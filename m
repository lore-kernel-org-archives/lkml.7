Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C94C10F06
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 01:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5A621872
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 01:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfDDBhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 21:37:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbfDDBhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 21:37:47 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16E7D21850;
        Thu,  4 Apr 2019 01:37:47 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hBrK6-00055C-6Q; Wed, 03 Apr 2019 21:37:46 -0400
Message-Id: <20190404013746.085272166@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 03 Apr 2019 21:37:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [for-next][PATCH 18/19] sched/fair: do not expose some tracepoints to user if
 CONFIG_SCHEDSTATS is not set
References: <20190404013721.023858792@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yafang Shao <laoar.shao@gmail.com>

The tracepoints trace_sched_stat_{iowait, blocked, wait, sleep} should
be not exposed to user if CONFIG_SCHEDSTATS is not set.

Link: http://lkml.kernel.org/r/1553602391-11926-3-git-send-email-laoar.shao@gmail.com

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/trace/events/sched.h | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 9a4bdfadab07..c8c7c7efb487 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -241,7 +241,6 @@ DECLARE_EVENT_CLASS(sched_process_template,
 DEFINE_EVENT(sched_process_template, sched_process_free,
 	     TP_PROTO(struct task_struct *p),
 	     TP_ARGS(p));
-	     
 
 /*
  * Tracepoint for a task exiting:
@@ -336,11 +335,20 @@ TRACE_EVENT(sched_process_exec,
 		  __entry->pid, __entry->old_pid)
 );
 
+
+#ifdef CONFIG_SCHEDSTATS
+#define DEFINE_EVENT_SCHEDSTAT DEFINE_EVENT
+#define DECLARE_EVENT_CLASS_SCHEDSTAT DECLARE_EVENT_CLASS
+#else
+#define DEFINE_EVENT_SCHEDSTAT DEFINE_EVENT_NOP
+#define DECLARE_EVENT_CLASS_SCHEDSTAT DECLARE_EVENT_CLASS_NOP
+#endif
+
 /*
  * XXX the below sched_stat tracepoints only apply to SCHED_OTHER/BATCH/IDLE
  *     adding sched_stat support to SCHED_FIFO/RR would be welcome.
  */
-DECLARE_EVENT_CLASS(sched_stat_template,
+DECLARE_EVENT_CLASS_SCHEDSTAT(sched_stat_template,
 
 	TP_PROTO(struct task_struct *tsk, u64 delay),
 
@@ -363,12 +371,11 @@ DECLARE_EVENT_CLASS(sched_stat_template,
 			(unsigned long long)__entry->delay)
 );
 
-
 /*
  * Tracepoint for accounting wait time (time the task is runnable
  * but not actually running due to scheduler contention).
  */
-DEFINE_EVENT(sched_stat_template, sched_stat_wait,
+DEFINE_EVENT_SCHEDSTAT(sched_stat_template, sched_stat_wait,
 	     TP_PROTO(struct task_struct *tsk, u64 delay),
 	     TP_ARGS(tsk, delay));
 
@@ -376,7 +383,7 @@ DEFINE_EVENT(sched_stat_template, sched_stat_wait,
  * Tracepoint for accounting sleep time (time the task is not runnable,
  * including iowait, see below).
  */
-DEFINE_EVENT(sched_stat_template, sched_stat_sleep,
+DEFINE_EVENT_SCHEDSTAT(sched_stat_template, sched_stat_sleep,
 	     TP_PROTO(struct task_struct *tsk, u64 delay),
 	     TP_ARGS(tsk, delay));
 
@@ -384,14 +391,14 @@ DEFINE_EVENT(sched_stat_template, sched_stat_sleep,
  * Tracepoint for accounting iowait time (time the task is not runnable
  * due to waiting on IO to complete).
  */
-DEFINE_EVENT(sched_stat_template, sched_stat_iowait,
+DEFINE_EVENT_SCHEDSTAT(sched_stat_template, sched_stat_iowait,
 	     TP_PROTO(struct task_struct *tsk, u64 delay),
 	     TP_ARGS(tsk, delay));
 
 /*
  * Tracepoint for accounting blocked time (time the task is in uninterruptible).
  */
-DEFINE_EVENT(sched_stat_template, sched_stat_blocked,
+DEFINE_EVENT_SCHEDSTAT(sched_stat_template, sched_stat_blocked,
 	     TP_PROTO(struct task_struct *tsk, u64 delay),
 	     TP_ARGS(tsk, delay));
 
-- 
2.20.1


