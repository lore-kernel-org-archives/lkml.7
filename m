Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97801C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 03:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B142083E
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 03:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7WRr809"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfCBDJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 22:09:07 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42733 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbfCBDJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 22:09:07 -0500
Received: by mail-pg1-f194.google.com with SMTP id b2so12335755pgl.9;
        Fri, 01 Mar 2019 19:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j5tUV8mrPKSwkaY2MybIkKGmYwEW+MDIsinu3Bwb2Ac=;
        b=I7WRr809XeLdDgiYJ57ERs9VjGqBVG3KjhevEqf34enoNRQDAm07ulrEZnL7SDLCYe
         QE02iNXyOD9xcIOwk7m9/O/HRfSzqUAay6dWKpAjJ54uce97Oy8yE3xLDFdZ9Bwpm+Lv
         1gcoegwQMfx/pTC9woBKYuZtoSgdbBfDBXpctfth4bHMQ09LGDAppSxiw0iKKHakdpQv
         Ecw4SZETqJdSHxLNS6HO3BMYD1zfUe5tFxt5wiuy+s34uQZqENsN2upTWHB88UhJuZMV
         lzdgn2/Krfrf2o4Um3h7r0WbsjDwASKwGL9coVok/xSw/oHRsI9Tc5eGgZEvFFwzMRve
         5rHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=j5tUV8mrPKSwkaY2MybIkKGmYwEW+MDIsinu3Bwb2Ac=;
        b=A96dBp6xog1CNUe8iuWkZlB0teRpDn2+uo2F2BfydTzJq5HbqpF4vJ5+Hfef3TEuc9
         llNzOEYo4ra46brIlBgcSQWhlwWTqQaJbHG3URKe4volawedu7RYfjhqhqrHeEwtLvXH
         sNAvLOOdPNvYczLEGXqYfmsO0Mefj6Tkti9iW6e6erXtJHJUP0lPBLEIH3YV/Rgxd5gx
         H/EQpqutjXiMmXQc5o1GOGCEHZ8XLX3r5RnEhhiQiyXbOtuUt6yZHSNXVFjc4BPebp66
         EEfJUePnCMDxFv3Fw4PO1DSHDbV6dluhWZBSiXonIsYu0vFEnCpwdUQzLREmW9LL4vQj
         ENDg==
X-Gm-Message-State: APjAAAUxbXKJ5L9WzHLgaav/dtmK2ZoDwNTFTsp7Xht6fSBk3eyunCc6
        c2CM82spabb7rek1hpuvhXlYH0sG
X-Google-Smtp-Source: APXvYqw0IPqZv4dNsYyYsiMfg619jq6qVyAi5qsU6+J6lo5GFLCstL51Rl92tv17mZWyhsW7eXKGjA==
X-Received: by 2002:a63:e844:: with SMTP id a4mr7593281pgk.231.1551496145856;
        Fri, 01 Mar 2019 19:09:05 -0800 (PST)
Received: from [10.230.26.115] ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id p6sm43646495pgd.69.2019.03.01.19.08.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 19:09:04 -0800 (PST)
Subject: Re: [PATCH net-next v2 3/3] net: phy: marvell10g: set the PHY in low
 power by default
To:     Antoine Tenart <antoine.tenart@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     davem@davemloft.net, linux@armlinux.org.uk, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, mw@semihalf.com
References: <20190301110047.20257-1-antoine.tenart@bootlin.com>
 <20190301110047.20257-4-antoine.tenart@bootlin.com>
 <20190301141953.GF19813@lunn.ch> <20190301150706.GD3554@kwain>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 w0j9Sw==
Message-ID: <d17bdf0c-f1b8-99e3-b199-a99a7f7347d3@gmail.com>
Date:   Fri, 1 Mar 2019 19:08:56 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190301150706.GD3554@kwain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/1/2019 7:07 AM, Antoine Tenart wrote:
> Hi Andrew,
> 
> On Fri, Mar 01, 2019 at 03:19:53PM +0100, Andrew Lunn wrote:
>> On Fri, Mar 01, 2019 at 12:00:47PM +0100, Antoine Tenart wrote:
>>> When the Marvell 10G PHYs are set out of reset, the LPOWER bit is set
>>> depending on an hardware configuration choice. We also do not know what
>>> is the PHY state at boot time. Hence, set the PHY in low power by
>>> default when this driver probes.
>>
>> Florian did some work for c22 PHYs so that the existing link state
>> could be used at boot. So for example, the bootloader configured the
>> PHY up and it got link, there is no need to down/up the PHY when linux
>> takes control. The networking comes up faster that way.
>>
>> Can this work for this PHY?
> 
> This use case (the bootloader configures the PHY, Linux boots and sets
> an interface using this PHY up) would work, and is what's happening in
> some situations right now (the 3310 reset is never asserted prior to
> this series).
> 
> But consider this case (let's say we use a 10G link):
> 
>   ----------------               ----------------
>   |    Board 1   |               |    Board 2   |
>   | MAC — 3310 — | — SFP cable — | — 3310 — MAC |
>   ----------------               ----------------
> 
> Board 1: The userspace do not set the interface up. The MAC is in reset
>          (default state during the MAC driver probe), the PHY was
> 	 configured by the bootloader.
> Board 2: The userspace set the interface up. The MAC is configured, the
>          PHY is configured as well.
> 
> The two PHY's PCS will establish a link and report it as being up. In
> this case, phylink's AN mode is MLO_AN_PHY and thus will report the
> overall link as being the PHY's link status: up.
> 
> My understanding is that the issue arises because the PHYs were never
> set in reset, or low power, and thus act as if the user wanted the port
> to be up. As the default behaviour for networking ports is to be down at
> boot, I thought to set the PHY as well in a default low power state.

The policy you are creating here for the marvell10g driver is entirely
applicable to any PHY <=> PHY configuration where either of the two
software agents on Board 1 or Board 2 has not had a chance to bring-up
its bootloader/OS/applications to control the PHY.

A number of PHYs come up fully on (or in isolate or super isolate mode)
and will AN with their link partner if connected. For some people it's a
feature, for some it is a waste of power. I don't necessarily have an
issue with your patch per-se, but it does create an one off behavior
that other PHY drivers may not follow.
-- 
Florian
