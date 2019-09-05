Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C47C3A5AB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE9B622CF7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389258AbfIEMML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 08:12:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42711 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388965AbfIEMMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:12:05 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i5qcO-0007tU-4l; Thu, 05 Sep 2019 14:12:04 +0200
Message-Id: <20190905120539.978233418@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 05 Sep 2019 14:03:43 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: [patch 4/6] posix-cpu-timers: Restrict clock_gettime() permissions
References: <20190905120339.561100423@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to creating timers on a process there is no restriction at all to
read the Posix CPU clocks of any process in the system. Per thread CPU
clock access is limited to threads in the same thread group.

The per process CPU clocks can be used to observe activity of tasks and
reading them can affect the execution of the process to which they are
attached as reading can require to lock sighand lock and sum up the fine
grained accounting for all threads in the process.

Restrict it by checking ptrace MODE_READ permissions of the reader on the
target process.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -71,9 +71,18 @@ static struct task_struct *lookup_task(c
 		/*
 		 * For clock_gettime() the task does not need to be the
 		 * actual group leader. tsk->sighand gives access to the
-		 * group's clock.
+		 * group's clock. current can obviously access itself, so
+		 * spare the ptrace check below.
 		 */
-		return (p == current || thread_group_leader(p)) ? p : NULL;
+		if (p == current)
+			return p;
+
+		if (!thread_group_leader(p))
+			return NULL;
+
+		if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
+			return NULL;
+		return p;
 	}
 
 	/*
@@ -92,9 +101,7 @@ static struct task_struct *lookup_task(c
 	 * Creating timers on processes which cannot be ptraced is not
 	 * permitted:
 	 */
-	if (!ptrace_may_access(p, PTRACE_MODE_ATTACH_REALCREDS))
-		return NULL;
-	return p;
+	return ptrace_may_access(p, PTRACE_MODE_ATTACH_REALCREDS) ? p : NULL;
 }
 
 static struct task_struct *__get_task_for_clock(const clockid_t clock,


