Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DB5C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 19:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2A9233A2
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 19:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fc4aT5+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbfIATtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 15:49:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50565 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728506AbfIATtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 15:49:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id c10so466250wmc.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2019 12:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=1t8RKux0b3auTyo3EU4Fjza8Z8XyMBYSPlq98c5flic=;
        b=Fc4aT5+uP8DK3G5DqiX1PVV2U0OR5puONXiG36iLvcBgC5k9t3q5XjF75IRYjbbgxy
         aIQkqrvX4ndW8RUayuyDYvIjx2aJFf4TbnI5pGadB7iNwZVsE9UD2tEN1XOCo0rbrhcv
         ZgpnWW44RXkXooQLApzTxaK7xFfdgGHLw/sVzVJU09l6RwHZNWQUEI+ATBYN5Wb9TyNf
         6GqU/CikpFvNy+g7jzE+5M0EjQxcTmWk7OxrDi3nsCaQSjwHkqB6LQwt4aT7oiBYLIxf
         6qDyXfNfW77+yBUX8CoAfE7CQ6o8jwkqMD4aM/C2jBoTtRzavn8XletlmQJbR7vske2S
         bvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=1t8RKux0b3auTyo3EU4Fjza8Z8XyMBYSPlq98c5flic=;
        b=dmOh1MWzxVA1gyO1xgET0VTRLenltqnchQEaGqNg1smdwlkHrd3zHvaw8WDY2i1j0A
         ByHCWa1T2BlFwKUNGDkuNXsKSjJRMlgq2uUze+Vo4YqdfA9Jncketq1uQGHuTKS5Fmrg
         zeWvXJLS/CvAMg7KhcHwl3AcRi3CGJekxnrsMOoISgR1AQPuNojge9dX+DnJ0VkDbM+5
         1013URNhr1ovIOcdh8OIyqg7MVMKsq+6WFH0Ms9spfAm9P1NVmMsyDbq+G22+1S7EnzP
         vHIedRjhlntZHKxd5GgSQ8RC4h+oHNbHKyu8Hmbyy7vq9TYJv4bbMqrQNXSblxO6CiB6
         cZUQ==
X-Gm-Message-State: APjAAAVKKz2ejo6Zqydxfc2EQH2HWSov5sbzOtO/Gq5ctVA/VtjVEgVN
        s51WvwJx4vPHetADumR2b38=
X-Google-Smtp-Source: APXvYqxlFS6lvb5mBA/RJA/yrpoHPmKtHhrVFCS4pgKnF8Uke2A+7VWsTMCrKWkhLoaeJouFKBHi7w==
X-Received: by 2002:a7b:c857:: with SMTP id c23mr33536520wml.51.1567367386985;
        Sun, 01 Sep 2019 12:49:46 -0700 (PDT)
Received: from noxium ([86.124.23.129])
        by smtp.gmail.com with ESMTPSA id f75sm17153683wmf.2.2019.09.01.12.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2019 12:49:46 -0700 (PDT)
Message-ID: <5124dd295d2b5fb934ad567fbe19b2f6b37a8372.camel@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Set SAI Channel Mode to Output Mode
From:   Cosmin-Gabriel Samoila <gabrielcsmo@gmail.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>, broonie@kernel.org
Cc:     festevam@gmail.com, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        shengjiu.wang@nxp.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, timur@kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
Date:   Sun, 01 Sep 2019 22:49:44 +0300
In-Reply-To: <20190830225514.5283-1-daniel.baluta@nxp.com>
References: <20190830225514.5283-1-daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me!

Best regards,
Cosmin

On Sat, 2019-08-31 at 01:55 +0300, Daniel Baluta wrote:
> From SAI datasheet:
> 
> CHMOD, configures if transmit data pins are configured for TDM mode
> or Output mode.
> 	* (0) TDM mode, transmit data pins are tri-stated when slots
> are
> 	masked or channels are disabled.
> 	* (1) Output mode, transmit data pins are never tri-stated and
> 	will output zero when slots are masked or channels are
> disabled.
> 
> When data pins are tri-stated, there is noise on some channels
> when FS clock value is high and data is read while fsclk is
> transitioning from high to low.
> 
> Fix this by setting CHMOD to Output Mode so that pins will output
> zero
> when slots are masked or channels are disabled.
> 
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Signed-off-by: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  sound/soc/fsl/fsl_sai.c | 15 ++++++++++++---
>  sound/soc/fsl/fsl_sai.h |  2 ++
>  2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index e896b577b1f7..b9daab0eb6eb 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -467,6 +467,12 @@ static int fsl_sai_hw_params(struct
> snd_pcm_substream *substream,
>  
>  	val_cr4 |= FSL_SAI_CR4_FRSZ(slots);
>  
> +	/*
> +	 * set CHMOD to Output Mode so that transmit data pins will
> +	 * output zero when slots are masked or channels are disabled
> +	 */
> +	val_cr4 |= FSL_SAI_CR4_CHMOD;
> +
>  	/*
>  	 * For SAI master mode, when Tx(Rx) sync with Rx(Tx) clock,
> Rx(Tx) will
>  	 * generate bclk and frame clock for Tx(Rx), we should set
> RCR4(TCR4),
> @@ -477,7 +483,8 @@ static int fsl_sai_hw_params(struct
> snd_pcm_substream *substream,
>  	if (!sai->is_slave_mode) {
>  		if (!sai->synchronous[TX] && sai->synchronous[RX] &&
> !tx) {
>  			regmap_update_bits(sai->regmap,
> FSL_SAI_TCR4(ofs),
> -				FSL_SAI_CR4_SYWD_MASK |
> FSL_SAI_CR4_FRSZ_MASK,
> +				FSL_SAI_CR4_SYWD_MASK |
> FSL_SAI_CR4_FRSZ_MASK |
> +				FSL_SAI_CR4_CHMOD_MASK,
>  				val_cr4);
>  			regmap_update_bits(sai->regmap,
> FSL_SAI_TCR5(ofs),
>  				FSL_SAI_CR5_WNW_MASK |
> FSL_SAI_CR5_W0W_MASK |
> @@ -486,7 +493,8 @@ static int fsl_sai_hw_params(struct
> snd_pcm_substream *substream,
>  				~0UL - ((1 << channels) - 1));
>  		} else if (!sai->synchronous[RX] && sai-
> >synchronous[TX] && tx) {
>  			regmap_update_bits(sai->regmap,
> FSL_SAI_RCR4(ofs),
> -				FSL_SAI_CR4_SYWD_MASK |
> FSL_SAI_CR4_FRSZ_MASK,
> +				FSL_SAI_CR4_SYWD_MASK |
> FSL_SAI_CR4_FRSZ_MASK |
> +				FSL_SAI_CR4_CHMOD_MASK,
>  				val_cr4);
>  			regmap_update_bits(sai->regmap,
> FSL_SAI_RCR5(ofs),
>  				FSL_SAI_CR5_WNW_MASK |
> FSL_SAI_CR5_W0W_MASK |
> @@ -497,7 +505,8 @@ static int fsl_sai_hw_params(struct
> snd_pcm_substream *substream,
>  	}
>  
>  	regmap_update_bits(sai->regmap, FSL_SAI_xCR4(tx, ofs),
> -			   FSL_SAI_CR4_SYWD_MASK |
> FSL_SAI_CR4_FRSZ_MASK,
> +			   FSL_SAI_CR4_SYWD_MASK |
> FSL_SAI_CR4_FRSZ_MASK |
> +			   FSL_SAI_CR4_CHMOD_MASK,
>  			   val_cr4);
>  	regmap_update_bits(sai->regmap, FSL_SAI_xCR5(tx, ofs),
>  			   FSL_SAI_CR5_WNW_MASK | FSL_SAI_CR5_W0W_MASK
> |
> diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
> index f96f8d97489d..1e3b4a6889a8 100644
> --- a/sound/soc/fsl/fsl_sai.h
> +++ b/sound/soc/fsl/fsl_sai.h
> @@ -119,6 +119,8 @@
>  #define FSL_SAI_CR4_FRSZ_MASK	(0x1f << 16)
>  #define FSL_SAI_CR4_SYWD(x)	(((x) - 1) << 8)
>  #define FSL_SAI_CR4_SYWD_MASK	(0x1f << 8)
> +#define FSL_SAI_CR4_CHMOD	BIT(5)
> +#define FSL_SAI_CR4_CHMOD_MASK	GENMASK(5, 5)
>  #define FSL_SAI_CR4_MF		BIT(4)
>  #define FSL_SAI_CR4_FSE		BIT(3)
>  #define FSL_SAI_CR4_FSP		BIT(1)

