Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C05DC282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 14:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7B5213A2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 14:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYdqXGIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfDFOPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 10:15:11 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35266 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfDFOPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 10:15:10 -0400
Received: by mail-lf1-f67.google.com with SMTP id u21so6416855lfu.2;
        Sat, 06 Apr 2019 07:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Rm6dA38Uy9nK5AupU4NI307gw+DmejHVOJLYkIEeV0s=;
        b=BYdqXGIcuvTpRqgrUWf9PtKBd1OK99MDnl72G2jRfaFe6/mbUwg01sprHl2hRf5lYS
         dBEuCSTmbz1Wt2+A8cBPH8hVApv4B3qcF3KzvyjUUjv04QMeV3G34ZcWi98lkOwFzaE2
         dDTqwsusDzV4XE2hBTQWBv4Dlv61wdXEimwuw8XaKGBpuGAKR7pn3T6NkW6yy+QTDls1
         Zz7VIoolRUIgbP2EmFZ9TWI2bAIL6VDg6HdB1ht0R6zT4km/fEAjK7FG1tBpV4s1XnT4
         yDhkg7J4T4G4eSSBTv2K/IU5mjwRgIChgwOvSVavK7zykfTxLwdSZraON2OVGQe2LbIO
         U8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rm6dA38Uy9nK5AupU4NI307gw+DmejHVOJLYkIEeV0s=;
        b=h9k27cYKxrlWfUlJ/qx6xvYE/9BHRJN/SOkDBWmADLQl4Npm+jKrgNkBPcJNUBSA9f
         h4e++jyy56z6wfFh58mk//o8J8Nvd4M3nJ+ET2GeZzmlwc4xYPmwqBIuOBLAweeNoYb6
         bHZywMMw4ssuLtcPA3CnKaHc9KHjXrAwFiSsZcYhQBagyyPuv+umCG81Zs0gsrf5PGj8
         5k3e6FEoS4kQEI8NmMXSqGbwuECAUDLPGiLTTL5QPyP3CGqLMnvtKGoP+Y1ZNh/bx6tP
         ZbUnlrlDuelnTliP2uPa2khGy+D1okMHwvLjFnTaaQsBguomKO/cqr2hliQD5IAsTBPG
         QOkw==
X-Gm-Message-State: APjAAAWHjY2wYgDrjot+1trCqqCwJ3C/PWM6u11rdHGstx3pi8JKARjS
        lx1qOwYG45i5SRzwy5qA/0A=
X-Google-Smtp-Source: APXvYqxSdPreY/22XAwZ9wshOmLUJM3vImJWFVK1DrqmhHMLdDBVTdwr2aM7vTPK6twYlYdkCb0v6w==
X-Received: by 2002:ac2:5a01:: with SMTP id q1mr10239433lfn.147.1554560107470;
        Sat, 06 Apr 2019 07:15:07 -0700 (PDT)
Received: from [192.168.1.19] (bkw193.neoplus.adsl.tpnet.pl. [83.28.190.193])
        by smtp.gmail.com with ESMTPSA id u11sm5027685lfi.5.2019.04.06.07.15.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 07:15:06 -0700 (PDT)
Subject: Re: [PATCH v5 3/3] platform/chrome: Standardize Chrome OS keyboard
 backlight name
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Nick Crews <ncrews@chromium.org>,
        Benson Leung <bleung@chromium.org>, linux-leds@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Simon Glass <sjg@google.com>
References: <20190404200658.GD29984@amd>
 <CAE_wzQ8WcMCzYqvxA_JBZKNza7ca3QE-VShmMxv5++_4F8RR=g@mail.gmail.com>
 <20190404202042.GF29984@amd>
 <CAE_wzQ-8XwzptH7EqNrELxjBzY2+0oHJGB3Va=vZwwK3csu_aA@mail.gmail.com>
 <20190404204207.GH29984@amd>
 <CAE_wzQ8xe=x0uYcZkDRVKpUAQ_1vVdEPHU3XnEV1=_WN1-AMfw@mail.gmail.com>
 <20190404220509.GA14690@amd>
 <CABXOdTeQgjd2-T+eZCMdTDWBGLHEk6kvnYR0DjJYR7zuvVTMsQ@mail.gmail.com>
 <df9577fd-c526-77e9-c11c-5416387121db@collabora.com>
 <469dfb68-a7ab-668d-15cb-9e021c0d3f0c@gmail.com> <20190406095346.GB7546@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <1b45b4e8-18b6-62d5-7d42-0feed57c2c73@gmail.com>
Date:   Sat, 6 Apr 2019 16:15:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190406095346.GB7546@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 4/6/19 11:53 AM, Pavel Machek wrote:
> Hi!
> 
>> The patch set introduces also a set of predefined LED_FUNCTION
>> names to be used in DT bindings. This along with the removal
>> of devicename section from LED naming pattern will help to keep
>> LED sysfs interface more uniform and not varying depending on
>> underlaying hardware driving the LEDs.
>>
>> Regarding the problem discussed in this thread - I would not necessarily
>> go for "platform" in place of devicename LED name section in the
>> cros_kbd_led_backlight driver. If we change it (should we at all - it is
>> already in 5.0 AFAICS?), then I would opt for dropping the "chromeos:"
>> part. It believe it will be possible to retrieve this name with
>> get_led_device_info.sh script. It would be good exercise to check
>> it out.
> 
> I am not sure about existing driver. Important thing for me is that
> new drivers use consistent naming.
> 
>> In cases like above:
>>
>>      keyboardist::kbd_backlight
>>      tclnumpad::kbd_backlight
>>
>> we could do with the following:
>>
>>      :kbd-backlight
>>      :numpad-backlight
>>
>> I used hyphens instead of underscores since we will have this convention
>> in the LED_FUNCTION names, which is more common for Device Tree, and
>> some of existing LED triggers.
> 
> Existing userspace already searches for *:kbd_backlight", AFAICT, so
> we probably want to keep the "_".

OK, but it should be an exception but not a rule.
This "kbd-*" naming is used in input and tty subsystems which register
keyboard triggers with this style:

~/kernel$ git grep  ".*[\":]kbd-" -- "*.c"
drivers/input/input-leds.c:     [LED_NUML]      = { "numlock", 
VT_TRIGGER("kbd-numlock") },
drivers/input/input-leds.c:     [LED_CAPSL]     = { "capslock", 
VT_TRIGGER("kbd-capslock") },
drivers/input/input-leds.c:     [LED_SCROLLL]   = { "scrolllock", 
VT_TRIGGER("kbd-scrolllock") },
drivers/input/input-leds.c:     [LED_KANA]      = { "kana", 
VT_TRIGGER("kbd-kanalock") },
drivers/tty/vt/keyboard.c:      KBD_LED_TRIGGER(VC_SCROLLOCK, 
"kbd-scrolllock"),
drivers/tty/vt/keyboard.c:      KBD_LED_TRIGGER(VC_NUMLOCK, 
"kbd-numlock"),
drivers/tty/vt/keyboard.c:      KBD_LED_TRIGGER(VC_CAPSLOCK, 
"kbd-capslock"),
drivers/tty/vt/keyboard.c:      KBD_LED_TRIGGER(VC_KANALOCK, 
"kbd-kanalock"),
drivers/tty/vt/keyboard.c:      KBD_LOCKSTATE_TRIGGER(VC_SHIFTLOCK, 
"kbd-shiftlock"),
drivers/tty/vt/keyboard.c:      KBD_LOCKSTATE_TRIGGER(VC_ALTGRLOCK, 
"kbd-altgrlock"),
drivers/tty/vt/keyboard.c:      KBD_LOCKSTATE_TRIGGER(VC_CTRLLOCK, 
"kbd-ctrllock"),
drivers/tty/vt/keyboard.c:      KBD_LOCKSTATE_TRIGGER(VC_ALTLOCK, 
"kbd-altlock"),
drivers/tty/vt/keyboard.c:      KBD_LOCKSTATE_TRIGGER(VC_SHIFTLLOCK, 
"kbd-shiftllock"),
drivers/tty/vt/keyboard.c:      KBD_LOCKSTATE_TRIGGER(VC_SHIFTRLOCK, 
"kbd-shiftrlock"),
drivers/tty/vt/keyboard.c:      KBD_LOCKSTATE_TRIGGER(VC_CTRLLLOCK, 
"kbd-ctrlllock"),
drivers/tty/vt/keyboard.c:      KBD_LOCKSTATE_TRIGGER(VC_CTRLRLOCK, 
"kbd-ctrlrlock"),

"kbd_" naming is used only in case of backlight LEDs:

~/kernel$ git grep  ".*[\":]kbd_" -- "*.c"
drivers/hid/hid-asus.c: drvdata->kbd_backlight->cdev.name = 
"asus::kbd_backlight";
drivers/hid/hid-google-hammer.c:        kbd_backlight->cdev.name = 
"hammer::kbd_backlight";
drivers/hwmon/applesmc.c:       .name                   = 
"smc::kbd_backlight",
drivers/input/misc/ims-pcu.c:            "pcu%d::kbd_backlight", 
pcu->device_no);
drivers/platform/chrome/cros_kbd_led_backlight.c:       cdev->name = 
"chromeos::kbd_backlight";
drivers/platform/x86/asus-laptop.c:             cdev->name = 
"asus::kbd_backlight";
drivers/platform/x86/asus-wmi.c:                asus->kbd_led.name = 
"asus::kbd_backlight";
drivers/platform/x86/dell-laptop.c:     .name           = 
"dell::kbd_backlight",
drivers/platform/x86/samsung-laptop.c:          samsung->kbd_led.name = 
"samsung::kbd_backlight";
drivers/platform/x86/sony-laptop.c:     kbdbl_ctl->mode_attr.attr.name = 
"kbd_backlight";
drivers/platform/x86/sony-laptop.c: 
kbdbl_ctl->timeout_attr.attr.name = "kbd_backlight_timeout";
drivers/platform/x86/thinkpad_acpi.c:           .name           = 
"tpacpi::kbd_backlight",
drivers/platform/x86/toshiba_acpi.c:            dev->kbd_led.name = 
"toshiba::kbd_backlight";

With LEDs in platform drivers is that problem that we have the name
compiled into the kernel. Maybe to make it more flexible we could
use kernel config to choose between new "kbd-" and legacy "kbd_"
naming.

> I don't care much if we use "platform:" or no prefix at all for
> backlight of internal keyboard, as long as it is consistent across all
> devices.
> 
> We certainly want to use some prefix (probably inputX:) for backlight
> on USB keyboards.

For LEDs exposed through the input-LED bridge my get_led_device_info.sh
script nicely reports:

associated input node: input1

It just does:

readlink input1\:\:numlock/device

which prints: "../../input1 "

And I believe that for backlight LEDs exposed by input
subsystem it should be similarly since the input device
related to USB keyboard is a child of USB device:

/sys/class/leds# readlink input1::numlock
../../devices/pci0000:00/0000:00:14.0/usb2/2-4/2-4:1.0/0003:1C4F:0002.0002/input/input1/input1::numlock

-- 
Best regards,
Jacek Anaszewski
