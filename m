Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C461C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B65921848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731481AbfJINAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 09:00:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50928 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731330AbfJIM7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 08:59:34 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iIBYr-0002sn-OD; Wed, 09 Oct 2019 14:59:25 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A643A1C0322;
        Wed,  9 Oct 2019 14:59:20 +0200 (CEST)
Date:   Wed, 09 Oct 2019 12:59:20 -0000
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/vtime: Fix guest/system mis-accounting on task switch
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rik van Riel <riel@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wanpeng Li <wanpengli@tencent.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190925214242.21873-1-frederic@kernel.org>
References: <20190925214242.21873-1-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <157062596061.9978.8958739331326748237.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     68e7a4d66b0ce04bf18ff2ffded5596ab3618585
Gitweb:        https://git.kernel.org/tip/68e7a4d66b0ce04bf18ff2ffded5596ab3618585
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 25 Sep 2019 23:42:42 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 09 Oct 2019 12:38:03 +02:00

sched/vtime: Fix guest/system mis-accounting on task switch

vtime_account_system() assumes that the target task to account cputime
to is always the current task. This is most often true indeed except on
task switch where we call:

	vtime_common_task_switch(prev)
		vtime_account_system(prev)

Here prev is the scheduling-out task where we account the cputime to. It
doesn't match current that is already the scheduling-in task at this
stage of the context switch.

So we end up checking the wrong task flags to determine if we are
accounting guest or system time to the previous task.

As a result the wrong task is used to check if the target is running in
guest mode. We may then spuriously account or leak either system or
guest time on task switch.

Fix this assumption and also turn vtime_guest_enter/exit() to use the
task passed in parameter as well to avoid future similar issues.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wanpeng Li <wanpengli@tencent.com>
Fixes: 2a42eb9594a1 ("sched/cputime: Accumulate vtime on top of nsec clocksource")
Link: https://lkml.kernel.org/r/20190925214242.21873-1-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/cputime.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 2305ce8..46ed4e1 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -740,7 +740,7 @@ void vtime_account_system(struct task_struct *tsk)
 
 	write_seqcount_begin(&vtime->seqcount);
 	/* We might have scheduled out from guest path */
-	if (current->flags & PF_VCPU)
+	if (tsk->flags & PF_VCPU)
 		vtime_account_guest(tsk, vtime);
 	else
 		__vtime_account_system(tsk, vtime);
@@ -783,7 +783,7 @@ void vtime_guest_enter(struct task_struct *tsk)
 	 */
 	write_seqcount_begin(&vtime->seqcount);
 	__vtime_account_system(tsk, vtime);
-	current->flags |= PF_VCPU;
+	tsk->flags |= PF_VCPU;
 	write_seqcount_end(&vtime->seqcount);
 }
 EXPORT_SYMBOL_GPL(vtime_guest_enter);
@@ -794,7 +794,7 @@ void vtime_guest_exit(struct task_struct *tsk)
 
 	write_seqcount_begin(&vtime->seqcount);
 	vtime_account_guest(tsk, vtime);
-	current->flags &= ~PF_VCPU;
+	tsk->flags &= ~PF_VCPU;
 	write_seqcount_end(&vtime->seqcount);
 }
 EXPORT_SYMBOL_GPL(vtime_guest_exit);
