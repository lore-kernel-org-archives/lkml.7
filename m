Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D91C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5486C2133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731680AbfDBOpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:45:25 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:54479 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729526AbfDBOpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:45:25 -0400
Received: from localhost (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 23E0B100015;
        Tue,  2 Apr 2019 14:45:18 +0000 (UTC)
Date:   Tue, 2 Apr 2019 16:45:18 +0200
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
Message-ID: <20190402144518.bevb2vg64mprhtjt@flea>
References: <20190311133637.18334-1-jagan@amarulasolutions.com>
 <20190311133637.18334-2-jagan@amarulasolutions.com>
 <20190311153734.izg44ijwqqh2vpxc@flea>
 <CAMty3ZDDARP02qMJZ9CXeiMv=kghoiUHgEAV9b4q+SrbLss40Q@mail.gmail.com>
 <20190319102520.ldgjtyzrphuib3td@flea>
 <CAMty3ZC+dTVuc2TWR=cqKNbrZe6j2vnwfXAqg6RbvduvY_63LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="udtxcv6c7reia3ri"
Content-Disposition: inline
In-Reply-To: <CAMty3ZC+dTVuc2TWR=cqKNbrZe6j2vnwfXAqg6RbvduvY_63LA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--udtxcv6c7reia3ri
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 21, 2019 at 08:08:58PM +0530, Jagan Teki wrote:
> On Tue, Mar 19, 2019 at 3:55 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Mon, Mar 11, 2019 at 09:31:11PM +0530, Jagan Teki wrote:
> > > On Mon, Mar 11, 2019 at 9:07 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > >
> > > > On Mon, Mar 11, 2019 at 07:06:23PM +0530, Jagan Teki wrote:
> > > > > Vertical video start delay is computed by excluding vertical front
> > > > > porch value from total vertical timings.
> > > > >
> > > > > This clearly confirmed from BSP code and here how it computed,
> > > > >
> > > > > (drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> > > > > u32 vfp = panel->lcd_vt - panel->lcd_y - panel->lcd_vbp;
> > > > > => (panel->lcd_vt) - panel->lcd_y - (panel->lcd_vbp)
> > > > > => (timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y)
> > > > >    - panel->lcd_y - (panel->lcd_vbp)
> > > > > => timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y
> > > > >                            - panel->lcd_y - panel->lcd_vbp
> > > > > => timmings->ver_front_porch
> > > > >
> > > > > But the current driver is assuming it can exclude vertical front
> > > > > porch along with vertical sync values from total vertical timings,
> > > > > which resulting wrong start delay indeed wrong picture rendering
> > > > > in the panel.
> > > >
> > > > Same story here: which panel, which datasheet, which "wrong picture
> > > > rendering"?
> > >
> > > It's bananapi,s070wv20-ct16 DSI
>
> 2. as I said before, it is the same panel for both RGB and DSI, and
> ICN6211 bridge is converter for RGB-to-DSI. we don't have any specific
> programming or detailed datasheet from this except BSP DSI panel
> sequence along with BSP panel timings which are similar to RGB one.
>
> 3. wrong picture rendering is something sprightliness followed by
> colors jerks, which I couldn't explain it properly ie reason I
> mentioned some generic term for understanding.

Some generic term doesn't explain anything, it barely makes a
statement.

> > You're answering one out of three questions.
> >
> > > > > Example: timings, where it produces the issue.
> > > > > {
> > > > >       .vdisplay       = 600,
> > > > >       .vsync_start    = 600 + 12,
> > > > >       .vsync_end      = 600 + 12 + 2,
> > > > >       .vtotal         = 600 + 12 + 2 + 21,
> > > > > }
> > > >
> > > > Can you 100% trust those timings?
> > >
> > > ie. reason, I have given the Mainline timings [1]. The above timings
> > > are wrongly mentioned actual timings are from [1]
> >
> > You're still answering partially here. Those timings are working for
> > RGB, you have no proof that we need to make the same adjustments for
> > DSI.
>
> It is RGB to DSI bridge on the same panel, as I explained above and it
> would shared same timings. I can confirm or proved it from BSP panel
> timings which are working. indeed same timings are been in Mainline
> tree, we can trust them atleast.

You're missing the point. If the bridge has a different tolerance
range to DSI timings for example, then you're screwed, even though the
timings work in RGB.

> > > > > It produces the desired start delay value as 19 but the correct working
> > > > > value should be 513.
> > > > >
> > > > > So, Fix it by computing proper video start delay.
> > > > >
> > > > > Fixes: 69006ef0ecb1 ("drm/sun4i: dsi: Change the start delay calculation")
> > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > ---
> > > > >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 10 ++++++++--
> > > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > > > index 62a508420227..8d6292c0158b 100644
> > > > > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > > > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > > > @@ -364,8 +364,14 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
> > > > >  static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
> > > > >                                          struct drm_display_mode *mode)
> > > > >  {
> > > > > -     u16 start = clamp(mode->vtotal - mode->vdisplay - 10, 8, 100);
> > > > > -     u16 delay = mode->vtotal - (mode->vsync_end - mode->vdisplay) + start;
> > > > > +     u16 delay = mode->vtotal - (mode->vsync_start - mode->vdisplay);
> > > > > +
> > > > > +     /**
> > > > > +      * BSP comment:
> > > > > +      * put start_delay to tcon. set ready sync early to dramfreq,
> > > > > +      * so set start_delay 1
> > > > > +      */
> > > >
> > > > That doesn't make any sense to me... What does it mean?
> > >
> > > Which is meaning as above stated as "BSP comment" from here[2]
> >
> > It doesn't matter where you took it from. If you cannot explain what
> > happen, putting a random label that doesn't explain anything will not
> > help.
>
> I have no idea or document to refer why this 1 would be added. so I
> used same comment from BSP like many places on sun4i does. w/o this +1
> the delay is computed to 512 which is not working and with this the
> desired delay is 513 which is perfectly working.
>
> If you have any idea on this, please share so-that I can add it in
> comment otherwise.

You're the one with the panel, the issue and apparently a solution,
and the whole problem we're having is because I don't have any idea on
what that issue is precisely, and neither why your solution makes sense.

I'm not sure I'm the best to write a comment in that situation.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--udtxcv6c7reia3ri
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKN1fgAKCRDj7w1vZxhR
xeE/APwJ6P50rKOZvJ71IaZ0Ft7qfzWfSI5WNwoLRnca/X4A2AEAsVv6PNIshCT/
RHPgyAEnrnIKEDiwoUN3EHaYWHjnMAg=
=pFtn
-----END PGP SIGNATURE-----

--udtxcv6c7reia3ri--
