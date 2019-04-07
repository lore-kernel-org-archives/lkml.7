Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DC4C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 22:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB8A20880
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 22:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V/Ck8+/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfDGWBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 18:01:51 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33626 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfDGWBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 18:01:50 -0400
Received: by mail-lf1-f67.google.com with SMTP id v14so8036424lfi.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 15:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Hbf7tiueveeUM4Lcx/xeMtbGrsy9IPvHxZ3KKWMRZk=;
        b=V/Ck8+/5A62ll8KTXUkJa0PaWr1l2KYq5qEcibaeJ/tmL0f4z7/Ea6z1TEdolLFTZH
         IEKHOSEfkO2ekZy5sl/azMfffcmEQAAj0p2AGjImDLDp5JAd3+aMPyY20CS0iEIr7ctc
         zWWuasOsNHDU/o69Ey+X9Hn3GFhUg7fLSI5lTWHKLrMS3yZlEV+29E38NV2GYkWKgrsE
         t0oGeGcio6lJBCeXCshWyuRu5haFYdl5F2SgxOgnyi7wV+SadTCfbQz0l6gFnYeNdhGL
         EviD12lpUIMT5YYx4mnskKFnAwhNzIwCoDX/EwkOnyJLhEmg9ToB5OjoYy6In4Jv4/+B
         Xx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Hbf7tiueveeUM4Lcx/xeMtbGrsy9IPvHxZ3KKWMRZk=;
        b=RcCxlQPPAKfVOOdn6n5zoWr5Y6GX5U70RSexHJxhHveSm64qeSVMpFBf4Y5wfB7lu+
         9ZXf2aTixGFuDoq+dyHqNzp6Qp6uPwDKeG6ICLyFP2zsIk0FJWdIxitjEB7Vc4LRTvDa
         kWCHe4BLTia1XTNSox3QrD2u+oOFzed82GYA/MfvP/Pc04MvB0Ypz2RW94vQoHOffZZr
         EcQZdgSAZnTPSIA9KSGfcekfRsOFah4Ypu9+pv/dby4tDlxZKiT+BSYGniCR0tNanmyv
         8Bd2Wk9PlhQyNTUDJxZGqe8m9IypVoQEwHMLoGPw5fB/0dfePu+6av7QKJ0BXs2/+5GO
         TUQw==
X-Gm-Message-State: APjAAAVLXEvK0/kmM3p8lnbDZsWCBPPD1UAmsSdnb4zeFkDk9UeKTcXt
        XpZPcqIR6o1jSSSZfVR/5OTMk3vITVgkh8fKSwlByw==
X-Google-Smtp-Source: APXvYqzr95/f4Z7UNOG6MwcAGok0JlHubpIx1YDgAI2fTYKbD9h+mhRwYAK0Li1PzDuf9HzfUopfYaU8xdaT6o7um8Q=
X-Received: by 2002:ac2:4839:: with SMTP id 25mr4709098lft.85.1554674507112;
 Sun, 07 Apr 2019 15:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190404185919.GB27340@amd> <CAE_wzQ-XuK7WOyPm6yXsmjp7z0=T92mMrfn1TVaavaLejcYVGA@mail.gmail.com>
 <20190404191931.GA29984@amd> <CAE_wzQ8y8i7C+_tv0CdnbUw0r21g1ggv2YUuzCog1xABivEvWA@mail.gmail.com>
 <20190404200658.GD29984@amd> <CAE_wzQ8WcMCzYqvxA_JBZKNza7ca3QE-VShmMxv5++_4F8RR=g@mail.gmail.com>
 <20190404202042.GF29984@amd> <CAE_wzQ-8XwzptH7EqNrELxjBzY2+0oHJGB3Va=vZwwK3csu_aA@mail.gmail.com>
 <20190404204207.GH29984@amd> <CAE_wzQ8xe=x0uYcZkDRVKpUAQ_1vVdEPHU3XnEV1=_WN1-AMfw@mail.gmail.com>
 <20190404220509.GA14690@amd> <CABXOdTeQgjd2-T+eZCMdTDWBGLHEk6kvnYR0DjJYR7zuvVTMsQ@mail.gmail.com>
 <df9577fd-c526-77e9-c11c-5416387121db@collabora.com> <469dfb68-a7ab-668d-15cb-9e021c0d3f0c@gmail.com>
In-Reply-To: <469dfb68-a7ab-668d-15cb-9e021c0d3f0c@gmail.com>
From:   Dmitry Torokhov <dtor@google.com>
Date:   Sun, 7 Apr 2019 15:01:35 -0700
Message-ID: <CAE_wzQ_bhRMH1yHOrFhOqAR_ch0w8Ajv31yynT7ssZ3eDM4FUQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] platform/chrome: Standardize Chrome OS keyboard
 backlight name
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@google.com>, Pavel Machek <pavel@ucw.cz>,
        Nick Crews <ncrews@chromium.org>,
        Benson Leung <bleung@chromium.org>, linux-leds@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Simon Glass <sjg@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacek,

On Fri, Apr 5, 2019 at 1:00 PM Jacek Anaszewski
<jacek.anaszewski@gmail.com> wrote:
>
> Hi all,
>
> On 4/5/19 10:42 AM, Enric Balletbo i Serra wrote:
> > Hi,
> >
> > On 5/4/19 0:42, Guenter Roeck wrote:
> >> On Thu, Apr 4, 2019 at 3:05 PM Pavel Machek <pavel@ucw.cz> wrote:
> >>>
> >>> On Thu 2019-04-04 14:48:35, Dmitry Torokhov wrote:
> >>>> On Thu, Apr 4, 2019 at 1:42 PM Pavel Machek <pavel@ucw.cz> wrote:
> >>>>>
> >>>>> Hi!
> >>>>>
> >>>>>>>> And what to do if internal keyboard is not platform but USB? Like
> >>>>>>>> Google "Whiskers"? (I am not sure why you decided to drop my mention
> >>>>>>>> of internal USB keyboards completely off your reply).
> >>>>>>>
> >>>>>>> I don't have answers for everything. Even if you have USB keyboard, you'll
> >>>>>>> likely still have backlight connected to embedded controller. If not,
> >>>>>>> then maybe you have exception userland needs to know about.
> >>>>>>>
> >>>>>>> Still better than making everything an exception.
> >>>>>>
> >>>>>> You do not need to make everything exception. You just need to look
> >>>>>> beyond the name, and see how the device is connected. And then apply
> >>>>>> your exceptions for "weird" devices.
> >>>>>
> >>>>> "Where it is connected" is not interesting to the userland. "Is it
> >>>>> backlight for internal keyboard" is the right question. It may be
> >>>>> connected to embedded controller or some kind of controller over
> >>>>> i2c... my shell scripts should not need to know about architecture of
> >>>>> every notebook out there.
> >>>>
> >>>> Then your scripts will be failing for some setups.
> >>>
> >>> Well, yes. Do you want to guess what "lp5523:kb3" is?
> >>>
> >>
> >> Oh, please. The discussion is about the driver name part, which you
> >> want to overload with some string to mean "internal", which in turn
> >> is, if anything, part of the functionality.
> >>
> >> With "platform", you'll at some point have two
> >> "platform::kbd_backlight" entries. Remind me to send you a "told you
> >> so" when that happens.
> >>
> >> Guenter
> >>
> >>>>> But I don't see why I should do additional work when its trivial for
> >>>>> kernel to just name the LED in an useful way.
> >>>>>
> >>>>> "platform::kbd_backlight" has no disadvantages compared to
> >>>>> "wilco::kbd_backlight" ... so lets just use it.
> >>>>
> >>>> It has disadvantages because it promises more than it can deliver IMO.
> >>>> If device name != "platform::kbd_backlight" it does not mean that it
> >>>> is not internal keyboard.
> >>>
> >>> My promise is if "platform::kbd_backlight" exists, it is backlight for
> >>> internal keyboard. (And second half is "if it is easy for kernel, we
> >>> name backlight for internal keyboard platform::kbd_backlight").
> >>>
> >>>> And you still have not resolved how you will
> >>>> handle cases when there is more than one deice that can be considered
> >>>> internal and may have a backlight.
> >>>
> >>> Is that realistic? How would that device look like?
> >>>
> >
> > Maybe is something "weird" in the PC/laptop world but in the Embedded world is
> > not as weird as you think. I worked on devices that has two internal backlights,
> > one to lit the qwerty keyboard and the other one to lit the numeric pad. We used
> > the device field to differentiate both.
> >
> >    keyboardist::kbd_backlight
> >    tclnumpad::kbd_backlight
> >
> > Taking this to the extreme you can also think in a device where every key has
> > its own LED backlight, this happens for example in this device [1]. The device
> > can lit only specific keys giving to the user a word prediction experience (i.e
> > After press a key, only the keys that match with a possible word are lit on)
>
> While we have your attention at the subject of LED naming I would like
> to invite you all to reviewing my recent patch set [0], available
> also on the led_naming_v3 branch of linux-leds.git [1].
>
> The patch set introduces generic, backward compatible mechanism for
> composing LED class devices names. It also aims to deprecate current
> LED naming convention and encourage dropping "devicename" section.

From looking at the docs section it looks like you propose to move
from "device:color:fucntion" to simply "color:function" naming, and
expect to have a suffix "_<n>" to avoid problem with duplicate LED
names. I do not think this is quite backward compatible, since
previously userspace was supposed to split the device name on the
colon boundaries and extract the 3rd component if it wanted to
determine function. With the new proposed scheme it has to be modified
to try and also fetch the 2nd component if there isn't 3rd one and
consider it as function as well. It also need to recognize potential
suffixes and drop them before matching on function name.

I think if you want flexibility you really need to switch from
encoding the information in the name to add LED class attributes
describing the LED in more detail. This might include information
about LEd placement (internal/external) if such information is
available, and other additional attributes, if needed. Updated
userspace can make use of these new attributes, leaving existing
userspace decoding legacy names.

>
> Patch 5/25 from the discussed patch set includes
> get_led_device_name_info.sh script proving that parent device name
> of the LED class device is available in the sysfs and its presence
> in the LED name is unjustified and redundant.  The argument being raised
> here related to name clash risk when there is no unique devicename
> section included into the LED name is unjustified since LED core has
> a protection against that and adds "_n" numerical suffix to the
> requested LED name when it is already taken.

This scheme breaks userspace that does not expect additional suffixes
attached to function name.

>
> The patch set introduces also a set of predefined LED_FUNCTION
> names to be used in DT bindings. This along with the removal
> of devicename section from LED naming pattern will help to keep
> LED sysfs interface more uniform and not varying depending on
> underlaying hardware driving the LEDs.
>
> Regarding the problem discussed in this thread - I would not necessarily
> go for "platform" in place of devicename LED name section in the
> cros_kbd_led_backlight driver. If we change it (should we at all - it is
> already in 5.0 AFAICS?), then I would opt for dropping the "chromeos:"
> part. It believe it will be possible to retrieve this name with
> get_led_device_info.sh script. It would be good exercise to check
> it out.
>
> In cases like above:
>
>      keyboardist::kbd_backlight
>      tclnumpad::kbd_backlight
>
> we could do with the following:
>
>      :kbd-backlight
>      :numpad-backlight
>
> I used hyphens instead of underscores since we will have this convention
> in the LED_FUNCTION names, which is more common for Device Tree, and
> some of existing LED triggers.

I am not sure what device tree has to do with it. ACPI for example
likes all caps and sort names with numbers, but we do not let it
propagate into the kernel.

We also should not be changing existing function names as existing
userspace relies on them.

>
> W could also think of placing common LED_FUNCTION definitions in
> include/leds/led-functions.h and include it in both include/leds/leds.h
> and include/dt-bindings/leds/common.h, so that they would be more
> naturally accessible for non DT based drivers.

This makes total sense.

Thanks.

-- 
Dmitry
