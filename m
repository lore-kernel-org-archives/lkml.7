Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAD5C2D0C1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 23:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E0520707
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 23:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uBhd8jQ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfLFXQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 18:16:08 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:40500 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfLFXQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 18:16:03 -0500
Received: by mail-pj1-f73.google.com with SMTP id x16so4411118pjq.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 15:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eeHiwTQLUOCsDH5tMUsZ9raUalT4UTX4dDSQ+ytC3GU=;
        b=uBhd8jQ7OxhMJLS7kKlGkUM4fLzVwC237EG0z/17pqJdQuwYu52XDKXS5qXH3+6uu/
         Jw8Acer5kBi26AmLvBXI7/JXEhgbradCzF2/PMP8nlT+9c2qxr3BAEFEu0XTotjq5nYe
         wfNzQi41P+NLV6h+cRfxUyuwmjoq0sxUUAxQvBXqxcIjtfjW2y3w9+HvaPrPr113aL97
         k5VYh0WBJHKWbO55OsCS9BwcMKwD7z60y7JtmwHKhiiIjTmvVs85h7dRTSPz08N3aEpj
         9tHB53322vpkNYmrDusHr70EskaChz3wl5/XZd3f/HfNRxAV2O1+4d6t9A8tQj5tBZP+
         vkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eeHiwTQLUOCsDH5tMUsZ9raUalT4UTX4dDSQ+ytC3GU=;
        b=gOuCFM4BEa2Nk/+I9DtnWA0on2p2jQVGBqajYYMp5P1IL5gWYvqe0IsF0xnSRy+HMv
         +dN3Amf+xYp3kMXvQxtsFOCrLBhCJMC9+5FOPfEQmg3Dr7cRq7rdfiu8D0Rl8pO3bJfl
         uPrPT9jOESMCeuQCoGuxDfukTfnNdYtgcmFxGOLehgo9p2wPUnCoUgpDIkcCRzkDw+At
         yRMA9SK7dWa94gdLIoh4lXSDmaAg09c8ICr4R+pEsuep1Cl78FEyurseqjalWrXmLAla
         m6GkGs1xQ0fUyiWYPdodgPIh4v/ujIQG0KPpKBjYX00qE+cZhhBxJm0n9gbCpGuXBISM
         Nzcg==
X-Gm-Message-State: APjAAAUi9ARnJbCTT2HqYR+lt0ZgdH7A0CVJsapeQAAO+C0xjXqXnkMK
        1Bb7JdKl/wbwqPfFZPdUWaHcCudbUB6S
X-Google-Smtp-Source: APXvYqz/qelO5QQRO2mGZBD88R3B8sE3UnFc0MUK5QKDw01dYro+nsDa2q7uE/cFn8Q3Hbg7BvFnogHtnmpW
X-Received: by 2002:a65:66c4:: with SMTP id c4mr6358319pgw.429.1575674162375;
 Fri, 06 Dec 2019 15:16:02 -0800 (PST)
Date:   Fri,  6 Dec 2019 15:15:35 -0800
In-Reply-To: <20191206231539.227585-1-irogers@google.com>
Message-Id: <20191206231539.227585-7-irogers@google.com>
Mime-Version: 1.0
References: <20191116011845.177150-1-irogers@google.com> <20191206231539.227585-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v5 06/10] perf/cgroup: Order events in RB tree by cgroup id
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

If one is monitoring 6 events on 20 cgroups the per-CPU RB tree will
hold 120 events. The scheduling in of the events currently iterates
over all events looking to see which events match the task's cgroup or
its cgroup hierarchy. If a task is in 1 cgroup with 6 events, then 114
events are considered unnecessarily.

This change orders events in the RB tree by cgroup id if it is present.
This means scheduling in may go directly to events associated with the
task's cgroup if one is present. The per-CPU iterator storage in
visit_groups_merge is sized sufficent for an iterator per cgroup depth,
where different iterators are needed for the task's cgroup and parent
cgroups. By considering the set of iterators when visiting, the lowest
group_index event may be selected and the insertion order group_index
property is maintained. This also allows event rotation to function
correctly, as although events are grouped into a cgroup, rotation always
selects the lowest group_index event to rotate (delete/insert into the
tree) and the min heap of iterators make it so that the group_index order
is maintained.

Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Link: https://lkml.kernel.org/r/20190724223746.153620-3-irogers@google.com
---
 kernel/events/core.c | 97 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 87 insertions(+), 10 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1e484ffff572..20e08d0c1cb9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1576,6 +1576,30 @@ perf_event_groups_less(struct perf_event *left, struct perf_event *right)
 	if (left->cpu > right->cpu)
 		return false;
 
+#ifdef CONFIG_CGROUP_PERF
+	if (left->cgrp != right->cgrp) {
+		if (!left->cgrp || !left->cgrp->css.cgroup) {
+			/*
+			 * Left has no cgroup but right does, no cgroups come
+			 * first.
+			 */
+			return true;
+		}
+		if (!right->cgrp || right->cgrp->css.cgroup) {
+			/*
+			 * Right has no cgroup but left does, no cgroups come
+			 * first.
+			 */
+			return false;
+		}
+		/* Two dissimilar cgroups, order by id. */
+		if (left->cgrp->css.cgroup->id < right->cgrp->css.cgroup->id)
+			return true;
+
+		return false;
+	}
+#endif
+
 	if (left->group_index < right->group_index)
 		return true;
 	if (left->group_index > right->group_index)
@@ -1655,25 +1679,48 @@ del_event_from_groups(struct perf_event *event, struct perf_event_context *ctx)
 }
 
 /*
- * Get the leftmost event in the @cpu subtree.
+ * Get the leftmost event in the cpu/cgroup subtree.
  */
 static struct perf_event *
-perf_event_groups_first(struct perf_event_groups *groups, int cpu)
+perf_event_groups_first(struct perf_event_groups *groups, int cpu,
+			struct cgroup *cgrp)
 {
 	struct perf_event *node_event = NULL, *match = NULL;
 	struct rb_node *node = groups->tree.rb_node;
+#ifdef CONFIG_CGROUP_PERF
+	int node_cgrp_id, cgrp_id = 0;
+
+	if (cgrp)
+		cgrp_id = cgrp->id;
+#endif
 
 	while (node) {
 		node_event = container_of(node, struct perf_event, group_node);
 
 		if (cpu < node_event->cpu) {
 			node = node->rb_left;
-		} else if (cpu > node_event->cpu) {
+			continue;
+		}
+		if (cpu > node_event->cpu) {
 			node = node->rb_right;
-		} else {
-			match = node_event;
+			continue;
+		}
+#ifdef CONFIG_CGROUP_PERF
+		node_cgrp_id = 0;
+		if (node_event->cgrp && node_event->cgrp->css.cgroup)
+			node_cgrp_id = node_event->cgrp->css.cgroup->id;
+
+		if (cgrp_id < node_cgrp_id) {
 			node = node->rb_left;
+			continue;
+		}
+		if (cgrp_id > node_cgrp_id) {
+			node = node->rb_right;
+			continue;
 		}
+#endif
+		match = node_event;
+		node = node->rb_left;
 	}
 
 	return match;
@@ -1686,12 +1733,26 @@ static struct perf_event *
 perf_event_groups_next(struct perf_event *event)
 {
 	struct perf_event *next;
+#ifdef CONFIG_CGROUP_PERF
+	int curr_cgrp_id = 0;
+	int next_cgrp_id = 0;
+#endif
 
 	next = rb_entry_safe(rb_next(&event->group_node), typeof(*event), group_node);
-	if (next && next->cpu == event->cpu)
-		return next;
+	if (next == NULL || next->cpu != event->cpu)
+		return NULL;
 
-	return NULL;
+#ifdef CONFIG_CGROUP_PERF
+	if (event->cgrp && event->cgrp->css.cgroup)
+		curr_cgrp_id = event->cgrp->css.cgroup->id;
+
+	if (next->cgrp && next->cgrp->css.cgroup)
+		next_cgrp_id = next->cgrp->css.cgroup->id;
+
+	if (curr_cgrp_id != next_cgrp_id)
+		return NULL;
+#endif
+	return next;
 }
 
 /*
@@ -3468,6 +3529,9 @@ static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
 				int (*func)(struct perf_event *, void *),
 				void *data)
 {
+#ifdef CONFIG_CGROUP_PERF
+	struct cgroup_subsys_state *css = NULL;
+#endif
 	/* Space for per CPU and/or any CPU event iterators. */
 	struct perf_event *itrs[2];
 	struct min_heap event_heap;
@@ -3483,6 +3547,11 @@ static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
 		};
 
 		lockdep_assert_held(&cpuctx->ctx.lock);
+
+#ifdef CONFIG_CGROUP_PERF
+		if (cpuctx->cgrp)
+			css = &cpuctx->cgrp->css;
+#endif
 	} else {
 		event_heap = (struct min_heap){
 			.data = itrs,
@@ -3490,11 +3559,19 @@ static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
 			.cap = ARRAY_SIZE(itrs),
 		};
 		/* Events not within a CPU context may be on any CPU. */
-		__heap_add(&event_heap, perf_event_groups_first(groups, -1));
+		__heap_add(&event_heap, perf_event_groups_first(groups, -1,
+									NULL));
 	}
 	evt = event_heap.data;
 
-	__heap_add(&event_heap, perf_event_groups_first(groups, cpu));
+	__heap_add(&event_heap, perf_event_groups_first(groups, cpu, NULL));
+
+#ifdef CONFIG_CGROUP_PERF
+	for (; css; css = css->parent) {
+		__heap_add(&event_heap, perf_event_groups_first(groups, cpu,
+								css->cgroup));
+	}
+#endif
 
 	min_heapify_all(&event_heap, &perf_min_heap);
 
-- 
2.24.0.393.g34dc348eaf-goog

