Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E15C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E423206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfCDPtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 10:49:16 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:49719 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfCDPtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 10:49:16 -0500
X-Originating-IP: 185.94.189.188
Received: from localhost (unknown [185.94.189.188])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 4AD3EE001A;
        Mon,  4 Mar 2019 15:49:12 +0000 (UTC)
Date:   Mon, 4 Mar 2019 16:49:11 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v9 3/5] drm/sun4i: sun6i_mipi_dsi: Support vblk timing
 for 4-lane devices
Message-ID: <20190304154911.s6rcx6bzal5slcjk@flea>
References: <20190303173527.31055-1-jagan@amarulasolutions.com>
 <20190303173527.31055-4-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4vyjlwpzptsmmtro"
Content-Disposition: inline
In-Reply-To: <20190303173527.31055-4-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4vyjlwpzptsmmtro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 03, 2019 at 11:05:25PM +0530, Jagan Teki wrote:
> Like other dsi setup timings, or hblk for that matter vblk would
> also require compute the timings based payload equation along with
> packet overhead.
>=20
> But, on the other hand vblk computation is also depends on device
> lane number.
> - for 4 lane devices, it is computed based on vtotal, packet overhead
>   along with hblk value.
> - for others devices, it is simply 0
>=20
> BSP code from BPI-M64-bsp is computing vblk as for 4-lane devices
> (from linux-sunxi
> drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
>=20
> tmp =3D (ht*dsi_pixel_bits[format]/8)*vt-(4+dsi_hblk+2);
> dsi_vblk =3D (lane-tmp%lane);
>=20
> So, update the vblk timing calculation to support all type of
> devices.
>=20
> Tested on 2-lane, 4-lane MIPI-DSI LCD panels.

You should be explaining which issue you faced, in which setup, what
were its symptoms and how that solution is fixing it.

> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Tested-by: Merlijn Wajer <merlijn@wizzup.org>
> ---
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 27 +++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun=
4i/sun6i_mipi_dsi.c
> index 140e55f5ed2e..b38358465d87 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -527,6 +527,24 @@ static void sun6i_dsi_setup_format(struct sun6i_dsi =
*dsi,
>  		     SUN6I_DSI_PIXEL_CTL0_FORMAT(fmt));
>  }
> =20
> +static u16 sun6i_dsi_get_timings_vblk(struct sun6i_dsi *dsi,
> +				      struct drm_display_mode *mode, u16 hblk)
> +{
> +	struct mipi_dsi_device *device =3D dsi->device;
> +	unsigned int Bpp =3D mipi_dsi_pixel_format_to_bpp(device->format) / 8;
> +	int tmp;
> +
> +	/*
> +	 * The vertical blank is set using a blanking packet (4 bytes +
> +	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
> +	 */
> +#define VBLK_PACKET_OVERHEAD	6
> +	tmp =3D (mode->htotal * Bpp) * mode->vtotal -
> +	      (hblk + VBLK_PACKET_OVERHEAD);
> +
> +	return (device->lanes - tmp % device->lanes);

This should have a comment explaining why it's needed

> +}
> +
>  static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
>  				    struct drm_display_mode *mode)
>  {
> @@ -586,13 +604,8 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi=
 *dsi,
>  			   (mode->htotal - (mode->hsync_end - mode->hsync_start)) * Bpp -
>  			   HBLK_PACKET_OVERHEAD);
> =20
> -		/*
> -		 * And I'm not entirely sure what vblk is about. The driver in
> -		 * Allwinner BSP is using a rather convoluted calculation
> -		 * there only for 4 lanes. However, using 0 (the !4 lanes
> -		 * case) even with a 4 lanes screen seems to work...
> -		 */
> -		vblk =3D 0;
> +		if (device->lanes =3D=3D 4)

And that can be done in the function itself.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--4vyjlwpzptsmmtro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXH1I9wAKCRDj7w1vZxhR
xQodAQCrqnZbxF2fyl1NPVcnROU4AIK0N+R9W8jAMN9Z+0GiSAD/aQOiMHG7Z389
2eYWjKGR050OLCOn/EsHwfkZYY4d7Qs=
=O1dp
-----END PGP SIGNATURE-----

--4vyjlwpzptsmmtro--
