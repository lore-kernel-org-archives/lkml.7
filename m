Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDC5C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 638DC22CF7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389270AbfIEMMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 08:12:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42716 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389219AbfIEMMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:12:06 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i5qcO-0007tc-K6; Thu, 05 Sep 2019 14:12:04 +0200
Message-Id: <20190905120540.068959005@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 05 Sep 2019 14:03:44 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: [patch 5/6] posix-cpu-timers: Sanitize thread clock permissions
References: <20190905120339.561100423@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thread clock permissions are restricted to tasks of the same thread
group, but that also prevents a ptracer from reading them. This is
inconsistent vs. the process restrictions and unnecessary strict.

Relax it to ptrace permissions in the same way as process permissions are
handled.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |   56 +++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 27 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -51,6 +51,7 @@ void update_rlimit_cpu(struct task_struc
 static struct task_struct *lookup_task(const pid_t pid, bool thread,
 				       bool gettime)
 {
+	unsigned int mode = PTRACE_MODE_ATTACH_REALCREDS;
 	struct task_struct *p;
 
 	/*
@@ -64,44 +65,45 @@ static struct task_struct *lookup_task(c
 	if (!p)
 		return p;
 
-	if (thread)
-		return same_thread_group(p, current) ? p : NULL;
-
 	if (gettime) {
 		/*
 		 * For clock_gettime() the task does not need to be the
 		 * actual group leader. tsk->sighand gives access to the
-		 * group's clock. current can obviously access itself, so
-		 * spare the ptrace check below.
+		 * group's clock.
+		 *
+		 * The trivial case is that p is current or in the same
+		 * thread group, i.e. sharing p->signal. Spare the ptrace
+		 * check in that case.
 		 */
-		if (p == current)
+		if (same_thread_group(p, current))
 			return p;
 
-		if (!thread_group_leader(p))
-			return NULL;
+		mode = PTRACE_MODE_READ_REALCREDS;
 
-		if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
-			return NULL;
-		return p;
-	}
+	} else if (thread) {
+		/*
+		 * Timer is going to be attached to a thread. If p is
+		 * current or in the same thread group, granted.
+		 */
+		if (same_thread_group(p, current))
+			return p;
 
-	/*
-	 * For processes require that p is group leader.
-	 */
-	if (!has_group_leader_pid(p))
-		return NULL;
+	} else {
+		/*
+		 * For processes require that p is group leader.
+		 */
+		if (!has_group_leader_pid(p))
+			return NULL;
 
-	/*
-	 * Avoid the ptrace overhead when this is current's process
-	 */
-	if (same_thread_group(p, current))
-		return p;
+		/*
+		 * Avoid the ptrace overhead when this is current's process
+		 */
+		if (same_thread_group(p, current))
+			return p;
+	}
 
-	/*
-	 * Creating timers on processes which cannot be ptraced is not
-	 * permitted:
-	 */
-	return ptrace_may_access(p, PTRACE_MODE_ATTACH_REALCREDS) ? p : NULL;
+	/* Decide based on the ptrace permissions. */
+	return ptrace_may_access(p, mode) ? p : NULL;
 }
 
 static struct task_struct *__get_task_for_clock(const clockid_t clock,


