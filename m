Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BCDC43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 00:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AEBC2245C
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 00:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="WEGgWDcA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfLGAZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 19:25:01 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33002 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726386AbfLGAZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 19:25:00 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB70A3VB010430
        for <linux-kernel@vger.kernel.org>; Fri, 6 Dec 2019 16:24:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=6qVl3digbSS6oiQ/7N8cOkTionkRY9Fe0xFC5CEWFtw=;
 b=WEGgWDcACYth9/xZuW5RVqD0BP8tDwgxJosOF/Cg48L4AR2D71N4qIL6Pm+SqwXVUGOx
 BeFo9GCAG85f1e9JRam0Z79nmkzZMwub14N0k3JceyN+GeomKMPqD9I4YLXd7kbZXrZN
 QeKbarol4uhAefZQw0+Ag9vYXKmYIjjcRlk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wqnyxkeda-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 16:24:56 -0800
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 6 Dec 2019 16:24:52 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id C480862E228A; Fri,  6 Dec 2019 16:24:51 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, Song Liu <songliubraving@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v8] perf: Sharing PMU counters across compatible events
Date:   Fri, 6 Dec 2019 16:24:47 -0800
Message-ID: <20191207002447.2976319-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-06_08:2019-12-05,2019-12-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 mlxscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 priorityscore=1501 suspectscore=1
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912060191
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch tries to enable PMU sharing. When multiple perf_events are
counting the same metric, they can share the hardware PMU counter. We
call these events as "compatible events".

The PMU sharing are limited to events within the same perf_event_context
(ctx). When a event is installed or enabled, search the ctx for compatible
events. This is implemented in perf_event_setup_dup(). One of these
compatible events are picked as the master (stored in event->dup_master).
Similarly, when the event is removed or disabled, perf_event_remove_dup()
is used to clean up sharing.

A new state PERF_EVENT_STATE_ENABLED is introduced for the master event.
This state is used when the slave event is ACTIVE, but the master event
is not.

On the critical paths (add, del read), sharing PMU counters doesn't
increase the complexity. Helper functions event_pmu_[add|del|read]() are
introduced to cover these cases. All these functions have O(1) time
complexity.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Song Liu <songliubraving@fb.com>

---
Changes in v8:
Fix issues with task event (Jiri).
Fix issues with event inherit.
Fix mmap'ed events, i.e. perf test 4 (kernel test bot).

Changes in v7:
Major rewrite to avoid allocating extra master event.
---
 include/linux/perf_event.h |  14 +-
 kernel/events/core.c       | 342 ++++++++++++++++++++++++++++++++++---
 2 files changed, 327 insertions(+), 29 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 6d4c22aee384..7d49f9251621 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -547,7 +547,9 @@ enum perf_event_state {
 	PERF_EVENT_STATE_ERROR		= -2,
 	PERF_EVENT_STATE_OFF		= -1,
 	PERF_EVENT_STATE_INACTIVE	=  0,
-	PERF_EVENT_STATE_ACTIVE		=  1,
+	/* the hw PMC is enabled, but this event is not counting */
+	PERF_EVENT_STATE_ENABLED	=  1,
+	PERF_EVENT_STATE_ACTIVE		=  2,
 };
 
 struct file;
@@ -750,6 +752,16 @@ struct perf_event {
 	void *security;
 #endif
 	struct list_head		sb_list;
+
+	/* for PMU sharing */
+	struct perf_event		*dup_master;
+	/* check event_sync_dup_count() for the use of dup_base_* */
+	u64				dup_base_count;
+	u64				dup_base_child_count;
+	/* when this event is master,  read from master*count */
+	local64_t			master_count;
+	atomic64_t			master_child_count;
+	int				dup_active_count;
 #endif /* CONFIG_PERF_EVENTS */
 };
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4ff86d57f9e5..7a4bc3860dfa 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1657,6 +1657,140 @@ perf_event_groups_next(struct perf_event *event)
 		event = rb_entry_safe(rb_next(&event->group_node),	\
 				typeof(*event), group_node))
 
+static inline bool perf_event_can_share(struct perf_event *event)
+{
+	/* only share hardware counting events */
+	return !is_software_event(event) && !is_sampling_event(event);
+}
+
+/*
+ * Returns whether the two events can share a PMU counter.
+ *
+ * Note: This function does NOT check perf_event_can_share() for
+ * the two events, they should be checked before this function
+ */
+static inline bool perf_event_compatible(struct perf_event *event_a,
+					 struct perf_event *event_b)
+{
+	return event_a->attr.type == event_b->attr.type &&
+		event_a->attr.config == event_b->attr.config &&
+		event_a->attr.config1 == event_b->attr.config1 &&
+		event_a->attr.config2 == event_b->attr.config2;
+}
+
+/* prepare the dup_master, this event is its own dup_master */
+static void perf_event_init_dup_master(struct perf_event *event)
+{
+	event->dup_master = event;
+	/*
+	 * dup_master->count is used by the hw PMC, and shared with other
+	 * events, so we have to read from dup_master->master_count. Copy
+	 * event->count to event->master_count.
+	 *
+	 * Same logic for child_count and master_child_count.
+	 */
+	local64_set(&event->master_count, local64_read(&event->count));
+	atomic64_set(&event->master_child_count,
+		     atomic64_read(&event->child_count));
+
+	event->dup_active_count = 0;
+}
+
+/* tear down dup_master, no more sharing for this event */
+static void perf_event_exit_dup_master(struct perf_event *event)
+{
+	WARN_ON_ONCE(event->dup_active_count);
+
+	event->dup_master = NULL;
+	/* restore event->count and event->child_count */
+	local64_set(&event->count, local64_read(&event->master_count));
+	atomic64_set(&event->child_count,
+		     atomic64_read(&event->master_child_count));
+}
+
+/* After adding a event to the ctx, try find compatible event(s). */
+static void perf_event_setup_dup(struct perf_event *event,
+				 struct perf_event_context *ctx)
+
+{
+	struct perf_event *tmp;
+
+	if (event->dup_master ||
+	    event->state != PERF_EVENT_STATE_INACTIVE ||
+	    !perf_event_can_share(event))
+		return;
+
+	/* look for dup with other events */
+	list_for_each_entry(tmp, &ctx->event_list, event_entry) {
+		WARN_ON_ONCE(tmp->state > PERF_EVENT_STATE_INACTIVE);
+
+		if (tmp == event ||
+		    tmp->state != PERF_EVENT_STATE_INACTIVE ||
+		    !perf_event_can_share(tmp) ||
+		    !perf_event_compatible(event, tmp))
+			continue;
+
+		/* first dup, pick tmp as the master */
+		if (!tmp->dup_master)
+			perf_event_init_dup_master(tmp);
+
+		event->dup_master = tmp->dup_master;
+		break;
+	}
+}
+
+/* Remove dup_master for the event */
+static void perf_event_remove_dup(struct perf_event *event,
+				  struct perf_event_context *ctx)
+
+{
+	struct perf_event *tmp, *new_master;
+	int count;
+
+	/* no sharing */
+	if (!event->dup_master)
+		return;
+
+	WARN_ON_ONCE(event->state != PERF_EVENT_STATE_INACTIVE &&
+		     event->state != PERF_EVENT_STATE_OFF);
+
+	/* this event is not the master */
+	if (event->dup_master != event) {
+		event->dup_master = NULL;
+		return;
+	}
+
+	/* this event is the master */
+	perf_event_exit_dup_master(event);
+
+	count = 0;
+	new_master = NULL;
+	list_for_each_entry(tmp, &ctx->event_list, event_entry) {
+		WARN_ON_ONCE(tmp->state > PERF_EVENT_STATE_INACTIVE);
+		if (tmp->dup_master == event) {
+			count++;
+			if (!new_master)
+				new_master = tmp;
+		}
+	}
+
+	if (!count)
+		return;
+
+	if (count == 1) {
+		/* no more sharing */
+		new_master->dup_master = NULL;
+		return;
+	}
+
+	perf_event_init_dup_master(new_master);
+
+	/* switch to new_master */
+	list_for_each_entry(tmp, &ctx->event_list, event_entry)
+		if (tmp->dup_master == event)
+			tmp->dup_master = new_master;
+}
+
 /*
  * Add an event from the lists for its context.
  * Must be called with ctx->mutex and ctx->lock held.
@@ -2084,6 +2218,98 @@ event_filter_match(struct perf_event *event)
 	       perf_cgroup_match(event) && pmu_filter_match(event);
 }
 
+/* PMU sharing aware version of event->pmu->add() */
+static int event_pmu_add(struct perf_event *event,
+			 struct perf_event_context *ctx)
+{
+	struct perf_event *master;
+	int ret;
+
+	/* no sharing, just do event->pmu->add() */
+	if (!event->dup_master)
+		return event->pmu->add(event, PERF_EF_START);
+
+	master = event->dup_master;
+
+	if (!master->dup_active_count) {
+		ret = event->pmu->add(master, PERF_EF_START);
+		if (ret)
+			return ret;
+
+		if (master != event)
+			perf_event_set_state(master, PERF_EVENT_STATE_ENABLED);
+	}
+
+	master->dup_active_count++;
+	master->pmu->read(master);
+	event->dup_base_count = local64_read(&master->count);
+	event->dup_base_child_count = atomic64_read(&master->child_count);
+	return 0;
+}
+
+/*
+ * sync data count from dup->master to event, called on event_pmu_read()
+ * and event_pmu_del()
+ */
+static void event_sync_dup_count(struct perf_event *event,
+				 struct perf_event *master)
+{
+	u64 new_count;
+	u64 new_child_count;
+
+	WARN_ON_ONCE(event->state != PERF_EVENT_STATE_ACTIVE);
+
+	event->pmu->read(master);
+	new_count = local64_read(&master->count);
+	new_child_count = atomic64_read(&master->child_count);
+
+	if (event == master) {
+		local64_add(new_count - event->dup_base_count,
+			    &event->master_count);
+		atomic64_add(new_child_count - event->dup_base_child_count,
+			     &event->master_child_count);
+	} else {
+		local64_add(new_count - event->dup_base_count, &event->count);
+		atomic64_add(new_child_count - event->dup_base_child_count,
+			     &event->child_count);
+	}
+
+	/* save dup_base_* for next sync */
+	event->dup_base_count = new_count;
+	event->dup_base_child_count = new_child_count;
+}
+
+/* PMU sharing aware version of event->pmu->del() */
+static void event_pmu_del(struct perf_event *event,
+			  struct perf_event_context *ctx)
+{
+	struct perf_event *master;
+
+	if (event->dup_master == NULL) {
+		event->pmu->del(event, 0);
+		return;
+	}
+
+	master = event->dup_master;
+	event_sync_dup_count(event, master);
+	if (--master->dup_active_count == 0) {
+		event->pmu->del(master, 0);
+		perf_event_set_state(master, PERF_EVENT_STATE_INACTIVE);
+	} else if (master == event) {
+		perf_event_set_state(master, PERF_EVENT_STATE_ENABLED);
+	}
+}
+
+/* PMU sharing aware version of event->pmu->read() */
+static void event_pmu_read(struct perf_event *event)
+{
+	if (event->dup_master == NULL) {
+		event->pmu->read(event);
+		return;
+	}
+	event_sync_dup_count(event, event->dup_master);
+}
+
 static void
 event_sched_out(struct perf_event *event,
 		  struct perf_cpu_context *cpuctx,
@@ -2106,7 +2332,7 @@ event_sched_out(struct perf_event *event,
 
 	perf_pmu_disable(event->pmu);
 
-	event->pmu->del(event, 0);
+	event_pmu_del(event, ctx);
 	event->oncpu = -1;
 
 	if (READ_ONCE(event->pending_disable) >= 0) {
@@ -2155,6 +2381,16 @@ group_sched_out(struct perf_event *group_event,
 
 #define DETACH_GROUP	0x01UL
 
+static void ctx_sched_out(struct perf_event_context *ctx,
+			  struct perf_cpu_context *cpuctx,
+			  enum event_type_t event_type);
+
+static void ctx_resched(struct perf_cpu_context *cpuctx,
+			struct perf_event_context *task_ctx,
+			enum event_type_t event_type,
+			struct perf_event *event_add_dup,
+			struct perf_event *event_del_dup);
+
 /*
  * Cross CPU call to remove a performance event
  *
@@ -2174,6 +2410,14 @@ __perf_remove_from_context(struct perf_event *event,
 		update_cgrp_time_from_cpuctx(cpuctx);
 	}
 
+	if (event->dup_master == event) {
+		if (ctx->is_active)
+			ctx_resched(cpuctx, cpuctx->task_ctx,
+				    get_event_type(event), NULL, event);
+		else
+			perf_event_remove_dup(event, ctx);
+	}
+
 	event_sched_out(event, cpuctx, ctx);
 	if (flags & DETACH_GROUP)
 		perf_group_detach(event);
@@ -2241,6 +2485,14 @@ static void __perf_event_disable(struct perf_event *event,
 		update_cgrp_time_from_event(event);
 	}
 
+	if (event->dup_master == event) {
+		if (ctx->is_active)
+			ctx_resched(cpuctx, cpuctx->task_ctx,
+				    get_event_type(event), NULL, event);
+		else
+			perf_event_remove_dup(event, ctx);
+	}
+
 	if (event == event->group_leader)
 		group_sched_out(event, cpuctx, ctx);
 	else
@@ -2379,7 +2631,7 @@ event_sched_in(struct perf_event *event,
 
 	perf_log_itrace_start(event);
 
-	if (event->pmu->add(event, PERF_EF_START)) {
+	if (event_pmu_add(event, ctx)) {
 		perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
 		event->oncpu = -1;
 		ret = -EAGAIN;
@@ -2493,9 +2745,6 @@ static void add_event_to_ctx(struct perf_event *event,
 	perf_group_attach(event);
 }
 
-static void ctx_sched_out(struct perf_event_context *ctx,
-			  struct perf_cpu_context *cpuctx,
-			  enum event_type_t event_type);
 static void
 ctx_sched_in(struct perf_event_context *ctx,
 	     struct perf_cpu_context *cpuctx,
@@ -2544,7 +2793,9 @@ static void perf_event_sched_in(struct perf_cpu_context *cpuctx,
  */
 static void ctx_resched(struct perf_cpu_context *cpuctx,
 			struct perf_event_context *task_ctx,
-			enum event_type_t event_type)
+			enum event_type_t event_type,
+			struct perf_event *event_add_dup,
+			struct perf_event *event_del_dup)
 {
 	enum event_type_t ctx_event_type;
 	bool cpu_event = !!(event_type & EVENT_CPU);
@@ -2574,6 +2825,18 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
 	else if (ctx_event_type & EVENT_PINNED)
 		cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
 
+	if (event_add_dup) {
+		if (event_add_dup->ctx->is_active)
+			ctx_sched_out(event_add_dup->ctx, cpuctx, EVENT_ALL);
+		perf_event_setup_dup(event_add_dup, event_add_dup->ctx);
+	}
+
+	if (event_del_dup) {
+		if (event_del_dup->ctx->is_active)
+			ctx_sched_out(event_del_dup->ctx, cpuctx, EVENT_ALL);
+		perf_event_remove_dup(event_del_dup, event_del_dup->ctx);
+	}
+
 	perf_event_sched_in(cpuctx, task_ctx, current);
 	perf_pmu_enable(cpuctx->ctx.pmu);
 }
@@ -2584,7 +2847,7 @@ void perf_pmu_resched(struct pmu *pmu)
 	struct perf_event_context *task_ctx = cpuctx->task_ctx;
 
 	perf_ctx_lock(cpuctx, task_ctx);
-	ctx_resched(cpuctx, task_ctx, EVENT_ALL|EVENT_CPU);
+	ctx_resched(cpuctx, task_ctx, EVENT_ALL|EVENT_CPU, NULL, NULL);
 	perf_ctx_unlock(cpuctx, task_ctx);
 }
 
@@ -2642,9 +2905,11 @@ static int  __perf_install_in_context(void *info)
 	if (reprogram) {
 		ctx_sched_out(ctx, cpuctx, EVENT_TIME);
 		add_event_to_ctx(event, ctx);
-		ctx_resched(cpuctx, task_ctx, get_event_type(event));
+		ctx_resched(cpuctx, task_ctx, get_event_type(event),
+			    event, NULL);
 	} else {
 		add_event_to_ctx(event, ctx);
+		perf_event_setup_dup(event, ctx);
 	}
 
 unlock:
@@ -2789,8 +3054,10 @@ static void __perf_event_enable(struct perf_event *event,
 
 	perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
 
-	if (!ctx->is_active)
+	if (!ctx->is_active) {
+		perf_event_setup_dup(event, ctx);
 		return;
+	}
 
 	if (!event_filter_match(event)) {
 		ctx_sched_in(ctx, cpuctx, EVENT_TIME, current);
@@ -2801,7 +3068,7 @@ static void __perf_event_enable(struct perf_event *event,
 	 * If the event is in a group and isn't the group leader,
 	 * then don't put it on unless the group is on.
 	 */
-	if (leader != event && leader->state != PERF_EVENT_STATE_ACTIVE) {
+	if (leader != event && leader->state <= PERF_EVENT_STATE_INACTIVE) {
 		ctx_sched_in(ctx, cpuctx, EVENT_TIME, current);
 		return;
 	}
@@ -2810,7 +3077,8 @@ static void __perf_event_enable(struct perf_event *event,
 	if (ctx->task)
 		WARN_ON_ONCE(task_ctx != ctx);
 
-	ctx_resched(cpuctx, task_ctx, get_event_type(event));
+	ctx_resched(cpuctx, task_ctx, get_event_type(event),
+		    event, NULL);
 }
 
 /*
@@ -3148,8 +3416,8 @@ static void __perf_event_sync_stat(struct perf_event *event,
 	 * we know the event must be on the current CPU, therefore we
 	 * don't need to use it.
 	 */
-	if (event->state == PERF_EVENT_STATE_ACTIVE)
-		event->pmu->read(event);
+	if (event->state > PERF_EVENT_STATE_INACTIVE)
+		event_pmu_read(event);
 
 	perf_event_update_time(event);
 
@@ -3953,7 +4221,7 @@ static void perf_event_enable_on_exec(int ctxn)
 	 */
 	if (enabled) {
 		clone_ctx = unclone_ctx(ctx);
-		ctx_resched(cpuctx, ctx, event_type);
+		ctx_resched(cpuctx, ctx, event_type, NULL, NULL);
 	} else {
 		ctx_sched_in(ctx, cpuctx, EVENT_TIME, current);
 	}
@@ -4024,22 +4292,22 @@ static void __perf_event_read(void *info)
 		goto unlock;
 
 	if (!data->group) {
-		pmu->read(event);
+		event_pmu_read(event);
 		data->ret = 0;
 		goto unlock;
 	}
 
 	pmu->start_txn(pmu, PERF_PMU_TXN_READ);
 
-	pmu->read(event);
+	event_pmu_read(event);
 
 	for_each_sibling_event(sub, event) {
-		if (sub->state == PERF_EVENT_STATE_ACTIVE) {
+		if (sub->state > PERF_EVENT_STATE_INACTIVE) {
 			/*
 			 * Use sibling's PMU rather than @event's since
 			 * sibling could be on different (eg: software) PMU.
 			 */
-			sub->pmu->read(sub);
+			event_pmu_read(sub);
 		}
 	}
 
@@ -4051,6 +4319,9 @@ static void __perf_event_read(void *info)
 
 static inline u64 perf_event_count(struct perf_event *event)
 {
+	if (event->dup_master == event)
+		return local64_read(&event->master_count) +
+			atomic64_read(&event->master_child_count);
 	return local64_read(&event->count) + atomic64_read(&event->child_count);
 }
 
@@ -4109,9 +4380,12 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
 	 * oncpu == -1).
 	 */
 	if (event->oncpu == smp_processor_id())
-		event->pmu->read(event);
+		event_pmu_read(event);
 
-	*value = local64_read(&event->count);
+	if (event->dup_master == event)
+		*value = local64_read(&event->master_count);
+	else
+		*value = local64_read(&event->count);
 	if (enabled || running) {
 		u64 now = event->shadow_ctx_time + perf_clock();
 		u64 __enabled, __running;
@@ -4138,7 +4412,7 @@ static int perf_event_read(struct perf_event *event, bool group)
 	 * value in the event structure:
 	 */
 again:
-	if (state == PERF_EVENT_STATE_ACTIVE) {
+	if (state > PERF_EVENT_STATE_INACTIVE) {
 		struct perf_read_data data;
 
 		/*
@@ -6488,8 +6762,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 		values[n++] = running;
 
 	if ((leader != event) &&
-	    (leader->state == PERF_EVENT_STATE_ACTIVE))
-		leader->pmu->read(leader);
+	    (leader->state > PERF_EVENT_STATE_INACTIVE))
+		event_pmu_read(leader);
 
 	values[n++] = perf_event_count(leader);
 	if (read_format & PERF_FORMAT_ID)
@@ -6501,8 +6775,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 		n = 0;
 
 		if ((sub != event) &&
-		    (sub->state == PERF_EVENT_STATE_ACTIVE))
-			sub->pmu->read(sub);
+		    (sub->state > PERF_EVENT_STATE_INACTIVE))
+			event_pmu_read(sub);
 
 		values[n++] = perf_event_count(sub);
 		if (read_format & PERF_FORMAT_ID)
@@ -9800,10 +10074,10 @@ static enum hrtimer_restart perf_swevent_hrtimer(struct hrtimer *hrtimer)
 
 	event = container_of(hrtimer, struct perf_event, hw.hrtimer);
 
-	if (event->state != PERF_EVENT_STATE_ACTIVE)
+	if (event->state <= PERF_EVENT_STATE_INACTIVE)
 		return HRTIMER_NORESTART;
 
-	event->pmu->read(event);
+	event_pmu_read(event);
 
 	perf_sample_data_init(&data, 0, event->hw.last_period);
 	regs = get_irq_regs();
@@ -11492,9 +11766,17 @@ SYSCALL_DEFINE5(perf_event_open,
 		perf_remove_from_context(group_leader, 0);
 		put_ctx(gctx);
 
+		/*
+		 * move_group only happens to sw events, from sw ctx to hw
+		 * ctx. The sw events should not have valid dup_master. So
+		 * it is not necessary to handle dup_events.
+		 */
+		WARN_ON_ONCE(group_leader->dup_master);
+
 		for_each_sibling_event(sibling, group_leader) {
 			perf_remove_from_context(sibling, 0);
 			put_ctx(gctx);
+			WARN_ON_ONCE(sibling->dup_master);
 		}
 
 		/*
@@ -11761,7 +12043,10 @@ static void sync_child_event(struct perf_event *child_event,
 	/*
 	 * Add back the child's count to the parent's count:
 	 */
-	atomic64_add(child_val, &parent_event->child_count);
+	if (parent_event->dup_master == parent_event)
+		atomic64_add(child_val, &parent_event->master_child_count);
+	else
+		atomic64_add(child_val, &parent_event->child_count);
 	atomic64_add(child_event->total_time_enabled,
 		     &parent_event->child_total_time_enabled);
 	atomic64_add(child_event->total_time_running,
@@ -12140,6 +12425,7 @@ inherit_event(struct perf_event *parent_event,
 	 */
 	raw_spin_lock_irqsave(&child_ctx->lock, flags);
 	add_event_to_ctx(child_event, child_ctx);
+	perf_event_setup_dup(child_event, child_ctx);
 	raw_spin_unlock_irqrestore(&child_ctx->lock, flags);
 
 	/*
-- 
2.17.1

