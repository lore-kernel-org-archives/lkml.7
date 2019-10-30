Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8EFCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A5AB208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="iY3TrIc9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbfJ3Sew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 14:34:52 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41417 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbfJ3Sec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 14:34:32 -0400
Received: by mail-yw1-f68.google.com with SMTP id j131so1184866ywa.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 11:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=e+89YRcmk1O/FMy0n4jL4cWpTuvw/qC5kgSeWA8MCIo=;
        b=iY3TrIc9QP23eyLvfOX9opzG/1sSREIwR79LorZsQ+XW+DT/cIIbALiQKVynPPsj3o
         6lkA/DLhVxCNMMVQRP1grGcISdGsNzhcIrW/rWcsiCMNmJLxPtzcOiV1IF+BQhFhgDUm
         UNZlsMpVenfqsas1Vd7Orh6EVm3926HrTsX0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=e+89YRcmk1O/FMy0n4jL4cWpTuvw/qC5kgSeWA8MCIo=;
        b=paKbRzPPnFfyaP+vJNUzFK8AL8zoan/V5kmT2IKEaHYJY6+ex4K+7TBLNjWf130BHW
         P6igZ9oTqWvP9E03J7WyeQzCeQHPqHf/V0eFDdGPTNBJk45CuKHjPXcnKnu0DJMdDLGR
         FOhQ6V7+ObF17V5/intT0wzwXBqxHqacbEXeSJtG8Ud3urc7zViCJK2NVRSnGnXRai4K
         a28upfOTgzmVEFTjK76EMKFwComWxyVWBBboApXZmYJ5pxYXbIum7ucNb8kViJqzkwxg
         OX/wy2ID5UtBltjzX5QP3LLZ21cT6ibc5gfEe1P3JYdLG60gWecE7dRBnrM3Pq3Tg8E6
         n8nw==
X-Gm-Message-State: APjAAAW04zZUM4NSxfcsMFk/cSsYbA+68tjIcWEWma/aSKEeQjOhr2/8
        xEivdOqiVemaJZrA9PqU9CGC9Q==
X-Google-Smtp-Source: APXvYqzLXNhGp140MEehLun5dVgYcRMpwIGYHHPVEYSB2zkyksphy99KjqyE9EM2eCOz2yL+kYpbDQ==
X-Received: by 2002:a81:8242:: with SMTP id s63mr899957ywf.176.1572460470934;
        Wed, 30 Oct 2019 11:34:30 -0700 (PDT)
Received: from vpillai-dev.sfo2.internal.digitalocean.com ([138.68.32.68])
        by smtp.gmail.com with ESMTPSA id d205sm722151ywh.75.2019.10.30.11.34.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Oct 2019 11:34:30 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     Aaron Lu <aaron.lu@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, Dario Faggioli <dfaggioli@suse.com>,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Aaron Lu <ziqian.lzq@antfin.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>
Subject: [RFC PATCH v4 18/19] sched/fair: core wide vruntime comparison
Date:   Wed, 30 Oct 2019 18:33:31 +0000
Message-Id: <de8cdd84373ccadd585bbf3af849aafb1ca65a66.1572437285.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1572437285.git.vpillai@digitalocean.com>
References: <cover.1572437285.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1572437285.git.vpillai@digitalocean.com>
References: <cover.1572437285.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaron Lu <aaron.lu@linux.alibaba.com>

This patch provides a vruntime based way to compare two cfs task's
priority, be it on the same cpu or different threads of the same core.

When the two tasks are on the same CPU, we just need to find a common
cfs_rq both sched_entities are on and then do the comparison.

When the two tasks are on differen threads of the same core, the root
level sched_entities to which the two tasks belong will be used to do
the comparison.

An ugly illustration for the cross CPU case:

   cpu0         cpu1
 /   |  \     /   |  \
se1 se2 se3  se4 se5 se6
    /  \            /   \
  se21 se22       se61  se62

Assume CPU0 and CPU1 are smt siblings and task A's se is se21 while
task B's se is se61. To compare priority of task A and B, we compare
priority of se2 and se6. Whose vruntime is smaller, who wins.

To make this work, the root level se should have a common cfs_rq min
vuntime, which I call it the core cfs_rq min vruntime.

When we adjust the min_vruntime of rq->core, we need to propgate
that down the tree so as to not cause starvation of existing tasks
based on previous vruntime.

Signed-off-by: Aaron Lu <ziqian.lzq@antfin.com>
Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
---
 kernel/sched/core.c  | 15 +------
 kernel/sched/fair.c  | 99 +++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h |  2 +
 3 files changed, 102 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 18fbaa85ec30..09e5c77e54c3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -117,19 +117,8 @@ static inline bool prio_less(struct task_struct *a, struct task_struct *b)
 	if (pa == -1) /* dl_prio() doesn't work because of stop_class above */
 		return !dl_time_before(a->dl.deadline, b->dl.deadline);
 
-	if (pa == MAX_RT_PRIO + MAX_NICE)  { /* fair */
-		u64 vruntime = b->se.vruntime;
-
-		/*
-		 * Normalize the vruntime if tasks are in different cpus.
-		 */
-		if (task_cpu(a) != task_cpu(b)) {
-			vruntime -= task_cfs_rq(b)->min_vruntime;
-			vruntime += task_cfs_rq(a)->min_vruntime;
-		}
-
-		return !((s64)(a->se.vruntime - vruntime) <= 0);
-	}
+	if (pa == MAX_RT_PRIO + MAX_NICE) /* fair */
+		return cfs_prio_less(a, b);
 
 	return false;
 }
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ab32b22b0574..e8dd78a8c54d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -450,9 +450,105 @@ find_matching_se(struct sched_entity **se, struct sched_entity **pse)
 
 #endif	/* CONFIG_FAIR_GROUP_SCHED */
 
+static inline struct cfs_rq *root_cfs_rq(struct cfs_rq *cfs_rq)
+{
+	return &rq_of(cfs_rq)->cfs;
+}
+
+static inline bool is_root_cfs_rq(struct cfs_rq *cfs_rq)
+{
+	return cfs_rq == root_cfs_rq(cfs_rq);
+}
+
+static inline struct cfs_rq *core_cfs_rq(struct cfs_rq *cfs_rq)
+{
+	return &rq_of(cfs_rq)->core->cfs;
+}
+
 static inline u64 cfs_rq_min_vruntime(struct cfs_rq *cfs_rq)
 {
-	return cfs_rq->min_vruntime;
+	if (!sched_core_enabled(rq_of(cfs_rq)))
+		return cfs_rq->min_vruntime;
+
+	if (is_root_cfs_rq(cfs_rq))
+		return core_cfs_rq(cfs_rq)->min_vruntime;
+	else
+		return cfs_rq->min_vruntime;
+}
+
+static void coresched_adjust_vruntime(struct cfs_rq *cfs_rq, u64 delta)
+{
+	struct sched_entity *se, *next;
+
+	if (!cfs_rq)
+		return;
+
+	cfs_rq->min_vruntime -= delta;
+	rbtree_postorder_for_each_entry_safe(se, next,
+			&cfs_rq->tasks_timeline.rb_root, run_node) {
+		if (se->vruntime > delta)
+			se->vruntime -= delta;
+		if (se->my_q)
+			coresched_adjust_vruntime(se->my_q, delta);
+	}
+}
+
+static void update_core_cfs_rq_min_vruntime(struct cfs_rq *cfs_rq)
+{
+	struct cfs_rq *cfs_rq_core;
+
+	if (!sched_core_enabled(rq_of(cfs_rq)))
+		return;
+
+	if (!is_root_cfs_rq(cfs_rq))
+		return;
+
+	cfs_rq_core = core_cfs_rq(cfs_rq);
+	if (cfs_rq_core != cfs_rq &&
+	    cfs_rq->min_vruntime < cfs_rq_core->min_vruntime) {
+		u64 delta = cfs_rq_core->min_vruntime - cfs_rq->min_vruntime;
+		coresched_adjust_vruntime(cfs_rq_core, delta);
+	}
+}
+
+bool cfs_prio_less(struct task_struct *a, struct task_struct *b)
+{
+	struct sched_entity *sea = &a->se;
+	struct sched_entity *seb = &b->se;
+	bool samecpu = task_cpu(a) == task_cpu(b);
+	struct task_struct *p;
+	s64 delta;
+
+	if (samecpu) {
+		/* vruntime is per cfs_rq */
+		while (!is_same_group(sea, seb)) {
+			int sea_depth = sea->depth;
+			int seb_depth = seb->depth;
+
+			if (sea_depth >= seb_depth)
+				sea = parent_entity(sea);
+			if (sea_depth <= seb_depth)
+				seb = parent_entity(seb);
+		}
+
+		delta = (s64)(sea->vruntime - seb->vruntime);
+		goto out;
+	}
+
+	/* crosscpu: compare root level se's vruntime to decide priority */
+	while (sea->parent)
+		sea = sea->parent;
+	while (seb->parent)
+		seb = seb->parent;
+	delta = (s64)(sea->vruntime - seb->vruntime);
+
+out:
+	p = delta > 0 ? b : a;
+	trace_printk("picked %s/%d %s: %Ld %Ld %Ld\n", p->comm, p->pid,
+			samecpu ? "samecpu" : "crosscpu",
+			sea->vruntime, seb->vruntime, delta);
+
+	return delta > 0;
 }
 
 static __always_inline
@@ -512,6 +608,7 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
 
 	/* ensure we never gain time by being placed backwards. */
 	cfs_rq->min_vruntime = max_vruntime(cfs_rq_min_vruntime(cfs_rq), vruntime);
+	update_core_cfs_rq_min_vruntime(cfs_rq);
 #ifndef CONFIG_64BIT
 	smp_wmb();
 	cfs_rq->min_vruntime_copy = cfs_rq->min_vruntime;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 311ab1e2a00e..4844e703298a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2537,3 +2537,5 @@ static inline bool sched_energy_enabled(void)
 static inline bool sched_energy_enabled(void) { return false; }
 
 #endif /* CONFIG_ENERGY_MODEL && CONFIG_CPU_FREQ_GOV_SCHEDUTIL */
+
+bool cfs_prio_less(struct task_struct *a, struct task_struct *b);
-- 
2.17.1

