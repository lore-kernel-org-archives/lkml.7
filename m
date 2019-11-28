Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A411C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF1C21775
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FaLrypxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfK1Krk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 05:47:40 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58016 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfK1Krk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 05:47:40 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xASAlarG096661;
        Thu, 28 Nov 2019 04:47:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574938056;
        bh=eKSU4P9KuQJ/Do7x57Iah14M9xnEYTaNHRuLpboeRuc=;
        h=From:To:CC:Subject:Date;
        b=FaLrypxIqB8k7gWSrE28fq6fjmJToxV1Uayoe3XvvTov8R7neFPcB1W1/PgUpPkS0
         mAZTmfu77ZbysAOMBNz4/LpsoMiwN1nKMb5He+fm65W4EZR4U0ENEsYhOJ2YvasO5u
         UirB8pRsa1rAr02K0kh58CSX5yPEZerUJvHxbgSc=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xASAlaO6126286
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Nov 2019 04:47:36 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 28
 Nov 2019 04:47:36 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 28 Nov 2019 04:47:36 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xASAlX3v098163;
        Thu, 28 Nov 2019 04:47:33 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Anil Varughese <aniljoy@cadence.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 00/14] PHY: Add support for SERDES in TI's J721E SoC
Date:   Thu, 28 Nov 2019 16:16:34 +0530
Message-ID: <20191128104648.21894-1-kishon@ti.com>
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

Changes from v2:
 *) Deprecate "phy_clk" binding
 *) Fix Rob's comment on dt bindings
        -> Include BSD-2-Clause license identifier
        -> drop "oneOf" and "items" for compatible
        -> Fixed "num-lanes" to include only scalar keywords
        -> Change to 32-bit address space for child nodes
*) Rename cmn_refclk/cmn_refclk1 to cmn_refclk_dig_div/
   cmn_refclk1_dig_div

Changes from v1:
 *) Change the dt binding Documentation of WIZ wrapper to YAML format
 *) Fix an issue in Sierra while doimg rmmod

Anil Varughese (1):
  phy: cadence: Sierra: Configure both lane cdb and common cdb registers
    for external SSC

Kishon Vijay Abraham I (13):
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
  phy: cadence: Sierra: Set cmn_refclk_dig_div/cmn_refclk1_dig_div
    frequency to 25MHz
  phy: cadence: Sierra: Use correct dev pointer in
    cdns_sierra_phy_remove()
  dt-bindings: phy: Document WIZ (SERDES wrapper) bindings
  phy: ti: j721e-wiz: Add support for WIZ module present in TI J721E SoC

 .../bindings/phy/phy-cadence-sierra.txt       |  13 +-
 .../bindings/phy/ti,phy-j721e-wiz.yaml        | 158 +++
 drivers/phy/cadence/phy-cadence-sierra.c      | 699 +++++++++++---
 drivers/phy/ti/Kconfig                        |  15 +
 drivers/phy/ti/Makefile                       |   1 +
 drivers/phy/ti/phy-j721e-wiz.c                | 904 ++++++++++++++++++
 6 files changed, 1651 insertions(+), 139 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
 create mode 100644 drivers/phy/ti/phy-j721e-wiz.c

-- 
2.17.1

