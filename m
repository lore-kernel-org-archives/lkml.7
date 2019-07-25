Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE07BC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F10218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="uPRPooei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388119AbfGYQSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:18:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48885 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387564AbfGYQSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:18:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PGIHv11075655
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 09:18:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PGIHv11075655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564071497;
        bh=M8MSNdNT+I3OhyA1i0rnHeD2OKz70NAwEAGu3jLtLLY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=uPRPooeiEFyjdZDOog8mOnKt1IKh4y1Y3sg3W0itgTjdxrKVk0mWYreHJpe8eQHqb
         0pC3b3VMtC4pvDoPmuEcWRT+kYD9SzZvC0NmrhvRVr/hclUKW/Hai6sAUU6sD57YkN
         dnBOR+zrEI8m4NDxVKNMLs3ujPwTOEzRJqBskWHEoBGtSpj3Zb04B0IkJk6nT0+wdL
         r/xNY/hcB4aSRqlRsoyXSXAIJQBekaQN+1OXAOtZQfqeTC6YZLWL+RuSuSHOr0zDUS
         7EcAL3zXC14RqHEKHDm0KudY7AaJJaG1gIlfK5kuOw8l2NwGnF93q6UcKiZ6E5aZH0
         dUuQGWpxXk0ZA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PGIFSu1075651;
        Thu, 25 Jul 2019 09:18:15 -0700
Date:   Thu, 25 Jul 2019 09:18:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Wanpeng Li <tipbot@zytor.com>
Message-ID: <tip-e0e8d4911ed2695b12c3a01c15634000ede9bc73@git.kernel.org>
Cc:     torvalds@linux-foundation.org, srikar@linux.vnet.ibm.com,
        frederic@kernel.org, peterz@infradead.org, mingo@kernel.org,
        hpa@zytor.com, tglx@linutronix.de, wanpengli@tencent.com,
        linux-kernel@vger.kernel.org
Reply-To: torvalds@linux-foundation.org, srikar@linux.vnet.ibm.com,
          peterz@infradead.org, frederic@kernel.org, hpa@zytor.com,
          mingo@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, wanpengli@tencent.com
In-Reply-To: <1561711901-4755-2-git-send-email-wanpengli@tencent.com>
References: <1561711901-4755-2-git-send-email-wanpengli@tencent.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/isolation: Prefer housekeeping CPU in local
 node
Git-Commit-ID: e0e8d4911ed2695b12c3a01c15634000ede9bc73
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

Commit-ID:  e0e8d4911ed2695b12c3a01c15634000ede9bc73
Gitweb:     https://git.kernel.org/tip/e0e8d4911ed2695b12c3a01c15634000ede9bc73
Author:     Wanpeng Li <wanpengli@tencent.com>
AuthorDate: Fri, 28 Jun 2019 16:51:41 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Jul 2019 15:51:55 +0200

sched/isolation: Prefer housekeeping CPU in local node

In real product setup, there will be houseeking CPUs in each nodes, it
is prefer to do housekeeping from local node, fallback to global online
cpumask if failed to find houseeking CPU from local node.

Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1561711901-4755-2-git-send-email-wanpengli@tencent.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/isolation.c | 12 ++++++++++--
 kernel/sched/sched.h     |  8 +++++---
 kernel/sched/topology.c  | 20 ++++++++++++++++++++
 3 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index ccb28085b114..9fcb2a695a41 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -22,9 +22,17 @@ EXPORT_SYMBOL_GPL(housekeeping_enabled);
 
 int housekeeping_any_cpu(enum hk_flags flags)
 {
-	if (static_branch_unlikely(&housekeeping_overridden))
-		if (housekeeping_flags & flags)
+	int cpu;
+
+	if (static_branch_unlikely(&housekeeping_overridden)) {
+		if (housekeeping_flags & flags) {
+			cpu = sched_numa_find_closest(housekeeping_mask, smp_processor_id());
+			if (cpu < nr_cpu_ids)
+				return cpu;
+
 			return cpumask_any_and(housekeeping_mask, cpu_online_mask);
+		}
+	}
 	return smp_processor_id();
 }
 EXPORT_SYMBOL_GPL(housekeeping_any_cpu);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index aaca0e743776..16126efd14ed 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1262,16 +1262,18 @@ enum numa_topology_type {
 extern enum numa_topology_type sched_numa_topology_type;
 extern int sched_max_numa_distance;
 extern bool find_numa_distance(int distance);
-#endif
-
-#ifdef CONFIG_NUMA
 extern void sched_init_numa(void);
 extern void sched_domains_numa_masks_set(unsigned int cpu);
 extern void sched_domains_numa_masks_clear(unsigned int cpu);
+extern int sched_numa_find_closest(const struct cpumask *cpus, int cpu);
 #else
 static inline void sched_init_numa(void) { }
 static inline void sched_domains_numa_masks_set(unsigned int cpu) { }
 static inline void sched_domains_numa_masks_clear(unsigned int cpu) { }
+static inline int sched_numa_find_closest(const struct cpumask *cpus, int cpu)
+{
+	return nr_cpu_ids;
+}
 #endif
 
 #ifdef CONFIG_NUMA_BALANCING
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index f751ce0b783e..4eea2c9bc732 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1724,6 +1724,26 @@ void sched_domains_numa_masks_clear(unsigned int cpu)
 	}
 }
 
+/*
+ * sched_numa_find_closest() - given the NUMA topology, find the cpu
+ *                             closest to @cpu from @cpumask.
+ * cpumask: cpumask to find a cpu from
+ * cpu: cpu to be close to
+ *
+ * returns: cpu, or nr_cpu_ids when nothing found.
+ */
+int sched_numa_find_closest(const struct cpumask *cpus, int cpu)
+{
+	int i, j = cpu_to_node(cpu);
+
+	for (i = 0; i < sched_domains_numa_levels; i++) {
+		cpu = cpumask_any_and(cpus, sched_domains_numa_masks[i][j]);
+		if (cpu < nr_cpu_ids)
+			return cpu;
+	}
+	return nr_cpu_ids;
+}
+
 #endif /* CONFIG_NUMA */
 
 static int __sdt_alloc(const struct cpumask *cpu_map)
