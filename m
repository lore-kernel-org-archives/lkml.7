Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89106FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B222082C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yLN4r97f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404974AbfJPLbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 07:31:52 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34116 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbfJPLbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:31:51 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9GBVnhp081730;
        Wed, 16 Oct 2019 06:31:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571225509;
        bh=WUkid3uSZ5G9AdqsLWEwpgjUhaC3e/yVM4i69sFJaYw=;
        h=From:To:CC:Subject:Date;
        b=yLN4r97fgZWw1+eTcy7QebJzucU6++uY+O4ikm+OtLMmw5SAaSp1q22ciUywHeoaJ
         Dyxkh3hwY+4pKKn1VyW7TsGtVOGofyVBBONVrQOzxtO90KtfZRveqtfLqeEQfORXUs
         wbeDzCW8M9Um6S3NPSTW3IoyT6HHuiS/EJBx9qaA=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9GBVnx0079808
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Oct 2019 06:31:49 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 16
 Oct 2019 06:31:49 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 16 Oct 2019 06:31:42 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9GBVkm4097485;
        Wed, 16 Oct 2019 06:31:47 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>
CC:     Anil Varughese <aniljoy@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 00/13] PHY: Add support for SERDES in TI's J721E SoC
Date:   Wed, 16 Oct 2019 17:01:04 +0530
Message-ID: <20191016113117.12370-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI's J721E SoC uses Cadence Sierra SERDES for USB, PCIe and SGMII.
TI has a wrapper named WIZ to control input signals to Sierra and
Torrent SERDES.

This patch series:
 1) Add support to WIZ module present in TI's J721E SoC
 2) Adapt Cadence Sierra PHY driver to be used for J721E SoC

Anil Varughese (1):
  phy: cadence: Sierra: Configure both lane cdb and common cdb registers
    for external SSC

Kishon Vijay Abraham I (12):
  dt-bindings: phy: Sierra: Add bindings for Sierra in TI's J721E
  phy: cadence: Sierra: Make "phy_clk" and "sierra_apb" optional
    resources
  phy: cadence: Sierra: Use "regmap" for read and write to Sierra
    registers
  phy: cadence: Sierra: Add support for SERDES_16G used in J721E SoC
  phy: cadence: Sierra: Make cdns_sierra_phy_init() as phy_ops
  phy: cadence: Sierra: Modify register macro names to be in sync with
    Sierra user guide
  phy: cadence: Sierra: Get reset control "array" for each link
  phy: cadence: Sierra: Check for PLL lock during PHY power on
  phy: cadence: Sierra: Change MAX_LANES of Sierra to 16
  phy: cadence: Sierra: Set cmn_refclk/cmn_refclk1 frequency to 25MHz
  dt-bindings: phy: Document WIZ (SERDES wrapper) bindings
  phy: ti: j721e-wiz: Add support for WIZ module present in TI J721E SoC

 .../bindings/phy/phy-cadence-sierra.txt       |  13 +-
 .../bindings/phy/ti,phy-j721e-wiz.txt         |  95 ++
 drivers/phy/cadence/phy-cadence-sierra.c      | 695 +++++++++++---
 drivers/phy/ti/Kconfig                        |  15 +
 drivers/phy/ti/Makefile                       |   1 +
 drivers/phy/ti/phy-j721e-wiz.c                | 904 ++++++++++++++++++
 6 files changed, 1585 insertions(+), 138 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.txt
 create mode 100644 drivers/phy/ti/phy-j721e-wiz.c

-- 
2.17.1

