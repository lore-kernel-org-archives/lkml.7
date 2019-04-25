Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC630C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0C4205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UIgR3XfD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730705AbfDYTxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:53:43 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40524 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730554AbfDYTxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:53:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id d31so362307pgl.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aWyPwAmKiV26NYLJXz5kLa0RrGlpEkg6p1STyf3/JXM=;
        b=UIgR3XfDDDzlPAaFcdmVGS/UsH5wKZ2stJgoDKiDZvU43v/jj9cr1xMDDycXQfY3be
         TAwGdyxr79UKVJTctTA/NP+5MwI4M/WPzDDSESW5gQRoV+5MYuql8N+mObfahbPH3pMD
         MLaL6FB298a5B9frgl5taSPFFDsCmOllhgZ6soIAP1Li5EZL5PVS/TcDMkHQLNTdbvUf
         cEDI4I7QvckjAYEzx3ZXbVD8HXATG71aoFLXV8C/FAeTtXpHKi60X6rDYU9SCurxq3Rp
         N9WAlkv2D47743FUkV/poVG48HlfnRUdj3qJNvaneheg9Uwk5s4uy0wl547AhFQDfZeF
         GnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aWyPwAmKiV26NYLJXz5kLa0RrGlpEkg6p1STyf3/JXM=;
        b=cp0aqUpHElChOWvndOLKBdTwXo3T7BYRUHAJ+uK+dzmeA5Yu5uSP3XKxr7HUpbvQx+
         XqDOFu+zSEFiABZMsFNLcHMEE/AZYgci71xQEVUQjdPSt6ZlzK159sIikuK1ruO+cJ8R
         x85J/dPeo6Vy36uQxceZpRckrIjLYx/FoRnIHnL6q3U3Hq0fbxFNfcwKpsqKsj94FfmP
         cy+lGqTOzHmUtzsqirFi0OIfIOJfhMvO4D6cpc3aUlP2CreuyQE4Gyj2DelNjsbm5Y1H
         NwOT6lzZPrat+B3LyY5rrggGzGMmLT7+SOYiuWDrmvwoHiCnKj6iA2K1mrcyEgXP54kJ
         651A==
X-Gm-Message-State: APjAAAV+eZ5noQdD4UNGmUKE463rZNehYcWZfdTUzp8Apl1i4ufmQDOb
        juE98bQXYB4KhxCdmRfhHpvwFg==
X-Google-Smtp-Source: APXvYqw0a7Z7YUzD7xT/lcK2wIvi/hMagwVoZvebZ9AI2l7ficwgM9wIpIgwnO0D2PpxLvgyk2DcZA==
X-Received: by 2002:a65:63cb:: with SMTP id n11mr7252692pgv.236.1556222018564;
        Thu, 25 Apr 2019 12:53:38 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t64sm47261961pfa.86.2019.04.25.12.53.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:53:37 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 20/32] coresight: Properly address concurrency in sink::update() functions
Date:   Thu, 25 Apr 2019 13:52:58 -0600
Message-Id: <20190425195310.31562-21-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425195310.31562-1-mathieu.poirier@linaro.org>
References: <20190425195310.31562-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When operating in CPU-wide trace scenarios and working with an N:1
source/sink HW topology, update() functions need to be made atomic
in order to avoid racing with start and stop operations.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Tested-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Robert Walker <robert.walker@arm.com>
---
 drivers/hwtracing/coresight/coresight-etb10.c   | 4 +++-
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 6b73bc2e0dbd..00d664c6a401 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -405,7 +405,7 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
 	const u32 *barrier;
 	u32 read_ptr, write_ptr, capacity;
 	u32 status, read_data;
-	unsigned long offset, to_read;
+	unsigned long offset, to_read, flags;
 	struct cs_buffers *buf = sink_config;
 	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
@@ -414,6 +414,7 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
 
 	capacity = drvdata->buffer_depth * ETB_FRAME_SIZE_WORDS;
 
+	spin_lock_irqsave(&drvdata->spinlock, flags);
 	__etb_disable_hw(drvdata);
 	CS_UNLOCK(drvdata->base);
 
@@ -524,6 +525,7 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
 	}
 	__etb_enable_hw(drvdata);
 	CS_LOCK(drvdata->base);
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	return to_read;
 }
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 30f868676540..a38ad2b0d95a 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -413,7 +413,7 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
 	u32 *buf_ptr;
 	u64 read_ptr, write_ptr;
 	u32 status;
-	unsigned long offset, to_read;
+	unsigned long offset, to_read, flags;
 	struct cs_buffers *buf = sink_config;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
@@ -424,6 +424,7 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
 	if (WARN_ON_ONCE(drvdata->mode != CS_MODE_PERF))
 		return 0;
 
+	spin_lock_irqsave(&drvdata->spinlock, flags);
 	CS_UNLOCK(drvdata->base);
 
 	tmc_flush_and_stop(drvdata);
@@ -517,6 +518,7 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
 		to_read = buf->nr_pages << PAGE_SHIFT;
 	}
 	CS_LOCK(drvdata->base);
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	return to_read;
 }
-- 
2.17.1

