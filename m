Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EE8C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05772148E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MQBuR2Cn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbfDHRdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 13:33:03 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:51567 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfDHRdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 13:33:01 -0400
Received: by mail-pf1-f202.google.com with SMTP id s26so3039415pfm.18
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 10:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UhICCW1hVOgYnDU8QeqE210ACZ9KuR7LYeqsqj0Z0uk=;
        b=MQBuR2Cny5rq290AfZ7LFumVKYlbAJ6wIBleljUw2pOtVt+C8PhZJ/EpL4EP910mdl
         ZiJ8BYFDa/De1yst6Arg/jstnlsbwLpY4boAJURBImRIjy5vTyvTRZGLxlJF0q8oWTqz
         irlYI+0SUzUw3IJ2IUfhIABBtr2ZP0cDw61W2Wm/pNYRRbhzeVXecmAGlQea/F3DSM6K
         bwOOJKUuMRQnVm9OO7aR+LWgTYLRxpda6jesCocDYgpLzbyZ+BUVXjRWO1V7txTu9T9g
         0va3jCLlFjdHPweI3mvP2Vb8gIBUXgyCh8DkTHZGtZ7zIpaSvzrGZXd6SJYqaFoMsD3w
         XRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UhICCW1hVOgYnDU8QeqE210ACZ9KuR7LYeqsqj0Z0uk=;
        b=MExgUL8oupKGKT94eLcJqoeh9LvFDNgEMQe4EziwrxsfWMsacy7pmcO5CiJWaxhSua
         6FpSkImWEEr0s4vPtyIVcuJ4wYmdxKXfpF79vNPWEOkcbOmuFUT1ysJOmf13BC4S0BlP
         xA3cLtGVgt8buDNw2WtlPsJzJgKgK5PZDi9ZHfXnD76TMzePb9o9WA0lYuYCiUBAZJWp
         P8ek89kG8Q24M5XjxnyvPb+pjvSnHZRjK04HsV8J+6xIjPYVINKEi5FIdRZu4CR8JnXN
         J3Qemg4wWcpy8f7xohlKP1qt/pxAyCd78L01hwf9TjSD21/kYK4LIMJXstnYNxCV9odH
         az+A==
X-Gm-Message-State: APjAAAXqa8jFYRIQdH1VafsDpsEnhbAhaUb4iLxQ4PMgUJoY0ZnKjb4D
        mFzLqdopTxWOXOr5DerswuFL2Kh0LBAIc0wS5eT7nvYOUYYPY3FcjU2MA82jM9VL9iAY8O16P3/
        6hgCdhWWpoIuZLq3kocpY6QV52WIpw5WJdt9l3CQRU45NeoFCbk/qKCOXP/TS7OW3jQXx3TN1
X-Google-Smtp-Source: APXvYqyZtrCXxjD7e4lB22f2oiWCopv07PSSiLKJ9ViDC2ktnYQZvE0yK/NGOMVwIOLyKuMwvKe4J3m5jRqM
X-Received: by 2002:aa7:9507:: with SMTP id b7mr710246pfp.113.1554744780438;
 Mon, 08 Apr 2019 10:33:00 -0700 (PDT)
Date:   Mon,  8 Apr 2019 10:32:51 -0700
In-Reply-To: <20190408173252.37932-1-eranian@google.com>
Message-Id: <20190408173252.37932-2-eranian@google.com>
Mime-Version: 1.0
References: <20190408173252.37932-1-eranian@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v2 1/2] perf/core: add perf_ctx_resched() as global function
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, tglx@linutronix.de, ak@linux.intel.com,
        kan.liang@intel.com, mingo@elte.hu, nelson.dsouza@intel.com,
        jolsa@redhat.com, tonyj@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add perf_ctx_resched() a global function that can be called
to force rescheduling of events based on event types. The function locks
both cpuctx and task_ctx internally. This will be used by a subsequent patch.

Signed-off-by: Stephane Eranian <eranian@google.com>
Change-Id: Icbc05e5f461fd6e091b46778fe62b23f308e2be7
---
 include/linux/perf_event.h | 14 ++++++++++++++
 kernel/events/core.c       | 18 +++++++++---------
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 085a95e2582a..ee8a275df0ed 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -822,6 +822,15 @@ struct bpf_perf_event_data_kern {
 	struct perf_event *event;
 };
 
+enum event_type_t {
+	EVENT_FLEXIBLE = 0x1,
+	EVENT_PINNED = 0x2,
+	EVENT_TIME = 0x4,
+	/* see ctx_resched() for details */
+	EVENT_CPU = 0x8,
+	EVENT_ALL = EVENT_FLEXIBLE | EVENT_PINNED,
+};
+
 #ifdef CONFIG_CGROUP_PERF
 
 /*
@@ -888,6 +897,11 @@ extern void perf_sched_cb_dec(struct pmu *pmu);
 extern void perf_sched_cb_inc(struct pmu *pmu);
 extern int perf_event_task_disable(void);
 extern int perf_event_task_enable(void);
+
+extern void perf_ctx_resched(struct perf_cpu_context *cpuctx,
+			     struct perf_event_context *task_ctx,
+			     enum event_type_t event_type);
+
 extern int perf_event_refresh(struct perf_event *event, int refresh);
 extern void perf_event_update_userpage(struct perf_event *event);
 extern int perf_event_release_kernel(struct perf_event *event);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index dfc4bab0b02b..30474064ec22 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -354,15 +354,6 @@ static void event_function_local(struct perf_event *event, event_f func, void *d
 	(PERF_SAMPLE_BRANCH_KERNEL |\
 	 PERF_SAMPLE_BRANCH_HV)
 
-enum event_type_t {
-	EVENT_FLEXIBLE = 0x1,
-	EVENT_PINNED = 0x2,
-	EVENT_TIME = 0x4,
-	/* see ctx_resched() for details */
-	EVENT_CPU = 0x8,
-	EVENT_ALL = EVENT_FLEXIBLE | EVENT_PINNED,
-};
-
 /*
  * perf_sched_events : >0 events exist
  * perf_cgroup_events: >0 per-cpu cgroup events exist on this cpu
@@ -2477,6 +2468,15 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
 	perf_pmu_enable(cpuctx->ctx.pmu);
 }
 
+void perf_ctx_resched(struct perf_cpu_context *cpuctx,
+		      struct perf_event_context *task_ctx,
+		      enum event_type_t event_type)
+{
+	perf_ctx_lock(cpuctx, task_ctx);
+	ctx_resched(cpuctx, task_ctx, event_type);
+	perf_ctx_unlock(cpuctx, task_ctx);
+}
+
 /*
  * Cross CPU call to install and enable a performance event
  *
-- 
2.21.0.392.gf8f6787159e-goog

