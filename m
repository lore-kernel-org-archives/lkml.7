Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3E7C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A33F2171F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uWXgpbR5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfDDDgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:36:22 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33114 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfDDDgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:36:18 -0400
Received: by mail-pl1-f195.google.com with SMTP id t16so451273plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 20:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rp82OG+X/1qzhxgu7Opyhu1qYPCsjQeQJx+i+wMOyCE=;
        b=uWXgpbR5YVsdh1tkDK3c5M04exY7enShlsPHkKIwIqAg0jQLEPod7MxEbk+H/2YFcz
         ewWG019xQA/Lf3qtj7FErkvgro8gloYUwKTnLt3zJBa0YkZg3/yTQKVP43a5ex9/trTj
         JBzE92biGwlCxAdYA4Hhd7E085uqcUxOGhHqXVKLUEl4vxT4Z8zQnRPzaTaP2iyonlxt
         YDL9xYwgQat52IAFAuTHfzAHEVwNW5QgWQSFHN5IkO1BrKu5PwOwmDA5YIz/O6wOhF8V
         BMusCcGqe0BdXZ24kQU/tmzfO11fxxnV68luRiypOvVdge7qwRy0Q64yE0uTA+KjOMcO
         L8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rp82OG+X/1qzhxgu7Opyhu1qYPCsjQeQJx+i+wMOyCE=;
        b=pwNCXr7FGGDNp+3k7pm1ESOZp0TnVgeahB0TBx4YN1ykFrHh17bJoV8B/LFSeG/9k/
         1t/HD0+McQGJv6Y7CWA4gbau2JmZNQCr2VsBCQsUlXGXBktPYZ/AireMHSIaKlhxHZus
         E+rmHLkTWcYzmbj7rRIBuqjNmc7V5DN+lwBqh8XGYokOtT1NyaTn1IL2yr7+42RHHHPV
         hR03bFJfujczGD8TXeqg6MxyB3XRx6WW9Wz3c2rRIdq4glR9cVIvLgg0tf3kiwfjLiHd
         YjP3LiQy3S/o+6PWj/P6nxjwMviQwqL1oUsHnrezoKXqE8ESuOUYv3mU+oEaSboOqmjE
         ZDLg==
X-Gm-Message-State: APjAAAX1zTwX6vMbxMQOLlezdOowl3E9N5ZH4dr+i6JYc0uLGhvOn9J4
        DB7W/agnuR0naZVKypep/ldd4A==
X-Google-Smtp-Source: APXvYqxnprVmjjSF2tnUy4v7IbtEfubrPIrN37Y9gmUqDHLVytF4Jl14psXToYqcyqwcjS/j3syzww==
X-Received: by 2002:a17:902:5a2:: with SMTP id f31mr3721169plf.119.1554348977964;
        Wed, 03 Apr 2019 20:36:17 -0700 (PDT)
Received: from xps15.imgcgcw.net ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id u5sm12212780pfm.121.2019.04.03.20.36.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 20:36:17 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        suzuki.poulose@arm.com, mike.leach@arm.com, leo.yan@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/20] coresight: Properly address concurrency in sink::update() functions
Date:   Wed,  3 Apr 2019 21:35:29 -0600
Message-Id: <20190404033541.14072-9-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190404033541.14072-1-mathieu.poirier@linaro.org>
References: <20190404033541.14072-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When operating in CPU-wide trace scenarios and working with an N:1
source/sink HW topology, update() functions need to be made atomic
in order to avoid racing with start and stop operations.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etb10.c   | 4 +++-
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 52b7d95ab498..6b50e781dc57 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -413,7 +413,7 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
 	const u32 *barrier;
 	u32 read_ptr, write_ptr, capacity;
 	u32 status, read_data;
-	unsigned long offset, to_read;
+	unsigned long offset, to_read, flags;
 	struct cs_buffers *buf = sink_config;
 	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
@@ -422,6 +422,7 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
 
 	capacity = drvdata->buffer_depth * ETB_FRAME_SIZE_WORDS;
 
+	spin_lock_irqsave(&drvdata->spinlock, flags);
 	__etb_disable_hw(drvdata);
 	CS_UNLOCK(drvdata->base);
 
@@ -532,6 +533,7 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
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

