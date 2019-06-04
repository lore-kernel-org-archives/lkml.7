Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75A3C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9841224CF0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfFDHtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 03:49:49 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:55043 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfFDHtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:49:49 -0400
Received: from localhost (aaubervilliers-681-1-24-139.w90-88.abo.wanadoo.fr [90.88.144.139])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id B8E6B10000A;
        Tue,  4 Jun 2019 07:49:40 +0000 (UTC)
Date:   Tue, 4 Jun 2019 09:49:40 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     codekipper@gmail.com
Cc:     wens@csie.org, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it
Subject: Re: [PATCH v4 5/9] ASoC: sun4i-i2s: Add set_tdm_slot functionality
Message-ID: <20190604074940.pwzggjluksv7xxel@flea>
References: <20190603174735.21002-1-codekipper@gmail.com>
 <20190603174735.21002-6-codekipper@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ld4z4b6632jtjjwn"
Content-Disposition: inline
In-Reply-To: <20190603174735.21002-6-codekipper@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ld4z4b6632jtjjwn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 03, 2019 at 07:47:31PM +0200, codekipper@gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> Some codecs require a different amount of a bit clocks per frame than

Which codec? And what are the actual requirements?

> what is calculated by the sample width. Use the tdm slot bindings to
> provide this mechanism.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 329883750d6f..bca73b3c0d74 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -186,6 +186,9 @@ struct sun4i_i2s {
>  	struct regmap_field	*field_rxchansel;
>
>  	const struct sun4i_i2s_quirks	*variant;
> +
> +	unsigned int	tdm_slots;
> +	unsigned int	slot_width;
>  };
>
>  struct sun4i_i2s_clk_div {
> @@ -337,7 +340,7 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
>  	if (i2s->variant->is_h3_i2s_based)
>  		regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
>  				   SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
> -				   SUN8I_I2S_FMT0_LRCK_PERIOD(32));
> +				   SUN8I_I2S_FMT0_LRCK_PERIOD(word_size));

This is an unrelated change, it should be in a separate patch.

>
>  	/* Set sign extension to pad out LSB with 0 */
>  	regmap_field_write(i2s->field_fmt_sext, 0);
> @@ -414,7 +417,8 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
>  			   sr + i2s->variant->fmt_offset);
>
>  	return sun4i_i2s_set_clk_rate(dai, params_rate(params),
> -				      params_width(params));
> +				      i2s->tdm_slots ?
> +				      i2s->slot_width : params_width(params));
>  }
>
>  static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
> @@ -657,11 +661,25 @@ static int sun4i_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
>  	return 0;
>  }
>
> +static int sun4i_i2s_set_dai_tdm_slot(struct snd_soc_dai *dai,
> +	unsigned int tx_mask, unsigned int rx_mask,
> +	int slots, int width)

The alignment after the wraping should be at the opening parenthesis.

> +{
> +	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
> +
> +	i2s->tdm_slots = slots;
> +
> +	i2s->slot_width = width;
> +
> +	return 0;
> +}
> +
>  static const struct snd_soc_dai_ops sun4i_i2s_dai_ops = {
>  	.hw_params	= sun4i_i2s_hw_params,
>  	.set_fmt	= sun4i_i2s_set_fmt,
>  	.set_sysclk	= sun4i_i2s_set_sysclk,
>  	.trigger	= sun4i_i2s_trigger,
> +	.set_tdm_slot	= sun4i_i2s_set_dai_tdm_slot,

Please sort them by alphabetical order.

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ld4z4b6632jtjjwn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXPYilAAKCRDj7w1vZxhR
xYXiAP0bXRYymU/3+ZTKYuLhieHKCw+su1ZTlL8VmZhDNotmdQD+PVY0AsWtlw/f
1o88nw8RTpP0U6hdQ3I6QSx5EAHp6Ao=
=vM/5
-----END PGP SIGNATURE-----

--ld4z4b6632jtjjwn--
