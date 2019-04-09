Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1E8C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F4D20818
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uHcSZyWZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfDIJTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:19:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54604 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfDIJTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:19:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id c1so1135332wml.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 02:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Ly84MQAcGGg7EuNJT4EnRVNtYf1x1Sqmd2QePOsavzM=;
        b=uHcSZyWZjmarcYxe/Q4CCw9A92qG1N7CCzps48CHPCuUQXMkoZfjKJqysNStSMQkK/
         JGF6zN1WRbZgm+WrDct5Pj6drOduxLOgkehVDSQnKEJ/s15F+XeYXzdvNutjB4RnmhuO
         ysiLTI7hPfTU+JMHEVpQKNrf5HyZpVaS6omyDT6kskUB9of/hOrolxJZKFn+R+Z4L837
         teagvg63IiOHMumlDMqRChVGXzgd7fYSneeIh+MSGgGowLDc8ILbKVXV2FEf58+8E23V
         kG0u6BAicegq9ti+jk4XKF7xR5j4indF4o9EEph7huhPoncDlBjE/O0AxfwrYHJFqPNx
         Ue6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Ly84MQAcGGg7EuNJT4EnRVNtYf1x1Sqmd2QePOsavzM=;
        b=L9/CcTn3WD+LsMiedMmskTVEori3NYr4BFXzQT7F+NZodrJMcMptUMcjFIdoWvVACr
         3pbut7he5SyTq7gWw6+xeIfsdZ0JHCEfJ067JLBzQEF16wzPt8tddC3I/pdPMrAqRi+y
         RoGLXCu0zIkMOxZaUcx9O0uHDvZftNbD6jmx13v0l9KNQ6xH2LKe36SsW0O1bSfhGY8h
         jB6nAXU6Mr6AUVmqoiWdPS1fAVh6nWUn6TL1LjFE+AZOdnrP7Ip2FghdONExZFlxJ4iA
         srn4IINvs8t6Gx9nU4mGVJpfK0PaQViMwM3BuWuWXrHZimsmn76MEsdTvocUgTLlNvAL
         YgDg==
X-Gm-Message-State: APjAAAVZw63BZum4BiTvWCr9qPWD5xkzQeRPbJyHKe7/yAOaE16gK5a3
        5UJtkqwCjugzLtI2LlRqmvu0Bd6VBUe70g==
X-Google-Smtp-Source: APXvYqyBXiQH/z3bBN7tXZDQqqtiKCJvqgT8dwp1CfdaU/oQiQ1AY8hGTigFafy3AE06dc57swrZkw==
X-Received: by 2002:a1c:4844:: with SMTP id v65mr20853032wma.139.1554801576544;
        Tue, 09 Apr 2019 02:19:36 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t74sm3068693wmt.3.2019.04.09.02.19.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 02:19:36 -0700 (PDT)
Subject: Re: [PATCH 09/11] drm/meson: Add G12A Video Clock setup
To:     Jerome Brunet <jbrunet@baylibre.com>,
        dri-devel@lists.freedesktop.org
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190325141824.21259-1-narmstrong@baylibre.com>
 <20190325141824.21259-10-narmstrong@baylibre.com>
 <2e2f63d7281c67c32fff993f1b557d80f53d23ad.camel@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <89be9d6c-e0ad-08de-bdf1-14e9c94a43e9@baylibre.com>
Date:   Tue, 9 Apr 2019 11:19:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2e2f63d7281c67c32fff993f1b557d80f53d23ad.camel@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2019 10:46, Jerome Brunet wrote:
> On Mon, 2019-03-25 at 15:18 +0100, Neil Armstrong wrote:
>> While switching to the Common Clock Framework is still Work In Progress,
>> this patch adds the corresponding G12A HDMI PLL setup to be on-par
>> with the other SoCs support.
>>
>> The G12A has only a single tweak about the high frequency setup,
>> where the HDMI PLL needs a specific setup to handle correctly the
>> 5.94GHz DCO frequency.
>>
>> Apart that, it handle correctly all the other HDMI frequencies
>> and can achieve even better DMT clock frequency precision with
>> the larger fractional dividier width.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/gpu/drm/meson/meson_vclk.c | 119 ++++++++++++++++++++++++++---
>>  1 file changed, 108 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
>> index c15a5a5df633..b39034745444 100644
>> --- a/drivers/gpu/drm/meson/meson_vclk.c
>> +++ b/drivers/gpu/drm/meson/meson_vclk.c
>> @@ -113,9 +113,12 @@
>>  #define HHI_HDMI_PLL_CNTL4	0x32C /* 0xcb offset in data sheet */
>>  #define HHI_HDMI_PLL_CNTL5	0x330 /* 0xcc offset in data sheet */
>>  #define HHI_HDMI_PLL_CNTL6	0x334 /* 0xcd offset in data sheet */
>> +#define HHI_HDMI_PLL_CNTL7	0x338 /* 0xce offset in data sheet */
>>  
>>  #define HDMI_PLL_RESET		BIT(28)
>> +#define HDMI_PLL_RESET_G12A	BIT(29)
>>  #define HDMI_PLL_LOCK		BIT(31)
>> +#define HDMI_PLL_LOCK_G12A	(3 << 30)
> 
> GENMASK(31, 30) ?

Ack

> 
>>  
>>  #define FREQ_1000_1001(_freq)	DIV_ROUND_CLOSEST(_freq * 1000, 1001)
>>  
>> @@ -257,6 +260,10 @@ static void meson_venci_cvbs_clock_config(struct meson_drm *priv)
>>  		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5, 0x71486980);
>>  		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL6, 0x00000e55);
>>  		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x4800023d);
>> +
>> +		/* Poll for lock bit */
>> +		regmap_read_poll_timeout(priv->hhi, HHI_HDMI_PLL_CNTL, val,
>> +					 (val & HDMI_PLL_LOCK), 10, 0);
>>  	} else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
>>  		   meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu")) {
>>  		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x4000027b);
>> @@ -271,11 +278,26 @@ static void meson_venci_cvbs_clock_config(struct meson_drm *priv)
>>  					HDMI_PLL_RESET, HDMI_PLL_RESET);
>>  		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
>>  					HDMI_PLL_RESET, 0);
>> -	}
>>  
>> -	/* Poll for lock bit */
>> -	regmap_read_poll_timeout(priv->hhi, HHI_HDMI_PLL_CNTL, val,
>> -				 (val & HDMI_PLL_LOCK), 10, 0);
>> +		/* Poll for lock bit */
>> +		regmap_read_poll_timeout(priv->hhi, HHI_HDMI_PLL_CNTL, val,
>> +					 (val & HDMI_PLL_LOCK), 10, 0);
>> +	} else if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
>> +		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x1a0504f7);
>> +		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL2, 0x00010000);
>> +		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL3, 0x00000000);
>> +		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL4, 0x6a28dc00);
>> +		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5, 0x65771290);
>> +		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL6, 0x39272000);
>> +		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL7, 0x56540000);
>> +		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x3a0504f7);
>> +		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x1a0504f7);
>> +
>> +		/* Poll for lock bit */
>> +		regmap_read_poll_timeout(priv->hhi, HHI_HDMI_PLL_CNTL, val,
>> +			((val & HDMI_PLL_LOCK_G12A) == HDMI_PLL_LOCK_G12A),
>> +			10, 0);
>> +	}
>>  
>>  	/* Disable VCLK2 */
>>  	regmap_update_bits(priv->hhi, HHI_VIID_CLK_CNTL, VCLK2_EN, 0);
>> @@ -288,8 +310,13 @@ static void meson_venci_cvbs_clock_config(struct meson_drm *priv)
>>  				VCLK2_DIV_MASK, (55 - 1));
>>  
>>  	/* select vid_pll for vclk2 */
>> -	regmap_update_bits(priv->hhi, HHI_VIID_CLK_CNTL,
>> -				VCLK2_SEL_MASK, (4 << VCLK2_SEL_SHIFT));
>> +	if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu"))
>> +		regmap_update_bits(priv->hhi, HHI_VIID_CLK_CNTL,
>> +					VCLK2_SEL_MASK, (0 << VCLK2_SEL_SHIFT));
>> +	else
>> +		regmap_update_bits(priv->hhi, HHI_VIID_CLK_CNTL,
>> +					VCLK2_SEL_MASK, (4 << VCLK2_SEL_SHIFT));
>> +
>>  	/* enable vclk2 gate */
>>  	regmap_update_bits(priv->hhi, HHI_VIID_CLK_CNTL, VCLK2_EN, VCLK2_EN);
>>  
>> @@ -476,32 +503,80 @@ void meson_hdmi_pll_set_params(struct meson_drm *priv, unsigned int m,
>>  		/* Poll for lock bit */
>>  		regmap_read_poll_timeout(priv->hhi, HHI_HDMI_PLL_CNTL, val,
>>  				(val & HDMI_PLL_LOCK), 10, 0);
>> +	} else if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
>> +		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x0b3a0400 | m);
>> +
>> +		/* Enable and reset */
>> +		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
>> +				   0x3 << 28, 0x3 << 28);
> 
> Could you use define of the enable and reset bit instead  of 0x3 << 28 ?

Ack

> 
>> +
>> +		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL2, frac);
>> +		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL3, 0x00000000);
>> +
>> +		/* G12A HDMI PLL Needs specific parameters for 5.4GHz */
>> +		if (m >= 0xf7) {
>> +			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL4, 0xea68dc00);
>> +			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5, 0x65771290);
>> +			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL6, 0x39272000);
>> +			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL7, 0x55540000);
>> +		} else {
>> +			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL4, 0x0a691c00);
>> +			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5, 0x33771290);
>> +			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL6, 0x39270000);
>> +			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL7, 0x50540000);
>> +		}
>> +
>> +		do {
>> +			/* Reset PLL */
>> +			regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
>> +					HDMI_PLL_RESET_G12A, HDMI_PLL_RESET_G12A);
>> +
>> +			/* UN-Reset PLL */
>> +			regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
>> +					HDMI_PLL_RESET_G12A, 0);
>> +
>> +			/* Poll for lock bits */
>> +			if (!regmap_read_poll_timeout(priv->hhi,
>> +						      HHI_HDMI_PLL_CNTL, val,
>> +						      ((val & HDMI_PLL_LOCK_G12A)
>> +						        == HDMI_PLL_LOCK_G12A),
>> +						      10, 100))
>> +				break;
>> +		} while(1);
>>  	}
>>  
>>  	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxbb-vpu"))
>>  		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL2,
>>  				3 << 16, pll_od_to_reg(od1) << 16);
>>  	else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
>> -			meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu"))
>> +		 meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu"))
>>  		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL3,
>>  				3 << 21, pll_od_to_reg(od1) << 21);
>> +	else if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu"))
>> +		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
>> +				3 << 16, pll_od_to_reg(od1) << 16);
>>  
>>  	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxbb-vpu"))
>>  		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL2,
>>  				3 << 22, pll_od_to_reg(od2) << 22);
>>  	else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
>> -			meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu"))
>> +		 meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu"))
>>  		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL3,
>>  				3 << 23, pll_od_to_reg(od2) << 23);
>> +	else if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu"))
>> +		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
>> +				3 << 18, pll_od_to_reg(od2) << 18);
>>  
>>  	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxbb-vpu"))
>>  		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL2,
>>  				3 << 18, pll_od_to_reg(od3) << 18);
>>  	else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
>> -			meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu"))
>> +		 meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu"))
>>  		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL3,
>>  				3 << 19, pll_od_to_reg(od3) << 19);
>> -
>> +	else if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu"))
>> +		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
>> +				3 << 20, pll_od_to_reg(od3) << 20);
> 
> Could you remove the constants above and define the shift and mask of the ODs
> ?

Ack

> 
>>  }
>>  
>>  #define XTAL_FREQ 24000
>> @@ -518,6 +593,7 @@ static unsigned int meson_hdmi_pll_get_m(struct meson_drm *priv,
>>  
>>  #define HDMI_FRAC_MAX_GXBB	4096
>>  #define HDMI_FRAC_MAX_GXL	1024
>> +#define HDMI_FRAC_MAX_G12A	131072
>>  
>>  static unsigned int meson_hdmi_pll_get_frac(struct meson_drm *priv,
>>  					    unsigned int m,
>> @@ -534,6 +610,9 @@ static unsigned int meson_hdmi_pll_get_frac(struct meson_drm *priv,
>>  		parent_freq *= 2;
>>  	}
>>  
>> +	if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu"))
>> +		frac_max = HDMI_FRAC_MAX_G12A;
>> +
>>  	/* We can have a perfect match !*/
>>  	if (pll_freq / m == parent_freq &&
>>  	    pll_freq % m == 0)
>> @@ -559,7 +638,8 @@ static bool meson_hdmi_pll_validate_params(struct meson_drm *priv,
>>  		if (frac >= HDMI_FRAC_MAX_GXBB)
>>  			return false;
>>  	} else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
>> -		   meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu")) {
>> +		   meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu") ||
>> +		   meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
>>  		/* Empiric supported min/max dividers */
>>  		if (m < 106 || m > 247)
>>  			return false;
>> @@ -713,6 +793,23 @@ static void meson_vclk_set(struct meson_drm *priv, unsigned int pll_base_freq,
>>  			break;
>>  		}
>>  
>> +		meson_hdmi_pll_set_params(priv, m, frac, od1, od2, od3);
>> +	} else if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
>> +		switch (pll_base_freq) {
>> +		case 2970000:
>> +			m = 0x7b;
>> +			frac = vic_alternate_clock ? 0x140b4 : 0x18000;
>> +			break;
>> +		case 4320000:
>> +			m = vic_alternate_clock ? 0xb3 : 0xb4;
>> +			frac = vic_alternate_clock ? 0x1a3ee : 0;
>> +			break;
>> +		case 5940000:
>> +			m = 0xf7;
>> +			frac = vic_alternate_clock ? 0x8148 : 0x10000;
>> +			break;
>> +		}
>> +
>>  		meson_hdmi_pll_set_params(priv, m, frac, od1, od2, od3);
>>  	}
>>  
> 
> 

Will fix in a follow-up patch, including GXBB/GXL/GXM.

Neil
