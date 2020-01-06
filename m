Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F84C33C9B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 13:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B11E22072E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 13:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="J2OFfNKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgAFNGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 08:06:37 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:42004 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgAFNGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 08:06:36 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 006D6YNK036369;
        Mon, 6 Jan 2020 07:06:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578315995;
        bh=soQVqElUgeYYTs4GQ2QMNIo22Q0FVeDlhr1DiwLKEqg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=J2OFfNKHdDv1anZx6oX95y3jOnZDsGUib80hBwttSgcWTpIOw72Vc/Flf3kcPA3V4
         eOsEZc9AhaMnWR7w3OvB5/6IwXTKnBMLE8Z3iBNtk1NfUObQpcx7EvKIbj/zvRRE+m
         BQIEF9sE+FwtmMn0On+b41gc+PVpIQFckTrDXYTQ=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 006D6Yfe019930;
        Mon, 6 Jan 2020 07:06:34 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 6 Jan
 2020 07:06:34 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 6 Jan 2020 07:06:34 -0600
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 006D6PkJ089522;
        Mon, 6 Jan 2020 07:06:32 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <kishon@ti.com>
CC:     <aniljoy@cadence.com>, <adouglas@cadence.com>, <nsekhar@ti.com>,
        <jsarha@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v5 3/3] phy: ti: j721e-wiz: Manage typec-gpio-dir
Date:   Mon, 6 Jan 2020 15:06:22 +0200
Message-ID: <20200106130622.29703-4-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106130622.29703-1-rogerq@ti.com>
References: <20200106130622.29703-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on this GPIO state we need to configure LN10
bit to swap lane0 and lane1 if required (flipped connector).

Type-C companions typically need some time after the cable is
plugged before and before they reflect the correct status of
Type-C plug orientation on the DIR line.

Type-C Spec specifies CC attachment debounce time (tCCDebounce)
of 100 ms (min) to 200 ms (max).

Use the DT property to figure out if we need to add delay
or not before sampling the Type-C DIR line.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Reviewed-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/phy/ti/phy-j721e-wiz.c | 61 ++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index b86ebdd68302..b5f6019e5c7d 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -9,6 +9,8 @@
 #include <dt-bindings/phy/phy.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/mux/consumer.h>
@@ -22,6 +24,7 @@
 #define WIZ_SERDES_CTRL		0x404
 #define WIZ_SERDES_TOP_CTRL	0x408
 #define WIZ_SERDES_RST		0x40c
+#define WIZ_SERDES_TYPEC	0x410
 #define WIZ_LANECTL(n)		(0x480 + (0x40 * (n)))
 
 #define WIZ_MAX_LANES		4
@@ -29,6 +32,8 @@
 #define WIZ_DIV_NUM_CLOCKS_16G	2
 #define WIZ_DIV_NUM_CLOCKS_10G	1
 
+#define WIZ_SERDES_TYPEC_LN10_SWAP	BIT(30)
+
 enum wiz_lane_standard_mode {
 	LANE_MODE_GEN1,
 	LANE_MODE_GEN2,
@@ -94,6 +99,9 @@ static const struct reg_field p_standard_mode[WIZ_MAX_LANES] = {
 	REG_FIELD(WIZ_LANECTL(3), 24, 25),
 };
 
+static const struct reg_field typec_ln10_swap =
+					REG_FIELD(WIZ_SERDES_TYPEC, 30, 30);
+
 struct wiz_clk_mux {
 	struct clk_hw		hw;
 	struct regmap_field	*field;
@@ -185,6 +193,9 @@ enum wiz_type {
 	J721E_WIZ_10G,
 };
 
+#define WIZ_TYPEC_DIR_DEBOUNCE_MIN	100	/* ms */
+#define WIZ_TYPEC_DIR_DEBOUNCE_MAX	1000
+
 struct wiz {
 	struct regmap		*regmap;
 	enum wiz_type		type;
@@ -201,11 +212,14 @@ struct wiz {
 	struct regmap_field	*pma_cmn_refclk_mode;
 	struct regmap_field	*pma_cmn_refclk_dig_div;
 	struct regmap_field	*pma_cmn_refclk1_dig_div;
+	struct regmap_field	*typec_ln10_swap;
 
 	struct device		*dev;
 	u32			num_lanes;
 	struct platform_device	*serdes_pdev;
 	struct reset_controller_dev wiz_phy_reset_dev;
+	struct gpio_desc	*gpio_typec_dir;
+	int			typec_dir_delay;
 };
 
 static int wiz_reset(struct wiz *wiz)
@@ -404,6 +418,13 @@ static int wiz_regfield_init(struct wiz *wiz)
 		}
 	}
 
+	wiz->typec_ln10_swap = devm_regmap_field_alloc(dev, regmap,
+						       typec_ln10_swap);
+	if (IS_ERR(wiz->typec_ln10_swap)) {
+		dev_err(dev, "LN10_SWAP reg field init failed\n");
+		return PTR_ERR(wiz->typec_ln10_swap);
+	}
+
 	return 0;
 }
 
@@ -697,6 +718,17 @@ static int wiz_phy_reset_deassert(struct reset_controller_dev *rcdev,
 	struct wiz *wiz = dev_get_drvdata(dev);
 	int ret;
 
+	/* if typec-dir gpio was specified, set LN10 SWAP bit based on that */
+	if (id == 0 && wiz->gpio_typec_dir) {
+		if (wiz->typec_dir_delay)
+			msleep_interruptible(wiz->typec_dir_delay);
+
+		if (gpiod_get_value_cansleep(wiz->gpio_typec_dir))
+			regmap_field_write(wiz->typec_ln10_swap, 1);
+		else
+			regmap_field_write(wiz->typec_ln10_swap, 0);
+	}
+
 	if (id == 0) {
 		ret = regmap_field_write(wiz->phy_reset_n, true);
 		return ret;
@@ -783,6 +815,35 @@ static int wiz_probe(struct platform_device *pdev)
 		goto err_addr_to_resource;
 	}
 
+	wiz->gpio_typec_dir = devm_gpiod_get_optional(dev, "typec-dir",
+						      GPIOD_IN);
+	if (IS_ERR(wiz->gpio_typec_dir)) {
+		ret = PTR_ERR(wiz->gpio_typec_dir);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "Failed to request typec-dir gpio: %d\n",
+				ret);
+		goto err_addr_to_resource;
+	}
+
+	if (wiz->gpio_typec_dir) {
+		ret = of_property_read_u32(node, "typec-dir-debounce-ms",
+					   &wiz->typec_dir_delay);
+		if (ret && ret != -EINVAL) {
+			dev_err(dev, "Invalid typec-dir-debounce property\n");
+			goto err_addr_to_resource;
+		}
+
+		/* use min. debounce from Type-C spec if not provided in DT  */
+		if (ret == -EINVAL)
+			wiz->typec_dir_delay = WIZ_TYPEC_DIR_DEBOUNCE_MIN;
+
+		if (wiz->typec_dir_delay < WIZ_TYPEC_DIR_DEBOUNCE_MIN ||
+		    wiz->typec_dir_delay > WIZ_TYPEC_DIR_DEBOUNCE_MAX) {
+			dev_err(dev, "Invalid typec-dir-debounce property\n");
+			goto err_addr_to_resource;
+		}
+	}
+
 	wiz->dev = dev;
 	wiz->regmap = regmap;
 	wiz->num_lanes = num_lanes;
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

