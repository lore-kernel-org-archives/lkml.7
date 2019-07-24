Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B80C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07F82189F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WGnDbAiU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbfGXWit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 18:38:49 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:51531 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728910AbfGXWis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 18:38:48 -0400
Received: by mail-pg1-f201.google.com with SMTP id n23so17431718pgf.18
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 15:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YgqBFfX2PJutsmookVM/iDQIrSwNBe6L53pTkYe2WHg=;
        b=WGnDbAiUcfO7OX58Ppyba9CU6xYAMbMfZHVb8BpR5I3wcIfb9cBkXttChOHQRANT3t
         iFxF9PX8aLhuvFF4LykADRJDHTwlHHWmug2aO5v1YypiwdGRvA7g86bhFLCfVkkmMZ0X
         k4t+catmM6m7R1ldTa3Ao6GOwUO9gUtwEHnqn7lbh7Y5FR5GNh+qxY1w6msgETnPzqxW
         6GE1JOQjQyHEPXawj0O2CCN13ZQw4J85KErfvGs7JPl+3la6ISnHt5fO14X3dr0r038q
         Wz2jUpwaQTnFN5W9SXqx0k50fDAYPoMVihwHQZ0LI3dtAsbqLbiicKbLSbPWXrBdebXC
         HyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YgqBFfX2PJutsmookVM/iDQIrSwNBe6L53pTkYe2WHg=;
        b=stpZRA/icNR307EAKgfkMjUJO7nBpRyEQ0g+wESPO9zS1clLXl5ZksN0eJogx1aC8V
         E5eygyMRTk0nziG8dtnC/Z6XdEG4vRV+pV2SY16uwO6EC5UjAcZAMr6eXHCUNkHpn5i3
         lWLX6tEmOrQRo3i0GSo7+v3FDQFAelqxyVUoNsODgEuSoMJdm0JZMj0mqyDRyb7ppurt
         NRYJack8zA5KHdc9gIe/fEgW5zHUweP2rnuxBYI/Jyo5OPjIIt6QXDO10YrCRUyNfzJK
         aXw8efHkY8kGOmq3xlZHqJBSnDcmdoJaMes0dhWshhviXGiekzhojOiqnbQpFbUgq6Kg
         fWlg==
X-Gm-Message-State: APjAAAXjDwhKwhEZJxjbBVjKlvGF+eHnYCpw9k6cKR6i/Nz1CGmGamP1
        +mo+Qgfy7NCp0M5ICK4JFLt2cBDkdW4w
X-Google-Smtp-Source: APXvYqy8n2wkYqXbG8csVc3aN/Fkqph3unJ2u3CU8zxm8oo4WNh/wBeH0nVkYLwy0W9kidqxjjwKRaYiBljN
X-Received: by 2002:a63:2a08:: with SMTP id q8mr51343916pgq.415.1564007927517;
 Wed, 24 Jul 2019 15:38:47 -0700 (PDT)
Date:   Wed, 24 Jul 2019 15:37:43 -0700
In-Reply-To: <20190724223746.153620-1-irogers@google.com>
Message-Id: <20190724223746.153620-5-irogers@google.com>
Mime-Version: 1.0
References: <20190702065955.165738-1-irogers@google.com> <20190724223746.153620-1-irogers@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v2 4/7] perf: avoid a bounded set of visit_groups_merge iterators
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

Create a per-cpu array of iterators that gets resized when cgroup events
are added. The size of the array reflects the maximum depth of cgroups,
although not all cgroups will have events monitored within them. This
approach avoids added storage cost to perf_event.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/linux/perf_event.h |  2 +
 kernel/events/core.c       | 87 +++++++++++++++++++++++++++++++-------
 2 files changed, 73 insertions(+), 16 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e8ad3c590a23..43f90cfa2c39 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -802,6 +802,8 @@ struct perf_cpu_context {
 #ifdef CONFIG_CGROUP_PERF
 	struct perf_cgroup		*cgrp;
 	struct list_head		cgrp_cpuctx_entry;
+	struct perf_event		**visit_groups_merge_iterator_storage;
+	int			       visit_groups_merge_iterator_storage_size;
 #endif
 
 	struct list_head		sched_cb_entry;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4d70df0415b9..2a2188908bed 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1709,6 +1709,20 @@ perf_event_groups_next(struct perf_event *event)
 	return next;
 }
 
+#ifdef CONFIG_CGROUP_PERF
+int perf_event_cgroup_depth(struct perf_event *event)
+{
+	struct cgroup_subsys_state *css;
+	struct perf_cgroup *cgrp = event->cgrp;
+	int depth = 0;
+
+	if (cgrp)
+		for (css = &cgrp->css; css; css = css->parent)
+			depth++;
+	return depth;
+}
+#endif
+
 /*
  * Iterate through the whole groups tree.
  */
@@ -2590,6 +2604,7 @@ static int  __perf_install_in_context(void *info)
 
 #ifdef CONFIG_CGROUP_PERF
 	if (is_cgroup_event(event)) {
+		int max_iterators;
 		/*
 		 * If the current cgroup doesn't match the event's
 		 * cgroup, we should not try to schedule it.
@@ -2597,6 +2612,30 @@ static int  __perf_install_in_context(void *info)
 		struct perf_cgroup *cgrp = perf_cgroup_from_task(current, ctx);
 		reprogram = cgroup_is_descendant(cgrp->css.cgroup,
 					event->cgrp->css.cgroup);
+
+		/*
+		 * Ensure space for visit_groups_merge iterator storage. With
+		 * cgroup profiling we may have an event at each depth plus
+		 * system wide events.
+		 */
+		max_iterators = perf_event_cgroup_depth(event) + 1;
+		if (max_iterators >
+		    cpuctx->visit_groups_merge_iterator_storage_size) {
+			struct perf_event **storage =
+			   krealloc(cpuctx->visit_groups_merge_iterator_storage,
+				    sizeof(struct perf_event *) * max_iterators,
+				    GFP_KERNEL);
+			if (storage) {
+				cpuctx->visit_groups_merge_iterator_storage
+						= storage;
+				cpuctx->visit_groups_merge_iterator_storage_size
+						= max_iterators;
+			} else {
+				WARN_ONCE(1, "Unable to increase iterator "
+					"storage for perf events with cgroups");
+				ret = -ENOMEM;
+			}
+		}
 	}
 #endif
 
@@ -3394,6 +3433,13 @@ static void min_heap_pop_push(struct perf_event_heap *heap,
 	}
 }
 
+
+/*
+ * Without cgroups, with a task context, there may be per-CPU and any
+ * CPU events.
+ */
+#define MIN_VISIT_GROUP_MERGE_ITERATORS 2
+
 static int visit_groups_merge(struct perf_event_context *ctx,
 			      struct perf_cpu_context *cpuctx,
 			      struct perf_event_groups *groups,
@@ -3405,22 +3451,25 @@ static int visit_groups_merge(struct perf_event_context *ctx,
 {
 	/*
 	 * A set of iterators, the iterator for the visit is chosen by the
-	 * group_index. The size of the array is sized such that there is space:
-	 * - for task contexts per-CPU and any-CPU events can be iterated.
-	 * - for CPU contexts:
-	 *   - without cgroups, global events can be iterated.
-	 *   - with cgroups, global events can be iterated and 16 sets of cgroup
-	 *     events. Cgroup events may monitor a cgroup at an arbitrary
-	 *     location within the cgroup hierarchy. An iterator is needed for
-	 *     each cgroup with events in the hierarchy. Potentially this is
-	 *     only limited by MAX_PATH.
-	 */
-	struct perf_event *itrs[IS_ENABLED(CONFIG_CGROUP_PERF) ? 17 : 2];
+	 * group_index.
+	 */
+#ifndef CONFIG_CGROUP_PERF
+	struct perf_event *itrs[MIN_VISIT_GROUP_MERGE_ITERATORS];
 	struct perf_event_heap heap = {
 		.storage = itrs,
 		.num_elements = 0,
-		.max_elements = ARRAYSIZE(itrs)
+		.max_elements = MIN_VISIT_GROUP_MERGE_ITERATORS
+	};
+#else
+	/*
+	 * With cgroups usage space in the CPU context reserved for iterators.
+	 */
+	struct perf_event_heap heap = {
+		.storage = cpuctx->visit_groups_merge_iterator_storage,
+		.num_elements = 0,
+		.max_elements = cpuctx->visit_groups_merge_iterator_storage_size
 	};
+#endif
 	int ret, cpu = smp_processor_id();
 
 	heap.storage[0] = perf_event_groups_first(groups, cpu, NULL);
@@ -3455,9 +3504,8 @@ static int visit_groups_merge(struct perf_event_context *ctx,
 					heap.num_elements++;
 					if (heap.num_elements ==
 					    heap.max_elements) {
-						WARN_ONCE(
-				     max_cgroups_with_events_depth,
-				     "Insufficient iterators for cgroup depth");
+						WARN_ONCE(1,
+						"per-CPU min-heap under sized");
 						break;
 					}
 				}
@@ -10167,7 +10215,14 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 		lockdep_set_class(&cpuctx->ctx.lock, &cpuctx_lock);
 		cpuctx->ctx.pmu = pmu;
 		cpuctx->online = cpumask_test_cpu(cpu, perf_online_mask);
-
+#ifdef CONFIG_CGROUP_PERF
+		cpuctx->visit_groups_merge_iterator_storage =
+				kmalloc_array(MIN_VISIT_GROUP_MERGE_ITERATORS,
+					      sizeof(struct perf_event *),
+					      GFP_KERNEL);
+		cpuctx->visit_groups_merge_iterator_storage_size =
+				MIN_VISIT_GROUP_MERGE_ITERATORS;
+#endif
 		__perf_mux_hrtimer_init(cpuctx, cpu);
 	}
 
-- 
2.22.0.709.g102302147b-goog

