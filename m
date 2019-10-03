Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73068C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 18:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50911222C4
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 18:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbfJCSyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 14:54:02 -0400
Received: from mxwww.masterlogin.de ([95.129.51.220]:53234 "EHLO
        mxwww.masterlogin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730471AbfJCSyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 14:54:00 -0400
Received: from mxout2.routing.net (unknown [192.168.10.82])
        by new.mxwww.masterlogin.de (Postfix) with ESMTPS id A5FE596C8B;
        Thu,  3 Oct 2019 18:53:53 +0000 (UTC)
Received: from mxbox4.masterlogin.de (unknown [192.168.10.79])
        by mxout2.routing.net (Postfix) with ESMTP id 127BF648FA;
        Thu,  3 Oct 2019 18:53:54 +0000 (UTC)
Received: from localhost.localdomain (fttx-pool-217.61.155.74.bambit.de [217.61.155.74])
        by mxbox4.masterlogin.de (Postfix) with ESMTPSA id 71F278089F;
        Thu,  3 Oct 2019 18:53:53 +0000 (UTC)
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Frank Wunderlich <frank-w@public-files.de>
Subject: [PATCH] mfd: mt6397: fix probe after changing mt6397-core
Date:   Thu,  3 Oct 2019 20:53:23 +0200
Message-Id: <20191003185323.24646-1-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Part 3 from this series [1] was not merged due to wrong splitting
and breaks mt6323 pmic on bananapi-r2

dmesg prints this line and at least switch is not initialized on bananapi-r2

mt6397 1000d000.pwrap:mt6323: unsupported chip: 0x0

this patch contains only the probe-changes and chip_data structs
from original part 3 by Hsin-Hsiung Wang

Fixes: a4872e80ce7d2a1844328176dbf279d0a2b89bdb mfd: mt6397: Extract IRQ related code from core driver

[1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=164155

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/mfd/mt6397-core.c | 64 ++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 24 deletions(-)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 310dae26ddff..b2c325ead1c8 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -129,11 +129,27 @@ static int mt6397_irq_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(mt6397_pm_ops, mt6397_irq_suspend,
 			mt6397_irq_resume);
 
+struct chip_data {
+	u32 cid_addr;
+	u32 cid_shift;
+};
+
+static const struct chip_data mt6323_core = {
+	.cid_addr = MT6323_CID,
+	.cid_shift = 0,
+};
+
+static const struct chip_data mt6397_core = {
+	.cid_addr = MT6397_CID,
+	.cid_shift = 0,
+};
+
 static int mt6397_probe(struct platform_device *pdev)
 {
 	int ret;
 	unsigned int id;
 	struct mt6397_chip *pmic;
+	const struct chip_data *pmic_core;
 
 	pmic = devm_kzalloc(&pdev->dev, sizeof(*pmic), GFP_KERNEL);
 	if (!pmic)
@@ -149,28 +165,30 @@ static int mt6397_probe(struct platform_device *pdev)
 	if (!pmic->regmap)
 		return -ENODEV;
 
-	platform_set_drvdata(pdev, pmic);
+	pmic_core = of_device_get_match_data(&pdev->dev);
+	if (!pmic_core)
+		return -ENODEV;
 
-	ret = regmap_read(pmic->regmap, MT6397_CID, &id);
+	ret = regmap_read(pmic->regmap, pmic_core->cid_addr, &id);
 	if (ret) {
-		dev_err(pmic->dev, "Failed to read chip id: %d\n", ret);
+		dev_err(&pdev->dev, "Failed to read chip id: %d\n", ret);
 		return ret;
 	}
 
+	pmic->chip_id = (id >> pmic_core->cid_shift) & 0xff;
+
+	platform_set_drvdata(pdev, pmic);
+
 	pmic->irq = platform_get_irq(pdev, 0);
 	if (pmic->irq <= 0)
 		return pmic->irq;
 
-	switch (id & 0xff) {
-	case MT6323_CHIP_ID:
-		pmic->int_con[0] = MT6323_INT_CON0;
-		pmic->int_con[1] = MT6323_INT_CON1;
-		pmic->int_status[0] = MT6323_INT_STATUS0;
-		pmic->int_status[1] = MT6323_INT_STATUS1;
-		ret = mt6397_irq_init(pmic);
-		if (ret)
-			return ret;
+	ret = mt6397_irq_init(pmic);
+	if (ret)
+		return ret;
 
+	switch (pmic->chip_id) {
+	case MT6323_CHIP_ID:
 		ret = devm_mfd_add_devices(&pdev->dev, -1, mt6323_devs,
 					   ARRAY_SIZE(mt6323_devs), NULL,
 					   0, pmic->irq_domain);
@@ -178,21 +196,13 @@ static int mt6397_probe(struct platform_device *pdev)
 
 	case MT6391_CHIP_ID:
 	case MT6397_CHIP_ID:
-		pmic->int_con[0] = MT6397_INT_CON0;
-		pmic->int_con[1] = MT6397_INT_CON1;
-		pmic->int_status[0] = MT6397_INT_STATUS0;
-		pmic->int_status[1] = MT6397_INT_STATUS1;
-		ret = mt6397_irq_init(pmic);
-		if (ret)
-			return ret;
-
 		ret = devm_mfd_add_devices(&pdev->dev, -1, mt6397_devs,
 					   ARRAY_SIZE(mt6397_devs), NULL,
 					   0, pmic->irq_domain);
 		break;
 
 	default:
-		dev_err(&pdev->dev, "unsupported chip: %d\n", id);
+		dev_err(&pdev->dev, "unsupported chip: %d\n", pmic->chip_id);
 		return -ENODEV;
 	}
 
@@ -205,9 +215,15 @@ static int mt6397_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id mt6397_of_match[] = {
-	{ .compatible = "mediatek,mt6397" },
-	{ .compatible = "mediatek,mt6323" },
-	{ }
+	{
+		.compatible = "mediatek,mt6323",
+		.data = &mt6323_core,
+	}, {
+		.compatible = "mediatek,mt6397",
+		.data = &mt6397_core,
+	}, {
+		/* sentinel */
+	}
 };
 MODULE_DEVICE_TABLE(of, mt6397_of_match);
 
-- 
2.17.1

