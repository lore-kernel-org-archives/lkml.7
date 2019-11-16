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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7536AC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 01:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3889920857
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 01:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GFMYUgHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfKPBTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 20:19:12 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:50182 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbfKPBTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 20:19:07 -0500
Received: by mail-pg1-f202.google.com with SMTP id u197so8548807pgc.17
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 17:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ovrgWdUij2f9Ew9nsQzX6AXQ3DrPOJ3uwEeNdAUHTO8=;
        b=GFMYUgHbfG6zMsmoqVUH0ZJCM5RXtX41nfFgA4H51a/VjNTquwTFAQdFmErrqqglpS
         xKvcPjHNOAFW0sBjr5pVxxAowq7t8roTgHXE7hG4UILpWQc3JHOeIghpa1u40OLMgn+H
         GE53jdK2/urAh5wJfCvCCnkC953LIPh+umzhJ7nNagK8lgzMEaHnICZjtFoQ+CHK53ep
         cURumDomh7Wc6WwR4JuKpLx055HDR52WuYZwt2yvYBqtG7SWMFBME67NGfvKVvTbe7Gf
         YWdYACOoX3YmQQRkla8vDKcYPbfo7QWPLYDqWIk7eKd+9HYcOUtSeNN8L/hX/QAsoiKn
         6AgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ovrgWdUij2f9Ew9nsQzX6AXQ3DrPOJ3uwEeNdAUHTO8=;
        b=tpoX3JUC1KceisiVAh4n0FnoAz7rWAdWiqH3s07cC//kkFJ1QS+y5eI45VIBLfi+ZG
         SzqZJHR7ociEtZXW3NAuGkgdgvItK/dGW1gEo2HcHMY7ydka0a/L3bWU7WYRjitq3A+/
         0xHX2l0iMdyBvk2wM5L3I3v+nKSY6jnEFws7m9UE7g4byRi+7x9+Hb+Dgx/VSaG/WAj1
         KhQK50K9muRdA4rDXbWt6KKMeNnSUYsMOf+IPUjb1UQ8lh+tdz76SfgVCNKnqykkdkKi
         wvUz5RHJYCwsldi1BZj/VopsIOtDF2ue6ldiCIBC6zLtWl0EZA0UV5zgiwIiW0PmPlDZ
         d+Ig==
X-Gm-Message-State: APjAAAV4bv40S/ADOoB0OYEPxtIkeu1AU9knCGydLA0GVd+m6/5CI3dg
        jz7RPt/MTC9rHa0Nztk58eBBjOSPgjFR
X-Google-Smtp-Source: APXvYqwDOffYMY50B+ZFd+ypnLSP3EI2XmReiIMKDKOyJ0aJSpiUpAaHkyv1mjFgYQeIhUOXpHlceHsQeCZL
X-Received: by 2002:a63:a5b:: with SMTP id z27mr14784040pgk.416.1573867146460;
 Fri, 15 Nov 2019 17:19:06 -0800 (PST)
Date:   Fri, 15 Nov 2019 17:18:41 -0800
In-Reply-To: <20191116011845.177150-1-irogers@google.com>
Message-Id: <20191116011845.177150-7-irogers@google.com>
Mime-Version: 1.0
References: <20191114003042.85252-1-irogers@google.com> <20191116011845.177150-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v4 06/10] perf/cgroup: Order events in RB tree by cgroup id
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
index 8817c645bef9..f26871ef352a 100644
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
@@ -3453,6 +3514,9 @@ static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
 				int (*func)(struct perf_event *, void *),
 				void *data)
 {
+#ifdef CONFIG_CGROUP_PERF
+	struct cgroup_subsys_state *css = NULL;
+#endif
 	/* Space for per CPU and/or any CPU event iterators. */
 	struct perf_event *itrs[2];
 	struct min_max_heap event_heap;
@@ -3468,6 +3532,11 @@ static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
 		};
 
 		lockdep_assert_held(&cpuctx->ctx.lock);
+
+#ifdef CONFIG_CGROUP_PERF
+		if (cpuctx->cgrp)
+			css = &cpuctx->cgrp->css;
+#endif
 	} else {
 		event_heap = (struct min_max_heap){
 			.data = itrs,
@@ -3475,11 +3544,19 @@ static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
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
 
 	min_max_heapify_all(&event_heap, &perf_min_heap);
 
-- 
2.24.0.432.g9d3f5f5b63-goog

