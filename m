Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7FEC04AA7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 04:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3EE52082E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 04:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnMi/JZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfEOE2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 00:28:11 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42605 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfEOE2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 00:28:11 -0400
Received: by mail-pl1-f195.google.com with SMTP id x15so663832pln.9;
        Tue, 14 May 2019 21:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=OC9PLly1kDPKO5tYlVrlWUMRiOg7Y7mQc5kS7OmwkNQ=;
        b=bnMi/JZpkJVxrxfa3gyCFwdWkNtTVwikzgtTOHNSHqUON1xH2JPrnclX3T5M16Wqtt
         8aCXdUjDHN9cTv63/6AYcX1P13/jXebIGxNdN/xApkL6csuq6AOd6LgDRtdnPQKABmiM
         KpcgPiVnVSxqD87o1dj4MxEOiMjLHOLFjdLNQnsj9hvHNXiuw1CVs3ILN+fvPkRCTFrf
         yWj470QCl05CCTGuNYeDBdWjjTXV3xoaI3yWgJP2/kpnXTQSf7bxuErkfUxd4Teu07MG
         3TJuX4R5x4VoKFvZ8obNCLRkE2YcXQilwMNoi2GayFeX5V2SHe4aKJOvHm2YSXAw+HU9
         pkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=OC9PLly1kDPKO5tYlVrlWUMRiOg7Y7mQc5kS7OmwkNQ=;
        b=IeRonKTkVDIlMLCuNl//YdP61L1olLGJGRAj1pbxuZyKlKgL8plLaDM+i/EZI0KiAh
         imjaOWsQLVXxe2gWLFRz4YWEbSt9DdMBdrzBOIn7t3nqLV3wred2DnICXuZ/RV+0tHYI
         p62qkof6+SLepamBjKL3Mo1Zg0RfsP8j3kJqaIKtGRbOhxaU/mp8qZAUzKOv4b5cDkfN
         pJE47T6r5Y83KF2pYLTNaN1KOsoSvupFu80NWeJtZEmG5wA9BoiLgcH/2bWM3V7Tbqdi
         izfOC+3Ob1tQ3nUVdgHkyVHdVXLoPJAjoXYygjH6+t0T2GZ1pSHbmMLDitgIas/q5bHE
         zV0Q==
X-Gm-Message-State: APjAAAWa7LgS1dt4Du01S3jNo8apwNkf/8saAxjCeb7WqmUy6HkYL92f
        /9BGMh5/LDcvb9YiDudnKGE19Jfb
X-Google-Smtp-Source: APXvYqyKag4srP+JEHfxF6M+638lpMDmSciPxA4duuw5dv6OTKK4VmV1DmzvMEJGYs446E2yXJ+jqA==
X-Received: by 2002:a17:902:4a:: with SMTP id 68mr42349613pla.235.1557894490151;
        Tue, 14 May 2019 21:28:10 -0700 (PDT)
Received: from [192.168.1.101] (122-58-182-39-adsl.sparkbb.co.nz. [122.58.182.39])
        by smtp.gmail.com with ESMTPSA id b186sm886354pga.5.2019.05.14.21.28.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 21:28:09 -0700 (PDT)
Subject: Re: linux-next: build failure after merge of the ecryptfs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20190514100910.6996d2f5@canb.auug.org.au>
 <CAK7LNAT_aJ4-abaNXe5VwvAYa2TOprjFL-vcUc730EDwHq80kw@mail.gmail.com>
 <20190514105649.512267cd@canb.auug.org.au>
 <c8f0cdf9-7236-30e0-fa11-b6c261bd3250@gmail.com>
Cc:     Tyler Hicks <tyhicks@canonical.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <b1271af4-42c7-42c2-44ef-8f47b9f5a145@gmail.com>
Date:   Wed, 15 May 2019 16:28:03 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <c8f0cdf9-7236-30e0-fa11-b6c261bd3250@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 14.05.2019 um 13:22 schrieb Michael Schmitz:
> Stephen,
>
> I wasn't aware of the other asix module when submitting the phy driver.
> The phy module gets autoloaded based on the PHY ID, so there's no reason
> why it couldn't be renamed.
>
> May I suggest ax88796b for the new module name?

I've got a patch series ready to go for this (compile tested).

I suppose this is meant to go through the net tree, Dave?

Cheers,

	Michael


>
> Cheers,
>
>     Michael
>
>
>
> On 14/05/19 12:56 PM, Stephen Rothwell wrote:
>> Hi all,
>>
>> [excessive quoting for new CC's]
>>
>> On Tue, 14 May 2019 09:40:53 +0900 Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>>> On Tue, May 14, 2019 at 9:16 AM Stephen Rothwell
>>> <sfr@canb.auug.org.au> wrote:
>>>> I don't know why this suddenly appeared after mergeing the ecryptfs
>>>> tree
>>>> since nothin has changed in that tree for some time (and nothing in
>>>> that
>>>> tree seems relevant).
>>>>
>>>> After merging the ecryptfs tree, today's linux-next build (x86_64
>>>> allmodconfig) failed like this:
>>>>
>>>> scripts/Makefile.modpost:112: target '.tmp_versions/asix.mod'
>>>> doesn't match the target pattern
>>>> scripts/Makefile.modpost:113: warning: overriding recipe for target
>>>> '.tmp_versions/asix.mod'
>>>> scripts/Makefile.modpost:100: warning: ignoring old recipe for
>>>> target '.tmp_versions/asix.mod'
>>>> scripts/Makefile.modpost:127: target '.tmp_versions/asix.mod'
>>>> doesn't match the target pattern
>>>> scripts/Makefile.modpost:128: warning: overriding recipe for target
>>>> '.tmp_versions/asix.mod'
>>>> scripts/Makefile.modpost:113: warning: ignoring old recipe for
>>>> target '.tmp_versions/asix.mod'
>>>> make[2]: Circular .tmp_versions/asix.mod <- __modpost dependency
>>>> dropped.
>>>> Binary file .tmp_versions/asix.mod matches: No such file or directory
>>>> make[2]: *** [scripts/Makefile.modpost:91: __modpost] Error 1
>>>> make[1]: *** [Makefile:1290: modules] Error 2
>>>>
>>>> The only clue I can see is that asix.o gets built in two separate
>>>> directories (drivers/net/{phy,usb}).
>>> Module name should be unique.
>>>
>>> If both are compiled as a module,
>>> they have the same module names:
>>>
>>> drivers/net/phy/asix.ko
>>> drivers/net/usb/asix.ko
>>>
>>> If you see .tmp_version directory,
>>> you will see asix.mod
>>>
>>> Perhaps, one overwrote the other,
>>> or it already got broken somehow.
>> So, the latter of these drivers (drivers/net/phy/asix.c) was added in
>> v4.18-rc1 by commit
>>
>>    31dd83b96641 ("net-next: phy: new Asix Electronics PHY driver")
>>
>> If we can't have 2 modules with the same base name, is it too late to
>> change its name?
>>
>> I am sort of suprised that noone else has hit this in the past year.
>>
>>>> I have the following files in the object directory:
>>>>
>>>> ./.tmp_versions/asix.mod
>>>> ./drivers/net/usb/asix.ko
>>>> ./drivers/net/usb/asix.mod.o
>>>> ./drivers/net/usb/asix.o
>>>> ./drivers/net/usb/asix_common.o
>>>> ./drivers/net/usb/asix_devices.o
>>>> ./drivers/net/usb/.asix.ko.cmd
>>>> ./drivers/net/usb/.asix.mod.o.cmd
>>>> ./drivers/net/usb/.asix.o.cmd
>>>> ./drivers/net/usb/asix.mod.c
>>>> ./drivers/net/usb/.asix_common.o.cmd
>>>> ./drivers/net/usb/.asix_devices.o.cmd
>>>> ./drivers/net/phy/asix.ko
>>>> ./drivers/net/phy/asix.o
>>>> ./drivers/net/phy/.asix.ko.cmd
>>>> ./drivers/net/phy/.asix.mod.o.cmd
>>>> ./drivers/net/phy/asix.mod.o
>>>> ./drivers/net/phy/asix.mod.c
>>>> ./drivers/net/phy/.asix.o.cmd
>>>>
>>>> ./.tmp_versions/asix.mod
>>>>
>>>> Looks like this:
>>>>
>>>> ------------------------------------------
>>>> drivers/net/phy/asix.ko
>>>> drivers/net/phy/asix.o
>>>>
>>>>
>>>> ------------------------------------------
>>>>
>>>> What you can't see above are the 256 NUL bytes at the end of the file
>>>> (followed by a NL).
>>>>
>>>> This is from a -j 80 build.  Surely there is a race condition here
>>>> if the
>>>> file in .tmp_versions is only named for the base name of the module and
>>>> we have 2 modules with the same base name.
>>>>
>>>> I removed that file and redid the build and it succeeded.
>>>>
>>>> Mind you, I have no itdea why this file was begin rebuilt, the merge
>>>> only touched these files:
>>>>
>>>> fs/ecryptfs/crypto.c
>>>> fs/ecryptfs/keystore.c
>>>>
>>>> Puzzled ... :-(
