Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3E0C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 03:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505EA206BF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 03:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vGROUGop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfD0DLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 23:11:54 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38740 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfD0DLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 23:11:53 -0400
Received: by mail-pl1-f193.google.com with SMTP id f36so2412408plb.5;
        Fri, 26 Apr 2019 20:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HC/S00uXLZeOiErWWrUJ4/1fgY2A3pnzkLJSKhInIbc=;
        b=vGROUGopJoSK4L1YDw3M+Zm5qYsgk+yug/9kBburb7igLGE40BmfUq9dEQ9UhK3n3O
         4+SI/U9PaUZO9Yz3HXvjqfMG+H2oobL633L5G/+AGui92wqgyBSKVbdomULErqKiZBA0
         AKPqUko733xMMfY31jQOd2pBrvJUdYwL8nWGQjTi/6O+35ije6DnxwgnZKV1mCCF3Dmc
         11L0t53K+LmO8isjW3r6LBhVEm+pvY6pbaQWDDdo01MTpsbutUbg1QSb7GhFCnCse0m1
         qT95zrER2t++MJfPT2iTI5+eWvq/+t/onCe9A8rMyoBE6WY+1hCgjLg1PZAELpYHHEsC
         AIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HC/S00uXLZeOiErWWrUJ4/1fgY2A3pnzkLJSKhInIbc=;
        b=JMSEpKkV861H0yO36CKw71CmRDir1AOUIvBQF4vr7mAwlBlTQ/LExD5Lg8/90OWfmY
         O/BZyhtbD8Y4Yfhbt4qC92Z2SGRSMsMW2hGqOLRZSTWccwwD2ae+vpFmYTRnyoRQeVk/
         mmxW9C5gBdMxNyYu7/VyLgv2vzcvUfTfqux0QOkI6HEPqAiNhdAEBAppFikcWs2I6lRp
         TuYTKaWuzhN8ccuxbyd2QWTiF0Nt6sQUKvLav8UW1mddG8xosKak+WyMJcPy8EDk1tDC
         HadxiYX7fq3lSOnNYMpHftrXnYWMEQzPZdr7Ptl//QW+NBgpvE/9cgyg6GT69/mXzwIJ
         1e5A==
X-Gm-Message-State: APjAAAWVb/1Nv+H9HS2xrbh3aUE0s3F2LMsEEgca+SR+HrdKTszzqTMA
        CWpm3wBGYygfUeZgKRqCB5vD2cJY
X-Google-Smtp-Source: APXvYqxq52RfcHX6vF+GWgSWA84d9+6hOKbR9Sdp+JeWlOwvrwMVRw53CJzvgXniyPaEE2zqoEjRoQ==
X-Received: by 2002:a17:902:f20a:: with SMTP id gn10mr2597728plb.90.1556334712766;
        Fri, 26 Apr 2019 20:11:52 -0700 (PDT)
Received: from [192.168.1.3] (ip68-101-123-102.oc.oc.cox.net. [68.101.123.102])
        by smtp.gmail.com with ESMTPSA id g79sm2835535pfd.144.2019.04.26.20.11.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 20:11:51 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] net: phy: realtek: Add rtl8211e rx/tx delays
 config
To:     Serge Semin <fancer.lancer@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190426093010.9609-1-fancer.lancer@gmail.com>
 <20190426212112.5624-1-fancer.lancer@gmail.com>
 <20190426214050.GU4041@lunn.ch>
 <20190426234503.y6nm5hekyclmgftc@mobilestation>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <fbf2ff24-a435-fe69-abcc-1f9326e1d61d@gmail.com>
Date:   Fri, 26 Apr 2019 20:11:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190426234503.y6nm5hekyclmgftc@mobilestation>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/26/2019 4:45 PM, Serge Semin wrote:
> On Fri, Apr 26, 2019 at 11:40:50PM +0200, Andrew Lunn wrote:
>> On Sat, Apr 27, 2019 at 12:21:11AM +0300, Serge Semin wrote:
>>> There are two chip pins named TXDLY and RXDLY which actually adds the 2ns
>>> delays to TXC and RXC for TXD/RXD latching. Alas this is the only
>>> documented info regarding the RGMII timing control configurations the PHY
>>> provides. It turns out the same settings can be setup via MDIO registers
>>> hidden in the extension pages layout. Particularly the extension page 0xa4
>>> provides a register 0x1c, which bits 1 and 2 control the described delays.
>>> They are used to implement the "rgmii-{id,rxid,txid}" phy-mode.
>>>
>>> The hidden RGMII configs register utilization was found in the rtl8211e
>>> U-boot driver:
>>> https://elixir.bootlin.com/u-boot/v2019.01/source/drivers/net/phy/realtek.c#L99
>>>
>>> There is also a freebsd-folks discussion regarding this register:
>>> https://reviews.freebsd.org/D13591
>>>
>>> It confirms that the register bits field must control the so called
>>> configuration pins described in the table 12-13 of the official PHY
>>> datasheet:
>>> 8:6 = PHY Address
>>> 5:4 = Auto-Negotiation
>>> 3 = Interface Mode Select
>>> 2 = RX Delay
>>> 1 = TX Delay
>>> 0 = SELRGV
>>>
>>> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
>>
>>
>> Hi Serge
>>
>> Next time please include a patch 0 containing a cover note explaining
>> the who series.
>>
> 
> Sure as long as the patchset gets to be much bigger than two small
> patches with an obvious reason to be merged.

netdev likes to have a cover letter for patch count >= 1, probably
something to be added to netdev-FAQ.rst.
-- 
Florian
