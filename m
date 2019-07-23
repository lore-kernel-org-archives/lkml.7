Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8461CC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABCA2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codeblueprint-co-uk.20150623.gappssmtp.com header.i=@codeblueprint-co-uk.20150623.gappssmtp.com header.b="m2QO0kdL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbfGWKsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 06:48:37 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38634 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729671AbfGWKsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 06:48:36 -0400
Received: by mail-ed1-f68.google.com with SMTP id r12so8591298edo.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 03:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeblueprint-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=/vbv8X7Ffa53TnjHVA0Vtm+sDJ1pMmI/u+My+FwraRA=;
        b=m2QO0kdLiNSFb6rRE9L049cc1C6UBL+zUeXbF2OB0gNyiWkLdgK2F+0p/5cRkvTBUQ
         74pku7WzeieXlWYJx25ab+fvHvpdkz1E2beMszzVrni1UJKMVtCeLJUhTml3OK/YNbD4
         zipyUn5Sk4dObc2nwMW3vVsh13ut5V2K/L4kebI+ROvkdRi9fd8oR9FwKoA6Z6BiXWWs
         Tc3ne0LO6Jz8KLwoZeW59YHPBsZHFmRdKzOSQ7STyVxywIWsVT5I5UDUprg4In6ElKl2
         s9Qo9mEwC0kaNQvyk1NIh9kLt8o3qSe6yvlyVLqQt75P2nw5ucmzRi3JFGg7/vbnPymh
         1ocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/vbv8X7Ffa53TnjHVA0Vtm+sDJ1pMmI/u+My+FwraRA=;
        b=V/cDEO1yKfV6RdTki6FMDWFDD6iEWQ7Zcey3hI0JwuGROGnXBw8hyHltBCgoZY1yI9
         /xgTwnsxgzlyk2/rjpXSHVYWoOIJMZD3qD0X1zeNp54cH1oQG2R9limyjSj4td2CEvoI
         cuqVRRutzbZHexzUSruYJt6HJqxcbKOGsTDuXjguRMCUW2yDbqZR9Jwv+lza8WVHWE9U
         ZVIHUP5q5fAkbOMg0jHXjyPJLGEOy9KyqUEcFeKj9nuk2PDFX4zJc4gpwDKbPrIoDyD0
         4fjRInV67NA+IM15XxfIBLh31srvInk4D+Z770RWibAvgkonrW+z3eD9jAfZJ+vjf7us
         BCiw==
X-Gm-Message-State: APjAAAVkpL6xU12foli6jt/jCQ+09OWLbvZhBU9fiD6iCkM15PeL5tUW
        YqmKJ49Rzmvq3eNpPt90E6A=
X-Google-Smtp-Source: APXvYqzOq5992isXNLSurSiU4XHy9//XtcjOz9XGrfXM13/Yhsx7Z7EDVFV2lELDPzO1EUplQj/D9Q==
X-Received: by 2002:a17:906:838a:: with SMTP id p10mr55331714ejx.237.1563878912114;
        Tue, 23 Jul 2019 03:48:32 -0700 (PDT)
Received: from localhost (5ec096bd.skybroadband.com. [94.192.150.189])
        by smtp.gmail.com with ESMTPSA id l1sm11632097edr.17.2019.07.23.03.48.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 03:48:31 -0700 (PDT)
From:   Matt Fleming <matt@codeblueprint.co.uk>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH v3] sched/topology: Improve load balancing on AMD EPYC
Date:   Tue, 23 Jul 2019 11:48:30 +0100
Message-Id: <20190723104830.26623-1-matt@codeblueprint.co.uk>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SD_BALANCE_{FORK,EXEC} and SD_WAKE_AFFINE are stripped in sd_init()
for any sched domains with a NUMA distance greater than 2 hops
(RECLAIM_DISTANCE). The idea being that it's expensive to balance
across domains that far apart.

However, as is rather unfortunately explained in

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
Cc: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc: Borislav Petkov <bp@alien8.de>
---
 arch/x86/kernel/cpu/amd.c |  3 +++
 include/linux/topology.h  | 14 ++++++++++++++
 kernel/sched/topology.c   |  3 ++-
 mm/khugepaged.c           |  2 +-
 mm/page_alloc.c           |  2 +-
 5 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 8d4e50428b68..d94bf83d5ee6 100644
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
@@ -824,6 +825,8 @@ static void init_amd_zn(struct cpuinfo_x86 *c)
 {
 	set_cpu_cap(c, X86_FEATURE_ZEN);
 
+	node_reclaim_distance = 32;
+
 	/*
 	 * Fix erratum 1076: CPB feature bit not being set in CPUID.
 	 * Always set it, except when running under a hypervisor.
diff --git a/include/linux/topology.h b/include/linux/topology.h
index 47a3e3c08036..579522ec446c 100644
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
index f751ce0b783e..f684fde00536 100644
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
index eaaa21b23215..ccede2425c3f 100644
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
index 272c6de1bf4e..0d54cd2c43a4 100644
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
-- 
2.13.7

