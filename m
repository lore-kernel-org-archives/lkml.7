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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7FFC5B576
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB6220B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHZTLQ59"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfF1AnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 20:43:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40124 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfF1AnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 20:43:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so2049157pfp.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 17:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d162iqtuNRNjSY3NyB0aYNZBj8AFFyHaBGabROY5zB0=;
        b=YHZTLQ59iv53WzHQFefXff3T56dcMxiJD5Yctll4VgHgaQgI4i3ZrviitjnvQGXV+r
         BuCh2omzPIM+C2pkLzOmE9Jc5FH3pDKkJfdP1qkHjI2Ef31JGHo1RuCHFwcdN4HmE+AL
         I14oFVB5nj3oYfn/jeqXY2x/qhpP94moQHLjMDmLNPO39wT04oJgXQu9xduuOzsJwt/7
         BKG++PDEmepZGsiQLRJ6Il+wOePVG+23eyEABZMSVEijkbisWLuTGiE+JTrbixCpaXF7
         RDJF2tiY190d21PRwcKzT7WicYf8U4ts1Jmer3/y2sYjjEmGjI+V43FlWJd7WlR1BjEP
         SPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d162iqtuNRNjSY3NyB0aYNZBj8AFFyHaBGabROY5zB0=;
        b=cvE0jQEQTZZ0QFKDJ7Ax7SM6f37/MEpmFQpPLD0+wU/eql27MhyelZsSYySQTCkSn/
         /pqADDOY4QktrZhP9hCEPRSiDKqPEKTk9ZuFjLIWp2ZMyIKr/NH3uwyTfZcv+tkxeec8
         2YQSLKwH6x3P09IhTdZ4GU6MxlpRMA7EgxfvKDwbmHBpFGlDM6ZJYJveh28S7MKoXu4x
         J30c8jPcPiuasxeOunrTLp/INnFmwUadE6RhFapZDU8FeVCibpBGdGpojz4VmN/XFM2J
         xLe+JwUP5UZFvRTs+iicHMXo0k8XQESYF1FurdLIzaci1fVpvEUjjLLOqpNpqGl9Vc47
         ZtgA==
X-Gm-Message-State: APjAAAVDkjCjBX6RrTxpPd4aDYicqRvWVmacppv6iZi6+Xw+Hey6uY7W
        1v/2oiOGltLy7QMwESaoBdgbGWRdvtM=
X-Google-Smtp-Source: APXvYqxF6Ecy7iu+6E0RPNfyb8EPwgopzuozwBqRw3ed6fOh33U3LXSxDdVWMS2cXAGLtfsaaCGhKA==
X-Received: by 2002:a17:90a:d817:: with SMTP id a23mr9417481pjv.54.1561682601211;
        Thu, 27 Jun 2019 17:43:21 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id n89sm11927802pjc.0.2019.06.27.17.43.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Jun 2019 17:43:20 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH RESEND v3] sched/isolation: Prefer housekeeping cpu in local node
Date:   Fri, 28 Jun 2019 08:43:13 +0800
Message-Id: <1561682593-12071-2-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561682593-12071-1-git-send-email-wanpengli@tencent.com>
References: <1561682593-12071-1-git-send-email-wanpengli@tencent.com>
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
Cc: Thomas Gleixner <tglx@linutronix.de>
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

