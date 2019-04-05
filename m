Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1813FC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4E0217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbfDEImW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 04:42:22 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33910 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfDEImV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 04:42:21 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 53B9C2813A9
Subject: Re: [PATCH v5 3/3] platform/chrome: Standardize Chrome OS keyboard
 backlight name
To:     Guenter Roeck <groeck@google.com>, Pavel Machek <pavel@ucw.cz>
Cc:     Dmitry Torokhov <dtor@google.com>,
        Nick Crews <ncrews@chromium.org>,
        Benson Leung <bleung@chromium.org>, linux-leds@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
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
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <df9577fd-c526-77e9-c11c-5416387121db@collabora.com>
Date:   Fri, 5 Apr 2019 10:42:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CABXOdTeQgjd2-T+eZCMdTDWBGLHEk6kvnYR0DjJYR7zuvVTMsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/4/19 0:42, Guenter Roeck wrote:
> On Thu, Apr 4, 2019 at 3:05 PM Pavel Machek <pavel@ucw.cz> wrote:
>>
>> On Thu 2019-04-04 14:48:35, Dmitry Torokhov wrote:
>>> On Thu, Apr 4, 2019 at 1:42 PM Pavel Machek <pavel@ucw.cz> wrote:
>>>>
>>>> Hi!
>>>>
>>>>>>> And what to do if internal keyboard is not platform but USB? Like
>>>>>>> Google "Whiskers"? (I am not sure why you decided to drop my mention
>>>>>>> of internal USB keyboards completely off your reply).
>>>>>>
>>>>>> I don't have answers for everything. Even if you have USB keyboard, you'll
>>>>>> likely still have backlight connected to embedded controller. If not,
>>>>>> then maybe you have exception userland needs to know about.
>>>>>>
>>>>>> Still better than making everything an exception.
>>>>>
>>>>> You do not need to make everything exception. You just need to look
>>>>> beyond the name, and see how the device is connected. And then apply
>>>>> your exceptions for "weird" devices.
>>>>
>>>> "Where it is connected" is not interesting to the userland. "Is it
>>>> backlight for internal keyboard" is the right question. It may be
>>>> connected to embedded controller or some kind of controller over
>>>> i2c... my shell scripts should not need to know about architecture of
>>>> every notebook out there.
>>>
>>> Then your scripts will be failing for some setups.
>>
>> Well, yes. Do you want to guess what "lp5523:kb3" is?
>>
> 
> Oh, please. The discussion is about the driver name part, which you
> want to overload with some string to mean "internal", which in turn
> is, if anything, part of the functionality.
> 
> With "platform", you'll at some point have two
> "platform::kbd_backlight" entries. Remind me to send you a "told you
> so" when that happens.
> 
> Guenter
> 
>>>> But I don't see why I should do additional work when its trivial for
>>>> kernel to just name the LED in an useful way.
>>>>
>>>> "platform::kbd_backlight" has no disadvantages compared to
>>>> "wilco::kbd_backlight" ... so lets just use it.
>>>
>>> It has disadvantages because it promises more than it can deliver IMO.
>>> If device name != "platform::kbd_backlight" it does not mean that it
>>> is not internal keyboard.
>>
>> My promise is if "platform::kbd_backlight" exists, it is backlight for
>> internal keyboard. (And second half is "if it is easy for kernel, we
>> name backlight for internal keyboard platform::kbd_backlight").
>>
>>> And you still have not resolved how you will
>>> handle cases when there is more than one deice that can be considered
>>> internal and may have a backlight.
>>
>> Is that realistic? How would that device look like?
>>

Maybe is something "weird" in the PC/laptop world but in the Embedded world is
not as weird as you think. I worked on devices that has two internal backlights,
one to lit the qwerty keyboard and the other one to lit the numeric pad. We used
the device field to differentiate both.

  tclkeyboard::kbd_backlight
  tclnumpad::kbd_backlight

Taking this to the extreme you can also think in a device where every key has
its own LED backlight, this happens for example in this device [1]. The device
can lit only specific keys giving to the user a word prediction experience (i.e
After press a key, only the keys that match with a possible word are lit on)

- Enric

[1] https://www.abilia.com/en/product/lightwriter-sl50

>>                                                                         Pavel
>> --
>> (english) http://www.livejournal.com/~pavelmachek
>> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
