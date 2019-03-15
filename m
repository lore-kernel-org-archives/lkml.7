Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38295C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E630E20700
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6XuSUB0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfCOXOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 19:14:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40072 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfCOXOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 19:14:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id t5so11215864wri.7;
        Fri, 15 Mar 2019 16:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ByKG67dfsbtrlfy4iJXUB63IQ1NQHthpkE1LO4mAvTo=;
        b=I6XuSUB0sLdkIbOslXc+EWqY/6jSrL677FNVfG8RIY7HyBh2fGwvh+opoTXJTFL2ns
         m6/+vCo7wT1VS9MD3bhtjJn66iALpe/3jZebOxgH+rb/SOSJMM7hKOdABFHnQQkJ1Ytg
         8o3pv7GShamX2SIghnStYeFBTX4s9HpbOyU2YW1FHBr98bgu4sd0jEBWdCY2GJJECqH8
         GV7DG0QULH5MauNJ2ZNZ2RrL+qKPEBB+kN6t5jnkooUBNBlvPNLGBRKw0Vg58tDrJbJb
         0UqmN/xOZbEvOBzmaBNc1ayFR5HofxAhhY8JZgEgmIoxtyHYXvY1LkV9rzyicWkbr4Dn
         lIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ByKG67dfsbtrlfy4iJXUB63IQ1NQHthpkE1LO4mAvTo=;
        b=mTV/eNEEj2bnZ94gegwGPjkxsPMf8vIxUBRqV4599VQlDC8Cm2Xbzr5t8ljGynTSay
         0YrZgJtboopI9eKh7BIteev1P2bESkbuhFv/71AOK/0TEdQp146egFuqxtEe9QpAhhdk
         gJkdaKqSWBWf+OvBkaj7EDCHLjEayj9gmvh/9dhxeTpqsqERAJbRc61OhY4LTRTjgPoD
         UKfK7r+CBFWbNvEXZ+tICqe4b5Mj5lDLjKCWotdixj/vkVLLWeOWWxIAi2T4qfbh+Teo
         +MVuMdjUlUAjHZnyEmWEDzux+GN2qVHlDDpjuQiqTGSZxTJwYfG9LBoNMP5IX4bt7vQ6
         bcjA==
X-Gm-Message-State: APjAAAX4ShcTHUFiIvVW9o9y3/qBcOqt9aunuXtd4pDWPlKVr+wO5e9V
        wjMoH2Hp07NouF8cuUGBTfQ=
X-Google-Smtp-Source: APXvYqw5RYvJXZfswHEBPD8NZ03mHQYXaubl/oUeUDuKWfzLLnwBBrQO4xQsZz7yZP9ESVKchMRi+w==
X-Received: by 2002:a5d:6a89:: with SMTP id s9mr4179056wru.58.1552691652409;
        Fri, 15 Mar 2019 16:14:12 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bc4:dc00:e99b:2537:dcd3:443f? (p200300EA8BC4DC00E99B2537DCD3443F.dip0.t-ipconnect.de. [2003:ea:8bc4:dc00:e99b:2537:dcd3:443f])
        by smtp.googlemail.com with ESMTPSA id 11sm3614341wmg.27.2019.03.15.16.14.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 16:14:11 -0700 (PDT)
Subject: Re: [PATCH net] net: phy: Don't assume loopback is supported
To:     Jose Abreu <jose.abreu@synopsys.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Joao Pinto <joao.pinto@synopsys.com>
References: <eeea080649153eefafef8ff93274733fe8f25b01.1552559796.git.joabreu@synopsys.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <24bb3e68-402b-98c1-a9e5-ca72e8efe428@gmail.com>
Date:   Sat, 16 Mar 2019 00:14:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <eeea080649153eefafef8ff93274733fe8f25b01.1552559796.git.joabreu@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.03.2019 11:37, Jose Abreu wrote:
> Some PHYs may not support loopback mode so we need to check if register
> is read-only.
> 
As I read Clause 22 this is a mandatory feature, the related bit is
specified as R/W. Do you have an actual example of a PHY w/o loopback
mode that doesn't allow to change this bit?

> Fixes: f0f9b4ed2338 ("net: phy: Add phy loopback support in net phy framework")
> Signed-off-by: Jose Abreu <joabreu@synopsys.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Joao Pinto <joao.pinto@synopsys.com>
> ---
>  drivers/net/phy/phy_device.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 49fdd1ee798e..a749639d98c3 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1918,8 +1918,24 @@ EXPORT_SYMBOL(genphy_resume);
>  
>  int genphy_loopback(struct phy_device *phydev, bool enable)
>  {
> -	return phy_modify(phydev, MII_BMCR, BMCR_LOOPBACK,
> -			  enable ? BMCR_LOOPBACK : 0);
> +	int ret;
> +
> +	ret = phy_modify(phydev, MII_BMCR, BMCR_LOOPBACK,
> +			 enable ? BMCR_LOOPBACK : 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = phy_read(phydev, MII_BMCR);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (enable) {
> +		if (ret & BMCR_LOOPBACK)
> +			return 0;
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL(genphy_loopback);
>  
> 

