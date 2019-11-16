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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C28C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 01:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A295B2073A
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 01:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bv3P61Ra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfKPBT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 20:19:29 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:38527 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfKPBTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 20:19:13 -0500
Received: by mail-pf1-f202.google.com with SMTP id m1so9090492pfh.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 17:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YNPtFzER6KXZ2R7pBEXKU8wWSWDes8JU2W1nei7Z8qE=;
        b=Bv3P61RakIE/TPYroUhzffK08Q1KijwQXCUTSVZ4LyVYd9Rjd9yskulRkYnuL8SWFQ
         Dhx2bRQuwvp6ZhhsRJlOVDs8SxPsOrQFhWp5oIIiRxAeF4ldJPI7Ea+9uxXoEpPlOZSi
         oZWXhOnMLGcu+e7p5gkQ8sd4I59wCH07gcypvCwhy/nZXf4XRfGUewcxpaDHWr1A/3Gh
         yURHKXelY2er9X3aqpk45hp+Nn/ELNgFdVNX3gUn0ym1fz7DrHsLWt6Tv1pHmT/7+l1I
         +wr15M8PTIIptJrNRzE/SQzrIVLGsSDlacih+QQejMNUqxQ1YUq3wLva1PnINfXUHtQg
         tMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YNPtFzER6KXZ2R7pBEXKU8wWSWDes8JU2W1nei7Z8qE=;
        b=O8+bkllNjp+UarST1apfb1O6iRnb4DEFJ009oqfUfgNZw0mEM1ejTS1Thpfz9VdaM5
         GY2wvNnSGul+xsZgeCU8J8UKEJePIxlgEEDfa6k6R8uIZmXc8f2tVNTYQIEztI4Dd+2j
         H/e2xFZun0X5fh06NuDZk5bx8GjLtYUkfaL3xeFBGP33nhzZYHbYx7hYwZi9lCHyLdsF
         9NxhbYEM7Y8g598WaiWaZogm29IGu7D9ATJEDCCZd6uDIiVkkUispAZyeu+E0FC8/8QD
         LwwXKwllrSuPE2bBjrd1dMYuW5wyEtVTz5If60KM7S6iwJK93wyo/I6uOoWM1/uxpx+w
         aYBw==
X-Gm-Message-State: APjAAAXRztsRGW/gyO986rm4+WwHIjI44azvRjFgR9phRkelo4QoahaO
        j1kRpBz1zZQUrXh/3jIFa0/scNjnlNCt
X-Google-Smtp-Source: APXvYqw3CvKLUSGF+snsVfZlw1e2g5xZPdjB3qEiAOOTOCJ/FQqRldvjCkck66ekshlc3dpK+IrPyC4eW6cn
X-Received: by 2002:a63:f812:: with SMTP id n18mr19993935pgh.109.1573867152396;
 Fri, 15 Nov 2019 17:19:12 -0800 (PST)
Date:   Fri, 15 Nov 2019 17:18:43 -0800
In-Reply-To: <20191116011845.177150-1-irogers@google.com>
Message-Id: <20191116011845.177150-9-irogers@google.com>
Mime-Version: 1.0
References: <20191114003042.85252-1-irogers@google.com> <20191116011845.177150-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v4 08/10] perf: cache perf_event_groups_first for cgroups
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
index b3580afbf358..be3ca69b3f69 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -877,6 +877,13 @@ struct perf_cgroup_info {
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
index 948a66967eb5..37abfca18bd3 100644
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
@@ -3581,8 +3622,8 @@ static int ctx_groups_sched_in(struct perf_event_context *ctx,
 			.cap = ARRAY_SIZE(itrs),
 		};
 		/* Events not within a CPU context may be on any CPU. */
-		__heap_add(&event_heap, perf_event_groups_first(groups, -1,
-									NULL));
+		__heap_add(&event_heap,
+			perf_event_groups_first(groups, -1, NULL));
 	}
 	evt = event_heap.data;
 
@@ -3590,8 +3631,16 @@ static int ctx_groups_sched_in(struct perf_event_context *ctx,
 
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
 
@@ -12493,18 +12542,35 @@ perf_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
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
2.24.0.432.g9d3f5f5b63-goog

