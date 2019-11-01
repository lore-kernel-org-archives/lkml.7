Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922E7CA9ED1
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A59C208CB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbfKAH6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 03:58:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:16169 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728769AbfKAH6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 03:58:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 00:58:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,254,1569308400"; 
   d="scan'208";a="225962518"
Received: from yhuang-dev.sh.intel.com ([10.239.159.29])
  by fmsmga004.fm.intel.com with ESMTP; 01 Nov 2019 00:58:43 -0700
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
Subject: [RFC 10/10] autonuma, memory tiering: Adjust hot threshold automatically
Date:   Fri,  1 Nov 2019 15:57:27 +0800
Message-Id: <20191101075727.26683-11-ying.huang@intel.com>
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

It isn't easy for the administrator to determine the hot threshold.
So in this patch, a method to adjust the hot threshold automatically
is implemented.  The basic idea is to control the number of the
candidate promotion pages to match the promotion rate limit.  If the
hint page fault latency of a page is less than the hot threshold, we
will try to promote the page, that is, the page is the candidate
promotion page.

If the number of the candidate promotion pages in the statistics
interval is much higher than the promotion rate limit, the hot
threshold will be lowered to reduce the number of the candidate
promotion pages.  Otherwise, the hot threshold will be raised to
increase the number of the candidate promotion pages.

To make the above method works, in each statistics interval, the total
number of the pages to check (on which the hint page faults occur) and
the hot/cold distribution need to be stable.  Because the page tables
are scanned linearly in autonuma, but the hot/cold distribution isn't
uniform along the address.  The statistics interval should be larger
than the autonuma scan period.  So in the patch, the max scan period
is used as statistics interval and it works well in our tests.

The sysctl knob kernel.numa_balancing_hot_threshold_ms becomes the
initial value and max value of the hot threshold.

The patch improves the score of pmbench memory accessing benchmark
with 80:20 read/write ratio and normal access address distribution by
5.5% with 24.6% fewer NUMA page migrations on a 2 socket Intel server
with Optance DC Persistent Memory.  Because it improves the accuracy
of the hot page selection.

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
 include/linux/mmzone.h |  3 +++
 kernel/sched/fair.c    | 48 ++++++++++++++++++++++++++++++++++++++----
 2 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 46382b058546..afd56541252c 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -772,6 +772,9 @@ typedef struct pglist_data {
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned long autonuma_jiffies;
 	unsigned long autonuma_try_migrate;
+	unsigned long autonuma_threshold_jiffies;
+	unsigned long autonuma_threshold_try_migrate;
+	unsigned long autonuma_threshold;
 #endif
 	/* Fields commonly accessed by the page reclaim scanner */
 	struct lruvec		lruvec;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0a83e9cf6685..22bdbb7afac2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1486,6 +1486,41 @@ static bool numa_migration_check_rate_limit(struct pglist_data *pgdat,
 	return true;
 }
 
+#define NUMA_MIGRATION_ADJUST_STEPS	16
+
+static void numa_migration_adjust_threshold(struct pglist_data *pgdat,
+					    unsigned long rate_limit,
+					    unsigned long ref_threshold)
+{
+	unsigned long now = jiffies, last_threshold_jiffies;
+	unsigned long unit_threshold, threshold;
+	unsigned long try_migrate, ref_try_migrate, mdiff;
+
+	last_threshold_jiffies = pgdat->autonuma_threshold_jiffies;
+	if (now > last_threshold_jiffies +
+	    msecs_to_jiffies(sysctl_numa_balancing_scan_period_max) &&
+	    cmpxchg(&pgdat->autonuma_threshold_jiffies,
+		    last_threshold_jiffies, now) == last_threshold_jiffies) {
+
+		ref_try_migrate = rate_limit *
+			sysctl_numa_balancing_scan_period_max / 1000;
+		try_migrate = node_page_state(pgdat, NUMA_TRY_MIGRATE);
+		mdiff = try_migrate - pgdat->autonuma_threshold_try_migrate;
+		unit_threshold = ref_threshold / NUMA_MIGRATION_ADJUST_STEPS;
+		threshold = pgdat->autonuma_threshold;
+		if (!threshold)
+			threshold = ref_threshold;
+		if (mdiff > ref_try_migrate * 11 / 10)
+			threshold = max(threshold - unit_threshold,
+					unit_threshold);
+		else if (mdiff < ref_try_migrate * 9 / 10)
+			threshold = min(threshold + unit_threshold,
+					ref_threshold);
+		pgdat->autonuma_threshold_try_migrate = try_migrate;
+		pgdat->autonuma_threshold = threshold;
+	}
+}
+
 bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 				int src_nid, int dst_cpu, unsigned long addr,
 				int flags)
@@ -1501,7 +1536,7 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
 	    next_promotion_node(src_nid) != -1) {
 		struct pglist_data *pgdat;
-		unsigned long rate_limit, latency, threshold;
+		unsigned long rate_limit, latency, threshold, def_threshold;
 
 		pgdat = NODE_DATA(dst_nid);
 		if (pgdat_free_space_enough(pgdat))
@@ -1511,16 +1546,21 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 		if (!(flags & TNF_YOUNG))
 			return false;
 
-		threshold = msecs_to_jiffies(
+		def_threshold = msecs_to_jiffies(
 			sysctl_numa_balancing_hot_threshold);
+		rate_limit = sysctl_numa_balancing_rate_limit <<
+			(20 - PAGE_SHIFT);
+		numa_migration_adjust_threshold(pgdat, rate_limit,
+						def_threshold);
+
+		threshold = pgdat->autonuma_threshold;
+		threshold = threshold ? : def_threshold;
 		if (flags & TNF_WRITE)
 			threshold *= 2;
 		latency = numa_hint_fault_latency(p, addr);
 		if (latency > threshold)
 			return false;
 
-		rate_limit = sysctl_numa_balancing_rate_limit <<
-			(20 - PAGE_SHIFT);
 		return numa_migration_check_rate_limit(pgdat, rate_limit,
 						       hpage_nr_pages(page));
 	}
-- 
2.23.0

