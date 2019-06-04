Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C659BC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E3E24D3D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfFDH6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 03:58:46 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:46343 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfFDH6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:58:45 -0400
X-Originating-IP: 90.88.144.139
Received: from localhost (aaubervilliers-681-1-24-139.w90-88.abo.wanadoo.fr [90.88.144.139])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id C485B1BF209;
        Tue,  4 Jun 2019 07:58:40 +0000 (UTC)
Date:   Tue, 4 Jun 2019 09:58:40 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     codekipper@gmail.com
Cc:     wens@csie.org, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it
Subject: Re: [PATCH v4 6/9] ASoC: sun4i-i2s: Add multi-lane functionality
Message-ID: <20190604075840.kquy3zcuckuzmvzr@flea>
References: <20190603174735.21002-1-codekipper@gmail.com>
 <20190603174735.21002-7-codekipper@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nyo2exzeeeog6q2h"
Content-Disposition: inline
In-Reply-To: <20190603174735.21002-7-codekipper@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nyo2exzeeeog6q2h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 03, 2019 at 07:47:32PM +0200, codekipper@gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> The i2s block supports multi-lane i2s output however this functionality
> is only possible in earlier SoCs where the pins are exposed and for
> the i2s block used for HDMI audio on the later SoCs.
>
> To enable this functionality, an optional property has been added to
> the bindings.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

I'd like to have Mark's input on this, but I'm really worried about
the interaction with the proper TDM support.

Our fundamental issue is that the controller can have up to 8
channels, but either on 4 lines (instead of 1), or 8 channels on 1
(like proper TDM) (or any combination between the two, but that should
be pretty rare).

You're trying to do the first one, and I'm trying to do the second one.

There's a number of assumptions later on that will break the TDM case,
see below for examples

> ---
>  sound/soc/sunxi/sun4i-i2s.c | 44 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 39 insertions(+), 5 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index bca73b3c0d74..75217fb52bfa 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -23,7 +23,7 @@
>
>  #define SUN4I_I2S_CTRL_REG		0x00
>  #define SUN4I_I2S_CTRL_SDO_EN_MASK		GENMASK(11, 8)
> -#define SUN4I_I2S_CTRL_SDO_EN(sdo)			BIT(8 + (sdo))
> +#define SUN4I_I2S_CTRL_SDO_EN(lines)		(((1 << lines) - 1) << 8)
>  #define SUN4I_I2S_CTRL_MODE_MASK		BIT(5)
>  #define SUN4I_I2S_CTRL_MODE_SLAVE			(1 << 5)
>  #define SUN4I_I2S_CTRL_MODE_MASTER			(0 << 5)
> @@ -355,14 +355,23 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
>  	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
>  	int sr, wss, channels;
>  	u32 width;
> +	int lines;
>
>  	channels = params_channels(params);
> -	if (channels != 2) {
> +	if ((channels > dai->driver->playback.channels_max) ||
> +		(channels < dai->driver->playback.channels_min)) {
>  		dev_err(dai->dev, "Unsupported number of channels: %d\n",
>  			channels);
>  		return -EINVAL;
>  	}
>
> +	lines = (channels + 1) / 2;
> +
> +	/* Enable the required output lines */
> +	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
> +			   SUN4I_I2S_CTRL_SDO_EN_MASK,
> +			   SUN4I_I2S_CTRL_SDO_EN(lines));
> +

This has the assumption that each line will have 2 channels, which is wrong.

>  	if (i2s->variant->is_h3_i2s_based) {
>  		regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
>  				   SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM_MASK,
> @@ -373,8 +382,19 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
>  	}
>
>  	/* Map the channels for playback and capture */
> -	regmap_field_write(i2s->field_txchanmap, 0x76543210);
>  	regmap_field_write(i2s->field_rxchanmap, 0x00003210);
> +	regmap_field_write(i2s->field_txchanmap, 0x10);
> +	if (i2s->variant->is_h3_i2s_based) {
> +		if (channels > 2)
> +			regmap_write(i2s->regmap,
> +				     SUN8I_I2S_TX_CHAN_MAP_REG+4, 0x32);
> +		if (channels > 4)
> +			regmap_write(i2s->regmap,
> +				     SUN8I_I2S_TX_CHAN_MAP_REG+8, 0x54);
> +		if (channels > 6)
> +			regmap_write(i2s->regmap,
> +				     SUN8I_I2S_TX_CHAN_MAP_REG+12, 0x76);
> +	}

And this creates a mapping matching that.

>  	/* Configure the channels */
>  	regmap_field_write(i2s->field_txchansel,
> @@ -1057,9 +1077,10 @@ static int sun4i_i2s_init_regmap_fields(struct device *dev,
>  static int sun4i_i2s_probe(struct platform_device *pdev)
>  {
>  	struct sun4i_i2s *i2s;
> +	struct snd_soc_dai_driver *soc_dai;
>  	struct resource *res;
>  	void __iomem *regs;
> -	int irq, ret;
> +	int irq, ret, val;
>
>  	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
>  	if (!i2s)
> @@ -1126,6 +1147,19 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
>  	i2s->capture_dma_data.addr = res->start + SUN4I_I2S_FIFO_RX_REG;
>  	i2s->capture_dma_data.maxburst = 8;
>
> +	soc_dai = devm_kmemdup(&pdev->dev, &sun4i_i2s_dai,
> +			       sizeof(*soc_dai), GFP_KERNEL);
> +	if (!soc_dai) {
> +		ret = -ENOMEM;
> +		goto err_pm_disable;
> +	}
> +
> +	if (!of_property_read_u32(pdev->dev.of_node,
> +				  "allwinner,playback-channels", &val)) {
> +		if (val >= 2 && val <= 8)
> +			soc_dai->playback.channels_max = val;
> +	}
> +

I'm not quite sure how this works.

of_property_read_u32 will return 0, so you will enter in the
condition. But what happens if the property is missing?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nyo2exzeeeog6q2h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXPYksAAKCRDj7w1vZxhR
xYBQAQCYX/Uu2lP7J+mcD5tFPBbgLuQ9PtE3e9B6ovbn9juZOQEA3+ZUzorIBacX
S9cvpP0cRQzxe6STHA66H3PfQRHFDA0=
=qzcv
-----END PGP SIGNATURE-----

--nyo2exzeeeog6q2h--
