Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFDEC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03AAF2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QalqmDYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfLPJ4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 04:56:22 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58780 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbfLPJ4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 04:56:19 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBG9uBuk106083;
        Mon, 16 Dec 2019 03:56:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576490171;
        bh=KgCdmhuOnIHUcH9TRzqb5Eaq1xWjKMdqrGjEhzQdvbA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=QalqmDYfFg9W7WqHbHUsMzhSqkcDYi6Y0MwJmDj4tw3Tfs8ezM8ph6eqhvOp0qxFx
         YRSSF2sT/J2Q3PAevOekStn3YJUii+8k4NKD4GtPYDUx9jIvxxWfV1bGi3anw3JPSC
         0driCIsf1+dAGQgr+rItzlC9xy0PiZu0DLjWkIdg=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBG9uBqE049265
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Dec 2019 03:56:11 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 16
 Dec 2019 03:56:11 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 16 Dec 2019 03:56:11 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBG9tsJO084408;
        Mon, 16 Dec 2019 03:56:08 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Anil Varughese <aniljoy@cadence.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>
CC:     <devicetree@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 05/14] phy: cadence: Sierra: Make cdns_sierra_phy_init() as phy_ops
Date:   Mon, 16 Dec 2019 15:27:03 +0530
Message-ID: <20191216095712.13266-6-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191216095712.13266-1-kishon@ti.com>
References: <20191216095712.13266-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of invoking cdns_sierra_phy_init() from probe, add it in
phy_ops so that it's initialized when the PHY consumer invokes
phy_init()

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index d3b0dac2db77..bc2ae260359c 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -176,7 +176,7 @@ static struct regmap_config cdns_sierra_phy_config_ctrl_config = {
 	.reg_read = cdns_regmap_read,
 };
 
-static void cdns_sierra_phy_init(struct phy *gphy)
+static int cdns_sierra_phy_init(struct phy *gphy)
 {
 	struct cdns_sierra_inst *ins = phy_get_drvdata(gphy);
 	struct cdns_sierra_phy *phy = dev_get_drvdata(gphy->dev.parent);
@@ -185,6 +185,10 @@ static void cdns_sierra_phy_init(struct phy *gphy)
 	struct cdns_reg_pairs *vals;
 	u32 num_regs;
 
+	/* Initialise the PHY registers, unless auto configured */
+	if (phy->autoconf)
+		return 0;
+
 	if (ins->phy_type == PHY_TYPE_PCIE) {
 		num_regs = phy->init_data->pcie_regs;
 		vals = phy->init_data->pcie_vals;
@@ -192,7 +196,7 @@ static void cdns_sierra_phy_init(struct phy *gphy)
 		num_regs = phy->init_data->usb_regs;
 		vals = phy->init_data->usb_vals;
 	} else {
-		return;
+		return -EINVAL;
 	}
 	for (i = 0; i < ins->num_lanes; i++) {
 		for (j = 0; j < num_regs ; j++) {
@@ -200,6 +204,8 @@ static void cdns_sierra_phy_init(struct phy *gphy)
 			regmap_write(regmap, vals[j].off, vals[j].val);
 		}
 	}
+
+	return 0;
 }
 
 static int cdns_sierra_phy_on(struct phy *gphy)
@@ -218,6 +224,7 @@ static int cdns_sierra_phy_off(struct phy *gphy)
 }
 
 static const struct phy_ops ops = {
+	.init		= cdns_sierra_phy_init,
 	.power_on	= cdns_sierra_phy_on,
 	.power_off	= cdns_sierra_phy_off,
 	.owner		= THIS_MODULE,
@@ -438,10 +445,6 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 		sp->phys[node].phy = gphy;
 		phy_set_drvdata(gphy, &sp->phys[node]);
 
-		/* Initialise the PHY registers, unless auto configured */
-		if (!sp->autoconf)
-			cdns_sierra_phy_init(gphy);
-
 		node++;
 	}
 	sp->nsubnodes = node;
-- 
2.17.1

