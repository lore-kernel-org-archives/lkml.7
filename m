Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C25C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09CE217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfDKKDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:03:53 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:58594 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfDKKDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:03:53 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1hEWYf-000336-PW from Jiada_Wang@mentor.com ; Thu, 11 Apr 2019 03:03:49 -0700
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Thu, 11 Apr 2019 03:03:46 -0700
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <daniel.lezcano@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jiada_wang@mentor.com>
Subject: [PATCH v1 1/1] thermal: rcar_gen3_thermal: request IRQ after device initialization
Date:   Thu, 11 Apr 2019 19:03:52 +0900
Message-ID: <20190411100352.15977-1-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: svr-orw-mbx-08.mgc.mentorg.com (147.34.90.208) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently IRQ is remain enabled after .remove, later if device is probed,
IRQ is requested before .thermal_init, this may cause IRQ function be
triggered but not able to clear IRQ status, thus cause system to hang.

this patch by moving request of IRQ after device initialization to
avoid this issue.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/thermal/rcar_gen3_thermal.c | 48 ++++++++++++++++-------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 88fa41cf16e8..4d095d7f9763 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -375,28 +375,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	/*
-	 * Request 2 (of the 3 possible) IRQs, the driver only needs to
-	 * to trigger on the low and high trip points of the current
-	 * temp window at this point.
-	 */
-	for (i = 0; i < 2; i++) {
-		irq = platform_get_irq(pdev, i);
-		if (irq < 0)
-			return irq;
-
-		irqname = devm_kasprintf(dev, GFP_KERNEL, "%s:ch%d",
-					 dev_name(dev), i);
-		if (!irqname)
-			return -ENOMEM;
-
-		ret = devm_request_threaded_irq(dev, irq, rcar_gen3_thermal_irq,
-						rcar_gen3_thermal_irq_thread,
-						IRQF_SHARED, irqname, priv);
-		if (ret)
-			return ret;
-	}
-
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
@@ -458,6 +436,32 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		goto error_unregister;
 	}
 
+	/*
+	 * Request 2 (of the 3 possible) IRQs, the driver only needs to
+	 * to trigger on the low and high trip points of the current
+	 * temp window at this point.
+	 */
+	for (i = 0; i < 2; i++) {
+		irq = platform_get_irq(pdev, i);
+		if (irq < 0) {
+			ret = irq;
+			goto error_unregister;
+		}
+
+		irqname = devm_kasprintf(dev, GFP_KERNEL, "%s:ch%d",
+					 dev_name(dev), i);
+		if (!irqname) {
+			ret = -ENOMEM;
+			goto error_unregister;
+		}
+
+		ret = devm_request_threaded_irq(dev, irq, rcar_gen3_thermal_irq,
+						rcar_gen3_thermal_irq_thread,
+						IRQF_SHARED, irqname, priv);
+		if (ret)
+			goto error_unregister;
+	}
+
 	rcar_thermal_irq_set(priv, true);
 
 	return 0;
-- 
2.19.2

