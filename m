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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FD1C43141
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 01:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D7A2073A
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 01:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kR4lOIKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfKPBTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 20:19:04 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:51700 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbfKPBTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 20:19:02 -0500
Received: by mail-pf1-f202.google.com with SMTP id 198so9053015pfz.18
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 17:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MfnX4kum6LtTgP0OLyI7zsgIzIn3npJAZpvCxVBFYIU=;
        b=kR4lOIKrvl1eAITYL9TiO77HTDSVmMGY6VS1nm3O1d0sNu7QiyxX46hAySkxKCMtyb
         wbT4QsF/01KoErsnbL2LSwK4gy8kBQZUuUYO4njTG9uN+9mvKfIyKJA7qrbIJLZLBEOM
         UHnPR82SJWNFc2J+1xowjuE7zg3gj2iDW4qLu+0OAzM4WZwjHdT2LCwa/bx6msmV27wy
         ABJhv/DwkocHzC1XfbGXJw608uHHCXd2h2CLvqKIXHNBoBnAuG82t+wE6fGGkl7P9B/o
         I4xq7cDTAs9hs6pIy5+ZZWhGN96JLNLrkIB3WSEcYdMYmjMEIp/gVvUvdymbR0335lTs
         Pupg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MfnX4kum6LtTgP0OLyI7zsgIzIn3npJAZpvCxVBFYIU=;
        b=dtGVlONnjX/+scQnNNohiS94J/2kVtzuPoKLd4kqYnWdqwyeOWEeZ4vDIjZMMwevGi
         nrtZQ0+dr31oj27SyY25hoUjscfcWHyh7FfELeb95/rTGdb5VqD3RZc6Wke/zcoNhBZP
         CyOVfeiPEAcYV7ubHEn9LsnJPAvU62yOrdUVoT3YEfAXrEI9QPuszT2q8IB5BOohxnDC
         7CvnCdzA8SRNHPZqfZSeIRDCWN7vMUS152gDzWKfKMYKqBZezOtFWTuVqKVzOAXXg9Lz
         sVBGOUAXsRFFw2foQlGoaST6R04ZkSuz/yrb87EFi0r5TNueAQltPET1WlnPH1Utj1lp
         IFbg==
X-Gm-Message-State: APjAAAXoub72cSEsNaWp/mgtrwmjMy2nZPafqD5cNjtGgTPWYWpW1cJk
        /uiFjbSCGZRZMCUlFYlDuGAgTKSI+N5x
X-Google-Smtp-Source: APXvYqz9JLdoAf9gKLwXFLA7Qbn0yf4uda7UqHbOaKQt70ssve+JpXr/7KbIKURMD1yTW3g7Sra4p0WWP3GB
X-Received: by 2002:a63:4c43:: with SMTP id m3mr4620095pgl.315.1573867140835;
 Fri, 15 Nov 2019 17:19:00 -0800 (PST)
Date:   Fri, 15 Nov 2019 17:18:39 -0800
In-Reply-To: <20191116011845.177150-1-irogers@google.com>
Message-Id: <20191116011845.177150-5-irogers@google.com>
Mime-Version: 1.0
References: <20191114003042.85252-1-irogers@google.com> <20191116011845.177150-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v4 04/10] perf: Add per perf_cpu_context min_heap storage
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

The storage required for visit_groups_merge's min heap needs to vary in
order to support more iterators, such as when multiple nested cgroups'
events are being visited. This change allows for 2 iterators and doesn't
support growth.
Based-on-work-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/linux/perf_event.h |  7 ++++++
 kernel/events/core.c       | 46 ++++++++++++++++++++++++++++----------
 2 files changed, 41 insertions(+), 12 deletions(-)

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
index b0e89a488e3d..a1c44d09eff8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3403,32 +3403,45 @@ static void __heap_add(struct min_max_heap *heap, struct perf_event *event)
 	}
 }
 
-static noinline int visit_groups_merge(struct perf_event_groups *groups,
-				int cpu,
+static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
+				struct perf_event_groups *groups, int cpu,
 				int (*func)(struct perf_event *, void *),
 				void *data)
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
+	}
+	evt = event_heap.data;
+
 	__heap_add(&event_heap, perf_event_groups_first(groups, cpu));
 
 	min_max_heapify_all(&event_heap, &perf_min_heap);
 
 	while (event_heap.size) {
-		ret = func(itrs[0], data);
+		ret = func(*evt, data);
 		if (ret)
 			return ret;
 
-		next = perf_event_groups_next(itrs[0]);
+		next = perf_event_groups_next(*evt);
 		if (next) {
 			min_max_heap_pop_push(&event_heap, &next,
 					&perf_min_heap);
@@ -3503,7 +3516,10 @@ ctx_pinned_sched_in(struct perf_event_context *ctx,
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
@@ -3518,7 +3534,10 @@ ctx_flexible_sched_in(struct perf_event_context *ctx,
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
@@ -10185,6 +10204,9 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 		cpuctx->online = cpumask_test_cpu(cpu, perf_online_mask);
 
 		__perf_mux_hrtimer_init(cpuctx, cpu);
+
+		cpuctx->itr_storage_cap = ARRAY_SIZE(cpuctx->itr_default);
+		cpuctx->itr_storage = cpuctx->itr_default;
 	}
 
 got_cpu_context:
-- 
2.24.0.432.g9d3f5f5b63-goog

