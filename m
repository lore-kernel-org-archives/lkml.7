Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A1FC5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9032121721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eiKoV90U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfGBHAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:00:41 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:36614 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbfGBHAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:00:38 -0400
Received: by mail-qt1-f201.google.com with SMTP id q26so15578320qtr.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 00:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pZKXEfyC3/D5M+q6RSbb10h/7szhfL3ngvsyGClR+a0=;
        b=eiKoV90UVKXY/bB03YHu5pLYn8of54tTfpaI6K6eYWYRU55qzU81wAewmnE1iBjOZj
         534uka2ZJBqhCjDIXX0/j3k1JSHIR3dqExHZGQ1Xvevj9qDYvt49KOjLAJ/XsP3TJwH9
         PiJLeH6F1zvS6W49986wxJm+/WPERuz7GPfo3moSaBlE9jDVvHBhh+p/80Shcpnc8EJm
         NC3svB/jDyvbSP6qjxOSrf8aSXcOQoF86WIAXgA8Q7kB7ce29Ue5sZY6FVu+KiFlIJRU
         dbF3mNxSsfrwbsf5Oxj47qc+IR1yJ+TVXmQVWHNbghcRa6yWEIFfA2AyBFigtPGLmxbH
         ezag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pZKXEfyC3/D5M+q6RSbb10h/7szhfL3ngvsyGClR+a0=;
        b=RpGaZBslNERL+nr0mRvS0r0vWdKwIGkmVyTtPPSnQRB+cxh+lrAAHkObuxEFhUi7Sc
         4jCzTECDQkVZiUlkyvaqY6MWIPWg6GaI2naL9h5EBMjoQGAV5nIjLtGKR5tWImc9xdZd
         FKcd39KxspRlsQFbiSG/7QWxE8oF9DD7T+4m0lKDylS/+PPzWM6Vw/grfz3QaQ11x4Wx
         TiP79LABI/aiwBwBYVr7s/4d1iYMKnsDpwDc0AmmLSK8Pqgd1uyKBhZq5mEtctaxK8iX
         gp5r8DjC2G2BJrks9NpIe2y6MI5HK3A+Ac+hrAEe74d7rga+rcj4vz5EdGeKtWPcGI74
         +XKg==
X-Gm-Message-State: APjAAAVyhlhPtCYNujtL6ns8dcgQWTjgtasaK/rZ69Atf3xoxFJrHe7u
        z2l7wz7inEuM+2scxcvmlK7OMpMOMdSA
X-Google-Smtp-Source: APXvYqy+LRDVkqm7GI8EDjg67BTzxi/07jx0DMHwvUODaIDNjufhsfK7fRdzyiYV5/7uQcqI36b6Sbr1Scv1
X-Received: by 2002:ac8:3636:: with SMTP id m51mr23808085qtb.102.1562050837579;
 Tue, 02 Jul 2019 00:00:37 -0700 (PDT)
Date:   Mon,  1 Jul 2019 23:59:55 -0700
In-Reply-To: <20190702065955.165738-1-irogers@google.com>
Message-Id: <20190702065955.165738-8-irogers@google.com>
Mime-Version: 1.0
References: <20190702065955.165738-1-irogers@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH 7/7] perf: rename visit_groups_merge to ctx_groups_sched_in
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

The visit_groups_merge function no longer takes a function pointer,
change the name to be similar to other sched_in functions.
Follow Kan Liang's <kan.liang@linux.intel.com> and remove the single
caller flexible_sched_in and pinned_sched_in, moving functionality to
caller.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/linux/perf_event.h |  4 +-
 kernel/events/core.c       | 77 ++++++++++++++++----------------------
 2 files changed, 35 insertions(+), 46 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 86fb379296cb..1dd0250d72bf 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -802,8 +802,8 @@ struct perf_cpu_context {
 #ifdef CONFIG_CGROUP_PERF
 	struct perf_cgroup		*cgrp;
 	struct list_head		cgrp_cpuctx_entry;
-	struct perf_event		**visit_groups_merge_iterator_storage;
-	int			       visit_groups_merge_iterator_storage_size;
+	struct perf_event		**ctx_groups_sched_in_iterator_storage;
+	int			      ctx_groups_sched_in_iterator_storage_size;
 #endif
 
 	struct list_head		sched_cb_entry;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index a66477ee196a..e714c2f9ea0d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2642,22 +2642,22 @@ static int  __perf_install_in_context(void *info)
 					event->cgrp->css.cgroup);
 
 		/*
-		 * Ensure space for visit_groups_merge iterator storage. With
+		 * Ensure space for ctx_groups_sched_in iterator storage. With
 		 * cgroup profiling we may have an event at each depth plus
 		 * system wide events.
 		 */
 		max_iterators = perf_event_cgroup_depth(event) + 1;
 		if (max_iterators >
-		    cpuctx->visit_groups_merge_iterator_storage_size) {
+		    cpuctx->ctx_groups_sched_in_iterator_storage_size) {
 			struct perf_event **storage =
-			   krealloc(cpuctx->visit_groups_merge_iterator_storage,
+			  krealloc(cpuctx->ctx_groups_sched_in_iterator_storage,
 				    sizeof(struct perf_event *) * max_iterators,
 				    GFP_KERNEL);
 			if (storage) {
-				cpuctx->visit_groups_merge_iterator_storage
-						= storage;
-				cpuctx->visit_groups_merge_iterator_storage_size
-						= max_iterators;
+				cpuctx->ctx_groups_sched_in_iterator_storage
+				    = storage;
+			       cpuctx->ctx_groups_sched_in_iterator_storage_size
+				    = max_iterators;
 			} else {
 				WARN_ONCE(1, "Unable to increase iterator "
 					"storage for perf events with cgroups");
@@ -3466,32 +3466,33 @@ static int flexible_sched_in(struct perf_event_context *ctx,
  * Without cgroups, with a task context, there may be per-CPU and any
  * CPU events.
  */
-#define MIN_VISIT_GROUP_MERGE_ITERATORS 2
+#define MIN_CTX_GROUPS_SCHED_IN_ITERATORS 2
 
-static int visit_groups_merge(struct perf_event_context *ctx,
-			      struct perf_cpu_context *cpuctx,
-			      bool is_pinned,
-			      int *data)
+static int ctx_groups_sched_in(struct perf_event_context *ctx,
+			       struct perf_cpu_context *cpuctx,
+			       bool is_pinned,
+			       int *data)
 {
 	/*
 	 * A set of iterators, the iterator for the visit is chosen by the
 	 * group_index.
 	 */
 #ifndef CONFIG_CGROUP_PERF
-	struct perf_event *itrs[MIN_VISIT_GROUP_MERGE_ITERATORS];
+	struct perf_event *itrs[MIN_CTX_GROUPS_SCHED_IN_ITERATORS];
 	struct perf_event_heap heap = {
 		.storage = itrs,
 		.num_elements = 0,
-		.max_elements = MIN_VISIT_GROUP_MERGE_ITERATORS
+		.max_elements = MIN_CTX_GROUPS_SCHED_IN_ITERATORS
 	};
 #else
 	/*
 	 * With cgroups usage space in the CPU context reserved for iterators.
 	 */
 	struct perf_event_heap heap = {
-		.storage = cpuctx->visit_groups_merge_iterator_storage,
+		.storage = cpuctx->ctx_groups_sched_in_iterator_storage,
 		.num_elements = 0,
-		.max_elements = cpuctx->visit_groups_merge_iterator_storage_size
+		.max_elements =
+			cpuctx->ctx_groups_sched_in_iterator_storage_size
 	};
 #endif
 	int ret, cpu = smp_processor_id();
@@ -3623,27 +3624,6 @@ static int flexible_sched_in(struct perf_event_context *ctx,
 	return 0;
 }
 
-static void
-ctx_pinned_sched_in(struct perf_event_context *ctx,
-		    struct perf_cpu_context *cpuctx)
-{
-	visit_groups_merge(ctx,
-			   cpuctx,
-			   /*is_pinned=*/true,
-			   NULL);
-}
-
-static void
-ctx_flexible_sched_in(struct perf_event_context *ctx,
-		      struct perf_cpu_context *cpuctx)
-{
-	int can_add_hw = 1;
-
-	visit_groups_merge(ctx,
-			   cpuctx,
-			   /*is_pinned=*/false,
-			   &can_add_hw);
-}
 
 static void
 ctx_sched_in(struct perf_event_context *ctx,
@@ -3681,11 +3661,20 @@ ctx_sched_in(struct perf_event_context *ctx,
 	 * in order to give them the best chance of going on.
 	 */
 	if (is_active & EVENT_PINNED)
-		ctx_pinned_sched_in(ctx, cpuctx);
+		ctx_groups_sched_in(ctx,
+				    cpuctx,
+				    /*is_pinned=*/true,
+				    NULL);
 
 	/* Then walk through the lower prio flexible groups */
-	if (is_active & EVENT_FLEXIBLE)
-		ctx_flexible_sched_in(ctx, cpuctx);
+	if (is_active & EVENT_FLEXIBLE) {
+		int can_add_hw = 1;
+
+		ctx_groups_sched_in(ctx,
+				    cpuctx,
+				    /*is_pinned=*/false,
+				    &can_add_hw);
+	}
 }
 
 static void cpu_ctx_sched_in(struct perf_cpu_context *cpuctx,
@@ -10243,12 +10232,12 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 		cpuctx->ctx.pmu = pmu;
 		cpuctx->online = cpumask_test_cpu(cpu, perf_online_mask);
 #ifdef CONFIG_CGROUP_PERF
-		cpuctx->visit_groups_merge_iterator_storage =
-				kmalloc_array(MIN_VISIT_GROUP_MERGE_ITERATORS,
+		cpuctx->ctx_groups_sched_in_iterator_storage =
+				kmalloc_array(MIN_CTX_GROUPS_SCHED_IN_ITERATORS,
 					      sizeof(struct perf_event *),
 					      GFP_KERNEL);
-		cpuctx->visit_groups_merge_iterator_storage_size =
-				MIN_VISIT_GROUP_MERGE_ITERATORS;
+		cpuctx->ctx_groups_sched_in_iterator_storage_size =
+				MIN_CTX_GROUPS_SCHED_IN_ITERATORS;
 #endif
 		__perf_mux_hrtimer_init(cpuctx, cpu);
 	}
-- 
2.22.0.410.gd8fdbe21b5-goog

