Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F7CC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC4D2073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbfDPLcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:32:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33703 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbfDPLcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:32:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3GBVhYl3427739
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Apr 2019 04:31:43 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3GBVgxk3427736;
        Tue, 16 Apr 2019 04:31:42 -0700
Date:   Tue, 16 Apr 2019 04:31:42 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Alexander Shishkin <tipbot@zytor.com>
Message-ID: <tip-339bc4183596e1f68c2c98a03b87aa124107c317@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        hpa@zytor.com, vincent.weaver@maine.edu, tglx@linutronix.de,
        torvalds@linux-foundation.org, acme@redhat.com,
        peterz@infradead.org, jolsa@redhat.com, Ben.Gainey@arm.com,
        eranian@google.com
Reply-To: stable@vger.kernel.org, acme@redhat.com,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          peterz@infradead.org, alexander.shishkin@linux.intel.com,
          jolsa@redhat.com, hpa@zytor.com, mingo@kernel.org,
          Ben.Gainey@arm.com, eranian@google.com, vincent.weaver@maine.edu,
          tglx@linutronix.de
In-Reply-To: <20190329091338.29999-1-alexander.shishkin@linux.intel.com>
References: <20190329091338.29999-1-alexander.shishkin@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/ring_buffer: Fix AUX record suppression
Git-Commit-ID: 339bc4183596e1f68c2c98a03b87aa124107c317
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  339bc4183596e1f68c2c98a03b87aa124107c317
Gitweb:     https://git.kernel.org/tip/339bc4183596e1f68c2c98a03b87aa124107c317
Author:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
AuthorDate: Fri, 29 Mar 2019 11:13:38 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 16 Apr 2019 12:13:57 +0200

perf/ring_buffer: Fix AUX record suppression

The following commit:

  1627314fb54a33e ("perf: Suppress AUX/OVERWRITE records")

has an unintended side-effect of also suppressing all AUX records with no flags
and non-zero size, so all the regular records in the full trace mode.
This breaks some use cases for people.

Fix this by restoring "regular" AUX records.

Reported-by: Ben Gainey <Ben.Gainey@arm.com>
Tested-by: Ben Gainey <Ben.Gainey@arm.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <stable@vger.kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Fixes: 1627314fb54a33e ("perf: Suppress AUX/OVERWRITE records")
Link: https://lkml.kernel.org/r/20190329091338.29999-1-alexander.shishkin@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/ring_buffer.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 2545ac08cc77..5eedb49a65ea 100644
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
