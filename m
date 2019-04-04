Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676D9C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D7F2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ERgmuMK6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfDDDgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:36:13 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34027 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfDDDgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:36:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id y6so448965plt.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 20:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3+2cx7RrzPvZOqOGF36avSO6d1PHCsF4iGdLwbSh4LE=;
        b=ERgmuMK6xtWdmPD77jb17SIuH6rwSvs2w3Qpv8JWfJPgF88AIpxO8MJ0BXlIqZX56j
         OPzGJ8StKQORS/ASrMXlTBO4x3Ay/5xn36Wc4OQJEsM+TY9597OYieZIAcK0CmgkDSB7
         zdVoLUZ4DIhCWE2K/X5nhhjBnFmYRTLDBvUhvRq+H5JZFScBkkt9ho9x9+tv3xw6L94R
         Lx5H6/EE9QTFPodzqDrE4Hl+C/1z0+Q1JOQR2hfzL8OG6iwclAh2rWW9IZl/7/cyKzDN
         d3lQE2YI+Gjffha2gtNdm2xAXtH16nfR2nS0iGrKMp4oM3tj6Pk6KoxlJdE8hkJOzODQ
         FA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3+2cx7RrzPvZOqOGF36avSO6d1PHCsF4iGdLwbSh4LE=;
        b=q/eeljb1rHyTFYyPg7Meb3oD3ZdqmKID5u+Xni615ZdWMjkXnhaOyfUPEUM3qONld9
         Csuri30mDDY+of3NW0g/8XZtdbk03knEdh0KugIjGF4VRV3GQ4xXNt9bSyjBBcobNNZ8
         OUT042kRUM9pT4pLvpD32ahg+0XsDAF142DekZfVISinKd0Dltw5RLzDb0l0lmDqsoWl
         U08JXXL9gjJdhqH1SgNHk43i/IJagZWnTTVYtf0DsiZR/q8nR2ce2vKHVOhhkYwlIDpk
         Pg0mP/l4IDxFKm9PbpE0lslRVEX58GLC1zPZeKJZ74X3atHA661UUq6Dr2qmMW5wZB7n
         02SQ==
X-Gm-Message-State: APjAAAWKQdrqFMWTC2oAmn6Z3mMjIxG0UhHbpewlCsTLUKEI+JxjqUin
        SqlOtPdn2yB5dxxsgpFcHiMXoA==
X-Google-Smtp-Source: APXvYqxJGYSn60DLijBbjVtqgh2z8TRAgV9KHO48zZwUhsyoq0d7oIQBZehENeaN78hF5nJWCwQp5Q==
X-Received: by 2002:a17:902:b407:: with SMTP id x7mr3965336plr.288.1554348971027;
        Wed, 03 Apr 2019 20:36:11 -0700 (PDT)
Received: from xps15.imgcgcw.net ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id u5sm12212780pfm.121.2019.04.03.20.36.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 20:36:10 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        suzuki.poulose@arm.com, mike.leach@arm.com, leo.yan@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/20] coresight: Move reference counting inside sink drivers
Date:   Wed,  3 Apr 2019 21:35:27 -0600
Message-Id: <20190404033541.14072-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190404033541.14072-1-mathieu.poirier@linaro.org>
References: <20190404033541.14072-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When operating in CPU-wide mode with an N:1 source/sink HW topology,
multiple CPUs can access a sink concurrently.  As such reference counting
needs to happen when the device's spinlock is held to avoid racing with
other operations (start(), update(), stop()), such as:

session A				Session B
-----					-------

enable_sink
atomic_inc(refcount)  = 1

...

atomic_dec(refcount) = 0		enable_sink
if (refcount == 0) disable_sink
					atomic_inc()

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 21 ++++++++++----
 .../hwtracing/coresight/coresight-tmc-etf.c   | 21 +++++++++++---
 .../hwtracing/coresight/coresight-tmc-etr.c   | 19 +++++++++++--
 drivers/hwtracing/coresight/coresight-tpiu.c  |  6 +++-
 drivers/hwtracing/coresight/coresight.c       | 28 +++++++++----------
 5 files changed, 66 insertions(+), 29 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 71c2a3cdb866..5af50a852e87 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -5,6 +5,7 @@
  * Description: CoreSight Embedded Trace Buffer driver
  */
 
+#include <linux/atomic.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/types.h>
@@ -159,14 +160,15 @@ static int etb_enable_sysfs(struct coresight_device *csdev)
 		goto out;
 	}
 
-	/* Nothing to do, the tracer is already enabled. */
-	if (drvdata->mode == CS_MODE_SYSFS)
-		goto out;
+	if (drvdata->mode == CS_MODE_DISABLED) {
+		ret = etb_enable_hw(drvdata);
+		if (ret)
+			goto out;
 
-	ret = etb_enable_hw(drvdata);
-	if (!ret)
 		drvdata->mode = CS_MODE_SYSFS;
+	}
 
+	atomic_inc(csdev->refcnt);
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 	return ret;
@@ -196,8 +198,10 @@ static int etb_enable_perf(struct coresight_device *csdev, void *data)
 		goto out;
 
 	ret = etb_enable_hw(drvdata);
-	if (!ret)
+	if (!ret) {
 		drvdata->mode = CS_MODE_PERF;
+		atomic_inc(csdev->refcnt);
+	}
 
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
@@ -332,6 +336,11 @@ static int etb_disable(struct coresight_device *csdev)
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
+	if (atomic_dec_return(csdev->refcnt)) {
+		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		return -EBUSY;
+	}
+
 	/* Disable the ETB only if it needs to */
 	if (drvdata->mode != CS_MODE_DISABLED) {
 		etb_disable_hw(drvdata);
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index d4213e7c2c45..d50a608a60f1 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -4,6 +4,7 @@
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
  */
 
+#include <linux/atomic.h>
 #include <linux/circ_buf.h>
 #include <linux/coresight.h>
 #include <linux/perf_event.h>
@@ -180,8 +181,10 @@ static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev)
 	 * sink is already enabled no memory is needed and the HW need not be
 	 * touched.
 	 */
-	if (drvdata->mode == CS_MODE_SYSFS)
+	if (drvdata->mode == CS_MODE_SYSFS) {
+		atomic_inc(csdev->refcnt);
 		goto out;
+	}
 
 	/*
 	 * If drvdata::buf isn't NULL, memory was allocated for a previous
@@ -200,11 +203,13 @@ static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev)
 	}
 
 	ret = tmc_etb_enable_hw(drvdata);
-	if (!ret)
+	if (!ret) {
 		drvdata->mode = CS_MODE_SYSFS;
-	else
+		atomic_inc(csdev->refcnt);
+	} else {
 		/* Free up the buffer if we failed to enable */
 		used = false;
+	}
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
@@ -239,8 +244,10 @@ static int tmc_enable_etf_sink_perf(struct coresight_device *csdev, void *data)
 		if (ret)
 			break;
 		ret  = tmc_etb_enable_hw(drvdata);
-		if (!ret)
+		if (!ret) {
 			drvdata->mode = CS_MODE_PERF;
+			atomic_inc(csdev->refcnt);
+		}
 	} while (0);
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
@@ -279,11 +286,17 @@ static int tmc_disable_etf_sink(struct coresight_device *csdev)
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
+
 	if (drvdata->reading) {
 		spin_unlock_irqrestore(&drvdata->spinlock, flags);
 		return -EBUSY;
 	}
 
+	if (atomic_dec_return(csdev->refcnt)) {
+		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		return -EBUSY;
+	}
+
 	/* Disable the TMC only if it needs to */
 	if (drvdata->mode != CS_MODE_DISABLED) {
 		tmc_etb_disable_hw(drvdata);
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 33501777038a..f90bca971367 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -4,6 +4,7 @@
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
  */
 
+#include <linux/atomic.h>
 #include <linux/coresight.h>
 #include <linux/dma-mapping.h>
 #include <linux/iommu.h>
@@ -1124,8 +1125,10 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 	 * sink is already enabled no memory is needed and the HW need not be
 	 * touched, even if the buffer size has changed.
 	 */
-	if (drvdata->mode == CS_MODE_SYSFS)
+	if (drvdata->mode == CS_MODE_SYSFS) {
+		atomic_inc(csdev->refcnt);
 		goto out;
+	}
 
 	/*
 	 * If we don't have a buffer or it doesn't match the requested size,
@@ -1138,8 +1141,10 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 	}
 
 	ret = tmc_etr_enable_hw(drvdata, drvdata->sysfs_buf);
-	if (!ret)
+	if (!ret) {
 		drvdata->mode = CS_MODE_SYSFS;
+		atomic_inc(csdev->refcnt);
+	}
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
@@ -1370,8 +1375,10 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
 	etr_perf->head = PERF_IDX2OFF(handle->head, etr_perf);
 	drvdata->perf_data = etr_perf;
 	rc = tmc_etr_enable_hw(drvdata, etr_perf->etr_buf);
-	if (!rc)
+	if (!rc) {
 		drvdata->mode = CS_MODE_PERF;
+		atomic_inc(csdev->refcnt);
+	}
 
 unlock_out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
@@ -1398,11 +1405,17 @@ static int tmc_disable_etr_sink(struct coresight_device *csdev)
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
+
 	if (drvdata->reading) {
 		spin_unlock_irqrestore(&drvdata->spinlock, flags);
 		return -EBUSY;
 	}
 
+	if (atomic_dec_return(csdev->refcnt)) {
+		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		return -EBUSY;
+	}
+
 	/* Disable the TMC only if it needs to */
 	if (drvdata->mode != CS_MODE_DISABLED) {
 		tmc_etr_disable_hw(drvdata);
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 0d13da1b9df1..7acbeffcc137 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -5,6 +5,7 @@
  * Description: CoreSight Trace Port Interface Unit driver
  */
 
+#include <linux/atomic.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/device.h>
@@ -73,7 +74,7 @@ static int tpiu_enable(struct coresight_device *csdev, u32 mode, void *__unused)
 	struct tpiu_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
 	tpiu_enable_hw(drvdata);
-
+	atomic_inc(csdev->refcnt);
 	dev_dbg(drvdata->dev, "TPIU enabled\n");
 	return 0;
 }
@@ -98,6 +99,9 @@ static int tpiu_disable(struct coresight_device *csdev)
 {
 	struct tpiu_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
+	if (atomic_dec_return(csdev->refcnt))
+		return -EBUSY;
+
 	tpiu_disable_hw(drvdata);
 
 	dev_dbg(drvdata->dev, "TPIU disabled\n");
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 13eda4693f81..19ba121d7451 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -225,14 +225,13 @@ static int coresight_enable_sink(struct coresight_device *csdev,
 	 * We need to make sure the "new" session is compatible with the
 	 * existing "mode" of operation.
 	 */
-	if (sink_ops(csdev)->enable) {
-		ret = sink_ops(csdev)->enable(csdev, mode, data);
-		if (ret)
-			return ret;
-		csdev->enable = true;
-	}
+	if (!sink_ops(csdev)->enable)
+		return -EINVAL;
 
-	atomic_inc(csdev->refcnt);
+	ret = sink_ops(csdev)->enable(csdev, mode, data);
+	if (ret)
+		return ret;
+	csdev->enable = true;
 
 	return 0;
 }
@@ -241,14 +240,13 @@ static void coresight_disable_sink(struct coresight_device *csdev)
 {
 	int ret;
 
-	if (atomic_dec_return(csdev->refcnt) == 0) {
-		if (sink_ops(csdev)->disable) {
-			ret = sink_ops(csdev)->disable(csdev);
-			if (ret)
-				return;
-			csdev->enable = false;
-		}
-	}
+	if (!sink_ops(csdev)->disable)
+		return;
+
+	ret = sink_ops(csdev)->disable(csdev);
+	if (ret)
+		return;
+	csdev->enable = false;
 }
 
 static int coresight_enable_link(struct coresight_device *csdev,
-- 
2.17.1

