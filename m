Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0291AC06511
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4EA21721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HMX7mmhw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfGBHAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:00:31 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:47853 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfGBHA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:00:28 -0400
Received: by mail-yb1-f201.google.com with SMTP id u9so1875428ybb.14
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 00:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2Q1YcTI+MC8r+5PU+Q2EksSxPGc5Le+JqIJrlFRjmas=;
        b=HMX7mmhw2HbuXVg6Lljf9I+tOJmIBs+UUFB8QLztbwTFMLInZVa/zd5DRTCDUr9fR2
         IIXZYgCMFMBsx5bgbTHL/sSSjm9qNDyxd+LfyFRnMf7eVoTpQ1K287AMp/CpLp9nYmmR
         enhn97ggbnnVkobnwovpluDKwgOqs1U78CP0owG/CkALaBEUIlomh4VG5NW2utyZbWMb
         uPe8wetLfHrx46EzcXy+APc0V9/NOLQGeUayMlxJ0WDJAQhiaSTqrowweqYgzjPZQYTB
         pY42WRo/tV0+1ns6Hvfsiake6QfKMU/tneYW4HluK73vngWbJVjz85msHNpw4jOkE4Aq
         AyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2Q1YcTI+MC8r+5PU+Q2EksSxPGc5Le+JqIJrlFRjmas=;
        b=l0iiQLk2PqEX3sEWqSWQOm9K0eld0u1S8KMYdbXZlDCcObySKg4ACizQ82GsjKWt9r
         s1E4iBWgamqKDrqAGol1/dxuSh1JuLX0uiSATbNoOPfRfgS7IzeuVWFIr36LTSJ2nktd
         qH8kZx1br2JE/JMpVikD1zqqzDjAif9RsRSQ5WpYTtByyqNMdgaVQ/nC1SKI93yr3eq2
         OFWQ/IqD33T10WSdJeMCHE3erQBPZ/418zDdOpUWrA8ZdYeV/KM87BWWdXpXWGFcChLJ
         HTZH19oA0z8/xEywEjKHohSBplGE1bHIYMIKa5UmeuiYRM9BWINnLrWU9DFjO+VKRVu5
         eOpg==
X-Gm-Message-State: APjAAAVw3mjxVxRiq/iwBYymy/oCFmYop7lLeHgC1nV8/8CH2FF77KN/
        rbpXIfxEeCvpZUC+6JOodHNXZKAXiI75
X-Google-Smtp-Source: APXvYqwKn49bxyr1jCvTkvx9aGaKpTJclstn9kf7ejHe+Y8NFVhHCeXwUpKkH+j/1qgeyKo+Wv9nbIBX13UB
X-Received: by 2002:a81:5c0a:: with SMTP id q10mr643572ywb.474.1562050827580;
 Tue, 02 Jul 2019 00:00:27 -0700 (PDT)
Date:   Mon,  1 Jul 2019 23:59:51 -0700
In-Reply-To: <20190702065955.165738-1-irogers@google.com>
Message-Id: <20190702065955.165738-4-irogers@google.com>
Mime-Version: 1.0
References: <20190702065955.165738-1-irogers@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH 3/7] perf: order iterators for visit_groups_merge into a min-heap
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
 kernel/events/core.c | 123 +++++++++++++++++++++++++++++++++----------
 1 file changed, 95 insertions(+), 28 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9a2ad34184b8..396b5ac6dcd4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3318,6 +3318,77 @@ static void cpu_ctx_sched_out(struct perf_cpu_context *cpuctx,
 	ctx_sched_out(&cpuctx->ctx, cpuctx, event_type);
 }
 
+/* Data structure used to hold a min-heap, ordered by group_index, of a fixed
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
+	while (pos > heap->num_elements / 2) {
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
@@ -3346,29 +3417,33 @@ static int visit_groups_merge(struct perf_event_context *ctx,
 	 */
 	const int max_itrs = max(2, 1 + max_cgroups_with_events_depth);
 #endif
-	/* The number of iterators in use. */
-	int num_itrs;
 	/*
 	 * A set of iterators, the iterator for the visit is chosen by the
 	 * group_index.
 	 */
 	struct perf_event *itrs[max_itrs];
-	/* A reference to the selected iterator. */
-	struct perf_event **evt;
-	int ret, i, cpu = smp_processor_id();
+	struct perf_event_heap heap = {
+		.storage = itrs,
+		.num_elements = 0,
+		.max_elements = max_itrs
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
@@ -3378,12 +3453,14 @@ static int visit_groups_merge(struct perf_event_context *ctx,
 			struct cgroup_subsys_state *css;
 
 			for (css = &cpuctx->cgrp->css; css; css = css->parent) {
-				itrs[num_itrs] = perf_event_groups_first(groups,
+				heap.storage[heap.num_elements] =
+						perf_event_groups_first(groups,
 								   cpu,
 								   css->cgroup);
-				if (itrs[num_itrs]) {
-					num_itrs++;
-					if (num_itrs == max_itrs) {
+				if (heap.storage[heap.num_elements]) {
+					heap.num_elements++;
+					if (heap.num_elements ==
+					    heap.max_elements) {
 						WARN_ONCE(
 				     max_cgroups_with_events_depth,
 				     "Insufficient iterators for cgroup depth");
@@ -3394,25 +3471,15 @@ static int visit_groups_merge(struct perf_event_context *ctx,
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
2.22.0.410.gd8fdbe21b5-goog

