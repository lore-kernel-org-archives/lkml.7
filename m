Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA493C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5492146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfCTSuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:50:35 -0400
Received: from foss.arm.com ([217.140.101.70]:44930 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727590AbfCTSuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 14:50:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F004FA78;
        Wed, 20 Mar 2019 11:50:31 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 769A03F59C;
        Wed, 20 Mar 2019 11:50:30 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        robert.walker@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 13/25] coresight: etb10: Clean up device specific data
Date:   Wed, 20 Mar 2019 18:49:30 +0000
Message-Id: <1553107783-3340-14-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Track the coresight device instead of the real device.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 105782e..a471cbd 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -97,12 +97,12 @@ static unsigned int etb_get_buffer_depth(struct etb_drvdata *drvdata)
 {
 	u32 depth = 0;
 
-	pm_runtime_get_sync(drvdata->dev);
+	pm_runtime_get_sync(drvdata->dev->parent);
 
 	/* RO registers don't need locking */
 	depth = readl_relaxed(drvdata->base + ETB_RAM_DEPTH_REG);
 
-	pm_runtime_put(drvdata->dev);
+	pm_runtime_put(drvdata->dev->parent);
 	return depth;
 }
 
@@ -701,7 +701,6 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
 	if (!drvdata)
 		return -ENOMEM;
 
-	drvdata->dev = &adev->dev;
 	drvdata->atclk = devm_clk_get(&adev->dev, "atclk"); /* optional */
 	if (!IS_ERR(drvdata->atclk)) {
 		ret = clk_prepare_enable(drvdata->atclk);
@@ -740,6 +739,7 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
 	if (IS_ERR(drvdata->csdev))
 		return PTR_ERR(drvdata->csdev);
 
+	drvdata->dev = &drvdata->csdev->dev;
 	drvdata->miscdev.name = pdata->name;
 	drvdata->miscdev.minor = MISC_DYNAMIC_MINOR;
 	drvdata->miscdev.fops = &etb_fops;
-- 
2.7.4

