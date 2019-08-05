Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23074C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 23:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E2A214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 23:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="teLFSQzd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731185AbfHEXhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 19:37:53 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:37093 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730733AbfHEXhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 19:37:52 -0400
Received: by mail-pg1-f201.google.com with SMTP id n9so50228295pgq.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 16:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=fBjJNFjoK1CAcW2n/5qAZBcAEg4a650LiNHBPnT1bA8=;
        b=teLFSQzdFhTree3GuH3s2GuOa3/Qab921rb+2lHcsNF3Q36mmpwBTCwosqfJMXKhRF
         ehSuAk72xI064YEL3vjbaFafFs9TTuIwStWRcNBJl0PITAgIhImi5Hte9gT6Z6JVA5QU
         GCdGwMMTfclbzqcWnR+tmYtxu2dBqp053GvGc2DHX76PMWaPsDX43n5BWxgfeHfjfv94
         ajnNeldBRDSHzNLzKuChwzT2zFyoIXqBPYgaxOmmSipvwGNsEC2SFwQR61tHNK+/L4V8
         8BQjqzD/GqzUxPY9AloyABiNCCpOUNuO+m0D/Wn+JpgVohng7LkFJGjmC6J3t3/kdtZU
         UMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=fBjJNFjoK1CAcW2n/5qAZBcAEg4a650LiNHBPnT1bA8=;
        b=Bqu/ab8fbXVGwZjitbT3NJpWJebxCyWiiojxLbxvF0IoADk5M1T3pNWZi6nLaNUwCl
         Amzov7qnxw6tNRgzT+oHaG0Ko3j3JCcOnqWoM4z//w3As6rF0fRvB+ttMc3QfhN8vtFA
         DTH8umSAokdyp6lgArF362u8T97kDMMdWiLv60PpA9c+hCctsU2raG1ETo1oa+Ehi8nt
         yeAxctQWrDvi0cg5tGHObxTXScVWFu6ffdmTUthsBieYLDe1cm4nZLSY5mzPq1uoxXAc
         Cl8IaWstSWqSUZEI3xVTp5gs09Jrjb+EbpRoioJjro2AhxWVYNTkGRTUgy8+8LiexRk4
         thpw==
X-Gm-Message-State: APjAAAUyOfe+D5U+TVl3+6W5PKOFOesmTjA+7Li+fAX1ucByoWDJ+f5N
        QpRNJEP0vAp3g+dpclHHwC6A2urZCg==
X-Google-Smtp-Source: APXvYqzElEKumTXzdjS5AKxhg+INSn2hflNMrkQU+AM6dd6TOj81EETimI6pwSS2tR7xd/O69Zccw7xtJRQ=
X-Received: by 2002:a63:6eca:: with SMTP id j193mr367802pgc.74.1565048271547;
 Mon, 05 Aug 2019 16:37:51 -0700 (PDT)
Date:   Mon,  5 Aug 2019 16:37:38 -0700
Message-Id: <20190805233738.136357-1-yabinc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH] coresight: tmc-etr: Fix updating buffer in not-snapshot mode.
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

Signed-off-by: Yabin Cui <yabinc@google.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 17006705287a..697e68d492af 100644
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
@@ -1423,7 +1424,6 @@ static void tmc_etr_sync_perf_buffer(struct etr_perf_buffer *etr_perf)
 	pg_offset = head & (PAGE_SIZE - 1);
 	dst_pages = (char **)etr_perf->pages;
 	src_offset = etr_buf->offset;
-	to_copy = etr_buf->len;
 
 	while (to_copy > 0) {
 		/*
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
2.22.0.770.g0f2c4a37fd-goog

