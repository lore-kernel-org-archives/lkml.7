Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CAACA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4FCE20856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="GlXmJRFj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfJ3Se0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 14:34:26 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:44311 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbfJ3SeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 14:34:21 -0400
Received: by mail-yb1-f193.google.com with SMTP id g38so973875ybe.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 11:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=opspaqZWBrmAJuccTRbw9IXkUXtPAL4HdyJEGqOFyOo=;
        b=GlXmJRFjGmJwfM74ZwosOoELHca3K1K7+SJdSy2RnCCmWwtc+fcXMKazlfR8+lGKZc
         x4sgwe7DLTiWwO6LfN5jOY6X4x532FFUGZlZPeKsHTT9PYO63IA+yQNXyJvj8cJDlwae
         /W5NORp4pBmtkbqYVmw1XoMKuyVPrL9kbbDPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=opspaqZWBrmAJuccTRbw9IXkUXtPAL4HdyJEGqOFyOo=;
        b=a7GMuDo0pqdZr+DhV+sxxPmwdgSPbzHhJKXKFnhr7BKUDapRfm1wA9M8/oGa6CvHDq
         OknjFhmFw7Hv5MRb/ZHPuEow5iMSgA0XGPlKN/TsydAm0pjEdtFY+dEbbsqJ3O2JqSBN
         TqFhSuooNolt5U4uFGaqx0bhNLdbTJtQSszuR9YfSzo+9YeeqASf/0OrFbMmCug6mgn0
         0zjWkTtOLkjgkANaYQSU7kPVOEyIXp9t5YFDAYwJZXboXV8TK/MWXaUyv5y9FVBARofp
         I2QTc+y3FWQT3TCi/Uda1GFBtnJ+cp/9Leb3QUPCdsykDMZs00vRRHQ/FRAUt9hfdPuh
         JM5w==
X-Gm-Message-State: APjAAAU6XW0+WJSfjCpbdBURTiupwxpjW4YnX04B4nsg/PfQNVMcifQz
        TWRfqwPHlmpN/xofFl6zZckelw==
X-Google-Smtp-Source: APXvYqwB6oubJeVv+qjO3l2QFkA6ru0LnSNMaX6nz0emUxPbH0P/r/vCojS+Cnm1fqvpgI/GsZKUGw==
X-Received: by 2002:a25:cc91:: with SMTP id l139mr646723ybf.271.1572460460030;
        Wed, 30 Oct 2019 11:34:20 -0700 (PDT)
Received: from vpillai-dev.sfo2.internal.digitalocean.com ([138.68.32.68])
        by smtp.gmail.com with ESMTPSA id d4sm813317ywl.0.2019.10.30.11.34.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Oct 2019 11:34:19 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Dario Faggioli <dfaggioli@suse.com>,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>
Subject: [RFC PATCH v4 11/19] sched: Basic tracking of matching tasks
Date:   Wed, 30 Oct 2019 18:33:24 +0000
Message-Id: <ca8ef62d1eadc51a8d1056db5e1c38ecac09379e.1572437285.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1572437285.git.vpillai@digitalocean.com>
References: <cover.1572437285.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1572437285.git.vpillai@digitalocean.com>
References: <cover.1572437285.git.vpillai@digitalocean.com>
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
 include/linux/sched.h |   8 ++-
 kernel/sched/core.c   | 146 ++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/fair.c   |  46 -------------
 kernel/sched/sched.h  |  55 ++++++++++++++++
 4 files changed, 208 insertions(+), 47 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9f51932bd543..d319219ea58f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -688,10 +688,16 @@ struct task_struct {
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
 
 #ifdef CONFIG_UCLAMP_TASK
 	/* Clamp values requested for a scheduling entity */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0427cf610d6a..44dadbe9a2d0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -76,6 +76,141 @@ int sysctl_sched_rt_runtime = 950000;
 
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
@@ -134,6 +269,11 @@ void sched_core_put(void)
 	mutex_unlock(&sched_core_mutex);
 }
 
+#else /* !CONFIG_SCHED_CORE */
+
+static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) { }
+static inline void sched_core_dequeue(struct rq *rq, struct task_struct *p) { }
+
 #endif /* CONFIG_SCHED_CORE */
 
 /*
@@ -1233,6 +1373,9 @@ static inline void init_uclamp(void) { }
 
 static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 {
+	if (sched_core_enabled(rq))
+		sched_core_enqueue(rq, p);
+
 	if (!(flags & ENQUEUE_NOCLOCK))
 		update_rq_clock(rq);
 
@@ -1247,6 +1390,9 @@ static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 
 static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 {
+	if (sched_core_enabled(rq))
+		sched_core_dequeue(rq, p);
+
 	if (!(flags & DEQUEUE_NOCLOCK))
 		update_rq_clock(rq);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cc78b334e1c3..e3b7e8ba1420 100644
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
 static inline void cfs_rq_tg_path(struct cfs_rq *cfs_rq, char *path, int len)
 {
 	if (!path)
@@ -435,33 +413,9 @@ find_matching_se(struct sched_entity **se, struct sched_entity **pse)
 
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
 static inline void cfs_rq_tg_path(struct cfs_rq *cfs_rq, char *path, int len)
 {
 	if (path)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2ba68ab093ee..666b3bc2cfc2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -996,6 +996,10 @@ struct rq {
 	/* per rq */
 	struct rq		*core;
 	unsigned int		core_enabled;
+	struct rb_root		core_tree;
+
+	/* shared state */
+	unsigned int		core_task_seq;
 #endif
 };
 
@@ -1075,6 +1079,57 @@ DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
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

