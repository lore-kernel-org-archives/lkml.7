Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B5BC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0825620693
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731824AbfDBOrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:47:46 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:48915 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbfDBOrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:47:46 -0400
X-Originating-IP: 90.88.30.125
Received: from localhost (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 408A22000E;
        Tue,  2 Apr 2019 14:47:43 +0000 (UTC)
Date:   Tue, 2 Apr 2019 16:47:42 +0200
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
Message-ID: <20190402144742.gdc57oxiqv3uz4o6@flea>
References: <20190303173527.31055-1-jagan@amarulasolutions.com>
 <20190303173527.31055-3-jagan@amarulasolutions.com>
 <20190304154320.uledvwz5jhzt22o3@flea>
 <CAMty3ZDWkLWgWhGWBjhXOsmAXzuGKGADAEhzB6gcL+jd7FRazQ@mail.gmail.com>
 <20190307153935.uxh2hsmahw5l7h4q@flea>
 <CAMty3ZDyk60R0YCsBV6toz84CFjD0D6uWyLVhmp8PC+Mj8GJpQ@mail.gmail.com>
 <20190311140923.vvtubx7wndos2rfr@flea>
 <CAMty3ZCABQ8Sa9+E_nznzMEYpvVm+KrnXDuEgt9qwue9t5Zs8g@mail.gmail.com>
 <20190319105648.54i6pd4l74uvp4px@flea>
 <CAMty3ZAp9tXD2dMKEdOYy6zftqobHNOs6U4fSUeAOfmSiO909A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kz6w2pkvgsyb3k3x"
Content-Disposition: inline
In-Reply-To: <CAMty3ZAp9tXD2dMKEdOYy6zftqobHNOs6U4fSUeAOfmSiO909A@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kz6w2pkvgsyb3k3x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 28, 2019 at 05:23:39PM +0530, Jagan Teki wrote:
> On Tue, Mar 19, 2019 at 4:26 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Mon, Mar 11, 2019 at 08:28:22PM +0530, Jagan Teki wrote:
> > > On Mon, Mar 11, 2019 at 7:39 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > >
> > > > On Thu, Mar 07, 2019 at 09:24:02PM +0530, Jagan Teki wrote:
> > > > > On Thu, Mar 7, 2019 at 9:09 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > > >
> > > > > > On Thu, Mar 07, 2019 at 05:49:07PM +0530, Jagan Teki wrote:
> > > > > > > On Mon, Mar 4, 2019 at 9:13 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > > > > >
> > > > > > > > On Sun, Mar 03, 2019 at 11:05:24PM +0530, Jagan Teki wrote:
> > > > > > > > > TCON DRQ for non-burst DSI mode can computed based on horizontal
> > > > > > > > > front porch value, but the current driver trying to include sync
> > > > > > > > > timings along with front porch resulting wrong drq.
> > > > > > > > >
> > > > > > > > > This patch is trying to update the drq by subtracting hsync_start
> > > > > > > > > with hdisplay, which is horizontal front porch.
> > > > > > > > >
> > > > > > > > > Current code:
> > > > > > > > > ------------
> > > > > > > > > mode->hsync_end - mode->hdisplay => horizontal front porch + sync
> > > > > > > > >
> > > > > > > > > With this patch:
> > > > > > > > > ----------------
> > > > > > > > > mode->hsync_start - mode->hdisplay => horizontal front porch
> > > > > > > > >
> > > > > > > > > BSP code form BPI-M64-bsp is computing TCON DRQ set bits
> > > > > > > > > for non-burts as (from linux-sunxi/
> > > > > > > > > drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> > > > > > > > >
> > > > > > > > > => panel->lcd_ht -    panel->lcd_x - panel->lcd_hbp
> > > > > > > > > => (timmings->hor_front_porch + panel->lcd_hbp + panel->lcd_x)
> > > > > > > >                                   ^ + sync length +
> > > > > > > > >    - panel->lcd_x - panel->hbp
> > > > > > > > > => timmings->hor_front_porch
> > > > > > > >                                ^ + sync
> > > > > > > > > => mode->hsync_start - mode->hdisplay
> > > > > > > >
> > > > > > > > s/hsync_start/hsync_end/
> > > > > > >
> > > > > > > No, it should be front porch so it is hsync_start. This change is
> > > > > > > trying to update DRQ set to use front porch and above evaluation from
> > > > > > > BSP, result the same front front porch
> > > > > > >
> > > > > > > Current driver has hsync_end - hdisplay which is not front porch
> > > > > > > timing (it is adding extra sync timing).
> > > > > >
> > > > > > It would be if you considered that the back porch actually was the
> > > > > > back porch plus the sync length. I have found no such evidence, quite
> > > > > > the opposite actually, everything seems to point at the fact that
> > > > > > unlike the TCON, the DSI block uses the back porch as only the back
> > > > > > porch.
> > > > >
> > > > > Sorry, I'm not clear about back porch here.
> > > > >
> > > > > The current code has mode->hsync_end - mode->hdisplay which is Front
> > > > > porch + sync time do you think it's not?
> > > >
> > > > It is.
> > > >
> > > > > DRQ set time is pure front porch value (according BSP) as I didn't
> > > > > see any information about DRQ set bits in manual or anywhere.
> > > >
> > > > This is what I'm telling you. If you consider the back porch as only
> > > > the back porch, then the result of that BSP calculation you mentionned
> > > > earlier is the front porch and the sync length.
> > > >
> > > > You imply that the back porch should actually be treated as the back
> > > > porch and the sync length in your calculation. What makes you say so?
> > >
> > > I'm consider the computations accordingly to drm_modes.h and which
> > > matches similar like BSP code.
> > >
> > > mode->hsync_end - mode->hdisplay = front porch + sync
> > >
> > > but the actual computation is
> > > mode->hsync_start - mode->hdisplay =>  front porch
> > >
> > > Which is similar to what BSP is using.
> > >
> > > => panel->lcd_ht -    panel->lcd_x - panel->lcd_hbp
> > > => (timmings->hor_front_porch + panel->lcd_hbp + panel->lcd_x)
> > >    - panel->lcd_x - panel->hbp
> > > => timmings->hor_front_porch
> > > => mode->hsync_start - mode->hdisplay
> >
> > You're missing the point. What I'm asking for is why you think that
> > panel->lcd_ht == (timmings->hor_front_porch + panel->lcd_hbp +
> > panel->lcd_x) and not timmings->hor_front_porch + panel->lcd_hbp +
> > sync_width + panel->lcd_x
>
> No ie not true we can't include sync_width, please see here [1]
>
> timmings->hor_front_porch= panel_info->lcd_ht-panel_info->lcd_hbp -
> panel_info->lcd_x;
> panel_info->lcd_ht = timmings->hor_front_porch + panel_info->lcd_hbp +
> panel_info->lcd_x;
>
> and the result of this lcd_ht is exactly matched with Mainline timings
> or any supported panel in A64.
>
> [1] https://github.com/longsleep/linux-pine64/blob/pine64-hacks-1.2/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L1839

Can we please start to reason in actual timings instead of whatever
Allwinner comes up with in their BSP?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--kz6w2pkvgsyb3k3x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKN2DgAKCRDj7w1vZxhR
xSqeAQDx9BENI+4TJ3ci0QpZ7BjfMqO0Vh62flCE/SGh1xBZ1AEA90msbhYdW4kl
QZEV8OU5fZZksH7oMSKF0v0/jry/Wwg=
=fcSY
-----END PGP SIGNATURE-----

--kz6w2pkvgsyb3k3x--
