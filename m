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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E20C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 01:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E6D20733
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 01:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vzF2vCp2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfKPBTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 20:19:08 -0500
Received: from mail-qv1-f74.google.com ([209.85.219.74]:34268 "EHLO
        mail-qv1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbfKPBTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 20:19:06 -0500
Received: by mail-qv1-f74.google.com with SMTP id y24so7913449qvh.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 17:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aBmFfoHDy2MA7WxjeZxqFYu+YzVSe4daO8WMbbeAXKE=;
        b=vzF2vCp28dqBCcFIVoLtAzaLQ2RTtrfIGaDX/E7izQH5eBJ3/m8GURwr2jqYFtLaim
         ekVKZ6wgivyVtJsUlnnsB5nhc39kPfwx6eQ02Vf0NFKZpK5Ksc4B2v/V9q9TettxlftJ
         7/+ogZCXEOfjj1xCNM1GndJjbguM8oR+pXLsCm3dKmBa36QJzROvvYJ7tScuhw/0U1WJ
         MoT8eS3mgFIgV+HjKIa1I78s7xBS9PeI+HRwKz2Y0G7DcbSzm9uTy6rr/OeBMNuSqpTY
         6jQmUPnBnaT2LSCMgFJAhjJcjU+gGXtJMENgp776v5VKL2zCyzYbcTypKWL1bV4AyINI
         FdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aBmFfoHDy2MA7WxjeZxqFYu+YzVSe4daO8WMbbeAXKE=;
        b=dz1cdIRaVV8V1Hi8gZoMoVjHEkBwKahFCMjdZnLNlvhgYneT8xcQ/PWLy/LIJUDMgD
         1NYj3WQmvKpFSLvOtYJ0H95A1SZdQA074j07tyeuMl32BuugT9zFr+vG/DUeKF/5ZZ7y
         7Ci2dHLvg9batQA4a0+SJGKGgGMNZXUIRyEitlCW/XavnQp4V66nQlrIo+FNYBm3jCKf
         dtnmL/H2lfz5NrpiV45aHUfkkZEH4D7vLbgvLFnuQ1CcfR/65KeU5BmFxNe/yGdmBUQn
         ZcEvT926kDeFzX0Qh7Y49v73cb5LnjkJqbaTcQ9bPgqtkaLQkIZvzcd8xCyquSM9XcpH
         1LQg==
X-Gm-Message-State: APjAAAWBP2KoxZPUPkWBpT07jHOGuugimFRfbzkrVBLMWh0gaxlUeLt/
        IvUASC6B33yjDWLXQASezpJX1OSJN/rh
X-Google-Smtp-Source: APXvYqxJbJML7gydfNzyd1xLyLOC6XzbVqPAtoNAsK0bKXSyQGN4BsvbE9WmUsb1n6iqOMn8DMZwFYVu/I/4
X-Received: by 2002:ae9:c30e:: with SMTP id n14mr15358727qkg.24.1573867143681;
 Fri, 15 Nov 2019 17:19:03 -0800 (PST)
Date:   Fri, 15 Nov 2019 17:18:40 -0800
In-Reply-To: <20191116011845.177150-1-irogers@google.com>
Message-Id: <20191116011845.177150-6-irogers@google.com>
Mime-Version: 1.0
References: <20191114003042.85252-1-irogers@google.com> <20191116011845.177150-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v4 05/10] perf/cgroup: Grow per perf_cpu_context heap storage
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
index a1c44d09eff8..8817c645bef9 100644
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

