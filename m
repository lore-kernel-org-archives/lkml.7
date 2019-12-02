Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696D0C43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3435E2146E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgUQvJ2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfLBNDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 08:03:17 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36874 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfLBNDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 08:03:15 -0500
Received: by mail-oi1-f193.google.com with SMTP id x195so3132942oix.4;
        Mon, 02 Dec 2019 05:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bX52blO5Z/VfsD74ynSwB9VNncYy9CIY2khqE8Zel0g=;
        b=cgUQvJ2haeoS1q2G8itmIG4cIR5Aan1bCkEEC4kBO2GOGHFvT7K02UIt9/KPZMXjNH
         SiEoEhIIb3Y5P/qh0b2Z6JI3an3bmtGr4xpdt35WqX8qEKgOF1XIZKwuTcijtPc62Mrt
         LDdKVhpc1flSpXGhHAQfHLh73Z9LYck49kxUpnHU9iuvOdK/zpSgF1Hv4F4QJgpjwVEb
         h+I/mQYRvncoyyKBUOJQsoAxGBLWua2x/fF+yKZbFKP6tthYU/zlF7sNPwgWWghbAc7d
         23TjFd0rF4IT3W3GwXW+gYwtwlEGyiv1FDwSPIAHz5IPeUcddvX6vkV95oj85r1RYT7B
         cRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bX52blO5Z/VfsD74ynSwB9VNncYy9CIY2khqE8Zel0g=;
        b=uLMLRp/oNI2LVbrgvmn66GRJRzwe68RJPWGoOrgAoeKqO2bckkoBkubMoOd3Ds+e0b
         aUTadeQDe3oPtDDG1SyvIbNQyRH4mXDfbIgl1hDEi+J5Bn9kKaHyoSmbZ53WBcm+BCpu
         /6JHLF2AhY4+4TFrIoRmI+wKjgTWKIUCQtqjipiFI6E30BGkmUY9AzjuX+fUSpUwQlM6
         jh3vfsQUiFjocLC1rAcDDd149fgtaOxy800hfVpyXBLTpFxguEIUOMAejpqCDvXT5PpP
         941xncxrY78C2EIpSKb13gAbBLO60NiSEj3u9Psmi/27q1iVI8RQauxGN48V0qDdb9Od
         8lsQ==
X-Gm-Message-State: APjAAAWaK6uJVj3BDcDSfBWvZuJ+5RLg+FTakp/dszlpqNygV1b29Wk9
        d7ciE4CUqmJ6+mh7xm2LcTdPVdNP
X-Google-Smtp-Source: APXvYqyVJ0/NLBpbcrIvPb2DGj+WK2ZRiJdvf2mYCU99DqsYlBcC0xncybV9ColrRMjd1SFx0qvvwg==
X-Received: by 2002:aca:1a0a:: with SMTP id a10mr20621387oia.146.1575291793674;
        Mon, 02 Dec 2019 05:03:13 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g25sm2499051otr.8.2019.12.02.05.03.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2019 05:03:12 -0800 (PST)
Subject: Re: [PATCH v4 1/2] drivers: move the early platform device support to
 arch/sh
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Slaby <jslaby@suse.com>, linux-sh@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
References: <20191003092913.10731-1-brgl@bgdev.pl>
 <20191003092912.G3pupKBmyct1r9ScP5Skuw9D-_ALcMVSnfMfHAlwe0Y@z>
 <20191202041440.GA1628@roeck-us.net>
 <CAMpxmJW3i4zmJJ14Xg65+T27kF3sgR1WG0K3FUT6+jeKtiHx=Q@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <3f8ffe03-98b8-423a-7cba-53961a5600cb@roeck-us.net>
Date:   Mon, 2 Dec 2019 05:03:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAMpxmJW3i4zmJJ14Xg65+T27kF3sgR1WG0K3FUT6+jeKtiHx=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/19 11:40 PM, Bartosz Golaszewski wrote:
> pon., 2 gru 2019 o 05:14 Guenter Roeck <linux@roeck-us.net> napisał(a):
>>
>> On Thu, Oct 03, 2019 at 11:29:12AM +0200, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> SuperH is the only user of the current implementation of early platform
>>> device support. We want to introduce a more robust approach to early
>>> probing. As the first step - move all the current early platform code
>>> to arch/sh.
>>>
>>> In order not to export internal drivers/base functions to arch code for
>>> this temporary solution - copy the two needed routines for driver
>>> matching from drivers/base/platform.c to arch/sh/drivers/platform_early.c.
>>>
>>> Also: call early_platform_cleanup() from subsys_initcall() so that it's
>>> called after all early devices are probed.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Wondering ... has anyone tested this patch on affected hardware ?
>> All my qemu boot tests (both sh and sheb) fail because of it.
>> Bisect log below.
>>
>> Guenter
>>
>> ---
>> # bad: [72c0870e3a05d9cd5466d08c3d2a3069ed0a2f9f] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input
>> # good: [89d57dddd7d319ded00415790a0bb3c954b7e386] Merge tag 'media/v5.5-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
>> git bisect start 'HEAD' '89d57dddd7d3'
>> # good: [0a6cad5df541108cfd3fbd79eef48eb824c89bdc] Merge branch 'vmwgfx-coherent' of git://people.freedesktop.org/~thomash/linux into drm-next
>> git bisect good 0a6cad5df541108cfd3fbd79eef48eb824c89bdc
>> # bad: [9a3d7fd275be4559277667228902824165153c80] Merge tag 'driver-core-5.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
>> git bisect bad 9a3d7fd275be4559277667228902824165153c80
>> # good: [59274c7164807d27b24e6c068dfe734f7bea4623] Merge tag 'usb-5.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
>> git bisect good 59274c7164807d27b24e6c068dfe734f7bea4623
>> # good: [e71903106721dc53923e90aa484d78bc86c039a9] staging: mt7621-dma: align to match open parenthesis
>> git bisect good e71903106721dc53923e90aa484d78bc86c039a9
>> # good: [8f56e4ebe05c26c30e167519273843476e39e244] Merge tag 'char-misc-5.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
>> git bisect good 8f56e4ebe05c26c30e167519273843476e39e244
>> # good: [8bde9f3d2a217d1635a7c7bdf8ad4c25c9a34b50] Merge tag 'iio-for-5.5c' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next
>> git bisect good 8bde9f3d2a217d1635a7c7bdf8ad4c25c9a34b50
>> # bad: [0628cda318df6baec439ca6e6e274007492f1ccd] mac80211: Use debugfs_create_xul() helper
>> git bisect bad 0628cda318df6baec439ca6e6e274007492f1ccd
>> # bad: [03324507e66c7664c754b1ef92c5c3be24c78aa2] driver core: Allow fwnode_operations.add_links to differentiate errors
>> git bisect bad 03324507e66c7664c754b1ef92c5c3be24c78aa2
>> # bad: [313f5dbba41d905d59c820bb2d91ee6c661aff99] debugfs: remove return value of debugfs_create_u16()
>> git bisect bad 313f5dbba41d905d59c820bb2d91ee6c661aff99
>> # good: [d4387cd117414ba80230f27a514be5ca4a09cfcc] of: property: Create device links for all child-supplier depencencies
>> git bisect good d4387cd117414ba80230f27a514be5ca4a09cfcc
>> # bad: [c31e73121f4c1ec45a3e523ac6ce3ce6dafdcec1] base: soc: Handle custom soc information sysfs entries
>> git bisect bad c31e73121f4c1ec45a3e523ac6ce3ce6dafdcec1
>> # bad: [201e91091b1d47047f55580b5474e1239f4d17aa] sh: add the sh_ prefix to early platform symbols
>> git bisect bad 201e91091b1d47047f55580b5474e1239f4d17aa
>> # bad: [507fd01d5333338753a1cc26322dfc9f856c109f] drivers: move the early platform device support to arch/sh
>> git bisect bad 507fd01d5333338753a1cc26322dfc9f856c109f
>> # first bad commit: [507fd01d5333338753a1cc26322dfc9f856c109f] drivers: move the early platform device support to arch/sh
> 
> Hi Guenter,
> 
> can you post some bootlogs? Is it the same problem everywhere?
> 

I don't have any useful logs. The boot fails too early for that.

Sorry, I don't understand "everywhere". It fails in mainline and -next, if that is what you mean.
And, yes, it has failed in -next for a while, looking back at the log history.

Guenter
