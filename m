Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF44C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19FF2417E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="GFEkREs4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfE2UhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 16:37:14 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:38802 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfE2UhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 16:37:09 -0400
Received: by mail-it1-f193.google.com with SMTP id i63so1508075ita.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 13:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=V/+T0SiafwC72T3IVYDnM+AvwCvCbJIUpxvhxgw+YnA=;
        b=GFEkREs4IcK5U9S2OVJz9AtpYXWQH0tG7hkxll6HlTOuBn99d/PC7VPJzmqBZ86TcW
         Tc0lIWVeTxKwoQSnPK35S7sBzQxxlk49BjDjk1aAb0dgydLVqtr7VJO2erCinx9gguAi
         90iEkDWglxmGAARAkN/dRNHQZ9ZHp3kbhTdnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=V/+T0SiafwC72T3IVYDnM+AvwCvCbJIUpxvhxgw+YnA=;
        b=VYVKJPeSBY/q4d/ZDBTj1DBhXXTtGGYaYa54AfO1UJugPIxDO3mNM7YPjtpr4YKJd9
         PRrflN8X+yIQ4hX5NpI8oK5np8G7fT7yJ/39cLWsOp5lmizEQ5uys7OwDWLPDtcleKPg
         88koVMBAB+febO60995eTWh6iOn//x6BAftNFHxTPUKkWZ/bxYSKiU90E8pgB9TC3kFU
         4Hi6fqfBjcpnc04KQq1fUlV+J9TZF7w1wVmtv0k76AgBLMUV13ZW5nVgZ9L7g+szXrV/
         AUZVSwUQyqcaS0bSOfxsRN+iDKpjSKpyA6ZUDGRUudPKbqaoLXqqlwsqR4+VCtFhmyX3
         qOqw==
X-Gm-Message-State: APjAAAUHqwlBRlZTmHJxGWqGnjpTaqm3aagvBDG2c/Ch884AFPDoVMrB
        ISfem+h6+V6qNzifkvKqFmtQ4Q==
X-Google-Smtp-Source: APXvYqz/A122GH+n1DOBN/jDheCaoFYaGTbbVT3VjQPk4BuM5pb7qdg20KzbFqz3snJA+hZS2X7OdA==
X-Received: by 2002:a24:2547:: with SMTP id g68mr137391itg.109.1559162228052;
        Wed, 29 May 2019 13:37:08 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id f71sm210205itc.5.2019.05.29.13.37.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 13:37:07 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>
Subject: [RFC PATCH v3 11/16] sched: Basic tracking of matching tasks
Date:   Wed, 29 May 2019 20:36:47 +0000
Message-Id: <d74f10401c5d220265a5918de0de13a8986d59a2.1559129225.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1559129225.git.vpillai@digitalocean.com>
References: <cover.1559129225.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1559129225.git.vpillai@digitalocean.com>
References: <cover.1559129225.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Introduce task_struct::core_cookie as an opaque identifier for core
scheduling. When enabled; core scheduling will only allow matching
task to be on the core; where idle matches everything.

When task_struct::core_cookie is set (and core scheduling is enabled)
these tasks are indexed in a second RB-tree, first on cookie value
then on scheduling function, such that matching task selection always
finds the most elegible match.

NOTE: *shudder* at the overhead...

NOTE: *sigh*, a 3rd copy of the scheduling function; the alternative
is per class tracking of cookies and that just duplicates a lot of
stuff for no raisin (the 2nd copy lives in the rt-mutex PI code).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
---

Changes in v3
-------------
- Refactored priority comparison code
- Fixed a comparison logic issue in sched_core_find
  - Aaron Lu

Changes in v2
-------------
- Improves the priority comparison logic between processes in
  different cpus.
  - Peter Zijlstra
  - Aaron Lu

---
 include/linux/sched.h |   8 ++-
 kernel/sched/core.c   | 146 ++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/fair.c   |  46 -------------
 kernel/sched/sched.h  |  55 ++++++++++++++++
 4 files changed, 208 insertions(+), 47 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1549584a1538..a4b39a28236f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -636,10 +636,16 @@ struct task_struct {
 	const struct sched_class	*sched_class;
 	struct sched_entity		se;
 	struct sched_rt_entity		rt;
+	struct sched_dl_entity		dl;
+
+#ifdef CONFIG_SCHED_CORE
+	struct rb_node			core_node;
+	unsigned long			core_cookie;
+#endif
+
 #ifdef CONFIG_CGROUP_SCHED
 	struct task_group		*sched_task_group;
 #endif
-	struct sched_dl_entity		dl;
 
 #ifdef CONFIG_PREEMPT_NOTIFIERS
 	/* List of struct preempt_notifier: */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b1ce33f9b106..112d70f2b1e5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -64,6 +64,141 @@ int sysctl_sched_rt_runtime = 950000;
 
 DEFINE_STATIC_KEY_FALSE(__sched_core_enabled);
 
+/* kernel prio, less is more */
+static inline int __task_prio(struct task_struct *p)
+{
+	if (p->sched_class == &stop_sched_class) /* trumps deadline */
+		return -2;
+
+	if (rt_prio(p->prio)) /* includes deadline */
+		return p->prio; /* [-1, 99] */
+
+	if (p->sched_class == &idle_sched_class)
+		return MAX_RT_PRIO + NICE_WIDTH; /* 140 */
+
+	return MAX_RT_PRIO + MAX_NICE; /* 120, squash fair */
+}
+
+/*
+ * l(a,b)
+ * le(a,b) := !l(b,a)
+ * g(a,b)  := l(b,a)
+ * ge(a,b) := !l(a,b)
+ */
+
+/* real prio, less is less */
+static inline bool prio_less(struct task_struct *a, struct task_struct *b)
+{
+
+	int pa = __task_prio(a), pb = __task_prio(b);
+
+	if (-pa < -pb)
+		return true;
+
+	if (-pb < -pa)
+		return false;
+
+	if (pa == -1) /* dl_prio() doesn't work because of stop_class above */
+		return !dl_time_before(a->dl.deadline, b->dl.deadline);
+
+	if (pa == MAX_RT_PRIO + MAX_NICE)  { /* fair */
+		u64 vruntime = b->se.vruntime;
+
+		/*
+		 * Normalize the vruntime if tasks are in different cpus.
+		 */
+		if (task_cpu(a) != task_cpu(b)) {
+			vruntime -= task_cfs_rq(b)->min_vruntime;
+			vruntime += task_cfs_rq(a)->min_vruntime;
+		}
+
+		return !((s64)(a->se.vruntime - vruntime) <= 0);
+	}
+
+	return false;
+}
+
+static inline bool __sched_core_less(struct task_struct *a, struct task_struct *b)
+{
+	if (a->core_cookie < b->core_cookie)
+		return true;
+
+	if (a->core_cookie > b->core_cookie)
+		return false;
+
+	/* flip prio, so high prio is leftmost */
+	if (prio_less(b, a))
+		return true;
+
+	return false;
+}
+
+static void sched_core_enqueue(struct rq *rq, struct task_struct *p)
+{
+	struct rb_node *parent, **node;
+	struct task_struct *node_task;
+
+	rq->core->core_task_seq++;
+
+	if (!p->core_cookie)
+		return;
+
+	node = &rq->core_tree.rb_node;
+	parent = *node;
+
+	while (*node) {
+		node_task = container_of(*node, struct task_struct, core_node);
+		parent = *node;
+
+		if (__sched_core_less(p, node_task))
+			node = &parent->rb_left;
+		else
+			node = &parent->rb_right;
+	}
+
+	rb_link_node(&p->core_node, parent, node);
+	rb_insert_color(&p->core_node, &rq->core_tree);
+}
+
+static void sched_core_dequeue(struct rq *rq, struct task_struct *p)
+{
+	rq->core->core_task_seq++;
+
+	if (!p->core_cookie)
+		return;
+
+	rb_erase(&p->core_node, &rq->core_tree);
+}
+
+/*
+ * Find left-most (aka, highest priority) task matching @cookie.
+ */
+static struct task_struct *sched_core_find(struct rq *rq, unsigned long cookie)
+{
+	struct rb_node *node = rq->core_tree.rb_node;
+	struct task_struct *node_task, *match;
+
+	/*
+	 * The idle task always matches any cookie!
+	 */
+	match = idle_sched_class.pick_task(rq);
+
+	while (node) {
+		node_task = container_of(node, struct task_struct, core_node);
+
+		if (cookie < node_task->core_cookie) {
+			node = node->rb_left;
+		} else if (cookie > node_task->core_cookie) {
+			node = node->rb_right;
+		} else {
+			match = node_task;
+			node = node->rb_left;
+		}
+	}
+
+	return match;
+}
+
 /*
  * The static-key + stop-machine variable are needed such that:
  *
@@ -122,6 +257,11 @@ void sched_core_put(void)
 	mutex_unlock(&sched_core_mutex);
 }
 
+#else /* !CONFIG_SCHED_CORE */
+
+static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) { }
+static inline void sched_core_dequeue(struct rq *rq, struct task_struct *p) { }
+
 #endif /* CONFIG_SCHED_CORE */
 
 /*
@@ -826,6 +966,9 @@ static void set_load_weight(struct task_struct *p, bool update_load)
 
 static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 {
+	if (sched_core_enabled(rq))
+		sched_core_enqueue(rq, p);
+
 	if (!(flags & ENQUEUE_NOCLOCK))
 		update_rq_clock(rq);
 
@@ -839,6 +982,9 @@ static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 
 static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 {
+	if (sched_core_enabled(rq))
+		sched_core_dequeue(rq, p);
+
 	if (!(flags & DEQUEUE_NOCLOCK))
 		update_rq_clock(rq);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 02e5dfb85e7d..d8a107aea69b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -248,33 +248,11 @@ const struct sched_class fair_sched_class;
  */
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-static inline struct task_struct *task_of(struct sched_entity *se)
-{
-	SCHED_WARN_ON(!entity_is_task(se));
-	return container_of(se, struct task_struct, se);
-}
 
 /* Walk up scheduling entities hierarchy */
 #define for_each_sched_entity(se) \
 		for (; se; se = se->parent)
 
-static inline struct cfs_rq *task_cfs_rq(struct task_struct *p)
-{
-	return p->se.cfs_rq;
-}
-
-/* runqueue on which this entity is (to be) queued */
-static inline struct cfs_rq *cfs_rq_of(struct sched_entity *se)
-{
-	return se->cfs_rq;
-}
-
-/* runqueue "owned" by this group */
-static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
-{
-	return grp->my_q;
-}
-
 static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	struct rq *rq = rq_of(cfs_rq);
@@ -422,33 +400,9 @@ find_matching_se(struct sched_entity **se, struct sched_entity **pse)
 
 #else	/* !CONFIG_FAIR_GROUP_SCHED */
 
-static inline struct task_struct *task_of(struct sched_entity *se)
-{
-	return container_of(se, struct task_struct, se);
-}
-
 #define for_each_sched_entity(se) \
 		for (; se; se = NULL)
 
-static inline struct cfs_rq *task_cfs_rq(struct task_struct *p)
-{
-	return &task_rq(p)->cfs;
-}
-
-static inline struct cfs_rq *cfs_rq_of(struct sched_entity *se)
-{
-	struct task_struct *p = task_of(se);
-	struct rq *rq = task_rq(p);
-
-	return &rq->cfs;
-}
-
-/* runqueue "owned" by this group */
-static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
-{
-	return NULL;
-}
-
 static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	return true;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index eb38063221d0..0cbcfb6c8ee4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -957,6 +957,10 @@ struct rq {
 	/* per rq */
 	struct rq		*core;
 	unsigned int		core_enabled;
+	struct rb_root		core_tree;
+
+	/* shared state */
+	unsigned int		core_task_seq;
 #endif
 };
 
@@ -1036,6 +1040,57 @@ DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define raw_rq()		raw_cpu_ptr(&runqueues)
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+static inline struct task_struct *task_of(struct sched_entity *se)
+{
+	SCHED_WARN_ON(!entity_is_task(se));
+	return container_of(se, struct task_struct, se);
+}
+
+static inline struct cfs_rq *task_cfs_rq(struct task_struct *p)
+{
+	return p->se.cfs_rq;
+}
+
+/* runqueue on which this entity is (to be) queued */
+static inline struct cfs_rq *cfs_rq_of(struct sched_entity *se)
+{
+	return se->cfs_rq;
+}
+
+/* runqueue "owned" by this group */
+static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
+{
+	return grp->my_q;
+}
+
+#else
+
+static inline struct task_struct *task_of(struct sched_entity *se)
+{
+	return container_of(se, struct task_struct, se);
+}
+
+static inline struct cfs_rq *task_cfs_rq(struct task_struct *p)
+{
+	return &task_rq(p)->cfs;
+}
+
+static inline struct cfs_rq *cfs_rq_of(struct sched_entity *se)
+{
+	struct task_struct *p = task_of(se);
+	struct rq *rq = task_rq(p);
+
+	return &rq->cfs;
+}
+
+/* runqueue "owned" by this group */
+static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
+{
+	return NULL;
+}
+#endif
+
 extern void update_rq_clock(struct rq *rq);
 
 static inline u64 __rq_clock_broken(struct rq *rq)
-- 
2.17.1

