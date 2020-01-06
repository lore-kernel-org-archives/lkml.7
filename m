Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B85C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 11:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3ADB2071A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 11:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgAFLii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 06:38:38 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33425 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgAFLih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 06:38:37 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1ioQiL-0004uf-AZ; Mon, 06 Jan 2020 12:38:29 +0100
Message-ID: <fd6e6d92fdc15552bb60481fec6f5622a1575e43.camel@pengutronix.de>
Subject: Re: [PATCH V2 0/7] soc: imx: Enable additional functionality of
 i.MX8M Mini
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Jacky Bai <ping.bai@nxp.com>, Adam Ford <aford173@gmail.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Date:   Mon, 06 Jan 2020 12:38:25 +0100
In-Reply-To: <DB7PR04MB5178EA739587B2DB084570B9872F0@DB7PR04MB5178.eurprd04.prod.outlook.com>
References: <20191213160542.15757-1-aford173@gmail.com>
         <CAHCN7xKuVCGqgRpixa9UPkWq92Gg=dm4XxAczBKAZCoMzcBVJg@mail.gmail.com>
         <DB7PR04MB5178EA739587B2DB084570B9872F0@DB7PR04MB5178.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacky,

On So, 2019-12-22 at 08:33 +0000, Jacky Bai wrote:
> > -----Original Message-----
> > From: Adam Ford <aford173@gmail.com>
> > Sent: Saturday, December 21, 2019 11:07 PM
> > To: arm-soc <linux-arm-kernel@lists.infradead.org>
> > Cc: Peng Fan <peng.fan@nxp.com>; Jacky Bai <ping.bai@nxp.com>; Rob
> > Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> > Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> > <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>;
> > dl-linux-imx <linux-imx@nxp.com>; devicetree <devicetree@vger.kernel.org>;
> > Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Leonard Crestez
> > <leonard.crestez@nxp.com>
> > Subject: Re: [PATCH V2 0/7] soc: imx: Enable additional functionality of
> > i.MX8M Mini
> > 
> > On Fri, Dec 13, 2019 at 10:05 AM Adam Ford <aford173@gmail.com> wrote:
> > > The GPCv2 controller on the i.MX8M Mini is compatible with the driver
> > > used for the i.MX8MQ except for the register locations and names.
> > > The GPCv2 controller is used to enable additional periperals currently
> > > unavailable on the i.MX8M Mini.  In order to make them function, the
> > > GPCv2 needs to be adapted so the drivers can associate their power
> > > domain to the GPCv2 to enable them.
> > > 
> > > This series makes one include file slightly more generic, adds the
> > > iMX8M Mini entries, updates the bindings, adds them to the device
> > > tree, then associates the new power domain to both the OTG and PCIe
> > > controllers.
> > > 
> > > Some peripherals may need additional power domain drivers in the
> > > future due to limitations of the GPC driver, but the drivers for VPU
> > > and others are not available yet.
> > 
> > Before I do a V3 to address Rob's comments, I am thinking I'll drop the items
> > on the GPC that Jacky suggested would not work, and we don't have drivers
> > for those other peripherals (GPU, VPU, etc.) anyway.  My main goal here was
> > to try and get the USB OTG ports working, so I'd like to enabled enough of the
> > items on the GPC that are similar to the i.MX8MQ and leave the more
> > challenging items until we have either a better driver available and/or actual
> > peripheral support coming.  I haven't seen LCDIF or DSI drivers pushed
> > upstream yet, so I doubt we'll see GPU or VPU yet until those are done.
> > 
> > Does anyone from the NXP team have any other comments/concerns?
> > 
> 
> If you look into NXP's release code, you will find that it is not easy to handle the
> power domain more generically in GPCv2 driver for imx8mm. That's the reason why we use
> SIP service to handle all the power domain in TF-A. we tried to upstream the SIP version
> power domain that can be reused for all i.MX8M, but rejected by ARM guys. they think
> we need to use SCMI to implement it. as there is no SCMI over SMC available, upstream is
> on the way, so the power domain for i.MX8MM/MN is pending.

Adding power domain support for i.MX8MM/MN to the GPCv2 driver does not
prevent a SCMI solution to be used when available. I don't see why we
should block this.

> Actually, I am confused why we can't use SIP service, even if the SCMI over SMC is ready in
> the future, It seems the SMCC function ID still need to choose from SIP service function id bank.
> 
> Another concern for adding power domain support in GPCv2 is that, each time a new
> SOC is added, we need to add hundred lines of code in GPCv2 driver. it is not a best way
> to keep driver reuse.

This is how all hardware specific stuff is handled in the driver. I see
your use-case of having a single TF-A based driver for applications
where you have more than on OS running on the system. For the very
common case of only a single rich OS running on the system the code
reuse doesn't really matter and in fact it's easier to fix any bugs by
just updating the Linux kernel.

>  The GPCv2 driver is originally used for i.MX7D, then reused by i.MX8MQ,
> as i.MX8MQ has very simple power domain design as i.MX7D. But for i.MX8MM, it is not the
> case.

I would be very interested in the details here. What is the big
difference in the i.MX8MM that would make it hard to support it in the
GPCv2 driver in the same way as we did with i.MX8MQ?
> 
> There is another concern, we don't want to export GPC module to rich OS side, it is not a must.

You are still free to remove the GPC DT node, as soon as the SCMI
replacement is ready.

But if you decide to handle the GPC stuff in TF-A, are you also going
to handle the external supplies to the GPC domains in the TF-A? What
about synchronous reset clocks that need to be running while the domain
is powered up? Are you going to add a SCMI based replacement for the
clock controller, which is currently also handled in the rich OS?

Regards,
Lucas

> 
> BR
> Jacky Bai
> 
> > adam
> > > Adam Ford (7):
> > >   soc: imx: gpcv2: Rename imx8mq-power.h to imx8m-power.h
> > >   soc: imx: gpcv2: Update imx8m-power.h to include iMX8M Mini
> > >   soc: imx: gpcv2: add support for i.MX8M Mini SoC
> > >   dt-bindings: imx-gpcv2: Update bindings to support i.MX8M Mini
> > >   arm64: dts: imx8mm: add GPC power domains
> > >   ARM64: dts: imx8mm: Fix clocks and power domain for USB OTG
> > >   arm64: dts: imx8mm: Add PCIe support
> > > 
> > >  .../bindings/power/fsl,imx-gpcv2.txt          |   6 +-
> > >  arch/arm64/boot/dts/freescale/imx8mm.dtsi     | 127 ++++++++-
> > >  arch/arm64/boot/dts/freescale/imx8mq.dtsi     |   2 +-
> > >  drivers/soc/imx/gpcv2.c                       | 246
> > +++++++++++++++++-
> > >  .../power/{imx8mq-power.h => imx8m-power.h}   |  14 +
> > >  5 files changed, 387 insertions(+), 8 deletions(-)  rename
> > > include/dt-bindings/power/{imx8mq-power.h => imx8m-power.h} (57%)
> > > 
> > > --
> > > 2.20.1
> > > 

