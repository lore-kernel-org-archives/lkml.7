Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87372C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 18:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5917D2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 18:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I//nl4Vn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731893AbfHOSqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 14:46:35 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:36743 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728579AbfHOSqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 14:46:35 -0400
Received: by mail-pf1-f201.google.com with SMTP id p16so2176852pfn.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 11:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KsmktdjBWzn80WIDzS6PF88MOFgM0z+buof8gWKRVNI=;
        b=I//nl4VnNITHaZ/zkdYhbwrnEzTXdxlUQRKM86qiAYedQFYdT7P9ilN9M2Vwi3ZiHL
         cWqViThiDBFJvpO9Mmn0xmyHlsXwlHGa4wn3jqVi8Tchjs6QWRwmU+qG9DOY6QLFIuEl
         VJ+c+JWIO9RpTSdEG1VZwkUaRf16zZKO/8gs2AWG3B3C7upnyFcnUnXNWMGsKJ9UZPAz
         a2PqSqvW3p/5PCBJNICnMfZVUSXI1bwdSC7bQGoQGTzaNmScjE0vzaooq1dtry7To3oV
         g9H4nclPahH5Aetv0y9pWKiyp505sW28QAVP9rmukE8tUI8thT8INp5mgqwXwaef64o0
         HjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KsmktdjBWzn80WIDzS6PF88MOFgM0z+buof8gWKRVNI=;
        b=dInuXU7jABCNbiwRT8LRDfDZPM79WxW855gf/XL/SCjY8ktBooWDISonc0VEmYfz49
         1mbFJV2xNonvNlC94gzOiiROKPts88JhLlinLLYphrsC5Ppae3HjjQGHwZPjLa9Bn/go
         iHdgGxW6/W3NJbAkkAA3G4dfgYOMM/f5cgJ4de1HpmyrSA5elE20Eumi2Vsin84vqt0U
         ysLpJcXb7Mo+w1Fw0HDAlk/zRDzAAJCV/jN10lnuwX2aAWtcBQkCVJLh1xKux6WQ6n6Z
         fwFmsU1p39WDyyB5l/s4tI7csqIQvWWva9wkmxXDbiAg2xanVuM5vzmYvf4dwYgInegi
         5KKQ==
X-Gm-Message-State: APjAAAXfLeGZ63UWCW5m8VkqEI22OY5yuaFePc6g28xaQU1YeslFLGK1
        G2LUeelqpoMcVDhSeBUs6wvOrVyZsQ==
X-Google-Smtp-Source: APXvYqx/4reP5xWBNNvhkbTIbQc7Zy6AQSY3Q6ZpX+/WKuWIJqhPsTzfuM9MuEyMM9sEMlpjic8OwTRm5Jw=
X-Received: by 2002:a65:57ca:: with SMTP id q10mr4745823pgr.52.1565894793853;
 Thu, 15 Aug 2019 11:46:33 -0700 (PDT)
Date:   Thu, 15 Aug 2019 11:46:28 -0700
Message-Id: <20190815184628.183186-1-yabinc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v3] coresight: tmc-etr: Fix perf_data check.
From:   Yabin Cui <yabinc@google.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When tracing etm data of multiple threads on multiple cpus through
perf interface, each cpu has a unique etr_perf_buffer while sharing
the same etr device. There is no guarantee that the last cpu starts
etm tracing also stops last. This makes perf_data check fail.

Fix it by checking etr_buf instead of etr_perf_buffer.
Also move the code setting and clearing perf_buf to more suitable
places.

Fixes: 3147da92a8a8 ("coresight: tmc-etr: Allocate and free ETR memory buffers for CPU-wide scenarios")
Signed-off-by: Yabin Cui <yabinc@google.com>
---

v2 -> v3:
  moved place of setting drvdata->perf_buf based on review comment.
  Also moved place of clearing drvdata->perf_buf from
  tmc_update_etr_buffer() to tmc_disable_etr_sink() for below
  situation:

  cpu 0 enable etr device (set perf_buf)
  cpu 0 update etr buffer (clear perf_buf)
  cpu 1 enable etr device (perf_buf isn't set because pid set by cpu 0)
  cpu 0 disable etr device
  cpu 1 update etr buffer (perf_buf == NULL, check fails)

  To fix it, we need to move clearing perf_buf to the disable function.

---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 8 ++++----
 drivers/hwtracing/coresight/coresight-tmc.h     | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 17006705287a..80af313f55d7 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1484,7 +1484,7 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
 		goto out;
 	}
 
-	if (WARN_ON(drvdata->perf_data != etr_perf)) {
+	if (WARN_ON(drvdata->perf_buf != etr_buf)) {
 		lost = true;
 		spin_unlock_irqrestore(&drvdata->spinlock, flags);
 		goto out;
@@ -1496,8 +1496,6 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
 	tmc_sync_etr_buf(drvdata);
 
 	CS_LOCK(drvdata->base);
-	/* Reset perf specific data */
-	drvdata->perf_data = NULL;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	size = etr_buf->len;
@@ -1556,7 +1554,6 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
 	}
 
 	etr_perf->head = PERF_IDX2OFF(handle->head, etr_perf);
-	drvdata->perf_data = etr_perf;
 
 	/*
 	 * No HW configuration is needed if the sink is already in
@@ -1572,6 +1569,7 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
 		/* Associate with monitored process. */
 		drvdata->pid = pid;
 		drvdata->mode = CS_MODE_PERF;
+		drvdata->perf_buf = etr_perf->etr_buf;
 		atomic_inc(csdev->refcnt);
 	}
 
@@ -1617,6 +1615,8 @@ static int tmc_disable_etr_sink(struct coresight_device *csdev)
 	/* Dissociate from monitored process. */
 	drvdata->pid = -1;
 	drvdata->mode = CS_MODE_DISABLED;
+	/* Reset perf specific data */
+	drvdata->perf_buf = NULL;
 
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 1ed50411cc3c..f9a0c95e9ba2 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -178,8 +178,8 @@ struct etr_buf {
  *		device configuration register (DEVID)
  * @idr:	Holds etr_bufs allocated for this ETR.
  * @idr_mutex:	Access serialisation for idr.
- * @perf_data:	PERF buffer for ETR.
- * @sysfs_data:	SYSFS buffer for ETR.
+ * @sysfs_buf:	SYSFS buffer for ETR.
+ * @perf_buf:	PERF buffer for ETR.
  */
 struct tmc_drvdata {
 	void __iomem		*base;
@@ -202,7 +202,7 @@ struct tmc_drvdata {
 	struct idr		idr;
 	struct mutex		idr_mutex;
 	struct etr_buf		*sysfs_buf;
-	void			*perf_data;
+	struct etr_buf		*perf_buf;
 };
 
 struct etr_buf_operations {
-- 
2.23.0.rc1.153.gdeed80330f-goog

