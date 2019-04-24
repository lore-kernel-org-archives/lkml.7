Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0939C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACAC321773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCTbTvOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387862AbfDXSc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:32:59 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41477 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733024AbfDXSc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:32:58 -0400
Received: by mail-lf1-f66.google.com with SMTP id t30so15457787lfd.8;
        Wed, 24 Apr 2019 11:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a7PyW//ODouHJ0UFL0G/u5+dubQwstZk66ZTCET5hDg=;
        b=iCTbTvOmNjQO0lutCP4K479JWvDLnKRbytD2MpfFLv4uDsaXEK7P6gKr7eImEO5H9X
         3FmEKvbHt6Vkc0kKtxfNMvlBgFeA8Yv+0BUl0kbvIu+QApNGe3Y/JzyzfsVVpHIHWUV6
         zkDAgTybXa8OJ1raV34XvWyArlYpch9p4Clh7GOivZ+X0gVI4AI26Ad/bjSzF2ujREtX
         mI8HRIbDSVBhWeMdZNfCi2hGvZYeVd0TtqQENm+Gz6Zo7qgknkFMRH6eTn/97WvKrG8d
         Ds6a+XNSDrbcwp66E209jnDyJeBO5CJ5nAe5dqwlBCdxo7mOmwMmIBcP9HV1W/K64kOL
         FT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a7PyW//ODouHJ0UFL0G/u5+dubQwstZk66ZTCET5hDg=;
        b=TGbJOrciV8xxGhrjkaize+cu2QZjWLYCbTdtkzHoj02WEw/oInGlgvHE+7DG3UY6zU
         21PWgj6ICyToPytGZWQfKkGH/cepLBUikfkbGy90sPjs1QFA+5b8s+rudM1xSuILHMOm
         VUL0Ft8ezGcH20P9pqO72UiehRMb1sIejs3BIfoZH66M6kTCKB7ZsIIdSxlpQXemqyUI
         mL/cI9GUp3IGHFB4pxRbSUG2OedEv8bgP1CpNx9GEC58md+IoomVVzvbY1FUvgrY8yFZ
         wUnIxHxQc0Pm5M+qHAnx06yBzSMgbfTeTtRUso8zargyD/RXNT26YIZMJ9UWVgSjGiA1
         /Tsg==
X-Gm-Message-State: APjAAAUkXPgBdBAbpW8Z2WGsFOPp+vXBw2devsit/BAeitIqq9SH81hE
        /t+mGI69f5Z6LhYyD2HgxwM=
X-Google-Smtp-Source: APXvYqzcTQx8ECJ8TJyG2Sv+GZuNYIBoadQ/NELoBXWO0zAUH3fVnlEHVUkwgVOCMUu2sSafs8g1xg==
X-Received: by 2002:a19:f50e:: with SMTP id j14mr17143444lfb.11.1556130776679;
        Wed, 24 Apr 2019 11:32:56 -0700 (PDT)
Received: from localhost.localdomain ([193.183.105.170])
        by smtp.gmail.com with ESMTPSA id d80sm4750993lfd.90.2019.04.24.11.32.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 11:32:55 -0700 (PDT)
Received: from [127.0.0.1] (helo=jeknote.loshitsa1.net)
        by localhost.localdomain with esmtp (Exim 4.92)
        (envelope-from <jekhor@gmail.com>)
        id 1hJMhP-0002iw-Tq; Wed, 24 Apr 2019 21:32:51 +0300
Date:   Wed, 24 Apr 2019 21:32:51 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH v2 0/2] Intel Cherry Trail Whiskey Cove LEDs support
Message-ID: <20190424183251.GA21254@jeknote.loshitsa1.net>
References: <20190212205901.13037-1-jekhor@gmail.com>
 <21337ca0-bb91-9ca9-117b-89c47c6b2ade@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21337ca0-bb91-9ca9-117b-89c47c6b2ade@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2019 at 09:28:42PM +0200, Hans de Goede wrote:
> Hi Yauhen,

> I had a discussion with Jacek Anaszewski about this in another thread and
> I believe we have come up with a solution for this which should work
> nicely and should allow us to move forward with your driver (after
> it is reworked to match the solution. So the solution we've come up with is:
> 
> 1) After thinking a bit more about the primary use-case for this, I've come
> to the conclusion that putting LED1 / the charging LED in software-controlled
> mode is also the correct thing to do on the GPD win / pocket. The reason for
> this is that ideally the LED would glow while charging and be simply solid
> on when the battery is full, the hw control does not allow this, so the GPD
> win/pocket can benefit from sw-control too.
> 
> 2) To allow the desired behavior we need to define a new
> "<supply-name>-charging-glow-full-solid" trigger in
> drivers/power/supply/power_supply_leds.c; and this must be the default
> trigger for the Intel Cherry Trail Whiskey Cove LED driver so that
> everything will just work. Also we must restore the original hw control
> setting on reboot/shut-down so that this is used on the GPD win/pocket when
> Linux is not running.
> 
> 3) To be able to actually implement this new trigger we first need 2 things
> in the kernel internal LED APIs:
> 
> 3a) An API for triggers to put the LED in glowing mode, we've come up
> with the following prototype for this:
> 
> void led_trigger_glow(struct led_trigger *trigger, unsigned long *cylce_time);
> 
> Where cycle_time is the number of milliseconds for a full glow cycle (from off
> to full-on to off again).  So if cylce_time is set to 1000 then the LED glows
> at 1 Hz, 500, 2 HZ, etc. Note as with led_trigger_blink() the time passed to
> led_trigger_glow is passed by reference as the LED driver may round it to
> match what the hardware can do and the rounded value is returned to the caller
> through the reference.
> 
> 3b) 3a) in turn will require adding a new optional glow_set callback to
> struct led_classdev which will then get called by led_trigger_glow if available.
> 
> We've not discussed yet what to do if led_trigger_glow gets called on
> a led_classdev which does not implement the new glow_set callback, I guess
> the most sensible thing to do then is to fallback to blinking with delay_on
> and delay_off set to cylce_time / 2.
> 
> If you can make some time to work on this solution that would be great. Please
> let me know if you've any questions about the solution outlined below.
> 
> Note that glowing is only exported as in kernel functionality, I see no
> use-case for exporting this to userspace and keeping this in kernel allows
> us to keep things nice and simple.
> 

Hi,
Unfortunately I am too busy now at fulltime job, so I don't know when I
will return to this. But I still plan to do  :)
 

-- 
Yauhen Kharuzhy
