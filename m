Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D65C742A1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 19:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E130320872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 19:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HUGOYlUb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfGKTfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 15:35:08 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50642 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbfGKTfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 15:35:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id v15so6776611wml.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 12:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BsG/SUhoid0dTPUM8Poctc1qgljLzJxI5QGoB4XkXj4=;
        b=HUGOYlUbwwHaqkIl78JsD3TNj/NSl3onqA1Fm13sf9RktADu6zYU13rAh04jLbD7Rx
         u1o4zSpHLurmewOmIGJYi2Bvd4MIw421zql06GMUIhEDdB2dEbSyR6kEQiS1yRkygt+3
         drN2ev/GrK2RrSsa54Oh8PLUXB8dotNKu5wuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BsG/SUhoid0dTPUM8Poctc1qgljLzJxI5QGoB4XkXj4=;
        b=GXLRDXvPajrYgL85An0pWCRXqJcJPZSGIpTmFmURU1Yz9c+Up/EBCQlwWwqY3PN5Uo
         fC597kquDdHHFxoUKj9AZS2d3sdR/qqf4+7vlkqjw8u9HQuEcvJk8wudULX8HNIr5ixm
         udSSF/ps3F/Ors3qE9OO4ho9Re9bLGWV4xwSnmFvGKeUmk579+ecwop6oWmmKWXubVok
         nIDPIjqI+cc51/xF0RssVQK/Vvkz7qv/4hmGZ3y9mxldtghR+vu9+hP4/LifN+t+64PT
         u6jOn+A3OkRjpj5n8mySt88FN2EtaVUa0HBu2tJ2q6gbyr13vSHu47T0tzOQ4suda4Un
         q7/A==
X-Gm-Message-State: APjAAAWhb3B1wfl+yz1qEgmYOHKGuekMLNgz5K4dovachpHYG4pkcAOl
        opMdXo384hdBsbS4pUZzRqXO3NYBd3Ods/FZp5zpZg==
X-Google-Smtp-Source: APXvYqx7EzRwlI1BU7mOpuHkh4EiGZyoGTW3F3QUN9UrcrRKi0FTuMW/1exaqrn+SzdoNN2maXKFfyJ7Fm1m+0cZK3Y=
X-Received: by 2002:a1c:b189:: with SMTP id a131mr5718191wmf.7.1562873702946;
 Thu, 11 Jul 2019 12:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190201143102.rcvrxstc365mezvx@flea> <CAMty3ZC3_+z1upH4Y08R1z=Uq1C=OpWETNrBO8nGRoHhuNrHSA@mail.gmail.com>
 <20190605064933.6bmskkxzzgn35xz7@flea> <CAMty3ZCCP=oCqm5=49BsjwoxdDETgBfU_5g8fQ=bz=iWApV0tw@mail.gmail.com>
 <20190614142406.ybdiqfppo5mc5bgq@flea> <CAMty3ZB45cHx3WeXnywBh2_UA_bTmFs6yBTqLWA1BNf4fQtVvQ@mail.gmail.com>
 <20190625144930.5hegt6bkzqzykjid@flea> <CAMty3ZCmj0Rz7MMhLqihsvLQi+1CHf0fAoJQ4QN65xB-bwxaJw@mail.gmail.com>
 <20190703114933.u3x4ej3v7ocewvif@flea> <CAOf5uw=ZEvMV1hFQE986rNG_ctpReGbjbZzv0m=OzKPdBh57uQ@mail.gmail.com>
 <20190711100100.cty3s6rs3w27low6@flea> <CAOf5uw=3fiMuhcj3kDtCaGNTsxHKRrYb79MXZ+yUZtmf0jU10A@mail.gmail.com>
In-Reply-To: <CAOf5uw=3fiMuhcj3kDtCaGNTsxHKRrYb79MXZ+yUZtmf0jU10A@mail.gmail.com>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Thu, 11 Jul 2019 21:34:51 +0200
Message-ID: <CAOf5uwnBJgK_HW2=_iWgvkYHo+w7JL59cdz=jAjAE2sMeO=0Ew@mail.gmail.com>
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

On Thu, Jul 11, 2019 at 7:43 PM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi Maxime
>
> On Thu, Jul 11, 2019 at 2:23 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Fri, Jul 05, 2019 at 07:52:27PM +0200, Michael Nazzareno Trimarchi wrote:
> > > On Wed, Jul 3, 2019 at 1:49 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > >
> > > > On Tue, Jun 25, 2019 at 09:00:36PM +0530, Jagan Teki wrote:
> > > > > On Tue, Jun 25, 2019 at 8:19 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > > >
> > > > > > On Thu, Jun 20, 2019 at 11:57:44PM +0530, Jagan Teki wrote:
> > > > > > > On Fri, Jun 14, 2019 at 7:54 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Jun 05, 2019 at 01:03:16PM +0530, Jagan Teki wrote:
> > > > > > > > > On Wed, Jun 5, 2019 at 12:19 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi,
> > > > > > > > > >
> > > > > > > > > > I've reordered the mail a bit to work on chunks
> > > > > > > > > >
> > > > > > > > > > On Fri, May 24, 2019 at 03:37:42PM +0530, Jagan Teki wrote:
> > > > > > > > > > > > I wish it was in your commit log in the first place, instead of having
> > > > > > > > > > > > to exchange multiple mails over this.
> > > > > > > > > > > >
> > > > > > > > > > > > However, I don't think that's quite true, and it might be a bug in
> > > > > > > > > > > > Allwinner's implementation (or rather something quite confusing).
> > > > > > > > > > > >
> > > > > > > > > > > > You're right that the lcd_rate and pll_rate seem to be generated from
> > > > > > > > > > > > the pixel clock, and it indeed looks like the ratio between the pixel
> > > > > > > > > > > > clock and the TCON dotclock is defined through the number of bits per
> > > > > > > > > > > > lanes.
> > > > > > > > > > > >
> > > > > > > > > > > > However, in this case, dsi_rate is actually the same than lcd_rate,
> > > > > > > > > > > > since pll_rate is going to be divided by dsi_div:
> > > > > > > > > > > > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L791
> > > > > > > > > > > >
> > > > > > > > > > > > Since lcd_div is 1, it also means that in this case, dsi_rate ==
> > > > > > > > > > > > dclk_rate.
> > > > > > > > > > > >
> > > > > > > > > > > > The DSI module clock however, is always set to 148.5 MHz. Indeed, if
> > > > > > > > > > > > we look at:
> > > > > > > > > > > > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L804
> > > > > > > > > > > >
> > > > > > > > > > > > We can see that the rate in clk_info is used if it's different than
> > > > > > > > > > > > 0. This is filled by disp_al_lcd_get_clk_info, which, in the case of a
> > > > > > > > > > > > DSI panel, will hardcode it to 148.5 MHz:
> > > > > > > > > > > > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/disp_al.c#L164
> > > > > > > > > > >
> > > > > > > > > > > Let me explain, something more.
> > > > > > > > > > >
> > > > > > > > > > > According to bsp there are clk_info.tcon_div which I will explain below.
> > > > > > > > > > > clk_info.dsi_div which is dynamic and it depends on bpp/lanes, so it
> > > > > > > > > > > is 6 for 24bpp and 4 lanes devices.
> > > > > > > > > > >
> > > > > > > > > > > PLL rate here depends on dsi_div (not tcon_div)
> > > > > > > > > > >
> > > > > > > > > > > Code here
> > > > > > > > > > > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L784
> > > > > > > > > > >
> > > > > > > > > > > is computing the actual set rate, which depends on dsi_rate.
> > > > > > > > > > >
> > > > > > > > > > > lcd_rate = dclk_rate * clk_info.dsi_div;
> > > > > > > > > > > dsi_rate = pll_rate / clk_info.dsi_div;
> > > > > > > > > > >
> > > > > > > > > > > Say if the dclk_rate 148MHz then the dsi_rate is 888MHz which set rate
> > > > > > > > > > > for above link you mentioned.
> > > > > > > > > > >
> > > > > > > > > > > Here are the evidence with some prints.
> > > > > > > > > > >
> > > > > > > > > > > https://gist.github.com/openedev/9bae2d87d2fcc06b999fe48c998b7043
> > > > > > > > > > > https://gist.github.com/openedev/700de2e3701b2bf3ad1aa0f0fa862c9a
> > > > > > > > > >
> > > > > > > > > > Ok, so we agree up to this point, and the prints confirm that the
> > > > > > > > > > analysis above is the right one.
> > > > > > > > > >
> > > > > > > > > > > > So, the DSI clock is set to this here:
> > > > > > > > > > > > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L805
> > > > > > > > > >
> > > > > > > > > > Your patch doesn't address that, so let's leave that one alone.
> > > > > > > > >
> > > > > > > > > Basically this is final pll set rate when sun4i_dotclock.c called the
> > > > > > > > > desired rate with ccu_nkm.c so it ended the final rate with parent as
> > > > > > > > > Line 8 of
> > > > > > > > > https://gist.github.com/openedev/700de2e3701b2bf3ad1aa0f0fa862c9a
> > > > > > > >
> > > > > > > > If that's important to the driver, it should be set explicitly then,
> > > > > > > > and not work by accident.
> > > > > > > >
> > > > > > > > > > > > The TCON *module* clock (the one in the clock controller) has been set
> > > > > > > > > > > > to lcd_rate (so the pixel clock times the number of bits per lane) here:
> > > > > > > > > > > > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L800
> > > > > > > > > > > >
> > > > > > > > > > > > And the PLL has been set to the same rate here:
> > > > > > > > > > > > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L794
> > > > > > > > > > > >
> > > > > > > > > > > > Let's take a step back now: that function we were looking at,
> > > > > > > > > > > > lcd_clk_config, is called by lcd_clk_enable, which is in turn called
> > > > > > > > > > > > by disp_lcd_enable here:
> > > > > > > > > > > > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L1328
> > > > > > > > > > > >
> > > > > > > > > > > > The next function being called is disp_al_lcd_cfg, and that function
> > > > > > > > > > > > will hardcode the TCON dotclock divider to 4, here:
> > > > > > > > > > > > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/disp_al.c#L240
> > > > > > > > > > >
> > > > > > > > > > > tcon_div from BSP point-of-view of there are two variants
> > > > > > > > > > > 00) clk_info.tcon_div which is 4 and same is set the divider position
> > > > > > > > > > > in SUN4I_TCON0_DCLK_REG (like above link refer)
> > > > > > > > > > > 01) tcon_div which is 4 and used for edge timings computation
> > > > > > > > > > > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c#L12
> > > > > > > > > > >
> > > > > > > > > > > The real reason for 01) is again 4 is they set the divider to 4 in 00)
> > > > > > > > > > > which is technically wrong because the dividers which used during
> > > > > > > > > > > dotclock in above (dsi_div) should be used here as well. Since there
> > > > > > > > > > > is no dynamic way of doing this BSP hard-coding these values.
> > > > > > > > > > >
> > > > > > > > > > > Patches 5,6,7 on this series doing this
> > > > > > > > > > > https://patchwork.freedesktop.org/series/60847/
> > > > > > > > > > >
> > > > > > > > > > > Hope this explanation helps?
> > > > > > > > > >
> > > > > > > > > > It doesn't.
> > > > > > > > > >
> > > > > > > > > > The clock tree is this one:
> > > > > > > > > >
> > > > > > > > > > PLL(s) -> TCON module clock -> TCON dotclock.
> > > > > > > > > >
> > > > > > > > > > The links I mentioned above show that the clock set to lcd_rate is the
> > > > > > > > > > TCON module clocks (and it should be the one taking the bpp and lanes
> > > > > > > > > > into account), while the TCON dotclock uses a fixed divider of 4.
> > > > > > > > >
> > > > > > > > > Sorry, I can argue much other-than giving some code snips, according to [1]
> > > > > > > > >
> > > > > > > > > 00) Line 785, 786 with dclk_rate 148000000
> > > > > > > > >
> > > > > > > > > lcd_rate = dclk_rate * clk_info.dsi_div;
> > > > > > > > > pll_rate = lcd_rate * clk_info.lcd_div;
> > > > > > > > >
> > > > > > > > > Since dsi_div is 6 (bpp/lanes), lcd_div 1
> > > > > > > > >
> > > > > > > > > lcd_rate = 888000000, pll_rate = 888000000
> > > > > > > > >
> > > > > > > > > 01)  Line 801, 804 are final rates computed as per clock driver (say
> > > > > > > > > ccu_nkm in mainline)
> > > > > > > > >
> > > > > > > > > lcd_rate_set=891000000
> > > > > > > > >
> > > > > > > > > As per your comments if it would be 4 then the desired numbers are
> > > > > > > > > would be 592000000 not 888000000.
> > > > > > > > >
> > > > > > > > > This is what I'm trying to say in all mails, and same as verified with
> > > > > > > > > 2-lanes devices as well where the dsi_div is 12 so the final rate is
> > > > > > > > > 290MHz * 12
> > > > > > > >
> > > > > > > > In the code you sent, you're forcing a divider on the internal TCON
> > > > > > > > clock, while that one is fixed in the BSP.
> > > > > > > >
> > > > > > > > There's indeed the bpp / lanes divider, but it's used in the *parent*
> > > > > > > > clock of the one you're changing.
> > > > > > > >
> > > > > > > > And the dsi0_clk clock you pointed out in the code snippet is yet
> > > > > > > > another clock, the MIPI DSI module clock.
> > > > > > >
> > > > > > > Correct, look like I refereed wrong reference in the above mail. sorry
> > > > > > > for the noise.
> > > > > > >
> > > > > > > Actually I'm trying to explain about pll_rate here which indeed
> > > > > > > depends on dsi.div
> > > > > > > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L786
> > > > > > >
> > > > > > > lcd_rate = dclk_rate * clk_info.dsi_div;
> > > > > > > pll_rate = lcd_rate * clk_info.lcd_div;
> > > > > > >
> > > > > > > Say
> > > > > > >
> > > > > > > 1) For 148MHz dclk_rate with dsi_div is 6 (24/4) lcd_div is 1 which
> > > > > > > resulting pll_rate is 888MHz.
> > > > > > >
> > > > > > > 2) For 30MHz dclk_rate with 4 lane and 24 RGB the resulting pll_rate is 180MHz
> > > > > > >
> > > > > > > 3) For 27.5MHz dclk_rate with 2 lane and 24 RGB the resulting pll_rate is 330MHz
> > > > > > >
> > > > > > > Here is the few more logs in code, for case 2)
> > > > > > >
> > > > > > > [    1.920441] sun4i_dclk_round_rate: min_div = 6 max_div = 6, rate = 30000000
> > > > > > > [    1.920505] ideal = 180000000, rounded = 178200000
> > > > > > > [    1.920509] sun4i_dclk_round_rate: div = 6 rate = 29700000
> > > > > > > [    1.920514] sun4i_dclk_round_rate: min_div = 6 max_div = 6, rate = 30000000
> > > > > > > [    1.920532] ideal = 1800ls and one DSI-RGB bridge. All of them do use
> > > > > PLL_MIPI (pll_rate) and it indeed depends on bpp/lanes
> > > > >00000, rounded = 178200000
> > > > > > > [    1.920535] sun4i_dclk_round_rate: div = 6 rate = 29700000
> > > > > > > [    1.920572] sun4i_dclk_recalc_rate: val = 1, rate = 178200000
> > > > > > > [    1.920576] sun4i_dclk_recalc_rate: val = 1, rate = 178200000
> > > > > > > [    1.920597] rate = 178200000
> > > > > > > [    1.920599] parent_rate = 297000000
> > > > > > > [    1.920602] reg = 0x90c00000
> > > > > > > [    1.920605] _nkm.n = 3, nkm->n.offset = 0x1, nkm->n.shift = 8
> > > > > > > [    1.920609] _nkm.k = 2, nkm->k.offset = 0x1, nkm->k.shift = 4
> > > > > > > [    1.920612] _nkm.m = 10, nkm->m.offset = 0x1, nkm->m.shift = 0
> > > > > > > [    1.920958] sun4i_dclk_set_rate div 6
> > > > > > > [    1.920966] sun4i_dclk_recalc_rate: val = 6, rate = 29700000
> > > > > > >
> > > > > > > and clk_summary:
> > > > > > >
> > > > > > >     pll-video0                        1        1        1   297000000
> > > > > > >         0     0  50000
> > > > > > >        hdmi                           0        0        0   297000000
> > > > > > >         0     0  50000
> > > > > > >        tcon1                          0        0        0   297000000
> > > > > > >         0     0  50000
> > > > > > >        pll-mipi                       1        1        1   178200000
> > > > > > >         0     0  50000
> > > > > > >           tcon0                       2        2        1   178200000
> > > > > > >         0     0  50000
> > > > > > >              tcon-pixel-clock         1        1        1    29700000
> > > > > > >         0     0  50000
> > > > > > >        pll-video0-2x                  0        0        0   594000000
> > > > > > >         0     0  50000
> > > > > >
> > > > > > This discussion is going nowhere. I'm telling you that your patch
> > > > > > doesn't apply the divider you want on the proper clock, and you're
> > > > > > replying that indeed, you're applying it on the wrong clock.
> > > > > >
> > > > > > It might work by accident in your case, but the board I have here
> > > > > > clearly indicates otherwise, so there's two possible way out here:
> > > > > >
> > > > > >   - Either you apply that divider to the TCON *module* clock, and not
> > > > > >     the dclk
> > > > > >
> > > > > >   - Or you point to somewhere in the allwinner code where the bpp /
> > > > > >     lanes divider is used for the dclk divider.
> > > > >
> > > > > I don't know how to proceed further on this, as you say it might work
> > > > > in accident but I have tested this in A33, A64 and R40 with 4
> > > > > different DSI panels and one DSI-RGB bridge. All of them do use
> > > > > PLL_MIPI (pll_rate) and it indeed depends on bpp/lanes
> > > > >
> > > > > 4-lane, 24-bit: Novatek NT35596 panel
> > > > > 4-lane, 24-bit: Feiyang, FY07024di26a30d panel
> > > > > 4-lane, 24-bit: Bananapi-s070wv20 panel
> > > > > 2-lane, 24-bit: Techstar,ts8550b panel
> > > > >
> > > > > and
> > > > >
> > > > > 4-lane, 24-bit, ICN6211 DSI-to-RGB bridge panel
> > > > >
> > > > > All above listed panels and bridges are working as per BSP and do
> > > > > follow bpp/lanes and for DIVIDER 4 no panel is working.
> > > >
> > > > Look. I'm not saying that there's no issue, I'm saying that your
> > > > patch, applied to the clock you're applying it to, doesn't make sense
> > > > and isn't what the BSP does.
> > >
> > > tcon-pixel clock is the rate that you want to achive on display side
> > > and if you have 4 lanes 32bit or lanes and different bit number that
> > > you need to have a clock that is able to put outside bits and speed
> > > equal to pixel-clock * bits / lanes. so If you want a pixel-clock of
> > > 40 mhz and you have 32bits and 4 lanes you need to have a clock of
> > > 40 * 32 / 4 in no-burst mode. I think that this is done but most of
> > > the display.
> >
> > So this is what the issue is then?
> >
> > This one does make sense, and you should just change the rate in the
> > call to clk_set_rate in sun4i_tcon0_mode_set_cpu.
> >
> > I'm still wondering why that hasn't been brought up in either the
> > discussion or the commit log before though.
> >
> Something like this?
>
> drivers/gpu/drm/sun4i/sun4i_tcon.c     | 20 +++++++++++---------
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h |  2 --
>  2 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index 64c43ee6bd92..42560d5c327c 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -263,10 +263,11 @@ static int sun4i_tcon_get_clk_delay(const struct
> drm_display_mode *mode,
>  }
>
>  static void sun4i_tcon0_mode_set_common(struct sun4i_tcon *tcon,
> -                                       const struct drm_display_mode *mode)
> +                                       const struct drm_display_mode *mode,
> +                                       u32 tcon_mul)
>  {
>         /* Configure the dot clock */
> -       clk_set_rate(tcon->dclk, mode->crtc_clock * 1000);
> +       clk_set_rate(tcon->dclk, mode->crtc_clock * tcon_mul * 1000);
>
>         /* Set the resolution */
>         regmap_write(tcon->regs, SUN4I_TCON0_BASIC0_REG,
> @@ -335,12 +336,13 @@ static void sun4i_tcon0_mode_set_cpu(struct
> sun4i_tcon *tcon,
>         u8 bpp = mipi_dsi_pixel_format_to_bpp(device->format);
>         u8 lanes = device->lanes;
>         u32 block_space, start_delay;
> -       u32 tcon_div;
> +       u32 tcon_div, tcon_mul;
>
> -       tcon->dclk_min_div = SUN6I_DSI_TCON_DIV;
> -       tcon->dclk_max_div = SUN6I_DSI_TCON_DIV;
> +       tcon->dclk_min_div = 4;
> +       tcon->dclk_max_div = 127;
>
> -       sun4i_tcon0_mode_set_common(tcon, mode);
> +       tcon_mul = bpp / lanes;
> +       sun4i_tcon0_mode_set_common(tcon, mode, tcon_mul);
>

Maybe wrong clock ;) but is this your idea?

Michael
>         /* Set dithering if needed */
>         sun4i_tcon0_mode_set_dithering(tcon, sun4i_tcon_get_connector(encoder));
> @@ -366,7 +368,7 @@ static void sun4i_tcon0_mode_set_cpu(struct
> sun4i_tcon *tcon,
>          */
>         regmap_read(tcon->regs, SUN4I_TCON0_DCLK_REG, &tcon_div);
>         tcon_div &= GENMASK(6, 0);
> -       block_space = mode->htotal * bpp / (tcon_div * lanes);
> +       block_space = mode->htotal * tcon_div * tcon_mul;
>         block_space -= mode->hdisplay + 40;
>
>         regmap_write(tcon->regs, SUN4I_TCON0_CPU_TRI0_REG,
> @@ -408,7 +410,7 @@ static void sun4i_tcon0_mode_set_lvds(struct
> sun4i_tcon *tcon,
>
>         tcon->dclk_min_div = 7;
>         tcon->dclk_max_div = 7;
> -       sun4i_tcon0_mode_set_common(tcon, mode);
> +       sun4i_tcon0_mode_set_common(tcon, mode, 1);
>
>         /* Set dithering if needed */
>         sun4i_tcon0_mode_set_dithering(tcon, sun4i_tcon_get_connector(encoder));
> @@ -487,7 +489,7 @@ static void sun4i_tcon0_mode_set_rgb(struct
> sun4i_tcon *tcon,
>
>         tcon->dclk_min_div = 6;
>         tcon->dclk_max_div = 127;
> -       sun4i_tcon0_mode_set_common(tcon, mode);
> +       sun4i_tcon0_mode_set_common(tcon, mode, 1);
>
>         /* Set dithering if needed */
>         sun4i_tcon0_mode_set_dithering(tcon, connector);
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> index 5c3ad5be0690..a07090579f84 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> @@ -13,8 +13,6 @@
>  #include <drm/drm_encoder.h>
>  #include <drm/drm_mipi_dsi.h>
>
> -#define SUN6I_DSI_TCON_DIV     4
> -
>  struct sun6i_dsi {
>         struct drm_connector    connector;
>         struct drm_encoder      encoder;
>
>
> > > Now in burst mode I don't know how should work the calculation of
> > > the clock for the require bandwidth and even I understand your
> > > comment I would like to have your clock tree after you boot on the
> > > display side and if it is possible I want to assemble a kit like you
> > > have.
> >
> > The setup is probably going to be a bit difficult to reproduce, it's a
> > prototype that I have that can't really be found anywhere. Jagan asked
> > me on IRC for the reference, and he found the part, but it's unclear
> > to me if it can be easily adapted to a common board.
> >
> > However, I'm not even sure we need this. I'll test the next version
> > and let you know if it works.
> >
> > Maxime
> >
> > --
> > Maxime Ripard, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com
>
>
>
> --
> | Michael Nazzareno Trimarchi                     Amarula Solutions BV |
> | COO  -  Founder                                      Cruquiuskade 47 |
> | +31(0)851119172                                 Amsterdam 1018 AM NL |
> |                  [`as] http://www.amarulasolutions.com               |



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
