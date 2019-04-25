Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46DCC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F1C2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PKo3sGS6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387831AbfDYTx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:53:57 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38740 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387794AbfDYTxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:53:52 -0400
Received: by mail-pl1-f194.google.com with SMTP id f36so312296plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nvndSiJzhOG7Xw1LUtIIbFBDaU3VT58I2Bl/sSO11+w=;
        b=PKo3sGS69IlP+FWHfFisAxeAomYhuWMjz2HU/U6czzGGJHz2DoP/RaU9oZuR4VG2Op
         A0XZ8Nezj+5Ie2r97RhRQ153Kofby1XPpkpGkrIcYI/qJBGUKvK+tPC4qWLFtCw1Q1Ds
         BvyjUYQRm5nz1PgfXqKG9tp2Bz7JjNNQY/wB2y6kC2o+fkZFPm51aryqAr8dIViQf1c/
         KcTXrcmAiSlW4jy1RJ2IB+Uj9Qk+aqvfM+h6YINH/A5tZ1LTdWSICvqOaOYBiajQmeDL
         Hwq6l5ksL8WYNiJHfW6hvQ7EnWifYrRJoD/vQIS7EYzXhjYkUBss0BoSHpAjLaKXRdY6
         /vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nvndSiJzhOG7Xw1LUtIIbFBDaU3VT58I2Bl/sSO11+w=;
        b=aFNMKJ26JD+ztatvGEYGXBMXmAf+aORagqMczKkYSngqgAQZKa3KKP7IvI9LhtkSRs
         qv4jA6ojWDwiK/FAYDBmOI0fU8mt81bTh4Z7ylz2Lf+V5Lokf56yq09J/RuS86Bh5s6o
         8mTgVp7+WRzB+llymEXmH4W3l5GWDqfjqHnseyJjaaHmEyFTWs2eoy4sHjjnZFsFTsUh
         ikc5R0l5YSqDsygoOYqHnehkbr98gggIzl1B0F+4oVGxxB/MnFHb3rGaOr2n1BO4JA0x
         /OqGfpVA+cT3uzhc9IM4eHKMQlI5llv8Zm7RM5NxwT+OzhPlS3untfwzJSt+sPl0P9Qh
         /KBA==
X-Gm-Message-State: APjAAAUPmx3aWmB+qipjz+GfIkDXUHc5mJZYOweP/a1XCQ8ehyH2ZP+Q
        3rPwVgkluF+X0aMAF2t1Mx+DpHNB9tA=
X-Google-Smtp-Source: APXvYqzMwNDgGTc2M3cMZRj0ZQoBI79566Y9OG9stDYx+2VY6DdhTYQ790kMzN+oM0mhG6sGuhl3aA==
X-Received: by 2002:a17:902:42:: with SMTP id 60mr41444062pla.79.1556222031202;
        Thu, 25 Apr 2019 12:53:51 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t64sm47261961pfa.86.2019.04.25.12.53.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:53:50 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 30/32] coresight: tmc-etr: Add support for CPU-wide trace scenarios
Date:   Thu, 25 Apr 2019 13:53:08 -0600
Message-Id: <20190425195310.31562-31-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425195310.31562-1-mathieu.poirier@linaro.org>
References: <20190425195310.31562-1-mathieu.poirier@linaro.org>
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
Tested-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Robert Walker <robert.walker@arm.com>
---
 .../hwtracing/coresight/coresight-tmc-etr.c   | 38 ++++++++++++++++---
 drivers/hwtracing/coresight/coresight-tmc.c   |  2 +
 drivers/hwtracing/coresight/coresight-tmc.h   |  3 ++
 3 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 8c75800003d2..df6e4b0b84e9 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1474,6 +1474,13 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
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
@@ -1513,17 +1520,15 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
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
@@ -1533,10 +1538,31 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
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
@@ -1580,6 +1606,8 @@ static int tmc_disable_etr_sink(struct coresight_device *csdev)
 	/* Complain if we (somehow) got out of sync */
 	WARN_ON_ONCE(drvdata->mode == CS_MODE_DISABLED);
 	tmc_etr_disable_hw(drvdata);
+	/* Dissociate from monitored process. */
+	drvdata->pid = -1;
 	drvdata->mode = CS_MODE_DISABLED;
 
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 9f9b2c514566..3f718729d741 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -422,6 +422,8 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
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

