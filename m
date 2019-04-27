Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA92AC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 19:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A83E52087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 19:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkzfeDD6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfD0TU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 15:20:27 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39086 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfD0TU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 15:20:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id e92so3118043plb.6;
        Sat, 27 Apr 2019 12:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EDFlSgfz5gmctNPFzgQVNJJpFnNsMiBdMfO5DCVrxek=;
        b=XkzfeDD6zYYW0z1brk2RNUFXCg17YN4xsBoDwkkhr9Jk0SLg2dI3MSlOPDyB2B1Q5M
         7HCVJY15JNEPEshGCLbtbL0YFjNtEXPhDlOHV/S2Bv3pEs5US5zNmxB2OJFNVzbTOSdW
         GTc62Rg4CowaPKHkahMWQVX+3isu4bdLhyLZWK31t46xYe9HbI+53nE0sqgMcoWUspPE
         30fhlB9f+ygLnlYlYC1o6KelGQr8gj7c7ah3wTqFySsmbNH/BOAtgh11pyjAwKeJUjnt
         rPMcHvxvleKJ5NMSduiK9YDpq10h+mXQeJSPvPKVf0lPrqBsBkf+ZVaRJcsh3hqpxJto
         LhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EDFlSgfz5gmctNPFzgQVNJJpFnNsMiBdMfO5DCVrxek=;
        b=duVknWK8vTjSS0GTu59iOj7eWS+we6JuC0PybzT648Eyp9RkPrtU9NwEUURvKMHQDv
         kG2C2AyUVYyrQrJNmwiDGB1RYSOiKUezF2dMm1DbCnr887d5TtiCz3KjgQvbfXmktnTQ
         X+VRz2b/SKb+7SyUO7hs/Mbf9GwRtagHCNNsx+ag/rVXMBHrwxWMdi04TrSO9CBOaNHn
         LprXWIoewMMHmD8t5Lfaqc8NudJp+drm8aGDfuSeKsLvXTSTKxizna4BDqGhR3BUBD1O
         qGBTa52PaPgof0fPOjYMwm2IrW5jTBtVZDgSOqOiDWGh9+fGe37+9RVV86Rc/wzk9RPk
         6Hnw==
X-Gm-Message-State: APjAAAWEIcIllRWDAJ8gvxAFGEwATjC6X9yWdMg/Vl2GZCRIAzAjpPcO
        bvaNvEajm8BHnKKmDi1AYdv/iXU5
X-Google-Smtp-Source: APXvYqzapuuKlgcBsZbeNivaq1O2ADQ9rbOj8OjHx//9JJUQ1TnO3mF1NI+gyiGldTzWXIYzOwRpBA==
X-Received: by 2002:a17:902:f81:: with SMTP id 1mr53322979plz.216.1556392825896;
        Sat, 27 Apr 2019 12:20:25 -0700 (PDT)
Received: from [10.230.28.107] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id j19sm37910380pfh.41.2019.04.27.12.20.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Apr 2019 12:20:24 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] net: phy: realtek: Add rtl8211e rx/tx delays
 config
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190426093010.9609-1-fancer.lancer@gmail.com>
 <20190426212112.5624-1-fancer.lancer@gmail.com>
 <20190426214050.GU4041@lunn.ch>
 <20190426234503.y6nm5hekyclmgftc@mobilestation>
 <fbf2ff24-a435-fe69-abcc-1f9326e1d61d@gmail.com>
 <20190427074400.is2hbij2k57f5daz@mobilestation>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <97fff320-c3bb-ff05-3152-57b23b4cb15e@gmail.com>
Date:   Sat, 27 Apr 2019 12:20:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190427074400.is2hbij2k57f5daz@mobilestation>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/27/2019 12:44 AM, Serge Semin wrote:
> On Fri, Apr 26, 2019 at 08:11:50PM -0700, Florian Fainelli wrote:
>>
>>
>> On 4/26/2019 4:45 PM, Serge Semin wrote:
>>> On Fri, Apr 26, 2019 at 11:40:50PM +0200, Andrew Lunn wrote:
>>>> On Sat, Apr 27, 2019 at 12:21:11AM +0300, Serge Semin wrote:
>>>>> There are two chip pins named TXDLY and RXDLY which actually adds the 2ns
>>>>> delays to TXC and RXC for TXD/RXD latching. Alas this is the only
>>>>> documented info regarding the RGMII timing control configurations the PHY
>>>>> provides. It turns out the same settings can be setup via MDIO registers
>>>>> hidden in the extension pages layout. Particularly the extension page 0xa4
>>>>> provides a register 0x1c, which bits 1 and 2 control the described delays.
>>>>> They are used to implement the "rgmii-{id,rxid,txid}" phy-mode.
>>>>>
>>>>> The hidden RGMII configs register utilization was found in the rtl8211e
>>>>> U-boot driver:
>>>>> https://elixir.bootlin.com/u-boot/v2019.01/source/drivers/net/phy/realtek.c#L99
>>>>>
>>>>> There is also a freebsd-folks discussion regarding this register:
>>>>> https://reviews.freebsd.org/D13591
>>>>>
>>>>> It confirms that the register bits field must control the so called
>>>>> configuration pins described in the table 12-13 of the official PHY
>>>>> datasheet:
>>>>> 8:6 = PHY Address
>>>>> 5:4 = Auto-Negotiation
>>>>> 3 = Interface Mode Select
>>>>> 2 = RX Delay
>>>>> 1 = TX Delay
>>>>> 0 = SELRGV
>>>>>
>>>>> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
>>>>
>>>>
>>>> Hi Serge
>>>>
>>>> Next time please include a patch 0 containing a cover note explaining
>>>> the who series.
>>>>
>>>
>>> Sure as long as the patchset gets to be much bigger than two small
>>> patches with an obvious reason to be merged.
>>
>> netdev likes to have a cover letter for patch count >= 1, probably
>> something to be added to netdev-FAQ.rst.
>> -- 
>> Florian
> 
> Hello Florian
> Really, even with count = 1? So just one patch with cover-letter? Doesn't it
> seem redundant since at least a single patch can be thoroughly described in
> it' commit message?

I was off by one, it's for count > 1 that a cover letter is usually
requested.
-- 
Florian
