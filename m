Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD855CA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09032080F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbfKAH6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 03:58:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:16169 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbfKAH6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 03:58:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 00:58:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,254,1569308400"; 
   d="scan'208";a="225962485"
Received: from yhuang-dev.sh.intel.com ([10.239.159.29])
  by fmsmga004.fm.intel.com with ESMTP; 01 Nov 2019 00:58:30 -0700
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
Subject: [RFC 04/10] autonuma, memory tiering: Rate limit NUMA migration throughput
Date:   Fri,  1 Nov 2019 15:57:21 +0800
Message-Id: <20191101075727.26683-5-ying.huang@intel.com>
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

In autonuma memory tiering mode, the hot PMEM (persistent memory)
pages could be migrated to DRAM via autonuma.  But this incurs some
overhead too.  So that sometimes the workload performance may be hurt.
To avoid too much disturbing to the workload, the migration throughput
should be rate-limited.

At the other hand, in some situation, for example, some workloads
exits, many DRAM pages become free, so that some pages of the other
workloads can be migrated to DRAM.  To respond to the workloads
changing quickly, it's better to migrate pages faster.

To address the above 2 requirements, a rate limit algorithm as follows
is used,

- If there is enough free memory in DRAM node (that is, > high
  watermark + 2 * rate limit pages), then NUMA migration throughput will
  not be rate-limited to respond to the workload changing quickly.

- Otherwise, counting the number of pages to try to migrate to a DRAM
  node via autonuma, if the count exceeds the limit specified by the
  users, stop NUMA migration until the next second.

A new sysctl knob kernel.numa_balancing_rate_limit_mbps is added for
the users to specify the limit.  If its value is 0, the default
value (high watermark) will be used.

TODO: Add ABI document for new sysctl knob.

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
 include/linux/mmzone.h       |  7 ++++
 include/linux/sched/sysctl.h |  1 +
 kernel/sched/fair.c          | 63 ++++++++++++++++++++++++++++++++++++
 kernel/sysctl.c              |  8 +++++
 mm/vmstat.c                  |  3 ++
 5 files changed, 82 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index d0b6ececaf39..46382b058546 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -247,6 +247,9 @@ enum node_stat_item {
 	NR_DIRTIED,		/* page dirtyings since bootup */
 	NR_WRITTEN,		/* page writings since bootup */
 	NR_KERNEL_MISC_RECLAIMABLE,	/* reclaimable non-slab kernel pages */
+#ifdef CONFIG_NUMA_BALANCING
+	NUMA_TRY_MIGRATE,	/* pages to try to migrate via NUMA balancing */
+#endif
 	NR_VM_NODE_STAT_ITEMS
 };
 
@@ -766,6 +769,10 @@ typedef struct pglist_data {
 	unsigned long split_queue_len;
 #endif
 
+#ifdef CONFIG_NUMA_BALANCING
+	unsigned long autonuma_jiffies;
+	unsigned long autonuma_try_migrate;
+#endif
 	/* Fields commonly accessed by the page reclaim scanner */
 	struct lruvec		lruvec;
 
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 5cfe38783c60..e3616889a91c 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -42,6 +42,7 @@ extern unsigned int sysctl_numa_balancing_scan_delay;
 extern unsigned int sysctl_numa_balancing_scan_period_min;
 extern unsigned int sysctl_numa_balancing_scan_period_max;
 extern unsigned int sysctl_numa_balancing_scan_size;
+extern unsigned int sysctl_numa_balancing_rate_limit;
 
 #ifdef CONFIG_SCHED_DEBUG
 extern __read_mostly unsigned int sysctl_sched_migration_cost;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f35930f5e528..489e2e21bb5d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1047,6 +1047,12 @@ unsigned int sysctl_numa_balancing_scan_size = 256;
 /* Scan @scan_size MB every @scan_period after an initial @scan_delay in ms */
 unsigned int sysctl_numa_balancing_scan_delay = 1000;
 
+/*
+ * Restrict the NUMA migration per second in MB for each target node
+ * if no enough free space in target node
+ */
+unsigned int sysctl_numa_balancing_rate_limit;
+
 struct numa_group {
 	refcount_t refcount;
 
@@ -1397,6 +1403,44 @@ static inline unsigned long group_weight(struct task_struct *p, int nid,
 	return 1000 * faults / total_faults;
 }
 
+static bool pgdat_free_space_enough(struct pglist_data *pgdat)
+{
+	int z;
+	unsigned long rate_limit;
+
+	rate_limit = sysctl_numa_balancing_rate_limit << (20 - PAGE_SHIFT);
+	for (z = pgdat->nr_zones - 1; z >= 0; z--) {
+		struct zone *zone = pgdat->node_zones + z;
+
+		if (!populated_zone(zone))
+			continue;
+
+		if (zone_watermark_ok(zone, 0,
+				      high_wmark_pages(zone) + rate_limit * 2,
+				      ZONE_MOVABLE, 0))
+			return true;
+	}
+	return false;
+}
+
+static bool numa_migration_check_rate_limit(struct pglist_data *pgdat,
+					    unsigned long rate_limit, int nr)
+{
+	unsigned long try_migrate;
+	unsigned long now = jiffies, last_jiffies;
+
+	mod_node_page_state(pgdat, NUMA_TRY_MIGRATE, nr);
+	try_migrate = node_page_state(pgdat, NUMA_TRY_MIGRATE);
+	last_jiffies = pgdat->autonuma_jiffies;
+	if (now > last_jiffies + HZ &&
+	    cmpxchg(&pgdat->autonuma_jiffies, last_jiffies, now) ==
+	    last_jiffies)
+		pgdat->autonuma_try_migrate = try_migrate;
+	if (try_migrate - pgdat->autonuma_try_migrate > rate_limit)
+		return false;
+	return true;
+}
+
 bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 				int src_nid, int dst_cpu)
 {
@@ -1404,6 +1448,25 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 	int dst_nid = cpu_to_node(dst_cpu);
 	int last_cpupid, this_cpupid;
 
+	/*
+	 * If memory tiering mode is enabled, will try promote pages
+	 * in slow memory node to fast memory node.
+	 */
+	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
+	    next_promotion_node(src_nid) != -1) {
+		struct pglist_data *pgdat;
+		unsigned long rate_limit;
+
+		pgdat = NODE_DATA(dst_nid);
+		if (pgdat_free_space_enough(pgdat))
+			return true;
+
+		rate_limit = sysctl_numa_balancing_rate_limit <<
+			(20 - PAGE_SHIFT);
+		return numa_migration_check_rate_limit(pgdat, rate_limit,
+						       hpage_nr_pages(page));
+	}
+
 	this_cpupid = cpu_pid_to_cpupid(dst_cpu, current->pid);
 	last_cpupid = page_cpupid_xchg_last(page, this_cpupid);
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 442acedb1fe7..c455ff404436 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -421,6 +421,14 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &one,
 	},
+	{
+		.procname	= "numa_balancing_rate_limit_mbps",
+		.data		= &sysctl_numa_balancing_rate_limit,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &zero,
+	},
 	{
 		.procname	= "numa_balancing",
 		.data		= &sysctl_numa_balancing_mode,
diff --git a/mm/vmstat.c b/mm/vmstat.c
index d4bbf9d69c06..c7ec14673ba8 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1198,6 +1198,9 @@ const char * const vmstat_text[] = {
 	"nr_dirtied",
 	"nr_written",
 	"nr_kernel_misc_reclaimable",
+#ifdef CONFIG_NUMA_BALANCING
+	"numa_try_migrate",
+#endif
 
 	/* enum writeback_stat_item counters */
 	"nr_dirty_threshold",
-- 
2.23.0

