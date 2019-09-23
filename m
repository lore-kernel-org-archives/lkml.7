Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11DCC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC5E20835
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbfIWO4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 10:56:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58796 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbfIWO4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:56:47 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iCPld-0007aN-Dt; Mon, 23 Sep 2019 16:56:45 +0200
Message-Id: <20190923145528.473070168@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 23 Sep 2019 16:54:36 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Michael Kerrisk <mtk.manpages@googlemail.com>,
        Kees Cook <keescook@chromium.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [patch V2 1/6] posix-cpu-timers: Restrict timer_create() permissions
References: <20190923145435.507024424@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Right now there is no restriction at all to attach a Posix CPU timer to any
process in the system. Per thread CPU timers are limited to be created by
threads in the same thread group.

Timers can be used to observe activity of tasks and also impose overhead on
the process to which they are attached because that process needs to do the
fine grained CPU time accounting.

Limit the ability to attach timers to a process by checking whether the
task which is creating the timer has permissions to attach ptrace on the
target process.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

---
 kernel/time/posix-cpu-timers.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -6,6 +6,7 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/cputime.h>
 #include <linux/posix-timers.h>
+#include <linux/ptrace.h>
 #include <linux/errno.h>
 #include <linux/math64.h>
 #include <linux/uaccess.h>
@@ -82,7 +83,20 @@ static struct task_struct *lookup_task(c
 	/*
 	 * For processes require that p is group leader.
 	 */
-	return has_group_leader_pid(p) ? p : NULL;
+	if (!has_group_leader_pid(p))
+		return NULL;
+
+	/*
+	 * Avoid the ptrace overhead when this is current's process
+	 */
+	if (same_thread_group(p, current))
+		return p;
+
+	/*
+	 * Creating timers on processes which cannot be ptraced is not
+	 * permitted:
+	 */
+	return ptrace_may_access(p, PTRACE_MODE_ATTACH_REALCREDS) ? p : NULL;
 }
 
 static struct task_struct *__get_task_for_clock(const clockid_t clock,


