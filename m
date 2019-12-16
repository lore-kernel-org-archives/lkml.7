Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEE5C2D0CF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A7820725
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iddfKkc8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfLPJ46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 04:56:58 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55194 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbfLPJ4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 04:56:08 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBG9tv6G037837;
        Mon, 16 Dec 2019 03:55:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576490157;
        bh=h6SVCdCA8094qluRqF1qIAbqUqNnpdtR3qwpgtBc3ck=;
        h=From:To:CC:Subject:Date;
        b=iddfKkc8eLohJwWp70i8+Vj+SfbfoCLwB60WOEnGWymfsq4ZaFBih2dvgRhb1yhCq
         y3KRXCNl5IWIWj7ri49iqsf6zFLDFTnyxIk5BBkbpdNeb3X0YYkjGSzSJU7RHeDhfs
         NRc/AydGH3GLVlF9FpqY1WTRfCCezVmcDp1x93NU=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBG9tvOA048668
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Dec 2019 03:55:57 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 16
 Dec 2019 03:55:57 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 16 Dec 2019 03:55:57 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBG9tsJJ084408;
        Mon, 16 Dec 2019 03:55:54 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Anil Varughese <aniljoy@cadence.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>
CC:     <devicetree@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 00/14] PHY: Add support for SERDES in TI's J721E SoC
Date:   Mon, 16 Dec 2019 15:26:58 +0530
Message-ID: <20191216095712.13266-1-kishon@ti.com>
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

Changes from v3:
 *) Fix Rob's comments on dt bindings
        -> Add properties to be added in WIZ child nodes to binding
        -> Use '-' rather than '_' in node names

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

The series has also been pushed to
https://github.com/kishon/linux-wip.git j7_serdes_v4

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
 .../bindings/phy/ti,phy-j721e-wiz.yaml        | 204 ++++
 drivers/phy/cadence/phy-cadence-sierra.c      | 699 +++++++++++---
 drivers/phy/ti/Kconfig                        |  15 +
 drivers/phy/ti/Makefile                       |   1 +
 drivers/phy/ti/phy-j721e-wiz.c                | 898 ++++++++++++++++++
 6 files changed, 1691 insertions(+), 139 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
 create mode 100644 drivers/phy/ti/phy-j721e-wiz.c

-- 
2.17.1

