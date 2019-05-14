Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58199C04AA7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 01:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2782084F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 01:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dugRZx65"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfENBW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 21:22:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32773 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfENBWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 21:22:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id z28so8172499pfk.0;
        Mon, 13 May 2019 18:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=3eobYZm7StaTAnM+px6iKkHHfDJqUuEOAPhcUxjWVIQ=;
        b=dugRZx65pDMZfh37DAdY9V8gH03dhprOGOwqGWj6D3nAxoC12L0iGBSufahBMWkCfq
         F/VRCSo5AHkgNbr3S419ZGs2vyEWyVZW2lf1Rgrg++2BjLByKdZrrEHWb4XHvR5Mlb0D
         p+ykhnOqX51UPaXJoBpeG/o6jI7P5Js/nwZRtrJr/C2gRUkHW3g3J6iLbXpBnbw/yN+z
         2CphAPX7mLJIlDI8KAAsaZTwwTATPI/JcEBnb92lO+D8waDMopFAHqzipa42edyc6KNc
         stRV6Bp0irbukRFuMMkhGwKobSinCeIq29LTXAAMQ0SF3EbpmtAvloSuBvTESSUkj+sy
         4Sgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3eobYZm7StaTAnM+px6iKkHHfDJqUuEOAPhcUxjWVIQ=;
        b=uCg1Bf9of0WS6lcboKy6/pUKdQmy/WqZNIREFn5ERS3Iw1UHGj77uDw2K7FIyfgzla
         9jxaPCuN2EaIF6oJdrxjNnITa02KVQSLo1x5QFFboekD0A/LgfyoVng1WXXjxB+sAgNT
         vtTen8kUav2crGFkCGFMrtW9Jg5DU4CVZBIg/eugupDfiuwE/e9RA0kBJ5Br20LCptG/
         lW0Zzw4HQ5HXTk9ZZ75ZkhCTYl/z3Q308W5e0DRkBh7zW2nqpC3MIjqrRU9lRp8QiRyV
         e8E5Z7lAyT70YJGJPBwV9uNai7+17YwW+cVLK3bArruUZv879CCNTV8LT7TLaF73G9O+
         bIfA==
X-Gm-Message-State: APjAAAU15NiNX2bX3CaJqeEKj/RGdt0QCfa6xcNPS/q5p8KcZYDshbYB
        gL2FcRSomo6VWD+pKWB4Fq9Od70n
X-Google-Smtp-Source: APXvYqwWWwm6E0b/n/b/fIxY3jjryLi82zDMx7HkfZFQIdsPh3qj/SiGKZ7/gbMMoP9RtonF4wI6qA==
X-Received: by 2002:a63:494f:: with SMTP id y15mr20342086pgk.56.1557796974567;
        Mon, 13 May 2019 18:22:54 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:19d:e5d2:2224:77b? ([2001:df0:0:200c:19d:e5d2:2224:77b])
        by smtp.gmail.com with ESMTPSA id m21sm32513074pff.146.2019.05.13.18.22.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 18:22:53 -0700 (PDT)
Subject: Re: linux-next: build failure after merge of the ecryptfs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Tyler Hicks <tyhicks@canonical.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
References: <20190514100910.6996d2f5@canb.auug.org.au>
 <CAK7LNAT_aJ4-abaNXe5VwvAYa2TOprjFL-vcUc730EDwHq80kw@mail.gmail.com>
 <20190514105649.512267cd@canb.auug.org.au>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <c8f0cdf9-7236-30e0-fa11-b6c261bd3250@gmail.com>
Date:   Tue, 14 May 2019 13:22:44 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514105649.512267cd@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen,

I wasn't aware of the other asix module when submitting the phy driver. 
The phy module gets autoloaded based on the PHY ID, so there's no reason 
why it couldn't be renamed.

May I suggest ax88796b for the new module name?

Cheers,

     Michael



On 14/05/19 12:56 PM, Stephen Rothwell wrote:
> Hi all,
>
> [excessive quoting for new CC's]
>
> On Tue, 14 May 2019 09:40:53 +0900 Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>> On Tue, May 14, 2019 at 9:16 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>> I don't know why this suddenly appeared after mergeing the ecryptfs tree
>>> since nothin has changed in that tree for some time (and nothing in that
>>> tree seems relevant).
>>>
>>> After merging the ecryptfs tree, today's linux-next build (x86_64
>>> allmodconfig) failed like this:
>>>
>>> scripts/Makefile.modpost:112: target '.tmp_versions/asix.mod' doesn't match the target pattern
>>> scripts/Makefile.modpost:113: warning: overriding recipe for target '.tmp_versions/asix.mod'
>>> scripts/Makefile.modpost:100: warning: ignoring old recipe for target '.tmp_versions/asix.mod'
>>> scripts/Makefile.modpost:127: target '.tmp_versions/asix.mod' doesn't match the target pattern
>>> scripts/Makefile.modpost:128: warning: overriding recipe for target '.tmp_versions/asix.mod'
>>> scripts/Makefile.modpost:113: warning: ignoring old recipe for target '.tmp_versions/asix.mod'
>>> make[2]: Circular .tmp_versions/asix.mod <- __modpost dependency dropped.
>>> Binary file .tmp_versions/asix.mod matches: No such file or directory
>>> make[2]: *** [scripts/Makefile.modpost:91: __modpost] Error 1
>>> make[1]: *** [Makefile:1290: modules] Error 2
>>>
>>> The only clue I can see is that asix.o gets built in two separate
>>> directories (drivers/net/{phy,usb}).
>> Module name should be unique.
>>
>> If both are compiled as a module,
>> they have the same module names:
>>
>> drivers/net/phy/asix.ko
>> drivers/net/usb/asix.ko
>>
>> If you see .tmp_version directory,
>> you will see asix.mod
>>
>> Perhaps, one overwrote the other,
>> or it already got broken somehow.
> So, the latter of these drivers (drivers/net/phy/asix.c) was added in
> v4.18-rc1 by commit
>
>    31dd83b96641 ("net-next: phy: new Asix Electronics PHY driver")
>
> If we can't have 2 modules with the same base name, is it too late to
> change its name?
>
> I am sort of suprised that noone else has hit this in the past year.
>
>>> I have the following files in the object directory:
>>>
>>> ./.tmp_versions/asix.mod
>>> ./drivers/net/usb/asix.ko
>>> ./drivers/net/usb/asix.mod.o
>>> ./drivers/net/usb/asix.o
>>> ./drivers/net/usb/asix_common.o
>>> ./drivers/net/usb/asix_devices.o
>>> ./drivers/net/usb/.asix.ko.cmd
>>> ./drivers/net/usb/.asix.mod.o.cmd
>>> ./drivers/net/usb/.asix.o.cmd
>>> ./drivers/net/usb/asix.mod.c
>>> ./drivers/net/usb/.asix_common.o.cmd
>>> ./drivers/net/usb/.asix_devices.o.cmd
>>> ./drivers/net/phy/asix.ko
>>> ./drivers/net/phy/asix.o
>>> ./drivers/net/phy/.asix.ko.cmd
>>> ./drivers/net/phy/.asix.mod.o.cmd
>>> ./drivers/net/phy/asix.mod.o
>>> ./drivers/net/phy/asix.mod.c
>>> ./drivers/net/phy/.asix.o.cmd
>>>
>>> ./.tmp_versions/asix.mod
>>>
>>> Looks like this:
>>>
>>> ------------------------------------------
>>> drivers/net/phy/asix.ko
>>> drivers/net/phy/asix.o
>>>
>>>
>>> ------------------------------------------
>>>
>>> What you can't see above are the 256 NUL bytes at the end of the file
>>> (followed by a NL).
>>>
>>> This is from a -j 80 build.  Surely there is a race condition here if the
>>> file in .tmp_versions is only named for the base name of the module and
>>> we have 2 modules with the same base name.
>>>
>>> I removed that file and redid the build and it succeeded.
>>>
>>> Mind you, I have no itdea why this file was begin rebuilt, the merge
>>> only touched these files:
>>>
>>> fs/ecryptfs/crypto.c
>>> fs/ecryptfs/keystore.c
>>>
>>> Puzzled ... :-(
