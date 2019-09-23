Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A795AC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CDE220578
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbfIWO5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 10:57:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58810 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731270AbfIWO4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:56:48 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iCPle-0007ae-Mn; Mon, 23 Sep 2019 16:56:46 +0200
Message-Id: <20190923145528.764987925@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 23 Sep 2019 16:54:39 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Michael Kerrisk <mtk.manpages@googlemail.com>,
        Kees Cook <keescook@chromium.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [patch V2 4/6] posix-cpu-timers: Make PID=0 and PID=self handling
 consistent
References: <20190923145435.507024424@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

If the PID encoded into the clock id is 0 then the target is either the
calling thread itself or the process to which it belongs.

If the current thread encodes its own PID on a process wide clock then
there is no reason not to treat it in the same way as the PID=0 case.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
V2: Remove the extra same_thread_group() check which is pointless.
---
 kernel/time/posix-cpu-timers.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -90,18 +90,20 @@ static struct task_struct *lookup_task(c
 
 	} else {
 		/*
+		 * Timer is going to be attached to a process. If p is
+		 * current then treat it like the PID=0 case above.
+		 * This also avoids the ptrace overhead.
+		 */
+		if (p == current)
+			return current->group_leader;
+
+		/*
 		 * Process wide timers need the group leader because they
 		 * take a reference on it and store the task pointer until
 		 * the timer is destroyed.
 		 */
 		if (!has_group_leader_pid(p))
 			return NULL;
-
-		/*
-		 * Avoid the ptrace overhead when this is current's process
-		 */
-		if (same_thread_group(p, current))
-			return p;
 	}
 
 	/* Decide based on the ptrace permissions. */


