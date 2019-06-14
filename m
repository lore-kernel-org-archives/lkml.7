Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEEAC31E4C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC898208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfFNJyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 05:54:18 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45135 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbfFNJyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 05:54:15 -0400
Received: by mail-ed1-f68.google.com with SMTP id a14so2622293edv.12;
        Fri, 14 Jun 2019 02:54:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qHuGCrXRTUkFQGayB4c7fw1V8CKP+g27HnNUqp7luJE=;
        b=A61E+uFgn8g+uIiDes5z+O80mUf9mAy/dPoIP93za8g2WnuMP9LU+jI95OG1ls79Kx
         yDnDx7RhzSuvjPyLxRjg8nzluuiy7QKz6T7IitCjR9TuDlS6HuiDbmDOn4r0UzAF7NGN
         rcnlm8IHYqnWYpux0ZWee8fDYKKLJo/QlVDTl9nJ6w1ox5KaD8ov5oJNOE0BBRk0uwhX
         PrYGOG+ZBhddM1MJ3K4D2aIZdb5FLWBmXTBUbAAUkWkjRFOUd7MGeAgD77xY1E9eJits
         /gwOePblt3QG1L3MDiaTz/fTDrxhNm6tASrrT4ZVCMZrz6nT2GfUac3VcAOGfP7/eD5g
         1YOw==
X-Gm-Message-State: APjAAAVSS2i2sKYjImsKi9wQpzsJO0M/Y8/VoEWlZ0sG89LCiBX473+I
        x5P60eU0xONYWUitHtk3uqz1u+m+4u8=
X-Google-Smtp-Source: APXvYqwbflIiWpIZ18fe2y9eLll7EthUnohzkEFO5UdPG4ILKM1Dc6YIpEUU1uVRF1oIgJnB5da2nw==
X-Received: by 2002:a05:6402:652:: with SMTP id u18mr7218160edx.85.1560506053022;
        Fri, 14 Jun 2019 02:54:13 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id a17sm710461edt.63.2019.06.14.02.54.11
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 02:54:12 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id z23so1652146wma.4;
        Fri, 14 Jun 2019 02:54:11 -0700 (PDT)
X-Received: by 2002:a1c:a186:: with SMTP id k128mr7440554wme.125.1560506051478;
 Fri, 14 Jun 2019 02:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190613185241.22800-1-jagan@amarulasolutions.com>
 <20190613185241.22800-6-jagan@amarulasolutions.com> <CAGb2v654p=HZuXCTJkrbWbFP_kEkpRWHwj-7_Ck_=XbyMFmvFw@mail.gmail.com>
 <CAMty3ZD0atS2uWJmPB-n1wmy324JEpwt42=_wpKeF-8uxM-GbQ@mail.gmail.com>
In-Reply-To: <CAMty3ZD0atS2uWJmPB-n1wmy324JEpwt42=_wpKeF-8uxM-GbQ@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 14 Jun 2019 17:53:58 +0800
X-Gmail-Original-Message-ID: <CAGb2v66BOOydMRQprKAo87F2rpr+xgqWgpGt_cccoHf8+9AoNA@mail.gmail.com>
Message-ID: <CAGb2v66BOOydMRQprKAo87F2rpr+xgqWgpGt_cccoHf8+9AoNA@mail.gmail.com>
Subject: Re: [PATCH 5/9] ARM: dts: sun8i: r40: Add TCON TOP LCD clocking
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 5:48 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Fri, Jun 14, 2019 at 9:16 AM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > On Fri, Jun 14, 2019 at 2:54 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > >
> > > According to Fig 7-2. TCON Top Block Diagram in User manual.
> > >
> > > TCON TOP can have an hierarchy for TCON_LCD0, LCD1 like
> > > TCON_TV0, TV1 so, the tcon top would handle the clocks of
> > > TCON_LCD0, LCD1 similar like TV0, TV1.
> >
> > That is not guaranteed. The diagram shows the pixel data path,
> > not necessarily the clocks. In addition, the LCD TCONs have an
> > internal clock gate for the dot-clock output, which the TV variants
> > do not. That might explain the need for the gates in TCON TOP.
>
> Correct, the actual idea about explanation here is to mention the
> clocks definition in tcon top level and internal tv and lcd can handle
> as you explained.
>
> >
> > > But, the current tcon_top node is using dsi clock name with
> > > CLK_DSI_DPHY which is ideally handle via dphy which indeed
> > > a separate interface block.
> > >
> > > So, use tcon-lcd0 instead of dsi which would refer the
> > > CLK_TCON_LCD0 similar like CLK_TCON_TV0 with tcon-tv0.
> > >
> > > This way we can refer CLK_TCON_LCD0 from tcon_top clock in
> > > tcon_lcd0 node and the actual DSI_DPHY clock node would
> > > refer in dphy node.
> >
> > That doesn't make sense. What about TCON_LCD1?
> >
> > The CCU already has CLK_TCON_LCD0 and CLK_TCON_LCD1. What makes
> > you think that the TCONs don't use them directly?
> >
> > Or maybe they do go through TCON_TOP, but there's no gate,
> > so we don't know about it.
> >
> > You need to rethink this. What are you trying to deal with?
>
> Yes, I understand what your asking for and indeed this is where I get
> confused and tried this way initially and attach the dsi reference in
> dphy something like
>
> tcon_lcd0 {
>                 clocks = <&ccu CLK_BUS_TCON_LCD0>, <&ccu CLK_TCON_LCD0>;
>                 clock-names = "ahb", "tcon-ch0";
> };
>
> dphy {
>                clocks = <&ccu CLK_BUS_MIPI_DSI>,
>                               <&tcon_top CLK_TCON_TOP_DSI>;
>                clock-names = "bus", "mod";
> };
>
> This would ended-up, phy wont getting the mod clock keep probing for
> -EPROBE-DEFER since tcon top driver might not be loaded at the time
> mipi driver. This way we have tv0, tv1 and dsi gates supported as
> existed. Does it make sense?

Looks like that happens because the clocks are only registered at
the component bind phase, rather than the probe phase. And to bind
all the components, the DSI controller wants the DPHY available,
which isn't because it's still waiting for the clock.

So you could try moving the bits that register the clocks in the
TCON TOP driver to the probe function, and see if that solves
the circular dependency issue.

ChenYu
