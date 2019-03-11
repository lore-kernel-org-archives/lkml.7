Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64461C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C2EB21741
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfCKPhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:37:42 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:49947 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfCKPhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 11:37:41 -0400
Received: from localhost (aaubervilliers-681-1-31-179.w90-88.abo.wanadoo.fr [90.88.150.179])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 2181910000A;
        Mon, 11 Mar 2019 15:37:34 +0000 (UTC)
Date:   Mon, 11 Mar 2019 16:37:34 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v8 01/15] drm/sun4i: dsi: Fix video start delay
 computation
Message-ID: <20190311153734.izg44ijwqqh2vpxc@flea>
References: <20190311133637.18334-1-jagan@amarulasolutions.com>
 <20190311133637.18334-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gkffxe7wlup45xq3"
Content-Disposition: inline
In-Reply-To: <20190311133637.18334-2-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gkffxe7wlup45xq3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2019 at 07:06:23PM +0530, Jagan Teki wrote:
> Vertical video start delay is computed by excluding vertical front
> porch value from total vertical timings.
>=20
> This clearly confirmed from BSP code and here how it computed,
>=20
> (drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> u32 vfp =3D panel->lcd_vt - panel->lcd_y - panel->lcd_vbp;
> =3D> (panel->lcd_vt) - panel->lcd_y - (panel->lcd_vbp)
> =3D> (timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y)
>    - panel->lcd_y - (panel->lcd_vbp)
> =3D> timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y
>   			     - panel->lcd_y - panel->lcd_vbp
> =3D> timmings->ver_front_porch
>=20
> But the current driver is assuming it can exclude vertical front
> porch along with vertical sync values from total vertical timings,
> which resulting wrong start delay indeed wrong picture rendering
> in the panel.

Same story here: which panel, which datasheet, which "wrong picture
rendering"?

> Example: timings, where it produces the issue.
> {
> 	.vdisplay	=3D 600,
> 	.vsync_start	=3D 600 + 12,
> 	.vsync_end	=3D 600 + 12 + 2,
> 	.vtotal		=3D 600 + 12 + 2 + 21,
> }

Can you 100% trust those timings?

> It produces the desired start delay value as 19 but the correct working
> value should be 513.
>
> So, Fix it by computing proper video start delay.
>=20
> Fixes: 69006ef0ecb1 ("drm/sun4i: dsi: Change the start delay calculation")
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun=
4i/sun6i_mipi_dsi.c
> index 62a508420227..8d6292c0158b 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -364,8 +364,14 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *ds=
i,
>  static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
>  					   struct drm_display_mode *mode)
>  {
> -	u16 start =3D clamp(mode->vtotal - mode->vdisplay - 10, 8, 100);
> -	u16 delay =3D mode->vtotal - (mode->vsync_end - mode->vdisplay) + start;
> +	u16 delay =3D mode->vtotal - (mode->vsync_start - mode->vdisplay);
> +
> +	/**
> +	 * BSP comment:
> +	 * put start_delay to tcon. set ready sync early to dramfreq,
> +	 * so set start_delay 1
> +	 */

That doesn't make any sense to me... What does it mean?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--gkffxe7wlup45xq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXIaAvgAKCRDj7w1vZxhR
xXs1AP0etuFMtzbwlTM4yI+9ntNLA+5Rp+ZPoilius9At8DlDwEA3fqiZzpYxCxO
B9BgvlqO7a9/DDgDCcBEHJ3Wu9mv8wM=
=D3L3
-----END PGP SIGNATURE-----

--gkffxe7wlup45xq3--
