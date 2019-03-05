Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494D0C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A33E20684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="F4kiFERI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbfCEQIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 11:08:12 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:39275 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbfCEQIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 11:08:12 -0500
Received: by mail-io1-f68.google.com with SMTP id x3so7473904ior.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 08:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+/U2CDL/W95ENCeyah388mBN8GQ//SqGFlcRGEgMdV0=;
        b=F4kiFERInLGpipDyYM2zmE1EAYdfC/AcPUwiFq5lbUHoBpfJobBg10NVCb+ZidqhM5
         Z6r6kDtdqRTjWOB4hggmuuupltWgt3BTCq79o2LbjRBYKrondKf5mOLGMvTKIxKLlA6d
         dDHO9u4L1+GbhLZ4zfk3ppahbjrnLwMt4RanQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+/U2CDL/W95ENCeyah388mBN8GQ//SqGFlcRGEgMdV0=;
        b=raWQZ8bE7lpPN7zLwJoWaIs1DZKNFwDUoEnFcYfIK9uP/oiKvDvXU1lM6PgYYY/UUx
         P3minje4W4LyUD8bkcoWIwaFSZERnxgdkGy+SPlPD/2djpR78HnFKRPxPUSHDAGR0dX8
         Zva/UVgmhxGE4Bnb8pB+KbBFnICVxEM0D+VmCRrzEJv0wUwtj3U79dQGxK0WFLsMhyrL
         aImuWIXrPEC4fKtgVcm8p4mKy3akKVNE+JAjMqiccbGSGZ2NKTRFQ6dGwRTxPwqyEGPO
         ogRIt5mK7XuIavJkReEqGawQHPxqr9LaBs7ugx34QtAHuGg4Fxb4dfFOicELEa5tP3E7
         gVRA==
X-Gm-Message-State: APjAAAWns9LBgYKsBfRhPN1bAb2Aim5jRXnVlND1jvr82m46AtY5tvso
        st58VZeONnQNRo/eraqdu7Yuftonki+NjGubDpx4JA==
X-Google-Smtp-Source: APXvYqxK/gpWj1B4CQoRgjm3yBUUbxiPTYhNEYv/ZiRDUdaHhBQsO1FJ+fp+xdenmEQQpzm9AcwprJM4c5TxhdQNYTQ=
X-Received: by 2002:a5e:c605:: with SMTP id f5mr483237iok.252.1551802091138;
 Tue, 05 Mar 2019 08:08:11 -0800 (PST)
MIME-Version: 1.0
References: <20190226060240.8783-1-jagan@amarulasolutions.com>
 <20190226060240.8783-2-jagan@amarulasolutions.com> <20190227153346.dwd3stsbsvf7rwly@flea>
 <CAMty3ZDSZvaxMjcQJLNaTDJQ5OjJ9NbjpOJKWMUE5PhRCzYvqw@mail.gmail.com>
 <20190301145724.vhvyoqkkxdflg2g7@flea> <CAMty3ZCUSsN71Q5h_nj6de0Smhqht1S5zq0pLKUqpwq=85XqXw@mail.gmail.com>
 <20190305155919.cm3yrve3vqp7jimh@flea>
In-Reply-To: <20190305155919.cm3yrve3vqp7jimh@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 5 Mar 2019 21:37:59 +0530
Message-ID: <CAMty3ZD6Bsu7B6phhf4h7jreoM1uvM-ZQNCaUZKKa=1DNOtb8A@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: allwinner: a64: Add Oceanic A64-5inMFD initial support
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryan Pannell <ryan@osukl.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 9:29 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Fri, Mar 01, 2019 at 10:27:14PM +0530, Jagan Teki wrote:
> > On Fri, Mar 1, 2019 at 8:27 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Wed, Feb 27, 2019 at 09:49:23PM +0530, Jagan Teki wrote:
> > > > On Wed, Feb 27, 2019 at 9:03 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Tue, Feb 26, 2019 at 11:32:40AM +0530, Jagan Teki wrote:
> > > > > > Oceanic A64-5inMFD is a 5 inch Multi function display baseboard
> > > > > > designed to mount SoPine SOM.
> > > > > >
> > > > > > Key features:
> > > > > > - Allwinner A64 Cortex-A53
> > > > > > - Mali-400MP2 GPU
> > > > > > - AXP803 PMIC
> > > > > > - 2GB DDR3 RAM
> > > > > > - SD Slot
> > > > > > - SPI-NOR flash
> > > > > > - EMAC, RTL8211E
> > > > > > - MCP2515 CAN
> > > > > > - MIPI-DSI
> > > > > > - Goodix 911 CTP
> > > > > > - USB Host
> > > > > > - 12V DC power supply
> > > > > >
> > > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > > ---
> > > > > >  arch/arm64/boot/dts/allwinner/Makefile        |  1 +
> > > > > >  .../allwinner/sun50i-a64-oceanic-5inmfd.dts   | 46 +++++++++++++++++++
> > > > > >  2 files changed, 47 insertions(+)
> > > > > >  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5inmfd.dts
> > > > > >
> > > > > > diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
> > > > > > index a5fb1eaa8acf..ec39fe856117 100644
> > > > > > --- a/arch/arm64/boot/dts/allwinner/Makefile
> > > > > > +++ b/arch/arm64/boot/dts/allwinner/Makefile
> > > > > > @@ -2,6 +2,7 @@
> > > > > >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-amarula-relic.dtb
> > > > > >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-bananapi-m64.dtb sun50i-a64-bananapi-m64-icn6211.dtb
> > > > > >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-nanopi-a64.dtb
> > > > > > +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-oceanic-5inmfd.dtb
> > > > > >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-olinuxino.dtb
> > > > > >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-orangepi-win.dtb
> > > > > >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pine64-lts.dtb
> > > > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5inmfd.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5inmfd.dts
> > > > > > new file mode 100644
> > > > > > index 000000000000..d73d1f55acb9
> > > > > > --- /dev/null
> > > > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5inmfd.dts
> > > > > > @@ -0,0 +1,46 @@
> > > > > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > > > > +/*
> > > > > > + * Copyright (C) 2019 Oceanic Systems (UK) Ltd.
> > > > > > + * Copyright (C) 2019 Amarula Solutions B.V.
> > > > > > + * Author: Jagan Teki <jagan@amarulasolutions.com>
> > > > > > + */
> > > > > > +
> > > > > > +/dts-v1/;
> > > > > > +
> > > > > > +#include "sun50i-a64-sopine.dtsi"
> > > > > > +
> > > > > > +/ {
> > > > > > +     model = "Oceanic A64-5inMFD";
> > > > > > +     compatible = "oceanic,a64-5inmfd", "allwinner,sun50i-a64";
> > > > >
> > > > > The name of the DT is Oceanic 5inMFD, while you call the board
> > > > > A64-5inMFD here, which name is the actual name?
> > > >
> > > > Yes, this is something that we discussed during "Amarula A64-Relic"
> > > > naming convention.
> > > >
> > > > Since these boards are not famous like teres-i we agreed to add vendor
> > > > name after sun50i-a64- followed by real board name.
> > > >
> > > > Here A64 already covered during sun50i-a64- so the dts name simply the
> > > > <vendor_name>-<real_board_name>
> > >
> > > For the DT name, yeah, we want that pattern.
> > >
> > > For the compatible and model, we want to use the model name.
> >
> > Entire model name after <vendor_name>, ?
> >
> > model = "Oceanic A64-5inMFD";
> > compatible = "oceanic,a64-5inmfd", "allwinner,sun50i-a64";
> >
> > is this not sufficient?
> >
> > Let me understand with respective few existing stuff.
> >
> > model = "Amarula A64-Relic";
> > compatible = "amarula,a64-relic", "allwinner,sun50i-a64";
> >
> > model = "Olimex A64 Teres-I"
> > compatible = "olimex,a64-teres-i", "allwinner,sun50i-a64";
>
> This one is called the TERES-A64:
> https://www.olimex.com/Products/DIY-Laptop/KITS/TERES-A64-WHITE/open-source-hardware
>
> The laptop is the Teres-I, it can have an A64
>
> > model = "FriendlyARM NanoPi A64";
> > compatible = "friendlyarm,nanopi-a64", "allwinner,sun50i-a64";
>
> NanoPi A64 is the name of the board: http://nanopi.io/nanopi-a64.html
>
> > model = "Olimex A64-Olinuxino";
> > compatible = "olimex,a64-olinuxino", "allwinner,sun50i-a64"
>
> A64-Olinuxino is the name of the board too:
> https://www.olimex.com/Products/OLinuXino/A64/A64-OLinuXino/open-source-hardware
>
> > Would you comment, what is the different with respect to my change?
>
> If the name of the product is 5inMFD, then the model should be Oceanic
> 5inMFD, and its compatible oceanic,5inmfd

Oceanic seems to have some multiple Multi Function Devices, ie reason
we prefer the product as 'A64-5inMFD' since it is A64 based. In this
case the model and compatible should be fine I think?
