Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC216C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB17206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="StBAZEG9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfDIIrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:47:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40864 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfDIIrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 04:47:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so19740155wre.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 01:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=/C1h77F+yf1YiKdSW4u8EW/LpvGFHUW1WPfpKGD1tkM=;
        b=StBAZEG9KvE4tlONkvY4Cr4Lt2OGh8SSzjdwdmuDk3rHfewWhKZfO2yYGeljosg9gN
         FeXsU6WJ+vBaYOTBZs2W5SEkYoO102dCpnojolbRvuaTnw3HIc65Nn2hoCFnURDD0i1t
         IMcuMqPVNrtV9dZaR0IenYvIHg4JkB35pTdeqmQOqnsoX6QjY8cMqeUhZbRNgh+4ox/1
         LoiaDUUl41sqkjA7LftV5YSYkiKAucO0JFBTj1Bum7cFkfQLNoYFtIlZjsQ24L5awcp3
         CbSWL8K2Y4tarBSGYm5JMPqQ6qnp/eD5YzpPRXwDYrV1C1CeTUi0p0INyU05E/hICm5N
         iXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=/C1h77F+yf1YiKdSW4u8EW/LpvGFHUW1WPfpKGD1tkM=;
        b=cSFDv+IRAjJZ36QKmHwGRXdts5u+NUVz556rfaOfyiyaNCtASiHbEkBAYT0XFVnz6w
         v7UamRL4yNq6UH4F79vJ4vdHruUagsOw/l5RQhKr4/ON7mMc2t9KzTTA+JTCIR/71Glp
         R3oD+ZjkmfSlTKcUcP6f5SR4Qoh8RyewpdyWBvtF+XHJ7xQ9KYoq4kGcMV7rWV5QuAVK
         Ox2azu8zoFAyPwS3DIQr4fVQl07NUFCz6ZaIHa8afb7jYie7vcQQkWPmbrASk4QEtBw3
         mXw2u4P2hvlxaNLY87zosMvdpM2lWRzvmHuAsA4i+elOLGFKGiW1Jez0QUneenkyfAtA
         cQsQ==
X-Gm-Message-State: APjAAAVglpNc/ZJDi8HnAiBCG0p+HGtmuXMpyqV2X1ORi+BhrIfxkrly
        4xT9b+tigdbYEYzoGRbeemDrPg==
X-Google-Smtp-Source: APXvYqwTFsB8n1r3f1MIV/NWgKBs20aHezy+QE0d/aWTc+c8DNpwKvzIcjDLJe8Gdqq4PldCgKbX/Q==
X-Received: by 2002:a5d:6889:: with SMTP id h9mr21560381wru.12.1554799619178;
        Tue, 09 Apr 2019 01:46:59 -0700 (PDT)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id d7sm14356019wmf.31.2019.04.09.01.46.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Apr 2019 01:46:58 -0700 (PDT)
Message-ID: <2e2f63d7281c67c32fff993f1b557d80f53d23ad.camel@baylibre.com>
Subject: Re: [PATCH 09/11] drm/meson: Add G12A Video Clock setup
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 09 Apr 2019 10:46:56 +0200
In-Reply-To: <20190325141824.21259-10-narmstrong@baylibre.com>
References: <20190325141824.21259-1-narmstrong@baylibre.com>
         <20190325141824.21259-10-narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-25 at 15:18 +0100, Neil Armstrong wrote:
> While switching to the Common Clock Framework is still Work In Progress,
> this patch adds the corresponding G12A HDMI PLL setup to be on-par
> with the other SoCs support.
> 
> The G12A has only a single tweak about the high frequency setup,
> where the HDMI PLL needs a specific setup to handle correctly the
> 5.94GHz DCO frequency.
> 
> Apart that, it handle correctly all the other HDMI frequencies
> and can achieve even better DMT clock frequency precision with
> the larger fractional dividier width.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/meson/meson_vclk.c | 119 ++++++++++++++++++++++++++---
>  1 file changed, 108 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
> index c15a5a5df633..b39034745444 100644
> --- a/drivers/gpu/drm/meson/meson_vclk.c
> +++ b/drivers/gpu/drm/meson/meson_vclk.c
> @@ -113,9 +113,12 @@
>  #define HHI_HDMI_PLL_CNTL4	0x32C /* 0xcb offset in data sheet */
>  #define HHI_HDMI_PLL_CNTL5	0x330 /* 0xcc offset in data sheet */
>  #define HHI_HDMI_PLL_CNTL6	0x334 /* 0xcd offset in data sheet */
> +#define HHI_HDMI_PLL_CNTL7	0x338 /* 0xce offset in data sheet */
>  
>  #define HDMI_PLL_RESET		BIT(28)
> +#define HDMI_PLL_RESET_G12A	BIT(29)
>  #define HDMI_PLL_LOCK		BIT(31)
> +#define HDMI_PLL_LOCK_G12A	(3 << 30)

GENMASK(31, 30) ?

>  
>  #define FREQ_1000_1001(_freq)	DIV_ROUND_CLOSEST(_freq * 1000, 1001)
>  
> @@ -257,6 +260,10 @@ static void meson_venci_cvbs_clock_config(struct meson_drm *priv)
>  		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5, 0x71486980);
>  		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL6, 0x00000e55);
>  		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x4800023d);
> +
> +		/* Poll for lock bit */
> +		regmap_read_poll_timeout(priv->hhi, HHI_HDMI_PLL_CNTL, val,
> +					 (val & HDMI_PLL_LOCK), 10, 0);
>  	} else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
>  		   meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu")) {
>  		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x4000027b);
> @@ -271,11 +278,26 @@ static void meson_venci_cvbs_clock_config(struct meson_drm *priv)
>  					HDMI_PLL_RESET, HDMI_PLL_RESET);
>  		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
>  					HDMI_PLL_RESET, 0);
> -	}
>  
> -	/* Poll for lock bit */
> -	regmap_read_poll_timeout(priv->hhi, HHI_HDMI_PLL_CNTL, val,
> -				 (val & HDMI_PLL_LOCK), 10, 0);
> +		/* Poll for lock bit */
> +		regmap_read_poll_timeout(priv->hhi, HHI_HDMI_PLL_CNTL, val,
> +					 (val & HDMI_PLL_LOCK), 10, 0);
> +	} else if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
> +		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x1a0504f7);
> +		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL2, 0x00010000);
> +		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL3, 0x00000000);
> +		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL4, 0x6a28dc00);
> +		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5, 0x65771290);
> +		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL6, 0x39272000);
> +		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL7, 0x56540000);
> +		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x3a0504f7);
> +		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x1a0504f7);
> +
> +		/* Poll for lock bit */
> +		regmap_read_poll_timeout(priv->hhi, HHI_HDMI_PLL_CNTL, val,
> +			((val & HDMI_PLL_LOCK_G12A) == HDMI_PLL_LOCK_G12A),
> +			10, 0);
> +	}
>  
>  	/* Disable VCLK2 */
>  	regmap_update_bits(priv->hhi, HHI_VIID_CLK_CNTL, VCLK2_EN, 0);
> @@ -288,8 +310,13 @@ static void meson_venci_cvbs_clock_config(struct meson_drm *priv)
>  				VCLK2_DIV_MASK, (55 - 1));
>  
>  	/* select vid_pll for vclk2 */
> -	regmap_update_bits(priv->hhi, HHI_VIID_CLK_CNTL,
> -				VCLK2_SEL_MASK, (4 << VCLK2_SEL_SHIFT));
> +	if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu"))
> +		regmap_update_bits(priv->hhi, HHI_VIID_CLK_CNTL,
> +					VCLK2_SEL_MASK, (0 << VCLK2_SEL_SHIFT));
> +	else
> +		regmap_update_bits(priv->hhi, HHI_VIID_CLK_CNTL,
> +					VCLK2_SEL_MASK, (4 << VCLK2_SEL_SHIFT));
> +
>  	/* enable vclk2 gate */
>  	regmap_update_bits(priv->hhi, HHI_VIID_CLK_CNTL, VCLK2_EN, VCLK2_EN);
>  
> @@ -476,32 +503,80 @@ void meson_hdmi_pll_set_params(struct meson_drm *priv, unsigned int m,
>  		/* Poll for lock bit */
>  		regmap_read_poll_timeout(priv->hhi, HHI_HDMI_PLL_CNTL, val,
>  				(val & HDMI_PLL_LOCK), 10, 0);
> +	} else if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
> +		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x0b3a0400 | m);
> +
> +		/* Enable and reset */
> +		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
> +				   0x3 << 28, 0x3 << 28);

Could you use define of the enable and reset bit instead  of 0x3 << 28 ?

> +
> +		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL2, frac);
> +		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL3, 0x00000000);
> +
> +		/* G12A HDMI PLL Needs specific parameters for 5.4GHz */
> +		if (m >= 0xf7) {
> +			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL4, 0xea68dc00);
> +			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5, 0x65771290);
> +			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL6, 0x39272000);
> +			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL7, 0x55540000);
> +		} else {
> +			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL4, 0x0a691c00);
> +			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5, 0x33771290);
> +			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL6, 0x39270000);
> +			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL7, 0x50540000);
> +		}
> +
> +		do {
> +			/* Reset PLL */
> +			regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
> +					HDMI_PLL_RESET_G12A, HDMI_PLL_RESET_G12A);
> +
> +			/* UN-Reset PLL */
> +			regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
> +					HDMI_PLL_RESET_G12A, 0);
> +
> +			/* Poll for lock bits */
> +			if (!regmap_read_poll_timeout(priv->hhi,
> +						      HHI_HDMI_PLL_CNTL, val,
> +						      ((val & HDMI_PLL_LOCK_G12A)
> +						        == HDMI_PLL_LOCK_G12A),
> +						      10, 100))
> +				break;
> +		} while(1);
>  	}
>  
>  	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxbb-vpu"))
>  		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL2,
>  				3 << 16, pll_od_to_reg(od1) << 16);
>  	else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
> -			meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu"))
> +		 meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu"))
>  		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL3,
>  				3 << 21, pll_od_to_reg(od1) << 21);
> +	else if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu"))
> +		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
> +				3 << 16, pll_od_to_reg(od1) << 16);
>  
>  	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxbb-vpu"))
>  		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL2,
>  				3 << 22, pll_od_to_reg(od2) << 22);
>  	else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
> -			meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu"))
> +		 meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu"))
>  		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL3,
>  				3 << 23, pll_od_to_reg(od2) << 23);
> +	else if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu"))
> +		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
> +				3 << 18, pll_od_to_reg(od2) << 18);
>  
>  	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxbb-vpu"))
>  		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL2,
>  				3 << 18, pll_od_to_reg(od3) << 18);
>  	else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
> -			meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu"))
> +		 meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu"))
>  		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL3,
>  				3 << 19, pll_od_to_reg(od3) << 19);
> -
> +	else if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu"))
> +		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
> +				3 << 20, pll_od_to_reg(od3) << 20);

Could you remove the constants above and define the shift and mask of the ODs
?

>  }
>  
>  #define XTAL_FREQ 24000
> @@ -518,6 +593,7 @@ static unsigned int meson_hdmi_pll_get_m(struct meson_drm *priv,
>  
>  #define HDMI_FRAC_MAX_GXBB	4096
>  #define HDMI_FRAC_MAX_GXL	1024
> +#define HDMI_FRAC_MAX_G12A	131072
>  
>  static unsigned int meson_hdmi_pll_get_frac(struct meson_drm *priv,
>  					    unsigned int m,
> @@ -534,6 +610,9 @@ static unsigned int meson_hdmi_pll_get_frac(struct meson_drm *priv,
>  		parent_freq *= 2;
>  	}
>  
> +	if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu"))
> +		frac_max = HDMI_FRAC_MAX_G12A;
> +
>  	/* We can have a perfect match !*/
>  	if (pll_freq / m == parent_freq &&
>  	    pll_freq % m == 0)
> @@ -559,7 +638,8 @@ static bool meson_hdmi_pll_validate_params(struct meson_drm *priv,
>  		if (frac >= HDMI_FRAC_MAX_GXBB)
>  			return false;
>  	} else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
> -		   meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu")) {
> +		   meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu") ||
> +		   meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
>  		/* Empiric supported min/max dividers */
>  		if (m < 106 || m > 247)
>  			return false;
> @@ -713,6 +793,23 @@ static void meson_vclk_set(struct meson_drm *priv, unsigned int pll_base_freq,
>  			break;
>  		}
>  
> +		meson_hdmi_pll_set_params(priv, m, frac, od1, od2, od3);
> +	} else if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
> +		switch (pll_base_freq) {
> +		case 2970000:
> +			m = 0x7b;
> +			frac = vic_alternate_clock ? 0x140b4 : 0x18000;
> +			break;
> +		case 4320000:
> +			m = vic_alternate_clock ? 0xb3 : 0xb4;
> +			frac = vic_alternate_clock ? 0x1a3ee : 0;
> +			break;
> +		case 5940000:
> +			m = 0xf7;
> +			frac = vic_alternate_clock ? 0x8148 : 0x10000;
> +			break;
> +		}
> +
>  		meson_hdmi_pll_set_params(priv, m, frac, od1, od2, od3);
>  	}
>  


