Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F9AC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 08:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A818F2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 08:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389411AbfGRI5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 04:57:14 -0400
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:46660 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726383AbfGRI5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 04:57:14 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id 113A3B879F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 09:57:11 +0100 (IST)
Received: (qmail 15222 invoked from network); 18 Jul 2019 08:57:10 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.36])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 18 Jul 2019 08:57:10 -0000
Date:   Thu, 18 Jul 2019 09:57:08 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     howaboutsynergy@protonmail.com, Vlastimil Babka <vbabka@suse.cz>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm: compaction: Avoid 100% CPU usage during compaction when
 a task is killed
Message-ID: <20190718085708.GE24383@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"howaboutsynergy" reported via kernel buzilla number 204165 that
compact_zone_order was consuming 100% CPU during a stress test for
prolonged periods of time. Specifically the following command, which
should exit in 10 seconds, was taking an excessive time to finish while
the CPU was pegged at 100%.

  stress -m 220 --vm-bytes 1000000000 --timeout 10

Tracing indicated a pattern as follows

          stress-3923  [007]   519.106208: mm_compaction_isolate_migratepages: range=(0x70bb80 ~ 0x70bb80) nr_scanned=0 nr_taken=0
          stress-3923  [007]   519.106212: mm_compaction_isolate_migratepages: range=(0x70bb80 ~ 0x70bb80) nr_scanned=0 nr_taken=0
          stress-3923  [007]   519.106216: mm_compaction_isolate_migratepages: range=(0x70bb80 ~ 0x70bb80) nr_scanned=0 nr_taken=0
          stress-3923  [007]   519.106219: mm_compaction_isolate_migratepages: range=(0x70bb80 ~ 0x70bb80) nr_scanned=0 nr_taken=0
          stress-3923  [007]   519.106223: mm_compaction_isolate_migratepages: range=(0x70bb80 ~ 0x70bb80) nr_scanned=0 nr_taken=0
          stress-3923  [007]   519.106227: mm_compaction_isolate_migratepages: range=(0x70bb80 ~ 0x70bb80) nr_scanned=0 nr_taken=0
          stress-3923  [007]   519.106231: mm_compaction_isolate_migratepages: range=(0x70bb80 ~ 0x70bb80) nr_scanned=0 nr_taken=0
          stress-3923  [007]   519.106235: mm_compaction_isolate_migratepages: range=(0x70bb80 ~ 0x70bb80) nr_scanned=0 nr_taken=0
          stress-3923  [007]   519.106238: mm_compaction_isolate_migratepages: range=(0x70bb80 ~ 0x70bb80) nr_scanned=0 nr_taken=0
          stress-3923  [007]   519.106242: mm_compaction_isolate_migratepages: range=(0x70bb80 ~ 0x70bb80) nr_scanned=0 nr_taken=0

Note that compaction is entered in rapid succession while scanning and
isolating nothing. The problem is that when a task that is compacting
receives a fatal signal, it retries indefinitely instead of exiting while
making no progress as a fatal signal is pending.

It's not easy to trigger this condition although enabling zswap helps on
the basis that the timing is altered. A very small window has to be hit
for the problem to occur (signal delivered while compacting and isolating
a PFN for migration that is not aligned to SWAP_CLUSTER_MAX).

This was reproduced locally -- 16G single socket system, 8G swap, 30% zswap
configured, vm-bytes 22000000000 using Colin Kings stress-ng implementation
from github running in a loop until the problem hits). Tracing recorded the
problem occurring almost 200K times in a short window. With this patch, the
problem hit 4 times but the task existed normally instead of consuming CPU.

This problem has existed for some time but it was made worse by
cf66f0700c8f ("mm, compaction: do not consider a need to reschedule as
contention"). Before that commit, if the same condition was hit then
locks would be quickly contended and compaction would exit that way.

I haven't included a Reported-and-tested-by as the reporters real name
is unknown but this was caught and repaired due to their testing and
tracing.  If they want a tag added then hopefully they'll say so before
this gets merged.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=204165
Fixes: cf66f0700c8f ("mm, compaction: do not consider a need to reschedule as contention")
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
CC: stable@vger.kernel.org # v5.1+
---
 mm/compaction.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 9e1b9acb116b..952dc2fb24e5 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -842,13 +842,15 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 
 		/*
 		 * Periodically drop the lock (if held) regardless of its
-		 * contention, to give chance to IRQs. Abort async compaction
-		 * if contended.
+		 * contention, to give chance to IRQs. Abort completely if
+		 * a fatal signal is pending.
 		 */
 		if (!(low_pfn % SWAP_CLUSTER_MAX)
 		    && compact_unlock_should_abort(&pgdat->lru_lock,
-					    flags, &locked, cc))
-			break;
+					    flags, &locked, cc)) {
+			low_pfn = 0;
+			goto fatal_pending;
+		}
 
 		if (!pfn_valid_within(low_pfn))
 			goto isolate_fail;
@@ -1060,6 +1062,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 	trace_mm_compaction_isolate_migratepages(start_pfn, low_pfn,
 						nr_scanned, nr_isolated);
 
+fatal_pending:
 	cc->total_migrate_scanned += nr_scanned;
 	if (nr_isolated)
 		count_compact_events(COMPACTISOLATED, nr_isolated);
