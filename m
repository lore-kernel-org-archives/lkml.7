Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F337C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37CDA2146F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bjSS0ZC5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfGBHAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:00:38 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:57031 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfGBHAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:00:36 -0400
Received: by mail-vs1-f74.google.com with SMTP id t82so4727137vst.23
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 00:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ril5U3BPdTaZFLli/CaafQNfoHYAGw/Elz1ksNt0JHY=;
        b=bjSS0ZC5j0EKQ2D8wPI7z/flCDiNrUvTG7r/HnVkfJJJMM5ie9rmshh/tZIb4SgIc5
         3owzb0PHCtxwSZmWYq9V+CNrkDKmJ/V8JhxYXfEk6wOdU0e90VSvmSgIinS/BNPCMoQA
         2XiGAB1puMqHnojyLyRdBzbjTVqVqEq4mh6MIReHPo1gUq+nL7o2Nd5yWvvVsdZi5RE7
         mqEvQHnVHnOGKkArTb54U8Mjx5du2kPGAEejUONZDRvrW4ksILrevAOoKGqvXTLnTwZy
         5gQN+P2aZNvdndGC8hYOv3KdvodBb5WNthVVXPtCGt0B2swtd/mStQL1YVmj8a2cK2Ap
         +srg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ril5U3BPdTaZFLli/CaafQNfoHYAGw/Elz1ksNt0JHY=;
        b=CiVSVb83GKqdhdgJ9s3hvAxED8w0CUpbLjKuItP8dpOypXSvnry/ZWkrD7BxIlAIDF
         9lWu+kPd4VufSvT7AYivlDxte6143fU6jsWGf1GqqmrLYf7XYUpNlq2BUt1fFv2gbEjV
         sIcs7fQQ8iSX5uYlJRDKzTWuXyippOuJtp9gQjbRSCRGBPiGEnJ4DLapl1cY/yLi7GgQ
         60LfXmf0y6ZTiWW/29TNpWUqYmbQ23yUeTpqZou3XeWXrWbTKHBKNeM886WAsCIXzH1l
         k7kJCZqkyJNT+4zWx4NWAsXJavwbLWfDh9nOuWlj1e4eiGfOR9IobZuUtfwGQCK8Fj7G
         uhnw==
X-Gm-Message-State: APjAAAUy5+Zv8jqHPVYiZiApU9RjEilY0eSVKSCkb7sfhg6qnwexeqtF
        b0N1+Gi2H4D5ryzVUjRZ4rxxne/vijz5
X-Google-Smtp-Source: APXvYqwgQwa8PcXgGy4s3L2l3XOl+5PkJq1oCUgGzxHFlKsG4w31TqJddYWjhL9p1yJ0/NwcTE/Lx3mA6ogl
X-Received: by 2002:ac5:c5a8:: with SMTP id f8mr2872336vkl.80.1562050835040;
 Tue, 02 Jul 2019 00:00:35 -0700 (PDT)
Date:   Mon,  1 Jul 2019 23:59:54 -0700
In-Reply-To: <20190702065955.165738-1-irogers@google.com>
Message-Id: <20190702065955.165738-7-irogers@google.com>
Mime-Version: 1.0
References: <20190702065955.165738-1-irogers@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH 6/7] perf: avoid double checking CPU and cgroup
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

When ctx_groups_sched_in iterates the CPU and cgroup of events is known
to match the current task. Avoid double checking this with
event_filter_match by passing in an additional argument.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 kernel/events/core.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7608bd562dac..a66477ee196a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2079,10 +2079,12 @@ static inline int pmu_filter_match(struct perf_event *event)
 }
 
 static inline int
-event_filter_match(struct perf_event *event)
+event_filter_match(struct perf_event *event, bool check_cgroup_and_cpu)
 {
-	return (event->cpu == -1 || event->cpu == smp_processor_id()) &&
-	       perf_cgroup_match(event) && pmu_filter_match(event);
+	return (!check_cgroup_and_cpu ||
+		((event->cpu == -1 || event->cpu == smp_processor_id()) &&
+		 perf_cgroup_match(event))) &&
+			pmu_filter_match(event);
 }
 
 static void
@@ -2797,7 +2799,7 @@ static void __perf_event_enable(struct perf_event *event,
 	if (!ctx->is_active)
 		return;
 
-	if (!event_filter_match(event)) {
+	if (!event_filter_match(event, /*check_cpu_and_cgroup=*/true)) {
 		ctx_sched_in(ctx, cpuctx, EVENT_TIME, current);
 		return;
 	}
@@ -3573,7 +3575,10 @@ static int pinned_sched_in(struct perf_event_context *ctx,
 	if (event->state <= PERF_EVENT_STATE_OFF)
 		return 0;
 
-	if (!event_filter_match(event))
+	/* The caller already checked the CPU and cgroup before calling
+	 * pinned_sched_in.
+	 */
+	if (!event_filter_match(event, /*check_cpu_and_cgroup=*/false))
 		return 0;
 
 	if (group_can_go_on(event, cpuctx, 1)) {
@@ -3599,7 +3604,10 @@ static int flexible_sched_in(struct perf_event_context *ctx,
 	if (event->state <= PERF_EVENT_STATE_OFF)
 		return 0;
 
-	if (!event_filter_match(event))
+	/* The caller already checked the CPU and cgroup before calling
+	 * felxible_sched_in.
+	 */
+	if (!event_filter_match(event, /*check_cpu_and_cgroup=*/false))
 		return 0;
 
 	if (group_can_go_on(event, cpuctx, *can_add_hw)) {
@@ -3899,7 +3907,7 @@ static void perf_adjust_freq_unthr_context(struct perf_event_context *ctx,
 		if (event->state != PERF_EVENT_STATE_ACTIVE)
 			continue;
 
-		if (!event_filter_match(event))
+		if (!event_filter_match(event, /*check_cpu_and_cgroup=*/true))
 			continue;
 
 		perf_pmu_disable(event->pmu);
@@ -6929,7 +6937,8 @@ perf_iterate_ctx(struct perf_event_context *ctx,
 		if (!all) {
 			if (event->state < PERF_EVENT_STATE_INACTIVE)
 				continue;
-			if (!event_filter_match(event))
+			if (!event_filter_match(event,
+						/*check_cpu_and_cgroup=*/true))
 				continue;
 		}
 
@@ -6953,7 +6962,7 @@ static void perf_iterate_sb_cpu(perf_iterate_f output, void *data)
 
 		if (event->state < PERF_EVENT_STATE_INACTIVE)
 			continue;
-		if (!event_filter_match(event))
+		if (!event_filter_match(event, /*check_cpu_and_cgroup=*/true))
 			continue;
 		output(event, data);
 	}
-- 
2.22.0.410.gd8fdbe21b5-goog

