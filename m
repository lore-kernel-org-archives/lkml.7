Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1D6C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2C02171F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="me0reGUH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbfDDDhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:37:01 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38479 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbfDDDg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:36:59 -0400
Received: by mail-pl1-f196.google.com with SMTP id g37so439190plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 20:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sdDt/HRF6MLGkuxtGtaVQsmhDK4+MNWevaRbT+jK8kU=;
        b=me0reGUHzjAiArUnM1m+8nwEBbmaHHIkK5QeHwjSxqEanx5sievn47DGQJOzluk7Yz
         K/wE+zAXLVZX25JzVwlb8I5DF7VoNep4JqOUhiEF6tKVxTglGMTWSx/2kOtKMRZGWWtU
         rWrGYYloH9wHtFC95pVDFDURHy5sWe5YpMK8noldYig6bHLwrX28/gnwoCfxbTPWKZrV
         wvLOpaiEh2v2HCbgfAr3HILmumCUA+Ur6oXsqnZO+uqgtmQBQ9+rFGJkjfHkdk6fJUoF
         LbkT9VmGoSqTCA7EQzoUYilV+6+7HCrBzOEMvWLp0f/vqap4uXJOqY7/b1erSZv/7/jN
         VgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sdDt/HRF6MLGkuxtGtaVQsmhDK4+MNWevaRbT+jK8kU=;
        b=TPysirmqNSjkSAlAisOgwddkvGFh5Jjyk+qmY89r9jLPUbDjX4dlyxaTkw0Fm5rtfJ
         8bs8n6rLLh477jCeSbTMREtbfEceHrK/EZLrDOQgOdlPW1E/2ZsTopymcirYLMjuAVK2
         78mk0O6BP98S6G1iorqRf9GYCPxZtqtCcB5T7FRMHjrh5yek0vX/rge5kzcOPqFv9uls
         lR5IslUcbpYLg9Ly5hcGY9E5Zj+gS3klSDC5i4ixmS7DOAGJQW9Wq9t2nMSXIdzOeOTR
         SXr9R106OmiLULAV2bwD4E/4apLBP/s7EPfY34GjKZIHc4RciXe6sBNmm2hW5C3kuMF/
         vDDg==
X-Gm-Message-State: APjAAAVa1PVGXM7D5gprMGoBJPsSrNPvsIsYwp13StIAVn2LRMGIBhu8
        dzP2EaJtGhTPQ4F2JWIMhdvnnA==
X-Google-Smtp-Source: APXvYqyK4MW2ELDtAddGQj/FriWe6wE+DJubczgxcSwbaMAob3whBlTlbA1CQ+CxPP+qJ7oQEL41dA==
X-Received: by 2002:a17:902:7c8c:: with SMTP id y12mr3808185pll.209.1554349018449;
        Wed, 03 Apr 2019 20:36:58 -0700 (PDT)
Received: from xps15.imgcgcw.net ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id u5sm12212780pfm.121.2019.04.03.20.36.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 20:36:57 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        suzuki.poulose@arm.com, mike.leach@arm.com, leo.yan@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 19/20] coresight: tmc-etf: Add support for CPU-wide trace scenarios
Date:   Wed,  3 Apr 2019 21:35:40 -0600
Message-Id: <20190404033541.14072-20-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190404033541.14072-1-mathieu.poirier@linaro.org>
References: <20190404033541.14072-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for CPU-wide trace scenarios by making sure that
only the sources monitoring the same process have access to a common sink.
Because the sink is shared between sources, the first source to use the
sink switches it on while the last one does the cleanup.  Any attempt to
modify the HW is overlooked for as long as more than one source is using
a sink.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../hwtracing/coresight/coresight-tmc-etf.c   | 40 ++++++++++++++++---
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 1df1f8fade71..2527b5d3b65e 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -223,6 +223,7 @@ static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev)
 static int tmc_enable_etf_sink_perf(struct coresight_device *csdev, void *data)
 {
 	int ret = 0;
+	pid_t pid;
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	struct perf_output_handle *handle = data;
@@ -233,18 +234,39 @@ static int tmc_enable_etf_sink_perf(struct coresight_device *csdev, void *data)
 		if (drvdata->reading)
 			break;
 		/*
-		 * In Perf mode there can be only one writer per sink.  There
-		 * is also no need to continue if the ETB/ETF is already
-		 * operated from sysFS.
+		 * No need to continue if the ETB/ETF is already operated
+		 * from sysFS.
 		 */
-		if (drvdata->mode != CS_MODE_DISABLED)
+		if (drvdata->mode == CS_MODE_SYSFS) {
+			ret = -EBUSY;
 			break;
+		}
+
+		/* Get a handle on the pid of the process to monitor */
+		pid = task_pid_nr(handle->event->owner);
+
+		if (drvdata->pid != -1 && drvdata->pid != pid) {
+			ret = -EBUSY;
+			break;
+		}
 
 		ret = tmc_set_etf_buffer(csdev, handle);
 		if (ret)
 			break;
+
+		/*
+		 * No HW configuration is needed if the sink is already in
+		 * use for this session.
+		 */
+		if (drvdata->pid == pid) {
+			atomic_inc(csdev->refcnt);
+			break;
+		}
+
 		ret  = tmc_etb_enable_hw(drvdata);
 		if (!ret) {
+			/* Associate with monitored process. */
+			drvdata->pid = pid;
 			drvdata->mode = CS_MODE_PERF;
 			atomic_inc(csdev->refcnt);
 		}
@@ -300,6 +322,8 @@ static int tmc_disable_etf_sink(struct coresight_device *csdev)
 	/* Complain if we (somehow) got out of sync */
 	WARN_ON_ONCE(drvdata->mode == CS_MODE_DISABLED);
 	tmc_etb_disable_hw(drvdata);
+	/* Dissociate from monitored process. */
+	drvdata->pid = -1;
 	drvdata->mode = CS_MODE_DISABLED;
 
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
@@ -414,7 +438,7 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
 	u32 *buf_ptr;
 	u64 read_ptr, write_ptr;
 	u32 status;
-	unsigned long offset, to_read, flags;
+	unsigned long offset, to_read = 0, flags;
 	struct cs_buffers *buf = sink_config;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
@@ -426,6 +450,11 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
 		return 0;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
+
+	/* Don't do anything if another tracer is using this sink */
+	if (atomic_read(csdev->refcnt) != 1)
+		goto out;
+
 	CS_UNLOCK(drvdata->base);
 
 	tmc_flush_and_stop(drvdata);
@@ -519,6 +548,7 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
 		to_read = buf->nr_pages << PAGE_SHIFT;
 	}
 	CS_LOCK(drvdata->base);
+out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	return to_read;
-- 
2.17.1

