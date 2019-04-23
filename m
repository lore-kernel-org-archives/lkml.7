Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDAAC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E514C208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="LdsdrWfd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbfDWQTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:19:31 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39451 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728658AbfDWQSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:18:53 -0400
Received: by mail-it1-f195.google.com with SMTP id e13so1098291itk.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=wQ0LDsK3bHeBUH7iKyQ0azS+t5FzDsZhSPpY0xVR21M=;
        b=LdsdrWfdePHVziSXPo4uXNlFsr0/MpFgAXe2qPVjmMy9KlXreSM9+ACbvf8kVG74+3
         oM7Z2wquZ00teHE9uN0xIOzgzdg2TeEAGJ8luW0CrGLGsnBBb7iKGVEQbDiP6wqNp4Zq
         fcqD7yGmN/yMEHhwyDKzJz8NAPfmOELIDZCdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=wQ0LDsK3bHeBUH7iKyQ0azS+t5FzDsZhSPpY0xVR21M=;
        b=Y5CzplQJCjD5X0VHNWzNFESEZnCDobppiGYAYqKrwH8qo9RgbLfrQwnB7O7geyyg3D
         SyqHGxjz35+beWoYNdaww21YhgucCXFtBJ+yilYsxFH32BrHc7o9NtckAwyB1i8bRcVR
         pgUpJXVJIbprcDlOLM/FJjtXZlMjTVeTKwbWFaHtV6i8W70lHluGHUlofz4jkt4La3q1
         WUnxJMXrZp8LtCDHYiH/FFfTaGGvvYN9RbljqiQDhhS0qn5Bbnly3KMIbp1TRJTNmyVQ
         6LVneRpgSmfwuK5z8uL+V2z6r9Gj+WWjATarP9Wi/6h4wy6MKGZmz28CDrX7UpbfrxJ3
         +4fQ==
X-Gm-Message-State: APjAAAUCahaYsH+AlUNAoCN27nRGuQHTvisa+2UA1kzsqhK3+11qgioF
        dHgs6mx/ZcvPaC8ZuyJVcC+WfA==
X-Google-Smtp-Source: APXvYqx6YfUe478gkHuzxl1S1K4QJqFC+rPpb3lTojQBhTwlhz54t38FzEOEFTnyAAAHGMuGM+USRA==
X-Received: by 2002:a02:6019:: with SMTP id i25mr17900810jac.66.1556036331966;
        Tue, 23 Apr 2019 09:18:51 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id 125sm7946972itx.21.2019.04.23.09.18.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 09:18:51 -0700 (PDT)
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
Subject: [RFC PATCH v2 11/17] sched: Basic tracking of matching tasks
Date:   Tue, 23 Apr 2019 16:18:16 +0000
Message-Id: <2364f2b65bf50826d881c84d7634b6565dfee527.1556025155.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1556025155.git.vpillai@digitalocean.com>
References: <cover.1556025155.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1556025155.git.vpillai@digitalocean.com>
References: <cover.1556025155.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra (Intel) <peterz@infradead.org>

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

Changes in v2
-------------
- Improves the priority comparison logic between processes in
  different cpus.
  - Peter Zijlstra
  - Aaron Lu

---
 include/linux/sched.h |   8 ++-
 kernel/sched/core.c   | 164 ++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h  |   4 ++
 3 files changed, 175 insertions(+), 1 deletion(-)

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
index 2f559d706b8e..5066a1493acf 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -64,6 +64,159 @@ int sysctl_sched_rt_runtime = 950000;
 
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
+// FIXME: This is copied from fair.c. Needs only single copy.
+#ifdef CONFIG_FAIR_GROUP_SCHED
+static inline struct cfs_rq *task_cfs_rq(struct task_struct *p)
+{
+	return p->se.cfs_rq;
+}
+#else
+static inline struct cfs_rq *task_cfs_rq(struct task_struct *p)
+{
+	return &task_rq(p)->cfs;
+}
+#endif
+
+/*
+ * l(a,b)
+ * le(a,b) := !l(b,a)
+ * g(a,b)  := l(b,a)
+ * ge(a,b) := !l(a,b)
+ */
+
+/* real prio, less is less */
+static inline bool __prio_less(struct task_struct *a, struct task_struct *b, bool core_cmp)
+{
+	u64 vruntime;
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
+	vruntime = b->se.vruntime;
+	if (core_cmp) {
+		vruntime -= task_cfs_rq(b)->min_vruntime;
+		vruntime += task_cfs_rq(a)->min_vruntime;
+	}
+	if (pa == MAX_RT_PRIO + MAX_NICE) /* fair */
+		return !((s64)(a->se.vruntime - vruntime) <= 0);
+
+	return false;
+}
+
+static inline bool cpu_prio_less(struct task_struct *a, struct task_struct *b)
+{
+	return __prio_less(a, b, false);
+}
+
+static inline bool core_prio_less(struct task_struct *a, struct task_struct *b)
+{
+	return __prio_less(a, b, true);
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
+	if (cpu_prio_less(b, a))
+		return true;
+
+	return false;
+}
+
+void sched_core_enqueue(struct rq *rq, struct task_struct *p)
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
+void sched_core_dequeue(struct rq *rq, struct task_struct *p)
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
+struct task_struct *sched_core_find(struct rq *rq, unsigned long cookie)
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
+		if (node_task->core_cookie < cookie) {
+			node = node->rb_left;
+		} else if (node_task->core_cookie > cookie) {
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
@@ -122,6 +275,11 @@ void sched_core_put(void)
 	mutex_unlock(&sched_core_mutex);
 }
 
+#else /* !CONFIG_SCHED_CORE */
+
+static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) { }
+static inline void sched_core_dequeue(struct rq *rq, struct task_struct *p) { }
+
 #endif /* CONFIG_SCHED_CORE */
 
 /*
@@ -826,6 +984,9 @@ static void set_load_weight(struct task_struct *p, bool update_load)
 
 static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 {
+	if (sched_core_enabled(rq))
+		sched_core_enqueue(rq, p);
+
 	if (!(flags & ENQUEUE_NOCLOCK))
 		update_rq_clock(rq);
 
@@ -839,6 +1000,9 @@ static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 
 static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 {
+	if (sched_core_enabled(rq))
+		sched_core_dequeue(rq, p);
+
 	if (!(flags & DEQUEUE_NOCLOCK))
 		update_rq_clock(rq);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index eb38063221d0..42dd620797d7 100644
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
 
-- 
2.17.1

