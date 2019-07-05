Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C9DC5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 05:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F16A2189E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 05:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfGEFFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 01:05:38 -0400
Received: from inva020.nxp.com ([92.121.34.13]:58158 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726824AbfGEFFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 01:05:37 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6767A1A0173;
        Fri,  5 Jul 2019 07:05:35 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 87CAF1A0E91;
        Fri,  5 Jul 2019 07:05:23 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id AF931402A6;
        Fri,  5 Jul 2019 13:05:09 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, mturquette@baylibre.com,
        sboyd@kernel.org, l.stach@pengutronix.de, abel.vesa@nxp.com,
        andrew.smirnov@gmail.com, angus@akkea.ca, ccaione@baylibre.com,
        agx@sigxcpu.org, leonard.crestez@nxp.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/6] thermal: qoriq: Use __maybe_unused instead of #if CONFIG_PM_SLEEP
Date:   Fri,  5 Jul 2019 12:56:08 +0800
Message-Id: <20190705045612.27665-2-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190705045612.27665-1-Anson.Huang@nxp.com>
References: <20190705045612.27665-1-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Use __maybe_unused for power management related functions
instead of #if CONFIG_PM_SLEEP to simply the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/thermal/qoriq_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index c7c7de2..2b2f79b 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -240,8 +240,7 @@ static int qoriq_tmu_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int qoriq_tmu_suspend(struct device *dev)
+static int __maybe_unused qoriq_tmu_suspend(struct device *dev)
 {
 	u32 tmr;
 	struct qoriq_tmu_data *data = dev_get_drvdata(dev);
@@ -254,7 +253,7 @@ static int qoriq_tmu_suspend(struct device *dev)
 	return 0;
 }
 
-static int qoriq_tmu_resume(struct device *dev)
+static int __maybe_unused qoriq_tmu_resume(struct device *dev)
 {
 	u32 tmr;
 	struct qoriq_tmu_data *data = dev_get_drvdata(dev);
@@ -266,7 +265,6 @@ static int qoriq_tmu_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(qoriq_tmu_pm_ops,
 			 qoriq_tmu_suspend, qoriq_tmu_resume);
-- 
2.7.4

