Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13ACACA9ECE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB52217F9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbfKAH6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 03:58:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:16169 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbfKAH6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 03:58:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 00:58:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,254,1569308400"; 
   d="scan'208";a="225962493"
Received: from yhuang-dev.sh.intel.com ([10.239.159.29])
  by fmsmga004.fm.intel.com with ESMTP; 01 Nov 2019 00:58:33 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>
Subject: [RFC 05/10] autonuma, memory tiering: Use kswapd to demote cold pages to PMEM
Date:   Fri,  1 Nov 2019 15:57:22 +0800
Message-Id: <20191101075727.26683-6-ying.huang@intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101075727.26683-1-ying.huang@intel.com>
References: <20191101075727.26683-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Ying <ying.huang@intel.com>

In a memory tiering system, if the memory size of the workloads is
smaller than that of the faster memory (e.g. DRAM) nodes, all pages of
the workloads should be put in the faster memory nodes.  But this
makes it unnecessary to use slower memory (e.g. PMEM) at all.

So in common cases, the memory size of the workload should be larger
than that of the faster memory nodes.  And to optimize the
performance, the hot pages should be promoted to the faster memory
nodes while the cold pages should be demoted to the slower memory
nodes.  To achieve that, we have two choices,

a. Promote the hot pages from the slower memory node to the faster
   memory node.  This will create some memory pressure in the faster
   memory node, thus trigger the memory reclaiming, where the cold
   pages will be demoted to the slower memory node.

b. Demote the cold pages from faster memory node to the slower memory
   node.  This will create some free memory space in the faster memory
   node, and the hot pages in the slower memory node could be promoted
   to the faster memory node.

The choice "a" will create the memory pressure in the faster memory
node.  If the memory pressure of the workload is high too, the memory
pressure may become so high that the memory allocation latency of the
workload is influenced, e.g. the direct reclaiming may be triggered.

The choice "b" works much better at this aspect.  If the memory
pressure of the workload is high, it will consume the free memory and
the hot pages promotion will stop earlier if its allocation watermark
is higher than that of the normal memory allocation.

In this patch, choice "b" is implemented.  If memory tiering NUMA
balancing mode is enabled, the node isn't the slowest node, and the
free memory size of the node is below the high watermark, the kswapd
of the node will be waken up to free some memory until the free memory
size is above the high watermark + autonuma promotion rate limit.  If
the free memory size is below the high watermark, autonuma promotion
will stop working.  This avoids to create too much memory pressure to
the system.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Fengguang Wu <fengguang.wu@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 mm/migrate.c | 26 +++++++++++++++++---------
 mm/vmscan.c  |  7 +++++++
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 8f06bd37d927..dd9e31416c10 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -47,6 +47,7 @@
 #include <linux/page_owner.h>
 #include <linux/sched/mm.h>
 #include <linux/ptrace.h>
+#include <linux/sched/sysctl.h>
 
 #include <asm/tlbflush.h>
 
@@ -1939,8 +1940,7 @@ COMPAT_SYSCALL_DEFINE6(move_pages, pid_t, pid, compat_ulong_t, nr_pages,
  * Returns true if this is a safe migration target node for misplaced NUMA
  * pages. Currently it only checks the watermarks which crude
  */
-static bool migrate_balanced_pgdat(struct pglist_data *pgdat,
-				   unsigned long nr_migrate_pages)
+static bool migrate_balanced_pgdat(struct pglist_data *pgdat, int order)
 {
 	int z;
 
@@ -1951,12 +1951,9 @@ static bool migrate_balanced_pgdat(struct pglist_data *pgdat,
 			continue;
 
 		/* Avoid waking kswapd by allocating pages_to_migrate pages. */
-		if (!zone_watermark_ok(zone, 0,
-				       high_wmark_pages(zone) +
-				       nr_migrate_pages,
-				       ZONE_MOVABLE, 0))
-			continue;
-		return true;
+		if (zone_watermark_ok(zone, order, high_wmark_pages(zone),
+				      ZONE_MOVABLE, 0))
+			return true;
 	}
 	return false;
 }
@@ -1983,8 +1980,19 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 	VM_BUG_ON_PAGE(compound_order(page) && !PageTransHuge(page), page);
 
 	/* Avoid migrating to a node that is nearly full */
-	if (!migrate_balanced_pgdat(pgdat, 1UL << compound_order(page)))
+	if (!migrate_balanced_pgdat(pgdat, compound_order(page))) {
+		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) {
+			int z;
+
+			for (z = pgdat->nr_zones - 1; z >= 0; z--) {
+				if (populated_zone(pgdat->node_zones + z))
+					break;
+			}
+			wakeup_kswapd(pgdat->node_zones + z,
+				      0, compound_order(page), ZONE_MOVABLE);
+		}
 		return 0;
+	}
 
 	if (isolate_lru_page(page))
 		return 0;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6867b49ce360..ecc7f66ee2c3 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -57,6 +57,7 @@
 
 #include <linux/swapops.h>
 #include <linux/balloon_compaction.h>
+#include <linux/sched/sysctl.h>
 
 #include "internal.h"
 
@@ -3336,8 +3337,11 @@ static bool pgdat_balanced(pg_data_t *pgdat, int order, int classzone_idx)
 {
 	int i;
 	unsigned long mark = -1;
+	unsigned long promote_ratelimit;
 	struct zone *zone;
 
+	promote_ratelimit = sysctl_numa_balancing_rate_limit <<
+		(20 - PAGE_SHIFT);
 	/*
 	 * Check watermarks bottom-up as lower zones are more likely to
 	 * meet watermarks.
@@ -3349,6 +3353,9 @@ static bool pgdat_balanced(pg_data_t *pgdat, int order, int classzone_idx)
 			continue;
 
 		mark = high_wmark_pages(zone);
+		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
+		    next_migration_node(pgdat->node_id) != -1)
+			mark += promote_ratelimit;
 		if (zone_watermark_ok_safe(zone, order, mark, classzone_idx))
 			return true;
 	}
-- 
2.23.0

