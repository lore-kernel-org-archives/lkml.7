Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9789DC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732F3222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfKMK46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:56:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37341 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfKMK45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:56:57 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUqKR-0002Aw-W3; Wed, 13 Nov 2019 11:56:52 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AF9421C0092;
        Wed, 13 Nov 2019 11:56:51 +0100 (CET)
Date:   Wed, 13 Nov 2019 10:56:51 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] time: Rename tsk->real_start_time to ->start_boottime
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>
MIME-Version: 1.0
Message-ID: <157364261123.29376.12299028093344341153.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     cf25e24db61cc9df42c47485a2ec2bff4e9a3692
Gitweb:        https://git.kernel.org/tip/cf25e24db61cc9df42c47485a2ec2bff4e9a3692
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 07 Nov 2019 11:07:58 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 13 Nov 2019 11:09:49 +01:00

time: Rename tsk->real_start_time to ->start_boottime

Since it stores CLOCK_BOOTTIME, not, as the name suggests,
CLOCK_REALTIME, let's rename ->real_start_time to ->start_bootime.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 fs/exec.c             | 2 +-
 fs/proc/array.c       | 2 +-
 include/linux/sched.h | 2 +-
 kernel/fork.c         | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 555e93c..f4d0f3a 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1132,7 +1132,7 @@ static int de_thread(struct task_struct *tsk)
 		 * also take its birthdate (always earlier than our own).
 		 */
 		tsk->start_time = leader->start_time;
-		tsk->real_start_time = leader->real_start_time;
+		tsk->start_boottime = leader->start_boottime;
 
 		BUG_ON(!same_thread_group(leader, tsk));
 		BUG_ON(has_group_leader_pid(tsk));
diff --git a/fs/proc/array.c b/fs/proc/array.c
index 46dcb6f..5efaf37 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -533,7 +533,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	nice = task_nice(task);
 
 	/* convert nsec -> ticks */
-	start_time = nsec_to_clock_t(task->real_start_time);
+	start_time = nsec_to_clock_t(task->start_boottime);
 
 	seq_put_decimal_ull(m, "", pid_nr_ns(pid, ns));
 	seq_puts(m, " (");
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 67a1d86..2541289 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -857,7 +857,7 @@ struct task_struct {
 	u64				start_time;
 
 	/* Boot based time in nsecs: */
-	u64				real_start_time;
+	u64				start_boottime;
 
 	/* MM fault and swap info: this can arguably be seen as either mm-specific or thread-specific: */
 	unsigned long			min_flt;
diff --git a/kernel/fork.c b/kernel/fork.c
index bcdf531..1392ee8 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2130,7 +2130,7 @@ static __latent_entropy struct task_struct *copy_process(
 	 */
 
 	p->start_time = ktime_get_ns();
-	p->real_start_time = ktime_get_boottime_ns();
+	p->start_boottime = ktime_get_boottime_ns();
 
 	/*
 	 * Make it visible to the rest of the system, but dont wake it up yet.
