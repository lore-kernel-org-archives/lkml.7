Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C4BCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B161A20656
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbfJULn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 07:43:26 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33913 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbfJULn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 07:43:26 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iMW5r-0000lD-GS; Mon, 21 Oct 2019 13:43:23 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iMW5n-00081f-On; Mon, 21 Oct 2019 13:43:19 +0200
Date:   Mon, 21 Oct 2019 13:43:19 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 00/10] Add support for more Kontron i.MX6UL/ULL SoMs and
 boards
Message-ID: <20191021114319.krrhdtvycu7zxxie@pengutronix.de>
References: <20191016150622.21753-1-frieder.schrempf@kontron.de>
 <20191017081422.65m5dtqznsanfftp@pengutronix.de>
 <6e6f9cf4-85b3-35e3-1238-11e39855bc08@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e6f9cf4-85b3-35e3-1238-11e39855bc08@kontron.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 13:41:49 up 156 days, 17:59, 99 users,  load average: 0.02, 0.01,
 0.00
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frieder,

On 19-10-17 08:24, Schrempf Frieder wrote:
> Hi Marco,
> 
> On 17.10.19 10:14, Marco Felsch wrote:
> > Hi Frieder,
> > 
> > On 19-10-16 15:06, Schrempf Frieder wrote:
> >> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> >>
> >> In order to support more of the i.MX6UL/ULL-based SoMs and boards by
> >> Kontron Electronics GmbH, we restructure the devicetrees to share common
> >> parts and add new devicetrees for the missing boards.
> >>
> >> Currently there are the following SoM flavors:
> >>    * N6310: SoM with i.MX6UL-2, 256MB RAM, 256MB SPI NAND
> >>    * N6311: SoM with i.MX6UL-2, 512MB RAM, 512MB SPI NAND (new)
> >>    * N6411: SoM with i.MX6ULL, 512MB RAM, 512MB SPI NAND (new)
> >>
> >> Each of the SoMs also features 1MB SPI NOR and an Ethernet PHY. The carrier
> >> board for the evalkit is the same for all SoMs.
> >>
> >> Frieder Schrempf (10):
> >>    ARM: dts: imx6ul-kontron-n6310: Move common SoM nodes to a separate
> >>      file
> >>    ARM: dts: Add support for two more Kontron SoMs N6311 and N6411
> >>    ARM: dts: imx6ul-kontron-n6310-s: Move common nodes to a separate file
> >>    ARM: dts: Add support for two more Kontron evalkit boards 'N6311 S'
> >>      and 'N6411 S'
> >>    ARM: dts: imx6ul-kontron-n6x1x: Add 'chosen' node with 'stdout-path'
> >>    ARM: dts: imx6ul-kontron-n6x1x-s: Specify bus-width for SD card and
> >>      eMMC
> >>    ARM: dts: imx6ul-kontron-n6x1x-s: Add vbus-supply and overcurrent
> >>      polarity to usb nodes
> >>    ARM: dts: imx6ul-kontron-n6x1x-s: Remove an obsolete comment and fix
> >>      indentation
> >>    dt-bindings: arm: fsl: Add more Kontron i.MX6UL/ULL compatibles
> >>    MAINTAINERS: Add an entry for Kontron Electronics ARM board support
> > 
> > Did you send all patches to same To: and Cc:?
> 
> No, I have a script that runs get_maintainer.pl for each patch. So the 
> recipients might differ. I only had Krzysztof and Rob as hard-coded 
> recipients for the whole series.
> 
> Do you think I should change this so each recipient receives the whole 
> series?

I do it that way because sometimes it is better for the reviewer to see
the whole context.

Regards,
  Marco 

> Thanks,
> Frieder
> 
> > 
> > Regards,
> >    Marco
> > 
> >>
> >>   .../devicetree/bindings/arm/fsl.yaml          |  14 +
> >>   MAINTAINERS                                   |   6 +
> >>   arch/arm/boot/dts/imx6ul-kontron-n6310-s.dts  | 405 +----------------
> >>   .../boot/dts/imx6ul-kontron-n6310-som.dtsi    |  95 +---
> >>   arch/arm/boot/dts/imx6ul-kontron-n6311-s.dts  |  16 +
> >>   .../boot/dts/imx6ul-kontron-n6311-som.dtsi    |  40 ++
> >>   arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi | 422 ++++++++++++++++++
> >>   .../dts/imx6ul-kontron-n6x1x-som-common.dtsi  | 129 ++++++
> >>   arch/arm/boot/dts/imx6ull-kontron-n6411-s.dts |  16 +
> >>   .../boot/dts/imx6ull-kontron-n6411-som.dtsi   |  40 ++
> >>   10 files changed, 685 insertions(+), 498 deletions(-)
> >>   create mode 100644 arch/arm/boot/dts/imx6ul-kontron-n6311-s.dts
> >>   create mode 100644 arch/arm/boot/dts/imx6ul-kontron-n6311-som.dtsi
> >>   create mode 100644 arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi
> >>   create mode 100644 arch/arm/boot/dts/imx6ul-kontron-n6x1x-som-common.dtsi
> >>   create mode 100644 arch/arm/boot/dts/imx6ull-kontron-n6411-s.dts
> >>   create mode 100644 arch/arm/boot/dts/imx6ull-kontron-n6411-som.dtsi
> >>
> >> -- 
> >> 2.17.1
> >>
> >>
> > 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
