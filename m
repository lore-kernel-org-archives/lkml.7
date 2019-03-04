Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33C8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AEB2206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfCDPuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 10:50:19 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:56509 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfCDPuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 10:50:19 -0500
X-Originating-IP: 185.94.189.188
Received: from localhost (unknown [185.94.189.188])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 56C9940019;
        Mon,  4 Mar 2019 15:50:15 +0000 (UTC)
Date:   Mon, 4 Mar 2019 16:50:14 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v9 5/5] drm/sun4i: sun6i_mipi_dsi: Simplify dsi setup
 timings code
Message-ID: <20190304155014.2c7mx4uvzqwy7yde@flea>
References: <20190303173527.31055-1-jagan@amarulasolutions.com>
 <20190303173527.31055-6-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v2ccyfomkb3u4ngk"
Content-Disposition: inline
In-Reply-To: <20190303173527.31055-6-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v2ccyfomkb3u4ngk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 03, 2019 at 11:05:27PM +0530, Jagan Teki wrote:
> DSI timings are varies between burst/non-burst devices and
> current driver is handling this support via if, else statements
> which would difficult to read.
>=20
> Simplify it by using goto to make code more readable.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Tested-by: Merlijn Wajer <merlijn@wizzup.org>
> ---
> Note: This change is created based on previous version burst
> changes [1] by addressing comment from [2] by Maxime to make
> code readable.=20
>=20
> [1] https://patchwork.kernel.org/cover/10813623/
> [2] https://patchwork.kernel.org/patch/10666607/
>=20
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 79 ++++++++++++++------------
>  1 file changed, 42 insertions(+), 37 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun=
4i/sun6i_mipi_dsi.c
> index 31ec4048804d..898f32319c2d 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -550,7 +550,8 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi =
*dsi,
>  {
>  	struct mipi_dsi_device *device =3D dsi->device;
>  	unsigned int Bpp =3D mipi_dsi_pixel_format_to_bpp(device->format) / 8;
> -	u16 hbp =3D 0, hfp =3D 0, hsa =3D 0, hblk =3D 0, vblk =3D 0;
> +	u16 hbp, hfp, hsa, hblk;
> +	u16 vblk =3D 0;
>  	u32 basic_ctl =3D 0;
>  	size_t bytes;
>  	u8 *buffer;
> @@ -558,6 +559,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi =
*dsi,
>  	/* Do all timing calculations up front to allocate buffer space */
> =20
>  	if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
> +		hbp =3D hfp =3D hsa =3D 0;

This raises a checkpatch warning and isn't necessary

>  		hblk =3D mode->hdisplay * Bpp;
>  		basic_ctl =3D SUN6I_DSI_BASIC_CTL_VIDEO_BURST |
>  			    SUN6I_DSI_BASIC_CTL_HSA_HSE_DIS |
> @@ -566,48 +568,51 @@ static void sun6i_dsi_setup_timings(struct sun6i_ds=
i *dsi,
>  		if (device->lanes =3D=3D 4)
>  			basic_ctl |=3D SUN6I_DSI_BASIC_CTL_TRAIL_FILL |
>  				     SUN6I_DSI_BASIC_CTL_TRAIL_INV(0xc);
> -	} else {
> -		/*
> -		 * A sync period is composed of a blanking packet (4
> -		 * bytes + payload + 2 bytes) and a sync event packet
> -		 * (4 bytes). Its minimal size is therefore 10 bytes
> -		 */
> +
> +		goto alloc_buf;

And I'd rather not have a goto in the middle of the code for no
particular reason.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--v2ccyfomkb3u4ngk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXH1JNgAKCRDj7w1vZxhR
xagXAQC3dp3eEYhs1dGhQeIjY6JCqWMePKF3iMTgmhnEtSjcnwEAzPLaMnwcsBir
cjFSa1r/ffjtERJIXV8n2y2ug6kJpg8=
=Grgg
-----END PGP SIGNATURE-----

--v2ccyfomkb3u4ngk--
