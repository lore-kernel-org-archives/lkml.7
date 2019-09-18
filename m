Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0611FC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC35C207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731101AbfIRM1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 08:27:40 -0400
Received: from mail-sz.amlogic.com ([211.162.65.117]:56694 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728539AbfIRM1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 08:27:37 -0400
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Sep 2019 08:27:32 EDT
Received: from droid12-sz.software.amlogic (10.28.8.22) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.1591.10; Wed, 18 Sep 2019
 20:13:27 +0800
From:   Xingyu Chen <xingyu.chen@amlogic.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] reset: add support for the Meson-A1 SoC Reset Controller
Date:   Wed, 18 Sep 2019 20:12:29 +0800
Message-ID: <1568808749-1196-1-git-send-email-xingyu.chen@amlogic.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.28.8.22]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of RESET registers and offset of RESET_LEVEL register for
Meson-A1 are different from previous SoCs, In order to describe these
differences, we introduce the struct meson_reset_param.

Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
---
 drivers/reset/reset-meson.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index 5242e06..d9541c1 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -64,12 +64,16 @@
 #include <linux/types.h>
 #include <linux/of_device.h>
 
-#define REG_COUNT	8
 #define BITS_PER_REG	32
-#define LEVEL_OFFSET	0x7c
+
+struct meson_reset_param {
+	int reg_count;
+	int level_offset;
+};
 
 struct meson_reset {
 	void __iomem *reg_base;
+	const struct meson_reset_param *param;
 	struct reset_controller_dev rcdev;
 	spinlock_t lock;
 };
@@ -95,10 +99,12 @@ static int meson_reset_level(struct reset_controller_dev *rcdev,
 		container_of(rcdev, struct meson_reset, rcdev);
 	unsigned int bank = id / BITS_PER_REG;
 	unsigned int offset = id % BITS_PER_REG;
-	void __iomem *reg_addr = data->reg_base + LEVEL_OFFSET + (bank << 2);
+	void __iomem *reg_addr;
 	unsigned long flags;
 	u32 reg;
 
+	reg_addr = data->reg_base + data->param->level_offset + (bank << 2);
+
 	spin_lock_irqsave(&data->lock, flags);
 
 	reg = readl(reg_addr);
@@ -130,10 +136,21 @@ static const struct reset_control_ops meson_reset_ops = {
 	.deassert	= meson_reset_deassert,
 };
 
+static const struct meson_reset_param meson8b_param = {
+	.reg_count	= 8,
+	.level_offset	= 0x7c,
+};
+
+static const struct meson_reset_param meson_a1_param = {
+	.reg_count	= 3,
+	.level_offset	= 0x40,
+};
+
 static const struct of_device_id meson_reset_dt_ids[] = {
-	 { .compatible = "amlogic,meson8b-reset" },
-	 { .compatible = "amlogic,meson-gxbb-reset" },
-	 { .compatible = "amlogic,meson-axg-reset" },
+	 { .compatible = "amlogic,meson8b-reset",    .data = &meson8b_param},
+	 { .compatible = "amlogic,meson-gxbb-reset", .data = &meson8b_param},
+	 { .compatible = "amlogic,meson-axg-reset",  .data = &meson8b_param},
+	 { .compatible = "amlogic,meson-a1-reset",   .data = &meson_a1_param},
 	 { /* sentinel */ },
 };
 
@@ -151,12 +168,16 @@ static int meson_reset_probe(struct platform_device *pdev)
 	if (IS_ERR(data->reg_base))
 		return PTR_ERR(data->reg_base);
 
+	data->param = of_device_get_match_data(&pdev->dev);
+	if (!data->param)
+		return -ENODEV;
+
 	platform_set_drvdata(pdev, data);
 
 	spin_lock_init(&data->lock);
 
 	data->rcdev.owner = THIS_MODULE;
-	data->rcdev.nr_resets = REG_COUNT * BITS_PER_REG;
+	data->rcdev.nr_resets = data->param->reg_count * BITS_PER_REG;
 	data->rcdev.ops = &meson_reset_ops;
 	data->rcdev.of_node = pdev->dev.of_node;
 
-- 
2.7.4

