Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0CBC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 841542070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vRMFPoXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfCDShM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:37:12 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37491 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfCDShM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:37:12 -0500
Received: by mail-pf1-f193.google.com with SMTP id s22so3630239pfh.4;
        Mon, 04 Mar 2019 10:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nU3/EfcDJG58Ec2LbhhuobTzFkTWa5lZg1OoGmX+nPY=;
        b=vRMFPoXFfRpg2xDFWXavmYqJHnZL7ZuVEX5EJmr3glmB3Wa5ORbhPqjJN+fapkHfOP
         yN9TdsNPNX0YQMdNjbAQ94/nbt6xuiGkDWEiIi3A7aJ+mOpgEQNGbLI+Wah3yxZeJEyK
         xtna+3c4J+xmGfYqCeJ1E/RnbqcsJixWpV3Vl4iiJJt3yGDk4iq73gWvPNFC8Qs81jOL
         zr5fFStm3emR3u9czpDFFHFY/Z9U/FvgcL6Wf9IOfdvHTxT4EbPTUzN32fxFRBre7zil
         Z0tnjhWFHPOr106Pl9ea2oKDnxXxo41sHLqVhRZtBkGi9Tgj3LfPRsVqopZatdVVpzRg
         0SBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=nU3/EfcDJG58Ec2LbhhuobTzFkTWa5lZg1OoGmX+nPY=;
        b=IewXRKNn+gYeR/zV+vWwxOTw/jz6d2YmRn0Obp3w7NcKt2/mkXXf8SKf4holsSzR7g
         IgfwFxHtKZWa9cmKIf+6truCrD+6+JPB3GCK8PBwAJPQghhBmxYBrTENV/0j3kMKfqNb
         qIxIK+FI4ht8F4e08k4dDWPeDMutyXvr5x7ZOnGiyWN/FPzdYY1X9tkUpeVtSDStVY62
         /jWhg8GePn8vgvQGkSjl6DLM9PwnHO6QYegHB0Q97MjUApU6DVNrMc2cli39wOtCQi82
         9iuSNjvXFynkjxQh6R8GxBQAADmkZ+Yq5O7mLccBIVWP9FJyNAO00QPR8ANyUToxtNxI
         9n9Q==
X-Gm-Message-State: APjAAAViNX4TNvcsJDZO7Xyuuznfzd7C0/ON5i8Xlx1/5KX70Ydt5RFs
        HA7110sRePnm8GALZww/VMM=
X-Google-Smtp-Source: APXvYqxOc18KljUIBWYnrAJrsrTicjHvcyPlk743LaDE13M/SZeUHvPFYBu8vEzmZ9QC3lUGArz7gg==
X-Received: by 2002:a17:902:3283:: with SMTP id z3mr5338619plb.155.1551724631087;
        Mon, 04 Mar 2019 10:37:11 -0800 (PST)
Received: from [10.67.50.0] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id 1sm15187765pfy.68.2019.03.04.10.37.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 10:37:10 -0800 (PST)
Subject: Re: [PATCH -next] net: dsa: mv88e6xxx: Fix build warning when
 CONFIG_NET_DSA_LEGACY is n
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Zhangshaokun <zhangshaokun@hisilicon.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
References: <1551703381-52115-1-git-send-email-zhangshaokun@hisilicon.com>
 <20190304132617.GB26378@lunn.ch>
 <bc528808-2ad5-90ae-4bc0-afa47a7c4f42@hisilicon.com>
 <20190304145710.GA17097@lunn.ch>
 <74a6581e-f761-0fb0-3200-e82b7ac88e75@gmail.com>
 <04ec6023-7385-d4ad-0bae-2c23e691c6f5@gmail.com>
 <e4a00af1-de84-b09f-8424-931a2c84ca41@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <3bc7fd6f-df27-2e18-f489-5f9f7cd0abca@gmail.com>
Date:   Mon, 4 Mar 2019 10:36:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <e4a00af1-de84-b09f-8424-931a2c84ca41@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/19 10:31 AM, Heiner Kallweit wrote:
> On 04.03.2019 19:24, Florian Fainelli wrote:
>> On 3/4/19 10:18 AM, Heiner Kallweit wrote:
>>> On 04.03.2019 15:57, Andrew Lunn wrote:
>>>> On Mon, Mar 04, 2019 at 10:16:08PM +0800, Zhangshaokun wrote:
>>>>> Hi Andrew,
>>>>>
>>>>> On 2019/3/4 21:26, Andrew Lunn wrote:
>>>>>> On Mon, Mar 04, 2019 at 08:43:01PM +0800, Shaokun Zhang wrote:
>>>>>>> When CONFIG_NET_DSA_LEGACY is n, there is a GCC bulid warning:
>>>>>>> drivers/net/dsa/mv88e6xxx/chip.c:4623:13: warning: ‘mv88e6xxx_ports_cmode_init’ defined but not used [-Wunused-function]
>>>>>>> static void mv88e6xxx_ports_cmode_init(struct mv88e6xxx_chip *chip)
>>>>>>> Let's fix it.
>>>>>>
>>>>>> Hi Shaokun, Heiner
>>>>>>
>>>>>> Although this fixes the warning, i suspect there i something wrong
>>>>>> with the original patch adding mv88e6390x_port_set_cmode(). It should
>>>>>> also be used without CONFIG_NET_DSA_LEGACY.
>>>>>
>>>>> I checked the commit-id 2a93c1a3651f ("net: dsa: Allow compiling out legacy support") by Florian.
>>>>> Do you mean that CONFIG_NET_DSA_LEGACY shall be removed completely? :-)
>>>>
>>>> No, i suspect mv88e6390x_ports_cmode_init() is being called from the
>>>> wrong place, or needs to be called from a second location.
>>>>
>>>> [Goes and looks at the code]
>>>>
>>>> Yes, it should also be called in mv88e6xxx_probe(). I would call it
>>>> just after the call to mv88e6xxx_detect(), so that it is the same as
>>>> in mv88e6xxx_drv_probe().
>>>>
>>>> There are two ways DSA drivers can be probed. The legacy way, which is
>>>> optional, and is slowly getting removed, and the current way. Heiner
>>>> is new to DSA and probably missed that, and only handled the legacy
>>>> probe method. I also missed checking when i reviewed to patch :-(
>>>>
>>> Right, I missed that, will submit a fix.
>>>
>>> I just saw that the Kconfig entry comment for NET_DSA_LEGACY says:
>>> "This feature is scheduled for removal in 4.17."
>>>
>>> Was forgotten to remove it or did somebody scream loud enough
>>> "But I depend on it" ?
>>
>> The intent was to remove it by that kernel version but the 88e6060
>> driver still depends on it, and there appears to be some active users
>> that Andrew worked with.
>>
> I see, thanks. And migrating this driver to the new DSA framework
> version isn't possible or not worth the effort?

Andrew is working on it actually. We could have 88E6060 select
NET_DSA_LEGACY and drop legacy probing from mv88e6xxx as an in between
solution.
-- 
Florian
