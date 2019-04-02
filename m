Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5015C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733512146E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="j4PsAVhf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbfDBNen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:34:43 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37244 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729532AbfDBNem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:34:42 -0400
Received: by mail-io1-f68.google.com with SMTP id x7so10904630ioh.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 06:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NzwaModfMrO6JsV2pjEKJScrv/U9qiF3UHNREeBewKE=;
        b=j4PsAVhfC72vz57HQmiLjnKkev0PnMZ19jaSVAL3Zy5ScTHC35ifWr0iZY+6pf11yM
         tiQRY6ySFhaJGWpJXc5985XWnosVZ4ICCWQoGFDYik3tffr4l2DNw3+NqWauhl2h7vyU
         sun80LLy7i4BJKRKjlOAMbQD6YGmWs7xZbbfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NzwaModfMrO6JsV2pjEKJScrv/U9qiF3UHNREeBewKE=;
        b=q1YfHMeiTzFxuSw3ktqf5IKT2DV927R2RTEDOW9VTVdfKPTj1yUF0mTaMybykapwCL
         xp0vpEfGtItYCgUFuxKNZXNCte6KmhbQdCyRvj4O8BjgJSDez/3wiuSNIB9UoulJonrr
         O6xg2sJloCGnNchXzEhykiHBdeM0b62KOoInULyOyjiPk1TaMmrm12eQ7UyE3yFuHjRh
         Qynq5dAl6oJskAschA77u7GIg9ZMtUI20OgcjylEN1W93ulkFsmG8qWyCyaMFiRuEoRe
         42Cj+MT0ymKzxih/RVfQfieIs/UQ1nK8d8VfxUl86i1suFYPLH2DR+v4HtLKUVeWLcM8
         PF0Q==
X-Gm-Message-State: APjAAAVv75GGuaABXygMpBwPUKoNZfOUAMU0aGvVYZZGmy4ExWmAJgvl
        shOFoOOIbh50IFiaUActeeQabm6MMHlq0zAWTsZaDg==
X-Google-Smtp-Source: APXvYqxO1BdPHlCGT19+/GZVwZWaFTywYA5hGVKHx1w6VOKs6qxz4Ns0w7qUhT9RWWPjU1ozwQTDWgeZRCLrgKBjx84=
X-Received: by 2002:a6b:7601:: with SMTP id g1mr50159844iom.108.1554212081888;
 Tue, 02 Apr 2019 06:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190311133637.18334-1-jagan@amarulasolutions.com>
 <20190311133637.18334-2-jagan@amarulasolutions.com> <20190311153734.izg44ijwqqh2vpxc@flea>
 <CAMty3ZDDARP02qMJZ9CXeiMv=kghoiUHgEAV9b4q+SrbLss40Q@mail.gmail.com>
 <20190319102520.ldgjtyzrphuib3td@flea> <CAMty3ZC+dTVuc2TWR=cqKNbrZe6j2vnwfXAqg6RbvduvY_63LA@mail.gmail.com>
In-Reply-To: <CAMty3ZC+dTVuc2TWR=cqKNbrZe6j2vnwfXAqg6RbvduvY_63LA@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 2 Apr 2019 19:04:30 +0530
Message-ID: <CAMty3ZA9x356e1y_aajSpviycnPR8GA0794BCR6dKMRYuw=zOg@mail.gmail.com>
Subject: Re: [PATCH v8 01/15] drm/sun4i: dsi: Fix video start delay computation
To:     Maxime Ripard <maxime.ripard@bootlin.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Thu, Mar 21, 2019 at 8:08 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
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
>
> >
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
>
> >
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

Any further comments?
