Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F439C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DDA62083D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MPmgRrCf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389309AbfCAQ51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:57:27 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:53922 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389270AbfCAQ51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:57:27 -0500
Received: by mail-it1-f195.google.com with SMTP id v2so21150155ith.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 08:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N0qix8KStCrr38pwzys0Ft4SlHFjFr2KiDnwm8gEhec=;
        b=MPmgRrCf00md36nzoiRMD1mlnNqlWfkv50AzWGv3ymKIHoLHQ7PjByAnrDKu0CiOZe
         eIoMDnsmyajODcGv6qmesRFHPMKAP+wAebTWkylI7CZVcy3cedYbb+nTb6+J1jfgHLby
         mDpUfBWRgPgkVwBPBTW3nCwLs2SBVlpgz94EA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N0qix8KStCrr38pwzys0Ft4SlHFjFr2KiDnwm8gEhec=;
        b=onmODHJbjHH8xaeYcrN2tG4gkmqcWSo5mADMJEUDGmgd7yJOoNvDDS4Tpdwv61T037
         H8oVipVJcSDo79AYKbnonJkesLZSVpU6snNTkCalANsevgpq1NXkfhELIaGViQUiM6OG
         HPj1ozMN2bVOG53QVaQWh+leq2WGkBquW6xlBxZGZ20vZy/6EnjshwbkHBHMkSvjirJJ
         txh08PgK15uJkhplPP7bmPfhkVNKn5xh0ZTUgSDSYy6ZaYojd6rWa6RUVHoU3We16WSu
         S1yahO7G5BgkkduSlLp+nfvsJs2eESNaBbXKJY+NHrOTZfcMf+AyyKWXmX+4DiqS+AML
         nHVg==
X-Gm-Message-State: APjAAAUfwaaDf4XFrBo/Xy/eJgr2tKU7DjBsTpAgRGbnssHM+sYLiwxd
        SHnIcQ9YxW7qVsqRDrSxaQk3RbqxCFFHNDpQjAQ3ow==
X-Google-Smtp-Source: AHgI3IYSms3Wn+JaUx/Lx/ywH3JHQLGlh4Ejw1H7LDS0ljBcZ9i31C58ixU0YHmGolTyf7c9UfpfiUa8bChZnsmtxJA=
X-Received: by 2002:a24:3655:: with SMTP id l82mr3820535itl.107.1551459445988;
 Fri, 01 Mar 2019 08:57:25 -0800 (PST)
MIME-Version: 1.0
References: <20190226060240.8783-1-jagan@amarulasolutions.com>
 <20190226060240.8783-2-jagan@amarulasolutions.com> <20190227153346.dwd3stsbsvf7rwly@flea>
 <CAMty3ZDSZvaxMjcQJLNaTDJQ5OjJ9NbjpOJKWMUE5PhRCzYvqw@mail.gmail.com> <20190301145724.vhvyoqkkxdflg2g7@flea>
In-Reply-To: <20190301145724.vhvyoqkkxdflg2g7@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Fri, 1 Mar 2019 22:27:14 +0530
Message-ID: <CAMty3ZCUSsN71Q5h_nj6de0Smhqht1S5zq0pLKUqpwq=85XqXw@mail.gmail.com>
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

On Fri, Mar 1, 2019 at 8:27 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Wed, Feb 27, 2019 at 09:49:23PM +0530, Jagan Teki wrote:
> > On Wed, Feb 27, 2019 at 9:03 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > Hi,
> > >
> > > On Tue, Feb 26, 2019 at 11:32:40AM +0530, Jagan Teki wrote:
> > > > Oceanic A64-5inMFD is a 5 inch Multi function display baseboard
> > > > designed to mount SoPine SOM.
> > > >
> > > > Key features:
> > > > - Allwinner A64 Cortex-A53
> > > > - Mali-400MP2 GPU
> > > > - AXP803 PMIC
> > > > - 2GB DDR3 RAM
> > > > - SD Slot
> > > > - SPI-NOR flash
> > > > - EMAC, RTL8211E
> > > > - MCP2515 CAN
> > > > - MIPI-DSI
> > > > - Goodix 911 CTP
> > > > - USB Host
> > > > - 12V DC power supply
> > > >
> > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > ---
> > > >  arch/arm64/boot/dts/allwinner/Makefile        |  1 +
> > > >  .../allwinner/sun50i-a64-oceanic-5inmfd.dts   | 46 +++++++++++++++++++
> > > >  2 files changed, 47 insertions(+)
> > > >  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5inmfd.dts
> > > >
> > > > diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
> > > > index a5fb1eaa8acf..ec39fe856117 100644
> > > > --- a/arch/arm64/boot/dts/allwinner/Makefile
> > > > +++ b/arch/arm64/boot/dts/allwinner/Makefile
> > > > @@ -2,6 +2,7 @@
> > > >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-amarula-relic.dtb
> > > >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-bananapi-m64.dtb sun50i-a64-bananapi-m64-icn6211.dtb
> > > >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-nanopi-a64.dtb
> > > > +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-oceanic-5inmfd.dtb
> > > >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-olinuxino.dtb
> > > >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-orangepi-win.dtb
> > > >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pine64-lts.dtb
> > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5inmfd.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5inmfd.dts
> > > > new file mode 100644
> > > > index 000000000000..d73d1f55acb9
> > > > --- /dev/null
> > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5inmfd.dts
> > > > @@ -0,0 +1,46 @@
> > > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > > +/*
> > > > + * Copyright (C) 2019 Oceanic Systems (UK) Ltd.
> > > > + * Copyright (C) 2019 Amarula Solutions B.V.
> > > > + * Author: Jagan Teki <jagan@amarulasolutions.com>
> > > > + */
> > > > +
> > > > +/dts-v1/;
> > > > +
> > > > +#include "sun50i-a64-sopine.dtsi"
> > > > +
> > > > +/ {
> > > > +     model = "Oceanic A64-5inMFD";
> > > > +     compatible = "oceanic,a64-5inmfd", "allwinner,sun50i-a64";
> > >
> > > The name of the DT is Oceanic 5inMFD, while you call the board
> > > A64-5inMFD here, which name is the actual name?
> >
> > Yes, this is something that we discussed during "Amarula A64-Relic"
> > naming convention.
> >
> > Since these boards are not famous like teres-i we agreed to add vendor
> > name after sun50i-a64- followed by real board name.
> >
> > Here A64 already covered during sun50i-a64- so the dts name simply the
> > <vendor_name>-<real_board_name>
>
> For the DT name, yeah, we want that pattern.
>
> For the compatible and model, we want to use the model name.

Entire model name after <vendor_name>, ?

model = "Oceanic A64-5inMFD";
compatible = "oceanic,a64-5inmfd", "allwinner,sun50i-a64";

is this not sufficient?

Let me understand with respective few existing stuff.

model = "Amarula A64-Relic";
compatible = "amarula,a64-relic", "allwinner,sun50i-a64";

model = "Olimex A64 Teres-I"
compatible = "olimex,a64-teres-i", "allwinner,sun50i-a64";

model = "FriendlyARM NanoPi A64";
compatible = "friendlyarm,nanopi-a64", "allwinner,sun50i-a64";

model = "Olimex A64-Olinuxino";
compatible = "olimex,a64-olinuxino", "allwinner,sun50i-a64"

Would you comment, what is the different with respect to my change?
