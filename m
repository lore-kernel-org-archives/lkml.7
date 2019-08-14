Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC16FC0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B718A2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltlAGtUz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfHNIiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 04:38:19 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50391 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfHNIiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 04:38:18 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so3817445wml.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 01:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ss3ykB/e733BEBWwIVPUSJTuhl3UWTyezbyVNGjf0SI=;
        b=ltlAGtUzyH1E/WYoIuA6t1M2IYW9GB6+wHg+pt3UbEcSyIMm9pb3pGRW1Ae3yqG4oS
         S4triQ/F5H3FxXdqdmb0vJH9CknjXq85n5nyHbEtoLpo3Ua0dAA6jegPSpx+yDRp0lKy
         qe8G+KWp4kv9XYXxiZNFwLuH2WxKSF9NNExeYJjKzXvSEfDSFNl0VyHQ9SEehpTqJrIa
         7qP2eVA1kQUX3d4uopEnXlj67HQceSPs3oLiE5i2IZWaMGD165T9w5JG/fFwIEqtiJGY
         tYDL9LzCm9CmWYzmFyk68qYLBmRc995t/wAEOmRfyUARzDaZJ6PcZFQOq+XpL4h5q1to
         V7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ss3ykB/e733BEBWwIVPUSJTuhl3UWTyezbyVNGjf0SI=;
        b=ghxnEA8byNidlGfr6jWQDIxtaPouNheKD3rKbWPc85twfeT3doQrVbPIOHEErTZ41B
         KboWrEwTFl58k6taeDwGYWKRG6EcoU7mqWXHDR7VAnqd7Xc12sZO6hK/ZBTBJoXe3ZRY
         LV2RSkBO3Z97T9IdyXiYZvu1zEu4wQJwIa0kTQtzP9cIKyiQbrZHNdpzOZy56tnPRMX/
         geH6LrfHDyUoSCn1hpYHijiV5Hc57htjEdcGGcnUmMWl/THwkPLWIf2zxJno4cDRcN3h
         d4b0ig/PeC6QO78iiskHaoyovw3Hch8dGUU4OSN682RM4YhorVr6eaOqi4eVICCxBGCm
         3uUA==
X-Gm-Message-State: APjAAAVh9mTrnC0mJhUpKubLz7/SvnWRPSv2pUkqK3dE1n6d9pfR/AZ1
        R+hGhLgAAQfVbnldT9Qi1ws=
X-Google-Smtp-Source: APXvYqxfBzQeFDvyuR2DGLqjv3kSBQPokkChEo3r8QnrPwWXcv7zOtPSRRB3fWQpU3jEfo1e6gz0QQ==
X-Received: by 2002:a7b:c651:: with SMTP id q17mr6661342wmk.136.1565771874804;
        Wed, 14 Aug 2019 01:37:54 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net. [89.212.178.211])
        by smtp.gmail.com with ESMTPSA id u130sm6528950wmg.28.2019.08.14.01.37.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 01:37:53 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-sunxi@googlegroups.com, codekipper@gmail.com
Cc:     maxime.ripard@free-electrons.com, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it
Subject: Re: [linux-sunxi] [PATCH v5 15/15] ASoC: sun4i-i2s: Adjust regmap settings
Date:   Wed, 14 Aug 2019 10:37:52 +0200
Message-ID: <3741744.8c7tOhJ1tT@jernej-laptop>
In-Reply-To: <20190814060854.26345-16-codekipper@gmail.com>
References: <20190814060854.26345-1-codekipper@gmail.com> <20190814060854.26345-16-codekipper@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne sreda, 14. avgust 2019 ob 08:08:54 CEST je codekipper@gmail.com 
napisal(a):
> From: Marcus Cooper <codekipper@gmail.com>
> 
> Bypass the regmap cache when flushing the i2s FIFOs and modify the tables
> to reflect this.
> 
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 31 ++++++++++---------------------
>  1 file changed, 10 insertions(+), 21 deletions(-)
> 
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index d3c8789f70bb..ecfc1ed79379 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -876,9 +876,11 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai,
> unsigned int fmt) static void sun4i_i2s_start_capture(struct sun4i_i2s
> *i2s)
>  {
>  	/* Flush RX FIFO */
> +	regcache_cache_bypass(i2s->regmap, true);
>  	regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
>  			   SUN4I_I2S_FIFO_CTRL_FLUSH_RX,
>  			   SUN4I_I2S_FIFO_CTRL_FLUSH_RX);
> +	regcache_cache_bypass(i2s->regmap, false);

Did you try with regmap_write_bits() instead? This function will 
unconditionally write bits so it's nicer solution, because you don't have to 
use regcache_cache_bypass().

> 
>  	/* Clear RX counter */
>  	regmap_write(i2s->regmap, SUN4I_I2S_RX_CNT_REG, 0);
> @@ -897,9 +899,11 @@ static void sun4i_i2s_start_capture(struct sun4i_i2s
> *i2s) static void sun4i_i2s_start_playback(struct sun4i_i2s *i2s)
>  {
>  	/* Flush TX FIFO */
> +	regcache_cache_bypass(i2s->regmap, true);
>  	regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
>  			   SUN4I_I2S_FIFO_CTRL_FLUSH_TX,
>  			   SUN4I_I2S_FIFO_CTRL_FLUSH_TX);
> +	regcache_cache_bypass(i2s->regmap, false);

Ditto.

> 
>  	/* Clear TX counter */
>  	regmap_write(i2s->regmap, SUN4I_I2S_TX_CNT_REG, 0);
> @@ -1053,13 +1057,7 @@ static const struct snd_soc_component_driver
> sun4i_i2s_component = {
> 
>  static bool sun4i_i2s_rd_reg(struct device *dev, unsigned int reg)
>  {
> -	switch (reg) {
> -	case SUN4I_I2S_FIFO_TX_REG:
> -		return false;
> -
> -	default:
> -		return true;
> -	}
> +	return true;

Why did you change this? Manual mentions that SUN4I_I2S_FIFO_TX_REG is write-
only register. Even if it can be read, then it's better to remove whole 
function, which will automatically mean that all registers can be read.


>  }
> 
>  static bool sun4i_i2s_wr_reg(struct device *dev, unsigned int reg)
> @@ -1078,6 +1076,8 @@ static bool sun4i_i2s_volatile_reg(struct device *dev,
> unsigned int reg) {
>  	switch (reg) {
>  	case SUN4I_I2S_FIFO_RX_REG:
> +	case SUN4I_I2S_FIFO_TX_REG:
> +	case SUN4I_I2S_FIFO_STA_REG:
>  	case SUN4I_I2S_INT_STA_REG:
>  	case SUN4I_I2S_RX_CNT_REG:
>  	case SUN4I_I2S_TX_CNT_REG:

SUN4I_I2S_FIFO_CTRL_REG should be put here, because it has two bits which 
returns to 0 immediately after they are set to 1.

Best regards,
Jernej

> @@ -1088,23 +1088,12 @@ static bool sun4i_i2s_volatile_reg(struct device
> *dev, unsigned int reg) }
>  }
> 
> -static bool sun8i_i2s_rd_reg(struct device *dev, unsigned int reg)
> -{
> -	switch (reg) {
> -	case SUN8I_I2S_FIFO_TX_REG:
> -		return false;
> -
> -	default:
> -		return true;
> -	}
> -}
> -
>  static bool sun8i_i2s_volatile_reg(struct device *dev, unsigned int reg)
>  {
>  	if (reg == SUN8I_I2S_INT_STA_REG)
>  		return true;
>  	if (reg == SUN8I_I2S_FIFO_TX_REG)
> -		return false;
> +		return true;
> 
>  	return sun4i_i2s_volatile_reg(dev, reg);
>  }
> @@ -1175,7 +1164,7 @@ static const struct regmap_config
> sun8i_i2s_regmap_config = { .reg_defaults	= sun8i_i2s_reg_defaults,
>  	.num_reg_defaults	= ARRAY_SIZE(sun8i_i2s_reg_defaults),
>  	.writeable_reg	= sun4i_i2s_wr_reg,
> -	.readable_reg	= sun8i_i2s_rd_reg,
> +	.readable_reg	= sun4i_i2s_rd_reg,
>  	.volatile_reg	= sun8i_i2s_volatile_reg,
>  };
> 
> @@ -1188,7 +1177,7 @@ static const struct regmap_config
> sun50i_i2s_regmap_config = { .reg_defaults	= sun50i_i2s_reg_defaults,
>  	.num_reg_defaults	= ARRAY_SIZE(sun50i_i2s_reg_defaults),
>  	.writeable_reg	= sun4i_i2s_wr_reg,
> -	.readable_reg	= sun8i_i2s_rd_reg,
> +	.readable_reg	= sun4i_i2s_rd_reg,
>  	.volatile_reg	= sun8i_i2s_volatile_reg,
>  };




