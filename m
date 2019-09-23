Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35025C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1365820578
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731511AbfIWO4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 10:56:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58806 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfIWO4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:56:48 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iCPle-0007aX-7f; Mon, 23 Sep 2019 16:56:46 +0200
Message-Id: <20190923145528.672384201@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 23 Sep 2019 16:54:38 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Michael Kerrisk <mtk.manpages@googlemail.com>,
        Kees Cook <keescook@chromium.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [patch V2 3/6] posix-cpu-timers: Sanitize thread clock permissions
References: <20190923145435.507024424@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The thread clock permissions are restricted to tasks of the same thread
group, but that also prevents a ptracer from reading them. This is
inconsistent vs. the process restrictions and unnecessary strict.

Relax it to ptrace permissions in the same way as process permissions are
handled.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/posix-cpu-timers.c |   66 +++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 34 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -51,6 +51,7 @@ void update_rlimit_cpu(struct task_struc
 static struct task_struct *lookup_task(const pid_t pid, bool thread,
 				       bool gettime)
 {
+	unsigned int mode = PTRACE_MODE_ATTACH_REALCREDS;
 	struct task_struct *p;
 
 	/*
@@ -64,50 +65,47 @@ static struct task_struct *lookup_task(c
 	if (!p)
 		return p;
 
-	if (thread)
-		return same_thread_group(p, current) ? p : NULL;
-
 	if (gettime) {
 		/*
-		 * For clock_gettime(PROCESS) the task does not need to be
-		 * the actual group leader. tsk->sighand gives
-		 * access to the group's clock.
-		 *
-		 * Timers need the group leader because they take a
-		 * reference on it and store the task pointer until the
-		 * timer is destroyed.
+		 * For clock_gettime() the task does not need to be the
+		 * actual group leader. tsk->sighand gives access to the
+		 * group's clock.
 		 *
-		 * current can obviously access it's own process, so spare
-		 * the ptrace check below.
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
+		 * Process wide timers need the group leader because they
+		 * take a reference on it and store the task pointer until
+		 * the timer is destroyed.
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


