Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90309C2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 23:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 647792245C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 23:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oDqlOmaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfLFXQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 18:16:04 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:52238 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfLFXQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 18:16:00 -0500
Received: by mail-pf1-f201.google.com with SMTP id f20so4877275pfn.19
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 15:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cNsHRQLfxVmBzpyxiQKp7IMxiaZn40N9njnfnrIm3xM=;
        b=oDqlOmaW+RwDEzTbYiSa0YUPAyAes31hCfR5RwaZz/4T7FZ0XTnVoOc3nC3oUZPBnU
         fwWiVp3YAh3D/W8DZCHmoaD9v7Xh2wG6F2Wd438seDEZbKm28/tfbUcpTEk7gUbamspd
         ki9MnSnlUfJ1cJtOMzwb4Bpva0oqrS4VKXfHLmN5aGZ6eY7JkMGY2pFeyofL1CTTkjUq
         MW1VqvGhr6iwDV6u71Ou8IuKTlByqU2ZIB/lcmVtb98PqNzKMxbQqF58fofVRBUTyVwr
         QgFDx7n7CGBeSlMH/G30s9Ln3Bj8MQ8d/ozvwP5Nemnw/vqVJaetA8T7KakyfLlw4JQu
         Pr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cNsHRQLfxVmBzpyxiQKp7IMxiaZn40N9njnfnrIm3xM=;
        b=HnyD6hUg8xM4jpLWqkA2pn66KC5qO5N9DRJ8VZ+lB0hw4VTzyB2ZgtQC7djiE+Kb6C
         Hm6EkTFvlRll3S8g5SM+fZKiItcswN69WCddb4yu1sDwgQ1bo55MALfhKEP6nLwHrhXr
         Tg0JW38gP44+sk8yL5V7Oz58XrynMmw86Pnvtks6FWEoc1g9b1bd2XbONVKkjE8rHFFV
         iz1JHIEP+mPVbN0wz7Wdm1uieVz2QX8kXHgz4iqoGRryRvINcuCfAfBnJRh2eS5KTV1y
         FCMvVivznlJTbNy/QuszlczdYHtdc7CS1tySOJ+krbEfj7rBA7RHxHwSmlum2PVNISf8
         P8ag==
X-Gm-Message-State: APjAAAU+fMtBm2/DjfGDZcyINReN3bmU3SpjDkuZKd9P9xrq8zvVZu4z
        uDgcBzDM7GAcwDoEx9nbXG3MXsx8uD93
X-Google-Smtp-Source: APXvYqwyqX5TtNoa83iLhsZHnZtVGFnA+84U2X1G0YAqqGs0EnbFxvMlw4kPXywqwqBbQwi1zJHtl2gsNPbQ
X-Received: by 2002:a65:62d3:: with SMTP id m19mr6187258pgv.270.1575674159641;
 Fri, 06 Dec 2019 15:15:59 -0800 (PST)
Date:   Fri,  6 Dec 2019 15:15:34 -0800
In-Reply-To: <20191206231539.227585-1-irogers@google.com>
Message-Id: <20191206231539.227585-6-irogers@google.com>
Mime-Version: 1.0
References: <20191116011845.177150-1-irogers@google.com> <20191206231539.227585-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v5 05/10] perf/cgroup: Grow per perf_cpu_context heap storage
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

Allow the per-CPU min heap storage to have sufficient space for per-cgroup
iterators.

Based-on-work-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 kernel/events/core.c | 47 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 259eca137563..1e484ffff572 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -892,6 +892,47 @@ static inline void perf_cgroup_sched_in(struct task_struct *prev,
 	rcu_read_unlock();
 }
 
+static int perf_cgroup_ensure_storage(struct perf_event *event,
+				struct cgroup_subsys_state *css)
+{
+	struct perf_cpu_context *cpuctx;
+	struct perf_event **storage;
+	int cpu, itr_cap, ret = 0;
+
+	/*
+	 * Allow storage to have sufficent space for an iterator for each
+	 * possibly nested cgroup plus an iterator for events with no cgroup.
+	 */
+	for (itr_cap = 1; css; css = css->parent)
+		itr_cap++;
+
+	for_each_possible_cpu(cpu) {
+		cpuctx = per_cpu_ptr(event->pmu->pmu_cpu_context, cpu);
+		if (itr_cap <= cpuctx->itr_storage_cap)
+			continue;
+
+		storage = kmalloc_node(itr_cap * sizeof(struct perf_event *),
+				       GFP_KERNEL, cpu_to_node(cpu));
+		if (!storage) {
+			ret = -ENOMEM;
+			break;
+		}
+
+		raw_spin_lock_irq(&cpuctx->ctx.lock);
+		if (cpuctx->itr_storage_cap < itr_cap) {
+			swap(cpuctx->itr_storage, storage);
+			if (storage == cpuctx->itr_default)
+				storage = NULL;
+			cpuctx->itr_storage_cap = itr_cap;
+		}
+		raw_spin_unlock_irq(&cpuctx->ctx.lock);
+
+		kfree(storage);
+	}
+
+	return ret;
+}
+
 static inline int perf_cgroup_connect(int fd, struct perf_event *event,
 				      struct perf_event_attr *attr,
 				      struct perf_event *group_leader)
@@ -911,6 +952,10 @@ static inline int perf_cgroup_connect(int fd, struct perf_event *event,
 		goto out;
 	}
 
+	ret = perf_cgroup_ensure_storage(event, css);
+	if (ret)
+		goto out;
+
 	cgrp = container_of(css, struct perf_cgroup, css);
 	event->cgrp = cgrp;
 
@@ -3436,6 +3481,8 @@ static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
 			.size = 0,
 			.cap = cpuctx->itr_storage_cap,
 		};
+
+		lockdep_assert_held(&cpuctx->ctx.lock);
 	} else {
 		event_heap = (struct min_heap){
 			.data = itrs,
-- 
2.24.0.393.g34dc348eaf-goog

