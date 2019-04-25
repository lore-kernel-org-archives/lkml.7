Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3046C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF28206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lkHbi3W6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfDYTzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:55:01 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41534 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729716AbfDYTxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:53:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id f6so359666pgs.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M9LNb8Y8HxxjyFFNvp7kAAIIQICkk54j2eh/SijJPGQ=;
        b=lkHbi3W6u8FC6opjaINUOdW90x6weygCYdhi6960nebUnhMu13tPrTNrSd2FazsLcC
         8RRL3fZ5doxNfz4A3dHFtaLq+JIUr2I/mGXE1JX+nEv4P+u/95fknFG0iLqjYA63+fEK
         pVNr3UMJ3UZNhMV77QQ3R5bOyrxogQBZlbH6XWv2qadhHv1WeVpC1BcWOSOjeYF+DDoo
         EGMfwYq6KMXYxEOsUJPOI3Z7GSHU6QBowC60rOifKaAvGrowAu3WORfchpp6N+uHe72V
         6BU3eKCVHL7JdPCikwQrznFFgXucn7dplsySsaQVq3vi7eUK3KKhovyyCbb1bPYVu65U
         RHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M9LNb8Y8HxxjyFFNvp7kAAIIQICkk54j2eh/SijJPGQ=;
        b=DPN0IGIt7BuNvdwKybyrlOQv8To/xAqXNvwPoTzVuOXk0LHzIkZA4bTZhkLVYUXfBK
         6YUk/SUdlJmU4q7Z0uxQaBu9kg4QHNb8MJkoo7Ko7emCwUedQIRMYUEMDf3Nafmee/aI
         Z+tQ5xYFdvPtd2V5AOa3Bk/L29cUkVj369lYDjbNbY6pJQ32oL6tjNoIKJTDBfdugInE
         /Irgyi10cNlwApLjKE3p+PCLi9bdvTbUV0x/tC9mcnPqs33VCkELDp3oEgFP2IkJNlwC
         Xl18//SEyDnfc9ABk42tXU4ggBPgD0wXei+Bta22vBEygQfve+tuvbC14saprDNhMCPb
         65kg==
X-Gm-Message-State: APjAAAVzDQ7jMnLLH4K38Ib7RS/qU8pB7XH5VagrAnzWRDFoGo7/Awpa
        uZBfuXGxKmyjolM+ppTjXPJNNB0cm/Y=
X-Google-Smtp-Source: APXvYqxGKxvXi2+ZtjZ8djIs9Dw2Nl0ZBq3nuyPfbh+WQJuPSDWSJUCAxkoAzmTGzM2jMMuy+ZW64Q==
X-Received: by 2002:a63:c54e:: with SMTP id g14mr39012364pgd.265.1556222016039;
        Thu, 25 Apr 2019 12:53:36 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t64sm47261961pfa.86.2019.04.25.12.53.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:53:34 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 18/32] coresight: Move reference counting inside sink drivers
Date:   Thu, 25 Apr 2019 13:52:56 -0600
Message-Id: <20190425195310.31562-19-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425195310.31562-1-mathieu.poirier@linaro.org>
References: <20190425195310.31562-1-mathieu.poirier@linaro.org>
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
Tested-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Robert Walker <robert.walker@arm.com>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 21 ++++++++++----
 .../hwtracing/coresight/coresight-tmc-etf.c   | 21 +++++++++++---
 .../hwtracing/coresight/coresight-tmc-etr.c   | 19 +++++++++++--
 drivers/hwtracing/coresight/coresight-tpiu.c  |  6 +++-
 drivers/hwtracing/coresight/coresight.c       | 28 +++++++++----------
 5 files changed, 66 insertions(+), 29 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 23b049cef19a..8e63863cf950 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -5,6 +5,7 @@
  * Description: CoreSight Embedded Trace Buffer driver
  */
 
+#include <linux/atomic.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/types.h>
@@ -151,14 +152,15 @@ static int etb_enable_sysfs(struct coresight_device *csdev)
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
@@ -188,8 +190,10 @@ static int etb_enable_perf(struct coresight_device *csdev, void *data)
 		goto out;
 
 	ret = etb_enable_hw(drvdata);
-	if (!ret)
+	if (!ret) {
 		drvdata->mode = CS_MODE_PERF;
+		atomic_inc(csdev->refcnt);
+	}
 
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
@@ -324,6 +328,11 @@ static int etb_disable(struct coresight_device *csdev)
 
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
index c6a0f5897684..6a8f39d03de3 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -4,6 +4,7 @@
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
  */
 
+#include <linux/atomic.h>
 #include <linux/coresight.h>
 #include <linux/dma-mapping.h>
 #include <linux/iommu.h>
@@ -1125,8 +1126,10 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
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
@@ -1139,8 +1142,10 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 	}
 
 	ret = tmc_etr_enable_hw(drvdata, drvdata->sysfs_buf);
-	if (!ret)
+	if (!ret) {
 		drvdata->mode = CS_MODE_SYSFS;
+		atomic_inc(csdev->refcnt);
+	}
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
@@ -1371,8 +1376,10 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
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
@@ -1399,11 +1406,17 @@ static int tmc_disable_etr_sink(struct coresight_device *csdev)
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
index c1b77e3c3187..63d9af31f57f 100644
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
index 66c25b0a785e..4b130281236a 100644
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

