Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618D2C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5CF205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e65dAhnT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730797AbfDYTyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:54:05 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41558 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730784AbfDYTxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:53:54 -0400
Received: by mail-pg1-f193.google.com with SMTP id f6so360161pgs.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jDPyESeyA1XWInOj96ARwqWgZicZRGHOAy5iyflwVzQ=;
        b=e65dAhnT6qG8v8FCU6x/En8lQ2B4KwrUer/Zz5B+GiH4AxPZel3HYIykHpsD1UGjG9
         Xkr7nJquxvFo8Pi9NpDcAwGpt/Ch5BtMmUpybkB9M4DYsLCC7Z0yEAGQXXWigcHKK0R2
         6n2rV3gSvf1aSB98psLaagr5fpyJGQyeG/9jYfYHdR3Z28IfB6icnh8xrahQMhrJvN1z
         orDFvSjBwoKXrcORAINLe9Gh5FY9NGfIqD7m9FBJ4i7U+WNcbmxbhggeFK4KSY9ZIxFK
         H35yv9FtGXwZcXFfr/mKf1LI5DfKc+qFmCG47mjytiBzlD4ZX6LxJ/Vo0LPLrRcCzZm3
         DD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jDPyESeyA1XWInOj96ARwqWgZicZRGHOAy5iyflwVzQ=;
        b=s0FDQqYUErRFKp+MyAokE5tZCZkfcJdflb/4v+gpQoe7wqm1AvzNWgLrNBS1wi5TTb
         RwVRYq1Txf9SeQbsXcbaSkY1VZDy9cs3HTT7c47PXrNywBQdNbfsMFYdomagrkjqT6AW
         xm6Rc7ZrdTn9TqzV+g0YRsmV9HTCmEaJ3v0xPDk0fhoC5YMYC3gVN5Wdwf7AZ/nuLL1z
         9lSMpClWw+48wrzHbGRLGSmZaU2q5AfZxyil1d5BX/jCcYi/63ixRU8c0vA6z6k5bHjB
         qIb3WdNbMZqqHuLBtKLzdz4kWaCa9sISRQeLhlVrmKc2oYAzuVqlGjwP4QWHx8g8sfia
         Nbag==
X-Gm-Message-State: APjAAAVBWvm4ZYnWNMKUWw3nSvWPt2OpBCR25IGaflU6f94tLQj/Yl4R
        YXPlqiHdVg6kqR6V6Mr2QAxFCRpP4Fc=
X-Google-Smtp-Source: APXvYqz0VDLsgAh+v1W5n7nSAX4tQofaylgqIxmcJ4NB9ls/HRLutTseiuxfmr1cWBl3pjpD0ni/8g==
X-Received: by 2002:a62:e411:: with SMTP id r17mr42322739pfh.127.1556222033500;
        Thu, 25 Apr 2019 12:53:53 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t64sm47261961pfa.86.2019.04.25.12.53.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:53:52 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 32/32] coresight: etb10: Add support for CPU-wide trace scenarios
Date:   Thu, 25 Apr 2019 13:53:10 -0600
Message-Id: <20190425195310.31562-33-mathieu.poirier@linaro.org>
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
 drivers/hwtracing/coresight/coresight-etb10.c | 43 +++++++++++++++++--
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index eeae375c7aed..4ee4c80a4354 100644
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
@@ -169,28 +172,49 @@ static int etb_enable_sysfs(struct coresight_device *csdev)
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
@@ -336,6 +360,8 @@ static int etb_disable(struct coresight_device *csdev)
 	/* Complain if we (somehow) got out of sync */
 	WARN_ON_ONCE(drvdata->mode == CS_MODE_DISABLED);
 	etb_disable_hw(drvdata);
+	/* Dissociate from monitored process. */
+	drvdata->pid = -1;
 	drvdata->mode = CS_MODE_DISABLED;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
@@ -406,7 +432,7 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
 	const u32 *barrier;
 	u32 read_ptr, write_ptr, capacity;
 	u32 status, read_data;
-	unsigned long offset, to_read, flags;
+	unsigned long offset, to_read = 0, flags;
 	struct cs_buffers *buf = sink_config;
 	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
@@ -416,6 +442,11 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
 	capacity = drvdata->buffer_depth * ETB_FRAME_SIZE_WORDS;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
+
+	/* Don't do anything if another tracer is using this sink */
+	if (atomic_read(csdev->refcnt) != 1)
+		goto out;
+
 	__etb_disable_hw(drvdata);
 	CS_UNLOCK(drvdata->base);
 
@@ -526,6 +557,7 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
 	}
 	__etb_enable_hw(drvdata);
 	CS_LOCK(drvdata->base);
+out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	return to_read;
@@ -733,6 +765,9 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
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

