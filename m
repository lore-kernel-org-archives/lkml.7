Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDA6C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 10:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE27A20675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 10:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfEGKxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 06:53:45 -0400
Received: from foss.arm.com ([217.140.101.70]:50032 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfEGKxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 06:53:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 406BFEBD;
        Tue,  7 May 2019 03:53:42 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0D69F3F5AF;
        Tue,  7 May 2019 03:53:40 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        rjw@rjwysocki.net, mathieu.poirier@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 01/30] coresight: funnel: Clean up device book keeping
Date:   Tue,  7 May 2019 11:52:28 +0100
Message-Id: <1557226378-10131-2-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
References: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to use a consistent device naming scheme,
clean up the device link tracking in funnel driver.
Use the "coresight" device instead of the "real" parent device
for all internal purposes. All other requests (e.g, power management,
DMA operations) must use the "real" device which is the parent device.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-funnel.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 16b0c0e..6236a84 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -32,14 +32,12 @@
 /**
  * struct funnel_drvdata - specifics associated to a funnel component
  * @base:	memory mapped base address for this component.
- * @dev:	the device entity associated to this component.
  * @atclk:	optional clock for the core parts of the funnel.
  * @csdev:	component vitals needed by the framework.
  * @priority:	port selection order.
  */
 struct funnel_drvdata {
 	void __iomem		*base;
-	struct device		*dev;
 	struct clk		*atclk;
 	struct coresight_device	*csdev;
 	unsigned long		priority;
@@ -80,7 +78,7 @@ static int funnel_enable(struct coresight_device *csdev, int inport,
 		rc = dynamic_funnel_enable_hw(drvdata, inport);
 
 	if (!rc)
-		dev_dbg(drvdata->dev, "FUNNEL inport %d enabled\n", inport);
+		dev_dbg(&csdev->dev, "FUNNEL inport %d enabled\n", inport);
 	return rc;
 }
 
@@ -110,7 +108,7 @@ static void funnel_disable(struct coresight_device *csdev, int inport,
 	if (drvdata->base)
 		dynamic_funnel_disable_hw(drvdata, inport);
 
-	dev_dbg(drvdata->dev, "FUNNEL inport %d disabled\n", inport);
+	dev_dbg(&csdev->dev, "FUNNEL inport %d disabled\n", inport);
 }
 
 static const struct coresight_ops_link funnel_link_ops = {
@@ -165,11 +163,11 @@ static ssize_t funnel_ctrl_show(struct device *dev,
 	u32 val;
 	struct funnel_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
-	pm_runtime_get_sync(drvdata->dev);
+	pm_runtime_get_sync(dev->parent);
 
 	val = get_funnel_ctrl_hw(drvdata);
 
-	pm_runtime_put(drvdata->dev);
+	pm_runtime_put(dev->parent);
 
 	return sprintf(buf, "%#x\n", val);
 }
@@ -205,7 +203,6 @@ static int funnel_probe(struct device *dev, struct resource *res)
 	if (!drvdata)
 		return -ENOMEM;
 
-	drvdata->dev = dev;
 	drvdata->atclk = devm_clk_get(dev, "atclk"); /* optional */
 	if (!IS_ERR(drvdata->atclk)) {
 		ret = clk_prepare_enable(drvdata->atclk);
-- 
2.7.4

