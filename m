Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA98C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D617B20679
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fqAtfhnq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389754AbfHHTb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:31:28 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:45538 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfHHTb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:31:27 -0400
Received: by mail-ua1-f73.google.com with SMTP id m2so8744580uap.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 12:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Y7EhV9R53SdAuJMBA2LVyo7uNmGfsioMNmmNCKcAKVc=;
        b=fqAtfhnqUKmEuu2DadlaluFP6n9iBHl/UJUasXOkm0OscZqXW+lwkZx/3mv3uoZhAC
         OCPXv/3lDYe+UEjV6jEFeo4T6KN6OUETZT0uxxEoo2lWtycilli1Usrk+5DmSzUszVed
         i1igcJIkNhslr9ilyPav1FckCTmCSYShPrxPm0aEbM7vtgRLnZ3thj9VWluYYoeeS8Gr
         1c8o7qcLtGfRS0KoSrh9B7/oq7YoiCI4etG0+fzmwVPtawENjcZwmgFaLNiFrQlIHgtd
         xzYY7Hzs+Jk6usoHoVh8SmSU9Pi3/dU1mJJOPJR99sH7+ItDVNNr2DZ7Vc0FK41JvSNH
         vMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Y7EhV9R53SdAuJMBA2LVyo7uNmGfsioMNmmNCKcAKVc=;
        b=iro/PzRMpwCRh0MVXqf35W9JoFZKA30ptKQjw6MXiHBFc2ZVl4urdUTd09UkncAwoU
         RtsqfrtD2Sfpr440ZrE1wgfAsBnogmpfCW0oh3f9Rq1Qr31UDxggSSFxlCsa7Fj+TARE
         4cF89WCc4WCI06ncU/N7Ex2WMS7mt5jwK2BVfsx+tV2q2KCMzcIJ2Sbx2HexWV2awsmv
         U0v+frJzfWkqOBJbFuuXWuqslGgHXetRBcPXyP0Jn9y2VymMchqpfxrtgdUvsDbvU4Qn
         J9c4bqjvzZ+S3bGd6PL2hUq+VDS6ef1FtzCruFBAVTrHNlk90jBvXi4JicHAFbOAKBMY
         9iSg==
X-Gm-Message-State: APjAAAU0Z183JvRuKb3ki5T3861zINNGGmHVZTuzt1LHLCEPmjKGfOpr
        FPZBGKsxGPWWNFDklDU7QACFAUFleA==
X-Google-Smtp-Source: APXvYqzFJnXdQ1RjWmuuNC0tPWroHzGPv2QybfWV/E4n1Fj9Gy51j8vmYrFEA/TFfcPlC3TJIO4khzTuYP0=
X-Received: by 2002:ac5:ccda:: with SMTP id j26mr6637280vkn.43.1565292686277;
 Thu, 08 Aug 2019 12:31:26 -0700 (PDT)
Date:   Thu,  8 Aug 2019 12:31:22 -0700
Message-Id: <20190808193122.76679-1-yabinc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH] coresight: tmc-etr: Remove perf_data check.
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
etm tracing also stops last. So the perf_data check is no longer valid.

Signed-off-by: Yabin Cui <yabinc@google.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 9 ---------
 drivers/hwtracing/coresight/coresight-tmc.h     | 2 --
 2 files changed, 11 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 17006705287a..0418440e0141 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1484,20 +1484,12 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
 		goto out;
 	}
 
-	if (WARN_ON(drvdata->perf_data != etr_perf)) {
-		lost = true;
-		spin_unlock_irqrestore(&drvdata->spinlock, flags);
-		goto out;
-	}
-
 	CS_UNLOCK(drvdata->base);
 
 	tmc_flush_and_stop(drvdata);
 	tmc_sync_etr_buf(drvdata);
 
 	CS_LOCK(drvdata->base);
-	/* Reset perf specific data */
-	drvdata->perf_data = NULL;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	size = etr_buf->len;
@@ -1556,7 +1548,6 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
 	}
 
 	etr_perf->head = PERF_IDX2OFF(handle->head, etr_perf);
-	drvdata->perf_data = etr_perf;
 
 	/*
 	 * No HW configuration is needed if the sink is already in
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 1ed50411cc3c..3881a9ee565a 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -178,7 +178,6 @@ struct etr_buf {
  *		device configuration register (DEVID)
  * @idr:	Holds etr_bufs allocated for this ETR.
  * @idr_mutex:	Access serialisation for idr.
- * @perf_data:	PERF buffer for ETR.
  * @sysfs_data:	SYSFS buffer for ETR.
  */
 struct tmc_drvdata {
@@ -202,7 +201,6 @@ struct tmc_drvdata {
 	struct idr		idr;
 	struct mutex		idr_mutex;
 	struct etr_buf		*sysfs_buf;
-	void			*perf_data;
 };
 
 struct etr_buf_operations {
-- 
2.22.0.770.g0f2c4a37fd-goog

