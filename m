Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1C1C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EFFC2377B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbfICIbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 04:31:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59175 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbfICIbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 04:31:41 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i54Dl-0002eS-Eb; Tue, 03 Sep 2019 10:31:25 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E64841C0772;
        Tue,  3 Sep 2019 10:31:24 +0200 (CEST)
Date:   Tue, 03 Sep 2019 08:31:24 -0000
From:   "tip-bot2 for Matt Fleming" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Improve load balancing on AMD EPYC systems
Cc:     Matt Fleming <matt@codeblueprint.co.uk>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Suravee.Suthikulpanit@amd.com,
        Thomas Gleixner <tglx@linutronix.de>, Thomas.Lendacky@amd.com,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20190808195301.13222-3-matt@codeblueprint.co.uk>
References: <20190808195301.13222-3-matt@codeblueprint.co.uk>
MIME-Version: 1.0
Message-ID: <156749948482.12874.10100038281387418384.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     a55c7454a8c887b226a01d7eed088ccb5374d81e
Gitweb:        https://git.kernel.org/tip/a55c7454a8c887b226a01d7eed088ccb5374d81e
Author:        Matt Fleming <matt@codeblueprint.co.uk>
AuthorDate:    Thu, 08 Aug 2019 20:53:01 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Sep 2019 09:17:37 +02:00

sched/topology: Improve load balancing on AMD EPYC systems

SD_BALANCE_{FORK,EXEC} and SD_WAKE_AFFINE are stripped in sd_init()
for any sched domains with a NUMA distance greater than 2 hops
(RECLAIM_DISTANCE). The idea being that it's expensive to balance
across domains that far apart.

However, as is rather unfortunately explained in:

  commit 32e45ff43eaf ("mm: increase RECLAIM_DISTANCE to 30")

the value for RECLAIM_DISTANCE is based on node distance tables from
2011-era hardware.

Current AMD EPYC machines have the following NUMA node distances:

 node distances:
 node   0   1   2   3   4   5   6   7
   0:  10  16  16  16  32  32  32  32
   1:  16  10  16  16  32  32  32  32
   2:  16  16  10  16  32  32  32  32
   3:  16  16  16  10  32  32  32  32
   4:  32  32  32  32  10  16  16  16
   5:  32  32  32  32  16  10  16  16
   6:  32  32  32  32  16  16  10  16
   7:  32  32  32  32  16  16  16  10

where 2 hops is 32.

The result is that the scheduler fails to load balance properly across
NUMA nodes on different sockets -- 2 hops apart.

For example, pinning 16 busy threads to NUMA nodes 0 (CPUs 0-7) and 4
(CPUs 32-39) like so,

  $ numactl -C 0-7,32-39 ./spinner 16

causes all threads to fork and remain on node 0 until the active
balancer kicks in after a few seconds and forcibly moves some threads
to node 4.

Override node_reclaim_distance for AMD Zen.

Signed-off-by: Matt Fleming <matt@codeblueprint.co.uk>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Suravee.Suthikulpanit@amd.com
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas.Lendacky@amd.com
Cc: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20190808195301.13222-3-matt@codeblueprint.co.uk
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/cpu/amd.c |  5 +++++
 include/linux/topology.h  | 14 ++++++++++++++
 kernel/sched/topology.c   |  3 ++-
 mm/khugepaged.c           |  2 +-
 mm/page_alloc.c           |  2 +-
 5 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 8d4e504..ceeb8af 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -8,6 +8,7 @@
 #include <linux/sched.h>
 #include <linux/sched/clock.h>
 #include <linux/random.h>
+#include <linux/topology.h>
 #include <asm/processor.h>
 #include <asm/apic.h>
 #include <asm/cacheinfo.h>
@@ -824,6 +825,10 @@ static void init_amd_zn(struct cpuinfo_x86 *c)
 {
 	set_cpu_cap(c, X86_FEATURE_ZEN);
 
+#ifdef CONFIG_NUMA
+	node_reclaim_distance = 32;
+#endif
+
 	/*
 	 * Fix erratum 1076: CPB feature bit not being set in CPUID.
 	 * Always set it, except when running under a hypervisor.
diff --git a/include/linux/topology.h b/include/linux/topology.h
index 47a3e3c..579522e 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -59,6 +59,20 @@ int arch_update_cpu_topology(void);
  */
 #define RECLAIM_DISTANCE 30
 #endif
+
+/*
+ * The following tunable allows platforms to override the default node
+ * reclaim distance (RECLAIM_DISTANCE) if remote memory accesses are
+ * sufficiently fast that the default value actually hurts
+ * performance.
+ *
+ * AMD EPYC machines use this because even though the 2-hop distance
+ * is 32 (3.2x slower than a local memory access) performance actually
+ * *improves* if allowed to reclaim memory and load balance tasks
+ * between NUMA nodes 2-hops apart.
+ */
+extern int __read_mostly node_reclaim_distance;
+
 #ifndef PENALTY_FOR_NODE_WITH_CPUS
 #define PENALTY_FOR_NODE_WITH_CPUS	(1)
 #endif
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8f83e8e..b5667a2 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1284,6 +1284,7 @@ static int			sched_domains_curr_level;
 int				sched_max_numa_distance;
 static int			*sched_domains_numa_distance;
 static struct cpumask		***sched_domains_numa_masks;
+int __read_mostly		node_reclaim_distance = RECLAIM_DISTANCE;
 #endif
 
 /*
@@ -1402,7 +1403,7 @@ sd_init(struct sched_domain_topology_level *tl,
 
 		sd->flags &= ~SD_PREFER_SIBLING;
 		sd->flags |= SD_SERIALIZE;
-		if (sched_domains_numa_distance[tl->numa_level] > RECLAIM_DISTANCE) {
+		if (sched_domains_numa_distance[tl->numa_level] > node_reclaim_distance) {
 			sd->flags &= ~(SD_BALANCE_EXEC |
 				       SD_BALANCE_FORK |
 				       SD_WAKE_AFFINE);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index eaaa21b..ccede24 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -710,7 +710,7 @@ static bool khugepaged_scan_abort(int nid)
 	for (i = 0; i < MAX_NUMNODES; i++) {
 		if (!khugepaged_node_load[i])
 			continue;
-		if (node_distance(nid, i) > RECLAIM_DISTANCE)
+		if (node_distance(nid, i) > node_reclaim_distance)
 			return true;
 	}
 	return false;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 272c6de..0d54cd2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3522,7 +3522,7 @@ bool zone_watermark_ok_safe(struct zone *z, unsigned int order,
 static bool zone_allows_reclaim(struct zone *local_zone, struct zone *zone)
 {
 	return node_distance(zone_to_nid(local_zone), zone_to_nid(zone)) <=
-				RECLAIM_DISTANCE;
+				node_reclaim_distance;
 }
 #else	/* CONFIG_NUMA */
 static bool zone_allows_reclaim(struct zone *local_zone, struct zone *zone)
