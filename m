Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AB6C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C097A206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fK544FAF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbfDDSc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:32:29 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:42543 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729856AbfDDSc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:32:28 -0400
Received: by mail-pg1-f201.google.com with SMTP id n5so2086608pgk.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 11:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eNh4bKb9Fo6fPg5Yrnkt9fE2hVfVtAypUrnQ6R5YeIA=;
        b=fK544FAFlMdZzX/vdrmL58DtFVoD/52XBfXAKarXpymHvZ4oXo92IbJdTemqLcH8vm
         2K17ZogkvsqUlJ023OR79vJbv18Y6ukHNoFiau1xPvW3ror7ewObBo3ZWRcMhzXYPpHz
         5iEZ4aZkXM7TPzR3gRn3Q3NuI5+OBERsdj2wNUUNoDYR3pSEapRP98lftTQgv9KUWUit
         uDUVP/y5SUG7hyiggX4t+qQPPYO4ypKNCduaRXYY4rx2V7GVpQe1Z38TvD+zYM1yzTFd
         I9G7j4BYzvSZpniTt5pG0RKoIlRC8JhudHrsQuh/bpyUDjJ6lBt+o4g7HA8JVcVpLHPc
         8IMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eNh4bKb9Fo6fPg5Yrnkt9fE2hVfVtAypUrnQ6R5YeIA=;
        b=ERPSXbWBgYb2jMYrX1v90jeXkf1bHdYjzr/iKrHFeFwyIoZ1gm7mB4+gMsy60OFMIn
         fycmEZh0FChgQEFEJpt93RtRSOnZhGSRQv3vXw7A+ocIWlfMplzNfvTa2N25mWxWS8pq
         34t5cliCUpAOV6AVYacIwQXKrthgo+GINMPDRwOvo9MaiUupVd/UB/CCo/nmG3HqE7Pz
         brMoJLfY+feYrAQgkPJa1YDnvqrbBKRc4Te9xnnEQv4Pu1lYZA9ACfvUxUcWm74xBJ76
         +0JUgp+YfhjI8VmhfNGPkLq8c4pQhiXscyXLOj7qfYdDl2oS8Vomc66jhlIWzst1tf8X
         j7JQ==
X-Gm-Message-State: APjAAAWOYa598fHga0/z7SB/c85I2rR9d3qIcvcuwYAlpM7lRh/BIQot
        Y1OS7czFD/Nt1ehrMSxlQgBRThwGDfMyJNWTdFRFFTHgWXZB1IEvIsaMywXklfzjjOlzIgz5P3w
        U1i/pj9SY1ZWhbNyRjuJGdiHc+7xfNFL6gYbQTcN8YV673IoF3by+HQ1BM87oy3F5rQAk2jE+
X-Google-Smtp-Source: APXvYqzlzKoFQBNkI1leP7rNWnR6XwqqhLqS05mZcFqcIOyIPMc/Ns8zGjS5gtpNezdgejqXMhy2VWlYj0JR
X-Received: by 2002:a63:6786:: with SMTP id b128mr226813pgc.122.1554402747173;
 Thu, 04 Apr 2019 11:32:27 -0700 (PDT)
Date:   Thu,  4 Apr 2019 11:32:18 -0700
In-Reply-To: <20190404183219.125083-1-eranian@google.com>
Message-Id: <20190404183219.125083-3-eranian@google.com>
Mime-Version: 1.0
References: <20190404183219.125083-1-eranian@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 2/3] perf/core: make ctx_resched() a global function
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

This patch renames ctx_resched() to perf_ctx_resched() and makes
the function globally accessible. This is to prepare for the next
patch which needs to call this function from arch specific code.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 include/linux/perf_event.h | 12 ++++++++++++
 kernel/events/core.c       | 21 ++++++---------------
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 514de997696b..150cfd493ad2 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -829,6 +829,15 @@ struct bpf_perf_event_data_kern {
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
@@ -895,6 +904,9 @@ extern void perf_sched_cb_dec(struct pmu *pmu);
 extern void perf_sched_cb_inc(struct pmu *pmu);
 extern int perf_event_task_disable(void);
 extern int perf_event_task_enable(void);
+extern void perf_ctx_resched(struct perf_cpu_context *cpuctx,
+			struct perf_event_context *task_ctx,
+			enum event_type_t event_type);
 extern int perf_event_refresh(struct perf_event *event, int refresh);
 extern void perf_event_update_userpage(struct perf_event *event);
 extern int perf_event_release_kernel(struct perf_event *event);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 429bf6d8be95..48b955a2b7f1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -338,15 +338,6 @@ static void event_function_local(struct perf_event *event, event_f func, void *d
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
@@ -2430,9 +2421,9 @@ static void perf_event_sched_in(struct perf_cpu_context *cpuctx,
  * event_type is a bit mask of the types of events involved. For CPU events,
  * event_type is only either EVENT_PINNED or EVENT_FLEXIBLE.
  */
-static void ctx_resched(struct perf_cpu_context *cpuctx,
-			struct perf_event_context *task_ctx,
-			enum event_type_t event_type)
+void perf_ctx_resched(struct perf_cpu_context *cpuctx,
+		      struct perf_event_context *task_ctx,
+		      enum event_type_t event_type)
 {
 	enum event_type_t ctx_event_type;
 	bool cpu_event = !!(event_type & EVENT_CPU);
@@ -2520,7 +2511,7 @@ static int  __perf_install_in_context(void *info)
 	if (reprogram) {
 		ctx_sched_out(ctx, cpuctx, EVENT_TIME);
 		add_event_to_ctx(event, ctx);
-		ctx_resched(cpuctx, task_ctx, get_event_type(event));
+		perf_ctx_resched(cpuctx, task_ctx, get_event_type(event));
 	} else {
 		add_event_to_ctx(event, ctx);
 	}
@@ -2664,7 +2655,7 @@ static void __perf_event_enable(struct perf_event *event,
 	if (ctx->task)
 		WARN_ON_ONCE(task_ctx != ctx);
 
-	ctx_resched(cpuctx, task_ctx, get_event_type(event));
+	perf_ctx_resched(cpuctx, task_ctx, get_event_type(event));
 }
 
 /*
@@ -3782,7 +3773,7 @@ static void perf_event_enable_on_exec(int ctxn)
 	 */
 	if (enabled) {
 		clone_ctx = unclone_ctx(ctx);
-		ctx_resched(cpuctx, ctx, event_type);
+		perf_ctx_resched(cpuctx, ctx, event_type);
 	} else {
 		ctx_sched_in(ctx, cpuctx, EVENT_TIME, current);
 	}
-- 
2.21.0.392.gf8f6787159e-goog

