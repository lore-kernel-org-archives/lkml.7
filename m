Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98FDC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912D9214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="L3PUE6BX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbfGVKjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 06:39:01 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38694 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfGVKjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 06:39:01 -0400
Received: by mail-io1-f68.google.com with SMTP id j6so40507555ioa.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 03:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X785RGDb03Vq0xPt63zvV6RuQKZu42hQ10CfPa5muiI=;
        b=L3PUE6BXdpA5N40F6qwOGK+dyroQkZ1FuWXkM0SPLMAnUlMAXykqnASqRtwbPCQfI3
         S8JA11NUkZEDrmQcq9AxJy4+4SX9QoEvXwOATemdaG/vwWk2A1F/7QrAGQJ15PzbpVC2
         pky69Fpti79diYMC8LFd46iAuc2Odrs96fqsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X785RGDb03Vq0xPt63zvV6RuQKZu42hQ10CfPa5muiI=;
        b=ooChm2lXfSyr3pQwbf1EyhMa4YnyzvUMQhUFKFhf7Qq3cwB1C+reTgDonxVj5AkDJ1
         qAVnCeVqbwzZjLEbCfHjtDmDzoNazLQKwLlCe/GpCzuPPR1jd81hcVsokbZdvoDfBcvX
         aRnNzbv0acTa31hzovDxTfkuVcUvGAbJYbCwWLnw3tts+jNEPpcZLdKTErx1Qc4HyzpC
         52hQYMbGDAdoi4OmUW1eaIrsissXYi6HL0e+NX+QOmBhudfOJ5SezibpCAgDSesAROFl
         UpXXESQh/Hk+9BaAtveqgcrjQVl/622wpt35vXbKN2n+Afoptv69mRFRmN17biyCfdpm
         zCRA==
X-Gm-Message-State: APjAAAXouag3H4SW3nPcvbI5bydYb5NODx+ddrv8g0Oj/LXPVaRp5EJj
        /7b32OEhyiWMuQVeW18MZKxcazAttAB7ReoWeqzcJI/arxk=
X-Google-Smtp-Source: APXvYqxkgQKBaOceS6jITojTL/X3zdR1BTAIItg0O18lfygV1MiQAI59qRJfJF7MjiinnCKCiM8ngrOm6Vz/Wy+Xjtk=
X-Received: by 2002:a05:6638:303:: with SMTP id w3mr18087166jap.103.1563791939954;
 Mon, 22 Jul 2019 03:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190614142406.ybdiqfppo5mc5bgq@flea> <CAMty3ZB45cHx3WeXnywBh2_UA_bTmFs6yBTqLWA1BNf4fQtVvQ@mail.gmail.com>
 <20190625144930.5hegt6bkzqzykjid@flea> <CAMty3ZCmj0Rz7MMhLqihsvLQi+1CHf0fAoJQ4QN65xB-bwxaJw@mail.gmail.com>
 <20190703114933.u3x4ej3v7ocewvif@flea> <CAOf5uw=ZEvMV1hFQE986rNG_ctpReGbjbZzv0m=OzKPdBh57uQ@mail.gmail.com>
 <20190711100100.cty3s6rs3w27low6@flea> <CAOf5uw=3fiMuhcj3kDtCaGNTsxHKRrYb79MXZ+yUZtmf0jU10A@mail.gmail.com>
 <20190720065830.zn3txpyduakywcva@flea> <CAMty3ZDE1xiNgHVLihH378dY5szzkr14V-fwLZdvPs12tY+G1A@mail.gmail.com>
 <20190720093202.6fn6xmhvsgawscnu@flea> <CAMty3ZDpOA1mD77t3RB6hEG7o3+ws8y64m1DU8=3HdZ4zy4AUw@mail.gmail.com>
 <CAOf5uw=5j+8XNv_ZBhY0yrnjjNnaV_w=a4oiV11LoksAfEY7AA@mail.gmail.com>
In-Reply-To: <CAOf5uw=5j+8XNv_ZBhY0yrnjjNnaV_w=a4oiV11LoksAfEY7AA@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 22 Jul 2019 16:08:48 +0530
Message-ID: <CAMty3ZCrj_9Lp15y6bcFErgXaATVjWibV3tO884G31RtVWmuxA@mail.gmail.com>
Subject: Re: [PATCH v6 11/22] clk: sunxi-ng: a64: Add minimum rate for PLL_MIPI
To:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
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

On Mon, Jul 22, 2019 at 3:55 PM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi Jagan
>
> On Mon, Jul 22, 2019 at 12:21 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > Hi Maxime,
> >
> > On Sat, Jul 20, 2019 at 3:02 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Sat, Jul 20, 2019 at 12:46:27PM +0530, Jagan Teki wrote:
> > > > On Sat, Jul 20, 2019 at 12:28 PM Maxime Ripard
> > > > <maxime.ripard@bootlin.com> wrote:
> > > > >
> > > > > On Thu, Jul 11, 2019 at 07:43:16PM +0200, Michael Nazzareno Trimarchi wrote:
> > > > > > > > tcon-pixel clock is the rate that you want to achive on display side
> > > > > > > > and if you have 4 lanes 32bit or lanes and different bit number that
> > > > > > > > you need to have a clock that is able to put outside bits and speed
> > > > > > > > equal to pixel-clock * bits / lanes. so If you want a pixel-clock of
> > > > > > > > 40 mhz and you have 32bits and 4 lanes you need to have a clock of
> > > > > > > > 40 * 32 / 4 in no-burst mode. I think that this is done but most of
> > > > > > > > the display.
> > > > > > >
> > > > > > > So this is what the issue is then?
> > > > > > >
> > > > > > > This one does make sense, and you should just change the rate in the
> > > > > > > call to clk_set_rate in sun4i_tcon0_mode_set_cpu.
> > > > > > >
> > > > > > > I'm still wondering why that hasn't been brought up in either the
> > > > > > > discussion or the commit log before though.
> > > > > > >
> > > > > > Something like this?
> > > > > >
> > > > > > drivers/gpu/drm/sun4i/sun4i_tcon.c     | 20 +++++++++++---------
> > > > > >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h |  2 --
> > > > > >  2 files changed, 11 insertions(+), 11 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > > > > > b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > > > > > index 64c43ee6bd92..42560d5c327c 100644
> > > > > > --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > > > > > +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > > > > > @@ -263,10 +263,11 @@ static int sun4i_tcon_get_clk_delay(const struct
> > > > > > drm_display_mode *mode,
> > > > > >  }
> > > > > >
> > > > > >  static void sun4i_tcon0_mode_set_common(struct sun4i_tcon *tcon,
> > > > > > -                                       const struct drm_display_mode *mode)
> > > > > > +                                       const struct drm_display_mode *mode,
> > > > > > +                                       u32 tcon_mul)
> > > > > >  {
> > > > > >         /* Configure the dot clock */
> > > > > > -       clk_set_rate(tcon->dclk, mode->crtc_clock * 1000);
> > > > > > +       clk_set_rate(tcon->dclk, mode->crtc_clock * tcon_mul * 1000);
> > > > > >
> > > > > >         /* Set the resolution */
> > > > > >         regmap_write(tcon->regs, SUN4I_TCON0_BASIC0_REG,
> > > > > > @@ -335,12 +336,13 @@ static void sun4i_tcon0_mode_set_cpu(struct
> > > > > > sun4i_tcon *tcon,
> > > > > >         u8 bpp = mipi_dsi_pixel_format_to_bpp(device->format);
> > > > > >         u8 lanes = device->lanes;
> > > > > >         u32 block_space, start_delay;
> > > > > > -       u32 tcon_div;
> > > > > > +       u32 tcon_div, tcon_mul;
> > > > > >
> > > > > > -       tcon->dclk_min_div = SUN6I_DSI_TCON_DIV;
> > > > > > -       tcon->dclk_max_div = SUN6I_DSI_TCON_DIV;
> > > > > > +       tcon->dclk_min_div = 4;
> > > > > > +       tcon->dclk_max_div = 127;
> > > > > >
> > > > > > -       sun4i_tcon0_mode_set_common(tcon, mode);
> > > > > > +       tcon_mul = bpp / lanes;
> > > > > > +       sun4i_tcon0_mode_set_common(tcon, mode, tcon_mul);
> > > > > >
> > > > > >         /* Set dithering if needed */
> > > > > >         sun4i_tcon0_mode_set_dithering(tcon, sun4i_tcon_get_connector(encoder));
> > > > > > @@ -366,7 +368,7 @@ static void sun4i_tcon0_mode_set_cpu(struct
> > > > > > sun4i_tcon *tcon,
> > > > > >          */
> > > > > >         regmap_read(tcon->regs, SUN4I_TCON0_DCLK_REG, &tcon_div);
> > > > > >         tcon_div &= GENMASK(6, 0);
> > > > > > -       block_space = mode->htotal * bpp / (tcon_div * lanes);
> > > > > > +       block_space = mode->htotal * tcon_div * tcon_mul;
> > > > > >         block_space -= mode->hdisplay + 40;
> > > > > >
> > > > > >         regmap_write(tcon->regs, SUN4I_TCON0_CPU_TRI0_REG,
> > > > > > @@ -408,7 +410,7 @@ static void sun4i_tcon0_mode_set_lvds(struct
> > > > > > sun4i_tcon *tcon,
> > > > > >
> > > > > >         tcon->dclk_min_div = 7;
> > > > > >         tcon->dclk_max_div = 7;
> > > > > > -       sun4i_tcon0_mode_set_common(tcon, mode);
> > > > > > +       sun4i_tcon0_mode_set_common(tcon, mode, 1);
> > > > > >
> > > > > >         /* Set dithering if needed */
> > > > > >         sun4i_tcon0_mode_set_dithering(tcon, sun4i_tcon_get_connector(encoder));
> > > > > > @@ -487,7 +489,7 @@ static void sun4i_tcon0_mode_set_rgb(struct
> > > > > > sun4i_tcon *tcon,
> > > > > >
> > > > > >         tcon->dclk_min_div = 6;
> > > > > >         tcon->dclk_max_div = 127;
> > > > > > -       sun4i_tcon0_mode_set_common(tcon, mode);
> > > > > > +       sun4i_tcon0_mode_set_common(tcon, mode, 1);
> > > > > >
> > > > > >         /* Set dithering if needed */
> > > > > >         sun4i_tcon0_mode_set_dithering(tcon, connector);
> > > > > > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> > > > > > b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> > > > > > index 5c3ad5be0690..a07090579f84 100644
> > > > > > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> > > > > > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> > > > > > @@ -13,8 +13,6 @@
> > > > > >  #include <drm/drm_encoder.h>
> > > > > >  #include <drm/drm_mipi_dsi.h>
> > > > > >
> > > > > > -#define SUN6I_DSI_TCON_DIV     4
> > > > > > -
> > > > > >  struct sun6i_dsi {
> > > > > >         struct drm_connector    connector;
> > > > > >         struct drm_encoder      encoder;
> > > > >
> > > > > I had more something like this in mind:
> > > > > http://code.bulix.org/nlp5a4-803511
> > > >
> > > > Worth to look at it. was it working on your panel? meanwhile I will check it.
> > >
> > > I haven't tested it.
> > >
> > > > We have updated with below change [1], seems working on but is
> > > > actually checking the each divider as before start with 4... till 127.
> > > >
> > > > This new approach, is start looking the best divider from 4.. based on
> > > > the idea vs rounded it will ended up best divider like [2]
> > >
> > > But why?
> > >
> > > I mean, it's not like it's the first time I'm asking this...
> > >
> > > If the issue is what Micheal described, then the divider has nothing
> > > to do with it. We've had that discussion over and over again.
> >
> > This is what Michael is mentioned in above mail
> > "tcon-pixel clock is the rate that you want to achive on display side and
> > if you have 4 lanes 32bit or lanes and different bit number that you need
> > to have a clock that is able to put outside bits and speed equal to
> > pixel-clock * bits / lanes. so If you want a pixel-clock of 40 mhz
> > and you have 32bits and 4 lanes you need to have a clock of
> > 40 * 32 / 4 in no-burst mode. "
> >
> > He is trying to manage the bpp/lanes into dclk_mul (in last mail) and
> > it can multiply with pixel clock which is rate argument in
> > sun4i_dclk_round_rate.
> >
> > The solution I have mentioned in dclk_min, max is bpp/lanes also
> > multiple rate in dotclock sun4i_dclk_round_rate.
> >
> > In both cases the overall pll_rate depends on dividers, the one that I
> > have on this patch is based on BSP and the Michael one is more generic
> > way so-that it can not to touch other functionalities and looping
> > dividers to find the best one.
> >
> > If dclk_min/max is bpp/lanes then dotclock directly using divider 6
> > (assuming 24-bit and 4 lanes) and return the pll_rate and divider 6
> > associated.
> >
> > if dclk_mul is bpp/lanes, on Michael new change, the dividers start
> > with 4 and end with 127 but the constant ideal rate which rate *
> > bpp/lanes but the loop from sun4i_dclk_round_rate computed the divider
> > as 6 only, ie what I'm mentioned on the above mail.
> >
>
> tcon-pixel clock and tcon are mutual connected. The code is done in a way
> that optimal clock need to be search. Now the patch that I propose is more
> connected to the description I gave.

True, ie what I'm trying to say in above mail.  My idea on the above
mail is to give more information on the both the solutions (one on the
this patch and another you mentioned on above mail) are depends on
divider value for computing desired pll_rate.

>
> I need some comment from Maxime, what he prefers or we need to search for
> a different one. I don't had time to check Maxime proposal because I'm working
> on other projects.

I already provide my logs on Maxime change.if you want you can have a look.
