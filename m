Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D8BC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4B8205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k9NLBuC5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387812AbfDYTxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:53:55 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41357 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730739AbfDYTxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:53:53 -0400
Received: by mail-pl1-f196.google.com with SMTP id d9so309639pls.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pqAZxopsE41ccB+0oaBL7u4YFTc9+57RlzLR8hpHiBU=;
        b=k9NLBuC5v46LEH+xRNfmy/fRkXrvUipLrXHbMzAme+d1gH+sz57Ax+JFiEKg/8KaM/
         P1FkyP8rks0i72wgIWoff9ene59vtsN4QgaxJgvpMqWYY9Uz0A8hmCY6JOk9AMrNGYZH
         llfshBUh2QxbX9Ii25RA3tR20T0EeXLc7YCBly81bwYeTjmZOcHnqsfn87ckks6J/ODT
         OPC26qb6HKQcYIPBm2atc2wVR8HfeYb5WAFGYzWAX56V5e5pSECTvLynKJCxXHAiRjDY
         BlhGilUz269F41Re2mZ4q3Z2DQ6RfWxUx/+LnuAkSxqEiLMZXL2ruIvyVsiHyWnhjYUG
         5tiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pqAZxopsE41ccB+0oaBL7u4YFTc9+57RlzLR8hpHiBU=;
        b=CS0P7CPEI3HkYRQqfct8v4lSsT6Ob6xlBsFMRZmw8gkbavLQjxWaJ9V46jcw5ABJKB
         3oiQWEnO/9a6Qfp9RXm85lFGvpuiXw/ndozSYv3gg51bqJskXOzddBKe0Zk0nZ0eDFY8
         eCWvjBEaQ/jYAkNidZZIQlQq/T0IZcIJH0fZ5h+SH/6YdkXG6SHanUI1rW5wX5rpI2iY
         GFXrRohUytSYSAMDPMPX4+623Ls5R7e9mgdmjwg+isKdPxMyf0sMkI5GKjb5+hzCdx1a
         DVtNSXA3lOYkJ5O1WshlTwSwUUuJcg9rB7KXacgwhgIB8v64xWe4yBwvoKuCOtW71n8Z
         PwFw==
X-Gm-Message-State: APjAAAW65v7qzCCC00VghtbqsEqMUAs6jArs4StrudKx7smmT/p54WOl
        moIB2Y0RyzT2S+s9RgMbxGpscQYAmrc=
X-Google-Smtp-Source: APXvYqy5+Pojyt5M07+LERH6pUlqOpL7bNrzya3/iUgnM4Ag5IALPrevKqQU0KBiB3lKjo5ABUSD0g==
X-Received: by 2002:a17:902:4481:: with SMTP id l1mr22503275pld.75.1556222032310;
        Thu, 25 Apr 2019 12:53:52 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t64sm47261961pfa.86.2019.04.25.12.53.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:53:51 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 31/32] coresight: tmc-etf: Add support for CPU-wide trace scenarios
Date:   Thu, 25 Apr 2019 13:53:09 -0600
Message-Id: <20190425195310.31562-32-mathieu.poirier@linaro.org>
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

