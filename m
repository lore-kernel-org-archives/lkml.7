Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4F7C3A5A4
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 22:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0121C2339F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 22:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kpr3QTAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393843AbfHVWJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 18:09:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42852 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393823AbfHVWJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 18:09:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id i30so4890163pfk.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 15:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9zuadHq2oNAonLqdCJokcmV7Tuo9vqcylSnraeruuq0=;
        b=Kpr3QTAHjS54FLrMAqnHEX87rbU/GpTGSZqfU8qQ9hxl6HzXlLA48Sn/M1KycdVeI6
         KJRdjA8uLj5Gi1uS7vdpyPz0Kw9s1VUmnULZVRTHyjf0pfqL2Q/HetGUczthXAWr9gZq
         s1rMj910XwiYgUUXbDCNTFrw2b0Liwi6uFyax9ibgDqxQlUb5bBcCgGo9WqHF+EfOCNY
         Vok1YRSY4m/O8w9HyFPA55mudsdKVOJFDk3y1ocvXxKDld3J51o+zwkHeZgyppoSnnTy
         v6GFTLNHweKRTDvOhjQKi7B1IGcuhfgiQZ4xVj04Sg0wI1ODfvlqViynwPxYi36lvVNM
         jYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9zuadHq2oNAonLqdCJokcmV7Tuo9vqcylSnraeruuq0=;
        b=sgxKUmsIL5OINBPr4qfh+PdvjonYih3W0GDgAr1SnTtZWiFpAvy5vzHiMbfvGxTGWT
         m7KQpOg2rokPbInLvjdwecLrvYj7aPxqpNfwWXJspSFDoWIxVhDyGHdQguOI9UYLE9tr
         cLNvJO++Ke2MEdQKZJ8pDoPkwOjbH4+hLwJ7wLHuiqsnKzGuWPN+ASt7tPCrkOeodTwT
         ys3L06hEAhY8mfjay3bAnD65fJbeQxDIDIg2b2IEqnfkk8MkPhHz+gWTiiA+1te7wBN2
         CDVohFWX4EESxi3s1uU1wOsBZpTKYcwCHVzkCEoDyGUPoB6G5WH+0r6vzLphd8gDrjr9
         as1A==
X-Gm-Message-State: APjAAAVY2MrJXNnwt3+F/hHDT9/Ydogern/lgr+6qjgaAMk+8wgwNnDq
        n8Zg9ej8EpAKpTEk3hbJi/d1xg==
X-Google-Smtp-Source: APXvYqy84OkTLajF4+tdro/zEbqpNFakHDW+gSLGmhAWrFYvZI20iFVQypOHf0JtT/vxegZCjr1sfw==
X-Received: by 2002:a63:607:: with SMTP id 7mr1204487pgg.240.1566511759764;
        Thu, 22 Aug 2019 15:09:19 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id s7sm377432pfb.138.2019.08.22.15.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 15:09:19 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     yabinc@google.com, suzuki.poulose@arm.com, leo.yan@linaro.org
Cc:     mike.leach@arm.com, alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] coresight: tmc-etr: Add barrier packet when moving offset forward
Date:   Thu, 22 Aug 2019 16:09:15 -0600
Message-Id: <20190822220915.8876-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190822220915.8876-1-mathieu.poirier@linaro.org>
References: <20190822220915.8876-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds barrier packets in the trace stream when the offset in the
data buffer needs to be moved forward.  Otherwise the decoder isn't aware
of the break in the stream and can't synchronise itself with the trace
data.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../hwtracing/coresight/coresight-tmc-etr.c   | 43 ++++++++++++++-----
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 4f000a03152e..0e4cd6ec5f28 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -946,10 +946,6 @@ static void tmc_sync_etr_buf(struct tmc_drvdata *drvdata)
 	WARN_ON(!etr_buf->ops || !etr_buf->ops->sync);
 
 	etr_buf->ops->sync(etr_buf, rrp, rwp);
-
-	/* Insert barrier packets at the beginning, if there was an overflow */
-	if (etr_buf->full)
-		tmc_etr_buf_insert_barrier_packet(etr_buf, etr_buf->offset);
 }
 
 static void __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
@@ -1415,10 +1411,11 @@ static void tmc_free_etr_buffer(void *config)
  * buffer to the perf ring buffer.
  */
 static void tmc_etr_sync_perf_buffer(struct etr_perf_buffer *etr_perf,
+				     unsigned long src_offset,
 				     unsigned long to_copy)
 {
 	long bytes;
-	long pg_idx, pg_offset, src_offset;
+	long pg_idx, pg_offset;
 	unsigned long head = etr_perf->head;
 	char **dst_pages, *src_buf;
 	struct etr_buf *etr_buf = etr_perf->etr_buf;
@@ -1427,7 +1424,6 @@ static void tmc_etr_sync_perf_buffer(struct etr_perf_buffer *etr_perf,
 	pg_idx = head >> PAGE_SHIFT;
 	pg_offset = head & (PAGE_SIZE - 1);
 	dst_pages = (char **)etr_perf->pages;
-	src_offset = etr_buf->offset + etr_buf->len - to_copy;
 
 	while (to_copy > 0) {
 		/*
@@ -1475,7 +1471,7 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
 		      void *config)
 {
 	bool lost = false;
-	unsigned long flags, size = 0;
+	unsigned long flags, offset, size = 0;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	struct etr_perf_buffer *etr_perf = config;
 	struct etr_buf *etr_buf = etr_perf->etr_buf;
@@ -1503,11 +1499,39 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	size = etr_buf->len;
+	offset = etr_buf->offset;
+	lost |= etr_buf->full;
+
+	/*
+	 * The ETR buffer may be bigger than the space available in the
+	 * perf ring buffer (handle->size).  If so advance the offset so that we
+	 * get the latest trace data.  In snapshot mode none of that matters
+	 * since we are expected to clobber stale data in favour of the latest
+	 * traces.
+	 */
 	if (!etr_perf->snapshot && size > handle->size) {
-		size = handle->size;
+		u32 mask = tmc_get_memwidth_mask(drvdata);
+
+		/*
+		 * Make sure the new size is aligned in accordance with the
+		 * requirement explained in function tmc_get_memwidth_mask().
+		 */
+		size = handle->size & mask;
+		offset = etr_buf->offset + etr_buf->len - size;
+
+		if (offset >= etr_buf->size)
+			offset -= etr_buf->size;
 		lost = true;
 	}
-	tmc_etr_sync_perf_buffer(etr_perf, size);
+
+	/*
+	 * Insert barrier packets at the beginning, if there was an overflow
+	 * or if the offset had to be brought forward.
+	 */
+	if (lost)
+		tmc_etr_buf_insert_barrier_packet(etr_buf, offset);
+
+	tmc_etr_sync_perf_buffer(etr_perf, offset, size);
 
 	/*
 	 * In snapshot mode we simply increment the head by the number of byte
@@ -1518,7 +1542,6 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
 	if (etr_perf->snapshot)
 		handle->head += size;
 
-	lost |= etr_buf->full;
 out:
 	/*
 	 * Don't set the TRUNCATED flag in snapshot mode because 1) the
-- 
2.17.1

