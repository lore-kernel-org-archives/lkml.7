Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CC4C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109FC20665
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RaSwuXUg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbfFTS17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:27:59 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45724 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfFTS16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:27:58 -0400
Received: by mail-io1-f65.google.com with SMTP id e3so19698ioc.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 11:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mwbErLJ3V6vC6WVVwdxU2Qgp0s+ZMnyIhMQtnjCFBbU=;
        b=RaSwuXUgC2LGddvftTsyMnDwQc4TrrqRNVm39hHPxMkFPpDShnxaupG/vuw6CFLbWo
         DyN9e8hA5ArOojTwZxq9NdZpcSJG470rqjoGTPE9jkWmP4iE155nFyVjL6NebM1S29iE
         YlG2Gtsn76EGrMkPGgJhBVv4qRBeMZuQvJaM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mwbErLJ3V6vC6WVVwdxU2Qgp0s+ZMnyIhMQtnjCFBbU=;
        b=cs73egzdtzKLUOVPhQdf8I/3XvENk0IfuGdFxcjilJ/ZNVWFEB3PfVMdbz7FAJhggA
         suQFi8I8TPeDdLs6JLkXfpDDTGyPm7LgUzHNRXu4TmbjthjQDKadkxOcx3wSNQpFPXCb
         g1YPM7ZZwum03pd6594/N17FECF7l3BPXP6coZ8Z9JVoQqZ2eN1eqQ/tX0vVXw+QO2Q3
         6OyqhrrywdNboD42p4wNr6f1lV8MdV47EFHjllF969E0C4c0LHFaZmj7rx95jzN4nZFv
         U74d6fSo5xADb4iLf6p6g39ge1CW5R2mK50DN8aYQJNsQtWtZ7STTlHsuHNJCNJ9H4J+
         YYsg==
X-Gm-Message-State: APjAAAX2ODlewefA973LN715QJ8/l2rurso0BWmRZ+BEamsYAi3FSChG
        fjFnJEG1lXL85uDbxG+5TCq17m9bsmqm4+jMP0+E7g==
X-Google-Smtp-Source: APXvYqy4fUuMM1AjTIRVaQrstaOthDZ0Ysq8Fh3ybDJt6I0bHpFOzpD0N6IDrxhFGMaXznlVFY5rQRjVws2S1bG4c3I=
X-Received: by 2002:a02:3308:: with SMTP id c8mr36993457jae.103.1561055276862;
 Thu, 20 Jun 2019 11:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
 <20190124195900.22620-12-jagan@amarulasolutions.com> <20190125212433.ni2jg3wvpyjazlxf@flea>
 <CAMty3ZAsH2iZ+JEqTE3D58aXfGuhMSg9YoO56ZhhOeE4c4yQHQ@mail.gmail.com>
 <20190129151348.mh27btttsqcmeban@flea> <CAMty3ZAjAoti8Zu80c=OyCA+u-jtQnkidsKSNz_c2OaRswqc3w@mail.gmail.com>
 <20190201143102.rcvrxstc365mezvx@flea> <CAMty3ZC3_+z1upH4Y08R1z=Uq1C=OpWETNrBO8nGRoHhuNrHSA@mail.gmail.com>
 <20190605064933.6bmskkxzzgn35xz7@flea> <CAMty3ZCCP=oCqm5=49BsjwoxdDETgBfU_5g8fQ=bz=iWApV0tw@mail.gmail.com>
 <20190614142406.ybdiqfppo5mc5bgq@flea>
In-Reply-To: <20190614142406.ybdiqfppo5mc5bgq@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 20 Jun 2019 23:57:44 +0530
Message-ID: <CAMty3ZB45cHx3WeXnywBh2_UA_bTmFs6yBTqLWA1BNf4fQtVvQ@mail.gmail.com>
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

On Fri, Jun 14, 2019 at 7:54 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Wed, Jun 05, 2019 at 01:03:16PM +0530, Jagan Teki wrote:
> > On Wed, Jun 5, 2019 at 12:19 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > Hi,
> > >
> > > I've reordered the mail a bit to work on chunks
> > >
> > > On Fri, May 24, 2019 at 03:37:42PM +0530, Jagan Teki wrote:
> > > > > I wish it was in your commit log in the first place, instead of having
> > > > > to exchange multiple mails over this.
> > > > >
> > > > > However, I don't think that's quite true, and it might be a bug in
> > > > > Allwinner's implementation (or rather something quite confusing).
> > > > >
> > > > > You're right that the lcd_rate and pll_rate seem to be generated from
> > > > > the pixel clock, and it indeed looks like the ratio between the pixel
> > > > > clock and the TCON dotclock is defined through the number of bits per
> > > > > lanes.
> > > > >
> > > > > However, in this case, dsi_rate is actually the same than lcd_rate,
> > > > > since pll_rate is going to be divided by dsi_div:
> > > > > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L791
> > > > >
> > > > > Since lcd_div is 1, it also means that in this case, dsi_rate ==
> > > > > dclk_rate.
> > > > >
> > > > > The DSI module clock however, is always set to 148.5 MHz. Indeed, if
> > > > > we look at:
> > > > > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L804
> > > > >
> > > > > We can see that the rate in clk_info is used if it's different than
> > > > > 0. This is filled by disp_al_lcd_get_clk_info, which, in the case of a
> > > > > DSI panel, will hardcode it to 148.5 MHz:
> > > > > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/disp_al.c#L164
> > > >
> > > > Let me explain, something more.
> > > >
> > > > According to bsp there are clk_info.tcon_div which I will explain below.
> > > > clk_info.dsi_div which is dynamic and it depends on bpp/lanes, so it
> > > > is 6 for 24bpp and 4 lanes devices.
> > > >
> > > > PLL rate here depends on dsi_div (not tcon_div)
> > > >
> > > > Code here
> > > > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L784
> > > >
> > > > is computing the actual set rate, which depends on dsi_rate.
> > > >
> > > > lcd_rate = dclk_rate * clk_info.dsi_div;
> > > > dsi_rate = pll_rate / clk_info.dsi_div;
> > > >
> > > > Say if the dclk_rate 148MHz then the dsi_rate is 888MHz which set rate
> > > > for above link you mentioned.
> > > >
> > > > Here are the evidence with some prints.
> > > >
> > > > https://gist.github.com/openedev/9bae2d87d2fcc06b999fe48c998b7043
> > > > https://gist.github.com/openedev/700de2e3701b2bf3ad1aa0f0fa862c9a
> > >
> > > Ok, so we agree up to this point, and the prints confirm that the
> > > analysis above is the right one.
> > >
> > > > > So, the DSI clock is set to this here:
> > > > > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L805
> > >
> > > Your patch doesn't address that, so let's leave that one alone.
> >
> > Basically this is final pll set rate when sun4i_dotclock.c called the
> > desired rate with ccu_nkm.c so it ended the final rate with parent as
> > Line 8 of
> > https://gist.github.com/openedev/700de2e3701b2bf3ad1aa0f0fa862c9a
>
> If that's important to the driver, it should be set explicitly then,
> and not work by accident.
>
> > > > > The TCON *module* clock (the one in the clock controller) has been set
> > > > > to lcd_rate (so the pixel clock times the number of bits per lane) here:
> > > > > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L800
> > > > >
> > > > > And the PLL has been set to the same rate here:
> > > > > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L794
> > > > >
> > > > > Let's take a step back now: that function we were looking at,
> > > > > lcd_clk_config, is called by lcd_clk_enable, which is in turn called
> > > > > by disp_lcd_enable here:
> > > > > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L1328
> > > > >
> > > > > The next function being called is disp_al_lcd_cfg, and that function
> > > > > will hardcode the TCON dotclock divider to 4, here:
> > > > > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/disp_al.c#L240
> > > >
> > > > tcon_div from BSP point-of-view of there are two variants
> > > > 00) clk_info.tcon_div which is 4 and same is set the divider position
> > > > in SUN4I_TCON0_DCLK_REG (like above link refer)
> > > > 01) tcon_div which is 4 and used for edge timings computation
> > > > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c#L12
> > > >
> > > > The real reason for 01) is again 4 is they set the divider to 4 in 00)
> > > > which is technically wrong because the dividers which used during
> > > > dotclock in above (dsi_div) should be used here as well. Since there
> > > > is no dynamic way of doing this BSP hard-coding these values.
> > > >
> > > > Patches 5,6,7 on this series doing this
> > > > https://patchwork.freedesktop.org/series/60847/
> > > >
> > > > Hope this explanation helps?
> > >
> > > It doesn't.
> > >
> > > The clock tree is this one:
> > >
> > > PLL(s) -> TCON module clock -> TCON dotclock.
> > >
> > > The links I mentioned above show that the clock set to lcd_rate is the
> > > TCON module clocks (and it should be the one taking the bpp and lanes
> > > into account), while the TCON dotclock uses a fixed divider of 4.
> >
> > Sorry, I can argue much other-than giving some code snips, according to [1]
> >
> > 00) Line 785, 786 with dclk_rate 148000000
> >
> > lcd_rate = dclk_rate * clk_info.dsi_div;
> > pll_rate = lcd_rate * clk_info.lcd_div;
> >
> > Since dsi_div is 6 (bpp/lanes), lcd_div 1
> >
> > lcd_rate = 888000000, pll_rate = 888000000
> >
> > 01)  Line 801, 804 are final rates computed as per clock driver (say
> > ccu_nkm in mainline)
> >
> > lcd_rate_set=891000000
> >
> > As per your comments if it would be 4 then the desired numbers are
> > would be 592000000 not 888000000.
> >
> > This is what I'm trying to say in all mails, and same as verified with
> > 2-lanes devices as well where the dsi_div is 12 so the final rate is
> > 290MHz * 12
>
> In the code you sent, you're forcing a divider on the internal TCON
> clock, while that one is fixed in the BSP.
>
> There's indeed the bpp / lanes divider, but it's used in the *parent*
> clock of the one you're changing.
>
> And the dsi0_clk clock you pointed out in the code snippet is yet
> another clock, the MIPI DSI module clock.

Correct, look like I refereed wrong reference in the above mail. sorry
for the noise.

Actually I'm trying to explain about pll_rate here which indeed
depends on dsi.div
https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L786

lcd_rate = dclk_rate * clk_info.dsi_div;
pll_rate = lcd_rate * clk_info.lcd_div;

Say

1) For 148MHz dclk_rate with dsi_div is 6 (24/4) lcd_div is 1 which
resulting pll_rate is 888MHz.

2) For 30MHz dclk_rate with 4 lane and 24 RGB the resulting pll_rate is 180MHz

3) For 27.5MHz dclk_rate with 2 lane and 24 RGB the resulting pll_rate is 330MHz

Here is the few more logs in code, for case 2)

[    1.920441] sun4i_dclk_round_rate: min_div = 6 max_div = 6, rate = 30000000
[    1.920505] ideal = 180000000, rounded = 178200000
[    1.920509] sun4i_dclk_round_rate: div = 6 rate = 29700000
[    1.920514] sun4i_dclk_round_rate: min_div = 6 max_div = 6, rate = 30000000
[    1.920532] ideal = 180000000, rounded = 178200000
[    1.920535] sun4i_dclk_round_rate: div = 6 rate = 29700000
[    1.920572] sun4i_dclk_recalc_rate: val = 1, rate = 178200000
[    1.920576] sun4i_dclk_recalc_rate: val = 1, rate = 178200000
[    1.920597] rate = 178200000
[    1.920599] parent_rate = 297000000
[    1.920602] reg = 0x90c00000
[    1.920605] _nkm.n = 3, nkm->n.offset = 0x1, nkm->n.shift = 8
[    1.920609] _nkm.k = 2, nkm->k.offset = 0x1, nkm->k.shift = 4
[    1.920612] _nkm.m = 10, nkm->m.offset = 0x1, nkm->m.shift = 0
[    1.920958] sun4i_dclk_set_rate div 6
[    1.920966] sun4i_dclk_recalc_rate: val = 6, rate = 29700000

and clk_summary:

    pll-video0                        1        1        1   297000000
        0     0  50000
       hdmi                           0        0        0   297000000
        0     0  50000
       tcon1                          0        0        0   297000000
        0     0  50000
       pll-mipi                       1        1        1   178200000
        0     0  50000
          tcon0                       2        2        1   178200000
        0     0  50000
             tcon-pixel-clock         1        1        1    29700000
        0     0  50000
       pll-video0-2x                  0        0        0   594000000
        0     0  50000
