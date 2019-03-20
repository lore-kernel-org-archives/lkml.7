Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AFDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DD920830
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aKfNFmV8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfCTWe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 18:34:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35472 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbfCTWe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 18:34:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id g8so2836583pgf.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 15:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=esbdAyu3T+o+zez8tkXQO6KPhgsZNz2xBz07TT2mOA0=;
        b=aKfNFmV80eYucvIGCYSqyLc0KpRxRdIpJ1OBzFRtaM6nlZ/Gn3liFfzo86A+oway1j
         zqrf4QSm/+67DvWDP0met6WBYKfnwA+X2o9XqWpnpJIwD88l3ZWij7vnaU6ezyL7iknR
         J1utkPNbrjBEDHxhZe+2Ucy+a8TEihewsGH+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=esbdAyu3T+o+zez8tkXQO6KPhgsZNz2xBz07TT2mOA0=;
        b=HQWCqifnubrCWmej7Nkt1qO/WUjBeP9X8w0mgqxoGrUW5bYKfwOsd+J90GWsEVyAMN
         +OA93RBDoVkHL9W5lPlA7QoCS2I09cUQN36dUS++9y2V3JqUpTxeo624e2eYCLjxaWqr
         7okAG+SpALi24DzaQpr+edyzsgyNEG0lvf2dDYVLJpUvv9pRpNrFG6Un4RsUSy3oBgai
         6BSIA2ysCZ7P7VxZa8cd/x9O/zXhKlDrI1w4/egzE3WK7CNrOYyBpB9wjGXIGxx641Lk
         n6WU4xps1ZOWLaFQG1X2TzQ6sNSzf9COwSrn3SsjVQ3TNC9jXORhAmfsVpoIgtsCU8SY
         a/UA==
X-Gm-Message-State: APjAAAWZVZXZVeubxx921i4If3kXFMKWx1I/VkhUZtJtvgg/wqkad07z
        T48MXlSEKJMfph9TXy6S4V0pow==
X-Google-Smtp-Source: APXvYqyVXrhwjVvRnim+85s8+kRk305TFUsW1rMHRW63v4g56wc3sYeZTTXw/9Zroj4CtIxXjGuedw==
X-Received: by 2002:a17:902:586:: with SMTP id f6mr210380plf.68.1553121297555;
        Wed, 20 Mar 2019 15:34:57 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id e63sm4102857pfe.120.2019.03.20.15.34.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 15:34:56 -0700 (PDT)
Subject: Re: [PATCH net-next 1/2] net: phy: Prepare for moving Omega out of
 bcm7xxx
To:     Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>, hkallweit1@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        murali.policharla@broadcom.com, arun.parameswaran@broadcom.com
References: <20190320195313.15658-1-f.fainelli@gmail.com>
 <20190320195313.15658-2-f.fainelli@gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <0ce073e1-d78f-eb47-47c7-f0ebf3865a92@broadcom.com>
Date:   Wed, 20 Mar 2019 15:34:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190320195313.15658-2-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good.

On 2019-03-20 12:53 p.m., Florian Fainelli wrote:
> The Omega PHY entry was added to bcm7xxx.c out of convenience and this
> breaks the one driver per product line paradigm that was applied up
> until now. Since the AFE initialization is shared between Omega and
> BCM7xxx move the relevant functions to bcm-phy-lib.[ch]. No functional
> changes introduced.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> ---
>   drivers/net/phy/bcm-phy-lib.c | 52 ++++++++++++++++++++++++
>   drivers/net/phy/bcm-phy-lib.h | 20 ++++++++++
>   drivers/net/phy/bcm7xxx.c     | 75 ++---------------------------------
>   3 files changed, 76 insertions(+), 71 deletions(-)
>
> diff --git a/drivers/net/phy/bcm-phy-lib.c b/drivers/net/phy/bcm-phy-lib.c
> index a75642051b8b..e0d3310957ff 100644
> --- a/drivers/net/phy/bcm-phy-lib.c
> +++ b/drivers/net/phy/bcm-phy-lib.c
> @@ -371,6 +371,58 @@ void bcm_phy_get_stats(struct phy_device *phydev, u64 *shadow,
>   }
>   EXPORT_SYMBOL_GPL(bcm_phy_get_stats);
>   
> +void bcm_phy_r_rc_cal_reset(struct phy_device *phydev)
> +{
> +	/* Reset R_CAL/RC_CAL Engine */
> +	bcm_phy_write_exp_sel(phydev, 0x00b0, 0x0010);
> +
> +	/* Disable Reset R_AL/RC_CAL Engine */
> +	bcm_phy_write_exp_sel(phydev, 0x00b0, 0x0000);
> +}
> +EXPORT_SYMBOL_GPL(bcm_phy_r_rc_cal_reset);
> +
> +int bcm_phy_28nm_a0b0_afe_config_init(struct phy_device *phydev)
> +{
> +	/* Increase VCO range to prevent unlocking problem of PLL at low
> +	 * temp
> +	 */
> +	bcm_phy_write_misc(phydev, PLL_PLLCTRL_1, 0x0048);
> +
> +	/* Change Ki to 011 */
> +	bcm_phy_write_misc(phydev, PLL_PLLCTRL_2, 0x021b);
> +
> +	/* Disable loading of TVCO buffer to bandgap, set bandgap trim
> +	 * to 111
> +	 */
> +	bcm_phy_write_misc(phydev, PLL_PLLCTRL_4, 0x0e20);
> +
> +	/* Adjust bias current trim by -3 */
> +	bcm_phy_write_misc(phydev, DSP_TAP10, 0x690b);
> +
> +	/* Switch to CORE_BASE1E */
> +	phy_write(phydev, MII_BRCM_CORE_BASE1E, 0xd);
> +
> +	bcm_phy_r_rc_cal_reset(phydev);
> +
> +	/* write AFE_RXCONFIG_0 */
> +	bcm_phy_write_misc(phydev, AFE_RXCONFIG_0, 0xeb19);
> +
> +	/* write AFE_RXCONFIG_1 */
> +	bcm_phy_write_misc(phydev, AFE_RXCONFIG_1, 0x9a3f);
> +
> +	/* write AFE_RX_LP_COUNTER */
> +	bcm_phy_write_misc(phydev, AFE_RX_LP_COUNTER, 0x7fc0);
> +
> +	/* write AFE_HPF_TRIM_OTHERS */
> +	bcm_phy_write_misc(phydev, AFE_HPF_TRIM_OTHERS, 0x000b);
> +
> +	/* write AFTE_TX_CONFIG */
> +	bcm_phy_write_misc(phydev, AFE_TX_CONFIG, 0x0800);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(bcm_phy_28nm_a0b0_afe_config_init);
> +
>   MODULE_DESCRIPTION("Broadcom PHY Library");
>   MODULE_LICENSE("GPL v2");
>   MODULE_AUTHOR("Broadcom Corporation");
> diff --git a/drivers/net/phy/bcm-phy-lib.h b/drivers/net/phy/bcm-phy-lib.h
> index 17faaefcfd60..5ecacb4e64f0 100644
> --- a/drivers/net/phy/bcm-phy-lib.h
> +++ b/drivers/net/phy/bcm-phy-lib.h
> @@ -9,6 +9,24 @@
>   #include <linux/brcmphy.h>
>   #include <linux/phy.h>
>   
> +/* 28nm only register definitions */
> +#define MISC_ADDR(base, channel)	base, channel
> +
> +#define DSP_TAP10			MISC_ADDR(0x0a, 0)
> +#define PLL_PLLCTRL_1			MISC_ADDR(0x32, 1)
> +#define PLL_PLLCTRL_2			MISC_ADDR(0x32, 2)
> +#define PLL_PLLCTRL_4			MISC_ADDR(0x33, 0)
> +
> +#define AFE_RXCONFIG_0			MISC_ADDR(0x38, 0)
> +#define AFE_RXCONFIG_1			MISC_ADDR(0x38, 1)
> +#define AFE_RXCONFIG_2			MISC_ADDR(0x38, 2)
> +#define AFE_RX_LP_COUNTER		MISC_ADDR(0x38, 3)
> +#define AFE_TX_CONFIG			MISC_ADDR(0x39, 0)
> +#define AFE_VDCA_ICTRL_0		MISC_ADDR(0x39, 1)
> +#define AFE_VDAC_OTHERS_0		MISC_ADDR(0x39, 3)
> +#define AFE_HPF_TRIM_OTHERS		MISC_ADDR(0x3a, 0)
> +
> +
>   int bcm_phy_write_exp(struct phy_device *phydev, u16 reg, u16 val);
>   int bcm_phy_read_exp(struct phy_device *phydev, u16 reg);
>   
> @@ -45,5 +63,7 @@ int bcm_phy_get_sset_count(struct phy_device *phydev);
>   void bcm_phy_get_strings(struct phy_device *phydev, u8 *data);
>   void bcm_phy_get_stats(struct phy_device *phydev, u64 *shadow,
>   		       struct ethtool_stats *stats, u64 *data);
> +void bcm_phy_r_rc_cal_reset(struct phy_device *phydev);
> +int bcm_phy_28nm_a0b0_afe_config_init(struct phy_device *phydev);
>   
>   #endif /* _LINUX_BCM_PHY_LIB_H */
> diff --git a/drivers/net/phy/bcm7xxx.c b/drivers/net/phy/bcm7xxx.c
> index b8415f8fae14..dddeffa23aa1 100644
> --- a/drivers/net/phy/bcm7xxx.c
> +++ b/drivers/net/phy/bcm7xxx.c
> @@ -37,77 +37,10 @@
>   #define MII_BCM7XXX_SHD_3_TL4		0x23
>   #define  MII_BCM7XXX_TL4_RST_MSK	(BIT(2) | BIT(1))
>   
> -/* 28nm only register definitions */
> -#define MISC_ADDR(base, channel)	base, channel
> -
> -#define DSP_TAP10			MISC_ADDR(0x0a, 0)
> -#define PLL_PLLCTRL_1			MISC_ADDR(0x32, 1)
> -#define PLL_PLLCTRL_2			MISC_ADDR(0x32, 2)
> -#define PLL_PLLCTRL_4			MISC_ADDR(0x33, 0)
> -
> -#define AFE_RXCONFIG_0			MISC_ADDR(0x38, 0)
> -#define AFE_RXCONFIG_1			MISC_ADDR(0x38, 1)
> -#define AFE_RXCONFIG_2			MISC_ADDR(0x38, 2)
> -#define AFE_RX_LP_COUNTER		MISC_ADDR(0x38, 3)
> -#define AFE_TX_CONFIG			MISC_ADDR(0x39, 0)
> -#define AFE_VDCA_ICTRL_0		MISC_ADDR(0x39, 1)
> -#define AFE_VDAC_OTHERS_0		MISC_ADDR(0x39, 3)
> -#define AFE_HPF_TRIM_OTHERS		MISC_ADDR(0x3a, 0)
> -
>   struct bcm7xxx_phy_priv {
>   	u64	*stats;
>   };
>   
> -static void r_rc_cal_reset(struct phy_device *phydev)
> -{
> -	/* Reset R_CAL/RC_CAL Engine */
> -	bcm_phy_write_exp_sel(phydev, 0x00b0, 0x0010);
> -
> -	/* Disable Reset R_AL/RC_CAL Engine */
> -	bcm_phy_write_exp_sel(phydev, 0x00b0, 0x0000);
> -}
> -
> -static int bcm7xxx_28nm_b0_afe_config_init(struct phy_device *phydev)
> -{
> -	/* Increase VCO range to prevent unlocking problem of PLL at low
> -	 * temp
> -	 */
> -	bcm_phy_write_misc(phydev, PLL_PLLCTRL_1, 0x0048);
> -
> -	/* Change Ki to 011 */
> -	bcm_phy_write_misc(phydev, PLL_PLLCTRL_2, 0x021b);
> -
> -	/* Disable loading of TVCO buffer to bandgap, set bandgap trim
> -	 * to 111
> -	 */
> -	bcm_phy_write_misc(phydev, PLL_PLLCTRL_4, 0x0e20);
> -
> -	/* Adjust bias current trim by -3 */
> -	bcm_phy_write_misc(phydev, DSP_TAP10, 0x690b);
> -
> -	/* Switch to CORE_BASE1E */
> -	phy_write(phydev, MII_BRCM_CORE_BASE1E, 0xd);
> -
> -	r_rc_cal_reset(phydev);
> -
> -	/* write AFE_RXCONFIG_0 */
> -	bcm_phy_write_misc(phydev, AFE_RXCONFIG_0, 0xeb19);
> -
> -	/* write AFE_RXCONFIG_1 */
> -	bcm_phy_write_misc(phydev, AFE_RXCONFIG_1, 0x9a3f);
> -
> -	/* write AFE_RX_LP_COUNTER */
> -	bcm_phy_write_misc(phydev, AFE_RX_LP_COUNTER, 0x7fc0);
> -
> -	/* write AFE_HPF_TRIM_OTHERS */
> -	bcm_phy_write_misc(phydev, AFE_HPF_TRIM_OTHERS, 0x000b);
> -
> -	/* write AFTE_TX_CONFIG */
> -	bcm_phy_write_misc(phydev, AFE_TX_CONFIG, 0x0800);
> -
> -	return 0;
> -}
> -
>   static int bcm7xxx_28nm_d0_afe_config_init(struct phy_device *phydev)
>   {
>   	/* AFE_RXCONFIG_0 */
> @@ -143,7 +76,7 @@ static int bcm7xxx_28nm_d0_afe_config_init(struct phy_device *phydev)
>   	bcm_phy_write_misc(phydev, DSP_TAP10, 0x011b);
>   
>   	/* Reset R_CAL/RC_CAL engine */
> -	r_rc_cal_reset(phydev);
> +	bcm_phy_r_rc_cal_reset(phydev);
>   
>   	return 0;
>   }
> @@ -171,7 +104,7 @@ static int bcm7xxx_28nm_e0_plus_afe_config_init(struct phy_device *phydev)
>   	bcm_phy_write_misc(phydev, DSP_TAP10, 0x011b);
>   
>   	/* Reset R_CAL/RC_CAL engine */
> -	r_rc_cal_reset(phydev);
> +	bcm_phy_r_rc_cal_reset(phydev);
>   
>   	return 0;
>   }
> @@ -196,7 +129,7 @@ static int bcm7xxx_28nm_a0_patch_afe_config_init(struct phy_device *phydev)
>   	/* Enable ffe zero detection for Vitesse interoperability */
>   	bcm_phy_write_misc(phydev, 0x26, 0x2, 0x0015);
>   
> -	r_rc_cal_reset(phydev);
> +	bcm_phy_r_rc_cal_reset(phydev);
>   
>   	return 0;
>   }
> @@ -227,7 +160,7 @@ static int bcm7xxx_28nm_config_init(struct phy_device *phydev)
>   	switch (rev) {
>   	case 0xa0:
>   	case 0xb0:
> -		ret = bcm7xxx_28nm_b0_afe_config_init(phydev);
> +		ret = bcm_phy_28nm_a0b0_afe_config_init(phydev);
>   		break;
>   	case 0xd0:
>   		ret = bcm7xxx_28nm_d0_afe_config_init(phydev);
