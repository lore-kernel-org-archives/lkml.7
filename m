Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0091AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C635F2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="I4WPNbtt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfCRSY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:24:57 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36827 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfCRSY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 14:24:57 -0400
Received: by mail-io1-f65.google.com with SMTP id f6so15382648iop.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 11:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=40KwwJTreUr7SrlhIboEHgMAtXuwNdUA9TdB84CMBq0=;
        b=I4WPNbttg47zfiGrm5quGozOpx0FlbzWFxGENkVdtsZpdjAc8cWv2MsAAtbEzDkb+N
         VvBaXDFHXy9XrpRjlc30ysNVeX+VY1RgB6cUH2G9q5821V43fZmAfxCbZ7dYyblwXK1K
         exZHSfGU3E2EpBAWCR5N5nYYtJ/ritD+zx+RE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=40KwwJTreUr7SrlhIboEHgMAtXuwNdUA9TdB84CMBq0=;
        b=qdC9SLasWGPCX/Jc9i5p9GNvTqsZ73E4eG5sa4o2aOrodNJ81FG3jOGxdiwl7hEKrL
         eVO6hJL+3nt+JQONCd8hG+yivFo0mKPH8y46FtTDdHgtJtUfHixjIuH6lYkeK54ePjwO
         dVcGg0pIrgFFz6uvYzfPqAOaPGLSTwwWcJjhCO23+FZVbBXc/R4FVpdOhlsfR3GrpVbe
         vZsFvWbCcBu42/AnI2AQp0u6cOVGihB1znt6diH7LG06SCysnEnL8Q9EesxuzO03+yKi
         c/pdFRvMxsWNHBTuQu2S6zK49ZuN6fMkq90C5vS62vldb91i2x3Y0DOUzklKYVAhofVo
         LY3w==
X-Gm-Message-State: APjAAAWghM5wm73Wns+LJLEXxlRA3VhqWnmIkqk9fB5xqMszR0Axp0l1
        zTkmYu6hDiptOrSF2Jke6LCO3lhq9v3HL7JmEZpfdw==
X-Google-Smtp-Source: APXvYqxYqD0aZLB9hBkLVdZqLnVaPTv9c5ALFTgs89uQqO7nn0GZ4egTAaKxg7v2cFKuYzB2cy26MeXWCLByUIynQK8=
X-Received: by 2002:a5d:97c8:: with SMTP id k8mr12627122ios.267.1552933496448;
 Mon, 18 Mar 2019 11:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190311133637.18334-1-jagan@amarulasolutions.com>
 <20190311133637.18334-3-jagan@amarulasolutions.com> <20190311153847.oz6ruqmptaq2befn@flea>
 <CAMty3ZChz=s7gdQyX9KnsAp1t5FrpouXGK74-r0SKJ89yJN67Q@mail.gmail.com>
In-Reply-To: <CAMty3ZChz=s7gdQyX9KnsAp1t5FrpouXGK74-r0SKJ89yJN67Q@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 18 Mar 2019 23:54:45 +0530
Message-ID: <CAMty3ZBteruXzMNkyUKv5VmDVzmN1E6zKL0+o7PYo_bFc7gq9g@mail.gmail.com>
Subject: Re: [PATCH v8 02/15] drm/sun4i: tcon: Compute DCLK dividers based on
 format, lanes
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

On Mon, Mar 11, 2019 at 9:36 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Mon, Mar 11, 2019 at 9:08 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Mon, Mar 11, 2019 at 07:06:24PM +0530, Jagan Teki wrote:
> > > pll-video => pll-mipi => tcon0 => tcon0-pixel-clock is the typical
> > > MIPI clock topology in Allwinner DSI controller.
> > >
> > > TCON dotclock driver is computing the desired DCLK divider based on
> > > panel pixel clock along with input DCLK min, max divider values from
> > > tcon driver and that would eventually set the pll-mipi clock rate.
> > >
> > > The current code allows the TCON clock divider to have a default 4
> > > for min, max ranges that would fail to compute the desired pll-mipi
> > > rate while supporting new panels.
> > >
> > > So, add the computation logic 'format/lanes' to dclk min and max dividers
> > > and instead of default 4. This computation logic align with Allwinner A64
> > > BSP, hoping that would work even for A33.
> >
> > Last time we discussed this, we found out that this wasn't the case,
> > even in the BSP.
>
> This was the case for BSP to compute pll-mipi not for TCON_DSI clock
> register, SUN4I_TCON0_DCLK_REG, which marked the divider 4 by default.
>
> >
> > What compelling evidence have you found that makes you say otherwise?
>
> divider 4 isn't worked, this I would mentioned before as well.
>
> Tested this on 4 different panels, and below are the desired divider values
> and pll-mipi clock rate with respect to pixel clock frequency.
>
> - 55MHz pixel clock with 4-lane panel, and the desired DSI clock divider
>   is 6 with the output parent clock rate of 330MHz.
> - 30MHz pixel clock with 4-lane panel, and the desired DSI clock divider
>   is 6 with parent clock rate of 180MHz.
> - 27.5Mhz pixel clock with 2-lane pane, and the desired DSI clock divider
>   is 12 with the output parent clock rate of 330MHz.
> - 147MHz pixel clock with 4-lane panel, and the desired DSI clock divider
>   is 6 with the output parent clock rate of 882MHz.
>
> BSP trying to use this format/lane to compute dsi divider that in-turn
> using pll-mipi set_rate but TCON0_DCLK_REG keep constant 4.

Any comments?

For more information, I have even tying to get the dump here to show
the pll_rate set in BSP code [1], please have a look at this gist[2]
where the bpp/lanes value of 6 is computed for pll_rate and let me
know what do you think?

DSI rate is 148.5Mhz
Panel Pixel clock is 148Mhz
PLL set rate is 888Mhz (which is bpp/lanes = 6 * 148 Mhz)

[1] https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c#L793
[2] https://gist.github.com/openedev/9bae2d87d2fcc06b999fe48c998b7043
     https://gist.github.com/openedev/700de2e3701b2bf3ad1aa0f0fa862c9a
