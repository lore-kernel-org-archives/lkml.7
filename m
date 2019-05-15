Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005E4C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 21:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4D62082E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 21:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfEOVCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 17:02:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:15270 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbfEOVCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 17:02:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 May 2019 14:02:08 -0700
X-ExtLoop1: 1
Received: from otc-lr-04.jf.intel.com ([10.54.39.157])
  by fmsmga001.fm.intel.com with ESMTP; 15 May 2019 14:02:08 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, tj@kernel.org, mark.rutland@arm.com,
        irogers@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 3/4] perf cgroup: Add new RB tree keys for cgroup
Date:   Wed, 15 May 2019 14:01:31 -0700
Message-Id: <1557954092-67275-4-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557954092-67275-1-git-send-email-kan.liang@linux.intel.com>
References: <1557954092-67275-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Current RB tree for pinned/flexible groups doesn't take cgroup into
account. All events on a given CPU will be fed to
pinned/flexible_sched_in(), which relies on perf_cgroup_match() to
filter the events for a specific cgroup. The method has high overhead,
especially in frequent context switch with several events and cgroups
involved.

Add new RB tree keys, cgrp_id and cgrp_group_index, for cgroup.
The unique cgrp_id (the same as css subsys-unique ID) is used to
indicate a cgroup. Events in the same cgroup has the same cgrp_id.
The cgrp_id is always zero for non-cgroup case. There is no functional
change for non-cgroup case.
The cgrp_group_index is used for multiplexing. The rotated events of a
cgroup has the same cgrp_group_index, which equals to the (group_index
-1) of the first rotated events.
The non-cgroup events, e.g. system-wide events, are treated as special
cgroups. The cgrp_group_index is also updated in multiplexing.

Add percpu pinned/flexible_event in perf_cgroup to track the left most
event for a cgroup, which will be used later to fast access the event of
a given cgroup.
Add percpu rotated_event to track the rotated events of a cgroup.

Add perf_event_groups_first_cgroup() to find the left most event for a
given cgroup ID and cgrp_group_index on a given CPU.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 include/linux/perf_event.h |   5 ++
 kernel/events/core.c       | 217 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 210 insertions(+), 12 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 3f12937..800bf62 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -703,6 +703,8 @@ struct perf_event {
 
 #ifdef CONFIG_CGROUP_PERF
 	struct perf_cgroup		*cgrp; /* cgroup event is attach to */
+	u64				cgrp_id; /* perf cgroup ID */
+	u64				cgrp_group_index;
 #endif
 
 	struct list_head		sb_list;
@@ -837,6 +839,9 @@ struct perf_cgroup {
 	struct cgroup_subsys_state	css;
 	struct perf_cgroup_info	__percpu *info;
 	int				cgrp_event_type;
+	struct perf_event * __percpu	*pinned_event;
+	struct perf_event * __percpu	*flexible_event;
+	struct perf_event * __percpu	*rotated_event;
 };
 
 /*
diff --git a/kernel/events/core.c b/kernel/events/core.c
index a3885e68..6891c74 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -717,6 +717,7 @@ static inline void perf_detach_cgroup(struct perf_event *event)
 {
 	css_put(&event->cgrp->css);
 	event->cgrp = NULL;
+	event->cgrp_id = 0;
 }
 
 static inline int is_cgroup_event(struct perf_event *event)
@@ -961,6 +962,7 @@ static inline int perf_cgroup_connect(int fd, struct perf_event *event,
 
 	cgrp = container_of(css, struct perf_cgroup, css);
 	event->cgrp = cgrp;
+	event->cgrp_id = css->id;
 
 	if (event->attr.pinned)
 		cgrp->cgrp_event_type |= EVENT_CGROUP_PINNED_ONLY;
@@ -1561,6 +1563,9 @@ static void init_event_group(struct perf_event *event)
 {
 	RB_CLEAR_NODE(&event->group_node);
 	event->group_index = 0;
+#ifdef CONFIG_CGROUP_PERF
+	event->cgrp_group_index = 0;
+#endif
 }
 
 /*
@@ -1588,8 +1593,8 @@ static void perf_event_groups_init(struct perf_event_groups *groups)
 /*
  * Compare function for event groups;
  *
- * Implements complex key that first sorts by CPU and then by virtual index
- * which provides ordering when rotating groups for the same CPU.
+ * Implements complex key that sorts by CPU, cgroup index, cgroup ID, and
+ * virtual index which provides ordering when rotating groups for the same CPU.
  */
 static bool
 perf_event_groups_less(struct perf_event *left, struct perf_event *right)
@@ -1599,6 +1604,18 @@ perf_event_groups_less(struct perf_event *left, struct perf_event *right)
 	if (left->cpu > right->cpu)
 		return false;
 
+#ifdef CONFIG_CGROUP_PERF
+	if (left->cgrp_group_index < right->cgrp_group_index)
+		return true;
+	if (left->cgrp_group_index > right->cgrp_group_index)
+		return false;
+
+	if (left->cgrp_id < right->cgrp_id)
+		return true;
+	if (left->cgrp_id > right->cgrp_id)
+		return false;
+#endif
+
 	if (left->group_index < right->group_index)
 		return true;
 	if (left->group_index > right->group_index)
@@ -1608,13 +1625,14 @@ perf_event_groups_less(struct perf_event *left, struct perf_event *right)
 }
 
 /*
- * Insert @event into @groups' tree; using {@event->cpu, ++@groups->index} for
- * key (see perf_event_groups_less). This places it last inside the CPU
+ * Insert @event into @groups' tree; Using
+ * {@event->cpu, @event->cgrp_group_index, @event->cgrp_id, ++@groups->index}
+ * for key (see perf_event_groups_less). This places it last inside the CPU
  * subtree.
  */
 static void
-perf_event_groups_insert(struct perf_event_groups *groups,
-			 struct perf_event *event)
+__perf_event_groups_insert(struct perf_event_groups *groups,
+			   struct perf_event *event)
 {
 	struct perf_event *node_event;
 	struct rb_node *parent;
@@ -1639,6 +1657,10 @@ perf_event_groups_insert(struct perf_event_groups *groups,
 	rb_insert_color(&event->group_node, &groups->tree);
 }
 
+static void
+perf_event_groups_insert(struct perf_event_groups *groups,
+			 struct perf_event *event);
+
 /*
  * Helper function to insert event into the pinned or flexible groups.
  */
@@ -1655,8 +1677,8 @@ add_event_to_groups(struct perf_event *event, struct perf_event_context *ctx)
  * Delete a group from a tree.
  */
 static void
-perf_event_groups_delete(struct perf_event_groups *groups,
-			 struct perf_event *event)
+__perf_event_groups_delete(struct perf_event_groups *groups,
+			   struct perf_event *event)
 {
 	WARN_ON_ONCE(RB_EMPTY_NODE(&event->group_node) ||
 		     RB_EMPTY_ROOT(&groups->tree));
@@ -1665,6 +1687,10 @@ perf_event_groups_delete(struct perf_event_groups *groups,
 	init_event_group(event);
 }
 
+static void
+perf_event_groups_delete(struct perf_event_groups *groups,
+			 struct perf_event *event);
+
 /*
  * Helper function to delete event from its groups.
  */
@@ -1717,6 +1743,129 @@ perf_event_groups_next(struct perf_event *event)
 	return NULL;
 }
 
+#ifdef CONFIG_CGROUP_PERF
+
+static struct perf_event *
+perf_event_groups_first_cgroup(struct perf_event_groups *groups,
+			       int cpu, u64 cgrp_group_index, u64 cgrp_id)
+{
+	struct perf_event *node_event = NULL, *match = NULL;
+	struct rb_node *node = groups->tree.rb_node;
+
+	while (node) {
+		node_event = container_of(node, struct perf_event, group_node);
+
+		if (cpu < node_event->cpu) {
+			node = node->rb_left;
+		} else if (cpu > node_event->cpu) {
+			node = node->rb_right;
+		} else {
+			if (cgrp_group_index < node_event->cgrp_group_index)
+				node = node->rb_left;
+			else if (cgrp_group_index > node_event->cgrp_group_index)
+				node = node->rb_right;
+			else {
+
+				if (cgrp_id < node_event->cgrp_id)
+					node = node->rb_left;
+				else if (cgrp_id > node_event->cgrp_id)
+					node = node->rb_right;
+				else {
+					match = node_event;
+					node = node->rb_left;
+				}
+			}
+		}
+	}
+	return match;
+}
+
+static void
+perf_event_groups_insert(struct perf_event_groups *groups,
+			 struct perf_event *event)
+{
+	struct perf_event **cgrp_event, **rotated_event;
+
+	__perf_event_groups_insert(groups, event);
+
+	if (is_cgroup_event(event)) {
+		if (event->attr.pinned)
+			cgrp_event = per_cpu_ptr(event->cgrp->pinned_event, event->cpu);
+		else {
+			cgrp_event = per_cpu_ptr(event->cgrp->flexible_event, event->cpu);
+			rotated_event = per_cpu_ptr(event->cgrp->rotated_event, event->cpu);
+
+			/* Add the first rotated event into *rotated_event */
+			if (*cgrp_event && !*rotated_event &&
+			    (event->cgrp_group_index > (*cgrp_event)->cgrp_group_index))
+				*rotated_event = event;
+
+			/*
+			 * *cgrp_event always point to the unrotated events.
+			 * All events have been rotated.
+			 * Update *cgrp_event and *rotated_event for next round.
+			 */
+			if (!*cgrp_event && *rotated_event) {
+				*cgrp_event = *rotated_event;
+				*rotated_event = NULL;
+			}
+		}
+		/*
+		 * Cgroup events for the same cgroup on the same CPU will
+		 * always be inserted at the right because of bigger
+		 * @groups->index.
+		 */
+		if (!*cgrp_event)
+			*cgrp_event = event;
+	}
+}
+
+static void
+perf_event_groups_delete(struct perf_event_groups *groups,
+			 struct perf_event *event)
+{
+	struct perf_event **cgrp_event, **rotated_event;
+
+	__perf_event_groups_delete(groups, event);
+
+	if (is_cgroup_event(event)) {
+		if (event->attr.pinned)
+			cgrp_event = per_cpu_ptr(event->cgrp->pinned_event, event->cpu);
+		else {
+			cgrp_event = per_cpu_ptr(event->cgrp->flexible_event, event->cpu);
+			rotated_event = per_cpu_ptr(event->cgrp->rotated_event, event->cpu);
+			if (*rotated_event == event) {
+				*rotated_event = perf_event_groups_first_cgroup(groups, event->cpu,
+										event->cgrp_group_index,
+										event->cgrp_id);
+			}
+		}
+		if (*cgrp_event == event) {
+			*cgrp_event = perf_event_groups_first_cgroup(groups, event->cpu,
+								     event->cgrp_group_index,
+								     event->cgrp_id);
+		}
+	}
+}
+
+#else /* !CONFIG_CGROUP_PERF */
+
+static void
+perf_event_groups_insert(struct perf_event_groups *groups,
+			 struct perf_event *event)
+{
+	__perf_event_groups_insert(groups, event);
+}
+
+static void
+perf_event_groups_delete(struct perf_event_groups *groups,
+			 struct perf_event *event)
+{
+	__perf_event_groups_delete(groups, event);
+}
+
+#endif
+
 /*
  * Iterate through the whole groups tree.
  */
@@ -3757,6 +3906,10 @@ static void perf_adjust_freq_unthr_context(struct perf_event_context *ctx,
  */
 static void rotate_ctx(struct perf_event_context *ctx, struct perf_event *event)
 {
+#ifdef CONFIG_CGROUP_PERF
+	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
+	struct perf_event **rotated_event;
+#endif
 	/*
 	 * Rotate the first entry last of non-pinned groups. Rotation might be
 	 * disabled by the inheritance code.
@@ -3765,6 +3918,22 @@ static void rotate_ctx(struct perf_event_context *ctx, struct perf_event *event)
 		return;
 
 	perf_event_groups_delete(&ctx->flexible_groups, event);
+
+#ifdef CONFIG_CGROUP_PERF
+
+	/* Rotate cgroups */
+	if (&cpuctx->ctx == ctx) {
+		if (event->cgrp) {
+			rotated_event = per_cpu_ptr(event->cgrp->rotated_event, event->cpu);
+			if (!*rotated_event)
+				event->cgrp_group_index = ctx->flexible_groups.index;
+			else
+				event->cgrp_group_index = (*rotated_event)->cgrp_group_index;
+		} else
+			event->cgrp_group_index = ctx->flexible_groups.index;
+	}
+#endif
+
 	perf_event_groups_insert(&ctx->flexible_groups, event);
 }
 
@@ -12196,18 +12365,42 @@ perf_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 		return ERR_PTR(-ENOMEM);
 
 	jc->info = alloc_percpu(struct perf_cgroup_info);
-	if (!jc->info) {
-		kfree(jc);
-		return ERR_PTR(-ENOMEM);
-	}
+	if (!jc->info)
+		goto free_jc;
+
+	jc->pinned_event = alloc_percpu(struct perf_event *);
+	if (!jc->pinned_event)
+		goto free_jc_info;
+
+	jc->flexible_event = alloc_percpu(struct perf_event *);
+	if (!jc->flexible_event)
+		goto free_jc_pinned;
+
+	jc->rotated_event = alloc_percpu(struct perf_event *);
+	if (!jc->rotated_event)
+		goto free_jc_flexible;
 
 	return &jc->css;
+
+free_jc_flexible:
+	free_percpu(jc->flexible_event);
+free_jc_pinned:
+	free_percpu(jc->pinned_event);
+free_jc_info:
+	free_percpu(jc->info);
+free_jc:
+	kfree(jc);
+
+	return ERR_PTR(-ENOMEM);
 }
 
 static void perf_cgroup_css_free(struct cgroup_subsys_state *css)
 {
 	struct perf_cgroup *jc = container_of(css, struct perf_cgroup, css);
 
+	free_percpu(jc->pinned_event);
+	free_percpu(jc->flexible_event);
+	free_percpu(jc->rotated_event);
 	free_percpu(jc->info);
 	kfree(jc);
 }
-- 
2.7.4

