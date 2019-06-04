Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3B1C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B862496E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfFDIVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:21:32 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:54567 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfFDIVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:21:32 -0400
X-Originating-IP: 90.88.144.139
Received: from localhost (aaubervilliers-681-1-24-139.w90-88.abo.wanadoo.fr [90.88.144.139])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 21F3820010;
        Tue,  4 Jun 2019 08:21:26 +0000 (UTC)
Date:   Tue, 4 Jun 2019 10:21:26 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     codekipper@gmail.com
Cc:     wens@csie.org, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it
Subject: Re: [PATCH v4 9/9] ASoC: sun4i-i2s: Adjust regmap settings
Message-ID: <20190604082126.7jgk2cn2u253nmr2@flea>
References: <20190603174735.21002-1-codekipper@gmail.com>
 <20190603174735.21002-10-codekipper@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="id3655fnez2gqvnw"
Content-Disposition: inline
In-Reply-To: <20190603174735.21002-10-codekipper@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--id3655fnez2gqvnw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 03, 2019 at 07:47:35PM +0200, codekipper@gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> Bypass the regmap cache when flushing the i2s FIFOs and modify the tables
> to reflect this.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 29 +++++++++--------------------
>  1 file changed, 9 insertions(+), 20 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 351b8021173b..92828a84902d 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -595,9 +595,11 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>  static void sun4i_i2s_start_capture(struct sun4i_i2s *i2s)
>  {
>  	/* Flush RX FIFO */
> +	regcache_cache_bypass(i2s->regmap, true);
>  	regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
>  			   SUN4I_I2S_FIFO_CTRL_FLUSH_RX,
>  			   SUN4I_I2S_FIFO_CTRL_FLUSH_RX);
> +	regcache_cache_bypass(i2s->regmap, false);

Your commit log should say why you need to do this in the first place.

> @@ -771,13 +775,7 @@ static const struct snd_soc_component_driver sun4i_i2s_component = {
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

That doesn't seem related?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--id3655fnez2gqvnw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXPYqBgAKCRDj7w1vZxhR
xaI9AP9kw/Dxrjf+ydEaoUMyGCeuWG+T3q9mRR+01bsMCLwC4gD/Vw5P/+LzUpDY
JRMk0P27lfshoHsSOv0tmj90hGxF+QU=
=QlRr
-----END PGP SIGNATURE-----

--id3655fnez2gqvnw--
