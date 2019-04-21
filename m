Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6258CC10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 19:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F7F20859
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 19:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfDUT2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 15:28:47 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35888 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfDUT2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 15:28:46 -0400
Received: by mail-ed1-f67.google.com with SMTP id u57so8069009edm.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2019 12:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f1WrATvsqWqWqqVYmk9421PbK7hlvZf8bi6E45Oqqjg=;
        b=TA2gyEm1mawy102KWtq87v4yuuqtS9NuwJr8pnIBx8jqqXfijXh22DeZlr7pdsPMS9
         AWN6ZupFIhwf98FQN9Dvll/Q/ss1JTmMDhTE/7Sqsi+yxbnmQvEoKMKEX1AUbdhEFV5r
         XW8NAGJ1se1xn7kphTKg9lfAmOzsCaZMAADPRhkJ+TuI60Iquodi/mFImfIqtRGLyEgB
         kE9Uy5DxCCdY957vLyNf7GgM3tRucpRhETkpn8/son4/DThk7CI7HoopcXjEcmXCHzTM
         ATRz88T0sRnVkl4rfBxfpkP+UVon7RAP6sx5bkHBfr5dDGIynAe+xiqgjM4Lw+kD+SB/
         cXlw==
X-Gm-Message-State: APjAAAUNa3oTGLFvRD6mVu1F6AoBiwIL2sZMvxaI4JHcsUm+e4tBxv0K
        mQOQP2sx2jsqu/08p6QdMNQRQw==
X-Google-Smtp-Source: APXvYqxle5dYhLvoa69re9dU0bYKYC/bGAf+ZQHmStEYAT72iLmVdYhOOAJl5GePAsf9hQbExpRFlg==
X-Received: by 2002:a50:9e48:: with SMTP id z66mr9956138ede.255.1555874925303;
        Sun, 21 Apr 2019 12:28:45 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id y12sm1873279ejr.75.2019.04.21.12.28.43
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 12:28:43 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Intel Cherry Trail Whiskey Cove LEDs support
To:     Yauhen Kharuzhy <jekhor@gmail.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20190212205901.13037-1-jekhor@gmail.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <21337ca0-bb91-9ca9-117b-89c47c6b2ade@redhat.com>
Date:   Sun, 21 Apr 2019 21:28:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190212205901.13037-1-jekhor@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yauhen,

On 12-02-19 21:58, Yauhen Kharuzhy wrote:
> This patch series introduces new driver for controlling LEDs connected
> to Intel Cherry Trail Whiskey Cove PMIC (general-purpose LED and charger
> status led). Only simple 'always on' and blinking modes are supported
> for now, no breathing.
> 
> Driver was tested only with Lenovo Yoga Book notebook, and I don't have
> any documentation for the PMIC, so proposals and testing are welcome.
> 
> v2:
>    - Fix comments and code style
>    - Add mutex to protect led state
>    - Add defaults triggers
>    - Fix module license declaration
> 
> Yauhen Kharuzhy (2):
>    leds: Add Intel Cherry Trail Whiskey Cove PMIC LEDs
>    mfd: Add leds MFD cell for intel_soc_pmic_chtwc

I had a discussion with Jacek Anaszewski about this in another thread and
I believe we have come up with a solution for this which should work
nicely and should allow us to move forward with your driver (after
it is reworked to match the solution. So the solution we've come up with is:

1) After thinking a bit more about the primary use-case for this, I've come
to the conclusion that putting LED1 / the charging LED in software-controlled
mode is also the correct thing to do on the GPD win / pocket. The reason for
this is that ideally the LED would glow while charging and be simply solid
on when the battery is full, the hw control does not allow this, so the GPD
win/pocket can benefit from sw-control too.

2) To allow the desired behavior we need to define a new
"<supply-name>-charging-glow-full-solid" trigger in
drivers/power/supply/power_supply_leds.c; and this must be the default
trigger for the Intel Cherry Trail Whiskey Cove LED driver so that
everything will just work. Also we must restore the original hw control
setting on reboot/shut-down so that this is used on the GPD win/pocket when
Linux is not running.

3) To be able to actually implement this new trigger we first need 2 things
in the kernel internal LED APIs:

3a) An API for triggers to put the LED in glowing mode, we've come up
with the following prototype for this:

void led_trigger_glow(struct led_trigger *trigger, unsigned long *cylce_time);

Where cycle_time is the number of milliseconds for a full glow cycle (from off
to full-on to off again).  So if cylce_time is set to 1000 then the LED glows
at 1 Hz, 500, 2 HZ, etc. Note as with led_trigger_blink() the time passed to
led_trigger_glow is passed by reference as the LED driver may round it to
match what the hardware can do and the rounded value is returned to the caller
through the reference.

3b) 3a) in turn will require adding a new optional glow_set callback to
struct led_classdev which will then get called by led_trigger_glow if available.

We've not discussed yet what to do if led_trigger_glow gets called on
a led_classdev which does not implement the new glow_set callback, I guess
the most sensible thing to do then is to fallback to blinking with delay_on
and delay_off set to cylce_time / 2.

If you can make some time to work on this solution that would be great. Please
let me know if you've any questions about the solution outlined below.

Note that glowing is only exported as in kernel functionality, I see no
use-case for exporting this to userspace and keeping this in kernel allows
us to keep things nice and simple.

Regards,

Hans


