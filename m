Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92C5C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE04B2189E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codeblueprint-co-uk.20150623.gappssmtp.com header.i=@codeblueprint-co-uk.20150623.gappssmtp.com header.b="MSOzjEgs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404240AbfHHTxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:53:09 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45467 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404163AbfHHTxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:53:08 -0400
Received: by mail-ed1-f67.google.com with SMTP id x19so86259955eda.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 12:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeblueprint-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sXARqBdqUQBXqrp75CLk5LlnTFHdOIgK3/ASZXfKgFk=;
        b=MSOzjEgsdrkTmYlrqo5++uPIxxVwb1N9q/JWQKpFpWZWwfv36shIcBguNS9ofvMQn0
         ZWy9CFC3uK4zlO9NvX0z5Nle1Zds+T3oVy+aNLQTvP64efuQRf5CIybkoWrZ/soXTtLb
         xYXrGxSjYyHoGVBjRMhyWUkPLXScideFLFLT4Bc8zl540URyQJP/AWAxENYdYc9JLlX3
         MIa+vpUpQNGmkee8vp6Appp9+1jKdDzmt/f3KfqsQBp2Densnc2fWdjpKnlk3UErcLlY
         BWWcdNhan2MXX4ErHCJeVry2pRlxi+FRPQjwKEfUcDfSSx7i2ynY0nmMxdygMSJAdR6T
         myKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sXARqBdqUQBXqrp75CLk5LlnTFHdOIgK3/ASZXfKgFk=;
        b=CFG3d5HmlSzihhkZI03k2a4MtwPjwpnGuPwj76XzZotaSBqzbVAzmLlRTkIY322gx9
         IOOMbkgiTTo9JPIsQtqPF+d3IX/wrD7wRloJ10a9B7LtJrlRdtPnRlkN5Sc0znDshuMc
         LoPVH3LzEieKzBbmFRVuPF1D4IA1yWfIZl3EItfebwuOUgBpWDhAmqPXrQjgt9vJ4f2y
         YMdItLDPHP/Z5lB9crQqYWk4eeFdtJOGoCWIinLXEjc7Z3mYq8+9e1oFUu9/msk9R4f9
         fpD6wzDHK7KJ+EpFQgyQ9muRNcw1zk9KOaP3UVSylsFKJztCd+7LPPHX7lpssG4gjatd
         jStQ==
X-Gm-Message-State: APjAAAXg6CaTAiqkdwiTpc7RFLFvSx3eUOU+WoC9KGYoRjTyUv3/pAR/
        D5r9YuExuJ3MGU2Q4qj0eGnsRg==
X-Google-Smtp-Source: APXvYqw0K/WQ/8dZdnI96tKu9LEuTlkHjW48PQG/W/afdYGKi98rCShUsTOL3vXbElxxD0GUI2U8YQ==
X-Received: by 2002:a17:906:31c9:: with SMTP id f9mr15178596ejf.168.1565293985754;
        Thu, 08 Aug 2019 12:53:05 -0700 (PDT)
Received: from localhost (97e6989d.skybroadband.com. [151.230.152.157])
        by smtp.gmail.com with ESMTPSA id hh16sm15370683ejb.18.2019.08.08.12.53.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 12:53:05 -0700 (PDT)
From:   Matt Fleming <matt@codeblueprint.co.uk>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Rik van Riel <riel@surriel.com>,
        Suravee.Suthikulpanit@amd.com, Borislav Petkov <bp@alien8.de>,
        Thomas.Lendacky@amd.com, Mel Gorman <mgorman@techsingularity.net>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: [PATCH v4 2/2] sched/topology: Improve load balancing on AMD EPYC
Date:   Thu,  8 Aug 2019 20:53:01 +0100
Message-Id: <20190808195301.13222-3-matt@codeblueprint.co.uk>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190808195301.13222-1-matt@codeblueprint.co.uk>
References: <20190808195301.13222-1-matt@codeblueprint.co.uk>
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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Cc: Suravee.Suthikulpanit@amd.com
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas.Lendacky@amd.com
---
 arch/x86/kernel/cpu/amd.c |  5 +++++
 include/linux/topology.h  | 14 ++++++++++++++
 kernel/sched/topology.c   |  3 ++-
 mm/khugepaged.c           |  2 +-
 mm/page_alloc.c           |  2 +-
 5 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 8d4e50428b68..ceeb8afc7cf3 100644
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
index 8f83e8e3ea9a..b5667a273bf6 100644
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

