Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CD1C2D0CF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5551215A4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="svry36Y9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbfLPJ4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 04:56:39 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58806 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbfLPJ43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 04:56:29 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBG9uNvB106117;
        Mon, 16 Dec 2019 03:56:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576490183;
        bh=Zekc0AXiObZrPPvegTp4K5GUPS8IXJOxaEdMQ6wwWA0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=svry36Y9SEy5nqCBDS949P2MxIkwOQjKA3MD3JzF9M4taTFldpbTbhILGa09CT9sD
         u2TbCA8zg2rBfLuAys6/0p/HVhwqh/Pp9OCvfEnovIVd+gOSj7Gapwprait5EZY7aQ
         Z4MhrxKxE550fy7nOBCzMy53CA67gUtLgBNPT3JE=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBG9uN4V094791
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Dec 2019 03:56:23 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 16
 Dec 2019 03:56:22 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 16 Dec 2019 03:56:22 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBG9tsJS084408;
        Mon, 16 Dec 2019 03:56:20 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Anil Varughese <aniljoy@cadence.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>
CC:     <devicetree@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 09/14] phy: cadence: Sierra: Check for PLL lock during PHY power on
Date:   Mon, 16 Dec 2019 15:27:07 +0530
Message-ID: <20191216095712.13266-10-kishon@ti.com>
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

Check for PLL lock during PHY power on.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 33 +++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 497c83827670..62bff4b043f0 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -55,6 +55,7 @@
 #define SIERRA_PLLCTRL_SUBRATE_PREG			0x03A
 #define SIERRA_PLLCTRL_GEN_D_PREG			0x03E
 #define SIERRA_PLLCTRL_CPGAIN_MODE_PREG			0x03F
+#define SIERRA_PLLCTRL_STATUS_PREG			0x044
 #define SIERRA_CLKPATH_BIASTRIM_PREG			0x04B
 #define SIERRA_DFE_BIASTRIM_PREG			0x04C
 #define SIERRA_DRVCTRL_ATTEN_PREG			0x06A
@@ -141,11 +142,14 @@
 
 #define SIERRA_MACRO_ID					0x00007364
 #define SIERRA_MAX_LANES				4
+#define PLL_LOCK_TIME					100000
 
 static const struct reg_field macro_id_type =
 				REG_FIELD(SIERRA_MACRO_ID_REG, 0, 15);
 static const struct reg_field phy_pll_cfg_1 =
 				REG_FIELD(SIERRA_PHY_PLL_CFG, 1, 1);
+static const struct reg_field pllctrl_lock =
+				REG_FIELD(SIERRA_PLLCTRL_STATUS_PREG, 0, 0);
 
 struct cdns_sierra_inst {
 	struct phy *phy;
@@ -192,6 +196,7 @@ struct cdns_sierra_phy {
 	struct regmap *regmap_common_cdb;
 	struct regmap_field *macro_id_type;
 	struct regmap_field *phy_pll_cfg_1;
+	struct regmap_field *pllctrl_lock[SIERRA_MAX_LANES];
 	struct clk *clk;
 	int nsubnodes;
 	bool autoconf;
@@ -291,10 +296,25 @@ static int cdns_sierra_phy_init(struct phy *gphy)
 
 static int cdns_sierra_phy_on(struct phy *gphy)
 {
+	struct cdns_sierra_phy *sp = dev_get_drvdata(gphy->dev.parent);
 	struct cdns_sierra_inst *ins = phy_get_drvdata(gphy);
+	struct device *dev = sp->dev;
+	u32 val;
+	int ret;
 
 	/* Take the PHY lane group out of reset */
-	return reset_control_deassert(ins->lnk_rst);
+	ret = reset_control_deassert(ins->lnk_rst);
+	if (ret) {
+		dev_err(dev, "Failed to take the PHY lane out of reset\n");
+		return ret;
+	}
+
+	ret = regmap_field_read_poll_timeout(sp->pllctrl_lock[ins->mlane],
+					     val, val, 1000, PLL_LOCK_TIME);
+	if (ret < 0)
+		dev_err(dev, "PLL lock of lane failed\n");
+
+	return ret;
 }
 
 static int cdns_sierra_phy_off(struct phy *gphy)
@@ -350,6 +370,7 @@ static int cdns_regfield_init(struct cdns_sierra_phy *sp)
 	struct device *dev = sp->dev;
 	struct regmap_field *field;
 	struct regmap *regmap;
+	int i;
 
 	regmap = sp->regmap_common_cdb;
 	field = devm_regmap_field_alloc(dev, regmap, macro_id_type);
@@ -367,6 +388,16 @@ static int cdns_regfield_init(struct cdns_sierra_phy *sp)
 	}
 	sp->phy_pll_cfg_1 = field;
 
+	for (i = 0; i < SIERRA_MAX_LANES; i++) {
+		regmap = sp->regmap_lane_cdb[i];
+		field = devm_regmap_field_alloc(dev, regmap, pllctrl_lock);
+		if (IS_ERR(field)) {
+			dev_err(dev, "P%d_ENABLE reg field init failed\n", i);
+			return PTR_ERR(field);
+		}
+		sp->pllctrl_lock[i] =  field;
+	}
+
 	return 0;
 }
 
-- 
2.17.1

