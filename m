Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439B6C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1443F218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="g1PYiMNF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfCUOLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:11:42 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35310 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbfCUOLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:11:41 -0400
Received: by mail-io1-f65.google.com with SMTP id x4so5327579ion.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 07:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ADscw/yqxQuUf4MbLlwnwNF0LT5L7GDq1iDTgC4RvQ=;
        b=g1PYiMNFnqbMB1gAf8NL9OfTqrjh3Qpf2/kYNlHDA2TrMhU2Pvufl/Gip1/9yNE0Lo
         xVya9DuT6aWjBBiLMtGIjwOQZvY2+HZxIjf9xZbwAbsmHwSSEeg9/7VbjU9+qBpi5XoA
         /wALKblC1c5IYTuMhd7eZqV5Pff6+MIzjAyQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ADscw/yqxQuUf4MbLlwnwNF0LT5L7GDq1iDTgC4RvQ=;
        b=tc6IcuYqGzXudmLLom7j9wckstk4TAOnApu01FwzPzFYaHzqm9tb4epCqET9oYYe3S
         k94w5r2PIUwVemVW+Es1nExAktoPiDUvsh2t33peb2AqUu5DuL6NBonoOofqMqK5v2+g
         3vq8yGcaz2ojiffPwqohp8vA7LJoL1LBReHg9d1l1mXQeqiNHowe7p4naJUAUEFuEeNJ
         o4BIYn4m08sRKR2LSj0Tu3ZzWfTyax5gyRBwKyKqso6Kt8LER+TEOv0fEaud/T639EDu
         /0jcfEXpU5fpN0hTTIvKlemKC//HVXNPGrVcrNrHy//EpOiv28/8a/XhkcC5GEc/Rzc3
         kB+Q==
X-Gm-Message-State: APjAAAV5ubk0M2NXLdgB2nyvy+9B6bcxt3oGuarhYPYGn4tcySM6/Iio
        LgAl09jsUuCAUyXkcUXsRMbziCsRELFOjTeJmh9I7A==
X-Google-Smtp-Source: APXvYqzgjqYgaPyCy+tLoYG9qXmF+KjPFk2C8OigkBAYak5ZfVPgnhVypLipIHvf1ovQ2jOLD0HFrh6nbgW+OKDHwH0=
X-Received: by 2002:a6b:d80a:: with SMTP id y10mr2708705iob.114.1553177500014;
 Thu, 21 Mar 2019 07:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190311133637.18334-1-jagan@amarulasolutions.com>
 <20190311133637.18334-3-jagan@amarulasolutions.com> <20190311153847.oz6ruqmptaq2befn@flea>
 <CAMty3ZChz=s7gdQyX9KnsAp1t5FrpouXGK74-r0SKJ89yJN67Q@mail.gmail.com>
 <20190319105307.omowzyhqu33e3pzy@flea> <7dab458e-7fad-2dbe-bbae-bd3cdf89dcb4@orpaltech.com>
In-Reply-To: <7dab458e-7fad-2dbe-bbae-bd3cdf89dcb4@orpaltech.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 21 Mar 2019 19:41:28 +0530
Message-ID: <CAMty3ZCEjVhTvjUgvnkR7SpeC8m10f0FpnvLWCEkMksbhfWR2Q@mail.gmail.com>
Subject: Re: [PATCH v8 02/15] drm/sun4i: tcon: Compute DCLK dividers based on
 format, lanes
To:     Sergey Suloev <ssuloev@orpaltech.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        devicetree <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

On Tue, Mar 19, 2019 at 5:47 PM Sergey Suloev <ssuloev@orpaltech.com> wrote:
>
> Hi, guys,
>
> On 3/19/19 1:53 PM, Maxime Ripard wrote:
>
> On Mon, Mar 11, 2019 at 09:36:27PM +0530, Jagan Teki wrote:
>
> On Mon, Mar 11, 2019 at 9:08 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Mon, Mar 11, 2019 at 07:06:24PM +0530, Jagan Teki wrote:
>
> pll-video => pll-mipi => tcon0 => tcon0-pixel-clock is the typical
> MIPI clock topology in Allwinner DSI controller.
>
> TCON dotclock driver is computing the desired DCLK divider based on
> panel pixel clock along with input DCLK min, max divider values from
> tcon driver and that would eventually set the pll-mipi clock rate.
>
> The current code allows the TCON clock divider to have a default 4
> for min, max ranges that would fail to compute the desired pll-mipi
> rate while supporting new panels.
>
> So, add the computation logic 'format/lanes' to dclk min and max dividers
> and instead of default 4. This computation logic align with Allwinner A64
> BSP, hoping that would work even for A33.
>
> Last time we discussed this, we found out that this wasn't the case,
> even in the BSP.
>
> This was the case for BSP to compute pll-mipi not for TCON_DSI clock
> register, SUN4I_TCON0_DCLK_REG, which marked the divider 4 by default.
>
> What compelling evidence have you found that makes you say otherwise?
>
> divider 4 isn't worked, this I would mentioned before as well.
>
> Maybe you mentionned it before, but it's nowhere to be found in your
> commit log.
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
>
> Feel free to reply to
> http://lists.infradead.org/pipermail/linux-arm-kernel/2019-February/629596.html
>
> And correct whatever is said there that isn't what is happening.
>
>
> excuse me if my message is out of topic.
>
> I just want let you know  that the code
>
> tcon->dclk_min_div = SUN6I_DSI_TCON_DIV;
> tcon->dclk_max_div = SUN6I_DSI_TCON_DIV;
>
> where SUN6I_DSI_TCON_DIV = 4  isn't working with my 2-lane panel: I am always getting the error:
>
>  [CRTC:38:crtc-0] vblank wait timed out
>
> As soon as I set
>
> tcon->dclk_min_div = tcon->dclk_max_div = bpp/lanes, i.e. 12
>
> the error disappears.

Yes, I did test the same in 2-lane panel. it worked with the logic.
thanks for testing.
