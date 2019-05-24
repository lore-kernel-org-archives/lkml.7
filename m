Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6623C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D60D2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="xwg1vsCs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389437AbfEXIHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:07:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53371 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389112AbfEXIHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:07:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4O87XLB118315
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 24 May 2019 01:07:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4O87XLB118315
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558685253;
        bh=0qG2Gnpft6XUAySvThLAZqcLVhmLseGCIOn1LPirztc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=xwg1vsCsYMok1DrQayTTS7CHdQF6nuPgfJvMjnBkqRtuiFvu55bdKGtJswfXlXd3Q
         cjVgRGcKtkjDlvAirc9Y1EyBQZ7lCrLlV0KRsvcOHgVArwO9dc+98gd7KlJglU013y
         /99sPBxF7oQGdBJzbwLN5bcA+daqpm9EbLY2bWfbH35E4Z6CW+r3/6IAZuW5iB5y9x
         lxz0lOTrgXQPZ8+d6HHaufmjcs/69KvfHhEYJqk6bfqpUSZS4+k0HNMujMDNhp9MoH
         CUY6GYVs90gTjNifyvw1y7/hfod1NPK9o44wRjM6ae6hPcT1A+cj9ygHsfqr515lze
         4AxOjz80JP3jQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4O87W0R118311;
        Fri, 24 May 2019 01:07:32 -0700
Date:   Fri, 24 May 2019 01:07:32 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Qian Cai <tipbot@zytor.com>
Message-ID: <tip-8d2bd61bd89260d5da5eaef7cf264587f19a7e0d@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        cai@lca.pw, peterz@infradead.org, mingo@kernel.org,
        torvalds@linux-foundation.org
Reply-To: tglx@linutronix.de, cai@lca.pw, mingo@kernel.org,
          peterz@infradead.org, torvalds@linux-foundation.org,
          hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <1558549206-13031-1-git-send-email-cai@lca.pw>
References: <1558549206-13031-1-git-send-email-cai@lca.pw>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/core: Clean up sched_init() a bit
Git-Commit-ID: 8d2bd61bd89260d5da5eaef7cf264587f19a7e0d
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

Commit-ID:  8d2bd61bd89260d5da5eaef7cf264587f19a7e0d
Gitweb:     https://git.kernel.org/tip/8d2bd61bd89260d5da5eaef7cf264587f19a7e0d
Author:     Qian Cai <cai@lca.pw>
AuthorDate: Wed, 22 May 2019 14:20:06 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 24 May 2019 08:57:29 +0200

sched/core: Clean up sched_init() a bit

Compiling a kernel with both FAIR_GROUP_SCHED=n and RT_GROUP_SCHED=n
will generate a warning using W=1:

  kernel/sched/core.c: In function 'sched_init':
  kernel/sched/core.c:5906:32: warning: variable 'ptr' set but not used

Use this opportunity to tidy up a code a bit by removing unnecssary
indentations and lines.

Signed-off-by: Qian Cai <cai@lca.pw>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1558549206-13031-1-git-send-email-cai@lca.pw
[ Also remove some of the unnecessary #endif comments. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 45 +++++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 874c427742a9..9dc65b2957d1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5903,36 +5903,29 @@ DECLARE_PER_CPU(cpumask_var_t, select_idle_mask);
 void __init sched_init(void)
 {
 	int i, j;
-	unsigned long alloc_size = 0, ptr;
+#if defined(CONFIG_FAIR_GROUP_SCHED) || defined(CONFIG_RT_GROUP_SCHED)
+	unsigned long alloc_size = 2 * nr_cpu_ids * sizeof(void **);
+	unsigned long ptr = (unsigned long)kzalloc(alloc_size, GFP_NOWAIT);
 
-	wait_bit_init();
-
-#ifdef CONFIG_FAIR_GROUP_SCHED
-	alloc_size += 2 * nr_cpu_ids * sizeof(void **);
-#endif
-#ifdef CONFIG_RT_GROUP_SCHED
-	alloc_size += 2 * nr_cpu_ids * sizeof(void **);
 #endif
-	if (alloc_size) {
-		ptr = (unsigned long)kzalloc(alloc_size, GFP_NOWAIT);
+	wait_bit_init();
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-		root_task_group.se = (struct sched_entity **)ptr;
-		ptr += nr_cpu_ids * sizeof(void **);
+	root_task_group.se = (struct sched_entity **)ptr;
+	ptr += nr_cpu_ids * sizeof(void **);
 
-		root_task_group.cfs_rq = (struct cfs_rq **)ptr;
-		ptr += nr_cpu_ids * sizeof(void **);
+	root_task_group.cfs_rq = (struct cfs_rq **)ptr;
+	ptr += nr_cpu_ids * sizeof(void **);
 
-#endif /* CONFIG_FAIR_GROUP_SCHED */
+#endif
 #ifdef CONFIG_RT_GROUP_SCHED
-		root_task_group.rt_se = (struct sched_rt_entity **)ptr;
-		ptr += nr_cpu_ids * sizeof(void **);
+	root_task_group.rt_se = (struct sched_rt_entity **)ptr;
+	ptr += nr_cpu_ids * sizeof(void **);
 
-		root_task_group.rt_rq = (struct rt_rq **)ptr;
-		ptr += nr_cpu_ids * sizeof(void **);
+	root_task_group.rt_rq = (struct rt_rq **)ptr;
+	ptr += nr_cpu_ids * sizeof(void **);
 
-#endif /* CONFIG_RT_GROUP_SCHED */
-	}
+#endif
 #ifdef CONFIG_CPUMASK_OFFSTACK
 	for_each_possible_cpu(i) {
 		per_cpu(load_balance_mask, i) = (cpumask_var_t)kzalloc_node(
@@ -5940,7 +5933,7 @@ void __init sched_init(void)
 		per_cpu(select_idle_mask, i) = (cpumask_var_t)kzalloc_node(
 			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
 	}
-#endif /* CONFIG_CPUMASK_OFFSTACK */
+#endif
 
 	init_rt_bandwidth(&def_rt_bandwidth, global_rt_period(), global_rt_runtime());
 	init_dl_bandwidth(&def_dl_bandwidth, global_rt_period(), global_rt_runtime());
@@ -5950,9 +5943,8 @@ void __init sched_init(void)
 #endif
 
 #ifdef CONFIG_RT_GROUP_SCHED
-	init_rt_bandwidth(&root_task_group.rt_bandwidth,
-			global_rt_period(), global_rt_runtime());
-#endif /* CONFIG_RT_GROUP_SCHED */
+	init_rt_bandwidth(&root_task_group.rt_bandwidth, global_rt_period(), global_rt_runtime());
+#endif
 
 #ifdef CONFIG_CGROUP_SCHED
 	task_group_cache = KMEM_CACHE(task_group, 0);
@@ -5961,7 +5953,7 @@ void __init sched_init(void)
 	INIT_LIST_HEAD(&root_task_group.children);
 	INIT_LIST_HEAD(&root_task_group.siblings);
 	autogroup_init(&init_task);
-#endif /* CONFIG_CGROUP_SCHED */
+#endif
 
 	for_each_possible_cpu(i) {
 		struct rq *rq;
@@ -6031,6 +6023,7 @@ void __init sched_init(void)
 		rq->last_blocked_load_update_tick = jiffies;
 		atomic_set(&rq->nohz_flags, 0);
 #endif
+
 #endif /* CONFIG_SMP */
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
