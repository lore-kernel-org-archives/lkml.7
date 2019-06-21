Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA05C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 07:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0999F208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 07:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/nxgMG8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbfFUH20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 03:28:26 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37372 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfFUH20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 03:28:26 -0400
Received: by mail-pl1-f195.google.com with SMTP id bh12so2566948plb.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 00:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4FclFX+hRX7smZPEvP2u/zWBJAaj+hoSELqqFb76AF8=;
        b=a/nxgMG8rBvO6Z0tcmA1XvSg5kb0V2TtVLGWoVu9dKu3GfIfO9cUBTPQy+22vEy7qI
         j8xzcmGumH/f0AC0+AzUN3dUP+wO0G9Om5lqG04+SswN6jkHLB3ewiAzA+w+bBE9Yu8i
         fcmslAANCVye5jXtVOCcA9CnUIefPiUdYtBpY1CWUW2mQg18BiEldcJ95tW5aVwWHCLP
         TSlkvWAvMNRMjSQNcXt3whbg8ve32a1q/gcW8oARq74Q3DU4xeQAqSjgLO1V06hlfiWB
         LhkKLlXhMMXr6Qkg+DtV8CktoTN8SUPH+/+W8r3GCbV5WrXBtTxJBq8uI5JhsRF7IMrt
         381g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4FclFX+hRX7smZPEvP2u/zWBJAaj+hoSELqqFb76AF8=;
        b=jiYuLs7uNl/An6p+/ghiIuWxCAFc5qtJMX7eOfHzoA9KCgRjiGJS7MC43CkNXHIzkW
         HN6/OQ0g3RqGhEKgQm7YlFs5BkDnmIHJ9lXbmqw7ycT/SbJvZEq9vAF3wvJyWpjkNuVl
         gKLOPO6gWw6Vj5UcY921AaIYOdyW0aihiXbeQ3AdLxmE2+BSznF7HiTCenpw50uX+sXa
         ewyKQ0QoH91aE4w+jWZu46sD8QlFItGmoopv6/j/Jp2W2rvvJ/FiUGl56xwVIMza1iSv
         sd5MPFncoJnFhxMRShZE77xfLZu0jZljKjoFdYEDQonuO4l0NVf821qo2gIxmKdP9ics
         QyCA==
X-Gm-Message-State: APjAAAXRma1hsLVJqicSGmxO0RUQ1xJW/IoaBkHW03Ls3iNPoBZnFtt1
        SGeewBNJjQGaIrhTsYq6vKzpA/CC
X-Google-Smtp-Source: APXvYqx/rZoqtPDnhnSq+6zvgHqfTV80vsO8Rw46Lq/H2l8oT1DaaduDc9Huqwd2S18gOr4VcAnOkQ==
X-Received: by 2002:a17:902:724:: with SMTP id 33mr126468994pli.49.1561102105312;
        Fri, 21 Jun 2019 00:28:25 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id a12sm3972617pje.3.2019.06.21.00.28.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Jun 2019 00:28:24 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH v3] sched/isolation: Prefer housekeeping cpu in local node
Date:   Fri, 21 Jun 2019 15:28:15 +0800
Message-Id: <1561102095-29069-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

In real product setup, there will be houseeking cpus in each nodes, it 
is prefer to do housekeeping from local node, fallback to global online 
cpumask if failed to find houseeking cpu from local node.

Cc: Ingo Molnar <mingo@redhat.com> 
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
v2 -> v3:
 * add sched_numa_find_closest comments
v1 -> v2:
 * introduce sched_numa_find_closest

 kernel/sched/isolation.c | 12 ++++++++++--
 kernel/sched/sched.h     |  5 ++---
 kernel/sched/topology.c  | 22 ++++++++++++++++++++++
 3 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 123ea07..589afba 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -16,9 +16,17 @@ static unsigned int housekeeping_flags;
 
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
index b08dee2..0db7431 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1212,9 +1212,6 @@ enum numa_topology_type {
 extern enum numa_topology_type sched_numa_topology_type;
 extern int sched_max_numa_distance;
 extern bool find_numa_distance(int distance);
-#endif
-
-#ifdef CONFIG_NUMA
 extern void sched_init_numa(void);
 extern void sched_domains_numa_masks_set(unsigned int cpu);
 extern void sched_domains_numa_masks_clear(unsigned int cpu);
@@ -1224,6 +1221,8 @@ static inline void sched_domains_numa_masks_set(unsigned int cpu) { }
 static inline void sched_domains_numa_masks_clear(unsigned int cpu) { }
 #endif
 
+extern int sched_numa_find_closest(const struct cpumask *cpus, int cpu);
+
 #ifdef CONFIG_NUMA_BALANCING
 /* The regions in numa_faults array from task_struct */
 enum numa_faults_stats {
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 63184cf..083ef23 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1726,6 +1726,28 @@ void sched_domains_numa_masks_clear(unsigned int cpu)
 
 #endif /* CONFIG_NUMA */
 
+/*
+ * sched_numa_find_closest() - given the NUMA topology, find the cpu
+ *                             closest to @cpu from @cpumask.
+ * cpumask: cpumask to find a cpu from
+ * cpu: cpu to be close to
+ *
+ * returns: cpu, or >= nr_cpu_ids when nothing found (or !NUMA).
+ */
+int sched_numa_find_closest(const struct cpumask *cpus, int cpu)
+{
+#ifdef CONFIG_NUMA
+	int i, j = cpu_to_node(cpu);
+
+	for (i = 0; i < sched_domains_numa_levels; i++) {
+		cpu = cpumask_any_and(cpus, sched_domains_numa_masks[i][j]);
+		if (cpu < nr_cpu_ids)
+			return cpu;
+	}
+#endif
+	return nr_cpu_ids;
+}
+
 static int __sdt_alloc(const struct cpumask *cpu_map)
 {
 	struct sched_domain_topology_level *tl;
-- 
2.7.4

