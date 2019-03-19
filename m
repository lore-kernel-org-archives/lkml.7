Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059CBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5D12147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfCSK4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:56:54 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:57897 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbfCSK4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 06:56:54 -0400
X-Originating-IP: 90.88.22.102
Received: from localhost (aaubervilliers-681-1-80-102.w90-88.abo.wanadoo.fr [90.88.22.102])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 0252324000D;
        Tue, 19 Mar 2019 10:56:48 +0000 (UTC)
Date:   Tue, 19 Mar 2019 11:56:48 +0100
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
Message-ID: <20190319105648.54i6pd4l74uvp4px@flea>
References: <20190303173527.31055-1-jagan@amarulasolutions.com>
 <20190303173527.31055-3-jagan@amarulasolutions.com>
 <20190304154320.uledvwz5jhzt22o3@flea>
 <CAMty3ZDWkLWgWhGWBjhXOsmAXzuGKGADAEhzB6gcL+jd7FRazQ@mail.gmail.com>
 <20190307153935.uxh2hsmahw5l7h4q@flea>
 <CAMty3ZDyk60R0YCsBV6toz84CFjD0D6uWyLVhmp8PC+Mj8GJpQ@mail.gmail.com>
 <20190311140923.vvtubx7wndos2rfr@flea>
 <CAMty3ZCABQ8Sa9+E_nznzMEYpvVm+KrnXDuEgt9qwue9t5Zs8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yq5mfqkzwjqz2gly"
Content-Disposition: inline
In-Reply-To: <CAMty3ZCABQ8Sa9+E_nznzMEYpvVm+KrnXDuEgt9qwue9t5Zs8g@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yq5mfqkzwjqz2gly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 11, 2019 at 08:28:22PM +0530, Jagan Teki wrote:
> On Mon, Mar 11, 2019 at 7:39 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Thu, Mar 07, 2019 at 09:24:02PM +0530, Jagan Teki wrote:
> > > On Thu, Mar 7, 2019 at 9:09 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > >
> > > > On Thu, Mar 07, 2019 at 05:49:07PM +0530, Jagan Teki wrote:
> > > > > On Mon, Mar 4, 2019 at 9:13 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > > >
> > > > > > On Sun, Mar 03, 2019 at 11:05:24PM +0530, Jagan Teki wrote:
> > > > > > > TCON DRQ for non-burst DSI mode can computed based on horizontal
> > > > > > > front porch value, but the current driver trying to include sync
> > > > > > > timings along with front porch resulting wrong drq.
> > > > > > >
> > > > > > > This patch is trying to update the drq by subtracting hsync_start
> > > > > > > with hdisplay, which is horizontal front porch.
> > > > > > >
> > > > > > > Current code:
> > > > > > > ------------
> > > > > > > mode->hsync_end - mode->hdisplay => horizontal front porch + sync
> > > > > > >
> > > > > > > With this patch:
> > > > > > > ----------------
> > > > > > > mode->hsync_start - mode->hdisplay => horizontal front porch
> > > > > > >
> > > > > > > BSP code form BPI-M64-bsp is computing TCON DRQ set bits
> > > > > > > for non-burts as (from linux-sunxi/
> > > > > > > drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> > > > > > >
> > > > > > > => panel->lcd_ht -    panel->lcd_x - panel->lcd_hbp
> > > > > > > => (timmings->hor_front_porch + panel->lcd_hbp + panel->lcd_x)
> > > > > >                                   ^ + sync length +
> > > > > > >    - panel->lcd_x - panel->hbp
> > > > > > > => timmings->hor_front_porch
> > > > > >                                ^ + sync
> > > > > > > => mode->hsync_start - mode->hdisplay
> > > > > >
> > > > > > s/hsync_start/hsync_end/
> > > > >
> > > > > No, it should be front porch so it is hsync_start. This change is
> > > > > trying to update DRQ set to use front porch and above evaluation from
> > > > > BSP, result the same front front porch
> > > > >
> > > > > Current driver has hsync_end - hdisplay which is not front porch
> > > > > timing (it is adding extra sync timing).
> > > >
> > > > It would be if you considered that the back porch actually was the
> > > > back porch plus the sync length. I have found no such evidence, quite
> > > > the opposite actually, everything seems to point at the fact that
> > > > unlike the TCON, the DSI block uses the back porch as only the back
> > > > porch.
> > >
> > > Sorry, I'm not clear about back porch here.
> > >
> > > The current code has mode->hsync_end - mode->hdisplay which is Front
> > > porch + sync time do you think it's not?
> >
> > It is.
> >
> > > DRQ set time is pure front porch value (according BSP) as I didn't
> > > see any information about DRQ set bits in manual or anywhere.
> >
> > This is what I'm telling you. If you consider the back porch as only
> > the back porch, then the result of that BSP calculation you mentionned
> > earlier is the front porch and the sync length.
> >
> > You imply that the back porch should actually be treated as the back
> > porch and the sync length in your calculation. What makes you say so?
>
> I'm consider the computations accordingly to drm_modes.h and which
> matches similar like BSP code.
>
> mode->hsync_end - mode->hdisplay = front porch + sync
>
> but the actual computation is
> mode->hsync_start - mode->hdisplay =>  front porch
>
> Which is similar to what BSP is using.
>
> => panel->lcd_ht -    panel->lcd_x - panel->lcd_hbp
> => (timmings->hor_front_porch + panel->lcd_hbp + panel->lcd_x)
>    - panel->lcd_x - panel->hbp
> => timmings->hor_front_porch
> => mode->hsync_start - mode->hdisplay

You're missing the point. What I'm asking for is why you think that
panel->lcd_ht == (timmings->hor_front_porch + panel->lcd_hbp +
panel->lcd_x) and not timmings->hor_front_porch + panel->lcd_hbp +
sync_width + panel->lcd_x

maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--yq5mfqkzwjqz2gly
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXJDK8AAKCRDj7w1vZxhR
xX6aAP48fRI+WU4lqXU8Mv9I+HjOVHSPrhKEHCi3Du8MJsInmQEAiILoHfuRbNsd
LPFYMlQd2/YX97K04SBzMcHd+/nFYgs=
=qhJp
-----END PGP SIGNATURE-----

--yq5mfqkzwjqz2gly--
