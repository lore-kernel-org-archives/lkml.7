Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C50CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757122084D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U61y0vCE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbfKDSNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 13:13:22 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34668 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729617AbfKDSNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 13:13:10 -0500
Received: by mail-pg1-f195.google.com with SMTP id e4so11881345pgs.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 10:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zNSLQ4yVOGXzKEZuz3+X88N/a9oM0tmHL+W7cfWAqG4=;
        b=U61y0vCEaJMrncMMWKTp6alsvzkXjC9SFPXjSpuTDW5wP2lJ5MWsrgFL0edDG6iB8A
         16U73gfEg4PN6OKZfBs2IYB12wQk9ICH/0R/6rLVJhTvUE1wLuQUwtzL0htIZrbkCD/n
         qKbYEmA5lAbSze1N5pEKHVX2FPwCN+nKZfWN3ZMCWHjt5my8w9wWsjiXWnqoZV0hWCrB
         +fgtm569leiYQPgNkZTaA81ov8RlBc4jSc82Pr3q71AjyuaOMYlwS4SNEgQxIMHvqIMC
         5jncbym3qbVGrIsHRj53O1kEzrwC4S2jnN1icF/c1wyvIKRTKeuoM09MJv+wI8zHWdEi
         leqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zNSLQ4yVOGXzKEZuz3+X88N/a9oM0tmHL+W7cfWAqG4=;
        b=gzPHuxCwCvVUfPZ/dxSaBWGgTLqoQGDkvNlXv0g9R7vGRrJbIdRrFR9zcKO7JQTHTu
         lRE2lii+MeklZNK2FxukXVMRi0VLNPnJ2JJh7YgsAthm35/vMhfq+sHxOaG1+rUPKccj
         EoV5gqJmJLG/uhfY0WPwlG8uHnhVSHFRiTyCacbg0TSazraOjGBxvt5ZX6LKoOTi836u
         PagHNmcxeEiJox2o06dlzs6Hi+m0/Q58qXE2BKPacy8YT4PvDqujdV6pMqYlxGrT4p5v
         DzGO7BaFSHdjlojv/Ioc3XgurCAKrPQbqEYYTadSueXhbi8d3zC0m0zK+4Gu226um1oQ
         IiLQ==
X-Gm-Message-State: APjAAAX27BGK1LHm1hajx3U6xk66T3d1sQlkEZvY9v4zmGRFUe2HAmun
        itCOWJJ5U2xSxqPm8dqKciP5Tw==
X-Google-Smtp-Source: APXvYqyePPW9ffMklHCLMl63zYDBvK4GeJoTGZvi+F6CTfXY3x2EK/oJ2GSTfHnc7fkYb+1NWhYRtg==
X-Received: by 2002:a17:90a:fc8d:: with SMTP id ci13mr610341pjb.6.1572891186945;
        Mon, 04 Nov 2019 10:13:06 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o12sm16149520pgl.86.2019.11.04.10.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 10:13:06 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/14] coresight: Serialize enabling/disabling a link device.
Date:   Mon,  4 Nov 2019 11:12:50 -0700
Message-Id: <20191104181251.26732-14-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191104181251.26732-1-mathieu.poirier@linaro.org>
References: <20191104181251.26732-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yabin Cui <yabinc@google.com>

When tracing etm data of multiple threads on multiple cpus through perf
interface, some link devices are shared between paths of different cpus.
It creates race conditions when different cpus wants to enable/disable
the same link device at the same time.

Example 1:
Two cpus want to enable different ports of a coresight funnel, thus
calling the funnel enable operation at the same time. But the funnel
enable operation isn't reentrantable.

Example 2:
For an enabled coresight dynamic replicator with refcnt=1, one cpu wants
to disable it, while another cpu wants to enable it. Ideally we still have
an enabled replicator with refcnt=1 at the end. But in reality the result
is uncertain.

Since coresight devices claim themselves when enabled for self-hosted
usage, the race conditions above usually make the link devices not usable
after many cycles.

To fix the race conditions, this patch uses spinlocks to serialize
enabling/disabling link devices.

Fixes: a06ae8609b3d ("coresight: add CoreSight core layer framework")
Signed-off-by: Yabin Cui <yabinc@google.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: stable <stable@vger.kernel.org> # 5.3
---
 .../hwtracing/coresight/coresight-funnel.c    | 36 +++++++++++----
 .../coresight/coresight-replicator.c          | 35 ++++++++++++---
 .../hwtracing/coresight/coresight-tmc-etf.c   | 26 ++++++++---
 drivers/hwtracing/coresight/coresight.c       | 45 ++++++-------------
 4 files changed, 90 insertions(+), 52 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 05f7896c3a01..b605889b507a 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -38,12 +38,14 @@ DEFINE_CORESIGHT_DEVLIST(funnel_devs, "funnel");
  * @atclk:	optional clock for the core parts of the funnel.
  * @csdev:	component vitals needed by the framework.
  * @priority:	port selection order.
+ * @spinlock:	serialize enable/disable operations.
  */
 struct funnel_drvdata {
 	void __iomem		*base;
 	struct clk		*atclk;
 	struct coresight_device	*csdev;
 	unsigned long		priority;
+	spinlock_t		spinlock;
 };
 
 static int dynamic_funnel_enable_hw(struct funnel_drvdata *drvdata, int port)
@@ -76,11 +78,21 @@ static int funnel_enable(struct coresight_device *csdev, int inport,
 {
 	int rc = 0;
 	struct funnel_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-
-	if (drvdata->base)
-		rc = dynamic_funnel_enable_hw(drvdata, inport);
-
+	unsigned long flags;
+	bool first_enable = false;
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+	if (atomic_read(&csdev->refcnt[inport]) == 0) {
+		if (drvdata->base)
+			rc = dynamic_funnel_enable_hw(drvdata, inport);
+		if (!rc)
+			first_enable = true;
+	}
 	if (!rc)
+		atomic_inc(&csdev->refcnt[inport]);
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+
+	if (first_enable)
 		dev_dbg(&csdev->dev, "FUNNEL inport %d enabled\n", inport);
 	return rc;
 }
@@ -107,11 +119,19 @@ static void funnel_disable(struct coresight_device *csdev, int inport,
 			   int outport)
 {
 	struct funnel_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	unsigned long flags;
+	bool last_disable = false;
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+	if (atomic_dec_return(&csdev->refcnt[inport]) == 0) {
+		if (drvdata->base)
+			dynamic_funnel_disable_hw(drvdata, inport);
+		last_disable = true;
+	}
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	if (drvdata->base)
-		dynamic_funnel_disable_hw(drvdata, inport);
-
-	dev_dbg(&csdev->dev, "FUNNEL inport %d disabled\n", inport);
+	if (last_disable)
+		dev_dbg(&csdev->dev, "FUNNEL inport %d disabled\n", inport);
 }
 
 static const struct coresight_ops_link funnel_link_ops = {
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index b29ba640eb25..43304196a1a6 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -31,11 +31,13 @@ DEFINE_CORESIGHT_DEVLIST(replicator_devs, "replicator");
  *		whether this one is programmable or not.
  * @atclk:	optional clock for the core parts of the replicator.
  * @csdev:	component vitals needed by the framework
+ * @spinlock:	serialize enable/disable operations.
  */
 struct replicator_drvdata {
 	void __iomem		*base;
 	struct clk		*atclk;
 	struct coresight_device	*csdev;
+	spinlock_t		spinlock;
 };
 
 static void dynamic_replicator_reset(struct replicator_drvdata *drvdata)
@@ -97,10 +99,22 @@ static int replicator_enable(struct coresight_device *csdev, int inport,
 {
 	int rc = 0;
 	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-
-	if (drvdata->base)
-		rc = dynamic_replicator_enable(drvdata, inport, outport);
+	unsigned long flags;
+	bool first_enable = false;
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+	if (atomic_read(&csdev->refcnt[outport]) == 0) {
+		if (drvdata->base)
+			rc = dynamic_replicator_enable(drvdata, inport,
+						       outport);
+		if (!rc)
+			first_enable = true;
+	}
 	if (!rc)
+		atomic_inc(&csdev->refcnt[outport]);
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+
+	if (first_enable)
 		dev_dbg(&csdev->dev, "REPLICATOR enabled\n");
 	return rc;
 }
@@ -137,10 +151,19 @@ static void replicator_disable(struct coresight_device *csdev, int inport,
 			       int outport)
 {
 	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	unsigned long flags;
+	bool last_disable = false;
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+	if (atomic_dec_return(&csdev->refcnt[outport]) == 0) {
+		if (drvdata->base)
+			dynamic_replicator_disable(drvdata, inport, outport);
+		last_disable = true;
+	}
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	if (drvdata->base)
-		dynamic_replicator_disable(drvdata, inport, outport);
-	dev_dbg(&csdev->dev, "REPLICATOR disabled\n");
+	if (last_disable)
+		dev_dbg(&csdev->dev, "REPLICATOR disabled\n");
 }
 
 static const struct coresight_ops_link replicator_link_ops = {
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 807416b75ecc..d0cc3985b72a 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -334,9 +334,10 @@ static int tmc_disable_etf_sink(struct coresight_device *csdev)
 static int tmc_enable_etf_link(struct coresight_device *csdev,
 			       int inport, int outport)
 {
-	int ret;
+	int ret = 0;
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	bool first_enable = false;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 	if (drvdata->reading) {
@@ -344,12 +345,18 @@ static int tmc_enable_etf_link(struct coresight_device *csdev,
 		return -EBUSY;
 	}
 
-	ret = tmc_etf_enable_hw(drvdata);
+	if (atomic_read(&csdev->refcnt[0]) == 0) {
+		ret = tmc_etf_enable_hw(drvdata);
+		if (!ret) {
+			drvdata->mode = CS_MODE_SYSFS;
+			first_enable = true;
+		}
+	}
 	if (!ret)
-		drvdata->mode = CS_MODE_SYSFS;
+		atomic_inc(&csdev->refcnt[0]);
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	if (!ret)
+	if (first_enable)
 		dev_dbg(&csdev->dev, "TMC-ETF enabled\n");
 	return ret;
 }
@@ -359,6 +366,7 @@ static void tmc_disable_etf_link(struct coresight_device *csdev,
 {
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	bool last_disable = false;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 	if (drvdata->reading) {
@@ -366,11 +374,15 @@ static void tmc_disable_etf_link(struct coresight_device *csdev,
 		return;
 	}
 
-	tmc_etf_disable_hw(drvdata);
-	drvdata->mode = CS_MODE_DISABLED;
+	if (atomic_dec_return(&csdev->refcnt[0]) == 0) {
+		tmc_etf_disable_hw(drvdata);
+		drvdata->mode = CS_MODE_DISABLED;
+		last_disable = true;
+	}
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	dev_dbg(&csdev->dev, "TMC-ETF disabled\n");
+	if (last_disable)
+		dev_dbg(&csdev->dev, "TMC-ETF disabled\n");
 }
 
 static void *tmc_alloc_etf_buffer(struct coresight_device *csdev,
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index e6ca899fea4e..ef20f74c85fa 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -253,9 +253,9 @@ static int coresight_enable_link(struct coresight_device *csdev,
 				 struct coresight_device *parent,
 				 struct coresight_device *child)
 {
-	int ret;
+	int ret = 0;
 	int link_subtype;
-	int refport, inport, outport;
+	int inport, outport;
 
 	if (!parent || !child)
 		return -EINVAL;
@@ -264,29 +264,17 @@ static int coresight_enable_link(struct coresight_device *csdev,
 	outport = coresight_find_link_outport(csdev, child);
 	link_subtype = csdev->subtype.link_subtype;
 
-	if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG)
-		refport = inport;
-	else if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_SPLIT)
-		refport = outport;
-	else
-		refport = 0;
-
-	if (refport < 0)
-		return refport;
+	if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG && inport < 0)
+		return inport;
+	if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_SPLIT && outport < 0)
+		return outport;
 
-	if (atomic_inc_return(&csdev->refcnt[refport]) == 1) {
-		if (link_ops(csdev)->enable) {
-			ret = link_ops(csdev)->enable(csdev, inport, outport);
-			if (ret) {
-				atomic_dec(&csdev->refcnt[refport]);
-				return ret;
-			}
-		}
-	}
-
-	csdev->enable = true;
+	if (link_ops(csdev)->enable)
+		ret = link_ops(csdev)->enable(csdev, inport, outport);
+	if (!ret)
+		csdev->enable = true;
 
-	return 0;
+	return ret;
 }
 
 static void coresight_disable_link(struct coresight_device *csdev,
@@ -295,7 +283,7 @@ static void coresight_disable_link(struct coresight_device *csdev,
 {
 	int i, nr_conns;
 	int link_subtype;
-	int refport, inport, outport;
+	int inport, outport;
 
 	if (!parent || !child)
 		return;
@@ -305,20 +293,15 @@ static void coresight_disable_link(struct coresight_device *csdev,
 	link_subtype = csdev->subtype.link_subtype;
 
 	if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG) {
-		refport = inport;
 		nr_conns = csdev->pdata->nr_inport;
 	} else if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_SPLIT) {
-		refport = outport;
 		nr_conns = csdev->pdata->nr_outport;
 	} else {
-		refport = 0;
 		nr_conns = 1;
 	}
 
-	if (atomic_dec_return(&csdev->refcnt[refport]) == 0) {
-		if (link_ops(csdev)->disable)
-			link_ops(csdev)->disable(csdev, inport, outport);
-	}
+	if (link_ops(csdev)->disable)
+		link_ops(csdev)->disable(csdev, inport, outport);
 
 	for (i = 0; i < nr_conns; i++)
 		if (atomic_read(&csdev->refcnt[i]) != 0)
-- 
2.17.1

