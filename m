Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF64AC04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DBA2077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ml3Tkf+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfLIQWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:22:31 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42436 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfLIQWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 11:22:30 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB9GMS3S028131;
        Mon, 9 Dec 2019 10:22:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575908548;
        bh=6Vt9YLldmDuHyHf+Z5P+YTHosd/Hr2dv4ZyxDYP1aBI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Ml3Tkf+tJYBperMGP/GzZGMiBbo30uoEAg+E7a5EVLY5Sywv66GM6NGiKc3+nCVd7
         G0rr3VeDrTwf9whc1+u/Fy1hSWoABpc4vETAAXOPmJNu4vR5+HBJK6+03tQz182HNj
         nxKVHJs9BJ/ir5W57UUPmDgBXxpkXaDtJJPGSuKg=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB9GMSU1128399;
        Mon, 9 Dec 2019 10:22:28 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 9 Dec
 2019 10:22:27 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 9 Dec 2019 10:22:27 -0600
Received: from jadmar.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB9GMP0t050201;
        Mon, 9 Dec 2019 10:22:25 -0600
From:   Jyri Sarha <jsarha@ti.com>
To:     <kishon@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <tomi.valkeinen@ti.com>, <praneeth@ti.com>, <yamonkar@cadence.com>,
        <sjakhade@cadence.com>, <rogerq@ti.com>, <jsarha@ti.com>
Subject: [PATCH 3/3] phy: ti: j721e-wiz: Implement DisplayPort mode to the wiz driver
Date:   Mon, 9 Dec 2019 18:22:25 +0200
Message-ID: <8a8d070e1d8550dd0adc3f233bab18c074046089.1575906694.git.jsarha@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1575906694.git.jsarha@ti.com>
References: <cover.1575906694.git.jsarha@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For DisplayPort use we need to set WIZ_CONFIG_LANECTL register's
P_STANDARD_MODE bits to "mode 3". In the DisplayPort use also the
P_ENABLE bits of the same register are set to P_ENABLE instead of
P_ENABLE_FORCE, so that the DisplayPort driver can enable and disable
the lane as needed. The DisplayPort mode is selected according to
lane<n>-mode -property. All other values of lane<n>-mode -property but
PHY_TYPE_DP will set P_STANDARD_MODE bits to 0 and P_ENABLE bits to
force enable.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/phy/ti/phy-j721e-wiz.c | 55 +++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index c74979655654..d2a38ea6d881 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -20,6 +20,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset-controller.h>
+#include <dt-bindings/phy/phy.h>
 
 #define WIZ_SERDES_CTRL		0x404
 #define WIZ_SERDES_TOP_CTRL	0x408
@@ -78,6 +79,8 @@ static const struct reg_field p_enable[WIZ_MAX_LANES] = {
 	REG_FIELD(WIZ_LANECTL(3), 30, 31),
 };
 
+enum p_enable { P_ENABLE = 2, P_ENABLE_FORCE = 1, P_ENABLE_DISABLE = 0 };
+
 static const struct reg_field p_align[WIZ_MAX_LANES] = {
 	REG_FIELD(WIZ_LANECTL(0), 29, 29),
 	REG_FIELD(WIZ_LANECTL(1), 29, 29),
@@ -220,6 +223,7 @@ struct wiz {
 	struct reset_controller_dev wiz_phy_reset_dev;
 	struct gpio_desc	*gpio_typec_dir;
 	int			typec_dir_delay;
+	u32 lane_modes[WIZ_MAX_LANES];
 };
 
 static int wiz_reset(struct wiz *wiz)
@@ -242,12 +246,17 @@ static int wiz_reset(struct wiz *wiz)
 static int wiz_mode_select(struct wiz *wiz)
 {
 	u32 num_lanes = wiz->num_lanes;
+	enum wiz_lane_standard_mode mode;
 	int ret;
 	int i;
 
 	for (i = 0; i < num_lanes; i++) {
-		ret = regmap_field_write(wiz->p_standard_mode[i],
-					 LANE_MODE_GEN4);
+		if (wiz->lane_modes[i] == PHY_TYPE_DP)
+			mode = LANE_MODE_GEN1;
+		else
+			mode = LANE_MODE_GEN4;
+
+		ret = regmap_field_write(wiz->p_standard_mode[i], mode);
 		if (ret)
 			return ret;
 	}
@@ -713,7 +722,7 @@ static int wiz_phy_reset_assert(struct reset_controller_dev *rcdev,
 		return ret;
 	}
 
-	ret = regmap_field_write(wiz->p_enable[id - 1], false);
+	ret = regmap_field_write(wiz->p_enable[id - 1], P_ENABLE_DISABLE);
 	return ret;
 }
 
@@ -740,7 +749,11 @@ static int wiz_phy_reset_deassert(struct reset_controller_dev *rcdev,
 		return ret;
 	}
 
-	ret = regmap_field_write(wiz->p_enable[id - 1], true);
+	if (wiz->lane_modes[id - 1] == PHY_TYPE_DP)
+		ret = regmap_field_write(wiz->p_enable[id - 1], P_ENABLE);
+	else
+		ret = regmap_field_write(wiz->p_enable[id - 1], P_ENABLE_FORCE);
+
 	return ret;
 }
 
@@ -767,6 +780,33 @@ static const struct of_device_id wiz_id_table[] = {
 };
 MODULE_DEVICE_TABLE(of, wiz_id_table);
 
+static int wiz_get_lane_mode(struct device *dev, int lane_number,
+			     u32 *lane_mode)
+{
+	char property_name[11]; /* 11 is length of "lane0-mode\0" */
+	int ret;
+
+	ret = snprintf(property_name, sizeof(property_name), "lane%u-mode",
+		       lane_number);
+
+	if (ret != 10) { /* 10 is length of "lane0-mode" */
+		dev_err(dev, "%s: bad lane number %d (ret = %d)\n",
+			__func__, lane_number, ret);
+		return -ENOTSUPP;
+	}
+
+	ret = of_property_read_u32(dev->of_node, property_name, lane_mode);
+	if (ret == -EINVAL) {
+		*lane_mode = PHY_NONE;
+		return 0;
+	} else if (ret) {
+		dev_err(dev, "Getting \"%s\" property failed: %d\n",
+			property_name, ret);
+	}
+
+	return ret;
+}
+
 static int wiz_probe(struct platform_device *pdev)
 {
 	struct reset_controller_dev *phy_reset_dev;
@@ -780,6 +820,7 @@ static int wiz_probe(struct platform_device *pdev)
 	struct wiz *wiz;
 	u32 num_lanes;
 	int ret;
+	int i;
 
 	wiz = devm_kzalloc(dev, sizeof(*wiz), GFP_KERNEL);
 	if (!wiz)
@@ -850,6 +891,12 @@ static int wiz_probe(struct platform_device *pdev)
 		}
 	}
 
+	for (i = 0; i < num_lanes; i++) {
+		ret = wiz_get_lane_mode(dev, i, &wiz->lane_modes[i]);
+		if (ret)
+			return ret;
+	}
+
 	wiz->dev = dev;
 	wiz->regmap = regmap;
 	wiz->num_lanes = num_lanes;
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

