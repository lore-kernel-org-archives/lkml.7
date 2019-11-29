Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AD5C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 14:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA4921845
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 14:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfK2Oqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 09:46:35 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:43435 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbfK2Oqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 09:46:34 -0500
Received: from droid15-sz.amlogic.com (10.28.8.25) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.1591.10; Fri, 29 Nov 2019
 22:46:37 +0800
From:   Jian Hu <jian.hu@amlogic.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Jian Hu <jian.hu@amlogic.com>, Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Chandle Zou <chandle.zou@amlogic.com>,
        <linux-clk@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/7] clk: meson: eeclk: refactor eeclk common driver to support A1
Date:   Fri, 29 Nov 2019 22:46:01 +0800
Message-ID: <20191129144605.182774-4-jian.hu@amlogic.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191129144605.182774-1-jian.hu@amlogic.com>
References: <20191129144605.182774-1-jian.hu@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.8.25]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a common probe function for A1 series, the way to get
regmap is different between A1 series and the previous series.
The register region is only for one clock driver, the function of
meson_eeclkc_probe is not fit for A1, So it is necessary to
introduce a new function.
---
 drivers/clk/meson/meson-eeclk.c | 59 +++++++++++++++++++++++++++------
 drivers/clk/meson/meson-eeclk.h |  2 ++
 2 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/meson/meson-eeclk.c b/drivers/clk/meson/meson-eeclk.c
index a7cb1e7aedc4..6f9c8ee38c20 100644
--- a/drivers/clk/meson/meson-eeclk.c
+++ b/drivers/clk/meson/meson-eeclk.c
@@ -13,25 +13,37 @@
 #include "clk-regmap.h"
 #include "meson-eeclk.h"
 
-int meson_eeclkc_probe(struct platform_device *pdev)
+static struct regmap_config clkc_regmap_config = {
+	.reg_bits       = 32,
+	.val_bits       = 32,
+	.reg_stride     = 4,
+};
+
+struct regmap *meson_regmap_resource(struct platform_device *pdev)
+{
+	struct resource *res;
+	void __iomem *base;
+	struct device *dev = &pdev->dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return ERR_CAST(base);
+
+	return devm_regmap_init_mmio(dev, base, &clkc_regmap_config);
+}
+
+int meson_common_probe(struct platform_device *pdev, struct regmap *map)
 {
 	const struct meson_eeclkc_data *data;
 	struct device *dev = &pdev->dev;
-	struct regmap *map;
 	int ret, i;
 
 	data = of_device_get_match_data(dev);
 	if (!data)
 		return -EINVAL;
 
-	/* Get the hhi system controller node */
-	map = syscon_node_to_regmap(of_get_parent(dev->of_node));
-	if (IS_ERR(map)) {
-		dev_err(dev,
-			"failed to get HHI regmap\n");
-		return PTR_ERR(map);
-	}
-
 	if (data->init_count)
 		regmap_multi_reg_write(map, data->init_regs, data->init_count);
 
@@ -54,3 +66,30 @@ int meson_eeclkc_probe(struct platform_device *pdev)
 	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
 					   data->hw_onecell_data);
 }
+
+int meson_eeclkc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct regmap *map;
+
+	/* Get the hhi system controller node */
+	map = syscon_node_to_regmap(of_get_parent(dev->of_node));
+	if (IS_ERR(map)) {
+		dev_err(dev,
+			"failed to get HHI regmap\n");
+		return PTR_ERR(map);
+	}
+
+	return meson_common_probe(pdev, map);
+}
+
+int meson_clkc_probe(struct platform_device *pdev)
+{
+	struct regmap *map;
+
+	map = meson_regmap_resource(pdev);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
+	return meson_common_probe(pdev, map);
+}
diff --git a/drivers/clk/meson/meson-eeclk.h b/drivers/clk/meson/meson-eeclk.h
index 77316207bde1..db0bfba8f6b3 100644
--- a/drivers/clk/meson/meson-eeclk.h
+++ b/drivers/clk/meson/meson-eeclk.h
@@ -20,6 +20,8 @@ struct meson_eeclkc_data {
 	struct clk_hw_onecell_data	*hw_onecell_data;
 };
 
+struct regmap *meson_regmap_resource(struct platform_device *pdev);
 int meson_eeclkc_probe(struct platform_device *pdev);
+int meson_clkc_probe(struct platform_device *pdev);
 
 #endif /* __MESON_CLKC_H */
-- 
2.24.0

