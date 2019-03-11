Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E6BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB84B206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qLxo7lMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfCKQGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:06:40 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45253 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbfCKQGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:06:40 -0400
Received: by mail-io1-f65.google.com with SMTP id x9so4483633iog.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 09:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WCUvHye2jt+SRY6XPXyOCOgw8ixwhO4hL1UzT96KMAo=;
        b=qLxo7lMoM+5LgMlXK0Gl8ITyBmAW8+wMuqayrUjRy9mB7ETpjmLyalX/nPmWLZzlpO
         B4ZG/Ulr5GyndbAoFXz9nZOguO/sBHM3qxoLQKT/sI0oJ4tRQQjTVhP5CZRun64wxvJw
         n5HarI5dC2UmLY7ZPTtcr0FS24fh83s48yDcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WCUvHye2jt+SRY6XPXyOCOgw8ixwhO4hL1UzT96KMAo=;
        b=Y/eD77SVDl7IKzp0syuqRNNmVyE7XlagHZ/hJbhKe+mJkBrE6VhwrR4L0VNhTObCmW
         zLe1oq7glkE+hWgy7Aw1anZ0xIcxQ0qGEaZ5sAKgFLGsrCeDIO0Y4NNSOW4/g9iAkRoI
         64z7NFqCXX7+/oZgzQZ2I7YUy98jEZPhNuYybQ5xfWmemXkNf3KVqdM/OsM8BOEjbv67
         A/Hbk7idBWZ+OsCbx91dlvy0WcQYinEJvaNBny/BO8f9yXRlm66hxiseumNsQKuGy7G2
         6FMh6lMtpXS66fZlYiM50c0cxD/7Y0TShBxDWnVRfFTGZdcwKL2tHLaEcGE+xmRy4qtH
         Wpdw==
X-Gm-Message-State: APjAAAWKqUzKoGDRI56VZuZOXxvn0A+Hl1MIX5aDaDk3lubSoLr1m727
        Iqbe/+CaLBq9fuMBzZeyxo88PZBeOSXQ56kkQGE8nw==
X-Google-Smtp-Source: APXvYqyDx/kF4pBZFfoYncrUazhGpND/MDNkhIvzx6Up5f1YYpGoHDcg7RWBK7LnwDnE6VesrDS0u2QOWMLYRrbJXFs=
X-Received: by 2002:a5d:97c8:: with SMTP id k8mr18202861ios.267.1552320399007;
 Mon, 11 Mar 2019 09:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190311133637.18334-1-jagan@amarulasolutions.com>
 <20190311133637.18334-3-jagan@amarulasolutions.com> <20190311153847.oz6ruqmptaq2befn@flea>
In-Reply-To: <20190311153847.oz6ruqmptaq2befn@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 11 Mar 2019 21:36:27 +0530
Message-ID: <CAMty3ZChz=s7gdQyX9KnsAp1t5FrpouXGK74-r0SKJ89yJN67Q@mail.gmail.com>
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

On Mon, Mar 11, 2019 at 9:08 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Mon, Mar 11, 2019 at 07:06:24PM +0530, Jagan Teki wrote:
> > pll-video => pll-mipi => tcon0 => tcon0-pixel-clock is the typical
> > MIPI clock topology in Allwinner DSI controller.
> >
> > TCON dotclock driver is computing the desired DCLK divider based on
> > panel pixel clock along with input DCLK min, max divider values from
> > tcon driver and that would eventually set the pll-mipi clock rate.
> >
> > The current code allows the TCON clock divider to have a default 4
> > for min, max ranges that would fail to compute the desired pll-mipi
> > rate while supporting new panels.
> >
> > So, add the computation logic 'format/lanes' to dclk min and max dividers
> > and instead of default 4. This computation logic align with Allwinner A64
> > BSP, hoping that would work even for A33.
>
> Last time we discussed this, we found out that this wasn't the case,
> even in the BSP.

This was the case for BSP to compute pll-mipi not for TCON_DSI clock
register, SUN4I_TCON0_DCLK_REG, which marked the divider 4 by default.

>
> What compelling evidence have you found that makes you say otherwise?

divider 4 isn't worked, this I would mentioned before as well.

Tested this on 4 different panels, and below are the desired divider values
and pll-mipi clock rate with respect to pixel clock frequency.

- 55MHz pixel clock with 4-lane panel, and the desired DSI clock divider
  is 6 with the output parent clock rate of 330MHz.
- 30MHz pixel clock with 4-lane panel, and the desired DSI clock divider
  is 6 with parent clock rate of 180MHz.
- 27.5Mhz pixel clock with 2-lane pane, and the desired DSI clock divider
  is 12 with the output parent clock rate of 330MHz.
- 147MHz pixel clock with 4-lane panel, and the desired DSI clock divider
  is 6 with the output parent clock rate of 882MHz.

BSP trying to use this format/lane to compute dsi divider that in-turn
using pll-mipi set_rate but TCON0_DCLK_REG keep constant 4.
