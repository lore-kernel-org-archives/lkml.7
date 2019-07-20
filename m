Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3ACBC76196
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 07:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9238321873
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 07:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="O+LMCWhN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfGTHQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 03:16:40 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38541 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfGTHQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 03:16:39 -0400
Received: by mail-io1-f65.google.com with SMTP id j6so30867916ioa.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2019 00:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n6DYMx7wKaYROD5FVCd1p9bSE0uzUsWwaEufeVJ36kg=;
        b=O+LMCWhNC4mcdV8FP4xRuBHbY/qrm0mhaC6qhO7vfXmdUVIfl+ZbpG0uXFN2n2vvem
         b6oyea5YdCge1SWKMJwL9lkOSIxG0Yl2I1FZI6wJX41/+X/Hnio394p2D2aS51867md9
         7H4fqIG6RAsadOgYhehPlzumQatmB1d/TxKA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n6DYMx7wKaYROD5FVCd1p9bSE0uzUsWwaEufeVJ36kg=;
        b=Ye0mcbBpdRieM25amXtdNJIfOqFrvCSOf3DiiPDSMMwoyqI1AxKVozicCdJPV7skyF
         89M/2ZVt+DxpeervaHN8aXuAE7C5hOrl7Ujn7yj8sG7Vy27feNz2NzHhog3X10Qr6AWW
         dOC0JUsaZ7olgt6PSgmFcmSpGS5acLTbmXReRwLFCfiJKvIwGZNZevwheZGAtsgtm2L/
         4ineeKQT/1+XdFKTfMYPZmP1p3Jx54IbJqa+t9nLAxRdbKr6oUsZpQL+XmEZdSyDiBOi
         agldb9ZJhlUc69yCH55N8Pd6u1LDO/R4JI4rj4i0VR+0e4aQ9Wt5Q6ft8Aa6rFXQBhGq
         LeLw==
X-Gm-Message-State: APjAAAWJfkFK0nvPNX3BEuKsmGz2MZoROPkVt3t6mRPtyxo3/YoisQ8t
        E2ozf9BIcHhCN5jt2z3DERAGhltPxAAU13AIcxiQOw==
X-Google-Smtp-Source: APXvYqxrB0uRt9YtY4GDUUxefgLvzIIJ7vKZ4BIFtyOZPp//LSPjvCPr4jykQDuNHpHHozdXAz+HNCF1npTujMhRJDs=
X-Received: by 2002:a6b:5115:: with SMTP id f21mr3228832iob.173.1563606998627;
 Sat, 20 Jul 2019 00:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190605064933.6bmskkxzzgn35xz7@flea> <CAMty3ZCCP=oCqm5=49BsjwoxdDETgBfU_5g8fQ=bz=iWApV0tw@mail.gmail.com>
 <20190614142406.ybdiqfppo5mc5bgq@flea> <CAMty3ZB45cHx3WeXnywBh2_UA_bTmFs6yBTqLWA1BNf4fQtVvQ@mail.gmail.com>
 <20190625144930.5hegt6bkzqzykjid@flea> <CAMty3ZCmj0Rz7MMhLqihsvLQi+1CHf0fAoJQ4QN65xB-bwxaJw@mail.gmail.com>
 <20190703114933.u3x4ej3v7ocewvif@flea> <CAOf5uw=ZEvMV1hFQE986rNG_ctpReGbjbZzv0m=OzKPdBh57uQ@mail.gmail.com>
 <20190711100100.cty3s6rs3w27low6@flea> <CAOf5uw=3fiMuhcj3kDtCaGNTsxHKRrYb79MXZ+yUZtmf0jU10A@mail.gmail.com>
 <20190720065830.zn3txpyduakywcva@flea>
In-Reply-To: <20190720065830.zn3txpyduakywcva@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Sat, 20 Jul 2019 12:46:27 +0530
Message-ID: <CAMty3ZDE1xiNgHVLihH378dY5szzkr14V-fwLZdvPs12tY+G1A@mail.gmail.com>
Subject: Re: [PATCH v6 11/22] clk: sunxi-ng: a64: Add minimum rate for PLL_MIPI
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 20, 2019 at 12:28 PM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> On Thu, Jul 11, 2019 at 07:43:16PM +0200, Michael Nazzareno Trimarchi wrote:
> > > > tcon-pixel clock is the rate that you want to achive on display side
> > > > and if you have 4 lanes 32bit or lanes and different bit number that
> > > > you need to have a clock that is able to put outside bits and speed
> > > > equal to pixel-clock * bits / lanes. so If you want a pixel-clock of
> > > > 40 mhz and you have 32bits and 4 lanes you need to have a clock of
> > > > 40 * 32 / 4 in no-burst mode. I think that this is done but most of
> > > > the display.
> > >
> > > So this is what the issue is then?
> > >
> > > This one does make sense, and you should just change the rate in the
> > > call to clk_set_rate in sun4i_tcon0_mode_set_cpu.
> > >
> > > I'm still wondering why that hasn't been brought up in either the
> > > discussion or the commit log before though.
> > >
> > Something like this?
> >
> > drivers/gpu/drm/sun4i/sun4i_tcon.c     | 20 +++++++++++---------
> >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h |  2 --
> >  2 files changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > index 64c43ee6bd92..42560d5c327c 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > @@ -263,10 +263,11 @@ static int sun4i_tcon_get_clk_delay(const struct
> > drm_display_mode *mode,
> >  }
> >
> >  static void sun4i_tcon0_mode_set_common(struct sun4i_tcon *tcon,
> > -                                       const struct drm_display_mode *mode)
> > +                                       const struct drm_display_mode *mode,
> > +                                       u32 tcon_mul)
> >  {
> >         /* Configure the dot clock */
> > -       clk_set_rate(tcon->dclk, mode->crtc_clock * 1000);
> > +       clk_set_rate(tcon->dclk, mode->crtc_clock * tcon_mul * 1000);
> >
> >         /* Set the resolution */
> >         regmap_write(tcon->regs, SUN4I_TCON0_BASIC0_REG,
> > @@ -335,12 +336,13 @@ static void sun4i_tcon0_mode_set_cpu(struct
> > sun4i_tcon *tcon,
> >         u8 bpp = mipi_dsi_pixel_format_to_bpp(device->format);
> >         u8 lanes = device->lanes;
> >         u32 block_space, start_delay;
> > -       u32 tcon_div;
> > +       u32 tcon_div, tcon_mul;
> >
> > -       tcon->dclk_min_div = SUN6I_DSI_TCON_DIV;
> > -       tcon->dclk_max_div = SUN6I_DSI_TCON_DIV;
> > +       tcon->dclk_min_div = 4;
> > +       tcon->dclk_max_div = 127;
> >
> > -       sun4i_tcon0_mode_set_common(tcon, mode);
> > +       tcon_mul = bpp / lanes;
> > +       sun4i_tcon0_mode_set_common(tcon, mode, tcon_mul);
> >
> >         /* Set dithering if needed */
> >         sun4i_tcon0_mode_set_dithering(tcon, sun4i_tcon_get_connector(encoder));
> > @@ -366,7 +368,7 @@ static void sun4i_tcon0_mode_set_cpu(struct
> > sun4i_tcon *tcon,
> >          */
> >         regmap_read(tcon->regs, SUN4I_TCON0_DCLK_REG, &tcon_div);
> >         tcon_div &= GENMASK(6, 0);
> > -       block_space = mode->htotal * bpp / (tcon_div * lanes);
> > +       block_space = mode->htotal * tcon_div * tcon_mul;
> >         block_space -= mode->hdisplay + 40;
> >
> >         regmap_write(tcon->regs, SUN4I_TCON0_CPU_TRI0_REG,
> > @@ -408,7 +410,7 @@ static void sun4i_tcon0_mode_set_lvds(struct
> > sun4i_tcon *tcon,
> >
> >         tcon->dclk_min_div = 7;
> >         tcon->dclk_max_div = 7;
> > -       sun4i_tcon0_mode_set_common(tcon, mode);
> > +       sun4i_tcon0_mode_set_common(tcon, mode, 1);
> >
> >         /* Set dithering if needed */
> >         sun4i_tcon0_mode_set_dithering(tcon, sun4i_tcon_get_connector(encoder));
> > @@ -487,7 +489,7 @@ static void sun4i_tcon0_mode_set_rgb(struct
> > sun4i_tcon *tcon,
> >
> >         tcon->dclk_min_div = 6;
> >         tcon->dclk_max_div = 127;
> > -       sun4i_tcon0_mode_set_common(tcon, mode);
> > +       sun4i_tcon0_mode_set_common(tcon, mode, 1);
> >
> >         /* Set dithering if needed */
> >         sun4i_tcon0_mode_set_dithering(tcon, connector);
> > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> > b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> > index 5c3ad5be0690..a07090579f84 100644
> > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> > @@ -13,8 +13,6 @@
> >  #include <drm/drm_encoder.h>
> >  #include <drm/drm_mipi_dsi.h>
> >
> > -#define SUN6I_DSI_TCON_DIV     4
> > -
> >  struct sun6i_dsi {
> >         struct drm_connector    connector;
> >         struct drm_encoder      encoder;
>
> I had more something like this in mind:
> http://code.bulix.org/nlp5a4-803511

Worth to look at it. was it working on your panel? meanwhile I will check it.

We have updated with below change [1], seems working on but is
actually checking the each divider as before start with 4... till 127.

This new approach, is start looking the best divider from 4.. based on
the idea vs rounded it will ended up best divider like [2]

https://gist.github.com/openedev/7e2c33248b372d29be9979e06d483673
https://gist.github.com/openedev/c72dfffc0ca59e7ec1edcd7ad360cdd1

Jagan.
