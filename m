Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709B6C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD6D2189F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hC/0ro91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbfGXWiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 18:38:46 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:49598 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387405AbfGXWip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 18:38:45 -0400
Received: by mail-qk1-f202.google.com with SMTP id l14so40589524qke.16
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 15:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fUJbGU5QPMafOX3867/HsByeVO2WR9GkgTs8e2nWv30=;
        b=hC/0ro91VyiXNczXgXmQa9XUc9s4W/GS4B6+77r0acrvhHM9SJliV6a0590jm+d1Zm
         vxMvnG56c+K/iDnuMAXrjaNEQaA10kN9AypF4n4BFfIAlDDH0Ggl1YvvQtXZPvvoSUvk
         2RRloBy3A9IMhMcC71t8/gAZAZJH9ffR0hXmvbrdzWtADGnsvePQV2MvH5or8GPrR+M/
         lcWM/g3ltZY7yqUGUumqbpH+wy0yHwXbFGrN5lJSUDzXj70tMP1FMDfqK5d6KHlAygFL
         l5jSW2d0VePJYbVmeuQp8r7ZI4ReKxDVjSAeJOLvoQSQ6s81JgmV7bC6a82ov3AsZo3+
         NSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fUJbGU5QPMafOX3867/HsByeVO2WR9GkgTs8e2nWv30=;
        b=IL2RaIrTvsrX2PhUFWrTMkUiiWuNgMktR4vbl+8yjDSe+gNE+cnMJyNO/EIZuuZNQT
         HKVXf76/hWK+/m4AVpSQYDUlbvABbWUXyDWlQ+s2IN7SVx58ulqivR6lvPIyiswfRpfK
         qZHfvDm5ee3v8oOUhWV5nw6JZ4t5fApZ1T+M5RfoRy41PNLZqAMc2G2IifZOWyyjjZl7
         8wn+uvwBJZfLIBY3jTlHEWfuhgesC5n+nqUe8BwOF4hAj3mg5hLTLsZzVgJ9M2ocN3YY
         /slhkqVw8Fyzi8EDa0VilAftDNf8M2vCokv/C+ywFl+wUkB1mrM+ym5bfviBPzLuXzBd
         AbeQ==
X-Gm-Message-State: APjAAAVG6775qrMY5FAJGvvue7gGqGJfKnfV3QYymERmvw1mMQtdswzH
        6a0C77IAy1bfzRiwYybx7Z5ptpia+P3w
X-Google-Smtp-Source: APXvYqyQ5oIG7GUyCgnvHrqmXfdGVeZvpA07FvwA1lf7jTwo8FPm1BKCKnBCtSD0b0fNzX4WIBNE92eHfOXz
X-Received: by 2002:a37:80c1:: with SMTP id b184mr34730774qkd.381.1564007924379;
 Wed, 24 Jul 2019 15:38:44 -0700 (PDT)
Date:   Wed, 24 Jul 2019 15:37:42 -0700
In-Reply-To: <20190724223746.153620-1-irogers@google.com>
Message-Id: <20190724223746.153620-4-irogers@google.com>
Mime-Version: 1.0
References: <20190702065955.165738-1-irogers@google.com> <20190724223746.153620-1-irogers@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v2 3/7] perf: order iterators for visit_groups_merge into a min-heap
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The groups rbtree holding perf events, either for a CPU or a task, needs
to have multiple iterators that visit events in group_index (insertion)
order. Rather than linearly searching the iterators, use a min-heap to go
from a O(#iterators) search to a O(log2(#iterators)) insert cost per event
visited.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 kernel/events/core.c | 131 +++++++++++++++++++++++++++++++++----------
 1 file changed, 102 insertions(+), 29 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 47df9935de0b..4d70df0415b9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3322,6 +3322,78 @@ static void cpu_ctx_sched_out(struct perf_cpu_context *cpuctx,
 	ctx_sched_out(&cpuctx->ctx, cpuctx, event_type);
 }
 
+/*
+ * Data structure used to hold a min-heap, ordered by group_index, of a fixed
+ * maximum size.
+ */
+struct perf_event_heap {
+	struct perf_event **storage;
+	int num_elements;
+	int max_elements;
+};
+
+static void min_heap_swap(struct perf_event_heap *heap,
+			  int pos1, int pos2)
+{
+	struct perf_event *tmp = heap->storage[pos1];
+
+	heap->storage[pos1] = heap->storage[pos2];
+	heap->storage[pos2] = tmp;
+}
+
+/* Sift the perf_event at pos down the heap. */
+static void min_heapify(struct perf_event_heap *heap, int pos)
+{
+	int left_child, right_child;
+
+	while (pos < heap->num_elements / 2) {
+		left_child = pos * 2;
+		right_child = pos * 2 + 1;
+		if (heap->storage[pos]->group_index >
+		    heap->storage[left_child]->group_index) {
+			min_heap_swap(heap, pos, left_child);
+			pos = left_child;
+		} else if (heap->storage[pos]->group_index >
+			   heap->storage[right_child]->group_index) {
+			min_heap_swap(heap, pos, right_child);
+			pos = right_child;
+		} else {
+			break;
+		}
+	}
+}
+
+/* Floyd's approach to heapification that is O(n). */
+static void min_heapify_all(struct perf_event_heap *heap)
+{
+	int i;
+
+	for (i = heap->num_elements / 2; i > 0; i--)
+		min_heapify(heap, i);
+}
+
+/* Remove minimum element from the heap. */
+static void min_heap_pop(struct perf_event_heap *heap)
+{
+	WARN_ONCE(heap->num_elements <= 0, "Popping an empty heap");
+	heap->num_elements--;
+	heap->storage[0] = heap->storage[heap->num_elements];
+	min_heapify(heap, 0);
+}
+
+/* Remove the minimum element and then push the given event. */
+static void min_heap_pop_push(struct perf_event_heap *heap,
+			      struct perf_event *event)
+{
+	WARN_ONCE(heap->num_elements <= 0, "Popping an empty heap");
+	if (event == NULL) {
+		min_heap_pop(heap);
+	} else {
+		heap->storage[0] = event;
+		min_heapify(heap, 0);
+	}
+}
+
 static int visit_groups_merge(struct perf_event_context *ctx,
 			      struct perf_cpu_context *cpuctx,
 			      struct perf_event_groups *groups,
@@ -3331,8 +3403,6 @@ static int visit_groups_merge(struct perf_event_context *ctx,
 					  int *),
 			      int *data)
 {
-	/* The number of iterators in use. */
-	int num_itrs;
 	/*
 	 * A set of iterators, the iterator for the visit is chosen by the
 	 * group_index. The size of the array is sized such that there is space:
@@ -3346,22 +3416,28 @@ static int visit_groups_merge(struct perf_event_context *ctx,
 	 *     only limited by MAX_PATH.
 	 */
 	struct perf_event *itrs[IS_ENABLED(CONFIG_CGROUP_PERF) ? 17 : 2];
-	/* A reference to the selected iterator. */
-	struct perf_event **evt;
-	int ret, i, cpu = smp_processor_id();
+	struct perf_event_heap heap = {
+		.storage = itrs,
+		.num_elements = 0,
+		.max_elements = ARRAYSIZE(itrs)
+	};
+	int ret, cpu = smp_processor_id();
 
-	itrs[0] = perf_event_groups_first(groups, cpu, NULL);
+	heap.storage[0] = perf_event_groups_first(groups, cpu, NULL);
+	if (heap.storage[0])
+		heap.num_elements++;
 
 	if (ctx != &cpuctx->ctx) {
 		/*
 		 * A task context only ever has an iterator for CPU or any CPU
 		 * events.
 		 */
-		itrs[1] = perf_event_groups_first(groups, -1, NULL);
-		num_itrs = 2;
+		heap.storage[heap.num_elements] =
+				perf_event_groups_first(groups, -1, NULL);
+		if (heap.storage[heap.num_elements])
+			heap.num_elements++;
 	} else {
 		/* Per-CPU events are by definition not on any CPU. */
-		num_itrs = 1;
 #ifdef CONFIG_CGROUP_PERF
 		/*
 		 * For itrs[1..MAX] add an iterator for each cgroup parent that
@@ -3371,36 +3447,33 @@ static int visit_groups_merge(struct perf_event_context *ctx,
 			struct cgroup_subsys_state *css;
 
 			for (css = &cpuctx->cgrp->css; css; css = css->parent) {
-				itrs[num_itrs] = perf_event_groups_first(groups,
+				heap.storage[heap.num_elements] =
+						perf_event_groups_first(groups,
 								   cpu,
 								   css->cgroup);
-				if (itrs[num_itrs] &&
-				    WARN_ONCE(++num_itrs == ARRAY_SIZE(iters)
-				     "Insufficient iterators for cgroup depth"))
-					break;
+				if (heap.storage[heap.num_elements]) {
+					heap.num_elements++;
+					if (heap.num_elements ==
+					    heap.max_elements) {
+						WARN_ONCE(
+				     max_cgroups_with_events_depth,
+				     "Insufficient iterators for cgroup depth");
+						break;
+					}
+				}
 			}
 		}
 #endif
 	}
+	min_heapify_all(&heap);
 
-	while (true) {
-		/* Find lowest group_index event. */
-		evt = NULL;
-		for (i = 0; i < num_itrs; ++i) {
-			if (itrs[i] == NULL)
-				continue;
-			if (evt == NULL ||
-			    itrs[i]->group_index < (*evt)->group_index)
-				evt = &itrs[i];
-		}
-		if (evt == NULL)
-			break;
-
-		ret = func(ctx, cpuctx, *evt, data);
+	while (heap.num_elements > 0) {
+		ret = func(ctx, cpuctx, heap.storage[0], data);
 		if (ret)
 			return ret;
 
-		*evt = perf_event_groups_next(*evt);
+		min_heap_pop_push(&heap,
+				  perf_event_groups_next(heap.storage[0]));
 	}
 
 	return 0;
-- 
2.22.0.709.g102302147b-goog

