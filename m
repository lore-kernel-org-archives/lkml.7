Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8091DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5991821773
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbfC2JMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:12:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:14002 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728703AbfC2JMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:12:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2019 02:12:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,284,1549958400"; 
   d="scan'208";a="333147931"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 29 Mar 2019 02:12:28 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH] perf: Fix the address filterig fix
Date:   Fri, 29 Mar 2019 11:12:12 +0200
Message-Id: <20190329091212.29870-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c60f83b813e5 ("perf, pt, coresight: Fix address filters for vmas
with non-zero offset") changes the address filtering logic to communicate
filter ranges to the PMU driver via a single address range object, instead
of having the driver do the final bit of math. That change forgets to take
into account kernel filters, which are not calculated the same way as DSO
based filters.

Fix that by passing the kernel filters the same way as file-based filters.
This doesn't require any additional changes in the drivers.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Fixes: c60f83b813e5 ("perf, pt, coresight: Fix address filters for vmas with non-zero offset")
Reported-by: Adrian Hunter <adrian.hunter@intel.com>
---
 kernel/events/core.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5f59d848171e..53e7188fa854 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9041,26 +9041,29 @@ static void perf_event_addr_filters_apply(struct perf_event *event)
 	if (task == TASK_TOMBSTONE)
 		return;
 
-	if (!ifh->nr_file_filters)
-		return;
-
-	mm = get_task_mm(event->ctx->task);
-	if (!mm)
-		goto restart;
+	if (ifh->nr_file_filters) {
+		mm = get_task_mm(event->ctx->task);
+		if (!mm)
+			goto restart;
 
-	down_read(&mm->mmap_sem);
+		down_read(&mm->mmap_sem);
+	}
 
 	raw_spin_lock_irqsave(&ifh->lock, flags);
 	list_for_each_entry(filter, &ifh->list, entry) {
-		event->addr_filter_ranges[count].start = 0;
-		event->addr_filter_ranges[count].size = 0;
+		if (filter->path.dentry) {
+			/*
+			 * Adjust base offset if the filter is associated to a
+			 * binary that needs to be mapped:
+			 */
+			event->addr_filter_ranges[count].start = 0;
+			event->addr_filter_ranges[count].size = 0;
 
-		/*
-		 * Adjust base offset if the filter is associated to a binary
-		 * that needs to be mapped:
-		 */
-		if (filter->path.dentry)
 			perf_addr_filter_apply(filter, mm, &event->addr_filter_ranges[count]);
+		} else {
+			event->addr_filter_ranges[count].start = filter->offset;
+			event->addr_filter_ranges[count].size  = filter->size;
+		}
 
 		count++;
 	}
@@ -9068,9 +9071,11 @@ static void perf_event_addr_filters_apply(struct perf_event *event)
 	event->addr_filters_gen++;
 	raw_spin_unlock_irqrestore(&ifh->lock, flags);
 
-	up_read(&mm->mmap_sem);
+	if (ifh->nr_file_filters) {
+		up_read(&mm->mmap_sem);
 
-	mmput(mm);
+		mmput(mm);
+	}
 
 restart:
 	perf_event_stop(event, 1);
-- 
2.20.1

