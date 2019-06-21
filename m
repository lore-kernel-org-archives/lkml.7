Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BA1C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3712064B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5cwSWd8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfFUBoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 21:44:06 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36109 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFUBoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 21:44:05 -0400
Received: by mail-pl1-f195.google.com with SMTP id k8so2170392plt.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 18:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tkhWcpP90IbCc1eyz8PQ0udFiMlHh5Rce8pgGVY2kqc=;
        b=Y5cwSWd84cr5pT+ngrBbRH9+/jE2OLSDi0XBYRKj6+Xus5HgLPw1PJdKybc44+nUq1
         X3dWOffFmP1CVquRKX3fXOgWa8rTvna91lq/GyTuuaUPaH+RnKh9YffwEhOJRx81tOa8
         46MwCFN+/0W2M46jOSujkeC2v1R7szVirSpn4XvYNKC8TuDZ+H8h5se3jdQAwoePEaHC
         /Rzze0bP7Z5ZL/wr1D6H7RItwgP+7T/SrAg/v8ulxcNElp+ntccKXuVxK9SkHblpGGbm
         VMjZVlaodt68TaUWIaUhE4aRYv1khWwHZFnPTaUvRmNqe0kXa8zoicsrwwrJ8jEmKftr
         sKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tkhWcpP90IbCc1eyz8PQ0udFiMlHh5Rce8pgGVY2kqc=;
        b=cF0vwOZlgCwthM6618TlPQ15EHK2jVHCugQvrSxo122/3NuU7ahF9p833vhKy5bSYv
         Wt2wkFzggkDLhsKWBgdoiT8Kl4uNU5aXKISYe5rHVwsr2JbeKtLZQB5q/0ojVnAczsG2
         Psh8bresAnOVUrVgT0jcfmA/G4QYLwTI6aSLXEQraPAaxgpwrwpu2AqoFWJ495MzjkU5
         9sgKeftGehLwBvUj3aZ/GbimOnT5I7AI70Z4WcX5ZTUfPwASMoW+V6PMONt2C4hefwfs
         LuVeWztDyvHFkRbZW13blqNa809bxHvqyqf2OY3chOlTvTu4nYxwm1A3LmEs0KmEK2Hq
         AqkQ==
X-Gm-Message-State: APjAAAU5KTXlvos33zTFEmFz6xT+97tytTGOIvlqCVMht+UznX/xuKf0
        aomOvxsi+6ZPdGbULqda+QHsTmQ1
X-Google-Smtp-Source: APXvYqzrMYBb0VFopsTbd4r4MVBFyvwIJ9B3mR3PK+YTa21v0FfnE2hgifoWrwe0qsGetzNidIeJwg==
X-Received: by 2002:a17:902:1101:: with SMTP id d1mr7875672pla.212.1561080916138;
        Thu, 20 Jun 2019 18:35:16 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id p68sm707845pfb.80.2019.06.20.18.35.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Jun 2019 18:35:15 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH v2] sched/isolation: Prefer housekeeping cpu in local node
Date:   Fri, 21 Jun 2019 09:35:11 +0800
Message-Id: <1561080911-22655-1-git-send-email-wanpengli@tencent.com>
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
v1 -> v2:
 * introduce sched_numa_find_closest

 kernel/sched/isolation.c | 12 ++++++++++--
 kernel/sched/sched.h     |  5 ++---
 kernel/sched/topology.c  | 14 ++++++++++++++
 3 files changed, 26 insertions(+), 5 deletions(-)

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
index 63184cf..3d3fb04 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1726,6 +1726,20 @@ void sched_domains_numa_masks_clear(unsigned int cpu)
 
 #endif /* CONFIG_NUMA */
 
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

