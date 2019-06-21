Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E4CC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17D32084E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfFUPi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 11:38:57 -0400
Received: from inva020.nxp.com ([92.121.34.13]:40082 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbfFUPi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 11:38:56 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5A5C81A0A88;
        Fri, 21 Jun 2019 17:38:54 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4CBD71A0A85;
        Fri, 21 Jun 2019 17:38:54 +0200 (CEST)
Received: from fsr-ub1664-016.ea.freescale.net (fsr-ub1664-016.ea.freescale.net [10.171.71.216])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id D183820629;
        Fri, 21 Jun 2019 17:38:53 +0200 (CEST)
From:   Claudiu Manoil <claudiu.manoil@nxp.com>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        alexandru.marginean@nxp.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: [PATCH net-next 0/6] Microsemi Felix switch support
Date:   Fri, 21 Jun 2019 18:38:46 +0300
Message-Id: <1561131532-14860-1-git-send-email-claudiu.manoil@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device is an ethernet switch core from Microsemi (VSC9959)
integrated as PCIe endpoint into the LS1028a SoC.

Though this switch core has some particularities (i.e. 6 ports,
some register mapping differences), functionally this driver relies
entirely on the Ocelot switch driver providing all the features,
and is basically an instance of the Ocelot core driver.

The first 3 patches are minor refactoring of the common Ocelot code
(core driver).  The rest provide the integration code of the switch
as a PCIe device, the register mapping, corresponding ls1028a DT
nodes (for switch ports link configuration).  There are also few
particularities described by individual patch messages.

Claudiu Manoil (6):
  ocelot: Filter out ocelot SoC specific PCS config from common path
  ocelot: Refactor common ocelot probing code to ocelot_init
  ocelot: Factor out resource ioremap and regmap init common code
  arm64: dts: fsl: ls1028a: Add Felix switch port DT node
  dt-bindings: net: Add DT bindings for Microsemi Felix Switch
  net/mssc/ocelot: Add basic Felix switch driver

 .../devicetree/bindings/net/mscc-felix.txt    |  77 +++
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |  58 ++-
 drivers/net/ethernet/mscc/Kconfig             |   8 +
 drivers/net/ethernet/mscc/Makefile            |   9 +-
 drivers/net/ethernet/mscc/felix_board.c       | 392 +++++++++++++++
 drivers/net/ethernet/mscc/felix_regs.c        | 448 ++++++++++++++++++
 drivers/net/ethernet/mscc/ocelot.c            |  23 +-
 drivers/net/ethernet/mscc/ocelot.h            |  13 +-
 drivers/net/ethernet/mscc/ocelot_board.c      |  16 +-
 drivers/net/ethernet/mscc/ocelot_io.c         |  14 +-
 drivers/net/ethernet/mscc/ocelot_regs.c       |  21 +
 11 files changed, 1041 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/mscc-felix.txt
 create mode 100644 drivers/net/ethernet/mscc/felix_board.c
 create mode 100644 drivers/net/ethernet/mscc/felix_regs.c

-- 
2.17.1

