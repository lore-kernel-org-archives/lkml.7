Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CAFC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071AF206F9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t1FyZA3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfKNAbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 19:31:12 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:47897 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfKNAbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 19:31:09 -0500
Received: by mail-pf1-f202.google.com with SMTP id w16so3057075pfq.14
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 16:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=f4k3ez/Z2g2n3nhpv/7wuR5Cj6xMKN7089/i7VdML90=;
        b=t1FyZA3Z0cEa0Kf1aVtC1C700HVDWQCXtS+lzxEfqdWYuQu7sysG0bd6ITl0Sz4lmd
         QqwYNGiX7gd399iuR4UpUOj9GbsTGNYKnlVCnUo8B2JqiXUHvGWgMbg8gN1E4QiBaq+Q
         58LTkIfgfv5Fpw9tjx5Ez3+goSCMC8S+5FTSliBlueVhnTHIJ6ZtnHmoPZGCiJK8ZTSp
         c8TkngCN7BTLFtgVjwahen3sdGS5LV0hbW72GU4ysTf7X2EkSjRrGF/8R0TUB0YPZFOQ
         YkoTGUaiL0EKajLTL2rUERBslKnMcq8CWjFcHeLy3JDybm0rNiG7RvvX6b06fw4DIejS
         I5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=f4k3ez/Z2g2n3nhpv/7wuR5Cj6xMKN7089/i7VdML90=;
        b=ipLgMDFTQvSrYOpt6BSSOwSG02gVfbhoYWFrjulkdRqFrQyZTt5BltL6EF9rxnhyru
         C3FUi2s1bRK4+JD3GN4K/T+3t54j/TDBtCc/1gp3HxPBUizzOqIiANsX7QHhWGICsC9c
         GvIrkm80kMiZADP3akqzK/VFu3xJiuARBAeWInw8p5ZBWnHTKiO9VK6D+iwwG2Elj/t1
         h8IrTdMUkaNinnarJMw373+kd3XVtNm/Z2OrbhopAMfiQRGk8a6UDQKSEqi5fFBfsHZ9
         zZqdgTtGD2aGbMiZceyk3fZ2WsMy1gkalti7B8ByWAmRwOp9mIF8OEFavKElZuqvxPPk
         0X5A==
X-Gm-Message-State: APjAAAXAVzaU4/2H36ECqE5vfWJRzHZy39HG7VE8hg9coiC227+S71Ab
        xanyOa2Zi4mLhxl4cpRiXleKJchowoJb
X-Google-Smtp-Source: APXvYqzouR4x08zlgNSZMLeSp7+ZOCvx2s6Yvi5DlWBiNdLAJRm1pGQ0X0hL22+w8uGIXrv8fxuzlF0olxjs
X-Received: by 2002:a63:1b5c:: with SMTP id b28mr6812488pgm.69.1573691467141;
 Wed, 13 Nov 2019 16:31:07 -0800 (PST)
Date:   Wed, 13 Nov 2019 16:30:39 -0800
In-Reply-To: <20191114003042.85252-1-irogers@google.com>
Message-Id: <20191114003042.85252-8-irogers@google.com>
Mime-Version: 1.0
References: <20191114003042.85252-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v3 07/10] perf: simplify and rename visit_groups_merge
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

To enable a future caching optimization, pass in whether
visit_groups_merge is operating on pinned or flexible groups. The
is_pinned argument makes the func argument redundant, rename the
function to ctx_groups_sched_in as it just schedules pinned or flexible
groups in. Compute the cpu and groups arguments locally to reduce the
argument list size. Remove sched_in_data as it repeats arguments already
passed in. Remove the unused data argument to pinned_sched_in.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 kernel/events/core.c | 106 +++++++++++++++++--------------------------
 1 file changed, 41 insertions(+), 65 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index cb5fc47611c7..11594d8bbb2e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3509,10 +3509,18 @@ static void __heap_add(struct min_max_heap *heap, struct perf_event *event)
 	}
 }
 
-static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
-				struct perf_event_groups *groups, int cpu,
-				int (*func)(struct perf_event *, void *),
-				void *data)
+static int pinned_sched_in(struct perf_event_context *ctx,
+			struct perf_cpu_context *cpuctx,
+			struct perf_event *event);
+
+static int flexible_sched_in(struct perf_event_context *ctx,
+			struct perf_cpu_context *cpuctx,
+			struct perf_event *event,
+			int *can_add_hw);
+
+static int ctx_groups_sched_in(struct perf_event_context *ctx,
+			struct perf_cpu_context *cpuctx,
+			bool is_pinned)
 {
 #ifdef CONFIG_CGROUP_PERF
 	struct cgroup_subsys_state *css = NULL;
@@ -3522,9 +3530,13 @@ static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
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
@@ -3562,7 +3574,11 @@ static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
 	heapify_all(&event_heap, &perf_min_heap);
 
 	while (event_heap.size) {
-		ret = func(*evt, data);
+		if (is_pinned)
+			ret = pinned_sched_in(ctx, cpuctx, *evt);
+		else
+			ret = flexible_sched_in(ctx, cpuctx, *evt, &can_add_hw);
+
 		if (ret)
 			return ret;
 
@@ -3576,25 +3592,19 @@ static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
 	return 0;
 }
 
-struct sched_in_data {
-	struct perf_event_context *ctx;
-	struct perf_cpu_context *cpuctx;
-	int can_add_hw;
-};
-
-static int pinned_sched_in(struct perf_event *event, void *data)
+static int pinned_sched_in(struct perf_event_context *ctx,
+			struct perf_cpu_context *cpuctx,
+			struct perf_event *event)
 {
-	struct sched_in_data *sid = data;
-
 	if (event->state <= PERF_EVENT_STATE_OFF)
 		return 0;
 
 	if (!event_filter_match(event))
 		return 0;
 
-	if (group_can_go_on(event, sid->cpuctx, sid->can_add_hw)) {
-		if (!group_sched_in(event, sid->cpuctx, sid->ctx))
-			list_add_tail(&event->active_list, &sid->ctx->pinned_active);
+	if (group_can_go_on(event, cpuctx, 1)) {
+		if (!group_sched_in(event, cpuctx, ctx))
+			list_add_tail(&event->active_list, &ctx->pinned_active);
 	}
 
 	/*
@@ -3607,65 +3617,30 @@ static int pinned_sched_in(struct perf_event *event, void *data)
 	return 0;
 }
 
-static int flexible_sched_in(struct perf_event *event, void *data)
+static int flexible_sched_in(struct perf_event_context *ctx,
+			struct perf_cpu_context *cpuctx,
+			struct perf_event *event,
+			int *can_add_hw)
 {
-	struct sched_in_data *sid = data;
-
 	if (event->state <= PERF_EVENT_STATE_OFF)
 		return 0;
 
 	if (!event_filter_match(event))
 		return 0;
 
-	if (group_can_go_on(event, sid->cpuctx, sid->can_add_hw)) {
-		int ret = group_sched_in(event, sid->cpuctx, sid->ctx);
+	if (group_can_go_on(event, cpuctx, *can_add_hw)) {
+		int ret = group_sched_in(event, cpuctx, ctx);
 		if (ret) {
-			sid->can_add_hw = 0;
-			sid->ctx->rotate_necessary = 1;
+			*can_add_hw = 0;
+			ctx->rotate_necessary = 1;
 			return 0;
 		}
-		list_add_tail(&event->active_list, &sid->ctx->flexible_active);
+		list_add_tail(&event->active_list, &ctx->flexible_active);
 	}
 
 	return 0;
 }
 
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
@@ -3702,11 +3677,12 @@ ctx_sched_in(struct perf_event_context *ctx,
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

