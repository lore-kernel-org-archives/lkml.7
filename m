Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54B2C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 20:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A796207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 20:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="bhX3hmEN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfFDUqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 16:46:19 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39421 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfFDUqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 16:46:19 -0400
Received: by mail-qt1-f195.google.com with SMTP id i34so2078616qta.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 13:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=c88XoKITMsSgEqIMyQ3drS89O9rn+/C1xXVo2kxkkPs=;
        b=bhX3hmENQOddONUbQsso6uoqnqEX315jBUeFm9A+Eanve4Mu9lg/q2VdZL/JKlS5KJ
         ALmgVpmXrl2TOmnLD7Tm3rIeRM21K722em987mLSPYPd+Na7AN3j7IED16k0krS4YM4r
         mSxIF/JFCTLp5wDupniIPH5olUw6Xl6GnswdV0bpRUXsuiK9jsFmECTzlYIvc1HbO5hM
         0wEDlpG8f7nRvVcD81suVdYIB5kKlk9lFpUIM/ZbGVahKjcX/qgR+eHIlH1jJolXkw3u
         mq7drs5JEiqcDo7fDf1pWefRO9t0/BFEw5xKfCbXbzPeXKKRWGNRQzcuineL3mQtkEzG
         GDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=c88XoKITMsSgEqIMyQ3drS89O9rn+/C1xXVo2kxkkPs=;
        b=Qgb8B/de5dCWTFASvamuJTCfJ+vKnWjxQzwN8fNstJNtnK/eVtX1eC2XR+1z4ALtG+
         4DsE7GDdvEUxvWFbxRMKIsBnfvhtcaFmv0ytMb8cxu29cPVqcMFEOsoVHeZnNaZYvPae
         w5JWqItmjsT8X/SZAr9wCOabARW9k84myFD/PfNNT7/V2VB4I9zJCzpOI7AY0dNSDGxU
         65W7XYTZ9guMMBlPZL39uMnhARxuEsOSYRI0bRRCOZ5IsoeOpvLzSlHWyym8danRyCnI
         r1UL0dB5xD+JM3RJhAyTvMjreGt5TTVRXaQCOV4Txgects4v8u1iWPd4VbvQtiy+kNli
         8NbQ==
X-Gm-Message-State: APjAAAVw1gwjxh+GcUdthJdtY6J5Gb/C5N7RJYYdmXQezEcX35UNiKPo
        qltATX8vJ732/YY9nzByOuLYzq+Zv4k=
X-Google-Smtp-Source: APXvYqwSI+Wr/W+nZDzv1n87lVgwwCy6mvnUaqk5IrIbaL1CFL77k9ENrSpg1Z+II+3QbZY8B94tbA==
X-Received: by 2002:aed:3fc3:: with SMTP id w3mr2687259qth.168.1559681178163;
        Tue, 04 Jun 2019 13:46:18 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id p62sm9217928qkc.42.2019.06.04.13.46.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 13:46:17 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     mingo@kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH v2] sched/core: clean up sched_init() a bit
Date:   Tue,  4 Jun 2019 16:46:02 -0400
Message-Id: <1559681162-5385-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling a kernel with both FAIR_GROUP_SCHED=n and RT_GROUP_SCHED=n
will generate a warning using W=1:

  kernel/sched/core.c: In function 'sched_init':
  kernel/sched/core.c:5906:32: warning: variable 'ptr' set but not used

Use this opportunity to tidy up a code a bit by removing unnecssary
indentations, #endif comments and lines.

Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: Fix an oversight when both FAIR_GROUP_SCHED and RT_GROUP_SCHED
    selected which was found by the 0day kernel testing robot.

 kernel/sched/core.c | 50 +++++++++++++++++++++++---------------------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 874c427742a9..edebd5e97542 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5903,36 +5903,31 @@ int in_sched_functions(unsigned long addr)
 void __init sched_init(void)
 {
 	int i, j;
-	unsigned long alloc_size = 0, ptr;
-
-	wait_bit_init();
-
-#ifdef CONFIG_FAIR_GROUP_SCHED
-	alloc_size += 2 * nr_cpu_ids * sizeof(void **);
+#if defined(CONFIG_FAIR_GROUP_SCHED) && defined(CONFIG_RT_GROUP_SCHED)
+	unsigned long alloc_size = 4 * nr_cpu_ids * sizeof(void **);
+	unsigned long ptr = (unsigned long)kzalloc(alloc_size, GFP_NOWAIT);
+#elif defined(CONFIG_FAIR_GROUP_SCHED) || defined(CONFIG_RT_GROUP_SCHED)
+	unsigned long alloc_size = 2 * nr_cpu_ids * sizeof(void **);
+	unsigned long ptr = (unsigned long)kzalloc(alloc_size, GFP_NOWAIT);
 #endif
-#ifdef CONFIG_RT_GROUP_SCHED
-	alloc_size += 2 * nr_cpu_ids * sizeof(void **);
-#endif
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
@@ -5940,7 +5935,7 @@ void __init sched_init(void)
 		per_cpu(select_idle_mask, i) = (cpumask_var_t)kzalloc_node(
 			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
 	}
-#endif /* CONFIG_CPUMASK_OFFSTACK */
+#endif
 
 	init_rt_bandwidth(&def_rt_bandwidth, global_rt_period(), global_rt_runtime());
 	init_dl_bandwidth(&def_dl_bandwidth, global_rt_period(), global_rt_runtime());
@@ -5950,9 +5945,9 @@ void __init sched_init(void)
 #endif
 
 #ifdef CONFIG_RT_GROUP_SCHED
-	init_rt_bandwidth(&root_task_group.rt_bandwidth,
-			global_rt_period(), global_rt_runtime());
-#endif /* CONFIG_RT_GROUP_SCHED */
+	init_rt_bandwidth(&root_task_group.rt_bandwidth, global_rt_period(),
+			  global_rt_runtime());
+#endif
 
 #ifdef CONFIG_CGROUP_SCHED
 	task_group_cache = KMEM_CACHE(task_group, 0);
@@ -5961,7 +5956,7 @@ void __init sched_init(void)
 	INIT_LIST_HEAD(&root_task_group.children);
 	INIT_LIST_HEAD(&root_task_group.siblings);
 	autogroup_init(&init_task);
-#endif /* CONFIG_CGROUP_SCHED */
+#endif
 
 	for_each_possible_cpu(i) {
 		struct rq *rq;
@@ -6031,6 +6026,7 @@ void __init sched_init(void)
 		rq->last_blocked_load_update_tick = jiffies;
 		atomic_set(&rq->nohz_flags, 0);
 #endif
+
 #endif /* CONFIG_SMP */
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
-- 
1.8.3.1

