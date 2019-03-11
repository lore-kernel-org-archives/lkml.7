Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1D8C10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4932084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FLRf+fk1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfCKQB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:01:26 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:52352 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfCKQBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:01:25 -0400
Received: by mail-it1-f195.google.com with SMTP id g17so8105110ita.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 09:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TMOi8B+1epU1K9RxGY+X9JnIHdYzFe8+3EHfpEokmkY=;
        b=FLRf+fk1TZIGb7sOTxWw6TueK1CN17obX7x/bk8oQ3hieAGf6DlKds0R5H7P6NCQVb
         U9bHExmfwU4I9hkoJvJSWVMnl8/Bj/1qVuO/19SaU6OqgTqWylID5nX6Fv2SaaxxLzAa
         hwtCQAaAhgKnB4sSoP+/txzAaY97jvnFb85GM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TMOi8B+1epU1K9RxGY+X9JnIHdYzFe8+3EHfpEokmkY=;
        b=WlfGZyEqT9/Yk0EDoK+kVSrj3DG/vnAQUAaBQYa1bB0bPHa5kqhE+GS0qCCYLoINvJ
         17lfgoSjcUrmSs/LUZnkYOaSaGzAGlAGHe0Z1dJSD/q964txbtdtdCyZpFg0Hczvtqa+
         lZCbIUIFNO+Ewx1DeTRSz9dOAWd7BQMwLPjMtCwwmvkIZWdZqDczwlw1+Oo9nCzrbqEN
         gRfXexWEvj1rD3qdpmA9pYmkDcrpZwKIx8i4cbniQp/dCMnXoOxR6/mRNLmkO215v1cS
         LPccb6nNh1ZqCbFVrkbKbFHRFxSuwcnWtbmNTgIsVAtRhqOLEedQXpy/AUsbQHCkn5t0
         dEPQ==
X-Gm-Message-State: APjAAAXjIDDUaT5qNOy7KR9Ysuu2MSHZYtPirRYpdWqVcMFyUU9+AKvK
        hVd1hreT/NSUFKqdozirVnZkyhFPtbPA8ZVJ9ByfKg==
X-Google-Smtp-Source: APXvYqwg59UDVOWE7z/p66RcYCYFpXYZVzNaNxc8DEk5jyLaaU5ZR7vkiUNMh2C0kQBomEoNZ/9wSb5kds+tkR4b6Gc=
X-Received: by 2002:a24:3655:: with SMTP id l82mr244741itl.107.1552320083085;
 Mon, 11 Mar 2019 09:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190311133637.18334-1-jagan@amarulasolutions.com>
 <20190311133637.18334-2-jagan@amarulasolutions.com> <20190311153734.izg44ijwqqh2vpxc@flea>
In-Reply-To: <20190311153734.izg44ijwqqh2vpxc@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 11 Mar 2019 21:31:11 +0530
Message-ID: <CAMty3ZDDARP02qMJZ9CXeiMv=kghoiUHgEAV9b4q+SrbLss40Q@mail.gmail.com>
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

On Mon, Mar 11, 2019 at 9:07 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Mon, Mar 11, 2019 at 07:06:23PM +0530, Jagan Teki wrote:
> > Vertical video start delay is computed by excluding vertical front
> > porch value from total vertical timings.
> >
> > This clearly confirmed from BSP code and here how it computed,
> >
> > (drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> > u32 vfp = panel->lcd_vt - panel->lcd_y - panel->lcd_vbp;
> > => (panel->lcd_vt) - panel->lcd_y - (panel->lcd_vbp)
> > => (timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y)
> >    - panel->lcd_y - (panel->lcd_vbp)
> > => timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y
> >                            - panel->lcd_y - panel->lcd_vbp
> > => timmings->ver_front_porch
> >
> > But the current driver is assuming it can exclude vertical front
> > porch along with vertical sync values from total vertical timings,
> > which resulting wrong start delay indeed wrong picture rendering
> > in the panel.
>
> Same story here: which panel, which datasheet, which "wrong picture
> rendering"?

It's bananapi,s070wv20-ct16 DSI

>
> > Example: timings, where it produces the issue.
> > {
> >       .vdisplay       = 600,
> >       .vsync_start    = 600 + 12,
> >       .vsync_end      = 600 + 12 + 2,
> >       .vtotal         = 600 + 12 + 2 + 21,
> > }
>
> Can you 100% trust those timings?

ie. reason, I have given the Mainline timings [1]. The above timings
are wrongly mentioned actual timings are from [1]

>
> > It produces the desired start delay value as 19 but the correct working
> > value should be 513.
> >
> > So, Fix it by computing proper video start delay.
> >
> > Fixes: 69006ef0ecb1 ("drm/sun4i: dsi: Change the start delay calculation")
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > index 62a508420227..8d6292c0158b 100644
> > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > @@ -364,8 +364,14 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
> >  static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
> >                                          struct drm_display_mode *mode)
> >  {
> > -     u16 start = clamp(mode->vtotal - mode->vdisplay - 10, 8, 100);
> > -     u16 delay = mode->vtotal - (mode->vsync_end - mode->vdisplay) + start;
> > +     u16 delay = mode->vtotal - (mode->vsync_start - mode->vdisplay);
> > +
> > +     /**
> > +      * BSP comment:
> > +      * put start_delay to tcon. set ready sync early to dramfreq,
> > +      * so set start_delay 1
> > +      */
>
> That doesn't make any sense to me... What does it mean?

Which is meaning as above stated as "BSP comment" from here[2]

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/gpu/drm/panel/panel-simple.c?id=7ad8b41cd8f5c2842646d01cdd576663caee04a7
[2] https://github.com/longsleep/linux-pine64/blob/pine64-hacks-1.2/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c#L729
