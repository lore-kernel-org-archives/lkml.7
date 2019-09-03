Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D9DC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A6B2077B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbfICPoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 11:44:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:21568 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728679AbfICPoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 11:44:01 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7A03F18C8919;
        Tue,  3 Sep 2019 15:44:00 +0000 (UTC)
Received: from flask (unknown [10.43.2.55])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5EEBE19C78;
        Tue,  3 Sep 2019 15:43:57 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Tue, 03 Sep 2019 17:43:56 +0200
From:   =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?q?Jirka=20Hladk=C3=BD?= <jhladky@redhat.com>,
        =?UTF-8?q?Ji=C5=99=C3=AD=20Voz=C3=A1r?= <jvozar@redhat.com>,
        x86@kernel.org
Subject: [PATCH 2/2] sched/debug: add sched_update_nr_running tracepoint
Date:   Tue,  3 Sep 2019 17:43:40 +0200
Message-Id: <20190903154340.860299-3-rkrcmar@redhat.com>
In-Reply-To: <20190903154340.860299-1-rkrcmar@redhat.com>
References: <20190903154340.860299-1-rkrcmar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Tue, 03 Sep 2019 15:44:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The paper "The Linux Scheduler: a Decade of Wasted Cores" used several
custom data gathering points to better understand what was going on in
the scheduler.
Red Hat adapted one of them for the tracepoint framework and created a
tool to plot a heatmap of nr_running, where the sched_update_nr_running
tracepoint is being used for fine grained monitoring of scheduling
imbalance.
The tool is available from https://github.com/jirvoz/plot-nr-running.

The best place for the tracepoints is inside the add/sub_nr_running,
which requires some shenanigans to make it work as they are defined
inside sched.h.
The tracepoints have to be included from sched.h, which means that
CREATE_TRACE_POINTS has to be defined for the whole header and this
might cause problems if tree-wide headers expose tracepoints in sched.h
dependencies, but I'd argue it's the other side's misuse of tracepoints.

Moving the import sched.h line lower would require fixes in s390 and ppc
headers, because they don't include dependecies properly and expect
sched.h to do it, so it is simpler to keep sched.h there and
preventively undefine CREATE_TRACE_POINTS right after.

Exports of the pelt tracepoints remain because they don't need to be
protected by CREATE_TRACE_POINTS and moving them closer would be
unsightly.

Tested-by: Jirka Hladký <jhladky@redhat.com>
Tested-by: Jiří Vozár <jvozar@redhat.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
---
 include/trace/events/sched.h | 22 ++++++++++++++++++++++
 kernel/sched/core.c          |  7 ++-----
 kernel/sched/fair.c          |  2 --
 kernel/sched/sched.h         |  7 +++++++
 4 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 420e80e56e55..1527fc695609 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -625,6 +625,28 @@ DECLARE_TRACE(sched_overutilized_tp,
 	TP_PROTO(struct root_domain *rd, bool overutilized),
 	TP_ARGS(rd, overutilized));
 
+TRACE_EVENT(sched_update_nr_running,
+
+	TP_PROTO(int cpu, int change, unsigned int nr_running),
+
+	TP_ARGS(cpu, change, nr_running),
+
+	TP_STRUCT__entry(
+		__field(int,          cpu)
+		__field(int,          change)
+		__field(unsigned int, nr_running)
+	),
+
+	TP_fast_assign(
+		__entry->cpu        = cpu;
+		__entry->change     = change;
+		__entry->nr_running = nr_running;
+	),
+
+	TP_printk("cpu=%u nr_running=%u (%d)",
+			__entry->cpu, __entry->nr_running, __entry->change)
+);
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 71981ce84231..31ac37b9f6f7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6,7 +6,9 @@
  *
  *  Copyright (C) 1991-2002  Linus Torvalds
  */
+#define CREATE_TRACE_POINTS
 #include "sched.h"
+#undef CREATE_TRACE_POINTS
 
 #include <linux/nospec.h>
 
@@ -20,9 +22,6 @@
 
 #include "pelt.h"
 
-#define CREATE_TRACE_POINTS
-#include <trace/events/sched.h>
-
 /*
  * Export tracepoints that act as a bare tracehook (ie: have no trace event
  * associated with them) to allow external modules to probe them.
@@ -7618,5 +7617,3 @@ const u32 sched_prio_to_wmult[40] = {
  /*  10 */  39045157,  49367440,  61356676,  76695844,  95443717,
  /*  15 */ 119304647, 148102320, 186737708, 238609294, 286331153,
 };
-
-#undef CREATE_TRACE_POINTS
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 84959d3285d1..421236d39902 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -22,8 +22,6 @@
  */
 #include "sched.h"
 
-#include <trace/events/sched.h>
-
 /*
  * Targeted preemption latency for CPU-bound tasks:
  *
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c4915f46035a..b89d7786109a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -75,6 +75,8 @@
 #include "cpupri.h"
 #include "cpudeadline.h"
 
+#include <trace/events/sched.h>
+
 #ifdef CONFIG_SCHED_DEBUG
 # define SCHED_WARN_ON(x)	WARN_ONCE(x, #x)
 #else
@@ -1887,6 +1889,8 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
 
 	rq->nr_running = prev_nr + count;
 
+	trace_sched_update_nr_running(cpu_of(rq), count, rq->nr_running);
+
 #ifdef CONFIG_SMP
 	if (prev_nr < 2 && rq->nr_running >= 2) {
 		if (!READ_ONCE(rq->rd->overload))
@@ -1900,6 +1904,9 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
 static inline void sub_nr_running(struct rq *rq, unsigned count)
 {
 	rq->nr_running -= count;
+
+	trace_sched_update_nr_running(cpu_of(rq), -count, rq->nr_running);
+
 	/* Check if we still need preemption */
 	sched_update_tick_dependency(rq);
 }
-- 
2.23.0

