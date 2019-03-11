Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3C7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FACE2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfCKOJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:09:28 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:33159 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfCKOJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:09:28 -0400
X-Originating-IP: 90.88.150.179
Received: from localhost (aaubervilliers-681-1-31-179.w90-88.abo.wanadoo.fr [90.88.150.179])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id ADA8220016;
        Mon, 11 Mar 2019 14:09:23 +0000 (UTC)
Date:   Mon, 11 Mar 2019 15:09:23 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH v9 2/5] drm/sun4i: sun6i_mipi_dsi: Fix TCON DRQ set bits
Message-ID: <20190311140923.vvtubx7wndos2rfr@flea>
References: <20190303173527.31055-1-jagan@amarulasolutions.com>
 <20190303173527.31055-3-jagan@amarulasolutions.com>
 <20190304154320.uledvwz5jhzt22o3@flea>
 <CAMty3ZDWkLWgWhGWBjhXOsmAXzuGKGADAEhzB6gcL+jd7FRazQ@mail.gmail.com>
 <20190307153935.uxh2hsmahw5l7h4q@flea>
 <CAMty3ZDyk60R0YCsBV6toz84CFjD0D6uWyLVhmp8PC+Mj8GJpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lbfkunzo5uuh54qm"
Content-Disposition: inline
In-Reply-To: <CAMty3ZDyk60R0YCsBV6toz84CFjD0D6uWyLVhmp8PC+Mj8GJpQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lbfkunzo5uuh54qm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 09:24:02PM +0530, Jagan Teki wrote:
> On Thu, Mar 7, 2019 at 9:09 PM Maxime Ripard <maxime.ripard@bootlin.com> =
wrote:
> >
> > On Thu, Mar 07, 2019 at 05:49:07PM +0530, Jagan Teki wrote:
> > > On Mon, Mar 4, 2019 at 9:13 PM Maxime Ripard <maxime.ripard@bootlin.c=
om> wrote:
> > > >
> > > > On Sun, Mar 03, 2019 at 11:05:24PM +0530, Jagan Teki wrote:
> > > > > TCON DRQ for non-burst DSI mode can computed based on horizontal
> > > > > front porch value, but the current driver trying to include sync
> > > > > timings along with front porch resulting wrong drq.
> > > > >
> > > > > This patch is trying to update the drq by subtracting hsync_start
> > > > > with hdisplay, which is horizontal front porch.
> > > > >
> > > > > Current code:
> > > > > ------------
> > > > > mode->hsync_end - mode->hdisplay =3D> horizontal front porch + sy=
nc
> > > > >
> > > > > With this patch:
> > > > > ----------------
> > > > > mode->hsync_start - mode->hdisplay =3D> horizontal front porch
> > > > >
> > > > > BSP code form BPI-M64-bsp is computing TCON DRQ set bits
> > > > > for non-burts as (from linux-sunxi/
> > > > > drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> > > > >
> > > > > =3D> panel->lcd_ht -    panel->lcd_x - panel->lcd_hbp
> > > > > =3D> (timmings->hor_front_porch + panel->lcd_hbp + panel->lcd_x)
> > > >                                   ^ + sync length +
> > > > >    - panel->lcd_x - panel->hbp
> > > > > =3D> timmings->hor_front_porch
> > > >                                ^ + sync
> > > > > =3D> mode->hsync_start - mode->hdisplay
> > > >
> > > > s/hsync_start/hsync_end/
> > >
> > > No, it should be front porch so it is hsync_start. This change is
> > > trying to update DRQ set to use front porch and above evaluation from
> > > BSP, result the same front front porch
> > >
> > > Current driver has hsync_end - hdisplay which is not front porch
> > > timing (it is adding extra sync timing).
> >
> > It would be if you considered that the back porch actually was the
> > back porch plus the sync length. I have found no such evidence, quite
> > the opposite actually, everything seems to point at the fact that
> > unlike the TCON, the DSI block uses the back porch as only the back
> > porch.
>=20
> Sorry, I'm not clear about back porch here.
>=20
> The current code has mode->hsync_end - mode->hdisplay which is Front
> porch + sync time do you think it's not?

It is.

> DRQ set time is pure front porch value (according BSP) as I didn't
> see any information about DRQ set bits in manual or anywhere.

This is what I'm telling you. If you consider the back porch as only
the back porch, then the result of that BSP calculation you mentionned
earlier is the front porch and the sync length.

You imply that the back porch should actually be treated as the back
porch and the sync length in your calculation. What makes you say so?

> fyi: atleast if you didn't trust me, here is existing applied patch
> for about equations.
> https://cgit.freedesktop.org/drm/drm-misc/commit/drivers/gpu/drm/sun4i/su=
n6i_mipi_dsi.c?id=3D2cfdc24d2f8d9b14704567c065beb2a118a578fa

I'm aware of that patch, but I have no idea why do you bring it up in
that discussion.

> So, this patch fixed to remove sync time by updating hsync_start -
> hdisplay which is pure front porch. and it's clear that pane is not
> working without this.

This is the same discussion over and over again: which panel, which
datasheet, not working how?

> > > I believe this is something similar like fixed patches for VBP, HBLK
> > > timings.
> > >
> > > > Did you encounter any panel where this was fixing something? If so,
> > > > which one, and what is the matching timings and / or datasheet?
> > >
> > > W/O this change Bananapi  s070wv20 panel has issue on striped lines on
> > > the panel[1] and timings are
> > >
> > > static const struct drm_display_mode s070wv20_default_mode =3D {
> > >         .clock =3D 30000,
> > >         .vrefresh =3D 60,
> > >
> > >         .hdisplay =3D 800,
> > >         .hsync_start =3D 800 + 40,
> > >         .hsync_end =3D 800 + 40 + 48,
> > >         .htotal =3D 800 + 40 + 48 + 40,
> > >
> > >         .vdisplay =3D 480,
> > >         .vsync_start =3D 480 + 13,
> > >         .vsync_end =3D 480 + 13 + 3,
> > >         .vtotal =3D 480 + 13 + 3 + 29,
> > > };
> > >
> > > Which is similar like in panel-simple "bananapi,s070wv20-ct16"
> > >
> > > Here is the DSI panel patches and sequence:
> > > [pixel clock is 30Mhz] https://patchwork.kernel.org/patch/10680331/
> > > https://github.com/yesnoandor/x300/blob/master/kernel/arch/arm/boot/d=
ts/erobbing/x300/x300.dtsi#L81
> > > https://github.com/wxzed/Raspberry_5MIPI_Display/blob/master/I2C_Slav=
e/USER/main.c#L15
> > > https://github.com/eliot-shao/qcom/blob/master/icn6211_cxn0102/kernel=
/drivers/video/msm/mdss/mdss_i2c_interface.c#L152
> >
> > What are those supposed to be? It doesn't look like timings but rather =
initialization sequences
> >
> > > matches timings for
> > > https://github.com/eliot-shao/qcom/blob/master/icn6211_cxn0102/kernel=
/arch/arm/boot/dts/qcom/dsi-mipi-2-rgb_1280p_video.dtsi#L20
> >
> > That's not even the same resolution..
>=20
> fyi about the sequence.

How is that relevant?

> > > https://github.com/zestroly/micromat/blob/master/test/raspberry/ICN62=
11.cpp#L169
> >
> > And this isn't a set of timings either.
> >
> > > Attached is panel datasheet.
> >
> > Which is for an RGB panel... not a MIPI-DSI one.
>=20
> Same panel timings It is a DSI ICN6211 bridge, I have attached the
> patch above https://patchwork.kernel.org/patch/10680331/ for
> information about the display please find previous mail attachment.

The previous attachment was for a display that doesn't even have the
same bus. How is that relevant?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--lbfkunzo5uuh54qm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXIZsEwAKCRDj7w1vZxhR
xU0rAP0UGfRrSN11Vi+XBZeaQtUO9PDFLMhBdOKHqiRjuRZjWQD/W9Bu12DCZKaD
2xf6tvt1J8CPlDPBdpa4hz4awiityws=
=rEj7
-----END PGP SIGNATURE-----

--lbfkunzo5uuh54qm--
