Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A374EC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7106520818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbfDOQJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:09:09 -0400
Received: from foss.arm.com ([217.140.101.70]:37656 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727696AbfDOQFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:05:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2380280D;
        Mon, 15 Apr 2019 09:05:48 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9DE6C3F68F;
        Mon, 15 Apr 2019 09:05:46 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        rjw@rjwysocki.net, robert.walker@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 02/36] coresight: etb10: Cleanup power management
Date:   Mon, 15 Apr 2019 17:03:45 +0100
Message-Id: <1555344260-12375-3-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We drop the power before we complete the probe successfully. We
are supposed to drop it only when we are successful. Also, probing
the etb_buffer_length happens with the power turned up. So we don't
need to do that again in the helper.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 105782e..13c0a60 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -93,17 +93,9 @@ struct etb_drvdata {
 static int etb_set_buffer(struct coresight_device *csdev,
 			  struct perf_output_handle *handle);
 
-static unsigned int etb_get_buffer_depth(struct etb_drvdata *drvdata)
+static inline unsigned int etb_get_buffer_depth(struct etb_drvdata *drvdata)
 {
-	u32 depth = 0;
-
-	pm_runtime_get_sync(drvdata->dev);
-
-	/* RO registers don't need locking */
-	depth = readl_relaxed(drvdata->base + ETB_RAM_DEPTH_REG);
-
-	pm_runtime_put(drvdata->dev);
-	return depth;
+	return readl_relaxed(drvdata->base + ETB_RAM_DEPTH_REG);
 }
 
 static void __etb_enable_hw(struct etb_drvdata *drvdata)
@@ -720,7 +712,6 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
 	spin_lock_init(&drvdata->spinlock);
 
 	drvdata->buffer_depth = etb_get_buffer_depth(drvdata);
-	pm_runtime_put(&adev->dev);
 
 	if (drvdata->buffer_depth & 0x80000000)
 		return -EINVAL;
@@ -747,6 +738,7 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
 	if (ret)
 		goto err_misc_register;
 
+	pm_runtime_put(&adev->dev);
 	return 0;
 
 err_misc_register:
-- 
2.7.4

