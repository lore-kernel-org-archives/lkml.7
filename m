Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095AAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF18206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmVLQJTE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732582AbfCZSng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:43:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39054 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731755AbfCZSng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:43:36 -0400
Received: by mail-wm1-f68.google.com with SMTP id t124so14051930wma.4;
        Tue, 26 Mar 2019 11:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oEMDOGRrrUkvFCxhZq/bmDBzGyzPyIczRJSS3q+zWIE=;
        b=nmVLQJTE5ouV4KC6aW9mUbdPZEtecPnUKobsG9qQT+lSBB+yT7VMFslZgmZThqnvaJ
         84yWEdFZwdFYo//McRRZ317sH7zrEh0pGqfgAoJ/lvHDF1Bd2vpJUYfmpVhfmiFoPWbZ
         UiBuKhzH/Kw/D4kB0wczMl2h9xBw5Px9XlA7aOsMqzH+CwS/z24Uepw7d5kMaJIx/yjL
         SWtbYkVezYGe0YuwNqwnQ9z0SM3jIs1X1N0fsP9Xpe69fY3C0xtov1RehkulA54cDwfj
         ADLB3ZKLFeYyVDNhNZS+wZ6+lBaMDnK6iie9kJppwSq6E3o37Ql8DZ4/6PnU1lmp8unf
         qhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oEMDOGRrrUkvFCxhZq/bmDBzGyzPyIczRJSS3q+zWIE=;
        b=rLqFLF5sx7PqIobgjn2V1tz30Q+ClGobMq8VI0KJkr1gKEkWWTLQJmiNj88mNznXGh
         PiLqTEE7dRv2HZx9hSU4YOuTttAJN1ujhmxrjy+6WErfvhlkIFZkRBJ/7C02L9njwqi4
         iFCQOyqv/GlUmAYYYVpb0YDhZ/kEVgwindhwj6geLiD2AOSmgA0lZ7He5LP34TnTizd5
         65iZx89a8XV9Cy/HzSBkYBOa0F8/x7+1VrrQERhBJrQzRoezDJYaIHEzZIr7Wd70bxUd
         SR9uVCJlWGYRjq6ZLYdZmasFp2Ih5IaJDKnM5sMhT9IBM6MbOlKDMyj0ElXT8j37IPvr
         CGPw==
X-Gm-Message-State: APjAAAWLGBhbRWKxGdVfunCwIpUkZy3uG+fWWD5R5zO7cpjZiPegui/I
        cCCA/j0uIQRzt8JTsy++NpM=
X-Google-Smtp-Source: APXvYqyKgufNeYwH/zUZb/gf7uG07Dox682IgvWkdGNuRpA11hdpVSKzrxACUXFTIjFkSVuvwOqyxA==
X-Received: by 2002:a05:600c:219:: with SMTP id 25mr9703164wmi.7.1553625814285;
        Tue, 26 Mar 2019 11:43:34 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bc4:dc00:8c1:5e0b:d735:c3dc? (p200300EA8BC4DC0008C15E0BD735C3DC.dip0.t-ipconnect.de. [2003:ea:8bc4:dc00:8c1:5e0b:d735:c3dc])
        by smtp.googlemail.com with ESMTPSA id f128sm36538525wme.28.2019.03.26.11.43.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 11:43:33 -0700 (PDT)
Subject: Re: [PATCH net-next v3 1/2] net: phy: marvell10g: implement
 suspend/resume callbacks
To:     Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        linux@armlinux.org.uk, andrew@lunn.ch, f.fainelli@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, mw@semihalf.com
References: <20190326145302.9563-1-antoine.tenart@bootlin.com>
 <20190326145302.9563-2-antoine.tenart@bootlin.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <fa54cca8-c5c9-4498-c905-8fd360178c39@gmail.com>
Date:   Tue, 26 Mar 2019 19:43:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190326145302.9563-2-antoine.tenart@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.03.2019 15:53, Antoine Tenart wrote:
> This patch adds the suspend/resume callbacks for Marvell 10G PHYs. The
> three PCS (base-t, base-r and 1000base-x) are set in low power (the PCS
> are powered down) when the PHY isn't used.
> 
At least for the 3310 the datasheet mentions that via VEND2.f001.11
the port can be powered down completely. As this would simplify the code,
did you test this?

> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/net/phy/marvell10g.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
> index 100b401b1f4a..b56cd35182d5 100644
> --- a/drivers/net/phy/marvell10g.c
> +++ b/drivers/net/phy/marvell10g.c
> @@ -226,11 +226,25 @@ static int mv3310_probe(struct phy_device *phydev)
>  
>  static int mv3310_suspend(struct phy_device *phydev)
>  {
> +	phy_modify_mmd(phydev, MDIO_MMD_PCS, MV_PCS_BASE_T + MDIO_CTRL1,
> +		       MDIO_CTRL1_LPOWER, MDIO_CTRL1_LPOWER);
> +	phy_modify_mmd(phydev, MDIO_MMD_PCS, MV_PCS_BASE_R + MDIO_CTRL1,
> +		       MDIO_CTRL1_LPOWER, MDIO_CTRL1_LPOWER);
> +	phy_modify_mmd(phydev, MDIO_MMD_PCS, MV_PCS_1000BASEX + MDIO_CTRL1,
> +		       MDIO_CTRL1_LPOWER, MDIO_CTRL1_LPOWER);
> +
>  	return 0;
>  }
>  
>  static int mv3310_resume(struct phy_device *phydev)
>  {
> +	phy_modify_mmd(phydev, MDIO_MMD_PCS, MV_PCS_BASE_T + MDIO_CTRL1,
> +		       MDIO_CTRL1_LPOWER, 0);
> +	phy_modify_mmd(phydev, MDIO_MMD_PCS, MV_PCS_BASE_R + MDIO_CTRL1,
> +		       MDIO_CTRL1_LPOWER, 0);
> +	phy_modify_mmd(phydev, MDIO_MMD_PCS, MV_PCS_1000BASEX + MDIO_CTRL1,
> +		       MDIO_CTRL1_LPOWER, 0);
> +
>  	return mv3310_hwmon_config(phydev, true);
>  }
>  
> 

