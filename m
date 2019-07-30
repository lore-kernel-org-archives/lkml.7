Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3BCC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49281206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbfG3CbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:31:19 -0400
Received: from inva020.nxp.com ([92.121.34.13]:45572 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731012AbfG3CbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:31:03 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4F3351A0528;
        Tue, 30 Jul 2019 04:31:01 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 682CE1A0271;
        Tue, 30 Jul 2019 04:30:56 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2C24E402E8;
        Tue, 30 Jul 2019 10:30:50 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V3 3/5] thermal: qoriq: Use devm_platform_ioremap_resource() instead of of_iomap()
Date:   Tue, 30 Jul 2019 10:21:24 +0800
Message-Id: <20190730022126.17883-3-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190730022126.17883-1-Anson.Huang@nxp.com>
References: <20190730022126.17883-1-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Use devm_platform_ioremap_resource() instead of of_iomap() to
save the iounmap() call in error handle path;

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No change, just adjust the patch sequence and handle the conflicts.
---
 drivers/thermal/qoriq_thermal.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 5755a11..8d19601 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -204,11 +204,10 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 
 	data->little_endian = of_property_read_bool(np, "little-endian");
 
-	data->regs = of_iomap(np, 0);
-	if (!data->regs) {
+	data->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(data->regs)) {
 		dev_err(&pdev->dev, "Failed to get memory region\n");
-		ret = -ENODEV;
-		goto err_iomap;
+		return PTR_ERR(data->regs);
 	}
 
 	data->clk = devm_clk_get_optional(&pdev->dev, NULL);
@@ -225,22 +224,19 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 
 	ret = qoriq_tmu_calibration(pdev);	/* TMU calibration */
 	if (ret < 0)
-		goto err_tmu;
+		goto err;
 
 	ret = qoriq_tmu_register_tmu_zone(pdev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to register sensors\n");
 		ret = -ENODEV;
-		goto err_tmu;
+		goto err;
 	}
 
 	return 0;
 
-err_tmu:
+err:
 	clk_disable_unprepare(data->clk);
-	iounmap(data->regs);
-
-err_iomap:
 	platform_set_drvdata(pdev, NULL);
 
 	return ret;
@@ -253,8 +249,6 @@ static int qoriq_tmu_remove(struct platform_device *pdev)
 	/* Disable monitoring */
 	tmu_write(data, TMR_DISABLE, &data->regs->tmr);
 
-	iounmap(data->regs);
-
 	clk_disable_unprepare(data->clk);
 
 	platform_set_drvdata(pdev, NULL);
-- 
2.7.4

