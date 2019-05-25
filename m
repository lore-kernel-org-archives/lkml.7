Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198F2C07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 17:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0AEE20815
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 17:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iFWPNFkW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfEYRct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 13:32:49 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40880 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfEYRcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 13:32:48 -0400
Received: by mail-ot1-f66.google.com with SMTP id u11so11474839otq.7
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 10:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Gy9W1697bnJcZZYL9JPR13RWL43dUSo9hT4REu7ye88=;
        b=iFWPNFkW/msjuLBcH1597P5z4p04Oh2a5rg9i23EXl8eHTZLZ8x4Xb7VKbO5ERrBOc
         Ou3T1kdVwVnvAIkwRx2aXrnqOhf0BWokJrU6ARtpeKnimQXrZQLpT7lqNJz1u6ohw3N7
         RhkW4oggrur4UWZjaTO/qI3TEp2qhkkWMr2XYG6e1zwXV26WmH8YQPSXDgnCMkAHJAOD
         YqC2eDGARMY45KF6aPgL1PyeYkr6Fo5cqJLekG5Aw8a7F5pRUv5ISEqj3x141FTuSGh9
         GMuq2ORD/QbFkD66n3C1Q6F/OAEHhdvZ0ix/DorC2vHmJB8t0ntym9/U1RaomsyKoq2o
         vXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Gy9W1697bnJcZZYL9JPR13RWL43dUSo9hT4REu7ye88=;
        b=bVdPjivJeVjYZNkF2VLM6ND36g2/Mrd4vYwcgD5atKl6W8Q9lKogx+okuzOkdZjalC
         p8N1JBjrrOzvz86Yv4CazeHjFDeSj3649jrlsh9xsLGmGZx3ptCpzH1X+ScR814sN3Qw
         3gs9aFLw6aK1Zqbj6y2z7Z62xD80bgrgT5MOx8R5ePbYfDhEFPMRtBCzGumYdX1Zmyvs
         DWR7XLRmLmTnKm9Iv0iOy4pDbxquYhVUrD65x5mQshCBP/sR5uNXxpkxk1K3HJBhCFWY
         kepdh7l85GdzDJHqOpkReM9st46rFZB59F/ZAE44yisEnrlMEJ3KkJ9CFdp3rM/VerTm
         M5TQ==
X-Gm-Message-State: APjAAAUexFljPWbLzmoOWBuIwbgcoD4aMEeQxr0RiwZC2rJwRbVwrNbL
        1THym4PvQmlyUn1T5kTN0Q140w==
X-Google-Smtp-Source: APXvYqwHPDK5YDX5n1VmM8qsxD8m2BvhBoawwa+maja28PntVCqHAA2nLLN3ZPpUVp/9axALAfH3gQ==
X-Received: by 2002:a05:6830:1545:: with SMTP id l5mr32208199otp.69.1558805567517;
        Sat, 25 May 2019 10:32:47 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id b127sm2413034oih.43.2019.05.25.10.32.46
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 May 2019 10:32:46 -0700 (PDT)
Date:   Sat, 25 May 2019 10:32:31 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Pavel Machek <pavel@ucw.cz>
cc:     Hugh Dickins <hughd@google.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Revert "leds: avoid races with workqueue"?
In-Reply-To: <20190525093759.GA17767@amd>
Message-ID: <alpine.LSU.2.11.1905251025300.1112@eggly.anvils>
References: <alpine.LSU.2.11.1905241540080.1674@eggly.anvils> <20190525093759.GA17767@amd>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 May 2019, Pavel Machek wrote:

> Hi!
> 
> > I'm having to revert 0db37915d912 ("leds: avoid races with workqueue")
> > from my 5.2-rc testing tree, because lockdep and other debug options
> > don't like it: net/mac80211/led.c arranges for led_blink_setup() to be
> > called at softirq time, and flush_work() is not good for calling
> > then.
> 
> This should keep X60 working (as well as it is now; X60 will still
> have problems with lost events in setup like yours).
> 
> Can you test this instead of the revert?

Thanks, Pavel: yes, that works fine for me on the T420s, no debug
complaints, good and silent; and the wifi LED is blinking as before.

Hugh

> 
> Thanks,
> 								Pavel
> 
> diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
> index aefac4d..ebaac4d 100644
> --- a/drivers/leds/led-core.c
> +++ b/drivers/leds/led-core.c
> @@ -158,19 +159,14 @@ static void led_set_software_blink(struct led_classdev *led_cdev,
>  	}
>  
>  	set_bit(LED_BLINK_SW, &led_cdev->work_flags);
> -	mod_timer(&led_cdev->blink_timer, jiffies + 1);
> +	mod_timer(&led_cdev->blink_timer, jiffies + 1); /* Why oh why? Just call it directly? */
>  }
>  
> -
> +/* May not block */
>  static void led_blink_setup(struct led_classdev *led_cdev,
>  		     unsigned long *delay_on,
>  		     unsigned long *delay_off)
>  {
> -	/*
> -	 * If "set brightness to 0" is pending in workqueue, we don't
> -	 * want that to be reordered after blink_set()
> -	 */
> -	flush_work(&led_cdev->set_brightness_work);
>  	if (!test_bit(LED_BLINK_ONESHOT, &led_cdev->work_flags) &&
>  	    led_cdev->blink_set &&
>  	    !led_cdev->blink_set(led_cdev, delay_on, delay_off))
> diff --git a/drivers/leds/trigger/ledtrig-timer.c b/drivers/leds/trigger/ledtrig-timer.c
> index ca898c1..427fc3c 100644
> --- a/drivers/leds/trigger/ledtrig-timer.c
> +++ b/drivers/leds/trigger/ledtrig-timer.c
> @@ -113,6 +113,11 @@ static int timer_trig_activate(struct led_classdev *led_cdev)
>  		led_cdev->flags &= ~LED_INIT_DEFAULT_TRIGGER;
>  	}
>  
> +	/*
> +	 * If "set brightness to 0" is pending in workqueue, we don't
> +	 * want that to be reordered after blink_set()
> +	 */
> +	flush_work(&led_cdev->set_brightness_work);
>  	led_blink_set(led_cdev, &led_cdev->blink_delay_on,
>  		      &led_cdev->blink_delay_off);
>  
> 
> 
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
