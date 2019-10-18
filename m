Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C99FCA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F7B20640
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JWxYvpob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502464AbfJRSOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 14:14:10 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:37194 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfJRSOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 14:14:10 -0400
Received: by mail-yw1-f74.google.com with SMTP id w205so1233470ywc.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 11:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=IaFQRFoIKxbV+3Wiy1V75DzJYOA/bGVuQra7qnEhMcY=;
        b=JWxYvpobrwgL0pkXSKTJ4CsepjAxBY+VeNnXG55aHZfRGx104crk0mITbxGlM5JKod
         FpPCvBTLFCBpJRb8dlKQ476CEpHlWvG/hEEHr2rxvisA8bvOg2MXXeJsAV/6gH6AnE15
         fhs4smEtZ43z89Q2XqQEdKZJcMKhGSqpk9fTZfkMclqdp7+HoqHzYbeS1pCE1zDzqPD9
         c02JtxSqBRJAnrZetqxoQBKDFZSS+zpbf3pvL00TiG+8EorcEWx8UOFv2pE42Ev+goQv
         cuQEDSnZ15UGJKp3PCojLGtscYMsdBpaEj2ao8mlpkL+k1GsYlG+O2hlRUs0255ZTMpC
         kFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=IaFQRFoIKxbV+3Wiy1V75DzJYOA/bGVuQra7qnEhMcY=;
        b=XgqdzveKuTHsodF0zz1aeQDRMEbaKavowaMirDywvvCYiI+Lm5Yd7Rfd5yu9NnXwEp
         4cpjNfcDm4yigT4p9Z7c4bup/j1Qt6ehGcTQAgigeCHTQ6321yS7/4QmqBAYOlVkT24y
         +ToGWRk3jTyJVtPrCx8lus0UG51J4jtZYWh4m1AqVIoa4C6KGBiDpkXwuTbGRpxUHUa7
         rbgfC6bj59xOEhHD3QEyLVfYUSdvbd7z9fE2emwAd4QeZdHaBfUwEIP/aXXVS0t57Z1h
         UZqms8+2w/Uu5zcmfd795nh12pqNquSdNw74SOhlVRGLWKAuZAI/75fG3TOgqxgkR00K
         jQcw==
X-Gm-Message-State: APjAAAWZuj5+yL22iDxjubKC55k41TuoKcFESNUk6qylpx9W9isMqdKj
        f5OlMeIZqw3e41dOamQfwmTHbW86vQ==
X-Google-Smtp-Source: APXvYqzt8DNJJd9Eu6sisLImGf22fQmuBo9KAFOjGRAf+2nFwozhnFGV0lfwRGc1JpssCfpBwbwLVj5Ny0w=
X-Received: by 2002:a25:50c8:: with SMTP id e191mr7436750ybb.152.1571422448526;
 Fri, 18 Oct 2019 11:14:08 -0700 (PDT)
Date:   Fri, 18 Oct 2019 11:14:03 -0700
Message-Id: <20191018181403.106836-1-yabinc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH v4] coresight: Serialize enabling/disabling a link device.
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
---

v3 -> v4: moved lock from coresight_enable/disable_link() to
enable/disable functions of each link device.

I also removed lock protection of csdev->enable in v3. Because that
needs to move csdev->enable inside the enable/disable functions of
each link device. That's much effort with almost no benefits.
csdev->enable seems only used for source devices in sysfs interface.

---
 .../hwtracing/coresight/coresight-funnel.c    | 29 ++++++++----
 .../coresight/coresight-replicator.c          | 31 +++++++++----
 .../hwtracing/coresight/coresight-tmc-etf.c   | 39 ++++++++--------
 drivers/hwtracing/coresight/coresight.c       | 45 ++++++-------------
 4 files changed, 77 insertions(+), 67 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 05f7896c3a01..8326d03a0d03 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -44,6 +44,7 @@ struct funnel_drvdata {
 	struct clk		*atclk;
 	struct coresight_device	*csdev;
 	unsigned long		priority;
+	spinlock_t		spinlock;
 };
 
 static int dynamic_funnel_enable_hw(struct funnel_drvdata *drvdata, int port)
@@ -76,12 +77,20 @@ static int funnel_enable(struct coresight_device *csdev, int inport,
 {
 	int rc = 0;
 	struct funnel_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	unsigned long flags;
 
-	if (drvdata->base)
-		rc = dynamic_funnel_enable_hw(drvdata, inport);
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+	if (atomic_inc_return(&csdev->refcnt[inport]) == 1) {
+		if (drvdata->base)
+			rc = dynamic_funnel_enable_hw(drvdata, inport);
 
-	if (!rc)
-		dev_dbg(&csdev->dev, "FUNNEL inport %d enabled\n", inport);
+		if (rc)
+			atomic_dec(&csdev->refcnt[inport]);
+		else
+			dev_dbg(&csdev->dev, "FUNNEL inport %d enabled\n",
+				inport);
+	}
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 	return rc;
 }
 
@@ -107,11 +116,15 @@ static void funnel_disable(struct coresight_device *csdev, int inport,
 			   int outport)
 {
 	struct funnel_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	unsigned long flags;
 
-	if (drvdata->base)
-		dynamic_funnel_disable_hw(drvdata, inport);
-
-	dev_dbg(&csdev->dev, "FUNNEL inport %d disabled\n", inport);
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+	if (atomic_dec_return(&csdev->refcnt[inport]) == 0) {
+		if (drvdata->base)
+			dynamic_funnel_disable_hw(drvdata, inport);
+		dev_dbg(&csdev->dev, "FUNNEL inport %d disabled\n", inport);
+	}
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 }
 
 static const struct coresight_ops_link funnel_link_ops = {
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index b29ba640eb25..427d8b8d0917 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -36,6 +36,7 @@ struct replicator_drvdata {
 	void __iomem		*base;
 	struct clk		*atclk;
 	struct coresight_device	*csdev;
+	spinlock_t		spinlock;
 };
 
 static void dynamic_replicator_reset(struct replicator_drvdata *drvdata)
@@ -97,11 +98,20 @@ static int replicator_enable(struct coresight_device *csdev, int inport,
 {
 	int rc = 0;
 	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-
-	if (drvdata->base)
-		rc = dynamic_replicator_enable(drvdata, inport, outport);
-	if (!rc)
-		dev_dbg(&csdev->dev, "REPLICATOR enabled\n");
+	unsigned long flags;
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+	if (atomic_inc_return(&csdev->refcnt[outport]) == 1) {
+		if (drvdata->base)
+			rc = dynamic_replicator_enable(drvdata, inport,
+						       outport);
+
+		if (rc)
+			atomic_dec(&csdev->refcnt[outport]);
+		else
+			dev_dbg(&csdev->dev, "REPLICATOR enabled\n");
+	}
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 	return rc;
 }
 
@@ -137,10 +147,15 @@ static void replicator_disable(struct coresight_device *csdev, int inport,
 			       int outport)
 {
 	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	unsigned long flags;
 
-	if (drvdata->base)
-		dynamic_replicator_disable(drvdata, inport, outport);
-	dev_dbg(&csdev->dev, "REPLICATOR disabled\n");
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+	if (atomic_dec_return(&csdev->refcnt[outport]) == 0) {
+		if (drvdata->base)
+			dynamic_replicator_disable(drvdata, inport, outport);
+		dev_dbg(&csdev->dev, "REPLICATOR disabled\n");
+	}
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 }
 
 static const struct coresight_ops_link replicator_link_ops = {
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 807416b75ecc..cb4a38541bf8 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -334,23 +334,25 @@ static int tmc_disable_etf_sink(struct coresight_device *csdev)
 static int tmc_enable_etf_link(struct coresight_device *csdev,
 			       int inport, int outport)
 {
-	int ret;
+	int ret = 0;
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
-	if (drvdata->reading) {
-		spin_unlock_irqrestore(&drvdata->spinlock, flags);
-		return -EBUSY;
+	if (atomic_inc_return(&csdev->refcnt[0]) == 1) {
+		if (drvdata->reading)
+			ret = -EBUSY;
+		else
+			ret = tmc_etf_enable_hw(drvdata);
+
+		if (ret) {
+			atomic_dec(&csdev->refcnt[0]);
+		} else {
+			drvdata->mode = CS_MODE_SYSFS;
+			dev_dbg(&csdev->dev, "TMC-ETF enabled\n");
+		}
 	}
-
-	ret = tmc_etf_enable_hw(drvdata);
-	if (!ret)
-		drvdata->mode = CS_MODE_SYSFS;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
-
-	if (!ret)
-		dev_dbg(&csdev->dev, "TMC-ETF enabled\n");
 	return ret;
 }
 
@@ -361,16 +363,13 @@ static void tmc_disable_etf_link(struct coresight_device *csdev,
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
-	if (drvdata->reading) {
-		spin_unlock_irqrestore(&drvdata->spinlock, flags);
-		return;
-	}
-
-	tmc_etf_disable_hw(drvdata);
-	drvdata->mode = CS_MODE_DISABLED;
+	if (atomic_dec_return(&csdev->refcnt[0]) == 0)
+		if (!drvdata->reading) {
+			tmc_etf_disable_hw(drvdata);
+			drvdata->mode = CS_MODE_DISABLED;
+			dev_dbg(&csdev->dev, "TMC-ETF disabled\n");
+		}
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
-
-	dev_dbg(&csdev->dev, "TMC-ETF disabled\n");
 }
 
 static void *tmc_alloc_etf_buffer(struct coresight_device *csdev,
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 6453c67a4d01..0bbce0d29158 100644
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
2.23.0.866.gb869b98d4c-goog

