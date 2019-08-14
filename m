Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB3BC0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D27205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfHNH5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 03:57:11 -0400
Received: from mailoutvs27.siol.net ([185.57.226.218]:39838 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725928AbfHNH5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 03:57:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 7965752410F;
        Wed, 14 Aug 2019 09:57:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id bAnz3fg4eXxG; Wed, 14 Aug 2019 09:57:05 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id C9244524113;
        Wed, 14 Aug 2019 09:57:05 +0200 (CEST)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 6A438524109;
        Wed, 14 Aug 2019 09:57:03 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     codekipper@gmail.com
Cc:     maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        be17068@iperbole.bo.it
Subject: Re: [PATCH v5 11/15] ASoC: sun4i-i2s: Add support for H6 I2S
Date:   Wed, 14 Aug 2019 09:57:02 +0200
Message-ID: <13079463.kjevBeenX1@jernej-laptop>
In-Reply-To: <20190814060854.26345-12-codekipper@gmail.com>
References: <20190814060854.26345-1-codekipper@gmail.com> <20190814060854.26345-12-codekipper@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne sreda, 14. avgust 2019 ob 08:08:50 CEST je codekipper@gmail.com 
napisal(a):
> From: Jernej Skrabec <jernej.skrabec@siol.net>
> 
> H6 I2S is very similar to that in H3, except it supports up to 16
> channels.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Your Signed-off-by is missing here and on all other patches made originally by 
me.

Best regards,
Jernej

> ---
>  sound/soc/sunxi/sun4i-i2s.c | 148 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 148 insertions(+)
> 
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 6de3cb41aaf6..a8d98696fe7c 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -121,6 +121,21 @@
>  #define SUN8I_I2S_RX_CHAN_SEL_REG	0x54
>  #define SUN8I_I2S_RX_CHAN_MAP_REG	0x58
> 
> +/* Defines required for sun50i-h6 support */
> +#define SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET_MASK	GENMASK(21, 20)
> +#define SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET(offset)	((offset) << 20)
> +#define SUN50I_H6_I2S_TX_CHAN_SEL_MASK		GENMASK(19, 16)
> +#define SUN50I_H6_I2S_TX_CHAN_SEL(chan)		((chan - 1) << 16)
> +#define SUN50I_H6_I2S_TX_CHAN_EN_MASK		GENMASK(15, 0)
> +#define SUN50I_H6_I2S_TX_CHAN_EN(num_chan)	(((1 << num_chan) - 1))
> +
> +#define SUN50I_H6_I2S_TX_CHAN_MAP0_REG	0x44
> +#define SUN50I_H6_I2S_TX_CHAN_MAP1_REG	0x48
> +
> +#define SUN50I_H6_I2S_RX_CHAN_SEL_REG	0x64
> +#define SUN50I_H6_I2S_RX_CHAN_MAP0_REG	0x68
> +#define SUN50I_H6_I2S_RX_CHAN_MAP1_REG	0x6C
> +
>  struct sun4i_i2s;
> 
>  /**
> @@ -440,6 +455,25 @@ static void sun8i_i2s_set_rxchanoffset(const struct
> sun4i_i2s *i2s) SUN8I_I2S_TX_CHAN_OFFSET(i2s->offset));
>  }
> 
> +static void sun50i_h6_i2s_set_txchanoffset(const struct sun4i_i2s *i2s, int
> output) +{
> +	if (output >= 0 && output < 4) {
> +		regmap_update_bits(i2s->regmap,
> +				   SUN8I_I2S_TX_CHAN_SEL_REG + 
(output * 4),
> +				   
SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET_MASK,
> +				   
SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET(i2s->offset));
> +	}
> +
> +}
> +
> +static void sun50i_h6_i2s_set_rxchanoffset(const struct sun4i_i2s *i2s)
> +{
> +	regmap_update_bits(i2s->regmap,
> +			   SUN50I_H6_I2S_RX_CHAN_SEL_REG,
> +			   SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET_MASK,
> +			   SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET(i2s-
>offset));
> +}
> +
>  static void sun8i_i2s_set_txchanen(const struct sun4i_i2s *i2s, int output,
> int channel)
>  {
> @@ -459,6 +493,26 @@ static void sun8i_i2s_set_rxchanen(const struct
> sun4i_i2s *i2s, int channel) SUN8I_I2S_TX_CHAN_EN(channel));
>  }
> 
> +
> +static void sun50i_h6_i2s_set_txchanen(const struct sun4i_i2s *i2s, int
> output, +				       int channel)
> +{
> +	if (output >= 0 && output < 4) {
> +		regmap_update_bits(i2s->regmap,
> +				   SUN8I_I2S_TX_CHAN_SEL_REG + 
(output * 4),
> +				   SUN50I_H6_I2S_TX_CHAN_EN_MASK,
> +				   
SUN50I_H6_I2S_TX_CHAN_EN(channel));
> +	}
> +}
> +
> +static void sun50i_h6_i2s_set_rxchanen(const struct sun4i_i2s *i2s, int
> channel) +{
> +	regmap_update_bits(i2s->regmap,
> +			   SUN50I_H6_I2S_RX_CHAN_SEL_REG,
> +			   SUN50I_H6_I2S_TX_CHAN_EN_MASK,
> +			   SUN50I_H6_I2S_TX_CHAN_EN(channel));
> +}
> +
>  static void sun4i_i2s_set_txchansel(const struct sun4i_i2s *i2s, int
> output, int channel)
>  {
> @@ -495,6 +549,25 @@ static void sun8i_i2s_set_rxchansel(const struct
> sun4i_i2s *i2s, int channel) SUN8I_I2S_TX_CHAN_SEL(channel));
>  }
> 
> +static void sun50i_h6_i2s_set_txchansel(const struct sun4i_i2s *i2s, int
> output, +				       int channel)
> +{
> +	if (output >= 0 && output < 4) {
> +		regmap_update_bits(i2s->regmap,
> +				   SUN8I_I2S_TX_CHAN_SEL_REG + 
(output * 4),
> +				   SUN50I_H6_I2S_TX_CHAN_SEL_MASK,
> +				   
SUN50I_H6_I2S_TX_CHAN_SEL(channel));
> +	}
> +}
> +
> +static void sun50i_h6_i2s_set_rxchansel(const struct sun4i_i2s *i2s, int
> channel) +{
> +	regmap_update_bits(i2s->regmap,
> +			   SUN50I_H6_I2S_RX_CHAN_SEL_REG,
> +			   SUN50I_H6_I2S_TX_CHAN_SEL_MASK,
> +			   SUN50I_H6_I2S_TX_CHAN_SEL(channel));
> +}
> +
>  static void sun4i_i2s_set_txchanmap(const struct sun4i_i2s *i2s, int
> output, int channel)
>  {
> @@ -520,6 +593,20 @@ static void sun8i_i2s_set_rxchanmap(const struct
> sun4i_i2s *i2s, int channel) regmap_write(i2s->regmap,
> SUN8I_I2S_RX_CHAN_MAP_REG, channel);
>  }
> 
> +static void sun50i_h6_i2s_set_txchanmap(const struct sun4i_i2s *i2s, int
> output, +				       int channel)
> +{
> +	if (output >= 0 && output < 4) {
> +		regmap_write(i2s->regmap,
> +			     SUN50I_H6_I2S_TX_CHAN_MAP1_REG + (output 
* 8), channel);
> +	}
> +}
> +
> +static void sun50i_h6_i2s_set_rxchanmap(const struct sun4i_i2s *i2s, int
> channel) +{
> +	regmap_write(i2s->regmap, SUN50I_H6_I2S_RX_CHAN_MAP1_REG, channel);
> +}
> +
>  static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
>  			       struct snd_pcm_hw_params *params,
>  			       struct snd_soc_dai *dai)
> @@ -996,6 +1083,22 @@ static const struct reg_default
> sun8i_i2s_reg_defaults[] = { { SUN8I_I2S_RX_CHAN_MAP_REG, 0x00000000 },
>  };
> 
> +static const struct reg_default sun50i_i2s_reg_defaults[] = {
> +	{ SUN4I_I2S_CTRL_REG, 0x00060000 },
> +	{ SUN4I_I2S_FMT0_REG, 0x00000033 },
> +	{ SUN4I_I2S_FMT1_REG, 0x00000030 },
> +	{ SUN4I_I2S_FIFO_CTRL_REG, 0x000400f0 },
> +	{ SUN4I_I2S_DMA_INT_CTRL_REG, 0x00000000 },
> +	{ SUN4I_I2S_CLK_DIV_REG, 0x00000000 },
> +	{ SUN8I_I2S_CHAN_CFG_REG, 0x00000000 },
> +	{ SUN8I_I2S_TX_CHAN_SEL_REG, 0x00000000 },
> +	{ SUN50I_H6_I2S_TX_CHAN_MAP0_REG, 0x00000000 },
> +	{ SUN50I_H6_I2S_TX_CHAN_MAP1_REG, 0x00000000 },
> +	{ SUN50I_H6_I2S_RX_CHAN_SEL_REG, 0x00000000 },
> +	{ SUN50I_H6_I2S_RX_CHAN_MAP0_REG, 0x00000000 },
> +	{ SUN50I_H6_I2S_RX_CHAN_MAP1_REG, 0x00000000 },
> +};
> +
>  static const struct regmap_config sun4i_i2s_regmap_config = {
>  	.reg_bits	= 32,
>  	.reg_stride	= 4,
> @@ -1023,6 +1126,19 @@ static const struct regmap_config
> sun8i_i2s_regmap_config = { .volatile_reg	= sun8i_i2s_volatile_reg,
>  };
> 
> +static const struct regmap_config sun50i_i2s_regmap_config = {
> +	.reg_bits	= 32,
> +	.reg_stride	= 4,
> +	.val_bits	= 32,
> +	.max_register	= SUN50I_H6_I2S_RX_CHAN_MAP1_REG,
> +	.cache_type	= REGCACHE_FLAT,
> +	.reg_defaults	= sun50i_i2s_reg_defaults,
> +	.num_reg_defaults	= ARRAY_SIZE(sun50i_i2s_reg_defaults),
> +	.writeable_reg	= sun4i_i2s_wr_reg,
> +	.readable_reg	= sun8i_i2s_rd_reg,
> +	.volatile_reg	= sun8i_i2s_volatile_reg,
> +};
> +
>  static int sun4i_i2s_runtime_resume(struct device *dev)
>  {
>  	struct sun4i_i2s *i2s = dev_get_drvdata(dev);
> @@ -1197,6 +1313,34 @@ static const struct sun4i_i2s_quirks
> sun50i_a64_codec_i2s_quirks = { .set_rxchanmap		= 
sun4i_i2s_set_rxchanmap,
>  };
> 
> +static const struct sun4i_i2s_quirks sun50i_h6_i2s_quirks = {
> +	.has_reset		= true,
> +	.reg_offset_txdata	= SUN8I_I2S_FIFO_TX_REG,
> +	.sun4i_i2s_regmap	= &sun50i_i2s_regmap_config,
> +	.has_fmt_set_lrck_period = true,
> +	.has_chcfg		= true,
> +	.has_chsel_tx_chen	= true,
> +	.has_chsel_offset	= true,
> +	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 8, 8),
> +	.field_fmt_wss		= REG_FIELD(SUN4I_I2S_FMT0_REG, 
0, 2),
> +	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 6),
> +	.field_fmt_bclk		= REG_FIELD(SUN4I_I2S_FMT0_REG, 
7, 7),
> +	.field_fmt_lrclk	= REG_FIELD(SUN4I_I2S_FMT0_REG, 19, 19),
> +	.field_fmt_mode		= REG_FIELD(SUN4I_I2S_CTRL_REG, 4, 
5),
> +	.field_fmt_sext		= REG_FIELD(SUN4I_I2S_FMT1_REG, 
4, 5),
> +	.get_sr			= sun8i_i2s_get_sr_wss,
> +	.get_wss		= sun8i_i2s_get_sr_wss,
> +	.set_format		= sun8i_i2s_set_format,
> +	.set_txchanoffset	= sun50i_h6_i2s_set_txchanoffset,
> +	.set_rxchanoffset	= sun50i_h6_i2s_set_rxchanoffset,
> +	.set_txchanen		= sun50i_h6_i2s_set_txchanen,
> +	.set_rxchanen		= sun50i_h6_i2s_set_rxchanen,
> +	.set_txchansel		= sun50i_h6_i2s_set_txchansel,
> +	.set_rxchansel		= sun50i_h6_i2s_set_rxchansel,
> +	.set_txchanmap		= sun50i_h6_i2s_set_txchanmap,
> +	.set_rxchanmap		= sun50i_h6_i2s_set_rxchanmap,
> +};
> +
>  static int sun4i_i2s_init_regmap_fields(struct device *dev,
>  					struct sun4i_i2s *i2s)
>  {
> @@ -1389,6 +1533,10 @@ static const struct of_device_id sun4i_i2s_match[] =
> { .compatible = "allwinner,sun50i-a64-codec-i2s",
>  		.data = &sun50i_a64_codec_i2s_quirks,
>  	},
> +	{
> +		.compatible = "allwinner,sun50i-h6-i2s",
> +		.data = &sun50i_h6_i2s_quirks,
> +	},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, sun4i_i2s_match);




