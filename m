Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4A7CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 10:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A1620700
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 10:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408428AbfJRK4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 06:56:13 -0400
Received: from outbound-smtp23.blacknight.com ([81.17.249.191]:53801 "EHLO
        outbound-smtp23.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407703AbfJRK4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 06:56:11 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp23.blacknight.com (Postfix) with ESMTPS id 77FC1B885C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 11:56:08 +0100 (IST)
Received: (qmail 30789 invoked from network); 18 Oct 2019 10:56:08 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.19.210])
  by 81.17.254.9 with ESMTPA; 18 Oct 2019 10:56:08 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Borislav Petkov <bp@alien8.de>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 2/3] mm, meminit: Recalculate pcpu batch and high limits after init completes
Date:   Fri, 18 Oct 2019 11:56:05 +0100
Message-Id: <20191018105606.3249-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191018105606.3249-1-mgorman@techsingularity.net>
References: <20191018105606.3249-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deferred memory initialisation updates zone->managed_pages during
the initialisation phase but before that finishes, the per-cpu page
allocator (pcpu) calculates the number of pages allocated/freed in
batches as well as the maximum number of pages allowed on a per-cpu list.
As zone->managed_pages is not up to date yet, the pcpu initialisation
calculates inappropriately low batch and high values.

This increases zone lock contention quite severely in some cases with the
degree of severity depending on how many CPUs share a local zone and the
size of the zone. A private report indicated that kernel build times were
excessive with extremely high system CPU usage. A perf profile indicated
that a large chunk of time was lost on zone->lock contention.

This patch recalculates the pcpu batch and high values after deferred
initialisation completes on each node. It was tested on a 2-socket AMD
EPYC 2 machine using a kernel compilation workload -- allmodconfig and
all available CPUs.

mmtests configuration: config-workload-kernbench-max
Configuration was modified to build on a fresh XFS partition.

kernbench
                                5.4.0-rc3              5.4.0-rc3
                                  vanilla         resetpcpu-v1r1
Amean     user-256    13249.50 (   0.00%)    15928.40 * -20.22%*
Amean     syst-256    14760.30 (   0.00%)     4551.77 *  69.16%*
Amean     elsp-256      162.42 (   0.00%)      118.46 *  27.06%*
Stddev    user-256       42.97 (   0.00%)       50.83 ( -18.30%)
Stddev    syst-256      336.87 (   0.00%)       33.70 (  90.00%)
Stddev    elsp-256        2.46 (   0.00%)        0.81 (  67.01%)

                   5.4.0-rc3   5.4.0-rc3
                     vanillaresetpcpu-v1r1
Duration User       39766.24    47802.92
Duration System     44298.10    13671.93
Duration Elapsed      519.11      387.65

The patch reduces system CPU usage by 69.16% and total build time by
27.06%. The variance of system CPU usage is also much reduced.

Cc: stable@vger.kernel.org # v4.15+
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cafe568d36f6..0a0dd74edc83 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1818,6 +1818,14 @@ static int __init deferred_init_memmap(void *data)
 	 */
 	while (spfn < epfn)
 		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
+
+	/*
+	 * The number of managed pages has changed due to the initialisation
+	 * so the pcpu batch and high limits needs to be updated or the limits
+	 * will be artificially small.
+	 */
+	zone_pcp_update(zone);
+
 zone_empty:
 	pgdat_resize_unlock(pgdat, &flags);
 
@@ -8516,7 +8524,6 @@ void free_contig_range(unsigned long pfn, unsigned int nr_pages)
 	WARN(count != 0, "%d pages are still in use!\n", count);
 }
 
-#ifdef CONFIG_MEMORY_HOTPLUG
 /*
  * The zone indicated has a new number of managed_pages; batch sizes and percpu
  * page high values need to be recalulated.
@@ -8527,7 +8534,6 @@ void __meminit zone_pcp_update(struct zone *zone)
 	__zone_pcp_update(zone);
 	mutex_unlock(&pcp_batch_high_lock);
 }
-#endif
 
 void zone_pcp_reset(struct zone *zone)
 {
-- 
2.16.4

