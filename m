Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4B0C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 10:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 580E120675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 10:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfEGKx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 06:53:56 -0400
Received: from foss.arm.com ([217.140.101.70]:50118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726945AbfEGKxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 06:53:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 042921684;
        Tue,  7 May 2019 03:53:51 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C50D33F5AF;
        Tue,  7 May 2019 03:53:49 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        rjw@rjwysocki.net, mathieu.poirier@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 07/30] coresight: etm: Clean up device specific data
Date:   Tue,  7 May 2019 11:52:34 +0100
Message-Id: <1557226378-10131-8-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
References: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Track the coresight device instead of the real device.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm.h        |  6 ++----
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    | 12 ++++++------
 drivers/hwtracing/coresight/coresight-etm3x.c      | 22 ++++++++++++----------
 drivers/hwtracing/coresight/coresight-etm4x.c      | 17 +++++++++--------
 drivers/hwtracing/coresight/coresight-etm4x.h      |  2 --
 5 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
index 79e1ad8..f3ab96e 100644
--- a/drivers/hwtracing/coresight/coresight-etm.h
+++ b/drivers/hwtracing/coresight/coresight-etm.h
@@ -208,7 +208,6 @@ struct etm_config {
 /**
  * struct etm_drvdata - specifics associated to an ETM component
  * @base:	memory mapped base address for this component.
- * @dev:	the device entity associated to this component.
  * @atclk:	optional clock for the core parts of the ETM.
  * @csdev:	component vitals needed by the framework.
  * @spinlock:	only one at a time pls.
@@ -232,7 +231,6 @@ struct etm_config {
  */
 struct etm_drvdata {
 	void __iomem			*base;
-	struct device			*dev;
 	struct clk			*atclk;
 	struct coresight_device		*csdev;
 	spinlock_t			spinlock;
@@ -260,7 +258,7 @@ static inline void etm_writel(struct etm_drvdata *drvdata,
 {
 	if (drvdata->use_cp14) {
 		if (etm_writel_cp14(off, val)) {
-			dev_err(drvdata->dev,
+			dev_err(&drvdata->csdev->dev,
 				"invalid CP14 access to ETM reg: %#x", off);
 		}
 	} else {
@@ -274,7 +272,7 @@ static inline unsigned int etm_readl(struct etm_drvdata *drvdata, u32 off)
 
 	if (drvdata->use_cp14) {
 		if (etm_readl_cp14(off, &val)) {
-			dev_err(drvdata->dev,
+			dev_err(&drvdata->csdev->dev,
 				"invalid CP14 access to ETM reg: %#x", off);
 		}
 	} else {
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index 75487b3..e8c7649 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -48,7 +48,7 @@ static ssize_t etmsr_show(struct device *dev,
 	unsigned long flags, val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
-	pm_runtime_get_sync(drvdata->dev);
+	pm_runtime_get_sync(dev->parent);
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 	CS_UNLOCK(drvdata->base);
 
@@ -56,7 +56,7 @@ static ssize_t etmsr_show(struct device *dev,
 
 	CS_LOCK(drvdata->base);
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
-	pm_runtime_put(drvdata->dev);
+	pm_runtime_put(dev->parent);
 
 	return sprintf(buf, "%#lx\n", val);
 }
@@ -131,7 +131,7 @@ static ssize_t mode_store(struct device *dev,
 
 	if (config->mode & ETM_MODE_STALL) {
 		if (!(drvdata->etmccr & ETMCCR_FIFOFULL)) {
-			dev_warn(drvdata->dev, "stall mode not supported\n");
+			dev_warn(dev, "stall mode not supported\n");
 			ret = -EINVAL;
 			goto err_unlock;
 		}
@@ -141,7 +141,7 @@ static ssize_t mode_store(struct device *dev,
 
 	if (config->mode & ETM_MODE_TIMESTAMP) {
 		if (!(drvdata->etmccer & ETMCCER_TIMESTAMP)) {
-			dev_warn(drvdata->dev, "timestamp not supported\n");
+			dev_warn(dev, "timestamp not supported\n");
 			ret = -EINVAL;
 			goto err_unlock;
 		}
@@ -945,7 +945,7 @@ static ssize_t seq_curr_state_show(struct device *dev,
 		goto out;
 	}
 
-	pm_runtime_get_sync(drvdata->dev);
+	pm_runtime_get_sync(dev->parent);
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	CS_UNLOCK(drvdata->base);
@@ -953,7 +953,7 @@ static ssize_t seq_curr_state_show(struct device *dev,
 	CS_LOCK(drvdata->base);
 
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
-	pm_runtime_put(drvdata->dev);
+	pm_runtime_put(dev->parent);
 out:
 	return sprintf(buf, "%#lx\n", val);
 }
diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index be302ec..9c92491 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -165,7 +165,7 @@ static void etm_set_prog(struct etm_drvdata *drvdata)
 	 */
 	isb();
 	if (coresight_timeout_etm(drvdata, ETMSR, ETMSR_PROG_BIT, 1)) {
-		dev_err(drvdata->dev,
+		dev_err(&drvdata->csdev->dev,
 			"%s: timeout observed when probing at offset %#x\n",
 			__func__, ETMSR);
 	}
@@ -184,7 +184,7 @@ static void etm_clr_prog(struct etm_drvdata *drvdata)
 	 */
 	isb();
 	if (coresight_timeout_etm(drvdata, ETMSR, ETMSR_PROG_BIT, 0)) {
-		dev_err(drvdata->dev,
+		dev_err(&drvdata->csdev->dev,
 			"%s: timeout observed when probing at offset %#x\n",
 			__func__, ETMSR);
 	}
@@ -425,7 +425,7 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
 done:
 	CS_LOCK(drvdata->base);
 
-	dev_dbg(drvdata->dev, "cpu: %d enable smp call done: %d\n",
+	dev_dbg(&drvdata->csdev->dev, "cpu: %d enable smp call done: %d\n",
 		drvdata->cpu, rc);
 	return rc;
 }
@@ -455,6 +455,7 @@ int etm_get_trace_id(struct etm_drvdata *drvdata)
 {
 	unsigned long flags;
 	int trace_id = -1;
+	struct device *etm_dev = drvdata->csdev->dev.parent;
 
 	if (!drvdata)
 		goto out;
@@ -462,7 +463,7 @@ int etm_get_trace_id(struct etm_drvdata *drvdata)
 	if (!local_read(&drvdata->mode))
 		return drvdata->traceid;
 
-	pm_runtime_get_sync(drvdata->dev);
+	pm_runtime_get_sync(etm_dev);
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
@@ -471,7 +472,7 @@ int etm_get_trace_id(struct etm_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
-	pm_runtime_put(drvdata->dev);
+	pm_runtime_put(etm_dev);
 
 out:
 	return trace_id;
@@ -526,7 +527,7 @@ static int etm_enable_sysfs(struct coresight_device *csdev)
 	spin_unlock(&drvdata->spinlock);
 
 	if (!ret)
-		dev_dbg(drvdata->dev, "ETM tracing enabled\n");
+		dev_dbg(&csdev->dev, "ETM tracing enabled\n");
 	return ret;
 }
 
@@ -581,7 +582,8 @@ static void etm_disable_hw(void *info)
 
 	CS_LOCK(drvdata->base);
 
-	dev_dbg(drvdata->dev, "cpu: %d disable smp call done\n", drvdata->cpu);
+	dev_dbg(&drvdata->csdev->dev,
+		"cpu: %d disable smp call done\n", drvdata->cpu);
 }
 
 static void etm_disable_perf(struct coresight_device *csdev)
@@ -628,7 +630,7 @@ static void etm_disable_sysfs(struct coresight_device *csdev)
 	spin_unlock(&drvdata->spinlock);
 	cpus_read_unlock();
 
-	dev_dbg(drvdata->dev, "ETM tracing disabled\n");
+	dev_dbg(&csdev->dev, "ETM tracing disabled\n");
 }
 
 static void etm_disable(struct coresight_device *csdev,
@@ -803,7 +805,6 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 		drvdata->use_cp14 = of_property_read_bool(np, "arm,cp14");
 	}
 
-	drvdata->dev = &adev->dev;
 	dev_set_drvdata(dev, drvdata);
 
 	/* Validity for the resource is already checked by the AMBA core */
@@ -871,7 +872,8 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 	}
 
 	pm_runtime_put(&adev->dev);
-	dev_info(dev, "%s initialized\n", (char *)coresight_get_uci_data(id));
+	dev_info(&drvdata->csdev->dev,
+		 "%s initialized\n", (char *)coresight_get_uci_data(id));
 	if (boot_enable) {
 		coresight_enable(drvdata->csdev);
 		drvdata->boot_enable = true;
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 8bb0092..77d1d83 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -88,6 +88,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 {
 	int i, rc;
 	struct etmv4_config *config = &drvdata->config;
+	struct device *etm_dev = &drvdata->csdev->dev;
 
 	CS_UNLOCK(drvdata->base);
 
@@ -102,7 +103,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 
 	/* wait for TRCSTATR.IDLE to go up */
 	if (coresight_timeout(drvdata->base, TRCSTATR, TRCSTATR_IDLE_BIT, 1))
-		dev_err(drvdata->dev,
+		dev_err(etm_dev,
 			"timeout while waiting for Idle Trace Status\n");
 
 	writel_relaxed(config->pe_sel, drvdata->base + TRCPROCSELR);
@@ -184,13 +185,13 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 
 	/* wait for TRCSTATR.IDLE to go back down to '0' */
 	if (coresight_timeout(drvdata->base, TRCSTATR, TRCSTATR_IDLE_BIT, 0))
-		dev_err(drvdata->dev,
+		dev_err(etm_dev,
 			"timeout while waiting for Idle Trace Status\n");
 
 done:
 	CS_LOCK(drvdata->base);
 
-	dev_dbg(drvdata->dev, "cpu: %d enable smp call done: %d\n",
+	dev_dbg(etm_dev, "cpu: %d enable smp call done: %d\n",
 		drvdata->cpu, rc);
 	return rc;
 }
@@ -400,7 +401,7 @@ static int etm4_enable_sysfs(struct coresight_device *csdev)
 	spin_unlock(&drvdata->spinlock);
 
 	if (!ret)
-		dev_dbg(drvdata->dev, "ETM tracing enabled\n");
+		dev_dbg(&csdev->dev, "ETM tracing enabled\n");
 	return ret;
 }
 
@@ -461,7 +462,8 @@ static void etm4_disable_hw(void *info)
 
 	CS_LOCK(drvdata->base);
 
-	dev_dbg(drvdata->dev, "cpu: %d disable smp call done\n", drvdata->cpu);
+	dev_dbg(&drvdata->csdev->dev,
+		"cpu: %d disable smp call done\n", drvdata->cpu);
 }
 
 static int etm4_disable_perf(struct coresight_device *csdev,
@@ -511,7 +513,7 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
 	spin_unlock(&drvdata->spinlock);
 	cpus_read_unlock();
 
-	dev_dbg(drvdata->dev, "ETM tracing disabled\n");
+	dev_dbg(&csdev->dev, "ETM tracing disabled\n");
 }
 
 static void etm4_disable(struct coresight_device *csdev,
@@ -1095,7 +1097,6 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 		adev->dev.platform_data = pdata;
 	}
 
-	drvdata->dev = &adev->dev;
 	dev_set_drvdata(dev, drvdata);
 
 	/* Validity for the resource is already checked by the AMBA core */
@@ -1157,7 +1158,7 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	}
 
 	pm_runtime_put(&adev->dev);
-	dev_info(dev, "CPU%d: ETM v%d.%d initialized\n",
+	dev_info(&drvdata->csdev->dev, "CPU%d: ETM v%d.%d initialized\n",
 		 drvdata->cpu, drvdata->arch >> 4, drvdata->arch & 0xf);
 
 	if (boot_enable) {
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 52786e9..4523f10 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -284,7 +284,6 @@ struct etmv4_config {
 /**
  * struct etm4_drvdata - specifics associated to an ETM component
  * @base:       Memory mapped base address for this component.
- * @dev:        The device entity associated to this component.
  * @csdev:      Component vitals needed by the framework.
  * @spinlock:   Only one at a time pls.
  * @mode:	This tracer's mode, i.e sysFS, Perf or disabled.
@@ -340,7 +339,6 @@ struct etmv4_config {
  */
 struct etmv4_drvdata {
 	void __iomem			*base;
-	struct device			*dev;
 	struct coresight_device		*csdev;
 	spinlock_t			spinlock;
 	local_t				mode;
-- 
2.7.4

