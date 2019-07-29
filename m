Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972D0C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7444C2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbfG2KDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 06:03:53 -0400
Received: from inva020.nxp.com ([92.121.34.13]:48222 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbfG2KDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 06:03:50 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 413161A1487;
        Mon, 29 Jul 2019 12:03:49 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 342041A1481;
        Mon, 29 Jul 2019 12:03:49 +0200 (CEST)
Received: from fsr-ub1664-016.ea.freescale.net (fsr-ub1664-016.ea.freescale.net [10.171.71.216])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id B9CAB205F3;
        Mon, 29 Jul 2019 12:03:48 +0200 (CEST)
From:   Claudiu Manoil <claudiu.manoil@nxp.com>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     andrew@lunn.ch, Rob Herring <robh+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, alexandru.marginean@nxp.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/4] enetc: Add mdio bus driver for the PCIe MDIO endpoint
Date:   Mon, 29 Jul 2019 13:03:43 +0300
Message-Id: <1564394627-3810-1-git-send-email-claudiu.manoil@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First patch fixes a sparse issue and cleans up accessors to avoid
casting to __iomem.
Second patch just registers the PCIe endpoint device containing
the MDIO registers as a standalone MDIO bus driver, to allow
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

Claudiu Manoil (4):
  enetc: Clean up local mdio bus allocation
  enetc: Add mdio bus driver for the PCIe MDIO endpoint
  dt-bindings: net: fsl: enetc: Add bindings for the central MDIO PCIe
    endpoint
  arm64: dts: fsl: ls1028a: Enable eth port1 on the ls1028a QDS board

 .../devicetree/bindings/net/fsl-enetc.txt     |  42 +++-
 .../boot/dts/freescale/fsl-ls1028a-qds.dts    |  40 ++++
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |   6 +
 .../net/ethernet/freescale/enetc/enetc_mdio.c | 190 +++++++++++++-----
 .../net/ethernet/freescale/enetc/enetc_pf.c   |   5 +-
 5 files changed, 232 insertions(+), 51 deletions(-)

-- 
2.17.1

