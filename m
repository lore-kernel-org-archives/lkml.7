Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC08C10F05
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140052147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ue49eOPx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfDDDhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:37:05 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38484 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbfDDDhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:37:03 -0400
Received: by mail-pl1-f196.google.com with SMTP id g37so439266plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 20:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DXJXs+4knPk/tA7or7zclZmTtg+ioeh357GrnSar9kA=;
        b=Ue49eOPxZ/b1NIUrbk6DsAPnbtiZDLB+YR+tD0AKaa/fHQhyekBCugfgGTfQML9J8e
         MQvFErB7hxKiVViwohCnahFYv8cpLq9Lz4ID9etGYngPzS0j8uPnWnd1HHIDcUM0LIL4
         /J/Lcrl1xQ1SgJGqLRlPyiIShR6WlvTD+GTfO3Jhj17F7C7dE5uR/bNv1nr/dA57RRuJ
         C2w80m9Wi18ElVMtAc6zFUi0+dOg36L0BIt8KueCIMwydRYuqAk70YhtlJrniZ2HANfa
         qD77URjCiBDYx0o+HpE+jzUk/Vq/SqOgFEb/RhQAwOTo33qo1Sxy62jDoy1cCqQg/LHd
         3Jyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DXJXs+4knPk/tA7or7zclZmTtg+ioeh357GrnSar9kA=;
        b=kR7OEW6JAKGZu6LFY/GrA3t57TVBRv4y5kw+f44Dwto3DmfKy3RlOuNPIwlx8ETiMo
         srRRTwYItbYOP2OS4bT9mpuJOuHg37duxgwF2Pkh4pnhlHLdpXOJyLEKlbIfoosqoCzg
         h02jQ2b8ZPxms3ggGTEM4cBRaGmi3acI7SLEC/bpjZQUi3QIrzhpK3Zk3VnVxwfEC6Ww
         XIQDIMWywam0eU630J9HlxU647ql3/Wv/4IGeKWyjMzRekqJJfVm1I1Pdf9d2EjuiZSH
         n99tbkRUXl16bFMKN60Qho0sQsFtf8WHwIfYXx3gOeOW570ondIMOiUymlKw+iX7eLKn
         lavQ==
X-Gm-Message-State: APjAAAXiU0TTSkENHwoAcS2AUv16U+8eoJi3XbI/oWHPaUqF0Ma1wVt+
        VzwWzzXqQl9mW08y5ysR8z7DSg==
X-Google-Smtp-Source: APXvYqzSpjfKRSscdhjHCkli33DQ/OnEBY5jyMnQH+ksUW76Ae0Ylq+FgyIgcfygVuFDRBkiWaZGSw==
X-Received: by 2002:a17:902:be04:: with SMTP id r4mr3949596pls.218.1554349022282;
        Wed, 03 Apr 2019 20:37:02 -0700 (PDT)
Received: from xps15.imgcgcw.net ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id u5sm12212780pfm.121.2019.04.03.20.36.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 20:37:01 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        suzuki.poulose@arm.com, mike.leach@arm.com, leo.yan@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 20/20] coresight: etb10: Add support for CPU-wide trace scenarios
Date:   Wed,  3 Apr 2019 21:35:41 -0600
Message-Id: <20190404033541.14072-21-mathieu.poirier@linaro.org>
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
 drivers/hwtracing/coresight/coresight-etb10.c | 43 +++++++++++++++++--
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 7d64c41cd8ac..a2379c00d635 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -72,6 +72,8 @@
  * @miscdev:	specifics to handle "/dev/xyz.etb" entry.
  * @spinlock:	only one at a time pls.
  * @reading:	synchronise user space access to etb buffer.
+ * @pid:	Process ID of the process being monitored by the session
+ *		that is using this component.
  * @buf:	area of memory where ETB buffer content gets sent.
  * @mode:	this ETB is being used.
  * @buffer_depth: size of @buf.
@@ -85,6 +87,7 @@ struct etb_drvdata {
 	struct miscdevice	miscdev;
 	spinlock_t		spinlock;
 	local_t			reading;
+	pid_t			pid;
 	u8			*buf;
 	u32			mode;
 	u32			buffer_depth;
@@ -177,28 +180,49 @@ static int etb_enable_sysfs(struct coresight_device *csdev)
 static int etb_enable_perf(struct coresight_device *csdev, void *data)
 {
 	int ret = 0;
+	pid_t pid;
 	unsigned long flags;
 	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct perf_output_handle *handle = data;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
-	/* No need to continue if the component is already in use. */
-	if (drvdata->mode != CS_MODE_DISABLED) {
+	/* No need to continue if the component is already in used by sysFS. */
+	if (drvdata->mode == CS_MODE_SYSFS) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	/* Get a handle on the pid of the process to monitor */
+	pid = task_pid_nr(handle->event->owner);
+
+	if (drvdata->pid != -1 && drvdata->pid != pid) {
 		ret = -EBUSY;
 		goto out;
 	}
 
+	/*
+	 * No HW configuration is needed if the sink is already in
+	 * use for this session.
+	 */
+	if (drvdata->pid == pid) {
+		atomic_inc(csdev->refcnt);
+		goto out;
+	}
+
 	/*
 	 * We don't have an internal state to clean up if we fail to setup
 	 * the perf buffer. So we can perform the step before we turn the
 	 * ETB on and leave without cleaning up.
 	 */
-	ret = etb_set_buffer(csdev, (struct perf_output_handle *)data);
+	ret = etb_set_buffer(csdev, handle);
 	if (ret)
 		goto out;
 
 	ret = etb_enable_hw(drvdata);
 	if (!ret) {
+		/* Associate with monitored process. */
+		drvdata->pid = pid;
 		drvdata->mode = CS_MODE_PERF;
 		atomic_inc(csdev->refcnt);
 	}
@@ -344,6 +368,8 @@ static int etb_disable(struct coresight_device *csdev)
 	/* Complain if we (somehow) got out of sync */
 	WARN_ON_ONCE(drvdata->mode == CS_MODE_DISABLED);
 	etb_disable_hw(drvdata);
+	/* Dissociate from monitored process. */
+	drvdata->pid = -1;
 	drvdata->mode = CS_MODE_DISABLED;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
@@ -414,7 +440,7 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
 	const u32 *barrier;
 	u32 read_ptr, write_ptr, capacity;
 	u32 status, read_data;
-	unsigned long offset, to_read, flags;
+	unsigned long offset, to_read = 0, flags;
 	struct cs_buffers *buf = sink_config;
 	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
@@ -424,6 +450,11 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
 	capacity = drvdata->buffer_depth * ETB_FRAME_SIZE_WORDS;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
+
+	/* Don't do anything if another tracer is using this sink */
+	if (atomic_read(csdev->refcnt) != 1)
+		goto out;
+
 	__etb_disable_hw(drvdata);
 	CS_UNLOCK(drvdata->base);
 
@@ -534,6 +565,7 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
 	}
 	__etb_enable_hw(drvdata);
 	CS_LOCK(drvdata->base);
+out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	return to_read;
@@ -742,6 +774,9 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
 	if (!drvdata->buf)
 		return -ENOMEM;
 
+	/* This device is not associated with a session */
+	drvdata->pid = -1;
+
 	desc.type = CORESIGHT_DEV_TYPE_SINK;
 	desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
 	desc.ops = &etb_cs_ops;
-- 
2.17.1

