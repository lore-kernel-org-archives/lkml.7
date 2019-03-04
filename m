Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A773CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72232206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfCDPnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 10:43:25 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:60001 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbfCDPnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 10:43:24 -0500
X-Originating-IP: 185.94.189.188
Received: from localhost (unknown [185.94.189.188])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 354A0FF81C;
        Mon,  4 Mar 2019 15:43:20 +0000 (UTC)
Date:   Mon, 4 Mar 2019 16:43:20 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v9 2/5] drm/sun4i: sun6i_mipi_dsi: Fix TCON DRQ set bits
Message-ID: <20190304154320.uledvwz5jhzt22o3@flea>
References: <20190303173527.31055-1-jagan@amarulasolutions.com>
 <20190303173527.31055-3-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ckvqly3325xxados"
Content-Disposition: inline
In-Reply-To: <20190303173527.31055-3-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ckvqly3325xxados
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 03, 2019 at 11:05:24PM +0530, Jagan Teki wrote:
> TCON DRQ for non-burst DSI mode can computed based on horizontal
> front porch value, but the current driver trying to include sync
> timings along with front porch resulting wrong drq.
>=20
> This patch is trying to update the drq by subtracting hsync_start
> with hdisplay, which is horizontal front porch.
>=20
> Current code:
> ------------
> mode->hsync_end - mode->hdisplay =3D> horizontal front porch + sync
>=20
> With this patch:
> ----------------
> mode->hsync_start - mode->hdisplay =3D> horizontal front porch
>=20
> BSP code form BPI-M64-bsp is computing TCON DRQ set bits
> for non-burts as (from linux-sunxi/
> drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
>=20
> =3D> panel->lcd_ht -    panel->lcd_x - panel->lcd_hbp
> =3D> (timmings->hor_front_porch + panel->lcd_hbp + panel->lcd_x)
                                  ^ + sync length +         =20
>    - panel->lcd_x - panel->hbp
> =3D> timmings->hor_front_porch
                               ^ + sync
> =3D> mode->hsync_start - mode->hdisplay

s/hsync_start/hsync_end/

Did you encounter any panel where this was fixing something? If so,
which one, and what is the matching timings and / or datasheet?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ckvqly3325xxados
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXH1HmAAKCRDj7w1vZxhR
xbE5AQCeJXHl7njsE2u2cncRN3BJU9l5VoQgSMjTqpXB+TrW/wEAokqKp7BJB7eQ
T8Bevhwx3dZ0c7Sesev+6hAUeEd5hAI=
=0s6U
-----END PGP SIGNATURE-----

--ckvqly3325xxados--
