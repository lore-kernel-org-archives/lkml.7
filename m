Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1BBC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A305F2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfG2ItB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 04:49:01 -0400
Received: from inva020.nxp.com ([92.121.34.13]:55122 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727850AbfG2Isy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 04:48:54 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 13DF91A032F;
        Mon, 29 Jul 2019 10:48:52 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 401CC1A1455;
        Mon, 29 Jul 2019 10:48:47 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0ABBF40313;
        Mon, 29 Jul 2019 16:48:38 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 4/4] thermal: qoriq: Add clock operations
Date:   Mon, 29 Jul 2019 16:39:15 +0800
Message-Id: <20190729083915.4855-4-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190729083915.4855-1-Anson.Huang@nxp.com>
References: <20190729083915.4855-1-Anson.Huang@nxp.com>
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
Changes since V1:
	- use devm_clk_get_optional() instead of devm_clk_get().
---
 drivers/thermal/qoriq_thermal.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 2b2f79b..0ae45c0 100644
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
@@ -208,6 +210,16 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 		return PTR_ERR(data->regs);
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
@@ -235,6 +247,8 @@ static int qoriq_tmu_remove(struct platform_device *pdev)
 	/* Disable monitoring */
 	tmu_write(data, TMR_DISABLE, &data->regs->tmr);
 
+	clk_disable_unprepare(data->clk);
+
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
@@ -250,14 +264,21 @@ static int __maybe_unused qoriq_tmu_suspend(struct device *dev)
 	tmr &= ~TMR_ME;
 	tmu_write(data, tmr, &data->regs->tmr);
 
+	clk_disable_unprepare(data->clk);
+
 	return 0;
 }
 
 static int __maybe_unused qoriq_tmu_resume(struct device *dev)
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

