Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D7BC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 06:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1278920644
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 06:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="eyEFx7Ic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfG2G7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 02:59:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53282 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbfG2G7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 02:59:20 -0400
Received: by mail-wm1-f68.google.com with SMTP id x15so52746148wmj.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 23:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WdNVaqUhdH7oW+fwcGR8G6amm2wx7+HLe9zq6HFmEiI=;
        b=eyEFx7Icsfu+CUq4Ppda2EPce21BwzOmDs0nd5M8t9uN1iMDxXI+MkpQfDp+1dkaEn
         znzeaPBheFleG9xwsWWWAp0V5Slg0tCRfTmJEt31vtIQ5vgHU9qURQDUpZVpAMs1Z2Eo
         L5OYK6bVkKrxY4gZtFcmmbmJFfRuWfWQvPOm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WdNVaqUhdH7oW+fwcGR8G6amm2wx7+HLe9zq6HFmEiI=;
        b=pzcsu3Z6IAbHXYVwMTPmEq+Ae1zIvLljN8EM+8wEVKT+uR+swJrRDxsd8CLqf85tJa
         vifaOQA1LpQy8tT2z0nKgdd2bA6l45FWUAcs2AFg6r14S4ien5uVlBn7UqrJcxkfMqpL
         5GvRq/r51XF7xc5XpCoNHHZa7PFfQ4J0IF1zmjCJjNRmsbF4QKpfT9x8hY1AAoYVFklB
         quUpDYWh9qIo/eHqbtRV36w0XRrdbWvNlUh7x4VdzLdSsufGEy8Wx7OPb0ZRGAQ+BX39
         zg3Hp9wn9x035Kjfv5Ol7NcXzh82e3qwe0sBI7Ya2sF+miIvQTTqcNtSOVsDFdy8ys++
         yb7A==
X-Gm-Message-State: APjAAAVUvpMFpBqcpPBmqCuoOzCU+MSHId0aZnGNHc57lJKgr0r4bCk8
        llSrcEB23SGALjDMNlPrGP/f7oCpUtjTSkv+8lZ/7Q==
X-Google-Smtp-Source: APXvYqxxTUG4jxVwawUTZ5umF2B4akxxNIKm+pHEc6XgYB7rTEHgz64m8Wlv4tnj3zYknNEjJ+UOfhVDZUSR38VTveU=
X-Received: by 2002:a7b:cf32:: with SMTP id m18mr69037468wmg.27.1564383556328;
 Sun, 28 Jul 2019 23:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190625144930.5hegt6bkzqzykjid@flea> <CAMty3ZCmj0Rz7MMhLqihsvLQi+1CHf0fAoJQ4QN65xB-bwxaJw@mail.gmail.com>
 <20190703114933.u3x4ej3v7ocewvif@flea> <CAOf5uw=ZEvMV1hFQE986rNG_ctpReGbjbZzv0m=OzKPdBh57uQ@mail.gmail.com>
 <20190711100100.cty3s6rs3w27low6@flea> <CAOf5uw=3fiMuhcj3kDtCaGNTsxHKRrYb79MXZ+yUZtmf0jU10A@mail.gmail.com>
 <20190720065830.zn3txpyduakywcva@flea> <CAMty3ZDE1xiNgHVLihH378dY5szzkr14V-fwLZdvPs12tY+G1A@mail.gmail.com>
 <20190720093202.6fn6xmhvsgawscnu@flea> <CAMty3ZDpOA1mD77t3RB6hEG7o3+ws8y64m1DU8=3HdZ4zy4AUw@mail.gmail.com>
 <20190724090513.vqnlmya3nqkl6pmu@flea>
In-Reply-To: <20190724090513.vqnlmya3nqkl6pmu@flea>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Mon, 29 Jul 2019 08:59:04 +0200
Message-ID: <CAOf5uwkvCs62zHcUoFuJwau_ZZFdnVf8ua6JY_wzUb9m8rLTTw@mail.gmail.com>
Subject: Re: [PATCH v6 11/22] clk: sunxi-ng: a64: Add minimum rate for PLL_MIPI
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
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

Hi

On Wed, Jul 24, 2019 at 11:05 AM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> On Mon, Jul 22, 2019 at 03:51:04PM +0530, Jagan Teki wrote:
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
> > This is what Michael is mentioned in above mail "tcon-pixel clock is
> > the rate that you want to achive on display side and if you have 4
> > lanes 32bit or lanes and different bit number that you need to have
> > a clock that is able to put outside bits and speed equal to
> > pixel-clock * bits / lanes. so If you want a pixel-clock of 40 mhz
> > and you have 32bits and 4 lanes you need to have a clock of 40 * 32
> > / 4 in no-burst mode. "
>
> Yeah, so we need to change the clock rate.
>
> > He is trying to manage the bpp/lanes into dclk_mul (in last mail)
> > and it can multiply with pixel clock which is rate argument in
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
>
> We've been over this a couple of times already.
>
> The clock is generated like this:
>
> PLL -> TCON Module Clock -> TCON DCLK
>
> You want the TCON DCLK to be at the pixel clock rate * bpp /
> lanes. Fine, that makes sense.
>
> Except that the patch you've sent, instead of changing the rate
> itself, changes the ratio between the module clock and DCLK.
>
> And this is where the issue lies. First, from a logical viewpoint, it
> doesn't make sense. If you want to change the clock rate, then just do
> it. Don't hack around the multipliers trying to fall back to something
> that works for you.
>
> Then, the ratio itself needs to be set to 4. This is the part that
> we've discussed way too many times already, but in the Allwinner BSP,
> that ratio is hardcoded to 4, and we've had panels that need it at
> that value.
>
> So, what you want to do is to have:
>
> TCON DCLK = pixel clock * bpp / lanes
> TCON Module Clock = DCLK * 4
> PLL = Module Clock * Module Clock Divider (which I believe is 1 in most cases)

  pll-mipi                       1        1        1   178200000
   0     0  50000
          tcon0                       2        2        1   178200000
        0     0  50000
             tcon-pixel-clock         1        1        1    29700000
        0     0  50000

This is an english problem from my side:
tcon-pixel-clock is DCLK
tcon0 must be tcon-pixel-clock * bpp / lanes because the logic need to
put a bit every cycle.

One solution can be:
- set_rate_exclusive to tcon0 and calculate as display pixel clock *
bpp  / lanes
- calculate the tcon-pixel-clock using all divider

Problem is that the function that calculate tcon-pixel-clock does not
have any constrain on the ideal value. What you are
suggesting is not correct in my opinion or I'm not following your
suggesstion. What I know is that if we have a pixel-clock
of dvi display of 50Mhz and we have 4 lanes 32bit we need a clock in
the logic of 400Mhz (this is the ideal throughtput).
So tcon-pixel-clock is 50mhz and tcon0 is 400Mhz.

Michael


>
> So you want to increase the PLL. Fortunately for use, this is exactly
> what a call to clk_set_rate will end up doing.
>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
