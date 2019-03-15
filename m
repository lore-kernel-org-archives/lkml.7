Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09156C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51BE2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbfCONqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:46:00 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:58441 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbfCONqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:46:00 -0400
X-Originating-IP: 90.88.22.102
Received: from localhost (aaubervilliers-681-1-80-102.w90-88.abo.wanadoo.fr [90.88.22.102])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 78E84FF807;
        Fri, 15 Mar 2019 13:45:55 +0000 (UTC)
Date:   Fri, 15 Mar 2019 14:45:55 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     jagan@amarulasolutions.com, Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com
Subject: Re: [linux-sunxi] [PATCH 3/6] drm/sun4i: dsi: Add bridge support
Message-ID: <20190315134555.ekpywymjx3xqmdhf@flea>
References: <20190315130825.9005-1-jagan@amarulasolutions.com>
 <20190315130825.9005-4-jagan@amarulasolutions.com>
 <c232d5620d6a3272a6064ce9ccdec5c86a3a7950.camel@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pswiqfcemuf43jfz"
Content-Disposition: inline
In-Reply-To: <c232d5620d6a3272a6064ce9ccdec5c86a3a7950.camel@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pswiqfcemuf43jfz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2019 at 02:32:55PM +0100, Paul Kocialkowski wrote:
> Hi,
>=20
> On Fri, 2019-03-15 at 18:38 +0530, Jagan Teki wrote:
> > Some display panels would come up with a non-DSI output which
> > can have an option to connect DSI interface by means of bridge
> > convertor.
> >=20
> > This DSI to non-DSI bridge convertor would require a bridge
> > driver that would communicate the DSI controller for bridge
> > functionalities.
> >=20
> > So, add support for bridge functionalities in Allwinner DSI
> > controller.
>=20
> See a few comments below.
>=20
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 65 +++++++++++++++++++-------
> >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h |  1 +
> >  2 files changed, 49 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/s=
un4i/sun6i_mipi_dsi.c
> > index 0960b96b62cc..64d74313b842 100644
> > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > @@ -781,6 +781,9 @@ static void sun6i_dsi_encoder_enable(struct drm_enc=
oder *encoder)
> >  	if (!IS_ERR(dsi->panel))
> >  		drm_panel_prepare(dsi->panel);
> > =20
> > +	if (!IS_ERR(dsi->bridge))
> > +		drm_bridge_pre_enable(dsi->bridge);
> > +
> >  	/*
> >  	 * FIXME: This should be moved after the switch to HS mode.
> >  	 *
> > @@ -796,6 +799,9 @@ static void sun6i_dsi_encoder_enable(struct drm_enc=
oder *encoder)
> >  	if (!IS_ERR(dsi->panel))
> >  		drm_panel_enable(dsi->panel);
> > =20
> > +	if (!IS_ERR(dsi->bridge))
> > +		drm_bridge_enable(dsi->bridge);
> > +
> >  	sun6i_dsi_start(dsi, DSI_START_HSC);
> > =20
> >  	udelay(1000);
> > @@ -812,6 +818,9 @@ static void sun6i_dsi_encoder_disable(struct drm_en=
coder *encoder)
> >  	if (!IS_ERR(dsi->panel)) {
> >  		drm_panel_disable(dsi->panel);
> >  		drm_panel_unprepare(dsi->panel);
> > +	} else if (!IS_ERR(dsi->bridge)) {
> > +		drm_bridge_disable(dsi->bridge);
> > +		drm_bridge_post_disable(dsi->bridge);
> >  	}
> > =20
> >  	phy_power_off(dsi->dphy);
> > @@ -973,11 +982,16 @@ static int sun6i_dsi_attach(struct mipi_dsi_host =
*host,
> >  	struct sun6i_dsi *dsi =3D host_to_sun6i_dsi(host);
> > =20
> >  	dsi->device =3D device;
> > -	dsi->panel =3D of_drm_find_panel(device->dev.of_node);
> > -	if (IS_ERR(dsi->panel))
> > -		return PTR_ERR(dsi->panel);
> > =20
> > -	dev_info(host->dev, "Attached device %s\n", device->name);
> > +	dsi->bridge =3D of_drm_find_bridge(device->dev.of_node);
> > +	if (!dsi->bridge) {
>=20
> You are using IS_ERR to check that the bridge is alive in the changes
> above, but switch to checking that it's non-NULL at this point.
>=20
> Are both guaranteed to be interchangeable?

They aren't. Any ERR_PTR will be !NULL

> > +		dsi->panel =3D of_drm_find_panel(device->dev.of_node);
> > +		if (IS_ERR(dsi->panel))
> > +			return PTR_ERR(dsi->panel);
> > +	}
>=20
> You should probably use drm_of_find_panel_or_bridge instead of
> duplicating the logic here.

Or we can even use the drm_panel_bridge_add to simplify things.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--pswiqfcemuf43jfz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXIuskgAKCRDj7w1vZxhR
xe0MAP4wC7EmToXTIAr2uOVsRai2Km5NXRQqLmWuFt7WTBh5PQD7BrjuxRRWuADu
6AhK0aD8Oy8jtGOk+S5TYlOvOMVv3wI=
=qwPR
-----END PGP SIGNATURE-----

--pswiqfcemuf43jfz--
