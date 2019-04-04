Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D3DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C51E2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l+4n3Auv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfDDDgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:36:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40441 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfDDDgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:36:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id u9so498247pgo.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 20:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4hFRGGNdcU8vlM88cfy2RLP9AZ/aEQhsa4FL81XyY5I=;
        b=l+4n3AuvD3Zu0v6dF/2m4N149idN+ctNj72fR2SVD7pNTleaAJaUaygiNJaovpDO56
         gbmCxBWUIv/f1fdbX9kQWtLRrY8oACjxEE3QQXjNl4t2OXQFQTdk/wjvwInK2u3FOGE7
         +Rtc5GmC3vrPKZjXudAyzM3TkIF/ACHkEgioIsTt1di/rqKtZt10l+Y0Rs+94LEaigcC
         xr4zUMBb6XemdhJN6WcRoX4foZEXOt3trTPxSw0MvBK1QLMLKf4pd7oSwg73nO8o454I
         8zLe2fkj/9zOcykPMXa8nUmk15u3nyML4Y2plosYmRsYG/xcYoHZiNKXx3/s1aQGK1o8
         FSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4hFRGGNdcU8vlM88cfy2RLP9AZ/aEQhsa4FL81XyY5I=;
        b=IK8pPWRlkya+LBWmYGwhnFvrMcq3qTjvhQFz0ViXb2A0RanqiZQD/eapsKNMZ9tucM
         Ci6XSYOo52jJRQ8gcTu1paU1kp/mtaC9gGiWAyLUYXHd/uhIqAE/Y4aZ3NzOehL9B2Dm
         QrmOSrr97cNFlHtF6t9Duc1WU5lAsCxuRbPoziX39g1dlvWMz8FuvTzMSjeR3kOqImf+
         qwhSiTYkpbvhmPFJOPGTLntr/2ejSYFYcq9rArbge8OXrJPVI9cbzxycwO3hiTOFpMh/
         SSGYTVQKlqK6CEuePZxrVdygbEsXTB6PiYtd45CPfJB0roL55Ts1i4cZ+uVOVx1IPx8C
         cLiw==
X-Gm-Message-State: APjAAAWMf3XHcujaOEgdFUF3eX4e0221Uoq1+MXnBXouhFAeaqpd2bou
        hIVMIbXTxZzqQ3KEjaTpMbfoUA==
X-Google-Smtp-Source: APXvYqzdQY3/Duw2Bm4S0BKyQUO6JCiHbsm7nMfwqYmrE7+hMLM5kOEB7LYrrbkTg8WRJv4OzAe8gg==
X-Received: by 2002:a62:1215:: with SMTP id a21mr3348668pfj.126.1554348967345;
        Wed, 03 Apr 2019 20:36:07 -0700 (PDT)
Received: from xps15.imgcgcw.net ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id u5sm12212780pfm.121.2019.04.03.20.36.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 20:36:06 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        suzuki.poulose@arm.com, mike.leach@arm.com, leo.yan@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/20] coresight: Adding return code to sink::disable() operation
Date:   Wed,  3 Apr 2019 21:35:26 -0600
Message-Id: <20190404033541.14072-6-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190404033541.14072-1-mathieu.poirier@linaro.org>
References: <20190404033541.14072-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to handle device reference counting inside of the sink
drivers, add a return code to the sink::disable() operation so that
proper action can be taken if a sink has not been disabled.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etb10.c   | 3 ++-
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 5 +++--
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 5 +++--
 drivers/hwtracing/coresight/coresight-tpiu.c    | 3 ++-
 drivers/hwtracing/coresight/coresight.c         | 6 +++++-
 include/linux/coresight.h                       | 2 +-
 6 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 105782ea64c7..71c2a3cdb866 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -325,7 +325,7 @@ static void etb_disable_hw(struct etb_drvdata *drvdata)
 	coresight_disclaim_device(drvdata->base);
 }
 
-static void etb_disable(struct coresight_device *csdev)
+static int etb_disable(struct coresight_device *csdev)
 {
 	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	unsigned long flags;
@@ -340,6 +340,7 @@ static void etb_disable(struct coresight_device *csdev)
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	dev_dbg(drvdata->dev, "ETB disabled\n");
+	return 0;
 }
 
 static void *etb_alloc_buffer(struct coresight_device *csdev, int cpu,
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index a5f053f2db2c..d4213e7c2c45 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -273,7 +273,7 @@ static int tmc_enable_etf_sink(struct coresight_device *csdev,
 	return 0;
 }
 
-static void tmc_disable_etf_sink(struct coresight_device *csdev)
+static int tmc_disable_etf_sink(struct coresight_device *csdev)
 {
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
@@ -281,7 +281,7 @@ static void tmc_disable_etf_sink(struct coresight_device *csdev)
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 	if (drvdata->reading) {
 		spin_unlock_irqrestore(&drvdata->spinlock, flags);
-		return;
+		return -EBUSY;
 	}
 
 	/* Disable the TMC only if it needs to */
@@ -293,6 +293,7 @@ static void tmc_disable_etf_sink(struct coresight_device *csdev)
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	dev_dbg(drvdata->dev, "TMC-ETB/ETF disabled\n");
+	return 0;
 }
 
 static int tmc_enable_etf_link(struct coresight_device *csdev,
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index f684283890d3..33501777038a 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1392,7 +1392,7 @@ static int tmc_enable_etr_sink(struct coresight_device *csdev,
 	return -EINVAL;
 }
 
-static void tmc_disable_etr_sink(struct coresight_device *csdev)
+static int tmc_disable_etr_sink(struct coresight_device *csdev)
 {
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
@@ -1400,7 +1400,7 @@ static void tmc_disable_etr_sink(struct coresight_device *csdev)
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 	if (drvdata->reading) {
 		spin_unlock_irqrestore(&drvdata->spinlock, flags);
-		return;
+		return -EBUSY;
 	}
 
 	/* Disable the TMC only if it needs to */
@@ -1412,6 +1412,7 @@ static void tmc_disable_etr_sink(struct coresight_device *csdev)
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	dev_dbg(drvdata->dev, "TMC-ETR disabled\n");
+	return 0;
 }
 
 static const struct coresight_ops_sink tmc_etr_sink_ops = {
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index b2f72a1fa402..0d13da1b9df1 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -94,13 +94,14 @@ static void tpiu_disable_hw(struct tpiu_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
-static void tpiu_disable(struct coresight_device *csdev)
+static int tpiu_disable(struct coresight_device *csdev)
 {
 	struct tpiu_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
 	tpiu_disable_hw(drvdata);
 
 	dev_dbg(drvdata->dev, "TPIU disabled\n");
+	return 0;
 }
 
 static const struct coresight_ops_sink tpiu_sink_ops = {
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 29cef898afba..13eda4693f81 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -239,9 +239,13 @@ static int coresight_enable_sink(struct coresight_device *csdev,
 
 static void coresight_disable_sink(struct coresight_device *csdev)
 {
+	int ret;
+
 	if (atomic_dec_return(csdev->refcnt) == 0) {
 		if (sink_ops(csdev)->disable) {
-			sink_ops(csdev)->disable(csdev);
+			ret = sink_ops(csdev)->disable(csdev);
+			if (ret)
+				return;
 			csdev->enable = false;
 		}
 	}
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 7b87965f7a65..189cc6ddc92b 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -192,7 +192,7 @@ struct coresight_device {
  */
 struct coresight_ops_sink {
 	int (*enable)(struct coresight_device *csdev, u32 mode, void *data);
-	void (*disable)(struct coresight_device *csdev);
+	int (*disable)(struct coresight_device *csdev);
 	void *(*alloc_buffer)(struct coresight_device *csdev, int cpu,
 			      void **pages, int nr_pages, bool overwrite);
 	void (*free_buffer)(void *config);
-- 
2.17.1

