Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741C4C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E7620693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731278AbfG3CbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:31:02 -0400
Received: from inva021.nxp.com ([92.121.34.21]:36018 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730971AbfG3CbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:31:01 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5667D20053E;
        Tue, 30 Jul 2019 04:30:59 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6E6A9200538;
        Tue, 30 Jul 2019 04:30:54 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 318C1402F1;
        Tue, 30 Jul 2019 10:30:48 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V3 1/5] thermal: qoriq: Add clock operations
Date:   Tue, 30 Jul 2019 10:21:22 +0800
Message-Id: <20190730022126.17883-1-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.9.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Some platforms like i.MX8MQ has clock control for this module,
need to add clock operations to make sure the driver is working
properly.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Guido Günther <agx@sigxcpu.org>
---
Changes since V2:
	- move this patch as first patch in the series;
	- add clock disable handling in error path of probe.
---
 drivers/thermal/qoriq_thermal.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 7b36493..2893947 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -2,6 +2,7 @@
 //
 // Copyright 2016 Freescale Semiconductor, Inc.
 
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/err.h>
@@ -72,6 +73,7 @@ struct qoriq_sensor {
 
 struct qoriq_tmu_data {
 	struct qoriq_tmu_regs __iomem *regs;
+	struct clk *clk;
 	bool little_endian;
 	struct qoriq_sensor	*sensor[SITES_MAX];
 };
@@ -209,6 +211,16 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 		goto err_iomap;
 	}
 
+	data->clk = devm_clk_get_optional(&pdev->dev, NULL);
+	if (IS_ERR(data->clk))
+		return PTR_ERR(data->clk);
+
+	ret = clk_prepare_enable(data->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to enable clock\n");
+		return ret;
+	}
+
 	qoriq_tmu_init_device(data);	/* TMU initialization */
 
 	ret = qoriq_tmu_calibration(pdev);	/* TMU calibration */
@@ -225,6 +237,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	return 0;
 
 err_tmu:
+	clk_disable_unprepare(data->clk);
 	iounmap(data->regs);
 
 err_iomap:
@@ -241,6 +254,9 @@ static int qoriq_tmu_remove(struct platform_device *pdev)
 	tmu_write(data, TMR_DISABLE, &data->regs->tmr);
 
 	iounmap(data->regs);
+
+	clk_disable_unprepare(data->clk);
+
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
@@ -257,14 +273,21 @@ static int qoriq_tmu_suspend(struct device *dev)
 	tmr &= ~TMR_ME;
 	tmu_write(data, tmr, &data->regs->tmr);
 
+	clk_disable_unprepare(data->clk);
+
 	return 0;
 }
 
 static int qoriq_tmu_resume(struct device *dev)
 {
 	u32 tmr;
+	int ret;
 	struct qoriq_tmu_data *data = dev_get_drvdata(dev);
 
+	ret = clk_prepare_enable(data->clk);
+	if (ret)
+		return ret;
+
 	/* Enable monitoring */
 	tmr = tmu_read(data, &data->regs->tmr);
 	tmr |= TMR_ME;
-- 
2.7.4

