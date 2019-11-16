Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C602FC43215
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 01:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 907702073C
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 01:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lHfEkHgi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfKPBTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 20:19:14 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:35304 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfKPBTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 20:19:12 -0500
Received: by mail-pl1-f202.google.com with SMTP id x9so7461419plv.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 17:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2V31ewpXP+zkJsFFrpc7efvRnfpfbj2wFZXIFE+x5qo=;
        b=lHfEkHgi0/8bfzk5iA8SAtltDDytnHl9nmjvr0M65RyzndIDBc9z7O1qpbQw7cxj9T
         YYsJ59n9mQeced2aGDJWem659iKyfJOcHYv+vZydQVQucVX/p+2nliEZwlyrSF902fV0
         ZsApXpkA/s+E+JPR26aD1LB0uWCv5YXTQucyKoxGx7XuWmjt7+g4iiumhL0esf512nAv
         MebPd0lDT7SHdtQ1oYi0K/B7127q8cANPTzyce9bD+oB3uVn0ILn3/L+8+cZ9eXbW0hN
         CahNhP601rba2r154yffP5VkeEgq3vkZBYnx0NO89blHwoU2IvAdpWHrAm7vwZtCWyCB
         Acuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2V31ewpXP+zkJsFFrpc7efvRnfpfbj2wFZXIFE+x5qo=;
        b=XBE4ggWT9tiJGPLgL3lW2EGBKW0Bz/YrRyJxoHUPRQBXlU1OAUck6h+Vr2sAEmjH17
         m8xQfa4JNv2cxEzBPjEbjSXOgUkE0skq5EXZNDNS9Ar/bFpng/Dc/kQ3Aa9gBDLxGIHW
         9D0WP6ZsGZYOiXSeG7qdxG10tFtXya7PhVdiJqyCF1F2YTqU39jmdOwKaqRM/EPKt0uW
         jIWlTdfNFNb5rppNfeNdZ0OexUD4Zfo8Qox2CEkXG3NypkEhiN0g29PCMwberRv6xb2r
         8ON+Rd86+KbEFuXLxkY4cUArNJEguZZGktm9NMTkmm5fnTzp46SLy8ACZR97hqc2mbkz
         gHHQ==
X-Gm-Message-State: APjAAAVTNvCJNiUv6fHDV4r3SO5uHF1Um1MuCXSf+GsiE1Hr9NAwIRAG
        ZtRkp2Hubk45Wen3/hyuive8jCOKu8+9
X-Google-Smtp-Source: APXvYqzRM+j8LtppcKhcQakbQ2Q4KjhcQsnx9EQW24lSE7/ZkLNEfmTwEUpfcZLhCgHLGHcgiCVHNdDgSUHI
X-Received: by 2002:a63:7cf:: with SMTP id 198mr19633264pgh.372.1573867149402;
 Fri, 15 Nov 2019 17:19:09 -0800 (PST)
Date:   Fri, 15 Nov 2019 17:18:42 -0800
In-Reply-To: <20191116011845.177150-1-irogers@google.com>
Message-Id: <20191116011845.177150-8-irogers@google.com>
Mime-Version: 1.0
References: <20191114003042.85252-1-irogers@google.com> <20191116011845.177150-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v4 07/10] perf: simplify and rename visit_groups_merge
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

To enable a future caching optimization, pass in whether
visit_groups_merge is operating on pinned or flexible groups. The
is_pinned argument makes the func argument redundant, rename the
function to ctx_groups_sched_in as it just schedules pinned or flexible
groups in. Compute the cpu and groups arguments locally to reduce the
argument list size. Remove sched_in_data as it repeats arguments already
passed in. Merge pinned_sched_in and flexible_sched_in and use the
pinned argument to determine the active list.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 kernel/events/core.c | 149 ++++++++++++++-----------------------------
 1 file changed, 49 insertions(+), 100 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f26871ef352a..948a66967eb5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2118,7 +2118,6 @@ static void perf_group_detach(struct perf_event *event)
 
 		if (!RB_EMPTY_NODE(&event->group_node)) {
 			add_event_to_groups(sibling, event->ctx);
-
 			if (sibling->state == PERF_EVENT_STATE_ACTIVE) {
 				struct list_head *list = sibling->attr.pinned ?
 					&ctx->pinned_active : &ctx->flexible_active;
@@ -2441,6 +2440,8 @@ event_sched_in(struct perf_event *event,
 {
 	int ret = 0;
 
+	WARN_ON_ONCE(event->ctx != ctx);
+
 	lockdep_assert_held(&ctx->lock);
 
 	if (event->state <= PERF_EVENT_STATE_OFF)
@@ -3509,10 +3510,42 @@ static void __heap_add(struct min_max_heap *heap, struct perf_event *event)
 	}
 }
 
-static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
-				struct perf_event_groups *groups, int cpu,
-				int (*func)(struct perf_event *, void *),
-				void *data)
+static int merge_sched_in(struct perf_event_context *ctx,
+			struct perf_cpu_context *cpuctx,
+			struct perf_event *event,
+			bool is_pinned,
+			int *can_add_hw)
+{
+	WARN_ON_ONCE(event->ctx != ctx);
+
+	if (event->state <= PERF_EVENT_STATE_OFF)
+		return 0;
+
+	if (!event_filter_match(event))
+		return 0;
+
+	if (group_can_go_on(event, cpuctx, 1)) {
+		if (!group_sched_in(event, cpuctx, ctx)) {
+			list_add_tail(&event->active_list, is_pinned
+				? &ctx->pinned_active
+				: &ctx->flexible_active);
+		}
+	}
+
+	if (event->state == PERF_EVENT_STATE_INACTIVE) {
+		if (is_pinned)
+			perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
+
+		*can_add_hw = 0;
+		ctx->rotate_necessary = 1;
+	}
+
+	return 0;
+}
+
+static int ctx_groups_sched_in(struct perf_event_context *ctx,
+			struct perf_cpu_context *cpuctx,
+			bool is_pinned)
 {
 #ifdef CONFIG_CGROUP_PERF
 	struct cgroup_subsys_state *css = NULL;
@@ -3522,9 +3555,13 @@ static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
 	struct min_max_heap event_heap;
 	struct perf_event **evt;
 	struct perf_event *next;
-	int ret;
+	int ret, can_add_hw = 1;
+	int cpu = smp_processor_id();
+	struct perf_event_groups *groups = is_pinned
+		? &ctx->pinned_groups
+		: &ctx->flexible_groups;
 
-	if (cpuctx) {
+	if (ctx == &cpuctx->ctx) {
 		event_heap = (struct min_max_heap){
 			.data = cpuctx->itr_storage,
 			.size = 0,
@@ -3561,7 +3598,8 @@ static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
 	min_max_heapify_all(&event_heap, &perf_min_heap);
 
 	while (event_heap.size) {
-		ret = func(*evt, data);
+		ret = merge_sched_in(ctx, cpuctx, *evt, is_pinned, &can_add_hw);
+
 		if (ret)
 			return ret;
 
@@ -3576,96 +3614,6 @@ static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
 	return 0;
 }
 
-struct sched_in_data {
-	struct perf_event_context *ctx;
-	struct perf_cpu_context *cpuctx;
-	int can_add_hw;
-};
-
-static int pinned_sched_in(struct perf_event *event, void *data)
-{
-	struct sched_in_data *sid = data;
-
-	if (event->state <= PERF_EVENT_STATE_OFF)
-		return 0;
-
-	if (!event_filter_match(event))
-		return 0;
-
-	if (group_can_go_on(event, sid->cpuctx, sid->can_add_hw)) {
-		if (!group_sched_in(event, sid->cpuctx, sid->ctx))
-			list_add_tail(&event->active_list, &sid->ctx->pinned_active);
-	}
-
-	/*
-	 * If this pinned group hasn't been scheduled,
-	 * put it in error state.
-	 */
-	if (event->state == PERF_EVENT_STATE_INACTIVE)
-		perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
-
-	return 0;
-}
-
-static int flexible_sched_in(struct perf_event *event, void *data)
-{
-	struct sched_in_data *sid = data;
-
-	if (event->state <= PERF_EVENT_STATE_OFF)
-		return 0;
-
-	if (!event_filter_match(event))
-		return 0;
-
-	if (group_can_go_on(event, sid->cpuctx, sid->can_add_hw)) {
-		int ret = group_sched_in(event, sid->cpuctx, sid->ctx);
-		if (ret) {
-			sid->can_add_hw = 0;
-			sid->ctx->rotate_necessary = 1;
-			return 0;
-		}
-		list_add_tail(&event->active_list, &sid->ctx->flexible_active);
-	}
-
-	return 0;
-}
-
-static void
-ctx_pinned_sched_in(struct perf_event_context *ctx,
-		    struct perf_cpu_context *cpuctx)
-{
-	struct sched_in_data sid = {
-		.ctx = ctx,
-		.cpuctx = cpuctx,
-		.can_add_hw = 1,
-	};
-
-	if (ctx != &cpuctx->ctx)
-		cpuctx = NULL;
-
-	visit_groups_merge(cpuctx, &ctx->pinned_groups,
-			   smp_processor_id(),
-			   pinned_sched_in, &sid);
-}
-
-static void
-ctx_flexible_sched_in(struct perf_event_context *ctx,
-		      struct perf_cpu_context *cpuctx)
-{
-	struct sched_in_data sid = {
-		.ctx = ctx,
-		.cpuctx = cpuctx,
-		.can_add_hw = 1,
-	};
-
-	if (ctx != &cpuctx->ctx)
-		cpuctx = NULL;
-
-	visit_groups_merge(cpuctx, &ctx->flexible_groups,
-			   smp_processor_id(),
-			   flexible_sched_in, &sid);
-}
-
 static void
 ctx_sched_in(struct perf_event_context *ctx,
 	     struct perf_cpu_context *cpuctx,
@@ -3702,11 +3650,12 @@ ctx_sched_in(struct perf_event_context *ctx,
 	 * in order to give them the best chance of going on.
 	 */
 	if (is_active & EVENT_PINNED)
-		ctx_pinned_sched_in(ctx, cpuctx);
+		ctx_groups_sched_in(ctx, cpuctx, /*is_pinned=*/true);
+
 
 	/* Then walk through the lower prio flexible groups */
 	if (is_active & EVENT_FLEXIBLE)
-		ctx_flexible_sched_in(ctx, cpuctx);
+		ctx_groups_sched_in(ctx, cpuctx, /*is_pinned=*/false);
 }
 
 static void cpu_ctx_sched_in(struct perf_cpu_context *cpuctx,
-- 
2.24.0.432.g9d3f5f5b63-goog

