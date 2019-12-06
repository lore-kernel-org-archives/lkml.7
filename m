Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83650C2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 23:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E24524687
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 23:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="phDmIKj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfLFXP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 18:15:58 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:48149 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfLFXP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 18:15:57 -0500
Received: by mail-pg1-f202.google.com with SMTP id p188so4627345pgp.15
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 15:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jCG/OJqRz1g2O980DTmx+XHwj/u6xaJLzHSXy96lsoQ=;
        b=phDmIKj0jXXO0+BieOR5pP6UkyZGwrtDwGG/8J1ws5dqR9Xx/G4xnP4qTKOBBF8ZyX
         erhKo7Llx3ZEUICBQacxD4CKrKDUSLB3WBX8A64IrWfGgAeexxrVHLc6m2e849ONF5oY
         CY7G+ehA15yXqpziHF2RZ03jcbm6ThYVRVcX1ctedZljNQgshpe5G20R+nWiiIBTFnSM
         PAwqHK6rkhC7DiOUJBGadez6rF+Ou9hjx74/pa0l0lFZ9mVdLlJ27YBy8PNmUzCnElcC
         ws/LtEQEubm3TU+m7m3kau8zZL7orL5KlEMwxE52zP/Yh2yOXAQAyNoS9a3QTMUNQR8J
         o+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jCG/OJqRz1g2O980DTmx+XHwj/u6xaJLzHSXy96lsoQ=;
        b=gD20tQKtKumZR4mYMZWyhv5NreiFeBRcInGEHc75i7OAdaizMpLkMZUSknzOuHq0iQ
         1efNc9Jb+Vc+gzt5MZ1o57iwOayzP00X7h4wVIUSFwYQ6zBLV1+RiojgNyYn15/jcM57
         4AcynYYgOYn/lKAWhWuKsC4PojPke090ZunH36hkU9QCHM4buE7zTMUwMbM7TYT7o89F
         LKE2P/cnHkJc9kcJsWbhC6JabWFIxBcInRWjva8DvjIaYtpG5FWVhv5N0GZaQ3L/vMQO
         WMzhVL/yyfDVe/2LMcs723IMZ0KOiH/ZCbha8Ms2MEGgBvnM5S3G550WGymg94Plv55k
         jkuw==
X-Gm-Message-State: APjAAAVdCpmGwXEzFmwgBbElOeiTA5k+E7P+FALx8NmFB2EBysDXWq2e
        Z7aq3Z4V9K7OaFpPm9nJQbrV0UsTxkEa
X-Google-Smtp-Source: APXvYqziEQoVG1C+4mpFwfOkhXg9zpcXRSEL0X77Q5a5ZgsEm+R/ev7n+t33X7NAWXoPGlHpthuRVSN5O/PK
X-Received: by 2002:a63:1b54:: with SMTP id b20mr6258119pgm.312.1575674157095;
 Fri, 06 Dec 2019 15:15:57 -0800 (PST)
Date:   Fri,  6 Dec 2019 15:15:33 -0800
In-Reply-To: <20191206231539.227585-1-irogers@google.com>
Message-Id: <20191206231539.227585-5-irogers@google.com>
Mime-Version: 1.0
References: <20191116011845.177150-1-irogers@google.com> <20191206231539.227585-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v5 04/10] perf: Add per perf_cpu_context min_heap storage
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

The storage required for visit_groups_merge's min heap needs to vary in
order to support more iterators, such as when multiple nested cgroups'
events are being visited. This change allows for 2 iterators and doesn't
support growth.
Based-on-work-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/linux/perf_event.h |  7 +++++
 kernel/events/core.c       | 63 +++++++++++++++++++++++++-------------
 2 files changed, 49 insertions(+), 21 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 34c7c6910026..cd7d3b624655 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -850,6 +850,13 @@ struct perf_cpu_context {
 	int				sched_cb_usage;
 
 	int				online;
+	/*
+	 * Per-CPU storage for iterators used in visit_groups_merge. The default
+	 * storage is of size 2 to hold the CPU and any CPU event iterators.
+	 */
+	int				itr_storage_cap;
+	struct perf_event		**itr_storage;
+	struct perf_event		*itr_default[2];
 };
 
 struct perf_output_handle {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index e0cc1c833408..259eca137563 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -49,7 +49,7 @@
 #include <linux/sched/mm.h>
 #include <linux/proc_ns.h>
 #include <linux/mount.h>
-#include <linux/min_max_heap.h>
+#include <linux/min_heap.h>
 
 #include "internal.h"
 
@@ -3402,13 +3402,13 @@ static void swap_ptr(void *l, void *r)
 	swap(*lp, *rp);
 }
 
-static const struct min_max_heap_callbacks perf_min_heap = {
+static const struct min_heap_callbacks perf_min_heap = {
 	.elem_size = sizeof(struct perf_event *),
 	.cmp = perf_cmp_group_idx,
 	.swp = swap_ptr,
 };
 
-static void __heap_add(struct min_max_heap *heap, struct perf_event *event)
+static void __heap_add(struct min_heap *heap, struct perf_event *event)
 {
 	struct perf_event **itrs = heap->data;
 
@@ -3418,37 +3418,49 @@ static void __heap_add(struct min_max_heap *heap, struct perf_event *event)
 	}
 }
 
-static noinline int visit_groups_merge(struct perf_event_groups *groups,
-				int cpu,
+static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
+				struct perf_event_groups *groups, int cpu,
 				int (*func)(struct perf_event *, void *),
 				void *data)
 {
 	/* Space for per CPU and/or any CPU event iterators. */
 	struct perf_event *itrs[2];
-	struct min_max_heap event_heap = {
-		.data = itrs,
-		.size = 0,
-		.cap = ARRAY_SIZE(itrs),
-	};
+	struct min_heap event_heap;
+	struct perf_event **evt;
 	struct perf_event *next;
 	int ret;
 
-	__heap_add(&event_heap, perf_event_groups_first(groups, -1));
+	if (cpuctx) {
+		event_heap = (struct min_heap){
+			.data = cpuctx->itr_storage,
+			.size = 0,
+			.cap = cpuctx->itr_storage_cap,
+		};
+	} else {
+		event_heap = (struct min_heap){
+			.data = itrs,
+			.size = 0,
+			.cap = ARRAY_SIZE(itrs),
+		};
+		/* Events not within a CPU context may be on any CPU. */
+		__heap_add(&event_heap, perf_event_groups_first(groups, -1));
+	}
+	evt = event_heap.data;
+
 	__heap_add(&event_heap, perf_event_groups_first(groups, cpu));
 
-	min_max_heapify_all(&event_heap, &perf_min_heap);
+	min_heapify_all(&event_heap, &perf_min_heap);
 
 	while (event_heap.size) {
-		ret = func(itrs[0], data);
+		ret = func(*evt, data);
 		if (ret)
 			return ret;
 
-		next = perf_event_groups_next(itrs[0]);
-		if (next) {
-			min_max_heap_pop_push(&event_heap, &next,
-					&perf_min_heap);
-		} else
-			min_max_heap_pop(&event_heap, &perf_min_heap);
+		next = perf_event_groups_next(*evt);
+		if (next)
+			min_heap_pop_push(&event_heap, &next, &perf_min_heap);
+		else
+			min_heap_pop(&event_heap, &perf_min_heap);
 	}
 
 	return 0;
@@ -3518,7 +3530,10 @@ ctx_pinned_sched_in(struct perf_event_context *ctx,
 		.can_add_hw = 1,
 	};
 
-	visit_groups_merge(&ctx->pinned_groups,
+	if (ctx != &cpuctx->ctx)
+		cpuctx = NULL;
+
+	visit_groups_merge(cpuctx, &ctx->pinned_groups,
 			   smp_processor_id(),
 			   pinned_sched_in, &sid);
 }
@@ -3533,7 +3548,10 @@ ctx_flexible_sched_in(struct perf_event_context *ctx,
 		.can_add_hw = 1,
 	};
 
-	visit_groups_merge(&ctx->flexible_groups,
+	if (ctx != &cpuctx->ctx)
+		cpuctx = NULL;
+
+	visit_groups_merge(cpuctx, &ctx->flexible_groups,
 			   smp_processor_id(),
 			   flexible_sched_in, &sid);
 }
@@ -10350,6 +10368,9 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 		cpuctx->online = cpumask_test_cpu(cpu, perf_online_mask);
 
 		__perf_mux_hrtimer_init(cpuctx, cpu);
+
+		cpuctx->itr_storage_cap = ARRAY_SIZE(cpuctx->itr_default);
+		cpuctx->itr_storage = cpuctx->itr_default;
 	}
 
 got_cpu_context:
-- 
2.24.0.393.g34dc348eaf-goog

