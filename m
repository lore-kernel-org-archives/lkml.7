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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2B7C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 01:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB8620733
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 01:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QOKV8nnv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfKPBTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 20:19:02 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:38524 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfKPBTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 20:19:01 -0500
Received: by mail-pf1-f202.google.com with SMTP id m1so9090133pfh.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 17:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yg0cKPfqbWv1EmH0CQGvI/P8hyKMdso1sxEuOTAiSFw=;
        b=QOKV8nnv7TNQDze70guLkolpOswg9WPfJwTCzHeoVAid0m72y25q06ZwH2tXaIf6BV
         AFzDOIH+LmBEhpLHjLP6xirXaFl/sIK6aC55CbyLnCEzPlaeLqDn0Mu+cSFK3VlSNKPc
         R3wC3/IRmgQaGCs3aDOrPw2c3ObT+0MR72q0GyqnwlM9FHHKnLxwGX7Sndv/5FvLiz6r
         HihfVZ3C7gaVpl7BthEzbjbbbDcpEUVuukDG03schfQJOKQnSnYnhnXzjHddx9GFGrTx
         nwJCtI3Nh6UeCbcGMFxaVuphBtfJpOhMFKBV9qHWzWgk7o+mIiDhyP/Dz1WZ+MYgmrJn
         IYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yg0cKPfqbWv1EmH0CQGvI/P8hyKMdso1sxEuOTAiSFw=;
        b=jzpBduvNijydfYpjmOEEglV5xF6u3cQBNJ3sCFIk0aapWUq3swhjFjDUQrIIlP8AE8
         7+VGZAA2kBgfICG38mq1ESEpVKTkrBF9pzwfe6N77cBq24nb/SG/dwEPT7YgYPrTuAxX
         g83vF1K/NjGZs/0EDB8ZibVtaENtvjR4nIfvSysHMh7Lfe8sCiW0wD5z/9cnI2Qiqopz
         L9mrxEBrpcAicCRr7/WAPSXK2a3bJ/JizY5azi4bIBWFj3Y6lL3P2o4WJ4xAOrP/2XLe
         CnyBtWnrwsdMI+lVehABCUh0GcrOg2Y++1lw7pCELQ6ZQNI8dcEbS2Z4W5loH9Lhengj
         Mqxw==
X-Gm-Message-State: APjAAAXgSEXpPYiBsxGaEXxBlWqUeFcdZ/RW6adZnPXJakqvWYvY3HVw
        CXZlujOw16xo++hQ4y2Hv34InPsi52IR
X-Google-Smtp-Source: APXvYqzgNItggL0zXV7oOKuz2JdMs78HhEaJaGQ+tPxDeem/Csd0BUtn/ekVCvPMJm1/6PlgidfrShInZ0m+
X-Received: by 2002:a63:64c3:: with SMTP id y186mr19308418pgb.409.1573867137998;
 Fri, 15 Nov 2019 17:18:57 -0800 (PST)
Date:   Fri, 15 Nov 2019 17:18:38 -0800
In-Reply-To: <20191116011845.177150-1-irogers@google.com>
Message-Id: <20191116011845.177150-4-irogers@google.com>
Mime-Version: 1.0
References: <20191114003042.85252-1-irogers@google.com> <20191116011845.177150-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v4 03/10] perf: Use min_max_heap in visit_groups_merge
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
index 0dce28b0aae0..b0e89a488e3d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -49,6 +49,7 @@
 #include <linux/sched/mm.h>
 #include <linux/proc_ns.h>
 #include <linux/mount.h>
+#include <linux/min_max_heap.h>
 
 #include "internal.h"
 
@@ -3372,32 +3373,67 @@ static void cpu_ctx_sched_out(struct perf_cpu_context *cpuctx,
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
2.24.0.432.g9d3f5f5b63-goog

