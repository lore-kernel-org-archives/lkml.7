Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78247C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 19:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C16621848
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 19:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WVwg3TwB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732932AbfHZTqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 15:46:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45628 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732534AbfHZTqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 15:46:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id w26so12430282pfq.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 12:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CW9u0WKr9dqfCIpHqZBfiXSJtaw0A8YWyqVfALCj0kc=;
        b=WVwg3TwB0HpCikLZzH4a+tShwPXLCBRYuErCCrsm3tcP1adv5q72ZruqU3zHKVzD8S
         ByNPKX2v//T5qp3BdgQ1ilHmdKngKaYYomssiom/RZ8AIO29teRGAa1I9JvNlTD+Hpsp
         rfdfUVWOgRnOjQPbEdezmgfoI/+XmvA+wM52R4VihFTMcy8K+b5zNa+SryKqtyOiee0m
         /Tj0ZExjxZJ22hU5spBS3j2rj3SmA+SyJkUS48DJ2qard1Am+ONfatSUK8VofbA25GMY
         WV6FslRPJt0RFG1IPb6U1r4TeGBcJVHsVQVZ80mdcw7mw0QS82Gj7ZxsmCAZwEMowVaH
         MoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CW9u0WKr9dqfCIpHqZBfiXSJtaw0A8YWyqVfALCj0kc=;
        b=qvfm49T8E67fylyGRqZRmyVnNYQ5EvYCHCkI2mrcIk9zxpuky8q4QvHQ24VjvOVkrQ
         44vTs91DSdyW4MzkLGBycM4PysHHm9kem/8R52aFypczw4Wwz6H6OhuGMWh6N+Bq4aYd
         NYEHtOP8+EhKkMWpINl6f93g3OTiZ3DjDjkGsj/KKDmnWIBSnT8g1eaDq4dIxxqqT+y2
         FtNXRi5Woi+tVG/KZkfUSbg7gvY9g2CtrXlqceWeqv5XdmC5tlo+TDqY6hFO2s2BKPCD
         DmmAcA9EElON1cQsjHViV+Ux5uG2sIMfJRmgbBEPNcjRnJHWuL7pm+YfELFh1Au+diaa
         6KqA==
X-Gm-Message-State: APjAAAUknMfPDegdfS84x2d0oPXv9OmU6YSodSVjAjFfcogVh7iH2zy/
        NnaPdswIJifLlV3ejLYdTQ0mJw==
X-Google-Smtp-Source: APXvYqy1mvElBIxSMcteaEt74lmxuEQ926hHKQgX9L8nPzxDIVTjKn/u3jKSSZSkxZ0hbk581HsHSQ==
X-Received: by 2002:a63:fe52:: with SMTP id x18mr18744105pgj.344.1566848770082;
        Mon, 26 Aug 2019 12:46:10 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id c35sm13214789pgl.72.2019.08.26.12.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 12:46:09 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     suzuki.poulose@arm.com, leo.yan@linaro.org, mike.leach@arm.com
Cc:     yabinc@google.com, alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] coresight: tmc-etr: Add barrier packets when moving offset forward
Date:   Mon, 26 Aug 2019 13:46:05 -0600
Message-Id: <20190826194605.3791-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190826194605.3791-1-mathieu.poirier@linaro.org>
References: <20190826194605.3791-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds barrier packets in the trace stream when the offset in the
data buffer needs to be moved forward.  Otherwise the decoder isn't aware
of the break in the stream and can't synchronise itself with the trace
data.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Tested-by: Yabin Cui <yabinc@google.com>
---
 .../hwtracing/coresight/coresight-tmc-etr.c   | 29 +++++++++++++++----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index bae47272de98..625882bc8b08 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1418,10 +1418,11 @@ static void tmc_free_etr_buffer(void *config)
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
@@ -1430,7 +1431,6 @@ static void tmc_etr_sync_perf_buffer(struct etr_perf_buffer *etr_perf,
 	pg_idx = head >> PAGE_SHIFT;
 	pg_offset = head & (PAGE_SIZE - 1);
 	dst_pages = (char **)etr_perf->pages;
-	src_offset = etr_buf->offset + etr_buf->len - to_copy;
 
 	while (to_copy > 0) {
 		/*
@@ -1478,7 +1478,7 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
 		      void *config)
 {
 	bool lost = false;
-	unsigned long flags, size = 0;
+	unsigned long flags, offset, size = 0;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	struct etr_perf_buffer *etr_perf = config;
 	struct etr_buf *etr_buf = etr_perf->etr_buf;
@@ -1506,16 +1506,35 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	lost = etr_buf->full;
+	offset = etr_buf->offset;
 	size = etr_buf->len;
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
 
 	/* Insert barrier packets at the beginning, if there was an overflow */
 	if (lost)
 		tmc_etr_buf_insert_barrier_packet(etr_buf, etr_buf->offset);
-	tmc_etr_sync_perf_buffer(etr_perf, size);
+	tmc_etr_sync_perf_buffer(etr_perf, offset, size);
 
 	/*
 	 * In snapshot mode we simply increment the head by the number of byte
-- 
2.17.1

