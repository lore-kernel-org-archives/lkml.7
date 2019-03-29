Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E93C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD2B2173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbfC2JNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:13:49 -0400
Received: from mga14.intel.com ([192.55.52.115]:21775 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728046AbfC2JNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:13:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2019 02:13:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,284,1549958400"; 
   d="scan'208";a="156901087"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 29 Mar 2019 02:13:45 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ben Gainey <Ben.Gainey@arm.com>, stable@vger.kernel.org
Subject: [PATCH] perf: Fix AUX record suppression
Date:   Fri, 29 Mar 2019 11:13:38 +0200
Message-Id: <20190329091338.29999-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1627314fb54a33e ("perf: Suppress AUX/OVERWRITE records") has an
unintended side-effect of also suppressing all AUX records with no flags
and non-zero size, so all the regular records in the full trace mode.
This breaks some use cases for people.

Fix this by restoring "regular" AUX records.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Fixes: 1627314fb54a33e ("perf: Suppress AUX/OVERWRITE records")
Reported-by: Ben Gainey <Ben.Gainey@arm.com>
Tested-by: Ben Gainey <Ben.Gainey@arm.com>
CC: stable@vger.kernel.org # v4.20+
---
 kernel/events/ring_buffer.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 678ccec60d8f..626256dc26c1 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -455,24 +455,21 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
 		rb->aux_head += size;
 	}
 
-	if (size || handle->aux_flags) {
-		/*
-		 * Only send RECORD_AUX if we have something useful to communicate
-		 *
-		 * Note: the OVERWRITE records by themselves are not considered
-		 * useful, as they don't communicate any *new* information,
-		 * aside from the short-lived offset, that becomes history at
-		 * the next event sched-in and therefore isn't useful.
-		 * The userspace that needs to copy out AUX data in overwrite
-		 * mode should know to use user_page::aux_head for the actual
-		 * offset. So, from now on we don't output AUX records that
-		 * have *only* OVERWRITE flag set.
-		 */
-
-		if (handle->aux_flags & ~(u64)PERF_AUX_FLAG_OVERWRITE)
-			perf_event_aux_event(handle->event, aux_head, size,
-			                     handle->aux_flags);
-	}
+	/*
+	 * Only send RECORD_AUX if we have something useful to communicate
+	 *
+	 * Note: the OVERWRITE records by themselves are not considered
+	 * useful, as they don't communicate any *new* information,
+	 * aside from the short-lived offset, that becomes history at
+	 * the next event sched-in and therefore isn't useful.
+	 * The userspace that needs to copy out AUX data in overwrite
+	 * mode should know to use user_page::aux_head for the actual
+	 * offset. So, from now on we don't output AUX records that
+	 * have *only* OVERWRITE flag set.
+	 */
+	if (size || (handle->aux_flags & ~(u64)PERF_AUX_FLAG_OVERWRITE))
+		perf_event_aux_event(handle->event, aux_head, size,
+				     handle->aux_flags);
 
 	rb->user_page->aux_head = rb->aux_head;
 	if (rb_need_aux_wakeup(rb))
-- 
2.20.1

