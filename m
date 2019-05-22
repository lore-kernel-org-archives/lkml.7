Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FEBC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE762173C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJjLEb3+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbfEVSZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 14:25:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34324 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbfEVSZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 14:25:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id f8so3406341wrt.1;
        Wed, 22 May 2019 11:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+cjZu7UYIWfl3+uZkDA8MDVh/UHQTxR9rJwk+Staepk=;
        b=DJjLEb3+UhJU/UYaj40YgmYzbvfNSNjqRjc8+oIJ5ybtqvOhHVpAqlLGWoW6Pms3du
         LZKjemGcUzwORRb/s6Rl0XTz1OFtmoY3BjN60PkDwTlUWCLuHUu1iWKG0kyqfcNkYNY/
         QotpBZVPdvQOlj3FZdchAOflX/fU5lAAr2xCw4Y4wJsTtAc36dBrDa6ULYVksrs2GzOT
         PE7Y3K4OB5Wil4h7sCtQLuwltkqKS3IjG5Lhi3WMd6Qef7ANiNkDa0mscFdYq3dKVDrV
         xTyALBI9negl33x7wiSH29FJOQINHs03kyWuYzIcUmPvU/JFV30z1t+wvidTH4asfEW8
         DNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+cjZu7UYIWfl3+uZkDA8MDVh/UHQTxR9rJwk+Staepk=;
        b=gXxiiyWOrKyHwX9iT8y/sN0KC+8WRJFncaaXLirhKcAPjz5FrgVM79R7+mRxYf6pcp
         WRSmFm+JvttG6BhmbahTrWt/1DY8/AJzPgt7xEVxyDBfSnF6+GJntPEtJa9wuSEg3GEt
         0lvKGVWO8EAvEw8CrXS40j1M7Cr/73b3rsvlTs/JweHCXceXLoRQ3aK9VOECn/aOF0xg
         E9D+duFbyAbLt5gxWoRiXZZ2lXslr4u/uLh8Ej8hZ3DknZ62EIZ5fY32TkUtOSc4AQZP
         I/V3tlcebg28NHMh6WE2BaItnXrLpUhlST9izzD52nU2SFEXIbhal4cUyvtHRRc3c7zT
         /a1A==
X-Gm-Message-State: APjAAAUTjpDpEym/SBSnnDqutD2a8CS30O9BddSlaVoxWB8tsYn+ndto
        y5+gEV9+0Txp9yT++gSOIhsAnnqi
X-Google-Smtp-Source: APXvYqyzzkwROhPsi7oH5mLudlnI+30MushmdFRHQjnDInJoFrw1btnq/42pjSP3mnr0KWrY1koxAA==
X-Received: by 2002:adf:b60f:: with SMTP id f15mr4507235wre.283.1558549523577;
        Wed, 22 May 2019 11:25:23 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:3029:8954:1431:dc1e? (p200300EA8BD45700302989541431DC1E.dip0.t-ipconnect.de. [2003:ea:8bd4:5700:3029:8954:1431:dc1e])
        by smtp.googlemail.com with ESMTPSA id v184sm11516461wma.6.2019.05.22.11.25.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 11:25:22 -0700 (PDT)
Subject: Re: [PATCH] net: phy: lxt: Add suspend/resume support to LXT971 and
 LXT973.
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <cf280b7ab1f513f03d3908ac9ad194e819f170f5.1558519026.git.christophe.leroy@c-s.fr>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <15504aa9-092c-c3b0-4dbe-32b9cc8dff39@gmail.com>
Date:   Wed, 22 May 2019 20:25:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <cf280b7ab1f513f03d3908ac9ad194e819f170f5.1558519026.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.05.2019 12:01, Christophe Leroy wrote:
> All LXT PHYs implement the standard "power down" bit 11 of
> BMCR, so this patch adds support using the generic
> genphy_{suspend,resume} functions.
> 
> LXT970 is left aside because all registers get cleared upon
> "power down" exit.
> 
> Fixes: 0f0ca340e57b ("phy: power management support")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
The patch should be annotated net-next, and I would recommend
to remove the Fixes tag, because it doesn't fix an actual issue
and I see it rather as an improvement. Apart from that:

Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>
