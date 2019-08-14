Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2065EC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025362133F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfHNLIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 07:08:43 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:48069 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfHNLIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 07:08:42 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 055BE240006;
        Wed, 14 Aug 2019 11:08:36 +0000 (UTC)
Date:   Wed, 14 Aug 2019 09:13:43 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     codekipper@gmail.com
Cc:     wens@csie.org, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it
Subject: Re: [PATCH v5 03/15] ASoC: sun4i-i2s: Correct divider calculations
Message-ID: <20190814071343.vvjbozrmv5ionwnf@flea>
References: <20190814060854.26345-1-codekipper@gmail.com>
 <20190814060854.26345-4-codekipper@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bamdgrdnwpokqt4x"
Content-Disposition: inline
In-Reply-To: <20190814060854.26345-4-codekipper@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bamdgrdnwpokqt4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

(I just noticed this, but can you update my mail address, it's not
@free-electrons for quite a while, you probably want to change your
scripts to use mripard@kernel.org)

On Wed, Aug 14, 2019 at 08:08:42AM +0200, codekipper@gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> The clock division circuitry is different on the H3 and later SoCs.
> The division of bclk is now based on pll2.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 73 +++++++++++++++++++++++++------------
>  1 file changed, 49 insertions(+), 24 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 7c37b6291df0..34f31439ae7b 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -127,8 +127,6 @@ struct sun4i_i2s;
>   * @has_chsel_offset: SoC uses offset for selecting dai operational mode.
>   * @reg_offset_txdata: offset of the tx fifo.
>   * @sun4i_i2s_regmap: regmap config to use.
> - * @mclk_offset: Value by which mclkdiv needs to be adjusted.
> - * @bclk_offset: Value by which bclkdiv needs to be adjusted.
>   * @field_clkdiv_mclk_en: regmap field to enable mclk output.
>   * @field_fmt_wss: regmap field to set word select size.
>   * @field_fmt_sr: regmap field to set sample resolution.
> @@ -150,8 +148,6 @@ struct sun4i_i2s_quirks {
>  	bool				has_chsel_offset;
>  	unsigned int			reg_offset_txdata;	/* TX FIFO */
>  	const struct regmap_config	*sun4i_i2s_regmap;
> -	unsigned int			mclk_offset;
> -	unsigned int			bclk_offset;
>
>  	/* Register fields for i2s */
>  	struct reg_field		field_clkdiv_mclk_en;
> @@ -212,7 +208,25 @@ static const struct sun4i_i2s_clk_div sun4i_i2s_bclk_div[] = {
>  	{ .div = 8, .val = 3 },
>  	{ .div = 12, .val = 4 },
>  	{ .div = 16, .val = 5 },
> -	/* TODO - extend divide ratio supported by newer SoCs */
> +};
> +
> +static const struct sun4i_i2s_clk_div sun8i_i2s_clk_div[] = {
> +	{ .div = 0, .val = 0 },

Having a divider of 0 seems like a bad idea.

> +	{ .div = 1, .val = 1 },
> +	{ .div = 2, .val = 2 },
> +	{ .div = 4, .val = 3 },
> +	{ .div = 6, .val = 4 },
> +	{ .div = 8, .val = 5 },
> +	{ .div = 12, .val = 6 },
> +	{ .div = 16, .val = 7 },
> +	{ .div = 24, .val = 8 },
> +	{ .div = 32, .val = 9 },
> +	{ .div = 48, .val = 10 },
> +	{ .div = 64, .val = 11 },
> +	{ .div = 96, .val = 12 },
> +	{ .div = 128, .val = 13 },
> +	{ .div = 176, .val = 14 },
> +	{ .div = 192, .val = 15 },
>  };
>
>  static const struct sun4i_i2s_clk_div sun4i_i2s_mclk_div[] = {
> @@ -224,21 +238,21 @@ static const struct sun4i_i2s_clk_div sun4i_i2s_mclk_div[] = {
>  	{ .div = 12, .val = 5 },
>  	{ .div = 16, .val = 6 },
>  	{ .div = 24, .val = 7 },
> -	/* TODO - extend divide ratio supported by newer SoCs */
>  };
>
>  static int sun4i_i2s_get_bclk_div(struct sun4i_i2s *i2s,
>  				  unsigned int oversample_rate,
> -				  unsigned int word_size)
> +				  unsigned int word_size,
> +				  const struct sun4i_i2s_clk_div *bdiv,
> +				  unsigned int size)

Wouldn't it be simpler to just have the divider list in the variant
structure? It would avoid having to refactor all the functions, and
it's not like it's really going to change from one call to another
anyway.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--bamdgrdnwpokqt4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXVO0pwAKCRDj7w1vZxhR
xeUlAP9r6Z9EM/cbBKKY+kiTaI16sfr7c9NwecdxGZCT7mrOkAEAlrY4YQHdPrGM
Ek/ZDh1DW7Q85spOkTJgAF0ugAOlDwQ=
=8Nke
-----END PGP SIGNATURE-----

--bamdgrdnwpokqt4x--
