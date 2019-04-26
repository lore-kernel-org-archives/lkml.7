Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDD4C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 118992146E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbfDZITw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 04:19:52 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60407 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfDZITw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 04:19:52 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hJw57-0003R7-1D; Fri, 26 Apr 2019 10:19:41 +0200
Message-ID: <1556266779.2584.15.camel@pengutronix.de>
Subject: Re: [PATCH v2 00/15] add ecspi ERR009165 for i.mx6/7 soc family
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Robin Gong <yibin.gong@nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 26 Apr 2019 10:19:39 +0200
In-Reply-To: <1556265512-9130-1-git-send-email-yibin.gong@nxp.com>
References: <1556265512-9130-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

Am Freitag, den 26.04.2019, 08:05 +0000 schrieb Robin Gong:
>   There is ecspi ERR009165 on i.mx6/7 soc family, which cause FIFO
> transfer to be send twice in DMA mode. Please get more information from:
> https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf. The workaround is adding
> new sdma ram script which works in XCH  mode as PIO inside sdma instead
> of SMC mode, meanwhile, 'TX_THRESHOLD' should be 0.

I would like to have a more in-depth explanation about how this new RAM
script differs from the existing ROM script and the changes to the
state transitions.

>   The issue should be exist on all legacy i.mx6/7 soc family before i.mx6ul,
> NXP fix this design issue from i.mx6ul, so newer chips such as i.mx6ull/
> i.mx8mq/i.mx8mm, don't need this workaroud anymore. This patch set
> add new 'fsl,imx6ul-ecspi' for ecspi driver and 'ecspi_fixed' in sdma
> driver to choose if need errata or not.
>   The first two reverted patches should be the same issue, though, it
> seems 'fixed' by changing to other shp script. Hope Sean or Sascha could
> have the chance to test this patch set if could fix their issues.
>   Besides, enable sdma support for i.mx8mm/8mq and fix ecspi1 not work
> on i.mx8mm because the event id is zero.
> 
> PS:
>  Please get sdma firmware from below linux-firmware and copy it to your
> local rootfs /lib/firmware/imx/sdma.
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/imx/sdma

This is not an option as long as the SDMA RAM firmware breaks the
mainline serial DMA support. Please provide a fixed SDMA RAM firmware
that doesn't replace the ROM serial script, as that one is totally
fine.

Regards,
Lucas

> v2:
>   1. add commit log for reverted patches.
>   2. add comment for 'ecspi_fixed' in sdma driver.
>   3. add 'fsl,imx6sll-ecspi' compatible instead of 'fsl,imx6ul-ecspi'
>      rather than remove.
> 
> 
> Robin Gong (15):
>   Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
>   Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
>   Revert "dmaengine: imx-sdma: refine to load context only once"
>   dmaengine: imx-sdma: remove dupilicated sdma_load_context
>   dma: engine: imx-sdma: add mcu_2_ecspi script
>   spi: imx: fix ERR009165
>   spi: imx: remove ERR009165 workaround on i.mx6ul
>   dt-bindings: spi: imx: add i.mx6ul to state errata fixed
>   dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
>   dt-bindings: dma: imx-sdma: add i.mx6ul/6sx compatible name
>   dmaengine: imx-sdma: fix ecspi1 rx dma not work on i.mx8mm
>   ARM64: dts: freescale: imx8mm/8mq: update new compatible name for
>     ecspi and sdma
>   ARM: dts: imx6ul: add dma support on ecspi
>   ARM: dts: imx6sll: correct ecspi/sdma compatible
>   arm64: defconfig: Enable SDMA on i.mx8mq/8mm
> 
>  .../devicetree/bindings/dma/fsl-imx-sdma.txt       |  2 +
>  .../devicetree/bindings/spi/fsl-imx-cspi.txt       |  2 +
>  arch/arm/boot/dts/imx6q.dtsi                       |  2 +-
>  arch/arm/boot/dts/imx6qdl.dtsi                     |  8 +--
>  arch/arm/boot/dts/imx6sll.dtsi                     | 10 ++--
>  arch/arm/boot/dts/imx6ul.dtsi                      |  8 +++
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi          | 14 ++---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi          |  6 +-
>  arch/arm64/configs/defconfig                       |  3 +
>  drivers/dma/imx-sdma.c                             | 67 ++++++++++++++++------
>  drivers/spi/spi-imx.c                              | 46 ++++++++++++---
>  include/linux/platform_data/dma-imx-sdma.h         |  1 +
>  12 files changed, 124 insertions(+), 45 deletions(-)
> 
> -- 
> 2.7.4
> 
