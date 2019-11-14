Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4F2C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F90B206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FFhtRlhg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfKNAb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 19:31:28 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:38854 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKNAbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 19:31:02 -0500
Received: by mail-pl1-f201.google.com with SMTP id i5so2634350plt.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 16:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=n7eKokJvGZuDAJc8p4WUEijEYzPsLCGE45AbuIaYhBY=;
        b=FFhtRlhgcszmA5spc/RLykSetto5GQCLeBSoTnPALvyogdtRUqiD77ucOiXhE8WVe1
         xYWfnCWBdN6/Jb3LJyu0W4AfK987zXgoe8Bz2SQzLUX2r2tKbWrmjzmp4Frsu8GWgCfg
         pbNrLBgiy3ykQutMnIy693RDh9CDI9vHVRj8zRqrBD4gHPMlG9/kOwX/b6FuUCOeBgEy
         s7Ydl5j0YJT1fIi0ggl5JDHVwvM+5uhkO6WFLKBaz1ELQWVGpf/Qf5YWhosEHHPTVlSe
         oT7ykvh65RTLyvGlcj6vViwl+6TDFkLtoZNJObxmpuMELr3MWEQtb60cDbKRgDSSVDxJ
         CMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=n7eKokJvGZuDAJc8p4WUEijEYzPsLCGE45AbuIaYhBY=;
        b=YTMig20Pa35mI166MswTRmU4GIxQsbpQ6SV1kO9Qg2OsuoY8h+4HoabQdKK77UwJ10
         M4iQ9kNLMw5dVGdF/QkmKUCZNr2sosk2MyIrvXh7uTthr/yQUhrymM7abtNJTrbN1768
         bs5Ovf67ZQV0knvC8qwvu5a23eOPHwMGetN7ciCeJNZ/Dd7AwjZ4nrJV2QXslaW6zzGC
         EiKuqJE3EhFPjdwR0FN/y9/+SM0S7QjEBuedrerd5S6H9N9JUTZaK/JPy2Zc/Y2LF4ip
         2j07RihdzEHWZWXInvbPwtmE/BjCkM/wyLjS/7ePamIdm1WfN0PoDFyblKUMl9HY0edW
         d8Sw==
X-Gm-Message-State: APjAAAUYCuPDgTulG9C5F+PZDnRWrGnqL0mklrXa+zMmVRRXlx5ALrPi
        BdGInk2iytsiT32N+3HCYuqXpyKpwXfK
X-Google-Smtp-Source: APXvYqz89zDNjqR1R6luksgmmvRvLIX2fmFT5IfGQ6eHaES7caY+C9/Beyn2JnT15hQg8E+71BN4Ry1BLTvN
X-Received: by 2002:a63:1a51:: with SMTP id a17mr6638786pgm.449.1573691461370;
 Wed, 13 Nov 2019 16:31:01 -0800 (PST)
Date:   Wed, 13 Nov 2019 16:30:37 -0800
In-Reply-To: <20191114003042.85252-1-irogers@google.com>
Message-Id: <20191114003042.85252-6-irogers@google.com>
Mime-Version: 1.0
References: <20191114003042.85252-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v3 05/10] perf/cgroup: Grow per perf_cpu_context heap storage
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

Allow the per-CPU min heap storage to have sufficient space for per-cgroup
iterators.

Based-on-work-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 kernel/events/core.c | 47 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0dab60bf5935..3c44be7de44e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -892,6 +892,47 @@ static inline void perf_cgroup_sched_in(struct task_struct *prev,
 	rcu_read_unlock();
 }
 
+static int perf_cgroup_ensure_itr_storage_cap(struct perf_event *event,
+					struct cgroup_subsys_state *css)
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
 
+	ret = perf_cgroup_ensure_itr_storage_cap(event, css);
+	if (ret)
+		goto out;
+
 	cgrp = container_of(css, struct perf_cgroup, css);
 	event->cgrp = cgrp;
 
@@ -3421,6 +3466,8 @@ static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
 			.size = 0,
 			.cap = cpuctx->itr_storage_cap,
 		};
+
+		lockdep_assert_held(&cpuctx->ctx.lock);
 	} else {
 		event_heap = (struct min_max_heap){
 			.data = itrs,
-- 
2.24.0.432.g9d3f5f5b63-goog

