Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC55AC4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A80120823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXUl/7RF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfCDSbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:31:39 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36936 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfCDSbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:31:36 -0500
Received: by mail-wm1-f66.google.com with SMTP id x10so155361wmg.2;
        Mon, 04 Mar 2019 10:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0hEEszT+3r9bCgNko8jeuMMYLdhjFZw1N7jxEN81dbc=;
        b=WXUl/7RFnQFJGGgRMi5ceL/NnHgWe+TqJiUCaQ/g7vBnLG444pUE+oSJAXd68lVHkJ
         LrVM0dirrEqG5cjnkMtiTzBXqS+s/fVs2QNfGdK2WqjDrThXXLtNKlDcaxiWt3DdFXrh
         IY360rtA45yQUz6UZpC7mQj8mFjdFfuT1HH1ojHr7YKkZPq9+qK/2dPoL0Mww5lfdAtN
         xHOt1ZXXjdxpgNm7FTkPWEX6U25N4V8Emqso244csFn/7+nTlmfn8cAP0H2uLlv1i4il
         /fe670X0aA1MQwIc7AvCrg6XQosLCRGBp3HjRmi2UuhOnfR8blKe/pP805B2Vhu8jt6w
         OKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0hEEszT+3r9bCgNko8jeuMMYLdhjFZw1N7jxEN81dbc=;
        b=g6YA+RP82/XKwTBg+cXQfjn/0sC83Qz050S2iFl9mRZUvAxD/BZ9GsMCMD+tWoQA6q
         mmiJBZZ5lvsHxrhd4zqItfSCkdd/v7R359fbM8CC/EbKeyTsFs+3o94y/GQBRC3VODsT
         /llIJ58NABakFnpxkgSu8Pd8H6AtBMAgJLNvJGhJ3sqFFZHGeQYGEDI0amhvoGXY9wsp
         E/V1F1vAxZxbf52ukC67ooa7xME88GgP0pm0GwIbbJe+Qz/mVlItmjwCRNLGtgDAagWh
         LqilYPBXcvfLHX7fMMW2oWF06I4WL7+7byhVh842r7hATl1oUiioQ2mqMLvNSOCPNUGP
         lZgg==
X-Gm-Message-State: APjAAAWmEi0gSsm2kqDoLzk5xTVt9mQt9vrd79ZSSkTZoVhQzqKIB8RK
        DpVuCe/9pL5Frgj/BIH8DbM=
X-Google-Smtp-Source: APXvYqz/hKh8JzgVM7zdYdhjnoUNuoX7o1GKC6CK9KME1g/Yxvg0knckG+0M4zNKOi4DwObYMR1b8g==
X-Received: by 2002:a1c:2e85:: with SMTP id u127mr314628wmu.45.1551724295067;
        Mon, 04 Mar 2019 10:31:35 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:d8e4:889a:5ed6:37cb? (p200300EA8BF1E200D8E4889A5ED637CB.dip0.t-ipconnect.de. [2003:ea:8bf1:e200:d8e4:889a:5ed6:37cb])
        by smtp.googlemail.com with ESMTPSA id y20sm13304455wra.51.2019.03.04.10.31.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 10:31:34 -0800 (PST)
Subject: Re: [PATCH -next] net: dsa: mv88e6xxx: Fix build warning when
 CONFIG_NET_DSA_LEGACY is n
To:     Florian Fainelli <f.fainelli@gmail.com>,
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
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <e4a00af1-de84-b09f-8424-931a2c84ca41@gmail.com>
Date:   Mon, 4 Mar 2019 19:31:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <04ec6023-7385-d4ad-0bae-2c23e691c6f5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.03.2019 19:24, Florian Fainelli wrote:
> On 3/4/19 10:18 AM, Heiner Kallweit wrote:
>> On 04.03.2019 15:57, Andrew Lunn wrote:
>>> On Mon, Mar 04, 2019 at 10:16:08PM +0800, Zhangshaokun wrote:
>>>> Hi Andrew,
>>>>
>>>> On 2019/3/4 21:26, Andrew Lunn wrote:
>>>>> On Mon, Mar 04, 2019 at 08:43:01PM +0800, Shaokun Zhang wrote:
>>>>>> When CONFIG_NET_DSA_LEGACY is n, there is a GCC bulid warning:
>>>>>> drivers/net/dsa/mv88e6xxx/chip.c:4623:13: warning: ‘mv88e6xxx_ports_cmode_init’ defined but not used [-Wunused-function]
>>>>>> static void mv88e6xxx_ports_cmode_init(struct mv88e6xxx_chip *chip)
>>>>>> Let's fix it.
>>>>>
>>>>> Hi Shaokun, Heiner
>>>>>
>>>>> Although this fixes the warning, i suspect there i something wrong
>>>>> with the original patch adding mv88e6390x_port_set_cmode(). It should
>>>>> also be used without CONFIG_NET_DSA_LEGACY.
>>>>
>>>> I checked the commit-id 2a93c1a3651f ("net: dsa: Allow compiling out legacy support") by Florian.
>>>> Do you mean that CONFIG_NET_DSA_LEGACY shall be removed completely? :-)
>>>
>>> No, i suspect mv88e6390x_ports_cmode_init() is being called from the
>>> wrong place, or needs to be called from a second location.
>>>
>>> [Goes and looks at the code]
>>>
>>> Yes, it should also be called in mv88e6xxx_probe(). I would call it
>>> just after the call to mv88e6xxx_detect(), so that it is the same as
>>> in mv88e6xxx_drv_probe().
>>>
>>> There are two ways DSA drivers can be probed. The legacy way, which is
>>> optional, and is slowly getting removed, and the current way. Heiner
>>> is new to DSA and probably missed that, and only handled the legacy
>>> probe method. I also missed checking when i reviewed to patch :-(
>>>
>> Right, I missed that, will submit a fix.
>>
>> I just saw that the Kconfig entry comment for NET_DSA_LEGACY says:
>> "This feature is scheduled for removal in 4.17."
>>
>> Was forgotten to remove it or did somebody scream loud enough
>> "But I depend on it" ?
> 
> The intent was to remove it by that kernel version but the 88e6060
> driver still depends on it, and there appears to be some active users
> that Andrew worked with.
> 
I see, thanks. And migrating this driver to the new DSA framework
version isn't possible or not worth the effort?
