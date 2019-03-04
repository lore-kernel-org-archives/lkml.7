Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9442BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9A2206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfCDPys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 10:54:48 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:57733 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbfCDPys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 10:54:48 -0500
X-Originating-IP: 185.94.189.188
Received: from localhost (unknown [185.94.189.188])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 24FB6E001C;
        Mon,  4 Mar 2019 15:54:44 +0000 (UTC)
Date:   Mon, 4 Mar 2019 16:54:44 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v9 1/5] drm/sun4i: sun6i_mipi_dsi: Fix hsync_porch
 overflow
Message-ID: <20190304155444.rwslksn57uggpazw@flea>
References: <20190303173527.31055-1-jagan@amarulasolutions.com>
 <20190303173527.31055-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mr4wnokcjpwb6vbq"
Content-Disposition: inline
In-Reply-To: <20190303173527.31055-2-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mr4wnokcjpwb6vbq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 03, 2019 at 11:05:23PM +0530, Jagan Teki wrote:
> Loop N1 instruction delay for burst mode devices are computed
> based on horizontal sync and porch timing values.
>=20
> The current driver is using u16 type for computing this hsync_porch
> value, which would failed to fit within the u16 type for large sync
> and porch timings devices. This would result in hsync_porch overflow
> and eventually computed wrong instruction delay value.
>=20
> Example, timings, where it produces the overflow
> {
> 	.hdisplay       =3D 1080,
> 	.hsync_start    =3D 1080 + 408,
>         .hsync_end      =3D 1080 + 408 + 4,
>         .htotal         =3D 1080 + 408 + 4 + 38,
> }
>=20
> It reproduces the desired delay value 65487 but the correct working
> value should be 7.
>=20
> So, Fix it by computing hsync_porch value separately with u32 type.
>=20
> Fixes: 1c1a7aa3663c ("drm/sun4i: dsi: Add burst support")
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Tested-by: Merlijn Wajer <merlijn@wizzup.org>
> ---
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun=
4i/sun6i_mipi_dsi.c
> index 6ff585055a07..465e7fc57899 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -457,8 +457,9 @@ static void sun6i_dsi_setup_inst_loop(struct sun6i_ds=
i *dsi,
>  	u16 delay =3D 50 - 1;
> =20
>  	if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
> -		delay =3D (mode->htotal - mode->hdisplay) * 150;
> -		delay /=3D (mode->clock / 1000) * 8;
> +		u32 hsync_porch =3D (mode->htotal - mode->hdisplay);
> +
> +		delay =3D ((hsync_porch * 150) / ((mode->clock / 1000) * 8));

shouldn't we keep the multiplication by 150 in the u32 assignation?
Otherwise, we could keep a u16 for the delay

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--mr4wnokcjpwb6vbq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXH1KRAAKCRDj7w1vZxhR
xZafAQD6uiqAMuKggWx309kfrFfKHuWFY/3zVKpCznVU6qqbZAD/bOyu/0FojYfa
dEwRdepXajH5hSDlAoKHVG4fWH4itAQ=
=3ZL1
-----END PGP SIGNATURE-----

--mr4wnokcjpwb6vbq--
