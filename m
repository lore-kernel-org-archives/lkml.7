Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3810BC04AA7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 00:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F174521734
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 00:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxJ9TlLk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfENA2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 20:28:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44267 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfENA2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 20:28:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id z16so7608043pgv.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 17:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x998HJP6yTeSX0H7oOalYbftz/zFJskWtIaT8WJR4UA=;
        b=kxJ9TlLkY4+D2qLFVc+Yno7zIjtAnOHaEOVUoM4zoGdIqkEKb7QZLkDKOTcgTT0+g9
         ZXaFD9rjBxznjOIWf0MC1VIrW0IRE8KnLj6O+egXHAgHWjdKSwTpNJnvHjLndhXTsY9J
         I7AdX2x+QkqiOi4Clm5kex0FtRqZT6TfXu75JEctNhVPjpJqX4L6ENL/CBeTvB6PfPFk
         xGFIEpsYpcuZRYj3uxnO740SaLMiMtaTXvceZrjx2JHBNXBSNAuQiLtwx/RTQFIno2Ys
         GnCxVCoJ6MALYYP6k7NbdvHtuMW+hhl0uGV5j+18eixL5tmbgzEuIOQ7sLOrymq5E//t
         LIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x998HJP6yTeSX0H7oOalYbftz/zFJskWtIaT8WJR4UA=;
        b=chLWbmZdNPNAN0LKjNHx8KOks4hY34372GBI2hXlnfjLIW+OFj+6UDCxTVqEodo7nH
         OHQzBwG7Yo46XZYZqPvBHZ2Nutn9JhvSTCkHERPHBAwofSaN1A49jcbBa0rKidk6dxiD
         ON+ifWLNbdo/HdgHiLSwoMgW8E0cklGxRAsmO7czTOB5JpVhkzMXhQc2WzXX+sDLdRBc
         GTJt9QIx7UMLOtTGfnqxH8EZZpknH9fmd47DYJQBgb3UAfsHPqc0ZFOjCmbRy/El19X9
         HpRI3pKQTnL8AOvLArsAZU7n48H422ER9wRK9uV5ODDjTDJoj5apNMItv+YmhMFghT+r
         QrKA==
X-Gm-Message-State: APjAAAUdc+M7iUX4W2RESveIzvHezR93cekhCGher3aTGQ8CUnI4hNz+
        jbnxdq4XXbeM5OfHBdd04K0Q68H6
X-Google-Smtp-Source: APXvYqwtAKuVxu7zU5o2CNuW8dmNlPYNhmBTbxLx/XKvTEKlz4JygkgsmsYvfJ/MJ9sLKMjriqXJtQ==
X-Received: by 2002:a62:e718:: with SMTP id s24mr37531935pfh.247.1557793719284;
        Mon, 13 May 2019 17:28:39 -0700 (PDT)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
        by smtp.gmail.com with ESMTPSA id s18sm4535805pgg.64.2019.05.13.17.28.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 17:28:38 -0700 (PDT)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [RFC Patch] perf_event: fix a cgroup switch warning
Date:   Mon, 13 May 2019 17:27:47 -0700
Message-Id: <20190514002747.7047-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have been consistently triggering the warning
WARN_ON_ONCE(cpuctx->cgrp) in perf_cgroup_switch() for a rather
long time, although we still have no clue on how to reproduce it.

Looking into the code, it seems the only possibility here is that
the process calling perf_event_open() with a cgroup target exits
before the process in the target cgroup exits but after it gains
CPU to run. This is because we use the atomic counter
perf_cgroup_events as an indication of whether cgroup perf event
has enabled or not, which is inaccurate, illustrated as below:

CPU 0					CPU 1
// open perf events with a cgroup
// target for all CPU's
perf_event_open():
  account_event_cpu()
  // perf_cgroup_events == 1
				// Schedule in a process in the target cgroup
				perf_cgroup_switch()
perf_event_release_kernel():
  unaccount_event_cpu()
  // perf_cgroup_events == 0
				// schedule out
				// but perf_cgroup_sched_out() is skipped
				// cpuctx->cgrp left as non-NULL

				// schedule in another process
				perf_cgroup_switch() // WARN triggerred

The proposed fix is kinda ugly, as it adds a flag in each process to
indicate whether this process has to go through perf_cgroup_sched_out()
when perf_cgroup_events is false negative. The other possible fix is
to force a reschedule on each target CPU before decreasing the counter
perf_cgroup_events, but this is expensive.

Suggestions? Thoughts?

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 include/linux/sched.h | 3 +++
 kernel/events/core.c  | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index a2cd15855bad..835bdf15f92c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -733,6 +733,9 @@ struct task_struct {
 	/* to be used once the psi infrastructure lands upstream. */
 	unsigned			use_memdelay:1;
 #endif
+#ifdef CONFIG_PERF_EVENTS
+	unsigned			perf_cgroup_sched_in:1;
+#endif
 
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index abbd4b3b96c2..9b86b043018e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -817,6 +817,7 @@ static void perf_cgroup_switch(struct task_struct *task, int mode)
 			 * to event_filter_match() in event_sched_out()
 			 */
 			cpuctx->cgrp = NULL;
+			task->perf_cgroup_sched_in = 0;
 		}
 
 		if (mode & PERF_CGROUP_SWIN) {
@@ -831,6 +832,7 @@ static void perf_cgroup_switch(struct task_struct *task, int mode)
 			cpuctx->cgrp = perf_cgroup_from_task(task,
 							     &cpuctx->ctx);
 			cpu_ctx_sched_in(cpuctx, EVENT_ALL, task);
+			task->perf_cgroup_sched_in = 1;
 		}
 		perf_pmu_enable(cpuctx->ctx.pmu);
 		perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
@@ -3233,7 +3235,8 @@ void __perf_event_task_sched_out(struct task_struct *task,
 	 * to check if we have to switch out PMU state.
 	 * cgroup event are system-wide mode only
 	 */
-	if (atomic_read(this_cpu_ptr(&perf_cgroup_events)))
+	if (atomic_read(this_cpu_ptr(&perf_cgroup_events)) ||
+	    task->perf_cgroup_sched_in)
 		perf_cgroup_sched_out(task, next);
 }
 
-- 
2.21.0

