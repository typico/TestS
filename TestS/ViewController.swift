//
//  ViewController.swift
//  TestS
//
//  Created by DATEV Mobile on 15.02.16.
//  Copyright © 2016 DATEV Mobile. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var count = 0
    var seconds = 0
    var buttonBeep : AVAudioPlayer?
    var secondBeep : AVAudioPlayer?
    var backgroundMusic : AVAudioPlayer?
    var bla : Int!
    var timer = NSTimer()

    
    @IBOutlet weak var textField: UITextField!

    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    @IBAction func settingTime(sender: AnyObject) {
        
        let settingTime = sender as! UITextField
        if settingTime.text != "" {
            seconds = Int(settingTime.text!)!
            timerLabel.text = "Time: \(seconds)"
        }
    }
    
    @IBAction func viewTapped(sender : AnyObject) {
        textField.resignFirstResponder()
    }

    
    @IBAction func bottonPress(sender: AnyObject) {
    
        button.transform = CGAffineTransformMakeScale(0.86, 0.86)
        
        UIView.animateWithDuration(2.0,
            delay: 0,
            usingSpringWithDamping: CGFloat(0.20),
            initialSpringVelocity: CGFloat(6.0),
            options: UIViewAnimationOptions.AllowUserInteraction,
            animations: {
                self.button.transform = CGAffineTransformIdentity
            },
            completion: { Void in()  }
        )

    }
    
    
    @IBAction func buttonPressed()  {
        
        
        if count == 0 {
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("subtractTime"), userInfo: nil, repeats: true)
        }
        buttonBeep?.play()
        count++
        scoreLabel.text = "Score: \(count)"
        
    }
    
    func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer?  {
    
        let path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
        let url = NSURL.fileURLWithPath(path!)
        
        var audioPlayer:AVAudioPlayer?
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: url)
        } catch {
            print("Player not available")
        }
        
        return audioPlayer
    }
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setGradient()
        setAudio()
        setUpGame()

    }
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setAudio(){
    
        if let buttonBeep = self.setupAudioPlayerWithFile("ButtonTap", type:"wav") {
            self.buttonBeep = buttonBeep
        }
        if let secondBeep = self.setupAudioPlayerWithFile("SecondBeep", type:"wav") {
            self.secondBeep = secondBeep
        }
        if let backgroundMusic = self.setupAudioPlayerWithFile("HallOfTheMountainKing", type:"mp3") {
            self.backgroundMusic = backgroundMusic
        }
    }
    
    func setGradient(){
    
        let topColor = UIColor (red: (15/255.0), green: (118/255.0), blue: (128/255.0), alpha: 1)
        let bottomColor = UIColor (red: (84/255.0), green: (187/255.0), blue: (187/255.0), alpha: 1)
        
        let gradientColors: [CGColorRef] = [topColor.CGColor, bottomColor.CGColor]
        let gradientLocations: [Float] = [0.0, 1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, atIndex: 0)
        
    }
    
    func setUpGame(){
    
            seconds = 10
            count = 0
            
            timerLabel.text = "Time: \(seconds)"
            scoreLabel.text = "Score: \(count)"
        
            backgroundMusic?.volume = 0.3
            backgroundMusic?.play()
                }
    
    func subtractTime() {
        
        seconds--
        timerLabel.text = "Time: \(seconds)"
        secondBeep?.play()
        if seconds == 0 {
            timer.invalidate()
            alert()
        }
        
    }
    func alert(){

        let alert = UIAlertController(title: "Time is up!", message: "You scored \(count) points", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Play Again!", style: UIAlertActionStyle.Default, handler:{
            action in self.setUpGame()
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    

}

