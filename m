Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9282DC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A12208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxrfTJJc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfF1Ivv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 04:51:51 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39968 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfF1Ivt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 04:51:49 -0400
Received: by mail-pl1-f195.google.com with SMTP id a93so2875342pla.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 01:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lmnCp2g2vRBRbRWnyw5wsZG62MLOODFjodgyrO8Tg48=;
        b=qxrfTJJcFZebS8Si1nsBA2g8fSPRD73ARJqG4nOdg3169QHleUJmQLr3UBBGRgb4f2
         m5pS9EORLTDiWQ9gUZRhbOJ5dI1lA7untgGgyI6p+9hD3V8dKhE/FgVQk5vDEa65qnQJ
         wnrw17ZFkA1K1o3kaDcQlBMps1Cgjp01o9zttKYWfaVQH1XZ/raqvTWAmk5+tDbWmpBv
         pporz4v4gc2Q/ZqwtUp5KLR7+OzfmEogW56ocE65g7GUNxUlV5d+KIx6q+PVTrpMRtbS
         BWUZPEBOZU+zrRIDtxT1fOINQmrUqeiwaKjy/8FIdtvRtodIOfJvC4aeQsLACO4rWmeK
         JPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lmnCp2g2vRBRbRWnyw5wsZG62MLOODFjodgyrO8Tg48=;
        b=scf1HQDP/mS+FGN/m92DJkJYJv99X6Njc8XTkIr+hVlE1sINPnWYGVGixxv8ZBdC61
         5852QDLnNBHeB2MYbPRy5u/H/uyQe7ltJDl4lz/KHqiQKZ0bhrrsCDSr4gWbK6wTU9N3
         D+hXrpm7E6Z+eSiAdHQ6xNuNycOA+fcA2+elHGzqe3o4x8sGcZgPPPn4uwiOA8qvT8so
         T25amylekbCIjKqLUVoyW0tHPDdD/0K0p+fTSj6WOQwczH3tRQ0niHqctikj7Bi0BPc/
         KEwLisQADNUJKLx6kPV3TN4BfxBpaz5lTNxF4MSGW21Acoy8MYmg11vOAdYoIyfT2f6J
         DdGw==
X-Gm-Message-State: APjAAAWV6Q4I3oKw3kMrrA5NPIWVoJ/NfZrBwZkYlBqGoXZRiCo/K3ov
        vzPFrQjUnE8fL+tG0iaw1QAFubFMaqk=
X-Google-Smtp-Source: APXvYqxZdgC6ITfb83lB3vDLszOHFZ2LTIwl8f1AqnB/vKZQiE8uPfnXtN2b7v7WaGj/+NdXsrH/Bg==
X-Received: by 2002:a17:902:8d97:: with SMTP id v23mr9891982plo.157.1561711908758;
        Fri, 28 Jun 2019 01:51:48 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id 27sm1344076pgt.6.2019.06.28.01.51.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Jun 2019 01:51:48 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: [PATCH v4 1/2] sched/isolation: Prefer housekeeping cpu in local node
Date:   Fri, 28 Jun 2019 16:51:41 +0800
Message-Id: <1561711901-4755-2-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561711901-4755-1-git-send-email-wanpengli@tencent.com>
References: <1561711901-4755-1-git-send-email-wanpengli@tencent.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

In real product setup, there will be houseeking cpus in each nodes, it 
is prefer to do housekeeping from local node, fallback to global online 
cpumask if failed to find houseeking cpu from local node.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com> 
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
v3 -> v4:
 * have a static function for sched_numa_find_closest 
 * cleanup sched_numa_find_closest comments
v2 -> v3:
 * add sched_numa_find_closest comments
v1 -> v2:
 * introduce sched_numa_find_closest

 kernel/sched/isolation.c | 12 ++++++++++--
 kernel/sched/sched.h     |  8 +++++---
 kernel/sched/topology.c  | 20 ++++++++++++++++++++
 3 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 7b9e1e0..191f751 100644
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
index 802b1f3..ec65d90 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1261,16 +1261,18 @@ enum numa_topology_type {
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
index f751ce0..4eea2c9 100644
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
-- 
2.7.4

