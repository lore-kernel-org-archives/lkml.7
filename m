Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C855C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA852218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkFKzhzb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbfC2VcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:32:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41209 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729998AbfC2VcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 17:32:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id r4so4256355wrq.8;
        Fri, 29 Mar 2019 14:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9x508aNv3kHpyheaPWLHoljRKuPputtgEsJXuxm5pFM=;
        b=PkFKzhzbCjO0CY9YHQlOzpKDLfG+g2g46hugO7+GyfXfOHzwFIqBU3Jksl23OB/vEc
         KDTgLDxb4pFTmG9bkpHkabSOjw1tbd+FizeO6ferqXJxx1hysz7mRKkYRnlWXLrUsJ4F
         NHQlSonx9Bq2MEyL2ivLFNr5npl6pcro4SXsRFAJA/Vi0COKrZH6M/ipnaPrkZh/H0Vu
         7Dxbty6hj0NpC+Dw5nMQ4T7C1M/a6N3+Nu9emO7QkyWXzjKsWPKy7H9YRuIXBI7pSpoh
         B2gYF06QW2MAJRmcgMA7k14iefCC8yB2VGl2i6fwfE4/au9vYb3lN3tChWggG5i/6kxo
         3WEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9x508aNv3kHpyheaPWLHoljRKuPputtgEsJXuxm5pFM=;
        b=YLvNFcu/wMpG/pH4+dTg6Fu4dq6FoM5o0u858mIYRQvawMGrvL108CQI2p8hrarfr5
         D2Xp6tjtAKHmcuvFn+wZNoCsznrwh83l3CAtGeSb8qPmZEelLvuMv1qNzO+TtpImtT2B
         57zozgRI5Sy5zRl8vxgTcnBBCM5DWypvGcrK/2pmM7DyQS9yYeb5PfmRja9hYehpSTHy
         c9U4u5WfnOsyEohfKz0Ro3vCRamOZfOaW0Zb4BecUBJC6qFxJKbvQWIj73mzyWQ8slXY
         nVSjj+J1aFgthYioiO/GT2NSz+3RhgsI0q3NWGxcIqDlwokOCWj3XrQcULDjEME8oQNv
         0IbA==
X-Gm-Message-State: APjAAAUrbXm1d5uaRlz7AHSRRd9ZvqwNYInjKJRgr9oudaIIRUpW0IDY
        0paTvQIDOW+5UNG1nqRUKbs=
X-Google-Smtp-Source: APXvYqzc0o11bwxo13qCL3055RNDY802X4uTQK4PEtSgiaJ8Y8zX6kssgxmU4hMm2Hcnrfm3yS+SuQ==
X-Received: by 2002:adf:ff91:: with SMTP id j17mr29343660wrr.114.1553895130001;
        Fri, 29 Mar 2019 14:32:10 -0700 (PDT)
Received: from ?IPv6:2003:ea:8be1:dd00:a991:cc44:5157:9e5? (p200300EA8BE1DD00A991CC44515709E5.dip0.t-ipconnect.de. [2003:ea:8be1:dd00:a991:cc44:5157:9e5])
        by smtp.googlemail.com with ESMTPSA id c10sm4369564wru.83.2019.03.29.14.32.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 14:32:09 -0700 (PDT)
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
Message-ID: <dcd7bdaa-5587-0099-3a2e-ce55b32ab7f9@gmail.com>
Date:   Fri, 29 Mar 2019 22:32:02 +0100
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
When you re-submit this series, in addition to my previous comment:
Instead of phy_modify_mmd() it would be clearer to use
phy_set/clear_bits_mmd(). And checking the return value wouldn't hurt.

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

