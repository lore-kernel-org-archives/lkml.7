Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98770C2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 23:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FBB124673
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 23:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YO1d6Pqj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfLFXQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 18:16:11 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:43082 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfLFXQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 18:16:09 -0500
Received: by mail-qk1-f202.google.com with SMTP id f22so3280205qka.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 15:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xEi+vKgsmLlcT/1KoTX4fLPGiQtWGmGYsrHJ8zjnTqs=;
        b=YO1d6PqjdVeEc1RKSNdzkJXwxvQl+MqVUA1A9f/XTslue/ktJqZ9t0zzsthheZu6D0
         571cuE7ceFewaHuEysCCxXMu3pBkvFq9G8ST+OP4IN37MLkI/O3uxQH/39WKztM/M++7
         Uk3bgnmx9ioEGQtP+/2R8i/7LlR+3tvv3BxRbSpS8Nx5Bple0I+d5lc5vRyPcfGoZFj0
         a3e2xTmdNZFlDeGzoYKC0ncaZyPAu/sE1O9YFcdz8DtEX9dr294YlLZ3TmU9LPAUoOF9
         uq9G2HFzkQE3WBRegzQ71ztn4G8SA/OMN6w4XBag3sAzo4Z2fzis4pnyJv0RMyvHc5aW
         qYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xEi+vKgsmLlcT/1KoTX4fLPGiQtWGmGYsrHJ8zjnTqs=;
        b=YUNKUqKMulQkJmKDJ9OZhOdfwbtVfe4CZj6v0r/ng/63BghkcrP0M8Nz8V6yzkjgM1
         XuICg3GB8yDuIQo0ELhdoM6s7+leU3VVl4EQIIqzbS/dIc8bCxqQtLBR/0WY1QdmvRn4
         MUwQVmAqZeJjlN0Qua3dcGh4qD8knhToB3OH2jFK3yTLLYr2IbhKWLfwV0GHrvxAweX9
         dc1DpCNQRWwOsJoI1kNXPXM3v6JoOOtRVULQ1/uUzqV1JDob/Seusg698RgbKacggivX
         gOuUqoxv/t1oOYQJLLhjZApslt2/SNOUdziF/1pzXhteEgIRZrGWJYIp9j19Ghz3r0m+
         Ja6Q==
X-Gm-Message-State: APjAAAWMD5AYnyrpCDdPnEzfNosNZvsTnmRUx6pkilW07ed/t+XJfLu7
        lFE9nIutGyTAjRzLjMa7/6MN8SkGsON/
X-Google-Smtp-Source: APXvYqxRyq12f1VSdhpHsRfBPnJnzVRn90I1UhJMa27O9joJnKczg+VrmL2SF43FzCoRrooTdR4L66mA4j0d
X-Received: by 2002:a0c:c28a:: with SMTP id b10mr15132736qvi.88.1575674167757;
 Fri, 06 Dec 2019 15:16:07 -0800 (PST)
Date:   Fri,  6 Dec 2019 15:15:37 -0800
In-Reply-To: <20191206231539.227585-1-irogers@google.com>
Message-Id: <20191206231539.227585-9-irogers@google.com>
Mime-Version: 1.0
References: <20191116011845.177150-1-irogers@google.com> <20191206231539.227585-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v5 08/10] perf: cache perf_event_groups_first for cgroups
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

Add a per-CPU cache of the pinned and flexible perf_event_groups_first
value for a cgroup avoiding an O(log(#perf events)) searches during
sched_in.

Based-on-work-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/linux/perf_event.h |  7 ++++
 kernel/events/core.c       | 84 ++++++++++++++++++++++++++++++++++----
 2 files changed, 82 insertions(+), 9 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index cd7d3b624655..a29a38df909e 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -892,6 +892,13 @@ struct perf_cgroup_info {
 struct perf_cgroup {
 	struct cgroup_subsys_state	css;
 	struct perf_cgroup_info	__percpu *info;
+	/*
+	 * A cache of the first event with the perf_cpu_context's
+	 * perf_event_context for the first event in pinned_groups or
+	 * flexible_groups. Avoids an rbtree search during sched_in.
+	 */
+	struct perf_event * __percpu    *pinned_event;
+	struct perf_event * __percpu    *flexible_event;
 };
 
 /*
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3da9cc1ebc2d..5935d2474050 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1638,6 +1638,27 @@ perf_event_groups_insert(struct perf_event_groups *groups,
 
 	rb_link_node(&event->group_node, parent, node);
 	rb_insert_color(&event->group_node, &groups->tree);
+#ifdef CONFIG_CGROUP_PERF
+	if (is_cgroup_event(event)) {
+		struct perf_event **cgrp_event;
+
+		if (event->attr.pinned) {
+			cgrp_event = per_cpu_ptr(event->cgrp->pinned_event,
+						event->cpu);
+		} else {
+			cgrp_event = per_cpu_ptr(event->cgrp->flexible_event,
+						event->cpu);
+		}
+		/*
+		 * Remember smallest, left-most, group index event. The
+		 * less-than condition is only possible if the group_index
+		 * overflows.
+		 */
+		if (!*cgrp_event ||
+			event->group_index < (*cgrp_event)->group_index)
+			*cgrp_event = event;
+	}
+#endif
 }
 
 /*
@@ -1652,6 +1673,9 @@ add_event_to_groups(struct perf_event *event, struct perf_event_context *ctx)
 	perf_event_groups_insert(groups, event);
 }
 
+static struct perf_event *
+perf_event_groups_next(struct perf_event *event);
+
 /*
  * Delete a group from a tree.
  */
@@ -1662,6 +1686,22 @@ perf_event_groups_delete(struct perf_event_groups *groups,
 	WARN_ON_ONCE(RB_EMPTY_NODE(&event->group_node) ||
 		     RB_EMPTY_ROOT(&groups->tree));
 
+#ifdef CONFIG_CGROUP_PERF
+	if (is_cgroup_event(event)) {
+		struct perf_event **cgrp_event;
+
+		if (event->attr.pinned) {
+			cgrp_event = per_cpu_ptr(event->cgrp->pinned_event,
+						event->cpu);
+		} else {
+			cgrp_event = per_cpu_ptr(event->cgrp->flexible_event,
+						event->cpu);
+		}
+		if (*cgrp_event == event)
+			*cgrp_event = perf_event_groups_next(event);
+	}
+#endif
+
 	rb_erase(&event->group_node, &groups->tree);
 	init_event_group(event);
 }
@@ -1679,7 +1719,8 @@ del_event_from_groups(struct perf_event *event, struct perf_event_context *ctx)
 }
 
 /*
- * Get the leftmost event in the cpu/cgroup subtree.
+ * Get the leftmost event in the cpu subtree without a cgroup (ie task or
+ * system-wide).
  */
 static struct perf_event *
 perf_event_groups_first(struct perf_event_groups *groups, int cpu,
@@ -3596,8 +3637,8 @@ static int ctx_groups_sched_in(struct perf_event_context *ctx,
 			.cap = ARRAY_SIZE(itrs),
 		};
 		/* Events not within a CPU context may be on any CPU. */
-		__heap_add(&event_heap, perf_event_groups_first(groups, -1,
-									NULL));
+		__heap_add(&event_heap,
+			perf_event_groups_first(groups, -1, NULL));
 	}
 	evt = event_heap.data;
 
@@ -3605,8 +3646,16 @@ static int ctx_groups_sched_in(struct perf_event_context *ctx,
 
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
 
@@ -12672,18 +12721,35 @@ perf_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 		return ERR_PTR(-ENOMEM);
 
 	jc->info = alloc_percpu(struct perf_cgroup_info);
-	if (!jc->info) {
-		kfree(jc);
-		return ERR_PTR(-ENOMEM);
-	}
+	if (!jc->info)
+		goto free_jc;
+
+	jc->pinned_event = alloc_percpu(struct perf_event *);
+	if (!jc->pinned_event)
+		goto free_jc_info;
+
+	jc->flexible_event = alloc_percpu(struct perf_event *);
+	if (!jc->flexible_event)
+		goto free_jc_pinned;
 
 	return &jc->css;
+
+free_jc_pinned:
+	free_percpu(jc->pinned_event);
+free_jc_info:
+	free_percpu(jc->info);
+free_jc:
+	kfree(jc);
+
+	return ERR_PTR(-ENOMEM);
 }
 
 static void perf_cgroup_css_free(struct cgroup_subsys_state *css)
 {
 	struct perf_cgroup *jc = container_of(css, struct perf_cgroup, css);
 
+	free_percpu(jc->pinned_event);
+	free_percpu(jc->flexible_event);
 	free_percpu(jc->info);
 	kfree(jc);
 }
-- 
2.24.0.393.g34dc348eaf-goog

