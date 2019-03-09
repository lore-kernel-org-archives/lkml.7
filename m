Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34469C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 14:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF213207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 14:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfCIOk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 09:40:26 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38935 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbfCIOk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 09:40:26 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x29Ecx0h3109058
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Mar 2019 06:38:59 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x29EcutD3109054;
        Sat, 9 Mar 2019 06:38:56 -0800
Date:   Sat, 9 Mar 2019 06:38:56 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Alexander Shishkin <tipbot@zytor.com>
Message-ID: <tip-5768402fd9c6e872252b5268ad85e3fbae4fe26b@git.kernel.org>
Cc:     jolsa@redhat.com, acme@redhat.com, vincent.weaver@maine.edu,
        riel@surriel.com, mingo@kernel.org, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, dave.hansen@linux.intel.com,
        luto@kernel.org, bp@alien8.de, peterz@infradead.org,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, eranian@google.com
Reply-To: alexander.shishkin@linux.intel.com, hpa@zytor.com,
          mingo@kernel.org, acme@redhat.com, jolsa@redhat.com,
          riel@surriel.com, vincent.weaver@maine.edu,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          tglx@linutronix.de, eranian@google.com,
          dave.hansen@linux.intel.com, peterz@infradead.org, bp@alien8.de,
          luto@kernel.org
In-Reply-To: <20190215114727.62648-2-alexander.shishkin@linux.intel.com>
References: <20190215114727.62648-2-alexander.shishkin@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/ring_buffer: Use high order allocations for
 AUX buffers optimistically
Git-Commit-ID: 5768402fd9c6e872252b5268ad85e3fbae4fe26b
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

Commit-ID:  5768402fd9c6e872252b5268ad85e3fbae4fe26b
Gitweb:     https://git.kernel.org/tip/5768402fd9c6e872252b5268ad85e3fbae4fe26b
Author:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
AuthorDate: Fri, 15 Feb 2019 13:47:27 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 9 Mar 2019 14:10:30 +0100

perf/ring_buffer: Use high order allocations for AUX buffers optimistically

Currently, the AUX buffer allocator will use high-order allocations
for PMUs that don't support hardware scatter-gather chaining to ensure
large contiguous blocks of pages, and always use an array of single
pages otherwise.

There is, however, a tangible performance benefit in using larger chunks
of contiguous memory even in the latter case, that comes from not having
to fetch the next page's address at every page boundary. In particular,
a task running under Intel PT on an Atom CPU shows 1.5%-2% less runtime
penalty with a single multi-page output region in snapshot mode (no PMI)
than with multiple single-page output regions, from ~6% down to ~4%. For
the snapshot mode it does make a difference as it is intended to run over
long periods of time.

For this reason, change the allocation policy to always optimistically
start with the highest possible order when allocating pages for the AUX
buffer, desceding until the allocation succeeds or order zero allocation
fails.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: https://lkml.kernel.org/r/20190215114727.62648-2-alexander.shishkin@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/ring_buffer.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 678ccec60d8f..a4047321d7d8 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -598,29 +598,27 @@ int rb_alloc_aux(struct ring_buffer *rb, struct perf_event *event,
 {
 	bool overwrite = !(flags & RING_BUFFER_WRITABLE);
 	int node = (event->cpu == -1) ? -1 : cpu_to_node(event->cpu);
-	int ret = -ENOMEM, max_order = 0;
+	int ret = -ENOMEM, max_order;
 
 	if (!has_aux(event))
 		return -EOPNOTSUPP;
 
-	if (event->pmu->capabilities & PERF_PMU_CAP_AUX_NO_SG) {
-		/*
-		 * We need to start with the max_order that fits in nr_pages,
-		 * not the other way around, hence ilog2() and not get_order.
-		 */
-		max_order = ilog2(nr_pages);
+	/*
+	 * We need to start with the max_order that fits in nr_pages,
+	 * not the other way around, hence ilog2() and not get_order.
+	 */
+	max_order = ilog2(nr_pages);
 
-		/*
-		 * PMU requests more than one contiguous chunks of memory
-		 * for SW double buffering
-		 */
-		if ((event->pmu->capabilities & PERF_PMU_CAP_AUX_SW_DOUBLEBUF) &&
-		    !overwrite) {
-			if (!max_order)
-				return -EINVAL;
+	/*
+	 * PMU requests more than one contiguous chunks of memory
+	 * for SW double buffering
+	 */
+	if ((event->pmu->capabilities & PERF_PMU_CAP_AUX_SW_DOUBLEBUF) &&
+	    !overwrite) {
+		if (!max_order)
+			return -EINVAL;
 
-			max_order--;
-		}
+		max_order--;
 	}
 
 	rb->aux_pages = kcalloc_node(nr_pages, sizeof(void *), GFP_KERNEL,
