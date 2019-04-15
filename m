Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3678FC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026AE2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZcVgi2w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbfDOT4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:56:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33874 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728347AbfDOT4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:56:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id r186so704773wmf.1;
        Mon, 15 Apr 2019 12:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wIk65o+RO0GXjCOm+Angc753gmqOE8dlMvOLS/9D4ls=;
        b=JZcVgi2w/siujD5wC49nOZKOqGAYoYcbzgNq9zfqiwzdzV0zfuhwBrqIMThC0FqQAH
         IZpEcd3ivbRMeqsrotU2qXQVOf0I4z+SbjBytWvsYTb7mFwxXs+stNU9aTP7NdwnaKbO
         ne+Nt1X+om7X/Prf09dm5tNUNoiKTay5FtZRHrMedTPD010ggqk44PMlrCG/MrFxVana
         OuEs/8XMsHd2yrXYbQbNXBQQu1+gVxBqTz/d2XvOtQiA95yPxe7U0onAoERQJMExpjwG
         VM3xuZAZNyjxOL9BCtgKwQOd57xbarQJDkoPVo+ICVuR2peVeHu/XbLrgYUhMpllX/4M
         XwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wIk65o+RO0GXjCOm+Angc753gmqOE8dlMvOLS/9D4ls=;
        b=GZ7YpU8AdVS1NSbK0N+/1KyGIEZ2KevK7hiWNLKpmmwIqN4slnugEWWpwlzXvTaJR+
         LJe7ufzFo7SYYu2dQHV6nv23Iy16eccK8CYcza5uPh/Xo/D8Vzir/108XrSf7yHik+e+
         6CudRv/ZIb1O+voBspm2Gxbv2FH7nz+lsE+Y6idNhXaNVgo2kyaNbLJ0f72pkEEwUcG8
         Fm30r3B1EQhcqnWRQrcIBkm08NwjCE/ckuYO03mJpHTbUgjO1YwcLDHn+pYfq6qnk/pn
         EL2QsWmsi3wzTvsX0h3wYc+meV9o5C2y64SRPnwSN4WiJPy9yWyXB0StXe7sWxsanwyp
         pZWg==
X-Gm-Message-State: APjAAAVGG+gyhf8bCyqF+ixClv0+xD51fogOZ7vtz+nFDVtOnDK4KoZL
        1e8f2cszjTHC2+a42DtOWYobTFZQBErN9g==
X-Google-Smtp-Source: APXvYqyFEU6YIX+CbAOvJV5afdQPF7HdjSRbNYuRE8GHyWaUc2fqQmpMpyRCWIvUKMnX+WToSkdO4w==
X-Received: by 2002:a05:600c:220b:: with SMTP id z11mr23144663wml.73.1555358181873;
        Mon, 15 Apr 2019 12:56:21 -0700 (PDT)
Received: from [192.168.1.221] ([195.245.38.118])
        by smtp.gmail.com with ESMTPSA id r16sm38548382wrx.37.2019.04.15.12.56.20
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 12:56:21 -0700 (PDT)
Subject: Re: [PATCH 2/4] ARM: ep93xx: keypad: stop using mach/platform.h
To:     Arnd Bergmann <arnd@arndb.de>,
        Hartley Sweeten <HartleyS@visionengravers.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190415192734.935387-1-arnd@arndb.de>
 <20190415192734.935387-2-arnd@arndb.de>
 <CO2PR01MB21683E465191EA8246503774D02B0@CO2PR01MB2168.prod.exchangelabs.com>
 <CAK8P3a1DSN3jcfGngrJFp93Mt98qsibvKvtJGtjHYjOmcM1kNQ@mail.gmail.com>
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
Message-ID: <3665a5ad-ff6d-97a1-ca31-971973a7167f@gmail.com>
Date:   Mon, 15 Apr 2019 21:54:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1DSN3jcfGngrJFp93Mt98qsibvKvtJGtjHYjOmcM1kNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 15/04/2019 21:47, Arnd Bergmann wrote:
>>> We can communicate the clock rate using platform data rather than setting a
>>> flag to use a particular value in the driver, which is cleaner and avoids the dependency.
>>>
>>> No platform in the kernel currently defines the ep93xx keypad device structure, so this
>>> is a rather pointless excercise.  Any out of tree users are probably dead now, but if not,
>>>  they have to change their platform code to match the new platform_data structure.
>> <snip>
>>
>>> diff --git a/include/linux/platform_data/keypad-ep93xx.h b/include/linux/platform_data/keypad-ep93xx.h
>>> index 0e36818e3680..3054fced8509 100644
>>> --- a/include/linux/platform_data/keypad-ep93xx.h
>>> +++ b/include/linux/platform_data/keypad-ep93xx.h
>>> @@ -9,8 +9,7 @@ struct matrix_keymap_data;
>>>  #define EP93XX_KEYPAD_DIAG_MODE              (1<<1)  /* diagnostic mode */
>>>  #define EP93XX_KEYPAD_BACK_DRIVE     (1<<2)  /* back driving mode */
>>>  #define EP93XX_KEYPAD_TEST_MODE              (1<<3)  /* scan only column 0 */
>>> -#define EP93XX_KEYPAD_KDIV           (1<<4)  /* 1/4 clock or 1/16 clock */
>>> -#define EP93XX_KEYPAD_AUTOREPEAT     (1<<5)  /* enable key autorepeat */
>>> +#define EP93XX_KEYPAD_AUTOREPEAT     (1<<4)  /* enable key autorepeat */
>> You have re-defined the keypad register bits here.
>>
>> The KDIV bit changes the clock rate. The AUTOREPEAT bit enables key autorepeat.
> As far as I can tell, they are not register bits, just software flags
> for communicating between a board file and the driver, so I
> assumed I could freely reorganize them.
> 
> Did I miss something?

They are indeed only software flags (just checked datasheet), so you are only changing
platform data format. But as I do not know any keypad user in person, I'd rely on
Hartley's opinion in this case (if it's a good idea to change platform data or not).

--
Alex.
