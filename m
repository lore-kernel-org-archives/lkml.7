Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17283C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E592D20828
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfCSKZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:25:27 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:47893 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfCSKZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 06:25:27 -0400
X-Originating-IP: 90.88.22.102
Received: from localhost (aaubervilliers-681-1-80-102.w90-88.abo.wanadoo.fr [90.88.22.102])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 542CBE0011;
        Tue, 19 Mar 2019 10:25:21 +0000 (UTC)
Date:   Tue, 19 Mar 2019 11:25:20 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH v8 01/15] drm/sun4i: dsi: Fix video start delay
 computation
Message-ID: <20190319102520.ldgjtyzrphuib3td@flea>
References: <20190311133637.18334-1-jagan@amarulasolutions.com>
 <20190311133637.18334-2-jagan@amarulasolutions.com>
 <20190311153734.izg44ijwqqh2vpxc@flea>
 <CAMty3ZDDARP02qMJZ9CXeiMv=kghoiUHgEAV9b4q+SrbLss40Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4kxxtlmvi7tknwsq"
Content-Disposition: inline
In-Reply-To: <CAMty3ZDDARP02qMJZ9CXeiMv=kghoiUHgEAV9b4q+SrbLss40Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4kxxtlmvi7tknwsq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 11, 2019 at 09:31:11PM +0530, Jagan Teki wrote:
> On Mon, Mar 11, 2019 at 9:07 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Mon, Mar 11, 2019 at 07:06:23PM +0530, Jagan Teki wrote:
> > > Vertical video start delay is computed by excluding vertical front
> > > porch value from total vertical timings.
> > >
> > > This clearly confirmed from BSP code and here how it computed,
> > >
> > > (drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> > > u32 vfp = panel->lcd_vt - panel->lcd_y - panel->lcd_vbp;
> > > => (panel->lcd_vt) - panel->lcd_y - (panel->lcd_vbp)
> > > => (timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y)
> > >    - panel->lcd_y - (panel->lcd_vbp)
> > > => timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y
> > >                            - panel->lcd_y - panel->lcd_vbp
> > > => timmings->ver_front_porch
> > >
> > > But the current driver is assuming it can exclude vertical front
> > > porch along with vertical sync values from total vertical timings,
> > > which resulting wrong start delay indeed wrong picture rendering
> > > in the panel.
> >
> > Same story here: which panel, which datasheet, which "wrong picture
> > rendering"?
>
> It's bananapi,s070wv20-ct16 DSI

You're answering one out of three questions.

> > > Example: timings, where it produces the issue.
> > > {
> > >       .vdisplay       = 600,
> > >       .vsync_start    = 600 + 12,
> > >       .vsync_end      = 600 + 12 + 2,
> > >       .vtotal         = 600 + 12 + 2 + 21,
> > > }
> >
> > Can you 100% trust those timings?
>
> ie. reason, I have given the Mainline timings [1]. The above timings
> are wrongly mentioned actual timings are from [1]

You're still answering partially here. Those timings are working for
RGB, you have no proof that we need to make the same adjustments for
DSI.

> > > It produces the desired start delay value as 19 but the correct working
> > > value should be 513.
> > >
> > > So, Fix it by computing proper video start delay.
> > >
> > > Fixes: 69006ef0ecb1 ("drm/sun4i: dsi: Change the start delay calculation")
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > index 62a508420227..8d6292c0158b 100644
> > > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > @@ -364,8 +364,14 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
> > >  static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
> > >                                          struct drm_display_mode *mode)
> > >  {
> > > -     u16 start = clamp(mode->vtotal - mode->vdisplay - 10, 8, 100);
> > > -     u16 delay = mode->vtotal - (mode->vsync_end - mode->vdisplay) + start;
> > > +     u16 delay = mode->vtotal - (mode->vsync_start - mode->vdisplay);
> > > +
> > > +     /**
> > > +      * BSP comment:
> > > +      * put start_delay to tcon. set ready sync early to dramfreq,
> > > +      * so set start_delay 1
> > > +      */
> >
> > That doesn't make any sense to me... What does it mean?
>
> Which is meaning as above stated as "BSP comment" from here[2]

It doesn't matter where you took it from. If you cannot explain what
happen, putting a random label that doesn't explain anything will not
help.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--4kxxtlmvi7tknwsq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXJDDkAAKCRDj7w1vZxhR
xU+WAP0bWohQTOy2V10s8wo9M2tCtIwFTHk6g2vFYaoClQVpdAEA48ghCZuiSvUd
2pSL7z54qV6CklWr3sxeK3Mixv1nwwI=
=hFp+
-----END PGP SIGNATURE-----

--4kxxtlmvi7tknwsq--
