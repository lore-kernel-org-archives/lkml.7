Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE43AC282E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD0C2175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="TF4cfbuI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390577AbfEXKHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 06:07:55 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33615 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390106AbfEXKHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 06:07:54 -0400
Received: by mail-io1-f66.google.com with SMTP id z4so7353843iol.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 03:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TUgAZ6G4gvf+slUqb9uc+iwVC1m/3d6V2K633s4jrTg=;
        b=TF4cfbuIVUIf/mM/PjvuU2rmu3iPkhWBbwQvKTiRwPaDZyMqpwaKIV/Ucx5tADKIQ2
         HLgZhqUi739/CEIDRH8pBVVku19c3lIdQQttRRB+KAnl+kisiJ3tkBVxtDROIujKuFJY
         D29ppmoHxK/mAIUKubq81TwX1b4yPzj94Jlok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TUgAZ6G4gvf+slUqb9uc+iwVC1m/3d6V2K633s4jrTg=;
        b=IjuZ5MOOmgsAc5CxDOrExIFMz7a2z7wIzkcnwlF+mRHiUi1biiKl+qpWvERAIKzu54
         KOTZ9Rw9n4FGl8sxVeA0W3J2fb9/Uii5MsSFqsF4p1aq3C1qPmFZJ/tyz42ahW/dOG07
         BXF2Qjcqawif2nsKQCKeArxdvfwX2rFHsaobhxopkl+nkzeIaOJPWhlEqEAu0MzyUmAl
         GUh3CK1CgMe70L6DjpoME6xABfL0i36NmltFFtbkERcQIVO6+NcflUJQR7dDbNZ18201
         BcQ1fVdMA73vZzyOgwZk8hWKHxvGdmlxyJ31qSSMGMwvbzInTXvobOmmxqu53NAv6qjU
         8vfA==
X-Gm-Message-State: APjAAAWuhpr/EodOpgyEppq+Zpl+cM1mu7lgfA+Pwbd78hJXCZl5qYDt
        ZjUYc/e8e3LsB6+RhAupvog0v9qbu/LEox9kIGqixw==
X-Google-Smtp-Source: APXvYqwmVWbvA8JWDP7ZREuSZZ6USfKRDsF78w4YD1IvT2iQBryzh6GoPGvJRrLGpAZC28dLBcMDdVE9LG5qi3N05aQ=
X-Received: by 2002:a5d:994d:: with SMTP id v13mr4961505ios.77.1558692473939;
 Fri, 24 May 2019 03:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
 <20190124195900.22620-12-jagan@amarulasolutions.com> <20190125212433.ni2jg3wvpyjazlxf@flea>
 <CAMty3ZAsH2iZ+JEqTE3D58aXfGuhMSg9YoO56ZhhOeE4c4yQHQ@mail.gmail.com>
 <20190129151348.mh27btttsqcmeban@flea> <CAMty3ZAjAoti8Zu80c=OyCA+u-jtQnkidsKSNz_c2OaRswqc3w@mail.gmail.com>
 <20190201143102.rcvrxstc365mezvx@flea>
In-Reply-To: <20190201143102.rcvrxstc365mezvx@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Fri, 24 May 2019 15:37:42 +0530
Message-ID: <CAMty3ZC3_+z1upH4Y08R1z=Uq1C=OpWETNrBO8nGRoHhuNrHSA@mail.gmail.com>
Subject: Re: [PATCH v6 11/22] clk: sunxi-ng: a64: Add minimum rate for PLL_MIPI
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
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 8:01 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Tue, Jan 29, 2019 at 11:01:31PM +0530, Jagan Teki wrote:
> > On Tue, Jan 29, 2019 at 8:43 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Mon, Jan 28, 2019 at 03:06:10PM +0530, Jagan Teki wrote:
> > > > On Sat, Jan 26, 2019 at 2:54 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > >
> > > > > On Fri, Jan 25, 2019 at 01:28:49AM +0530, Jagan Teki wrote:
> > > > > > Minimum PLL used for MIPI is 500MHz, as per manual, but
> > > > > > lowering the min rate by 300MHz can result proper working
> > > > > > nkms divider with the help of desired dclock rate from
> > > > > > panel driver.
> > > > > >
> > > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > > Acked-by: Stephen Boyd <sboyd@kernel.org>
> > > > >
> > > > > Going 200MHz below the minimum doesn't seem really reasonable. What
> > > > > is the issue that you are trying to fix here?
> > > > >
> > > > > It looks like it's picking bad dividers, but if that's the case, this
> > > > > isn't the proper fix.
> > > >
> > > > As I stated in earlier patches, the whole idea is pick the desired
> > > > dclk divider based dclk rate. So the dotclock, sun4i_dclk_round_rate
> > > > is unable to get the proper dclk divider at the end, so it eventually
> > > > picking up wrong divider value and fired vblank timeout.
> > > >
> > > > So, we come-up with optimal and working min_rate 300MHz in pll-mipi to
> > > > get the desired clock something like below.
> > > > [    2.415773] [drm] No driver support for vblank timestamp query.
> > > > [    2.424116] sun4i_dclk_round_rate: min_div = 4 max_div = 127, rate = 55000000
> > > > [    2.424172] ideal = 220000000, rounded = 0
> > > > [    2.424176] ideal = 275000000, rounded = 0
> > > > [    2.424194] ccu_nkm_round_rate: rate = 330000000
> > > > [    2.424197] ideal = 330000000, rounded = 330000000
> > > > [    2.424201] sun4i_dclk_round_rate: div = 6 rate = 55000000
> > > > [    2.424205] sun4i_dclk_round_rate: min_div = 4 max_div = 127, rate = 55000000
> > > > [    2.424209] ideal = 220000000, rounded = 0
> > > > [    2.424213] ideal = 275000000, rounded = 0
> > > > [    2.424230] ccu_nkm_round_rate: rate = 330000000
> > > > [    2.424233] ideal = 330000000, rounded = 330000000
> > > > [    2.424236] sun4i_dclk_round_rate: div = 6 rate = 55000000
> > > > [    2.424253] ccu_nkm_round_rate: rate = 330000000
> > > > [    2.424270] ccu_nkm_round_rate: rate = 330000000
> > > > [    2.424278] sun4i_dclk_recalc_rate: val = 1, rate = 330000000
> > > > [    2.424281] sun4i_dclk_recalc_rate: val = 1, rate = 330000000
> > > > [    2.424306] ccu_nkm_set_rate: rate = 330000000, parent_rate = 297000000
> > > > [    2.424309] ccu_nkm_set_rate: _nkm.n = 5
> > > > [    2.424311] ccu_nkm_set_rate: _nkm.k = 2
> > > > [    2.424313] ccu_nkm_set_rate: _nkm.m = 9
> > > > [    2.424661] sun4i_dclk_set_rate div 6
> > > > [    2.424668] sun4i_dclk_recalc_rate: val = 6, rate = 55000000
> > > >
> > > > But look like this wouldn't valid for all other dclock rates, say BPI
> > > > panel has 30MHz clock that would failed with this logic.
> > > >
> > > > On the other side Allwinner BSP calculating dclk divider based on the
> > > > SoC's. for A33 [1] it is fixed dclk divider of 4 and for A64 is is
> > > > calculated based on the bpp/lanes.
> > >
> > > It looks like the A64 has the same divider of 4:
> > > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c#L12
> > >
> > > I think you're confusing it with the ratio between the pixel clock and
> > > the dotclock, called dsi_div:
> > > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/disp_al.c#L198
> >
> > Ahh.. I thought this initially but as far as DSI clock computation is
> > concern, the L12 tcon_div is local variable which is used for edge0
> > computation in burst mode and not for the dsi clock computation. Since
> > the BSP is unable to get the tcon_div during edge0 computation, they
> > defined it locally I think.
> >
> > You can see the lcd_clk_config() code [2], where we can see DSI clock
> > computation using dsi_div value.
> >
> > Here is dump after the in Line 792 which is after computation[3]
> > [   10.800737] lcd_clk_config: dsi_div = 6, tcon_div = 4, lcd_div = 1
> > [   10.800743] lcd_clk_config: lcd_dclk_freq = 55, dclk_rate = 55000000
> > [   10.800749] lcd_clk_config: lcd_rate = 330000000, pll_rate = 330000000
> >
> > The above dump the lcd_rate 330MHz is computed with panel clock, 55MHz
> > into dsi_div 6. So this can be our actual divider values dclk_min_div,
> > dclk_max_div in sun4i_dclk_round_rate (from
> > drivers/gpu/drm/sun4i/sun4i_dotclock.c)
>
> I wish it was in your commit log in the first place, instead of having
> to exchange multiple mails over this.
>
> However, I don't think that's quite true, and it might be a bug in
> Allwinner's implementation (or rather something quite confusing).
>
> You're right that the lcd_rate and pll_rate seem to be generated from
> the pixel clock, and it indeed looks like the ratio between the pixel
> clock and the TCON dotclock is defined through the number of bits per
> lanes.
>
> However, in this case, dsi_rate is actually the same than lcd_rate,
> since pll_rate is going to be divided by dsi_div:
> https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L791
>
> Since lcd_div is 1, it also means that in this case, dsi_rate ==
> dclk_rate.
>
> The DSI module clock however, is always set to 148.5 MHz. Indeed, if
> we look at:
> https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L804
>
> We can see that the rate in clk_info is used if it's different than
> 0. This is filled by disp_al_lcd_get_clk_info, which, in the case of a
> DSI panel, will hardcode it to 148.5 MHz:
> https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/disp_al.c#L164
>
> So, the DSI clock is set to this here:
> https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L805
>
> The TCON *module* clock (the one in the clock controller) has been set
> to lcd_rate (so the pixel clock times the number of bits per lane) here:
> https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L800
>
> And the PLL has been set to the same rate here:
> https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L794

Let me explain, something more.

According to bsp there are clk_info.tcon_div which I will explain below.
clk_info.dsi_div which is dynamic and it depends on bpp/lanes, so it
is 6 for 24bpp and 4 lanes devices.

PLL rate here depends on dsi_div (not tcon_div)

Code here
https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L784

is computing the actual set rate, which depends on dsi_rate.

lcd_rate = dclk_rate * clk_info.dsi_div;
dsi_rate = pll_rate / clk_info.dsi_div;

Say if the dclk_rate 148MHz then the dsi_rate is 888MHz which set rate
for above link you mentioned.

Here are the evidence with some prints.

https://gist.github.com/openedev/9bae2d87d2fcc06b999fe48c998b7043
https://gist.github.com/openedev/700de2e3701b2bf3ad1aa0f0fa862c9a

>
> Let's take a step back now: that function we were looking at,
> lcd_clk_config, is called by lcd_clk_enable, which is in turn called
> by disp_lcd_enable here:
> https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L1328
>
> The next function being called is disp_al_lcd_cfg, and that function
> will hardcode the TCON dotclock divider to 4, here:
> https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/disp_al.c#L240

tcon_div from BSP point-of-view of there are two variants
00) clk_info.tcon_div which is 4 and same is set the divider position
in SUN4I_TCON0_DCLK_REG (like above link refer)
01) tcon_div which is 4 and used for edge timings computation
https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c#L12

The real reason for 01) is again 4 is they set the divider to 4 in 00)
which is technically wrong because the dividers which used during
dotclock in above (dsi_div) should be used here as well. Since there
is no dynamic way of doing this BSP hard-coding these values.

Patches 5,6,7 on this series doing this
https://patchwork.freedesktop.org/series/60847/

Hope this explanation helps?
