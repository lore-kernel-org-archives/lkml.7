Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1E2C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7366F20880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfDOQGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:06:02 -0400
Received: from foss.arm.com ([217.140.101.70]:37730 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727876AbfDOQF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:05:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02A8480D;
        Mon, 15 Apr 2019 09:05:57 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7B0933F68F;
        Mon, 15 Apr 2019 09:05:55 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        rjw@rjwysocki.net, robert.walker@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 07/36] coresight: replicator: Cleanup device tracking
Date:   Mon, 15 Apr 2019 17:03:50 +0100
Message-Id: <1555344260-12375-8-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to use a consistent device naming scheme,
clean up the device link tracking in replicator driver.
Use the "coresight" device instead of the "real" parent device
for all internal purposes. All other requests (e.g, power management,
DMA operations) must use the "real" device which is the parent device.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-replicator.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 4e0da85..8bbb008 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -26,13 +26,11 @@
  * struct replicator_drvdata - specifics associated to a replicator component
  * @base:	memory mapped base address for this component. Also indicates
  *		whether this one is programmable or not.
- * @dev:	the device entity associated with this component
  * @atclk:	optional clock for the core parts of the replicator.
  * @csdev:	component vitals needed by the framework
  */
 struct replicator_drvdata {
 	void __iomem		*base;
-	struct device		*dev;
 	struct clk		*atclk;
 	struct coresight_device	*csdev;
 };
@@ -100,7 +98,7 @@ static int replicator_enable(struct coresight_device *csdev, int inport,
 	if (drvdata->base)
 		rc = dynamic_replicator_enable(drvdata, inport, outport);
 	if (!rc)
-		dev_dbg(drvdata->dev, "REPLICATOR enabled\n");
+		dev_dbg(&csdev->dev, "REPLICATOR enabled\n");
 	return rc;
 }
 
@@ -139,7 +137,7 @@ static void replicator_disable(struct coresight_device *csdev, int inport,
 
 	if (drvdata->base)
 		dynamic_replicator_disable(drvdata, inport, outport);
-	dev_dbg(drvdata->dev, "REPLICATOR disabled\n");
+	dev_dbg(&csdev->dev, "REPLICATOR disabled\n");
 }
 
 static const struct coresight_ops_link replicator_link_ops = {
@@ -193,7 +191,6 @@ static int replicator_probe(struct device *dev, struct resource *res)
 	if (!drvdata)
 		return -ENOMEM;
 
-	drvdata->dev = dev;
 	drvdata->atclk = devm_clk_get(dev, "atclk"); /* optional */
 	if (!IS_ERR(drvdata->atclk)) {
 		ret = clk_prepare_enable(drvdata->atclk);
-- 
2.7.4

