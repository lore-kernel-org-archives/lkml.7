Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB9BCA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6748520640
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kWeL+N0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405424AbfJWM6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:58:34 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59286 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405410AbfJWM6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:58:33 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9NCwUpQ048064;
        Wed, 23 Oct 2019 07:58:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571835510;
        bh=/o6Slw7qh/eWJym+d8XdAleakSiFor57TxNgXcKEnZI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kWeL+N0iZ+Ngu+l+pgmWXekKj07GPpE7d7+rV4fCQwLNi4W6jK2kG92Oa7y46lfB1
         JMbqhkoeuoFTtWSjJkkvuVITCv4allnIaPpTmpWfLTMqgOpgSFtzY6rMS6BlCL/k4t
         QT4j5z2KytS5tpWWxDo0piSbvWl3DeRotLR8yjG4=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9NCwU8R042746
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Oct 2019 07:58:30 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 23
 Oct 2019 07:58:30 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 23 Oct 2019 07:58:30 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9NCw5oD061147;
        Wed, 23 Oct 2019 07:58:28 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>
CC:     Anil Varughese <aniljoy@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 09/14] phy: cadence: Sierra: Check for PLL lock during PHY power on
Date:   Wed, 23 Oct 2019 18:27:30 +0530
Message-ID: <20191023125735.4713-10-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023125735.4713-1-kishon@ti.com>
References: <20191023125735.4713-1-kishon@ti.com>
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
index 2648a01f90b3..82f7617b2dac 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -54,6 +54,7 @@
 #define SIERRA_PLLCTRL_SUBRATE_PREG			0x03A
 #define SIERRA_PLLCTRL_GEN_D_PREG			0x03E
 #define SIERRA_PLLCTRL_CPGAIN_MODE_PREG			0x03F
+#define SIERRA_PLLCTRL_STATUS_PREG			0x044
 #define SIERRA_CLKPATH_BIASTRIM_PREG			0x04B
 #define SIERRA_DFE_BIASTRIM_PREG			0x04C
 #define SIERRA_DRVCTRL_ATTEN_PREG			0x06A
@@ -139,11 +140,14 @@
 
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
@@ -190,6 +194,7 @@ struct cdns_sierra_phy {
 	struct regmap *regmap_common_cdb;
 	struct regmap_field *macro_id_type;
 	struct regmap_field *phy_pll_cfg_1;
+	struct regmap_field *pllctrl_lock[SIERRA_MAX_LANES];
 	struct clk *clk;
 	int nsubnodes;
 	bool autoconf;
@@ -289,10 +294,25 @@ static int cdns_sierra_phy_init(struct phy *gphy)
 
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
@@ -349,6 +369,7 @@ static int cdns_regfield_init(struct cdns_sierra_phy *sp)
 	struct device *dev = sp->dev;
 	struct regmap_field *field;
 	struct regmap *regmap;
+	int i;
 
 	regmap = sp->regmap_common_cdb;
 	field = devm_regmap_field_alloc(dev, regmap, macro_id_type);
@@ -366,6 +387,16 @@ static int cdns_regfield_init(struct cdns_sierra_phy *sp)
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

