Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B14C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9589420578
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731612AbfIWO5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 10:57:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58798 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfIWO4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:56:47 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iCPld-0007aQ-R3; Mon, 23 Sep 2019 16:56:45 +0200
Message-Id: <20190923145528.563970313@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 23 Sep 2019 16:54:37 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Michael Kerrisk <mtk.manpages@googlemail.com>,
        Kees Cook <keescook@chromium.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [patch V2 2/6] posix-cpu-timers: Restrict clock_gettime() permissions
References: <20190923145435.507024424@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

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
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/posix-cpu-timers.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -76,8 +76,19 @@ static struct task_struct *lookup_task(c
 		 * Timers need the group leader because they take a
 		 * reference on it and store the task pointer until the
 		 * timer is destroyed.
+		 *
+		 * current can obviously access it's own process, so spare
+		 * the ptrace check below.
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


