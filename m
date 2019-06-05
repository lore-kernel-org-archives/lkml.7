Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B85C28CC6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 246C52075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="VCL9eX+g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfFEHda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 03:33:30 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46076 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfFEHd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 03:33:29 -0400
Received: by mail-io1-f67.google.com with SMTP id e3so19454500ioc.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 00:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sT5+EcB+YlUyYXK4d4U6HyNi0I1g3TpKkvkKUR2F5ZM=;
        b=VCL9eX+gvb3o26vh8+qUEyB25EROXALxlcBtJbdKECcuk3tu3EhsabIrBfSsB75pr5
         FSPgWuvogGIrYzakye+464zhUCYtAWxxrXoobR4lMdIBE4sPDZhOuVvQYjH+EPDCnjx1
         VQFFZVOeOFCa2ZERZrwmBQG1QQ1c3oCxK6/5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sT5+EcB+YlUyYXK4d4U6HyNi0I1g3TpKkvkKUR2F5ZM=;
        b=F9tFnGZGlFlgkk3V1kjuZ4dmVoxBxReEdRP3FWjyvVr9DAszlsBbQCM8PJ9QvQ/Kxs
         4ETTmTTRirEqQkJXhX4kGKoN++MRgAL8ouxReWuOVZYBKQbOSfNntHobMZ0vvx7nK9Yl
         7JC2EWipNtThJ+3v138IvoOG2hPo7jWOpvP4eK04uAXLPSkhKSdx8XQJxtqsalKLrkE7
         5tx/NrAkCrC2vSWyWj9PEmSgP0g/4wsjAKo+bVxvaGygqq5lg8zTn6bZGc3ImjXwk35U
         kdobNI/ptyhNIBegSJMVSuAupJbMNtaEWE1w/gc3KXcQLkR2UOGy3RKaCGBqB3FhfpUo
         H2lA==
X-Gm-Message-State: APjAAAXBrM7sbB8bRcqBqHWKV9FpJ14Iw+dGkG5AbFfFnDVgO3X+Ws7l
        x5HanZzZWaIO19TOQWEpYPJ/6mp7dFQ2DLEHMID0JA==
X-Google-Smtp-Source: APXvYqxoBfSiE/FChf+zOd+5G7lXRSPudgwOU4Z2EmihRMqCcQlK79PteyJ9VYub2JxxeB4a4GDKO/a5RQWhtvdopNE=
X-Received: by 2002:a5d:994d:: with SMTP id v13mr8213052ios.77.1559720008302;
 Wed, 05 Jun 2019 00:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
 <20190124195900.22620-12-jagan@amarulasolutions.com> <20190125212433.ni2jg3wvpyjazlxf@flea>
 <CAMty3ZAsH2iZ+JEqTE3D58aXfGuhMSg9YoO56ZhhOeE4c4yQHQ@mail.gmail.com>
 <20190129151348.mh27btttsqcmeban@flea> <CAMty3ZAjAoti8Zu80c=OyCA+u-jtQnkidsKSNz_c2OaRswqc3w@mail.gmail.com>
 <20190201143102.rcvrxstc365mezvx@flea> <CAMty3ZC3_+z1upH4Y08R1z=Uq1C=OpWETNrBO8nGRoHhuNrHSA@mail.gmail.com>
 <20190605064933.6bmskkxzzgn35xz7@flea>
In-Reply-To: <20190605064933.6bmskkxzzgn35xz7@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 5 Jun 2019 13:03:16 +0530
Message-ID: <CAMty3ZCCP=oCqm5=49BsjwoxdDETgBfU_5g8fQ=bz=iWApV0tw@mail.gmail.com>
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

On Wed, Jun 5, 2019 at 12:19 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Hi,
>
> I've reordered the mail a bit to work on chunks
>
> On Fri, May 24, 2019 at 03:37:42PM +0530, Jagan Teki wrote:
> > > I wish it was in your commit log in the first place, instead of having
> > > to exchange multiple mails over this.
> > >
> > > However, I don't think that's quite true, and it might be a bug in
> > > Allwinner's implementation (or rather something quite confusing).
> > >
> > > You're right that the lcd_rate and pll_rate seem to be generated from
> > > the pixel clock, and it indeed looks like the ratio between the pixel
> > > clock and the TCON dotclock is defined through the number of bits per
> > > lanes.
> > >
> > > However, in this case, dsi_rate is actually the same than lcd_rate,
> > > since pll_rate is going to be divided by dsi_div:
> > > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L791
> > >
> > > Since lcd_div is 1, it also means that in this case, dsi_rate ==
> > > dclk_rate.
> > >
> > > The DSI module clock however, is always set to 148.5 MHz. Indeed, if
> > > we look at:
> > > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L804
> > >
> > > We can see that the rate in clk_info is used if it's different than
> > > 0. This is filled by disp_al_lcd_get_clk_info, which, in the case of a
> > > DSI panel, will hardcode it to 148.5 MHz:
> > > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/disp_al.c#L164
> >
> > Let me explain, something more.
> >
> > According to bsp there are clk_info.tcon_div which I will explain below.
> > clk_info.dsi_div which is dynamic and it depends on bpp/lanes, so it
> > is 6 for 24bpp and 4 lanes devices.
> >
> > PLL rate here depends on dsi_div (not tcon_div)
> >
> > Code here
> > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L784
> >
> > is computing the actual set rate, which depends on dsi_rate.
> >
> > lcd_rate = dclk_rate * clk_info.dsi_div;
> > dsi_rate = pll_rate / clk_info.dsi_div;
> >
> > Say if the dclk_rate 148MHz then the dsi_rate is 888MHz which set rate
> > for above link you mentioned.
> >
> > Here are the evidence with some prints.
> >
> > https://gist.github.com/openedev/9bae2d87d2fcc06b999fe48c998b7043
> > https://gist.github.com/openedev/700de2e3701b2bf3ad1aa0f0fa862c9a
>
> Ok, so we agree up to this point, and the prints confirm that the
> analysis above is the right one.
>
> > > So, the DSI clock is set to this here:
> > > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L805
>
> Your patch doesn't address that, so let's leave that one alone.

Basically this is final pll set rate when sun4i_dotclock.c called the
desired rate with ccu_nkm.c so it ended the final rate with parent as
Line 8 of
https://gist.github.com/openedev/700de2e3701b2bf3ad1aa0f0fa862c9a

>
> > > The TCON *module* clock (the one in the clock controller) has been set
> > > to lcd_rate (so the pixel clock times the number of bits per lane) here:
> > > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L800
> > >
> > > And the PLL has been set to the same rate here:
> > > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L794
> > >
> > > Let's take a step back now: that function we were looking at,
> > > lcd_clk_config, is called by lcd_clk_enable, which is in turn called
> > > by disp_lcd_enable here:
> > > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L1328
> > >
> > > The next function being called is disp_al_lcd_cfg, and that function
> > > will hardcode the TCON dotclock divider to 4, here:
> > > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/disp_al.c#L240
> >
> > tcon_div from BSP point-of-view of there are two variants
> > 00) clk_info.tcon_div which is 4 and same is set the divider position
> > in SUN4I_TCON0_DCLK_REG (like above link refer)
> > 01) tcon_div which is 4 and used for edge timings computation
> > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c#L12
> >
> > The real reason for 01) is again 4 is they set the divider to 4 in 00)
> > which is technically wrong because the dividers which used during
> > dotclock in above (dsi_div) should be used here as well. Since there
> > is no dynamic way of doing this BSP hard-coding these values.
> >
> > Patches 5,6,7 on this series doing this
> > https://patchwork.freedesktop.org/series/60847/
> >
> > Hope this explanation helps?
>
> It doesn't.
>
> The clock tree is this one:
>
> PLL(s) -> TCON module clock -> TCON dotclock.
>
> The links I mentioned above show that the clock set to lcd_rate is the
> TCON module clocks (and it should be the one taking the bpp and lanes
> into account), while the TCON dotclock uses a fixed divider of 4.

Sorry, I can argue much other-than giving some code snips, according to [1]

00) Line 785, 786 with dclk_rate 148000000

lcd_rate = dclk_rate * clk_info.dsi_div;
pll_rate = lcd_rate * clk_info.lcd_div;

Since dsi_div is 6 (bpp/lanes), lcd_div 1

lcd_rate = 888000000, pll_rate = 888000000

01)  Line 801, 804 are final rates computed as per clock driver (say
ccu_nkm in mainline)

lcd_rate_set=891000000

As per your comments if it would be 4 then the desired numbers are
would be 592000000 not 888000000.

This is what I'm trying to say in all mails, and same as verified with
2-lanes devices as well where the dsi_div is 12 so the final rate is
290MHz * 12

>
> In your patches, you're using the bpp / lanes divider on the TCON
> dotclock, ie, the wrong clock.
>
> Again, I'm not saying that my analysis of the source code is correct
> here. But you haven't said anything to prove it's wrong either.

Don't understand what proves are remaining, I have explained each line
from BSP and saying pll rate is depends on dsi_div which is bpp/lanes
not wrt tcon_div on BSP (which is set to default 4) and which indeed
verified in A33, R40. all the code using bpp/lanes.

Please let me know if you need any more information to look?

[1] https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L805
