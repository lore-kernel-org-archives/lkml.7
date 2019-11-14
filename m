Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9122C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3947206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UVRhPNE7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfKNAbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 19:31:22 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:42584 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfKNAbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 19:31:19 -0500
Received: by mail-pl1-f202.google.com with SMTP id 30so2630552plb.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 16:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5Q9PEm/ygV5JKPwEXPPf6NylDVdkOIERxPJji5Pd1E4=;
        b=UVRhPNE7bZtzFtr5gNEYEJj8g3iCvMqPwpcQ3BEZhInRoaZHK/AMhkVAtv7ch0WZ4n
         HOpTDrIidTC2SX6Rkm77YVd8vQNDAl0BePspSwh5dkBJOPgQT90u8r/8z2IXfAc57hje
         3Fn01tm1dGggt8P0TpKcMQcT4Eme62nKKu2VWKxZzI5/9Nq5x9VfTTCR/js5dCR2cVUy
         ReSYNHnJ8SSSsXKoQ4miZ69QgFF6FKEEJXBdPrcDsQzWjchrfjr/JztYHLRfZvQUPbkv
         ga8CLyuqje0YWtH9bXAmmOJ13Oajl1Hg1vA63UYdB41O9lDnKq0hhfjyyVHlKnxndrkz
         abGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5Q9PEm/ygV5JKPwEXPPf6NylDVdkOIERxPJji5Pd1E4=;
        b=Ksk2fKdWEWAtJ93O358RQCLDzgaTk4l3OJ4mQRFqkz01+ys8XeK9p2jWYznzFiSczf
         NW6zSzpqIVE3MWBFDSMm6atgSEFnwYicmt3QBTc8usIfOsNS3syVvaBfOmQ+dx4yyg2s
         KDGrssVv7r543jcmzpd+cc3NsS6o9mJa/JWxvoAneixvuC9w94PeSbLJ09JgT2ScNFfc
         9kZkEqKX4v/XsfeaXaq+UYEbhPCz51BvBUmdKxQ4ZPqfskCDlQhwYOoaRs0RWgWPDnsa
         gxV5XdhAkiGP/UuIYeBF2rnRu6sSZ4ktUUOIWxBxnrqXO2A8TRTPZAL1i2QZwx5/fhcI
         vk+A==
X-Gm-Message-State: APjAAAX4Q43rWxxV4rilK3k5oxjptTHHvKIZtWnRSftAElQsN54+EVlV
        ghDp/NiUWF7JrWxdog0SbtJZOflwP2Un
X-Google-Smtp-Source: APXvYqzFT+yDNUape0FjOIJrY9hqwl/cRn9MQ3xmsUctyJJB/rSUKGfIDgS1D9Uz4MvcMGISYFz8sPVUt6yr
X-Received: by 2002:a63:6e82:: with SMTP id j124mr6963463pgc.115.1573691476947;
 Wed, 13 Nov 2019 16:31:16 -0800 (PST)
Date:   Wed, 13 Nov 2019 16:30:42 -0800
In-Reply-To: <20191114003042.85252-1-irogers@google.com>
Message-Id: <20191114003042.85252-11-irogers@google.com>
Mime-Version: 1.0
References: <20191114003042.85252-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v3 10/10] perf/cgroup: Do not switch system-wide events in
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
        Sri Krishna chowdary <schowdary@nvidia.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
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
 kernel/events/core.c       | 150 +++++++++++++++++++++++++++++++++----
 2 files changed, 135 insertions(+), 16 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index cfd0b320418c..f79f1cf1c2fb 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -877,6 +877,7 @@ struct perf_cgroup_info {
 struct perf_cgroup {
 	struct cgroup_subsys_state	css;
 	struct perf_cgroup_info	__percpu *info;
+	unsigned int			nr_pinned_event;
 	/* A cache of the first event with the perf_cpu_context's
 	 * perf_event_context for the first event in pinned_groups or
 	 * flexible_groups. Avoids an rbtree search during sched_in.
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 99ac8248a9b6..eb61c7b5157f 100644
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
+			bool pinned)
+{
+	if (event->cgrp)
+		return 0;
+	if (pinned)
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
@@ -3203,13 +3287,25 @@ static void ctx_sched_out(struct perf_event_context *ctx,
 
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
@@ -3538,16 +3634,19 @@ static void __heap_add(struct min_max_heap *heap, struct perf_event *event)
 
 static int pinned_sched_in(struct perf_event_context *ctx,
 			struct perf_cpu_context *cpuctx,
-			struct perf_event *event);
+			struct perf_event *event,
+			enum event_type_t event_type);
 
 static int flexible_sched_in(struct perf_event_context *ctx,
 			struct perf_cpu_context *cpuctx,
 			struct perf_event *event,
+			enum event_type_t event_type,
 			int *can_add_hw);
 
 static int ctx_groups_sched_in(struct perf_event_context *ctx,
 			struct perf_cpu_context *cpuctx,
-			bool is_pinned)
+			bool is_pinned,
+			enum event_type_t event_type)
 {
 #ifdef CONFIG_CGROUP_PERF
 	struct cgroup_subsys_state *css = NULL;
@@ -3610,10 +3709,12 @@ static int ctx_groups_sched_in(struct perf_event_context *ctx,
 	heapify_all(&event_heap, &perf_min_heap);
 
 	while (event_heap.size) {
-		if (is_pinned)
-			ret = pinned_sched_in(ctx, cpuctx, *evt);
-		else
-			ret = flexible_sched_in(ctx, cpuctx, *evt, &can_add_hw);
+		if (is_pinned) {
+			ret = pinned_sched_in(ctx, cpuctx, *evt, event_type);
+		} else {
+			ret = flexible_sched_in(ctx, cpuctx, *evt, event_type,
+						&can_add_hw);
+		}
 
 		if (ret)
 			return ret;
@@ -3630,11 +3731,15 @@ static int ctx_groups_sched_in(struct perf_event_context *ctx,
 
 static int pinned_sched_in(struct perf_event_context *ctx,
 			struct perf_cpu_context *cpuctx,
-			struct perf_event *event)
+			struct perf_event *event,
+			enum event_type_t event_type)
 {
 	if (event->state <= PERF_EVENT_STATE_OFF)
 		return 0;
 
+	if (perf_cgroup_skip_switch(event_type, event, true))
+		return 0;
+
 	/*
 	 * Avoid full event_filter_match as the caller verified the CPU and
 	 * cgroup before calling.
@@ -3660,11 +3765,15 @@ static int pinned_sched_in(struct perf_event_context *ctx,
 static int flexible_sched_in(struct perf_event_context *ctx,
 			struct perf_cpu_context *cpuctx,
 			struct perf_event *event,
+			enum event_type_t event_type,
 			int *can_add_hw)
 {
 	if (event->state <= PERF_EVENT_STATE_OFF)
 		return 0;
 
+	if (perf_cgroup_skip_switch(event_type, event, true))
+		return 0;
+
 	/*
 	 * Avoid full event_filter_match as the caller verified the CPU and
 	 * cgroup before calling.
@@ -3691,6 +3800,7 @@ ctx_sched_in(struct perf_event_context *ctx,
 	     enum event_type_t event_type,
 	     struct task_struct *task)
 {
+	enum event_type_t ctx_event_type = event_type & EVENT_ALL;
 	int is_active = ctx->is_active;
 	u64 now;
 
@@ -3699,7 +3809,7 @@ ctx_sched_in(struct perf_event_context *ctx,
 	if (likely(!ctx->nr_events))
 		return;
 
-	ctx->is_active |= (event_type | EVENT_TIME);
+	ctx->is_active |= (ctx_event_type | EVENT_TIME);
 	if (ctx->task) {
 		if (!is_active)
 			cpuctx->task_ctx = ctx;
@@ -3719,14 +3829,22 @@ ctx_sched_in(struct perf_event_context *ctx,
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

