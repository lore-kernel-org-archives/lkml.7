Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBF5C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 22:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C83582070C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 22:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iChCTuWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfHLWL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 18:11:59 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:45225 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfHLWL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 18:11:59 -0400
Received: by mail-qt1-f201.google.com with SMTP id l9so97731820qtu.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 15:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Jw1cj/+ww6TfMtRSJmzTU59qtmGQEsSIwrvBNo/N7vI=;
        b=iChCTuWckrWOil+NdSVQAXCes8B5y+65GYvCV0IakAqJktJmI/dqtiIt7UiI2ePUeJ
         uX7GWHA/fOMjJ9EroA9KTPBKBpIqHm34x/LpQfBTFSUtiQHqfLalCNCotPDpR94Y0nJo
         o1mh/M3dFf1EC0+hT6IcWPTi5U/HnvRqWstHp4Dmzei8hxvRLLPLpeIzU5wadrIp7tI3
         wUjQgUPE5yzFkpb0NUVdDmaB5oOs/vdE3L1ZCWhniXfrVEiu4W+xhpdxOHBazvyNtiDy
         LnocJc9ECkP4GZmBtQ+yX8mBiYSTItXKBf9JTH/hOBQ3k7Jz7er1kzgVuECju5/jFzLc
         RVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Jw1cj/+ww6TfMtRSJmzTU59qtmGQEsSIwrvBNo/N7vI=;
        b=WasKcxVR3liBEGivndwJ5Oaz73hJIDxlUeV3p23+UwKK6v9hVy/UkX/3rKjZts0/Z8
         v97mfs2NN3yo3MloGOosGxCI533lGoS6RuSqKXRa77ST3pONd9oD7EwewMFCUs1m2IeR
         75T3XjSsP3U/gkvi7TfkvF2+ybmrXOFxpNJJwXIgzs97bWXSEsi/BVV7/+Q7nIlZ7PXJ
         ywhIpihaGYHP85jkuMC6ne4DVsHx5i07duW3qFb52w1ALnDSE/WXO22o67S25AK6oM5v
         A2oIXBiCQSpev9j2eiTWHAZ865/ciXYgPSs6F9RFQeVpJmrz7/5Fi2LdhL46GdRLKh90
         JPnw==
X-Gm-Message-State: APjAAAWf3qAGBgZb8uKS49+xvzfTpLg3qo4rEedIOpAvEUfyVG2ja1oA
        e7Rw8qq0Ul+iTnPwK0ubtlEAFCeR+w==
X-Google-Smtp-Source: APXvYqwy1+a3pvBSx5ME8Bu1yYQnHk1MVG9t0R+bkukKv0wVXu23I1/UVkAiABDKs9aR157Lqsy4jBTtGqk=
X-Received: by 2002:ae9:e007:: with SMTP id m7mr2877964qkk.87.1565647918275;
 Mon, 12 Aug 2019 15:11:58 -0700 (PDT)
Date:   Mon, 12 Aug 2019 15:11:54 -0700
Message-Id: <20190812221154.46875-1-yabinc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v2] coresight: tmc-etr: Fix updating buffer in not-snapshot mode.
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

TMC etr always copies all available data to perf aux buffer, which
may exceed the available space in perf aux buffer. It isn't suitable
for not-snapshot mode, because:
1) It may overwrite previously written data.
2) It may make the perf_event_mmap_page->aux_head report having more
or less data than the reality.

So change to only copy the latest data fitting the available space in
perf aux buffer.

Signed-off-by: Yabin Cui <yabinc@google.com>
---

v1 -> v2: copy the latest data instead of the earliest data.

---
 .../hwtracing/coresight/coresight-tmc-etr.c    | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 17006705287a..676dcb4cf0e2 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1410,9 +1410,10 @@ static void tmc_free_etr_buffer(void *config)
  * tmc_etr_sync_perf_buffer: Copy the actual trace data from the hardware
  * buffer to the perf ring buffer.
  */
-static void tmc_etr_sync_perf_buffer(struct etr_perf_buffer *etr_perf)
+static void tmc_etr_sync_perf_buffer(struct etr_perf_buffer *etr_perf,
+				     unsigned long to_copy)
 {
-	long bytes, to_copy;
+	long bytes;
 	long pg_idx, pg_offset, src_offset;
 	unsigned long head = etr_perf->head;
 	char **dst_pages, *src_buf;
@@ -1422,8 +1423,7 @@ static void tmc_etr_sync_perf_buffer(struct etr_perf_buffer *etr_perf)
 	pg_idx = head >> PAGE_SHIFT;
 	pg_offset = head & (PAGE_SIZE - 1);
 	dst_pages = (char **)etr_perf->pages;
-	src_offset = etr_buf->offset;
-	to_copy = etr_buf->len;
+	src_offset = etr_buf->offset + etr_buf->len - to_copy;
 
 	while (to_copy > 0) {
 		/*
@@ -1434,6 +1434,8 @@ static void tmc_etr_sync_perf_buffer(struct etr_perf_buffer *etr_perf)
 		 *  3) what is available in the destination page.
 		 * in one iteration.
 		 */
+		if (src_offset >= etr_buf->size)
+			src_offset -= etr_buf->size;
 		bytes = tmc_etr_buf_get_data(etr_buf, src_offset, to_copy,
 					     &src_buf);
 		if (WARN_ON_ONCE(bytes <= 0))
@@ -1454,8 +1456,6 @@ static void tmc_etr_sync_perf_buffer(struct etr_perf_buffer *etr_perf)
 
 		/* Move source pointers */
 		src_offset += bytes;
-		if (src_offset >= etr_buf->size)
-			src_offset -= etr_buf->size;
 	}
 }
 
@@ -1501,7 +1501,11 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	size = etr_buf->len;
-	tmc_etr_sync_perf_buffer(etr_perf);
+	if (!etr_perf->snapshot && size > handle->size) {
+		size = handle->size;
+		lost = true;
+	}
+	tmc_etr_sync_perf_buffer(etr_perf, size);
 
 	/*
 	 * In snapshot mode we simply increment the head by the number of byte
-- 
2.23.0.rc1.153.gdeed80330f-goog

