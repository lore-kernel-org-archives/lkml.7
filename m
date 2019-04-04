Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A84DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF5962147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SMDcOjyb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfDDDgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:36:16 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34029 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfDDDgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:36:14 -0400
Received: by mail-pl1-f193.google.com with SMTP id y6so449020plt.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 20:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xiLcmlCMJ/zn0zkvhqy9D58gyT8D1Vy0Vdw39LfItT8=;
        b=SMDcOjybVXwz7wdBlpqH1BT0/eZjjAPZeypnxqWiRKROmfscHf+iNCaY66vQARxiWa
         Ibc+l3pFlOKq23HYZrXxCIuEshc9ftWes8AK/YNY0pMTHDxnYf2SMZ8gq5Sx+xyEa4Bm
         CKgYtizPTT0hA2s3kz+4G10zIdcwJOd60JmdXV8gmwW+5z11y3VkzOgwiHFwnJBYfQMu
         fKIqJx4kn+oNqruuVZ2eBJZ1z94plzBRWK1o2ejb+vePaDcalOirTw5bbQMkSngSRpst
         YynmPkGCq2hyozQ7WN3Q3pN+GpwzBDamTlGj3q7Z+R62+cCjTJJSqeGy8/2SxiMupkR6
         8NFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xiLcmlCMJ/zn0zkvhqy9D58gyT8D1Vy0Vdw39LfItT8=;
        b=E9epc1HsnMlGdi2QTvYCWgKeWNNoFLYB0Jzm5PpO3I4zywB/MeZCvW4Xxr778d8uJY
         5F1VpLuXOOmNfxCvqFnbxz7UWiBrxVhkrbp1hEjU32aqsf6tQpy9754D3TK9NQ0Pro9b
         GUFUuY8EM4jJBxK4bpXwNhtucHq7G6g5Va0mCZsbG656EYWQ1pqTsT7SG0z/ZRNW5mCP
         6sBH+kMNHbq0gYxZifLjVWka11UAM0K41Zh0OAvqAunSoHKjqQSuMvtalIQuOr4j2ed4
         2KM1YJbUXukuyqImXvHVsn2Pb93wUb7YGBUgj8WKM02byuSeWLyrPa9k3N4pXKY1JsD8
         +FUQ==
X-Gm-Message-State: APjAAAWV3M8KL9h2p6irUNkryvo+7vrgqlPRjbeIdDOZiA9Qszx6j6nD
        CUQhj7v+vZEaSyPy7/fU2v2lQg==
X-Google-Smtp-Source: APXvYqxdcioGEwtl0wmEqPe48OV/nikIhd55XEe1yLomC6Q9GNFK9nVQi0i5vzJ3NuXkkoZgqBo6LQ==
X-Received: by 2002:a17:902:e684:: with SMTP id cn4mr3754075plb.71.1554348974114;
        Wed, 03 Apr 2019 20:36:14 -0700 (PDT)
Received: from xps15.imgcgcw.net ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id u5sm12212780pfm.121.2019.04.03.20.36.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 20:36:13 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        suzuki.poulose@arm.com, mike.leach@arm.com, leo.yan@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/20] coresight: Properly address errors in sink::disable() functions
Date:   Wed,  3 Apr 2019 21:35:28 -0600
Message-Id: <20190404033541.14072-8-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190404033541.14072-1-mathieu.poirier@linaro.org>
References: <20190404033541.14072-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When disabling a sink the reference counter ensures the operation goes
through if nobody else is using it.  As such if drvdata::mode is already
set do CS_MODE_DISABLED, it is an error and should be reported as such.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etb10.c   | 9 ++++-----
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 9 ++++-----
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 9 ++++-----
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 5af50a852e87..52b7d95ab498 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -341,11 +341,10 @@ static int etb_disable(struct coresight_device *csdev)
 		return -EBUSY;
 	}
 
-	/* Disable the ETB only if it needs to */
-	if (drvdata->mode != CS_MODE_DISABLED) {
-		etb_disable_hw(drvdata);
-		drvdata->mode = CS_MODE_DISABLED;
-	}
+	/* Complain if we (somehow) got out of sync */
+	WARN_ON_ONCE(drvdata->mode == CS_MODE_DISABLED);
+	etb_disable_hw(drvdata);
+	drvdata->mode = CS_MODE_DISABLED;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	dev_dbg(drvdata->dev, "ETB disabled\n");
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index d50a608a60f1..30f868676540 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -297,11 +297,10 @@ static int tmc_disable_etf_sink(struct coresight_device *csdev)
 		return -EBUSY;
 	}
 
-	/* Disable the TMC only if it needs to */
-	if (drvdata->mode != CS_MODE_DISABLED) {
-		tmc_etb_disable_hw(drvdata);
-		drvdata->mode = CS_MODE_DISABLED;
-	}
+	/* Complain if we (somehow) got out of sync */
+	WARN_ON_ONCE(drvdata->mode == CS_MODE_DISABLED);
+	tmc_etb_disable_hw(drvdata);
+	drvdata->mode = CS_MODE_DISABLED;
 
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index f90bca971367..86e748d09dc3 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1416,11 +1416,10 @@ static int tmc_disable_etr_sink(struct coresight_device *csdev)
 		return -EBUSY;
 	}
 
-	/* Disable the TMC only if it needs to */
-	if (drvdata->mode != CS_MODE_DISABLED) {
-		tmc_etr_disable_hw(drvdata);
-		drvdata->mode = CS_MODE_DISABLED;
-	}
+	/* Complain if we (somehow) got out of sync */
+	WARN_ON_ONCE(drvdata->mode == CS_MODE_DISABLED);
+	tmc_etr_disable_hw(drvdata);
+	drvdata->mode = CS_MODE_DISABLED;
 
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-- 
2.17.1

