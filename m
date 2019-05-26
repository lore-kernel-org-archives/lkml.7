Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6400EC282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 19:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF0F2146E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 19:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbfEZTT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 15:19:58 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:34029 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbfEZTTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 15:19:54 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 0A271240003;
        Sun, 26 May 2019 19:19:40 +0000 (UTC)
Date:   Sun, 26 May 2019 21:19:40 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: fix warning PTR_ERR_OR_ZERO can be used
Message-ID: <20190526191940.ddr2yd7szfidtiu2@flea>
References: <20190525072509.GA6979@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wbyhtjebfo7bq6wk"
Content-Disposition: inline
In-Reply-To: <20190525072509.GA6979@hari-Inspiron-1545>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wbyhtjebfo7bq6wk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

On Sat, May 25, 2019 at 12:55:09PM +0530, Hariprasad Kelam wrote:
> fix below warnings reported by coccicheck
>
> ./drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c:174:1-3: WARNING:
> PTR_ERR_OR_ZERO can be used
> ./drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c:236:1-3: WARNING:
> PTR_ERR_OR_ZERO can be used
> ./drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c:285:1-3: WARNING:
> PTR_ERR_OR_ZERO can be used
> ./drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c:142:1-3: WARNING:
> PTR_ERR_OR_ZERO can be used
> ./drivers/gpu/drm/sun4i/sun4i_dotclock.c:198:1-3: WARNING:
> PTR_ERR_OR_ZERO can be used
>
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_dotclock.c      | 4 +---
>  drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c  | 4 +---
>  drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c      | 4 +---
>  drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c | 4 +---
>  drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c  | 4 +---
>  5 files changed, 5 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_dotclock.c b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
> index 2a15f2f..e0fd19d 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_dotclock.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
> @@ -195,10 +195,8 @@ int sun4i_dclk_create(struct device *dev, struct sun4i_tcon *tcon)
>  	dclk->hw.init = &init;
>
>  	tcon->dclk = clk_register(dev, &dclk->hw);
> -	if (IS_ERR(tcon->dclk))
> -		return PTR_ERR(tcon->dclk);
>
> -	return 0;
> +	return PTR_ERR_OR_ZERO(tcon->dclk);

Unfortunately, that was on purpose. It's much easier to extend if we
ever need to change anything there.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--wbyhtjebfo7bq6wk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXOrmzAAKCRDj7w1vZxhR
xYHIAQCHJXC7nn+WNDI2HEnEBKzcFG+IbWIX34bHIZfhK4AnGgEAgZHJJQ6EF1xn
m34W2K3bjCbJ19Re4AH0OQy4fDUa5Ag=
=640m
-----END PGP SIGNATURE-----

--wbyhtjebfo7bq6wk--
