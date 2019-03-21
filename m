Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03F2C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6131820830
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="B/MTc6FK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfCUOjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:39:12 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:40100 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfCUOjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:39:12 -0400
Received: by mail-it1-f194.google.com with SMTP id l139so4391049ita.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 07:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=caNEbSEGdMRUhb7Ixa2bcE1bckNZ3P3M0HJR9FDriCo=;
        b=B/MTc6FKftVTTf+la1N2OYnKKBP7SZe/2vApEwO8XANvTXXZ9BURpAtJG1aG3YL39E
         F7UBmEV1IaLDAFK91z+cuymxqINB2qiI3WC+zMZsSfVrZS8XVfEKd4fM8M9OBfDqinHX
         /gjeA3/PEvBq28CNrpqte+6tumpe1Zl9LOwVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=caNEbSEGdMRUhb7Ixa2bcE1bckNZ3P3M0HJR9FDriCo=;
        b=Wm3MThmeaRxdPJ15D1BEAfQ50kPQ9yKLLUqGlNrEcaTmjK1iq4uB0AXiBXO3ijjb2Z
         WyEsDF7ZdYTQv5qza4Tngof5A6GKc9rbwf3HtMSXDG5cHIshI0IDlQbUoHzKPgQ3sByX
         Pj070vPwuhNn/ZnjpiIO4bso4qJkeY+RcXAIZa99x7rsGqq+l1VBMqHFXzW2HoPwf71X
         O3YHulFRSOIdKYsMc9oxuAhH4yTzug4Q2g8FB/q7WVsMPYn+l+rhXlbe1C+NC3zhQGQh
         IeacJyB2ZT0OCGhp7ihsobgez7z3t6vK2h/LLC9dPf2yvPTq69/AyFaW5d+2W6NoJo5r
         Rc5A==
X-Gm-Message-State: APjAAAVld1hzPJ56/ndKiuXpm3DTixm/Aj+QjpDh2G8r6j0GABp7UT0D
        S5Ma6HzJxX1pHWfxU4ikpikWkhd44SkuxGkQTD1DfQ==
X-Google-Smtp-Source: APXvYqzIt5b8qkhy+DpcMutq3rTziyyFTkqCC+akkHxgRIaTVat/lN5pRJTP02biLZ02xqTu8IsN8Ba+1fA0LrdPt4M=
X-Received: by 2002:a24:72c6:: with SMTP id x189mr2897332itc.32.1553179150617;
 Thu, 21 Mar 2019 07:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190311133637.18334-1-jagan@amarulasolutions.com>
 <20190311133637.18334-2-jagan@amarulasolutions.com> <20190311153734.izg44ijwqqh2vpxc@flea>
 <CAMty3ZDDARP02qMJZ9CXeiMv=kghoiUHgEAV9b4q+SrbLss40Q@mail.gmail.com> <20190319102520.ldgjtyzrphuib3td@flea>
In-Reply-To: <20190319102520.ldgjtyzrphuib3td@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 21 Mar 2019 20:08:58 +0530
Message-ID: <CAMty3ZC+dTVuc2TWR=cqKNbrZe6j2vnwfXAqg6RbvduvY_63LA@mail.gmail.com>
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

On Tue, Mar 19, 2019 at 3:55 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Mon, Mar 11, 2019 at 09:31:11PM +0530, Jagan Teki wrote:
> > On Mon, Mar 11, 2019 at 9:07 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Mon, Mar 11, 2019 at 07:06:23PM +0530, Jagan Teki wrote:
> > > > Vertical video start delay is computed by excluding vertical front
> > > > porch value from total vertical timings.
> > > >
> > > > This clearly confirmed from BSP code and here how it computed,
> > > >
> > > > (drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> > > > u32 vfp = panel->lcd_vt - panel->lcd_y - panel->lcd_vbp;
> > > > => (panel->lcd_vt) - panel->lcd_y - (panel->lcd_vbp)
> > > > => (timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y)
> > > >    - panel->lcd_y - (panel->lcd_vbp)
> > > > => timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y
> > > >                            - panel->lcd_y - panel->lcd_vbp
> > > > => timmings->ver_front_porch
> > > >
> > > > But the current driver is assuming it can exclude vertical front
> > > > porch along with vertical sync values from total vertical timings,
> > > > which resulting wrong start delay indeed wrong picture rendering
> > > > in the panel.
> > >
> > > Same story here: which panel, which datasheet, which "wrong picture
> > > rendering"?
> >
> > It's bananapi,s070wv20-ct16 DSI

2. as I said before, it is the same panel for both RGB and DSI, and
ICN6211 bridge is converter for RGB-to-DSI. we don't have any specific
programming or detailed datasheet from this except BSP DSI panel
sequence along with BSP panel timings which are similar to RGB one.

3. wrong picture rendering is something sprightliness followed by
colors jerks, which I couldn't explain it properly ie reason I
mentioned some generic term for understanding.

>
> You're answering one out of three questions.
>
> > > > Example: timings, where it produces the issue.
> > > > {
> > > >       .vdisplay       = 600,
> > > >       .vsync_start    = 600 + 12,
> > > >       .vsync_end      = 600 + 12 + 2,
> > > >       .vtotal         = 600 + 12 + 2 + 21,
> > > > }
> > >
> > > Can you 100% trust those timings?
> >
> > ie. reason, I have given the Mainline timings [1]. The above timings
> > are wrongly mentioned actual timings are from [1]
>
> You're still answering partially here. Those timings are working for
> RGB, you have no proof that we need to make the same adjustments for
> DSI.

It is RGB to DSI bridge on the same panel, as I explained above and it
would shared same timings. I can confirm or proved it from BSP panel
timings which are working. indeed same timings are been in Mainline
tree, we can trust them atleast.

>
> > > > It produces the desired start delay value as 19 but the correct working
> > > > value should be 513.
> > > >
> > > > So, Fix it by computing proper video start delay.
> > > >
> > > > Fixes: 69006ef0ecb1 ("drm/sun4i: dsi: Change the start delay calculation")
> > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > ---
> > > >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 10 ++++++++--
> > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > > index 62a508420227..8d6292c0158b 100644
> > > > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > > @@ -364,8 +364,14 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
> > > >  static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
> > > >                                          struct drm_display_mode *mode)
> > > >  {
> > > > -     u16 start = clamp(mode->vtotal - mode->vdisplay - 10, 8, 100);
> > > > -     u16 delay = mode->vtotal - (mode->vsync_end - mode->vdisplay) + start;
> > > > +     u16 delay = mode->vtotal - (mode->vsync_start - mode->vdisplay);
> > > > +
> > > > +     /**
> > > > +      * BSP comment:
> > > > +      * put start_delay to tcon. set ready sync early to dramfreq,
> > > > +      * so set start_delay 1
> > > > +      */
> > >
> > > That doesn't make any sense to me... What does it mean?
> >
> > Which is meaning as above stated as "BSP comment" from here[2]
>
> It doesn't matter where you took it from. If you cannot explain what
> happen, putting a random label that doesn't explain anything will not
> help.

I have no idea or document to refer why this 1 would be added. so I
used same comment from BSP like many places on sun4i does. w/o this +1
the delay is computed to 512 which is not working and with this the
desired delay is 513 which is perfectly working.

If you have any idea on this, please share so-that I can add it in
comment otherwise.

Jagan.
