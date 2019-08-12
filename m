Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500A5C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 19:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A35520684
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 19:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q9RDmDO2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfHLTDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 15:03:51 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:51268 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfHLTDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 15:03:51 -0400
Received: by mail-pl1-f201.google.com with SMTP id p9so2641905pls.18
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 12:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=mVRG9jasrEKg9xmOyrLCCjteMMsk/r5mx76vPr6ubzk=;
        b=q9RDmDO2fkCI9Qt4DsOTQzVOLjfIiL+630cF1AohLv94Zttj87byDozSTNIzJdDFxS
         65LIrJBSWoWIPgg8HLw/Ibe+hpcR8l860eYDAMrCTN2mb4YifgWxGfgc/kIDQv3PjPOz
         1U1OI8q9EVNzl8XvJQmH4CaIptQ7UoukxN2XN+Q+KCZjNfIQ9ARbxFyTmRsVbN4FwiYu
         voOTvcr1jxQtiSrDxs8xdjQpdwIUxlAMT223sLKDhHO0pgWClDkk4F5cymxcnYlxVGr0
         0DQFGhVkujomhJzVwjuMSmGKkJnfhefJkUR2W2ih5Ct9N7PXTcL+3/i4ELl5X3y1Mekm
         hJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=mVRG9jasrEKg9xmOyrLCCjteMMsk/r5mx76vPr6ubzk=;
        b=K/iy8QuzmZJ2uSICFy1Hd9A3xhZbvxfFr3goCvZGCRHuT6KirEo/TSrMjqozEKErJ6
         SWhCE2wFOd06RALd08YC/HNbu2WP43vS86v0/1J2LoKkYHSFxKtbQhTzbYRWTE1weylD
         EtjoYS/R5u53jMjde/ndVvOSfb+5bl8pzApY9oDZV3eeP2bSSUrpoTBL08WLDJhrjOOZ
         5lXORgqLljirjLBlbSWlkdbbcinxrK+xzUJSOI/VE+KM1ReRa5Fd8/XZ0dcM8GdiEJGm
         rz3Et9aju/PBQsKOo4iI1Yk+qOSOr8Z9c5OUbVtcmjzRc3Xa/wWgmCgsRgs3nNFHrag/
         Jkgw==
X-Gm-Message-State: APjAAAUWsjRPBZvssqKqJh5HZDacQnXeciKIFzqH9Mt0KlimTNXug/7V
        Ao75lpj7FgxrjHuVqxTE3rVoIq7iYw==
X-Google-Smtp-Source: APXvYqz+0C+mFFgI8Q0CX89fBw1s6PY8DPzBB4RvD1+6OQmtwxJjFOgwhNgfAUl1lKyUt/SLCVegv6dY++0=
X-Received: by 2002:a63:89c2:: with SMTP id v185mr31231727pgd.241.1565636630566;
 Mon, 12 Aug 2019 12:03:50 -0700 (PDT)
Date:   Mon, 12 Aug 2019 12:03:20 -0700
Message-Id: <20190812190320.209988-1-yabinc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v2] coresight: tmc-etr: Fix perf_data check.
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

Fixes: 3147da92a8a8 ("coresight: tmc-etr: Allocate and free ETR memory buffers for CPU-wide scenarios")
Signed-off-by: Yabin Cui <yabinc@google.com>
---

v1 -> v2: rename perf_data to perf_buf. Add fixes tag.

---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 6 +++---
 drivers/hwtracing/coresight/coresight-tmc.h     | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 17006705287a..90d1548ad268 100644
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
@@ -1497,7 +1497,7 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
 
 	CS_LOCK(drvdata->base);
 	/* Reset perf specific data */
-	drvdata->perf_data = NULL;
+	drvdata->perf_buf = NULL;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	size = etr_buf->len;
@@ -1556,7 +1556,7 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
 	}
 
 	etr_perf->head = PERF_IDX2OFF(handle->head, etr_perf);
-	drvdata->perf_data = etr_perf;
+	drvdata->perf_buf = etr_perf->etr_buf;
 
 	/*
 	 * No HW configuration is needed if the sink is already in
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

