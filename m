Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0AFC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA70C206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K0v1CUGA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfKNAbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 19:31:05 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:36520 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfKNAbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 19:31:00 -0500
Received: by mail-qt1-f201.google.com with SMTP id o13so2791118qtr.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 16:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MWB+gm9aKaGUDRmtPgtUzEsiS+X0ixdA5HqFo/zxG2c=;
        b=K0v1CUGAHv2OenZZWjO98aesxZmxJX1yci+ArsmnkrbJyX0klqcGreJKGX3MDMzVsQ
         nZB72KVwGLzq7xrZmrdeaizz3b0WFqF6E4Ey0SdUVOy9LXrOWYJwoj4zfzfeqKoJXs87
         mIu7DuVPL8JSNCKfEuAQN1XJXFIhszQEErq+bIcoM4wnTwnHdHGSn+Fv2tHXlA5Coy0i
         FNB2usgTexYUkn0uoqqX2m36GXkpEPx+p5v/6TGc0ajum3EjJxxto9gwXCFfoy15uZO6
         E/DGvq9lrzGbl2AjlnFRAYee7/KQEgSnVKkFrDRJQtLgLyCAf1Zdch+5Aq0XTtjkiQ1t
         /xgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MWB+gm9aKaGUDRmtPgtUzEsiS+X0ixdA5HqFo/zxG2c=;
        b=CfzBGzb8LPJedKayZ27dSxrMKMi/pkL3KBgUy32q265Zgq18GUP/q5sXTBD07xb4/P
         PrVz1/OgnUwLzHGNCXiHe4HlvGobGNsRMNzf6QWhbPdCJS7dQamdmG/F7OF8udTGzLMz
         eAOfPlxUzYph+AwCSqFiR8hKRQfVwgt4yT9p8fK16f+Fnkqb4VicgzGswjygIvbWd6NP
         JuakDIforcNxi5PsBn+5xmln4CuCi92laXVUtneG9ZDYx0aIgoqtHbnE3xYg/MBjChPB
         UrlME1RXEik7b1hDja0CEMtwp26UC/wN7B6icqpr+v0IfgFPZhtl65pKV2CxUy9FsabE
         77fw==
X-Gm-Message-State: APjAAAW+mYtqVQ/PC88znzVEo8BQlvu+oZPTUj/8pFCKWUtaYA66Q+ff
        jpFExhL5cQZjFbkBqmKNA+VmtMwPm3Al
X-Google-Smtp-Source: APXvYqy5fzlLDsSaL5bOL5oSLl9xnAcItsC8xNeBOhbabIyjTRVysa/bq1ysF3/cUBrlWyZ+H2wgPI4u8m0t
X-Received: by 2002:ae9:c203:: with SMTP id j3mr5367254qkg.12.1573691458765;
 Wed, 13 Nov 2019 16:30:58 -0800 (PST)
Date:   Wed, 13 Nov 2019 16:30:36 -0800
In-Reply-To: <20191114003042.85252-1-irogers@google.com>
Message-Id: <20191114003042.85252-5-irogers@google.com>
Mime-Version: 1.0
References: <20191114003042.85252-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v3 04/10] perf: Add per perf_cpu_context min_heap storage
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
 include/linux/perf_event.h |  7 ++++++
 kernel/events/core.c       | 49 ++++++++++++++++++++++++++++----------
 2 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 011dcbdbccc2..b3580afbf358 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -835,6 +835,13 @@ struct perf_cpu_context {
 	int				sched_cb_usage;
 
 	int				online;
+	/*
+	 * Per-CPU storage for iterators used in visit_groups_merge. The default
+	 * storage is of size 2 to hold the CPU and any CPU event iterators.
+	 */
+	int				itr_storage_cap;
+	struct perf_event		**itr_storage;
+	struct perf_event		*itr_default[2];
 };
 
 struct perf_output_handle {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index a5a3d349a8f1..0dab60bf5935 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3403,30 +3403,46 @@ static void __heap_add(struct min_max_heap *heap, struct perf_event *event)
 	}
 }
 
-static noinline int visit_groups_merge(struct perf_event_groups *groups, int cpu,
-			      int (*func)(struct perf_event *, void *), void *data)
+static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
+				struct perf_event_groups *groups, int cpu,
+				int (*func)(struct perf_event *, void *),
+				void *data)
 {
 	/* Space for per CPU and/or any CPU event iterators. */
 	struct perf_event *itrs[2];
-	struct min_max_heap event_heap = {
-		.data = itrs,
-		.size = 0,
-		.cap = ARRAY_SIZE(itrs),
-	};
+	struct min_max_heap event_heap;
+	struct perf_event **evt;
 	struct perf_event *next;
 	int ret;
 
-	__heap_add(&event_heap, perf_event_groups_first(groups, -1));
+	if (cpuctx) {
+		event_heap = (struct min_max_heap){
+			.data = cpuctx->itr_storage,
+			.size = 0,
+			.cap = cpuctx->itr_storage_cap,
+		};
+	} else {
+		event_heap = (struct min_max_heap){
+			.data = itrs,
+			.size = 0,
+			.cap = ARRAY_SIZE(itrs),
+		};
+		/* Events not within a CPU context may be on any CPU. */
+		__heap_add(&event_heap, perf_event_groups_first(groups, -1));
+
+	}
+	evt = event_heap.data;
+
 	__heap_add(&event_heap, perf_event_groups_first(groups, cpu));
 
 	heapify_all(&event_heap, &perf_min_heap);
 
 	while (event_heap.size) {
-		ret = func(itrs[0], data);
+		ret = func(*evt, data);
 		if (ret)
 			return ret;
 
-		next = perf_event_groups_next(itrs[0]);
+		next = perf_event_groups_next(*evt);
 		if (next)
 			heap_pop_push(&event_heap, &next, &perf_min_heap);
 		else
@@ -3500,7 +3516,10 @@ ctx_pinned_sched_in(struct perf_event_context *ctx,
 		.can_add_hw = 1,
 	};
 
-	visit_groups_merge(&ctx->pinned_groups,
+	if (ctx != &cpuctx->ctx)
+		cpuctx = NULL;
+
+	visit_groups_merge(cpuctx, &ctx->pinned_groups,
 			   smp_processor_id(),
 			   pinned_sched_in, &sid);
 }
@@ -3515,7 +3534,10 @@ ctx_flexible_sched_in(struct perf_event_context *ctx,
 		.can_add_hw = 1,
 	};
 
-	visit_groups_merge(&ctx->flexible_groups,
+	if (ctx != &cpuctx->ctx)
+		cpuctx = NULL;
+
+	visit_groups_merge(cpuctx, &ctx->flexible_groups,
 			   smp_processor_id(),
 			   flexible_sched_in, &sid);
 }
@@ -10182,6 +10204,9 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 		cpuctx->online = cpumask_test_cpu(cpu, perf_online_mask);
 
 		__perf_mux_hrtimer_init(cpuctx, cpu);
+
+		cpuctx->itr_storage_cap = ARRAY_SIZE(cpuctx->itr_default);
+		cpuctx->itr_storage = cpuctx->itr_default;
 	}
 
 got_cpu_context:
-- 
2.24.0.432.g9d3f5f5b63-goog

