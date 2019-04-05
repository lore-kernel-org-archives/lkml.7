Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66EEC282DD
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C6020855
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUHRf3Cm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731779AbfDEUAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 16:00:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42294 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731589AbfDEUAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 16:00:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id g3so9337632wrx.9;
        Fri, 05 Apr 2019 13:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ao0rMgygIigF4/A3IIXKESY+E+98suF4TFmIM9PfRc8=;
        b=JUHRf3CmolO78xLfnct/hqCYi1BMIOoyNUS8uXP6+tFWyCH25qS/U1b3Mkw1Oyu3go
         Xi73Cbn1gISQvXb/rguSt0WFJk4D5w/g2exSvSwAx1CqWRq3XSUfvJTkYT4W5wmuWjnd
         yhZWWhB/B3kpXzYISEfCCRd8XKkEzm5cD8DD4H+B1vicj2CbATiDSiX5LYz+bZYG7pXl
         VkjVDZXQERk2geJbpKtXh2w+WGE9sQ51oLXcX7UaZrBc6ewcUljCFpRGSyA6JeYEC0Gj
         aZJVzq9njPihF6c2y1mDztK95BQgWN+akKF3G1jhntJl5/fHx5lrkN/OdMB87Z0bIkoz
         3tmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ao0rMgygIigF4/A3IIXKESY+E+98suF4TFmIM9PfRc8=;
        b=a6FTB1cwmiCmtQS4nqpn4QbNuRnjGYvk4N+9d+TkVjC8OOjmqI4BLGjl6dPngzKbcs
         I2zmmji+SCDco/b8HCnVBVqgoi1seDTL3W9PpjOFBceh8rQtYf4S6hzTJ9/h8DKBdzI1
         6lFU29xP8CyzNZj78Wo8ekOI7JBcK9Bq1HbQAuOciYY7rTWrzRXtoYHF1/Ewg58Sz5aV
         7yPMR9wCbefC8AYL/vW9x7JYzcINiKpj9U6DZEVFTHyfTH5y9TUXkCs/8fSUzpYLvY/e
         yEUz3JBlfHl9mZBBU8LqtqAUUGRkWUcQK/xe4P5dLRmMekEO4v17ZPDVB7+DbcgtuJVg
         CmMg==
X-Gm-Message-State: APjAAAUckPau1AJ3Jku5OpmZeAQKBlNKAd6VwdvnnTE2UeF0mpy9T1Si
        0ngKTBuhiHavN7dStJCcu/0=
X-Google-Smtp-Source: APXvYqycIgViNakHJ1k3mzyGgkyrHOlCYvyCcdf9KNNzMuAfieGyvnXVO8KZV8iv3jz4h6v0HBsqWg==
X-Received: by 2002:a5d:4d42:: with SMTP id a2mr9822411wru.130.1554494410365;
        Fri, 05 Apr 2019 13:00:10 -0700 (PDT)
Received: from [192.168.1.19] (bga218.neoplus.adsl.tpnet.pl. [83.28.64.218])
        by smtp.gmail.com with ESMTPSA id 4sm2593984wmi.14.2019.04.05.13.00.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 13:00:09 -0700 (PDT)
Subject: Re: [PATCH v5 3/3] platform/chrome: Standardize Chrome OS keyboard
 backlight name
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@google.com>, Pavel Machek <pavel@ucw.cz>
Cc:     Dmitry Torokhov <dtor@google.com>,
        Nick Crews <ncrews@chromium.org>,
        Benson Leung <bleung@chromium.org>, linux-leds@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Simon Glass <sjg@google.com>
References: <20190404185919.GB27340@amd>
 <CAE_wzQ-XuK7WOyPm6yXsmjp7z0=T92mMrfn1TVaavaLejcYVGA@mail.gmail.com>
 <20190404191931.GA29984@amd>
 <CAE_wzQ8y8i7C+_tv0CdnbUw0r21g1ggv2YUuzCog1xABivEvWA@mail.gmail.com>
 <20190404200658.GD29984@amd>
 <CAE_wzQ8WcMCzYqvxA_JBZKNza7ca3QE-VShmMxv5++_4F8RR=g@mail.gmail.com>
 <20190404202042.GF29984@amd>
 <CAE_wzQ-8XwzptH7EqNrELxjBzY2+0oHJGB3Va=vZwwK3csu_aA@mail.gmail.com>
 <20190404204207.GH29984@amd>
 <CAE_wzQ8xe=x0uYcZkDRVKpUAQ_1vVdEPHU3XnEV1=_WN1-AMfw@mail.gmail.com>
 <20190404220509.GA14690@amd>
 <CABXOdTeQgjd2-T+eZCMdTDWBGLHEk6kvnYR0DjJYR7zuvVTMsQ@mail.gmail.com>
 <df9577fd-c526-77e9-c11c-5416387121db@collabora.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <469dfb68-a7ab-668d-15cb-9e021c0d3f0c@gmail.com>
Date:   Fri, 5 Apr 2019 22:00:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <df9577fd-c526-77e9-c11c-5416387121db@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 4/5/19 10:42 AM, Enric Balletbo i Serra wrote:
> Hi,
> 
> On 5/4/19 0:42, Guenter Roeck wrote:
>> On Thu, Apr 4, 2019 at 3:05 PM Pavel Machek <pavel@ucw.cz> wrote:
>>>
>>> On Thu 2019-04-04 14:48:35, Dmitry Torokhov wrote:
>>>> On Thu, Apr 4, 2019 at 1:42 PM Pavel Machek <pavel@ucw.cz> wrote:
>>>>>
>>>>> Hi!
>>>>>
>>>>>>>> And what to do if internal keyboard is not platform but USB? Like
>>>>>>>> Google "Whiskers"? (I am not sure why you decided to drop my mention
>>>>>>>> of internal USB keyboards completely off your reply).
>>>>>>>
>>>>>>> I don't have answers for everything. Even if you have USB keyboard, you'll
>>>>>>> likely still have backlight connected to embedded controller. If not,
>>>>>>> then maybe you have exception userland needs to know about.
>>>>>>>
>>>>>>> Still better than making everything an exception.
>>>>>>
>>>>>> You do not need to make everything exception. You just need to look
>>>>>> beyond the name, and see how the device is connected. And then apply
>>>>>> your exceptions for "weird" devices.
>>>>>
>>>>> "Where it is connected" is not interesting to the userland. "Is it
>>>>> backlight for internal keyboard" is the right question. It may be
>>>>> connected to embedded controller or some kind of controller over
>>>>> i2c... my shell scripts should not need to know about architecture of
>>>>> every notebook out there.
>>>>
>>>> Then your scripts will be failing for some setups.
>>>
>>> Well, yes. Do you want to guess what "lp5523:kb3" is?
>>>
>>
>> Oh, please. The discussion is about the driver name part, which you
>> want to overload with some string to mean "internal", which in turn
>> is, if anything, part of the functionality.
>>
>> With "platform", you'll at some point have two
>> "platform::kbd_backlight" entries. Remind me to send you a "told you
>> so" when that happens.
>>
>> Guenter
>>
>>>>> But I don't see why I should do additional work when its trivial for
>>>>> kernel to just name the LED in an useful way.
>>>>>
>>>>> "platform::kbd_backlight" has no disadvantages compared to
>>>>> "wilco::kbd_backlight" ... so lets just use it.
>>>>
>>>> It has disadvantages because it promises more than it can deliver IMO.
>>>> If device name != "platform::kbd_backlight" it does not mean that it
>>>> is not internal keyboard.
>>>
>>> My promise is if "platform::kbd_backlight" exists, it is backlight for
>>> internal keyboard. (And second half is "if it is easy for kernel, we
>>> name backlight for internal keyboard platform::kbd_backlight").
>>>
>>>> And you still have not resolved how you will
>>>> handle cases when there is more than one deice that can be considered
>>>> internal and may have a backlight.
>>>
>>> Is that realistic? How would that device look like?
>>>
> 
> Maybe is something "weird" in the PC/laptop world but in the Embedded world is
> not as weird as you think. I worked on devices that has two internal backlights,
> one to lit the qwerty keyboard and the other one to lit the numeric pad. We used
> the device field to differentiate both.
> 
>    keyboardist::kbd_backlight
>    tclnumpad::kbd_backlight
> 
> Taking this to the extreme you can also think in a device where every key has
> its own LED backlight, this happens for example in this device [1]. The device
> can lit only specific keys giving to the user a word prediction experience (i.e
> After press a key, only the keys that match with a possible word are lit on)

While we have your attention at the subject of LED naming I would like
to invite you all to reviewing my recent patch set [0], available
also on the led_naming_v3 branch of linux-leds.git [1].

The patch set introduces generic, backward compatible mechanism for
composing LED class devices names. It also aims to deprecate current
LED naming convention and encourage dropping "devicename" section.

Patch 5/25 from the discussed patch set includes
get_led_device_name_info.sh script proving that parent device name
of the LED class device is available in the sysfs and its presence
in the LED name is unjustified and redundant. The argument being raised
here related to name clash risk when there is no unique devicename
section included into the LED name is unjustified since LED core has
a protection against that and adds "_n" numerical suffix to the
requested LED name when it is already taken.

The patch set introduces also a set of predefined LED_FUNCTION
names to be used in DT bindings. This along with the removal
of devicename section from LED naming pattern will help to keep
LED sysfs interface more uniform and not varying depending on
underlaying hardware driving the LEDs.

Regarding the problem discussed in this thread - I would not necessarily
go for "platform" in place of devicename LED name section in the
cros_kbd_led_backlight driver. If we change it (should we at all - it is
already in 5.0 AFAICS?), then I would opt for dropping the "chromeos:"
part. It believe it will be possible to retrieve this name with
get_led_device_info.sh script. It would be good exercise to check
it out.

In cases like above:

     keyboardist::kbd_backlight
     tclnumpad::kbd_backlight

we could do with the following:

     :kbd-backlight
     :numpad-backlight

I used hyphens instead of underscores since we will have this convention
in the LED_FUNCTION names, which is more common for Device Tree, and
some of existing LED triggers.

W could also think of placing common LED_FUNCTION definitions in
include/leds/led-functions.h and include it in both include/leds/leds.h
and include/dt-bindings/leds/common.h, so that they would be more
naturally accessible for non DT based drivers.


[0] https://lkml.org/lkml/2019/3/31/222
[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds.git/log/?h=led_naming_v3

-- 
Best regards,
Jacek Anaszewski
