Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C98C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 12:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039A320857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 12:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfKRMBW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 07:01:22 -0500
Received: from gloria.sntech.de ([185.11.138.130]:44402 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbfKRMBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 07:01:21 -0500
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iWfiX-0006Jj-Hc; Mon, 18 Nov 2019 13:01:17 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Markus Reichl <m.reichl@fivetechno.de>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: rockchip: Split rk3399-roc-pc for with and without mezzanine board.
Date:   Mon, 18 Nov 2019 13:01:16 +0100
Message-ID: <17111474.kvkBZtc6MS@diego>
In-Reply-To: <62bfaad5-cbd6-efbd-426b-3da681fcd160@fivetechno.de>
References: <075b3fa6-dab7-5fec-df68-b53f32bf061b@fivetechno.de> <CAMty3ZDwjv4ShpbAyQPWk9ewboFOK3nZO0s_QNty_m0hJKR76w@mail.gmail.com> <62bfaad5-cbd6-efbd-426b-3da681fcd160@fivetechno.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 18. November 2019, 12:57:16 CET schrieb Markus Reichl:
> Hi Jagan,
> 
> Am 18.11.19 um 12:44 schrieb Jagan Teki:
> > On Mon, Nov 4, 2019 at 5:42 PM Heiko Stübner <heiko@sntech.de> wrote:
> >>
> >> Hi Markus,
> >>
> >> Am Freitag, 1. November 2019, 17:54:23 CET schrieb Markus Reichl:
> >> > For rk3399-roc-pc is a mezzanine board available that carries M.2 and
> >> > POE interfaces. Use it with a separate dts.
> >> >
> >> > Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
> >> > ---
> >> >  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
> >> >  .../boot/dts/rockchip/rk3399-roc-pc-mezz.dts  |  52 ++
> >> >  .../arm64/boot/dts/rockchip/rk3399-roc-pc.dts | 757 +----------------
> >> >  .../boot/dts/rockchip/rk3399-roc-pc.dtsi      | 767 ++++++++++++++++++
> >> >  4 files changed, 821 insertions(+), 756 deletions(-)
> >> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezz.dts
> >> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> >> >
> >> > diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> >> > index a959434ad46e..80ee9f1fc5f5 100644
> >> > --- a/arch/arm64/boot/dts/rockchip/Makefile
> >> > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> >> > @@ -28,6 +28,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-neo4.dtb
> >> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-orangepi.dtb
> >> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
> >> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc.dtb
> >> > +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc-mezz.dtb
> >> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4.dtb
> >> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock960.dtb
> >> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rockpro64.dtb
> >> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezz.dts b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezz.dts
> >> > new file mode 100644
> >> > index 000000000000..ee77677d2cf2
> >> > --- /dev/null
> >> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezz.dts
> >> > @@ -0,0 +1,52 @@
> >> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> >> > +/*
> >> > + * Copyright (c) 2017 T-Chip Intelligent Technology Co., Ltd
> >> > + * Copyright (c) 2019 Markus Reichl <m.reichl@fivetechno.de>
> >> > + */
> >> > +
> >> > +/dts-v1/;
> >> > +#include "rk3399-roc-pc.dtsi"
> >> > +
> >> > +/ {
> >> > +     model = "Firefly ROC-RK3399-PC Mezzanine Board";
> >> > +     compatible = "firefly,roc-rk3399-pc", "rockchip,rk3399";
> >>
> >> different board with same compatible isn't possible, so
> >> you'll need a new compatible for it and add a new line to
> >> the roc-pc entry in
> >>         Documentation/devicetree/bindings/arm/rockchip.yaml
> >>
> >> Either you see it as
> >> - a board + hat, using dt overlay and same compatible
> >> - a completely separate board, which needs a separate
> >>   compatible as well
> >>
> >> And as discussed in the previous thread
> >> http://lists.infradead.org/pipermail/linux-rockchip/2019-November/027592.html
> >> but also in Jagan's response that really is somehow a grey area
> >> for something relatively static as the M.2 extension.
> > 
> > Sorry for late response on this. I still think that the "overlay would
> > be a better suite" than having separate dts, since it is HAT which is
> > optional to insert and have possibility of having another HAT if it
> > really fit into it.
> > 
> > Comments?
> Presently no other extension board does exist, I don't expect one.
> 
> I use it with rootfs on NVME on the mezzanine board.
> It is convenient to have the NVME up before going to user space.

And that is exactly the reason while I think it's sane to have this
as a separate board. For more common hats with random
extended functionality this might be different.

But people attaching the nvme-"hat" will in most all cases do so quite
permanently as well ;-) .

Heiko


