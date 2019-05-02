Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A7EC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018D820873
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfEBIZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 04:25:31 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:59975 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfEBIZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 04:25:30 -0400
Received: from localhost (aaubervilliers-681-1-29-145.w90-88.abo.wanadoo.fr [90.88.149.145])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 879AE100015;
        Thu,  2 May 2019 08:25:26 +0000 (UTC)
Date:   Thu, 2 May 2019 10:25:26 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 2/5] ASoC: sun4i-spdif: Add support for H6 SoC
Message-ID: <20190502082526.c5zo4uzceqzizbxo@flea>
References: <20190419191730.9437-1-peron.clem@gmail.com>
 <20190419191730.9437-3-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wid6745ec7776hfu"
Content-Disposition: inline
In-Reply-To: <20190419191730.9437-3-peron.clem@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wid6745ec7776hfu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2019 at 09:17:27PM +0200, Cl=E9ment P=E9ron wrote:
> Allwinner H6 has a different mapping for the fifo register controller.
>
> Actually only the fifo tx flush bit is used.
>
> Add a new quirk to know the correct fifo tx flush bit.
>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-spdif.c | 42 ++++++++++++++++++++++++++++++-----
>  1 file changed, 36 insertions(+), 6 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
> index b4af4aabead1..19e4bf9caa24 100644
> --- a/sound/soc/sunxi/sun4i-spdif.c
> +++ b/sound/soc/sunxi/sun4i-spdif.c
> @@ -75,6 +75,18 @@
>  	#define SUN4I_SPDIF_FCTL_RXOM(v)		((v) << 0)
>  	#define SUN4I_SPDIF_FCTL_RXOM_MASK		GENMASK(1, 0)
>
> +#define SUN50I_H6_SPDIF_FCTL (0x14)
> +	#define SUN50I_H6_SPDIF_FCTL_HUB_EN		BIT(31)
> +	#define SUN50I_H6_SPDIF_FCTL_FTX		BIT(30)
> +	#define SUN50I_H6_SPDIF_FCTL_FRX		BIT(29)
> +	#define SUN50I_H6_SPDIF_FCTL_TXTL(v)		((v) << 12)
> +	#define SUN50I_H6_SPDIF_FCTL_TXTL_MASK		GENMASK(19, 12)
> +	#define SUN50I_H6_SPDIF_FCTL_RXTL(v)		((v) << 4)
> +	#define SUN50I_H6_SPDIF_FCTL_RXTL_MASK		GENMASK(10, 4)
> +	#define SUN50I_H6_SPDIF_FCTL_TXIM		BIT(2)
> +	#define SUN50I_H6_SPDIF_FCTL_RXOM(v)		((v) << 0)
> +	#define SUN50I_H6_SPDIF_FCTL_RXOM_MASK		GENMASK(1, 0)
> +
>  #define SUN4I_SPDIF_FSTA	(0x18)
>  	#define SUN4I_SPDIF_FSTA_TXE			BIT(14)
>  	#define SUN4I_SPDIF_FSTA_TXECNTSHT		(8)
> @@ -169,16 +181,25 @@ struct sun4i_spdif_dev {
>  	struct snd_soc_dai_driver cpu_dai_drv;
>  	struct regmap *regmap;
>  	struct snd_dmaengine_dai_dma_data dma_params_tx;
> +	const struct sun4i_spdif_quirks *quirks;

I guess this will generate a warning since the structure hasn't been
defined yet?

> +};
> +
> +struct sun4i_spdif_quirks {
> +	unsigned int reg_dac_txdata;	/* TX FIFO offset for DMA config */
> +	unsigned int reg_fctl_ftx;	/* TX FIFO flush bitmask */
> +	bool has_reset;

You don't really need to move it around, you can just add the
structure prototype.

If you do want to move it around, then please do so in a separate patch

>  };
>
>  static void sun4i_spdif_configure(struct sun4i_spdif_dev *host)
>  {
> +	const struct sun4i_spdif_quirks *quirks =3D host->quirks;
> +
>  	/* soft reset SPDIF */
>  	regmap_write(host->regmap, SUN4I_SPDIF_CTL, SUN4I_SPDIF_CTL_RESET);
>
>  	/* flush TX FIFO */
>  	regmap_update_bits(host->regmap, SUN4I_SPDIF_FCTL,
> -			   SUN4I_SPDIF_FCTL_FTX, SUN4I_SPDIF_FCTL_FTX);
> +			   quirks->reg_fctl_ftx, quirks->reg_fctl_ftx);
>
>  	/* clear TX counter */
>  	regmap_write(host->regmap, SUN4I_SPDIF_TXCNT, 0);
> @@ -405,22 +426,26 @@ static struct snd_soc_dai_driver sun4i_spdif_dai =
=3D {
>  	.name =3D "spdif",
>  };
>
> -struct sun4i_spdif_quirks {
> -	unsigned int reg_dac_txdata;	/* TX FIFO offset for DMA config */
> -	bool has_reset;
> -};
> -
>  static const struct sun4i_spdif_quirks sun4i_a10_spdif_quirks =3D {
>  	.reg_dac_txdata	=3D SUN4I_SPDIF_TXFIFO,
> +	.reg_fctl_ftx   =3D SUN4I_SPDIF_FCTL_FTX,
>  };
>
>  static const struct sun4i_spdif_quirks sun6i_a31_spdif_quirks =3D {
>  	.reg_dac_txdata	=3D SUN4I_SPDIF_TXFIFO,
> +	.reg_fctl_ftx   =3D SUN4I_SPDIF_FCTL_FTX,
>  	.has_reset	=3D true,
>  };
>
>  static const struct sun4i_spdif_quirks sun8i_h3_spdif_quirks =3D {
>  	.reg_dac_txdata	=3D SUN8I_SPDIF_TXFIFO,
> +	.reg_fctl_ftx   =3D SUN4I_SPDIF_FCTL_FTX,
> +	.has_reset	=3D true,
> +};
>
> +static const struct sun4i_spdif_quirks sun50i_h6_spdif_quirks =3D {
> +	.reg_dac_txdata	=3D SUN8I_SPDIF_TXFIFO,
> +	.reg_fctl_ftx   =3D SUN50I_H6_SPDIF_FCTL_FTX,
>  	.has_reset	=3D true,

The reg_dac_txdata and reg_fctl_ftx changes here should also be part
of a separate patch.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--wid6745ec7776hfu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXMqpdgAKCRDj7w1vZxhR
xWH5AP0V7WwgeoLzp2Jy/IqaN2gkHTAxsL4rN9x34ddtQ9CO2AEA9tdoCjIN+Pu8
eH0aZZcT+yIqU0dkGQCUJfpkZdUMZQE=
=bqND
-----END PGP SIGNATURE-----

--wid6745ec7776hfu--
