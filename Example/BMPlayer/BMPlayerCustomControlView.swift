//
//  BMPlayerCustomControlView.swift
//  BMPlayer
//
//  Created by BrikerMan on 2017/4/4.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import BMPlayer

class BMPlayerCustomControlView: BMPlayerControlView {
    var playRate: Float = 1.0
    var rotateCount: CGFloat = 0
    
    override func customizeUIComponents() {
        mainMaskView.backgroundColor   = UIColor.clear
        topMaskView.removeFromSuperview()
        bottomMaskView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        fullscreenButton.isHidden = true
        timeSlider.setThumbImage(UIImage(named: "custom_slider_thumb"), for: .normal)
    }
    
    
    
    override func updateUI(_ isForFullScreen: Bool) {
        super.updateUI(isForFullScreen)
        if let layer = player?.playerLayer {
            layer.frame = player!.bounds
        }
    }
    
    override func controlViewAnimation(isShow: Bool) {
        self.isMaskShowing = isShow
        UIApplication.shared.setStatusBarHidden(!isShow, with: .fade)
        
        UIView.animate(withDuration: 0.24, animations: {
            
            self.bottomMaskView.snp.remakeConstraints {
                $0.bottom.equalTo(self.mainMaskView).offset(isShow ? 0 : 50)
                $0.left.right.equalTo(self.mainMaskView)
                $0.height.equalTo(50)
            }
            self.layoutIfNeeded()
        }) { (_) in
            self.autoFadeOutControlViewWithAnimation()
        }
    }
    
    @objc func onPlaybackRateButtonPressed() {
        autoFadeOutControlViewWithAnimation()
        switch playRate {
        case 1.0:
            playRate = 1.5
        case 1.5:
            playRate = 0.5
        case 0.5:
            playRate = 1.0
        default:
            playRate = 1.0
        }
        delegate?.controlView?(controlView: self, didChangeVideoPlaybackRate: playRate)
    }
}
