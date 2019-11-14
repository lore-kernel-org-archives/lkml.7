Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075B9C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14AF0206EC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fbEOpuZe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfKNAbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 19:31:01 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:42805 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKNAa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 19:30:57 -0500
Received: by mail-qt1-f202.google.com with SMTP id l8so2781120qtq.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 16:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uV0aJzQ3FQrSGECxm2tdmnAg4W4Bpkq1l+cWV9HDhGU=;
        b=fbEOpuZehQn+pO/sqEv7BM6usQrrLv/ZWky4zutTwhFWvqRdqPon6Q3OzjT4Xe855K
         dsCy7ZCNHEMs/NzaTvNUwENoIWWV6VW4AU7i7eGE6cLpNJVUV5ep1OkpzXE3f0dr6rRM
         LfyxPk+cuF3MEAXImLSE9wvgib1EaEWp6fot9XHvMbZNaUriymQOjQ+CKYoZH327RyDd
         dw1vv2Ql0NhC5WWg8xMpe7GGyAyFIa0RAFzJwjIxV8dS7MSNAaCXpLmKN8caQsuPzNqa
         hAB4kJx/C26uUVF2V2h2xrE5CLwXXYFGKU8vLKMUJnljPToVoxxVeNRQs+WILDClmrSU
         5VUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uV0aJzQ3FQrSGECxm2tdmnAg4W4Bpkq1l+cWV9HDhGU=;
        b=O1tgqzEmnXDBaMC2YVwKLk+PwPhFkVNNXVZO2Id/PVBvXvwWPq6nzHPMK4fGYyFU+/
         BwTaS6b6RMZw8qe6ncPJv73sTufo6hU2NIe4oKCoYVN2AZ5D/ovshSUUE+O51yJGsZaK
         XUsWCD8kE/VHnUrlHxPEsLWRK2tvkhul6NdbtvWm9aJLinomdK9YKP7DGz9iVfUBaVcx
         EUqb87JOUBGdpHvc9qaSu7Vd2clA+z3MsZMBmmBlf/fGR5aDRf6z0Wi09mXSFX47DERU
         BA72cVevk3dSQz1g8jnfIBgxbUpx/h8KBQfbbAJi/E9y1I1wMB7k2y8p5VG2ZET7DLfU
         31Rg==
X-Gm-Message-State: APjAAAVxygE4DnFjTdf3TzOgqNZ33XsIrJMTMl1jBrhlPiOg5U/xeajW
        KEsY51hOxg9tqyxJO4aandyG+ghk4DdK
X-Google-Smtp-Source: APXvYqy9pyEJPlRwC+Yww+yoaCMblMpVlRtfLySTVRs97JThhYU8k1iiQGfWc96xtLxTUUSSrzZYrjumDvfr
X-Received: by 2002:a37:8a82:: with SMTP id m124mr5286150qkd.235.1573691456103;
 Wed, 13 Nov 2019 16:30:56 -0800 (PST)
Date:   Wed, 13 Nov 2019 16:30:35 -0800
In-Reply-To: <20191114003042.85252-1-irogers@google.com>
Message-Id: <20191114003042.85252-4-irogers@google.com>
Mime-Version: 1.0
References: <20191114003042.85252-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v3 03/10] perf: Use min_max_heap in visit_groups_merge
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

Based-on-work-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 kernel/events/core.c | 67 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 50 insertions(+), 17 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0dce28b0aae0..a5a3d349a8f1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -49,6 +49,7 @@
 #include <linux/sched/mm.h>
 #include <linux/proc_ns.h>
 #include <linux/mount.h>
+#include <linux/min_max_heap.h>
 
 #include "internal.h"
 
@@ -3372,32 +3373,64 @@ static void cpu_ctx_sched_out(struct perf_cpu_context *cpuctx,
 	ctx_sched_out(&cpuctx->ctx, cpuctx, event_type);
 }
 
-static int visit_groups_merge(struct perf_event_groups *groups, int cpu,
+static bool perf_cmp_group_idx(const void *l, const void *r)
+{
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
+static noinline int visit_groups_merge(struct perf_event_groups *groups, int cpu,
 			      int (*func)(struct perf_event *, void *), void *data)
 {
-	struct perf_event **evt, *evt1, *evt2;
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
+	heapify_all(&event_heap, &perf_min_heap);
 
-		ret = func(*evt, data);
+	while (event_heap.size) {
+		ret = func(itrs[0], data);
 		if (ret)
 			return ret;
 
-		*evt = perf_event_groups_next(*evt);
+		next = perf_event_groups_next(itrs[0]);
+		if (next)
+			heap_pop_push(&event_heap, &next, &perf_min_heap);
+		else
+			heap_pop(&event_heap, &perf_min_heap);
 	}
 
 	return 0;
-- 
2.24.0.432.g9d3f5f5b63-goog

