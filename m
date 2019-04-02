Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B1FC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978A720883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mHKCkswu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731401AbfDBNdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:33:53 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:52763 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731377AbfDBNdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:33:52 -0400
Received: by mail-it1-f193.google.com with SMTP id x132so3037491itf.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 06:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dUIlCm4o7H0B+jroFyOFWZukTrGH3BevBvJsnu2hNHY=;
        b=mHKCkswuLdAr+fHuGeGcTI8sWZaxTXOVlUfWx5o2HXq0Yi2jra+oxBJsTTEHPTXoZb
         NCTz+IOByetunLwFPCULWeDDEdtfE/jVm0AmZqRL8BAr8UGy3H5d9Er+mxtbxn6BFFO9
         hM6EJ278CWTE1ESVNmQGsAzsovn3pwBK6gcyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dUIlCm4o7H0B+jroFyOFWZukTrGH3BevBvJsnu2hNHY=;
        b=aiWRHRn4RsWXlByUYmbBpWs/mG15UkJyXy/JssJnD7cTGPQveInIlOwF3ynhdJENWV
         prv2kamy/FMkUDAQpBBDXzhf+6z8m81cS+S/X5nlqr+EY+Y9TDF+437PzVvSbjMj+gCS
         WSiEO81YkhKitYAKlyiHKj2lz4feiUHyC5830u8Iu8IvkoBjkDYLlSn+smURzv1w00yv
         4luZYpcyna75VLkCSVVW6gcmHNkgbKHHvhpePgbB6lNT8ug0SQVKBw6DfST20DuKSiq6
         5hE8c7H/v54mnXLor1bDiPVobgLhzSfUOTYONJZh6twMFE+enqdDFq6GZwOjkfRosT2P
         /SEg==
X-Gm-Message-State: APjAAAUfEqjrg0eOB3UBGg51iCBxcoZv4/QIOLT27PmIR8kHb52aMr4z
        6s2bNNB698hk7SUj2LHqo+yDFVNf2Pvg8oStH2heDg==
X-Google-Smtp-Source: APXvYqwUUsW38UrSkwXJ4S0Jm3pC4KTXrbDLNNc6+iHf7WGCVxEZQepelSG8T8TTBEMuZ2HHkuv9mC3fRfGojc1uu9Y=
X-Received: by 2002:a24:1cc4:: with SMTP id c187mr4328464itc.85.1554212030866;
 Tue, 02 Apr 2019 06:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190311133637.18334-1-jagan@amarulasolutions.com>
 <20190311133637.18334-3-jagan@amarulasolutions.com> <20190311153847.oz6ruqmptaq2befn@flea>
 <CAMty3ZChz=s7gdQyX9KnsAp1t5FrpouXGK74-r0SKJ89yJN67Q@mail.gmail.com>
 <20190319105307.omowzyhqu33e3pzy@flea> <CAMty3ZCjTLLw+zAfPKD3qZx_o9yti4MD0XL0Ve7VG1_6ToJ=pg@mail.gmail.com>
In-Reply-To: <CAMty3ZCjTLLw+zAfPKD3qZx_o9yti4MD0XL0Ve7VG1_6ToJ=pg@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 2 Apr 2019 19:03:39 +0530
Message-ID: <CAMty3ZD7yPg9hJNw9Yy1SYKPMPsmt3n1PD6PkyE9KJNpcTyZVA@mail.gmail.com>
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

Hi Maxime,

On Thu, Mar 21, 2019 at 7:40 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Tue, Mar 19, 2019 at 4:23 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Mon, Mar 11, 2019 at 09:36:27PM +0530, Jagan Teki wrote:
> > > On Mon, Mar 11, 2019 at 9:08 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > >
> > > > On Mon, Mar 11, 2019 at 07:06:24PM +0530, Jagan Teki wrote:
> > > > > pll-video => pll-mipi => tcon0 => tcon0-pixel-clock is the typical
> > > > > MIPI clock topology in Allwinner DSI controller.
> > > > >
> > > > > TCON dotclock driver is computing the desired DCLK divider based on
> > > > > panel pixel clock along with input DCLK min, max divider values from
> > > > > tcon driver and that would eventually set the pll-mipi clock rate.
> > > > >
> > > > > The current code allows the TCON clock divider to have a default 4
> > > > > for min, max ranges that would fail to compute the desired pll-mipi
> > > > > rate while supporting new panels.
> > > > >
> > > > > So, add the computation logic 'format/lanes' to dclk min and max dividers
> > > > > and instead of default 4. This computation logic align with Allwinner A64
> > > > > BSP, hoping that would work even for A33.
> > > >
> > > > Last time we discussed this, we found out that this wasn't the case,
> > > > even in the BSP.
> > >
> > > This was the case for BSP to compute pll-mipi not for TCON_DSI clock
> > > register, SUN4I_TCON0_DCLK_REG, which marked the divider 4 by default.
> > >
> > > > What compelling evidence have you found that makes you say otherwise?
> > >
> > > divider 4 isn't worked, this I would mentioned before as well.
> >
> > Maybe you mentionned it before, but it's nowhere to be found in your
> > commit log.
>
> I have added it in 3rd paragraph in commit message, may be you missed
> it or you may look for different text.
>
> "The current code allows the TCON clock divider to have a default 4
> for min, max ranges that would fail to compute the desired pll-mipi
> rate while supporting new panels."
>
> >
> > > Tested this on 4 different panels, and below are the desired divider values
> > > and pll-mipi clock rate with respect to pixel clock frequency.
> > >
> > > - 55MHz pixel clock with 4-lane panel, and the desired DSI clock divider
> > >   is 6 with the output parent clock rate of 330MHz.
> > > - 30MHz pixel clock with 4-lane panel, and the desired DSI clock divider
> > >   is 6 with parent clock rate of 180MHz.
> > > - 27.5Mhz pixel clock with 2-lane pane, and the desired DSI clock divider
> > >   is 12 with the output parent clock rate of 330MHz.
> > > - 147MHz pixel clock with 4-lane panel, and the desired DSI clock divider
> > >   is 6 with the output parent clock rate of 882MHz.
> > >
> > > BSP trying to use this format/lane to compute dsi divider that in-turn
> > > using pll-mipi set_rate but TCON0_DCLK_REG keep constant 4.
> >
> > Feel free to reply to
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2019-February/629596.html
>
> Yes, I have replied at that time itself, please check.
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2019-February/629673.html
>
> Here I have taken the pixel clock to 30Mhz for example in Bananapi
> panel, and the above gist the pixel is 148Mhz from another panel.

Any further comments?
