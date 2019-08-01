Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB172C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10502087E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731112AbfHALw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 07:52:57 -0400
Received: from inva020.nxp.com ([92.121.34.13]:53324 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730514AbfHALw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 07:52:57 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 867A51A0105;
        Thu,  1 Aug 2019 13:52:54 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7A0F51A0074;
        Thu,  1 Aug 2019 13:52:54 +0200 (CEST)
Received: from fsr-ub1664-016.ea.freescale.net (fsr-ub1664-016.ea.freescale.net [10.171.71.216])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 14B04205E3;
        Thu,  1 Aug 2019 13:52:54 +0200 (CEST)
From:   Claudiu Manoil <claudiu.manoil@nxp.com>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     andrew@lunn.ch, Rob Herring <robh+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, alexandru.marginean@nxp.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 0/5] enetc: Add mdio bus driver for the PCIe MDIO endpoint
Date:   Thu,  1 Aug 2019 14:52:48 +0300
Message-Id: <1564660373-4607-1-git-send-email-claudiu.manoil@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First patch fixes a sparse issue and cleans up accessors to avoid
casting to __iomem.  The second one cleans up the Makefile, to make
it easier to add new entries.

Third patch just registers the PCIe endpoint device containing
the MDIO registers as a standalone MDIO bus driver, to provide
an alternative way to control the MDIO bus.  The same code used
by the ENETC ports (eth controllers) to manage MDIO via local
registers applies and is reused.

Bindings are provided for the new MDIO node, similarly to ENETC
port nodes bindings.

Last patch enables the ENETC port 1 and its RGMII PHY on the
LS1028A QDS board, where the MDIO muxing configuration relies
on the MDIO support provided in the first patch.

Changes since v0:
v1 - fixed mdio bus allocation
v2 - cleaned up accessors to avoid casting
v3 - fixed spelling (mostly commit message)
v4 - fixed err path check blunder
v5 - fixed loadble module build, provided separate kbuild module
     for the driver


Claudiu Manoil (5):
  enetc: Clean up local mdio bus allocation
  enetc: Clean up makefile
  enetc: Add mdio bus driver for the PCIe MDIO endpoint
  dt-bindings: net: fsl: enetc: Add bindings for the central MDIO PCIe
    endpoint
  arm64: dts: fsl: ls1028a: Enable eth port1 on the ls1028a QDS board

 .../devicetree/bindings/net/fsl-enetc.txt     |  42 +++++++-
 .../boot/dts/freescale/fsl-ls1028a-qds.dts    |  40 +++++++
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |   6 ++
 drivers/net/ethernet/freescale/enetc/Kconfig  |   9 ++
 drivers/net/ethernet/freescale/enetc/Makefile |  19 ++--
 .../net/ethernet/freescale/enetc/enetc_mdio.c |  97 ++++++++---------
 .../net/ethernet/freescale/enetc/enetc_mdio.h |  12 +++
 .../ethernet/freescale/enetc/enetc_pci_mdio.c | 101 ++++++++++++++++++
 .../net/ethernet/freescale/enetc/enetc_pf.c   |   5 +-
 9 files changed, 264 insertions(+), 67 deletions(-)
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_mdio.h
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c

-- 
2.17.1

