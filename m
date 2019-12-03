Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BBEC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7305206EC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwEg7gA3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfLCOgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:36:13 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35904 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfLCOgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 09:36:12 -0500
Received: by mail-pf1-f193.google.com with SMTP id b19so1957703pfd.3;
        Tue, 03 Dec 2019 06:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Rn7xBSAhQKVe2Ht+1DcSGP/ohUnkosJBZvRk56PLlOo=;
        b=bwEg7gA3D77LPqGZA190HNtiBjYVOnWHa+fgMp1JUtRl0jin8Y/Kbz4ydsBEWU6Xt3
         T/JAsQdyWzdQT2Nwbevgi9RSdWUL/awiH5N6N0RzQM7jbUHZP91LftIXgmcGxJvpWsSE
         74NHD7ULT0BZmbVVaj5oKnKroIDtcDHDhjVdeKeCbxEWmXNcndLyD6bpg97veWNkFrXa
         I0rtS3E7/DYfFz8SKtayEOobaxLxLylBPDh5KWszlL2rY6YeH7b7cTFmzcLt3ArXDGM9
         Jvh2NIj6zyGt/OUIRZjxOY3OT6VyTBJawYxsopwmBVH+ivJjvKsO4qTgp210IJlh7LfI
         idAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rn7xBSAhQKVe2Ht+1DcSGP/ohUnkosJBZvRk56PLlOo=;
        b=BoehftaVTlqIegosbfv2mxWpUuT1OSW0tkLA/IVP8jeVCV+EzDUiWXs9QzToeaqRm0
         iop/TjS7FUh3Uuwp17mhov6JuYsTNl0cByT7t0b72xopfqdq49ViJAtmR4u5LPqyeujq
         KPKR9o7sWm5zjOkcq/jh44uplnviBfN3dNL2cEW8WYh4AgzZI/j8g0qZiNeZ8Wn9G4LO
         TAxV48rDoRWLyVmKACiIbjnMmOGWzrgi87TjShdDZItZSHtOwEuFKzpXWbc3O6YOnL+u
         BxxNmfDUFoHD5VSbdg8UYcnAonLx/gHBlYpPWVJwqH0M8YMDWczRN92n16jeE2nqz/wx
         o8xw==
X-Gm-Message-State: APjAAAWUwfZXgBi4PxdJX3PFw3fLYIFe3m2seiKXGpWFNZdQCeAG2sUe
        Wyy3wTmRqp578e2iTQ2bi7SGlLsq
X-Google-Smtp-Source: APXvYqyt8fSFi1AFd9bKjy84mZ6YPlVqi4i+DQ3ls+nWrbwZvoQSAzfDev/gHwCQWdR7MtiIUJvDZg==
X-Received: by 2002:a63:6a01:: with SMTP id f1mr3384168pgc.92.1575383770909;
        Tue, 03 Dec 2019 06:36:10 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y38sm3851267pgk.33.2019.12.03.06.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2019 06:36:10 -0800 (PST)
Subject: Re: [PATCH v4 1/2] drivers: move the early platform device support to
 arch/sh
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Slaby <jslaby@suse.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
References: <20191003092913.10731-1-brgl@bgdev.pl>
 <20191003092912.G3pupKBmyct1r9ScP5Skuw9D-_ALcMVSnfMfHAlwe0Y@z>
 <20191202041440.GA1628@roeck-us.net>
 <CAMpxmJW3i4zmJJ14Xg65+T27kF3sgR1WG0K3FUT6+jeKtiHx=Q@mail.gmail.com>
 <3f8ffe03-98b8-423a-7cba-53961a5600cb@roeck-us.net>
 <CAMpxmJUmTF3FwacjvTrC+Vvzm8MscS9E=ZyWLbJV87LkQhqVow@mail.gmail.com>
 <5e7aafc9-deb9-9305-afea-2c86e310683f@roeck-us.net>
 <CAMRc=MebSL+WA-nHFkaUd0rHTmwLkv2e16D9oO1=PY8-sPnzzQ@mail.gmail.com>
 <CAMuHMdXDLfCUnNevNqGXUrtwa11yvyBn0Semq6EOPuJKtnwgLg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <19572fe8-10b4-7a73-7847-b5e68aed3e54@roeck-us.net>
Date:   Tue, 3 Dec 2019 06:36:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXDLfCUnNevNqGXUrtwa11yvyBn0Semq6EOPuJKtnwgLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/19 2:14 AM, Geert Uytterhoeven wrote:
> Hi Bartosz, Günter,
> 
> On Tue, Dec 3, 2019 at 10:50 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>> wt., 3 gru 2019 o 06:24 Guenter Roeck <linux@roeck-us.net> napisał(a):
>>> On 12/2/19 9:18 AM, Bartosz Golaszewski wrote:
>>>> pon., 2 gru 2019 o 14:03 Guenter Roeck <linux@roeck-us.net> napisał(a):
>>>>>
>>>>> On 12/1/19 11:40 PM, Bartosz Golaszewski wrote:
>>>>>> pon., 2 gru 2019 o 05:14 Guenter Roeck <linux@roeck-us.net> napisał(a):
>>>>>>>
>>>>>>> On Thu, Oct 03, 2019 at 11:29:12AM +0200, Bartosz Golaszewski wrote:
>>>>>>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>>>>>
>>>>>>>> SuperH is the only user of the current implementation of early platform
>>>>>>>> device support. We want to introduce a more robust approach to early
>>>>>>>> probing. As the first step - move all the current early platform code
>>>>>>>> to arch/sh.
>>>>>>>>
>>>>>>>> In order not to export internal drivers/base functions to arch code for
>>>>>>>> this temporary solution - copy the two needed routines for driver
>>>>>>>> matching from drivers/base/platform.c to arch/sh/drivers/platform_early.c.
>>>>>>>>
>>>>>>>> Also: call early_platform_cleanup() from subsys_initcall() so that it's
>>>>>>>> called after all early devices are probed.
>>>>>>>>
>>>>>>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>>>>
>>>>>>> Wondering ... has anyone tested this patch on affected hardware ?
>>>>>>> All my qemu boot tests (both sh and sheb) fail because of it.
>>>>>>> Bisect log below.
>>>>>>>
>>>>>>> Guenter
>>>>>>>
>>>>>>> ---
>>>>>>> # bad: [72c0870e3a05d9cd5466d08c3d2a3069ed0a2f9f] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input
>>>>>>> # good: [89d57dddd7d319ded00415790a0bb3c954b7e386] Merge tag 'media/v5.5-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
>>>>>>> git bisect start 'HEAD' '89d57dddd7d3'
>>>>>>> # good: [0a6cad5df541108cfd3fbd79eef48eb824c89bdc] Merge branch 'vmwgfx-coherent' of git://people.freedesktop.org/~thomash/linux into drm-next
>>>>>>> git bisect good 0a6cad5df541108cfd3fbd79eef48eb824c89bdc
>>>>>>> # bad: [9a3d7fd275be4559277667228902824165153c80] Merge tag 'driver-core-5.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
>>>>>>> git bisect bad 9a3d7fd275be4559277667228902824165153c80
>>>>>>> # good: [59274c7164807d27b24e6c068dfe734f7bea4623] Merge tag 'usb-5.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
>>>>>>> git bisect good 59274c7164807d27b24e6c068dfe734f7bea4623
>>>>>>> # good: [e71903106721dc53923e90aa484d78bc86c039a9] staging: mt7621-dma: align to match open parenthesis
>>>>>>> git bisect good e71903106721dc53923e90aa484d78bc86c039a9
>>>>>>> # good: [8f56e4ebe05c26c30e167519273843476e39e244] Merge tag 'char-misc-5.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
>>>>>>> git bisect good 8f56e4ebe05c26c30e167519273843476e39e244
>>>>>>> # good: [8bde9f3d2a217d1635a7c7bdf8ad4c25c9a34b50] Merge tag 'iio-for-5.5c' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next
>>>>>>> git bisect good 8bde9f3d2a217d1635a7c7bdf8ad4c25c9a34b50
>>>>>>> # bad: [0628cda318df6baec439ca6e6e274007492f1ccd] mac80211: Use debugfs_create_xul() helper
>>>>>>> git bisect bad 0628cda318df6baec439ca6e6e274007492f1ccd
>>>>>>> # bad: [03324507e66c7664c754b1ef92c5c3be24c78aa2] driver core: Allow fwnode_operations.add_links to differentiate errors
>>>>>>> git bisect bad 03324507e66c7664c754b1ef92c5c3be24c78aa2
>>>>>>> # bad: [313f5dbba41d905d59c820bb2d91ee6c661aff99] debugfs: remove return value of debugfs_create_u16()
>>>>>>> git bisect bad 313f5dbba41d905d59c820bb2d91ee6c661aff99
>>>>>>> # good: [d4387cd117414ba80230f27a514be5ca4a09cfcc] of: property: Create device links for all child-supplier depencencies
>>>>>>> git bisect good d4387cd117414ba80230f27a514be5ca4a09cfcc
>>>>>>> # bad: [c31e73121f4c1ec45a3e523ac6ce3ce6dafdcec1] base: soc: Handle custom soc information sysfs entries
>>>>>>> git bisect bad c31e73121f4c1ec45a3e523ac6ce3ce6dafdcec1
>>>>>>> # bad: [201e91091b1d47047f55580b5474e1239f4d17aa] sh: add the sh_ prefix to early platform symbols
>>>>>>> git bisect bad 201e91091b1d47047f55580b5474e1239f4d17aa
>>>>>>> # bad: [507fd01d5333338753a1cc26322dfc9f856c109f] drivers: move the early platform device support to arch/sh
>>>>>>> git bisect bad 507fd01d5333338753a1cc26322dfc9f856c109f
>>>>>>> # first bad commit: [507fd01d5333338753a1cc26322dfc9f856c109f] drivers: move the early platform device support to arch/sh
>>>>>>
>>>>>> Hi Guenter,
>>>>>>
>>>>>> can you post some bootlogs? Is it the same problem everywhere?
>>>>>>
>>>>>
>>>>> I don't have any useful logs. The boot fails too early for that.
>>>>>
>>>>
>>>> Yeah, it touched "early" devices after all...
>>>>
>>>>> Sorry, I don't understand "everywhere". It fails in mainline and -next, if that is what you mean.
>>>>
>>>> I referred to "All my qemu boot tests" when saying everywhere.
>>>>
>>>> I don't have any relevant HW - the idea for this patch is to stop
>>>> compiling for everyone a bunch of code that's only used by one largely
>>>> irrelevant architecture and free the namespace for a generic early
>>>> platform drivers implementation.
>>>>
>>>> How are you creating your SH qemu images? I'm seeing there's something
>>>> in buildroot for superh - maybe I'll be able to bearly_platform_cleanupuild something
>>>> useful.
>>>>
>>>
>>> Below is a possible fix. As I had suspected, the call to early_platform_cleanup()
>>> is in the wrong place.
>>>
>>
>> This makes sense. If it fixes the issue - do you want to send it to Greg?
> 
> Which tree does this patch apply to?
> Oh, it's whitespace-damaged.
> 

Sorry, that wasn't meant to be applicable, just a hack to confirm my suspicion.
I'll clean it up and submit it.

Thanks,
Guenter

> After applying it manually on top of current Linus' tree, (remote)
> SH7722-based Migo-R boots again, so
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> There's still an issue with crashing userspace, but that happens on v5.4
> too. Bisecting...
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 

