Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF94C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEBFD2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nLE6aWFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbfDYTxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:53:38 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38718 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387789AbfDYTxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:53:35 -0400
Received: by mail-pl1-f194.google.com with SMTP id f36so311877plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z7tuIrU+ZkZJi6hgSZa6yyPmsJFqpipO6I4SLg0Fmdg=;
        b=nLE6aWFApWJ952XgTdkH6gzt4202bRinTTytoU1kgPcChVTWMO+f+k1zSSyH6Higd1
         /5BbOLcam2k3ws9jpAFmfgnRpu7Vl9Ny3nZyvmGwHECTc2BfrbRbw34Zuaaj51WSGHk9
         c9P8gK/yjy50t1hZycs/Yao4ZjBL0dBneGvskQGj9l++U0nxMZye10sInVq79fkf0svG
         63y96Ft8RNspFUVoL62uHwYczRrEIE0uCqPWraNJ6JeQl5RrVXp1xygbwwdESCqRulbw
         zKQL2rPzJ4tpZ/+hURYcIgvgo07S9HpqG08AjMDadBDlBPgZToYcJ8kgcsRfDk6quLmH
         LQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z7tuIrU+ZkZJi6hgSZa6yyPmsJFqpipO6I4SLg0Fmdg=;
        b=mmCS0Lx2n9uYxPpaMjyjrw7W2qFRqlOw8BhriZS+MBIDfDIPKzUe+YPzrQ5ZTNLBMF
         yoejlPVfr2ok+4IALVvZVnDrBlSULSmpoZfwH6lHKyj48WcWilLdTYjdv/bYajbSMCKg
         e8ha1JCEJTeZxuNmrnkYQzSGigdhna9d2tWUFl/yiWHBdUCeBHC7J5xxF+6a6kwltkzn
         EgkankfRz5P3g6cJpY5iniAmr41MRVbgjvOYfYg3+3Ulbo/nF3mPYHTwO0qYl1QEPLhN
         mF657xBXdrEvMDofJwfDOrKm7wQ3GDHvxM8p74EJ8Xpr2vDItPfSQ1la85gP+caocJAx
         moCg==
X-Gm-Message-State: APjAAAWAKAae65v9Lw22KYRnQZtQtnnNGr9QdAiBqXW2uXKr7TLQr9fH
        ny8pxMuht6u6ln0q8q8X2hFQdg==
X-Google-Smtp-Source: APXvYqy4i448RozY1ju/kWG3zgsaiLG21nm6IHfN5NT9eQcG3yfyoNid3fF3m3xPrlldT+JnlQSqpA==
X-Received: by 2002:a17:902:32b:: with SMTP id 40mr41002801pld.204.1556222014405;
        Thu, 25 Apr 2019 12:53:34 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t64sm47261961pfa.86.2019.04.25.12.53.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:53:33 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 17/32] coresight: Adding return code to sink::disable() operation
Date:   Thu, 25 Apr 2019 13:52:55 -0600
Message-Id: <20190425195310.31562-18-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425195310.31562-1-mathieu.poirier@linaro.org>
References: <20190425195310.31562-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to handle device reference counting inside of the sink
drivers, add a return code to the sink::disable() operation so that
proper action can be taken if a sink has not been disabled.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Tested-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Robert Walker <robert.walker@arm.com>
---
 drivers/hwtracing/coresight/coresight-etb10.c   | 3 ++-
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 5 +++--
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 5 +++--
 drivers/hwtracing/coresight/coresight-tpiu.c    | 3 ++-
 drivers/hwtracing/coresight/coresight.c         | 6 +++++-
 include/linux/coresight.h                       | 2 +-
 6 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 13c0a601d3be..23b049cef19a 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -317,7 +317,7 @@ static void etb_disable_hw(struct etb_drvdata *drvdata)
 	coresight_disclaim_device(drvdata->base);
 }
 
-static void etb_disable(struct coresight_device *csdev)
+static int etb_disable(struct coresight_device *csdev)
 {
 	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	unsigned long flags;
@@ -332,6 +332,7 @@ static void etb_disable(struct coresight_device *csdev)
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
index cf7a32ce209d..c6a0f5897684 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1393,7 +1393,7 @@ static int tmc_enable_etr_sink(struct coresight_device *csdev,
 	return -EINVAL;
 }
 
-static void tmc_disable_etr_sink(struct coresight_device *csdev)
+static int tmc_disable_etr_sink(struct coresight_device *csdev)
 {
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
@@ -1401,7 +1401,7 @@ static void tmc_disable_etr_sink(struct coresight_device *csdev)
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 	if (drvdata->reading) {
 		spin_unlock_irqrestore(&drvdata->spinlock, flags);
-		return;
+		return -EBUSY;
 	}
 
 	/* Disable the TMC only if it needs to */
@@ -1413,6 +1413,7 @@ static void tmc_disable_etr_sink(struct coresight_device *csdev)
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	dev_dbg(drvdata->dev, "TMC-ETR disabled\n");
+	return 0;
 }
 
 static const struct coresight_ops_sink tmc_etr_sink_ops = {
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 93e2ef34e734..c1b77e3c3187 100644
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
index 55204dd47479..66c25b0a785e 100644
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

