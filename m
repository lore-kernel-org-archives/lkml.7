Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E4AC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03D62189F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ap9NTHIy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388467AbfGXWi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 18:38:56 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:49070 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388289AbfGXWiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 18:38:55 -0400
Received: by mail-pf1-f202.google.com with SMTP id u21so29487819pfn.15
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 15:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2SdC1sFGHXZXKOnD7ADoHYWBNuQh8LAr/1lmv6ATt9U=;
        b=Ap9NTHIyS2UpGIAtd7VH+Grk+GckSUIpuTaCV8ZMueH/2PKp/s3R+Rn194PD+yjS6T
         Rl5ipqJecVVITCS9thTh75c7TQiCI4T7wiK/FEvQhLkf+SI9o/Gg4jLpMw7g0PRPz9tF
         xFd8LltSbbHg4aTOdQvT1wfx6wRoF3dljasnwbX/+HtiGS8dXavnDiiBzOKuGNvRkLS4
         7kHOzaSt9b5jsqYkpzeg7SBw3fklTSNuLSbqHmmH8+XCeP7L84+y5YIeBvY75OrUWpBk
         rY4OzjeNF6jtoZ0uQAYX6nUrfcVl2YqOgPj3Okq4JemRAHhFdBu8nmSE3iiO4OG9hC+g
         WBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2SdC1sFGHXZXKOnD7ADoHYWBNuQh8LAr/1lmv6ATt9U=;
        b=mtYo7XjmhdK+HoobXHgfNI/rfr2U3EhRgMATlcpfABqFWC+9y6jMayb+/JTGGd2+Tw
         wSGpKgykdr11yxT2FmhkEHLa4QbKGIDtkfUJo6tH1V23mhVMhhf8csfqSEXvPQZn8L0e
         mYeQ7m8FNkYzZCXKyfspTOxo6xSMgHRgp/vgIWsk/tvoDHm7qctGT3671gTzHQTv+Sx9
         dEN1EfpwqC8iCKZjHgRorwPjsd0ZeBW1wqMT+GGHb8pNADQ2rjI+cYlSJWbn1/njv8aa
         sAkwgSqQABmPqK2Mj+fSDnjLEmcs5GtlyD5P2bZb2RNp+YdVq2MLCQYSIRlST9SRJQNu
         8khA==
X-Gm-Message-State: APjAAAXi09NmAWVE3/8X2SSJv/Q8xdKzb1fVT3+rbTE4ao06NDb+FyHC
        oNxzy4kiOk0f+DSRUpHWQ7CyinuOy3uC
X-Google-Smtp-Source: APXvYqz9Vu+IqwU95+96GN3//B+OjGoyEv4m/RH3LiAYvVaPhfGNdtZIpw0zHUTpEP7KhZzjE6WXamCmAoJ3
X-Received: by 2002:a63:f048:: with SMTP id s8mr55212472pgj.26.1564007934231;
 Wed, 24 Jul 2019 15:38:54 -0700 (PDT)
Date:   Wed, 24 Jul 2019 15:37:45 -0700
In-Reply-To: <20190724223746.153620-1-irogers@google.com>
Message-Id: <20190724223746.153620-7-irogers@google.com>
Mime-Version: 1.0
References: <20190702065955.165738-1-irogers@google.com> <20190724223746.153620-1-irogers@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v2 6/7] perf: avoid double checking CPU and cgroup
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
index c8b9c8611533..fb1027387e8e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2077,10 +2077,12 @@ static inline int pmu_filter_match(struct perf_event *event)
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
@@ -2801,7 +2803,7 @@ static void __perf_event_enable(struct perf_event *event,
 	if (!ctx->is_active)
 		return;
 
-	if (!event_filter_match(event)) {
+	if (!event_filter_match(event, /*check_cpu_and_cgroup=*/true)) {
 		ctx_sched_in(ctx, cpuctx, EVENT_TIME, current);
 		return;
 	}
@@ -3578,7 +3580,10 @@ static int pinned_sched_in(struct perf_event_context *ctx,
 	if (event->state <= PERF_EVENT_STATE_OFF)
 		return 0;
 
-	if (!event_filter_match(event))
+	/* The caller already checked the CPU and cgroup before calling
+	 * pinned_sched_in.
+	 */
+	if (!event_filter_match(event, /*check_cpu_and_cgroup=*/false))
 		return 0;
 
 	if (group_can_go_on(event, cpuctx, 1)) {
@@ -3604,7 +3609,10 @@ static int flexible_sched_in(struct perf_event_context *ctx,
 	if (event->state <= PERF_EVENT_STATE_OFF)
 		return 0;
 
-	if (!event_filter_match(event))
+	/* The caller already checked the CPU and cgroup before calling
+	 * felxible_sched_in.
+	 */
+	if (!event_filter_match(event, /*check_cpu_and_cgroup=*/false))
 		return 0;
 
 	if (group_can_go_on(event, cpuctx, *can_add_hw)) {
@@ -3904,7 +3912,7 @@ static void perf_adjust_freq_unthr_context(struct perf_event_context *ctx,
 		if (event->state != PERF_EVENT_STATE_ACTIVE)
 			continue;
 
-		if (!event_filter_match(event))
+		if (!event_filter_match(event, /*check_cpu_and_cgroup=*/true))
 			continue;
 
 		perf_pmu_disable(event->pmu);
@@ -6952,7 +6960,8 @@ perf_iterate_ctx(struct perf_event_context *ctx,
 		if (!all) {
 			if (event->state < PERF_EVENT_STATE_INACTIVE)
 				continue;
-			if (!event_filter_match(event))
+			if (!event_filter_match(event,
+						/*check_cpu_and_cgroup=*/true))
 				continue;
 		}
 
@@ -6976,7 +6985,7 @@ static void perf_iterate_sb_cpu(perf_iterate_f output, void *data)
 
 		if (event->state < PERF_EVENT_STATE_INACTIVE)
 			continue;
-		if (!event_filter_match(event))
+		if (!event_filter_match(event, /*check_cpu_and_cgroup=*/true))
 			continue;
 		output(event, data);
 	}
-- 
2.22.0.709.g102302147b-goog

