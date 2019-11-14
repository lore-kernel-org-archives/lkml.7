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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29EBC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041DB206FE
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mWeWM45R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfKNAbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 19:31:14 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:54476 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfKNAbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 19:31:11 -0500
Received: by mail-pf1-f201.google.com with SMTP id 2so3048353pfv.21
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 16:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cguHIS1mj7NrMy4ME/gNz5fRpIQrgKiArcsnSPIxgZo=;
        b=mWeWM45RPPFmaJLv4eTY7ToF0DV/JOxOhcbueVeUs2CFrCdX20HXhA/ri33JXg9hUl
         x3Lu+wD/UVWf8j2mY4Kh/ypTgSnZ8qRbl6Irj6n+OYz0iqYj4MhOFd3sgu9+CJlcXMa9
         1Zk9jcfiCquUey55y1qjxDdwwb91ZekKJit100aGj5D199bUAOvfiletYYiJNfmzzGQx
         J6R0uf1wffu1q85fatjCuZhZlzEetIBRx0Sqbvobzbxbi3CUMYCVS6qS6YeowFGlR4s7
         +JIHRfL/SlJgRchgTlL0lZIjBIa3csWAXZdkQU4K7whipTcUWq/Yc3SdErDmuCvBfYAY
         8eaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cguHIS1mj7NrMy4ME/gNz5fRpIQrgKiArcsnSPIxgZo=;
        b=BtYsO9ofsEqLmqB0f7CW1gdrj9/sSAHTVu/du9ExR8t/hgFqiEiIIsj0YMIOW1AN3X
         tdxqGwVCKDV7HTjy9DH6O72/fG8bVDtDOCNQzdjVQj4d9X+4dZrbJgAF7UN5f52fY/AD
         remGftNDTqrjpV4nE/7jjEmmqu6QLH0NB+dx7K/6nP2rGTDbFjtxNpxIsZFs9MREBbyF
         x3Ryic+LEvFIB7ibVjTs+agsJ+4ejRtRy1/6MLGIWj2SSSr5eA15+ijwFPncUVKv2UBy
         vDjm8oguTDiQXSYcqCGE4dZIXie6GAcTXfwlrd21btGx8AUlep0JmCETor/XUw8Rkp2m
         xMjw==
X-Gm-Message-State: APjAAAV/hZy2W2nG/QBZYrR9gClpKEVUR+vo1p7SopYKhd8xCUC3BAUP
        YYBMUHaQBCDaW+JE4c+olaAVvWHsACkG
X-Google-Smtp-Source: APXvYqw9H1XBzAUWu2gnFHtKxEc/EI4Af0TMulh5PucIjFcaHzzGk/tGZeW+n3gt7NwHyx9A6zN6uHeIqGyy
X-Received: by 2002:a63:4101:: with SMTP id o1mr6791738pga.39.1573691469904;
 Wed, 13 Nov 2019 16:31:09 -0800 (PST)
Date:   Wed, 13 Nov 2019 16:30:40 -0800
In-Reply-To: <20191114003042.85252-1-irogers@google.com>
Message-Id: <20191114003042.85252-9-irogers@google.com>
Mime-Version: 1.0
References: <20191114003042.85252-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v3 08/10] perf: cache perf_event_groups_first for cgroups
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

Add a per-CPU cache of the pinned and flexible perf_event_groups_first
value for a cgroup avoiding an O(log(#perf events)) searches during
sched_in.

Based-on-work-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/linux/perf_event.h |  6 +++
 kernel/events/core.c       | 79 +++++++++++++++++++++++++++-----------
 2 files changed, 62 insertions(+), 23 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index b3580afbf358..cfd0b320418c 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -877,6 +877,12 @@ struct perf_cgroup_info {
 struct perf_cgroup {
 	struct cgroup_subsys_state	css;
 	struct perf_cgroup_info	__percpu *info;
+	/* A cache of the first event with the perf_cpu_context's
+	 * perf_event_context for the first event in pinned_groups or
+	 * flexible_groups. Avoids an rbtree search during sched_in.
+	 */
+	struct perf_event * __percpu    *pinned_event;
+	struct perf_event * __percpu    *flexible_event;
 };
 
 /*
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 11594d8bbb2e..9f0febf51d97 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1638,6 +1638,25 @@ perf_event_groups_insert(struct perf_event_groups *groups,
 
 	rb_link_node(&event->group_node, parent, node);
 	rb_insert_color(&event->group_node, &groups->tree);
+#ifdef CONFIG_CGROUP_PERF
+	if (is_cgroup_event(event)) {
+		struct perf_event **cgrp_event;
+
+		if (event->attr.pinned)
+			cgrp_event = per_cpu_ptr(event->cgrp->pinned_event,
+						event->cpu);
+		else
+			cgrp_event = per_cpu_ptr(event->cgrp->flexible_event,
+						event->cpu);
+		/*
+		 * Cgroup events for the same cgroup on the same CPU will
+		 * always be inserted at the right because of bigger
+		 * @groups->index. Only need to set *cgrp_event when it's NULL.
+		 */
+		if (!*cgrp_event)
+			*cgrp_event = event;
+	}
+#endif
 }
 
 /*
@@ -1652,6 +1671,9 @@ add_event_to_groups(struct perf_event *event, struct perf_event_context *ctx)
 	perf_event_groups_insert(groups, event);
 }
 
+static struct perf_event *
+perf_event_groups_next(struct perf_event *event);
+
 /*
  * Delete a group from a tree.
  */
@@ -1662,6 +1684,22 @@ perf_event_groups_delete(struct perf_event_groups *groups,
 	WARN_ON_ONCE(RB_EMPTY_NODE(&event->group_node) ||
 		     RB_EMPTY_ROOT(&groups->tree));
 
+#ifdef CONFIG_CGROUP_PERF
+	if (is_cgroup_event(event)) {
+		struct perf_event **cgrp_event;
+
+		if (event->attr.pinned)
+			cgrp_event = per_cpu_ptr(event->cgrp->pinned_event,
+						event->cpu);
+		else
+			cgrp_event = per_cpu_ptr(event->cgrp->flexible_event,
+						event->cpu);
+
+		if (*cgrp_event == event)
+			*cgrp_event = perf_event_groups_next(event);
+	}
+#endif
+
 	rb_erase(&event->group_node, &groups->tree);
 	init_event_group(event);
 }
@@ -1679,20 +1717,14 @@ del_event_from_groups(struct perf_event *event, struct perf_event_context *ctx)
 }
 
 /*
- * Get the leftmost event in the cpu/cgroup subtree.
+ * Get the leftmost event in the cpu subtree without a cgroup (ie task or
+ * system-wide).
  */
 static struct perf_event *
-perf_event_groups_first(struct perf_event_groups *groups, int cpu,
-			struct cgroup *cgrp)
+perf_event_groups_first_no_cgroup(struct perf_event_groups *groups, int cpu)
 {
 	struct perf_event *node_event = NULL, *match = NULL;
 	struct rb_node *node = groups->tree.rb_node;
-#ifdef CONFIG_CGROUP_PERF
-	int node_cgrp_id, cgrp_id = 0;
-
-	if (cgrp)
-		cgrp_id = cgrp->id;
-#endif
 
 	while (node) {
 		node_event = container_of(node, struct perf_event, group_node);
@@ -1706,18 +1738,10 @@ perf_event_groups_first(struct perf_event_groups *groups, int cpu,
 			continue;
 		}
 #ifdef CONFIG_CGROUP_PERF
-		node_cgrp_id = 0;
-		if (node_event->cgrp && node_event->cgrp->css.cgroup)
-			node_cgrp_id = node_event->cgrp->css.cgroup->id;
-
-		if (cgrp_id < node_cgrp_id) {
+		if (node_event->cgrp) {
 			node = node->rb_left;
 			continue;
 		}
-		if (cgrp_id > node_cgrp_id) {
-			node = node->rb_right;
-			continue;
-		}
 #endif
 		match = node_event;
 		node = node->rb_left;
@@ -3556,18 +3580,27 @@ static int ctx_groups_sched_in(struct perf_event_context *ctx,
 			.cap = ARRAY_SIZE(itrs),
 		};
 		/* Events not within a CPU context may be on any CPU. */
-		__heap_add(&event_heap, perf_event_groups_first(groups, -1,
-									NULL));
+		__heap_add(&event_heap,
+			perf_event_groups_first_no_cgroup(groups, -1));
 
 	}
 	evt = event_heap.data;
 
-	__heap_add(&event_heap, perf_event_groups_first(groups, cpu, NULL));
+	__heap_add(&event_heap,
+		perf_event_groups_first_no_cgroup(groups, cpu));
 
 #ifdef CONFIG_CGROUP_PERF
 	for (; css; css = css->parent) {
-		__heap_add(&event_heap, perf_event_groups_first(groups, cpu,
-								css->cgroup));
+		struct perf_cgroup *cgrp;
+
+		/* root cgroup doesn't have events */
+		if (css->id == 1)
+			break;
+
+		cgrp = container_of(css, struct perf_cgroup, css);
+		__heap_add(&event_heap, is_pinned
+			? *per_cpu_ptr(cgrp->pinned_event, cpu)
+			: *per_cpu_ptr(cgrp->flexible_event, cpu));
 	}
 #endif
 
-- 
2.24.0.432.g9d3f5f5b63-goog

