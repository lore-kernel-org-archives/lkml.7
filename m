Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2409C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 01:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869C32073A
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 01:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V2a2lPo3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfKPBTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 20:19:21 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:45836 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfKPBTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 20:19:20 -0500
Received: by mail-pf1-f202.google.com with SMTP id a14so9075384pfr.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 17:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EKFsUFpxE1UnuslYf6JP+PHbYMwc1PNXCq7ObqCo/gY=;
        b=V2a2lPo3prnHYB7gHt9r4HkboJ5e0xawhu2yHABc/dcBTLf2gSochW8CYgBukWfx76
         mYCC/X1ZnB6tbqZ3lxJxQ8ToFv0QWKb+W6NM3YhI4MbeoUKHWF75L8X5AR0TVHwYYf8R
         VEHYnecu6w2mappOcCeefKuxgcHJps5URnPGM+YOXudY4dBIOZqlHz3D6E3ezp6cNN2P
         SCAa3MfdTEg3jTdnpLujvl0E4hAkK9i3aCuu45mhcT37xjBk/1lLFrtS0dNmjS/u1OA4
         k4JwnsXTh3iVvySW3CbBq6GCGfalKMCATOLL16f+L5rQMk1so8V/iGPx9CYRxXgqV0CY
         NWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EKFsUFpxE1UnuslYf6JP+PHbYMwc1PNXCq7ObqCo/gY=;
        b=jNowww9p4tMKuRoVDOPUWXQhNe2utCAwDHDdQTrDR1qy/wOY4W8fjkuUjdlMBKTQ0h
         o2tQiLOMqsgMYGFbhNZct+LfIrGLBTZNNM5nKFhxgiV1UYIl3TBRk4xLn8q6uMhw8fT8
         n4mh7hdNEMI52+IeRW7ALeczy5dX2yT3GkLJz16NGyzzIAsTHjJYKieMZ7C80caBdkcJ
         O0+61XWFTvern0iRhuaHIIoFkKGwBgNU9DUOzXEnd2VF3Y6JuA5FuUMBlEtJKGpsM9Cz
         WoSgNFR4is1UCmW8oQPlBOSBRo4+O5eiHF+a8G35rWWEp1JPxZSAfL4IChGYyFu+XaoA
         Kb4g==
X-Gm-Message-State: APjAAAUMhwXrB4WLiEeBSyxLBaG2gr8sRBynERQZ/iFEpYADxm+/dQjk
        WqNgkIv8Lat6OME1XREdvnD3dvOE0hBi
X-Google-Smtp-Source: APXvYqwoo/wrUmJP6tDeqrhRS7Ev9iM5X0w290lcyjez+cGF1NAYpGz4krZxzNQv/UiZapbHqNecFu7qsZBl
X-Received: by 2002:a63:1c05:: with SMTP id c5mr18902430pgc.398.1573867158245;
 Fri, 15 Nov 2019 17:19:18 -0800 (PST)
Date:   Fri, 15 Nov 2019 17:18:45 -0800
In-Reply-To: <20191116011845.177150-1-irogers@google.com>
Message-Id: <20191116011845.177150-11-irogers@google.com>
Mime-Version: 1.0
References: <20191114003042.85252-1-irogers@google.com> <20191116011845.177150-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v4 10/10] perf/cgroup: Do not switch system-wide events in
 cgroup switch
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Qian Cai <cai@lca.pw>, Joe Lawrence <joe.lawrence@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Gary Hook <Gary.Hook@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

When counting system-wide events and cgroup events simultaneously, the
system-wide events are always scheduled out then back in during cgroup
switches, bringing extra overhead and possibly missing events. Switching
out system wide flexible events may be necessary if the scheduled in
task's cgroups have pinned events that need to be scheduled in at a higher
priority than the system wide flexible events.

Here is test with 6 child cgroups (sibling cgroups), 1 parent cgroup
and system-wide events.
A specjbb benchmark is running in each child cgroup.
The perf command is as below.
   perf stat -e cycles,instructions -e cycles,instructions
   -e cycles,instructions -e cycles,instructions
   -e cycles,instructions -e cycles,instructions
   -e cycles,instructions -e cycles,instructions
   -G cgroup1,cgroup1,cgroup2,cgroup2,cgroup3,cgroup3
   -G cgroup4,cgroup4,cgroup5,cgroup5,cgroup6,cgroup6
   -G cgroup_parent,cgroup_parent
   -a -e cycles,instructions -I 1000

The average RT (Response Time) reported from specjbb is
used as key performance metrics. (The lower the better)
                                        RT(us)              Overhead
Baseline (no perf stat):                4286.9
Use cgroup perf, no patches:            4537.1                5.84%
Use cgroup perf, apply the patch:       4440.7                3.59%

Fixes: e5d1367f17ba ("perf: Add cgroup support")
---
This patch was rebased based on: https://lkml.org/lkml/2019/8/7/771
with some minor changes to comments made by: Ian Rogers
<irogers@google.com>

Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/linux/perf_event.h |   1 +
 kernel/events/core.c       | 133 ++++++++++++++++++++++++++++++++++---
 2 files changed, 123 insertions(+), 11 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index be3ca69b3f69..887abf387b54 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -877,6 +877,7 @@ struct perf_cgroup_info {
 struct perf_cgroup {
 	struct cgroup_subsys_state	css;
 	struct perf_cgroup_info	__percpu *info;
+	unsigned int			nr_pinned_event;
 	/*
 	 * A cache of the first event with the perf_cpu_context's
 	 * perf_event_context for the first event in pinned_groups or
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6427b16c95d0..d9c3d3280ad9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -362,8 +362,18 @@ enum event_type_t {
 	/* see ctx_resched() for details */
 	EVENT_CPU = 0x8,
 	EVENT_ALL = EVENT_FLEXIBLE | EVENT_PINNED,
+
+	/* see perf_cgroup_switch() for details */
+	EVENT_CGROUP_FLEXIBLE_ONLY = 0x10,
+	EVENT_CGROUP_PINNED_ONLY = 0x20,
+	EVENT_CGROUP_ALL_ONLY = EVENT_CGROUP_FLEXIBLE_ONLY |
+				EVENT_CGROUP_PINNED_ONLY,
+
 };
 
+#define CGROUP_PINNED(type)	(type & EVENT_CGROUP_PINNED_ONLY)
+#define CGROUP_FLEXIBLE(type)	(type & EVENT_CGROUP_FLEXIBLE_ONLY)
+
 /*
  * perf_sched_events : >0 events exist
  * perf_cgroup_events: >0 per-cpu cgroup events exist on this cpu
@@ -668,6 +678,20 @@ perf_event_set_state(struct perf_event *event, enum perf_event_state state)
 
 #ifdef CONFIG_CGROUP_PERF
 
+/* Skip system-wide CPU events if only cgroup events are required. */
+static inline bool
+perf_cgroup_skip_switch(enum event_type_t event_type,
+			struct perf_event *event,
+			bool is_pinned)
+{
+	if (event->cgrp)
+		return 0;
+	if (is_pinned)
+		return !!CGROUP_PINNED(event_type);
+	else
+		return !!CGROUP_FLEXIBLE(event_type);
+}
+
 static inline bool
 perf_cgroup_match(struct perf_event *event)
 {
@@ -694,6 +718,8 @@ perf_cgroup_match(struct perf_event *event)
 
 static inline void perf_detach_cgroup(struct perf_event *event)
 {
+	if (event->attr.pinned)
+		event->cgrp->nr_pinned_event--;
 	css_put(&event->cgrp->css);
 	event->cgrp = NULL;
 }
@@ -781,6 +807,22 @@ perf_cgroup_set_timestamp(struct task_struct *task,
 	}
 }
 
+/* Check if cgroup and its ancestor have pinned events attached */
+static bool
+cgroup_has_pinned_events(struct perf_cgroup *cgrp)
+{
+	struct cgroup_subsys_state *css;
+	struct perf_cgroup *tmp_cgrp;
+
+	for (css = &cgrp->css; css; css = css->parent) {
+		tmp_cgrp = container_of(css, struct perf_cgroup, css);
+		if (tmp_cgrp->nr_pinned_event > 0)
+			return true;
+	}
+
+	return false;
+}
+
 static DEFINE_PER_CPU(struct list_head, cgrp_cpuctx_list);
 
 #define PERF_CGROUP_SWOUT	0x1 /* cgroup switch out every event */
@@ -812,7 +854,22 @@ static void perf_cgroup_switch(struct task_struct *task, int mode)
 		perf_pmu_disable(cpuctx->ctx.pmu);
 
 		if (mode & PERF_CGROUP_SWOUT) {
-			cpu_ctx_sched_out(cpuctx, EVENT_ALL);
+			/*
+			 * The system-wide events and cgroup events share the
+			 * same cpuctx groups. Decide which events to be
+			 * scheduled outbased on the types of events:
+			 * - EVENT_FLEXIBLE | EVENT_CGROUP_FLEXIBLE_ONLY:
+			 *   Only switch cgroup events from EVENT_FLEXIBLE
+			 *   groups.
+			 * - EVENT_PINNED | EVENT_CGROUP_PINNED_ONLY:
+			 *   Only switch cgroup events from EVENT_PINNED
+			 *   groups.
+			 * - EVENT_ALL | EVENT_CGROUP_ALL_ONLY:
+			 *   Only switch cgroup events from both EVENT_FLEXIBLE
+			 *   and EVENT_PINNED groups.
+			 */
+			cpu_ctx_sched_out(cpuctx,
+					EVENT_ALL | EVENT_CGROUP_ALL_ONLY);
 			/*
 			 * must not be done before ctxswout due
 			 * to event_filter_match() in event_sched_out()
@@ -831,7 +888,23 @@ static void perf_cgroup_switch(struct task_struct *task, int mode)
 			 */
 			cpuctx->cgrp = perf_cgroup_from_task(task,
 							     &cpuctx->ctx);
-			cpu_ctx_sched_in(cpuctx, EVENT_ALL, task);
+
+			/*
+			 * To keep the priority order of cpu pinned then cpu
+			 * flexible, if the new cgroup has pinned events then
+			 * sched out all system-wide flexilbe events before
+			 * sched in all events.
+			 */
+			if (cgroup_has_pinned_events(cpuctx->cgrp)) {
+				cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
+				cpu_ctx_sched_in(cpuctx,
+					EVENT_ALL | EVENT_CGROUP_PINNED_ONLY,
+					task);
+			} else {
+				cpu_ctx_sched_in(cpuctx,
+					EVENT_ALL | EVENT_CGROUP_ALL_ONLY,
+					task);
+			}
 		}
 		perf_pmu_enable(cpuctx->ctx.pmu);
 		perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
@@ -959,6 +1032,9 @@ static inline int perf_cgroup_connect(int fd, struct perf_event *event,
 	cgrp = container_of(css, struct perf_cgroup, css);
 	event->cgrp = cgrp;
 
+	if (event->attr.pinned)
+		cgrp->nr_pinned_event++;
+
 	/*
 	 * all events in a group must monitor
 	 * the same cgroup because a task belongs
@@ -1032,6 +1108,14 @@ list_update_cgroup_event(struct perf_event *event,
 
 #else /* !CONFIG_CGROUP_PERF */
 
+static inline bool
+perf_cgroup_skip_switch(enum event_type_t event_type,
+			struct perf_event *event,
+			bool pinned)
+{
+	return false;
+}
+
 static inline bool
 perf_cgroup_match(struct perf_event *event)
 {
@@ -3221,13 +3305,25 @@ static void ctx_sched_out(struct perf_event_context *ctx,
 
 	perf_pmu_disable(ctx->pmu);
 	if (is_active & EVENT_PINNED) {
-		list_for_each_entry_safe(event, tmp, &ctx->pinned_active, active_list)
+		list_for_each_entry_safe(event, tmp, &ctx->pinned_active,
+					active_list) {
+			if (perf_cgroup_skip_switch(event_type, event, true)) {
+				ctx->is_active |= EVENT_PINNED;
+				continue;
+			}
 			group_sched_out(event, cpuctx, ctx);
+		}
 	}
 
 	if (is_active & EVENT_FLEXIBLE) {
-		list_for_each_entry_safe(event, tmp, &ctx->flexible_active, active_list)
+		list_for_each_entry_safe(event, tmp, &ctx->flexible_active,
+					active_list) {
+			if (perf_cgroup_skip_switch(event_type, event, false)) {
+				ctx->is_active |= EVENT_FLEXIBLE;
+				continue;
+			}
 			group_sched_out(event, cpuctx, ctx);
+		}
 	}
 	perf_pmu_enable(ctx->pmu);
 }
@@ -3558,6 +3654,7 @@ static int merge_sched_in(struct perf_event_context *ctx,
 			struct perf_cpu_context *cpuctx,
 			struct perf_event *event,
 			bool is_pinned,
+			enum event_type_t event_type,
 			int *can_add_hw)
 {
 	WARN_ON_ONCE(event->ctx != ctx);
@@ -3565,6 +3662,9 @@ static int merge_sched_in(struct perf_event_context *ctx,
 	if (event->state <= PERF_EVENT_STATE_OFF)
 		return 0;
 
+	if (perf_cgroup_skip_switch(event_type, event, is_pinned))
+		return 0;
+
 	/*
 	 * Avoid full event_filter_match as the caller verified the CPU and
 	 * cgroup before calling.
@@ -3593,7 +3693,8 @@ static int merge_sched_in(struct perf_event_context *ctx,
 
 static int ctx_groups_sched_in(struct perf_event_context *ctx,
 			struct perf_cpu_context *cpuctx,
-			bool is_pinned)
+			bool is_pinned,
+			enum event_type_t event_type)
 {
 #ifdef CONFIG_CGROUP_PERF
 	struct cgroup_subsys_state *css = NULL;
@@ -3654,7 +3755,8 @@ static int ctx_groups_sched_in(struct perf_event_context *ctx,
 	min_max_heapify_all(&event_heap, &perf_min_heap);
 
 	while (event_heap.size) {
-		ret = merge_sched_in(ctx, cpuctx, *evt, is_pinned, &can_add_hw);
+		ret = merge_sched_in(ctx, cpuctx, *evt, event_type, is_pinned,
+				&can_add_hw);
 
 		if (ret)
 			return ret;
@@ -3676,6 +3778,7 @@ ctx_sched_in(struct perf_event_context *ctx,
 	     enum event_type_t event_type,
 	     struct task_struct *task)
 {
+	enum event_type_t ctx_event_type = event_type & EVENT_ALL;
 	int is_active = ctx->is_active;
 	u64 now;
 
@@ -3684,7 +3787,7 @@ ctx_sched_in(struct perf_event_context *ctx,
 	if (likely(!ctx->nr_events))
 		return;
 
-	ctx->is_active |= (event_type | EVENT_TIME);
+	ctx->is_active |= (ctx_event_type | EVENT_TIME);
 	if (ctx->task) {
 		if (!is_active)
 			cpuctx->task_ctx = ctx;
@@ -3704,14 +3807,22 @@ ctx_sched_in(struct perf_event_context *ctx,
 	/*
 	 * First go through the list and put on any pinned groups
 	 * in order to give them the best chance of going on.
+	 *
+	 * System-wide events may not have been scheduled out for a cgroup
+	 * switch.  Unconditionally call sched_in() for cgroup events and
+	 * it will filter the events.
 	 */
-	if (is_active & EVENT_PINNED)
-		ctx_groups_sched_in(ctx, cpuctx, /*is_pinned=*/true);
+	if ((is_active & EVENT_PINNED) || CGROUP_PINNED(event_type)) {
+		ctx_groups_sched_in(ctx, cpuctx, /*is_pinned=*/true,
+				CGROUP_PINNED(event_type));
+	}
 
 
 	/* Then walk through the lower prio flexible groups */
-	if (is_active & EVENT_FLEXIBLE)
-		ctx_groups_sched_in(ctx, cpuctx, /*is_pinned=*/false);
+	if ((is_active & EVENT_FLEXIBLE) || CGROUP_FLEXIBLE(event_type)) {
+		ctx_groups_sched_in(ctx, cpuctx, /*is_pinned=*/false,
+				CGROUP_FLEXIBLE(event_type));
+	}
 }
 
 static void cpu_ctx_sched_in(struct perf_cpu_context *cpuctx,
-- 
2.24.0.432.g9d3f5f5b63-goog

