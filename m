Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8553C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA48C218FF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Sh78JYLG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbfCUOKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:10:45 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40621 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbfCUOKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:10:45 -0400
Received: by mail-io1-f68.google.com with SMTP id d201so789435iof.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 07:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l4prZKlAB50Bs9wlhPUMWokWMRil7AfNQQkRJzsmuYY=;
        b=Sh78JYLGniAQPuLJlDnBHZVtLqX+7noyJdkomCbID+4lx3h7EdXLR/WREys+rITaL0
         LGQWR97hP3kb2UPFSwhw/qed4Sms7+rgmBVYfnaG0aFcy2H6s6OFgJDsTBXgR4+iIsgi
         LXZnt+/EFCiTsasqHJK4eF3tcPNd6NxrD//rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l4prZKlAB50Bs9wlhPUMWokWMRil7AfNQQkRJzsmuYY=;
        b=rrkePB9AhSwcfjPGquRRpL9QBooEOua1zqxFGJ62c9fOOOjj/5FW+8+UoBjt8xvQDJ
         dHBQDks6gHKyd+DLvF1M4hshChrp+r4TWCyWMLnYeIS6xoXQSZirn6gElE2yGqVdu1PY
         fK0lb7TbSzhAooXBJOC16RNcW1921VZ75XLszP5e6a9NRJwa3eL0Y/eGpjAEYYTkSNcw
         uABgp+1bdvRC10EtRAfWAtZI/xLFEvqqbkdAE2kJzfBEGrW5/jZ4u0Bb9fwUu1k/e7ZX
         vyYFrF8r1YHJ8YhLc8dtilP9UVZV1tJkxnMLjYeSZsax8E0wrJXCfSXPOAdtIXG8V+G5
         Y2sw==
X-Gm-Message-State: APjAAAVVLyT/UJRAeQYOCYrLQSh05icnZNwuWYEIJ/dNY+Dn+eOmTVRR
        MGG4vZd+KFOJncS7OlHe2jsVgMg2leUV5NxrOwQoDQ==
X-Google-Smtp-Source: APXvYqzLcX99QhGQY9GWWcP14CpRZJxMXiunytxXoXfrolX6QQUdqNmsusZCUuWc74bsFNkaU5FPTLwDLr8EH8OY6YA=
X-Received: by 2002:a6b:d80a:: with SMTP id y10mr2704810iob.114.1553177444368;
 Thu, 21 Mar 2019 07:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190311133637.18334-1-jagan@amarulasolutions.com>
 <20190311133637.18334-3-jagan@amarulasolutions.com> <20190311153847.oz6ruqmptaq2befn@flea>
 <CAMty3ZChz=s7gdQyX9KnsAp1t5FrpouXGK74-r0SKJ89yJN67Q@mail.gmail.com> <20190319105307.omowzyhqu33e3pzy@flea>
In-Reply-To: <20190319105307.omowzyhqu33e3pzy@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 21 Mar 2019 19:40:32 +0530
Message-ID: <CAMty3ZCjTLLw+zAfPKD3qZx_o9yti4MD0XL0Ve7VG1_6ToJ=pg@mail.gmail.com>
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

On Tue, Mar 19, 2019 at 4:23 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Mon, Mar 11, 2019 at 09:36:27PM +0530, Jagan Teki wrote:
> > On Mon, Mar 11, 2019 at 9:08 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Mon, Mar 11, 2019 at 07:06:24PM +0530, Jagan Teki wrote:
> > > > pll-video => pll-mipi => tcon0 => tcon0-pixel-clock is the typical
> > > > MIPI clock topology in Allwinner DSI controller.
> > > >
> > > > TCON dotclock driver is computing the desired DCLK divider based on
> > > > panel pixel clock along with input DCLK min, max divider values from
> > > > tcon driver and that would eventually set the pll-mipi clock rate.
> > > >
> > > > The current code allows the TCON clock divider to have a default 4
> > > > for min, max ranges that would fail to compute the desired pll-mipi
> > > > rate while supporting new panels.
> > > >
> > > > So, add the computation logic 'format/lanes' to dclk min and max dividers
> > > > and instead of default 4. This computation logic align with Allwinner A64
> > > > BSP, hoping that would work even for A33.
> > >
> > > Last time we discussed this, we found out that this wasn't the case,
> > > even in the BSP.
> >
> > This was the case for BSP to compute pll-mipi not for TCON_DSI clock
> > register, SUN4I_TCON0_DCLK_REG, which marked the divider 4 by default.
> >
> > > What compelling evidence have you found that makes you say otherwise?
> >
> > divider 4 isn't worked, this I would mentioned before as well.
>
> Maybe you mentionned it before, but it's nowhere to be found in your
> commit log.

I have added it in 3rd paragraph in commit message, may be you missed
it or you may look for different text.

"The current code allows the TCON clock divider to have a default 4
for min, max ranges that would fail to compute the desired pll-mipi
rate while supporting new panels."

>
> > Tested this on 4 different panels, and below are the desired divider values
> > and pll-mipi clock rate with respect to pixel clock frequency.
> >
> > - 55MHz pixel clock with 4-lane panel, and the desired DSI clock divider
> >   is 6 with the output parent clock rate of 330MHz.
> > - 30MHz pixel clock with 4-lane panel, and the desired DSI clock divider
> >   is 6 with parent clock rate of 180MHz.
> > - 27.5Mhz pixel clock with 2-lane pane, and the desired DSI clock divider
> >   is 12 with the output parent clock rate of 330MHz.
> > - 147MHz pixel clock with 4-lane panel, and the desired DSI clock divider
> >   is 6 with the output parent clock rate of 882MHz.
> >
> > BSP trying to use this format/lane to compute dsi divider that in-turn
> > using pll-mipi set_rate but TCON0_DCLK_REG keep constant 4.
>
> Feel free to reply to
> http://lists.infradead.org/pipermail/linux-arm-kernel/2019-February/629596.html

Yes, I have replied at that time itself, please check.

http://lists.infradead.org/pipermail/linux-arm-kernel/2019-February/629673.html

Here I have taken the pixel clock to 30Mhz for example in Bananapi
panel, and the above gist the pixel is 148Mhz from another panel.
