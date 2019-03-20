Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D14C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2BA62146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfCTSvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:51:54 -0400
Received: from foss.arm.com ([217.140.101.70]:44920 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727577AbfCTSua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 14:50:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3956A1AC1;
        Wed, 20 Mar 2019 11:50:30 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B3CFF3F59C;
        Wed, 20 Mar 2019 11:50:28 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        robert.walker@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 12/25] coresight: etm: Clean up device specific data
Date:   Wed, 20 Mar 2019 18:49:29 +0000
Message-Id: <1553107783-3340-13-git-send-email-suzuki.poulose@arm.com>
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
 drivers/hwtracing/coresight/coresight-etm3x.c | 6 +++---
 drivers/hwtracing/coresight/coresight-etm4x.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index be302ec..1b9ae3a 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -462,7 +462,7 @@ int etm_get_trace_id(struct etm_drvdata *drvdata)
 	if (!local_read(&drvdata->mode))
 		return drvdata->traceid;
 
-	pm_runtime_get_sync(drvdata->dev);
+	pm_runtime_get_sync(drvdata->dev->parent);
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
@@ -471,7 +471,7 @@ int etm_get_trace_id(struct etm_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
-	pm_runtime_put(drvdata->dev);
+	pm_runtime_put(drvdata->dev->parent);
 
 out:
 	return trace_id;
@@ -803,7 +803,6 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 		drvdata->use_cp14 = of_property_read_bool(np, "arm,cp14");
 	}
 
-	drvdata->dev = &adev->dev;
 	dev_set_drvdata(dev, drvdata);
 
 	/* Validity for the resource is already checked by the AMBA core */
@@ -864,6 +863,7 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 		goto err_arch_supported;
 	}
 
+	drvdata->dev = &drvdata->csdev->dev;
 	ret = etm_perf_symlink(drvdata->csdev, true);
 	if (ret) {
 		coresight_unregister(drvdata->csdev);
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 08ce37c..8d5ee3b 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -987,7 +987,6 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 		adev->dev.platform_data = pdata;
 	}
 
-	drvdata->dev = &adev->dev;
 	dev_set_drvdata(dev, drvdata);
 
 	/* Validity for the resource is already checked by the AMBA core */
@@ -1042,6 +1041,7 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 		goto err_arch_supported;
 	}
 
+	drvdata->dev = &drvdata->csdev->dev;
 	ret = etm_perf_symlink(drvdata->csdev, true);
 	if (ret) {
 		coresight_unregister(drvdata->csdev);
@@ -1049,7 +1049,7 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	}
 
 	pm_runtime_put(&adev->dev);
-	dev_info(dev, "CPU%d: ETM v%d.%d initialized\n",
+	dev_info(drvdata->dev, "CPU%d: ETM v%d.%d initialized\n",
 		 drvdata->cpu, drvdata->arch >> 4, drvdata->arch & 0xf);
 
 	if (boot_enable) {
-- 
2.7.4

