Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F93AC2D0C1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 23:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CC72464E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 23:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SgiVBzQj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfLFXQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 18:16:01 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:38598 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfLFXPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 18:15:55 -0500
Received: by mail-pj1-f73.google.com with SMTP id k93so4418891pjh.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 15:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dQcTotfpal6OIFNFfZsJBWPz/JeXUsjONjaFgIBxFvQ=;
        b=SgiVBzQjnMVCLe5dzS0N4Xr20kf5G67BRXOolP1/rodR7ETjX1ylLJKHhGIKos10hB
         Lk0hzXBgcq+eMXqyUz61Kgj6zb2Z+LQUWM3y1MauMkRht+DgTUOQzU4xM5Afhe+S0Vgx
         hWKS9p/oGNHM4f0ImtEV0/Y7YNAqkvvQHFGEgS1NY08jEGck1A0sb+Wa5Yk+o8wvldAl
         cYx1diE0BszLDEpRtKZhaIUJFbe29nYWtezC4VN8CkhyeFrEiSTUmr/Q5Xn1QCBH4CiW
         mcC/0+pyVBxGf8uJudJ0WHmDlLMOHyPsYElLEha60T190WYE92IF7V8vGxG+4j7+5YUX
         X8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dQcTotfpal6OIFNFfZsJBWPz/JeXUsjONjaFgIBxFvQ=;
        b=A6zQH40Ahf27WMQcIYeSzU0FrPqoZ9oJ8QNVGyg9gnTIHXcBOWPOSt3gSnR15+Irmd
         ZNd3bfH8Yjvd0IOLOkH1+NqN251yN5wuP8lFVkn16084shZFmwL6NHCGIldWcF/5JzAr
         bwMBWx+L0H7ngZKRDxfbSKv8jUIuSW9Oca5jNT1ql5HvrRnRHKXFVpmoy7R6ZNeldrk4
         zeuwukfrWSW0FR4/qqUt9CPYWamYyE0NDY8n3wUQ17C7Cvy1dgHxHoa1HYcxw1/GcKTK
         gGzN+O7ihlrBwBbKoSPcDA1f/T/7/nw2vsAnkQVnRIEhv2M8i83PfDmrw96CORTMVWe0
         0FgQ==
X-Gm-Message-State: APjAAAWVMUPvkbtvAS4CToJW8owd+4ROr74aUBZu8Sm9wpdemdwwHH3i
        jQ8RY7YFdJLXIgiqYvitmlTgFFK7UlBp
X-Google-Smtp-Source: APXvYqwgukUC1YiLF3qHMaEl8YVY8YDY56SBIHR7cDcK77OjjI6C/3CmgRX49oDT+nffiSiZryVyAh0Ertpu
X-Received: by 2002:a65:56c6:: with SMTP id w6mr6430940pgs.167.1575674154668;
 Fri, 06 Dec 2019 15:15:54 -0800 (PST)
Date:   Fri,  6 Dec 2019 15:15:32 -0800
In-Reply-To: <20191206231539.227585-1-irogers@google.com>
Message-Id: <20191206231539.227585-4-irogers@google.com>
Mime-Version: 1.0
References: <20191116011845.177150-1-irogers@google.com> <20191206231539.227585-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v5 03/10] perf: Use min_max_heap in visit_groups_merge
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

visit_groups_merge will pick the next event based on when it was
inserted in to the context (perf_event group_index). Events may be per CPU
or for any CPU, but in the future we'd also like to have per cgroup events
to avoid searching all events for the events to schedule for a cgroup.
Introduce a min heap for the events that maintains a property that the
earliest inserted event is always at the 0th element. Initialize the heap
with per-CPU and any-CPU events for the context.
Based-on-work-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Signed-off-by: Ian Rogers <irogers@google.com>
---
 kernel/events/core.c | 72 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 54 insertions(+), 18 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9f055ca0651d..e0cc1c833408 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -49,6 +49,7 @@
 #include <linux/sched/mm.h>
 #include <linux/proc_ns.h>
 #include <linux/mount.h>
+#include <linux/min_max_heap.h>
 
 #include "internal.h"
 
@@ -3387,32 +3388,67 @@ static void cpu_ctx_sched_out(struct perf_cpu_context *cpuctx,
 	ctx_sched_out(&cpuctx->ctx, cpuctx, event_type);
 }
 
-static int visit_groups_merge(struct perf_event_groups *groups, int cpu,
-			      int (*func)(struct perf_event *, void *), void *data)
+static bool perf_cmp_group_idx(const void *l, const void *r)
 {
-	struct perf_event **evt, *evt1, *evt2;
+	const struct perf_event *le = l, *re = r;
+
+	return le->group_index < re->group_index;
+}
+
+static void swap_ptr(void *l, void *r)
+{
+	void **lp = l, **rp = r;
+
+	swap(*lp, *rp);
+}
+
+static const struct min_max_heap_callbacks perf_min_heap = {
+	.elem_size = sizeof(struct perf_event *),
+	.cmp = perf_cmp_group_idx,
+	.swp = swap_ptr,
+};
+
+static void __heap_add(struct min_max_heap *heap, struct perf_event *event)
+{
+	struct perf_event **itrs = heap->data;
+
+	if (event) {
+		itrs[heap->size] = event;
+		heap->size++;
+	}
+}
+
+static noinline int visit_groups_merge(struct perf_event_groups *groups,
+				int cpu,
+				int (*func)(struct perf_event *, void *),
+				void *data)
+{
+	/* Space for per CPU and/or any CPU event iterators. */
+	struct perf_event *itrs[2];
+	struct min_max_heap event_heap = {
+		.data = itrs,
+		.size = 0,
+		.cap = ARRAY_SIZE(itrs),
+	};
+	struct perf_event *next;
 	int ret;
 
-	evt1 = perf_event_groups_first(groups, -1);
-	evt2 = perf_event_groups_first(groups, cpu);
+	__heap_add(&event_heap, perf_event_groups_first(groups, -1));
+	__heap_add(&event_heap, perf_event_groups_first(groups, cpu));
 
-	while (evt1 || evt2) {
-		if (evt1 && evt2) {
-			if (evt1->group_index < evt2->group_index)
-				evt = &evt1;
-			else
-				evt = &evt2;
-		} else if (evt1) {
-			evt = &evt1;
-		} else {
-			evt = &evt2;
-		}
+	min_max_heapify_all(&event_heap, &perf_min_heap);
 
-		ret = func(*evt, data);
+	while (event_heap.size) {
+		ret = func(itrs[0], data);
 		if (ret)
 			return ret;
 
-		*evt = perf_event_groups_next(*evt);
+		next = perf_event_groups_next(itrs[0]);
+		if (next) {
+			min_max_heap_pop_push(&event_heap, &next,
+					&perf_min_heap);
+		} else
+			min_max_heap_pop(&event_heap, &perf_min_heap);
 	}
 
 	return 0;
-- 
2.24.0.393.g34dc348eaf-goog

