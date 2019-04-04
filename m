Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D61C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89CB22171F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p5ap4iba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfDDDg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:36:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33881 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728671AbfDDDg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:36:56 -0400
Received: by mail-pf1-f193.google.com with SMTP id b3so636348pfd.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 20:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LudRC9TQK4HNLvQvknqLAVG3xxx86t5omiW1jcpQn7M=;
        b=p5ap4ibaWa2YMJgeLjUNn2YMG/1OP1OdJICTAiBIXN8oy4cPKJ51Jd9kOgaA4wY3/x
         pp3Du9fIrKogx0dYSHz5wkHkBeWvIOYrNJ54wwWHiCwo2AnCRQjvV5L/oKWlTrL6M06e
         sxquML1M0yOl5NfRz5fQN0Vn6538pwN+786rBqo2JJfOmVE5vnbYdWrvPE7CEvmdFtQE
         Y3iyYDLa+rQV5dsqGUtO+VzodR7R6CZVjq+sIlhfMLNwv1HzYaFmkH5KS4WvPROLmDGV
         IowW/KPSopknMq0CmQGY1mEsq5R+0/V2HD/eFxOSPS/dJWA6bWk/d94S+RwISxwbZp+E
         yJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LudRC9TQK4HNLvQvknqLAVG3xxx86t5omiW1jcpQn7M=;
        b=cOhPwQFtd3KUtiplxqXjV20z0zKCWVxkiGHLQWtVz20V4m2vlWQuKFfjazdOYR1wM2
         sjl6QBF0E4gSbsOONMY8nXK3O6TZpfkYpTNQnK2/r2lg7qxyqCt1oYJQUS6FzYc7Lp0R
         JOOyfyDjqJb/jsAWrkeWK9w6LWli1ML+2Pf94J7x3CUrzQkqLcOitcWVF31LxPeOim2S
         kwTPmlyRHIrCov0HKf7/fTDtfmzv2UgWDHvteOq0B8Qnwb1tqKzrcDhZmEQKIXleoGDx
         S1cYPBUJgUXVZxGc2/iA4QaMTG5WZGTsm/thCV7y5Heck3zOw4vfxtphWJI9D0TEl+nI
         veNQ==
X-Gm-Message-State: APjAAAWZQNOiPFMfMjst6nVyWi7XFaDSIN0c8yX8EgxZbWkJChMH6bt7
        aWjApW9ge74VZN/hNx7pZUsEAQ==
X-Google-Smtp-Source: APXvYqyWtaDRUkI7E51SZkIw6nNMwUGRIn9GPjmjSfHKhkdgoSLfqdmkYEa/D81ozG+zhNjzgSH0qA==
X-Received: by 2002:a65:47c6:: with SMTP id f6mr3400010pgs.173.1554349014940;
        Wed, 03 Apr 2019 20:36:54 -0700 (PDT)
Received: from xps15.imgcgcw.net ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id u5sm12212780pfm.121.2019.04.03.20.36.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 20:36:54 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        suzuki.poulose@arm.com, mike.leach@arm.com, leo.yan@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 18/20] coresight: tmc-etr: Add support for CPU-wide trace scenarios
Date:   Wed,  3 Apr 2019 21:35:39 -0600
Message-Id: <20190404033541.14072-19-mathieu.poirier@linaro.org>
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
 .../hwtracing/coresight/coresight-tmc-etr.c   | 38 ++++++++++++++++---
 drivers/hwtracing/coresight/coresight-tmc.c   |  2 +
 drivers/hwtracing/coresight/coresight-tmc.h   |  3 ++
 3 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 61110ef41d00..a91c1bc17e2d 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1473,6 +1473,13 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
 	struct etr_buf *etr_buf = etr_perf->etr_buf;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
+
+	/* Don't do anything if another tracer is using this sink */
+	if (atomic_read(csdev->refcnt) != 1) {
+		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		goto out;
+	}
+
 	if (WARN_ON(drvdata->perf_data != etr_perf)) {
 		lost = true;
 		spin_unlock_irqrestore(&drvdata->spinlock, flags);
@@ -1512,17 +1519,15 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
 static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
 {
 	int rc = 0;
+	pid_t pid;
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	struct perf_output_handle *handle = data;
 	struct etr_perf_buffer *etr_perf = etm_perf_sink_config(handle);
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
-	/*
-	 * There can be only one writer per sink in perf mode. If the sink
-	 * is already open in SYSFS mode, we can't use it.
-	 */
-	if (drvdata->mode != CS_MODE_DISABLED || WARN_ON(drvdata->perf_data)) {
+	 /* Don't use this sink if it is already claimed by sysFS */
+	if (drvdata->mode == CS_MODE_SYSFS) {
 		rc = -EBUSY;
 		goto unlock_out;
 	}
@@ -1532,10 +1537,31 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
 		goto unlock_out;
 	}
 
+	/* Get a handle on the pid of the process to monitor */
+	pid = etr_perf->pid;
+
+	/* Do not proceed if this device is associated with another session */
+	if (drvdata->pid != -1 && drvdata->pid != pid) {
+		rc = -EBUSY;
+		goto unlock_out;
+	}
+
 	etr_perf->head = PERF_IDX2OFF(handle->head, etr_perf);
 	drvdata->perf_data = etr_perf;
+
+	/*
+	 * No HW configuration is needed if the sink is already in
+	 * use for this session.
+	 */
+	if (drvdata->pid == pid) {
+		atomic_inc(csdev->refcnt);
+		goto unlock_out;
+	}
+
 	rc = tmc_etr_enable_hw(drvdata, etr_perf->etr_buf);
 	if (!rc) {
+		/* Associate with monitored process. */
+		drvdata->pid = pid;
 		drvdata->mode = CS_MODE_PERF;
 		atomic_inc(csdev->refcnt);
 	}
@@ -1579,6 +1605,8 @@ static int tmc_disable_etr_sink(struct coresight_device *csdev)
 	/* Complain if we (somehow) got out of sync */
 	WARN_ON_ONCE(drvdata->mode == CS_MODE_DISABLED);
 	tmc_etr_disable_hw(drvdata);
+	/* Dissociate from monitored process. */
+	drvdata->pid = -1;
 	drvdata->mode = CS_MODE_DISABLED;
 
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 71c86cffc021..fd8267fd8e6b 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -417,6 +417,8 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 	devid = readl_relaxed(drvdata->base + CORESIGHT_DEVID);
 	drvdata->config_type = BMVAL(devid, 6, 7);
 	drvdata->memwidth = tmc_get_memwidth(devid);
+	/* This device is not associated with a session */
+	drvdata->pid = -1;
 
 	if (drvdata->config_type == TMC_CONFIG_TYPE_ETR) {
 		if (np)
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index c1b1700b2df7..503f1b3a3741 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -165,6 +165,8 @@ struct etr_buf {
  * @csdev:	component vitals needed by the framework.
  * @miscdev:	specifics to handle "/dev/xyz.tmc" entry.
  * @spinlock:	only one at a time pls.
+ * @pid:	Process ID of the process being monitored by the session
+ *		that is using this component.
  * @buf:	Snapshot of the trace data for ETF/ETB.
  * @etr_buf:	details of buffer used in TMC-ETR
  * @len:	size of the available trace for ETF/ETB.
@@ -186,6 +188,7 @@ struct tmc_drvdata {
 	struct coresight_device	*csdev;
 	struct miscdevice	miscdev;
 	spinlock_t		spinlock;
+	pid_t			pid;
 	bool			reading;
 	union {
 		char		*buf;		/* TMC ETB */
-- 
2.17.1

