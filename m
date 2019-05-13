Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9F6C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B721E20879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbfEMLEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 07:04:06 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:54151 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbfEMLEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 07:04:06 -0400
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x4DB2aWk054153;
        Mon, 13 May 2019 20:02:36 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp);
 Mon, 13 May 2019 20:02:36 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x4DB2SWl054088
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 13 May 2019 20:02:36 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Petr Mladek <pmladek@suse.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Liu Chuansheng" <chuansheng.liu@intel.com>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH] kernel/hung_task.c: Monitor killed tasks.
Date:   Mon, 13 May 2019 20:02:11 +0900
Message-Id: <1557745331-10367-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot's second top report is "no output from test machine" where the
userspace process failed to spawn a new test process for 300 seconds
for some reason. One of reasons which can result in this report is that
an already spawned test process was unable to terminate (e.g. trapped at
an unkillable retry loop due to some bug) after SIGKILL was sent to that
process. Therefore, reporting when a thread is failing to terminate
despite a fatal signal is pending would give us more useful information.

This version shares existing sysctl settings (e.g. check interval,
timeout, whether to panic) used for detecting TASK_UNINTERRUPTIBLE
threads, for I don't know whether people want to use a new kernel
config option and different sysctl settings for monitoring killed
threads.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
 include/linux/sched.h |  1 +
 kernel/hung_task.c    | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index a2cd1585..d42bdd7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -850,6 +850,7 @@ struct task_struct {
 #ifdef CONFIG_DETECT_HUNG_TASK
 	unsigned long			last_switch_count;
 	unsigned long			last_switch_time;
+	unsigned long			killed_time;
 #endif
 	/* Filesystem information: */
 	struct fs_struct		*fs;
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index f108a95..34e7b84 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -141,6 +141,47 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 	touch_nmi_watchdog();
 }
 
+static void check_killed_task(struct task_struct *t, unsigned long timeout)
+{
+	unsigned long stamp = t->killed_time;
+
+	/*
+	 * Ensure the task is not frozen.
+	 * Also, skip vfork and any other user process that freezer should skip.
+	 */
+	if (unlikely(t->flags & (PF_FROZEN | PF_FREEZER_SKIP)))
+		return;
+	/*
+	 * Skip threads which are already inside do_exit(), for exit_mm() etc.
+	 * might take many seconds.
+	 */
+	if (t->flags & PF_EXITING)
+		return;
+	if (!stamp) {
+		stamp = jiffies;
+		if (!stamp)
+			stamp++;
+		t->killed_time = stamp;
+		return;
+	}
+	if (time_is_after_jiffies(stamp + timeout * HZ))
+		return;
+	trace_sched_process_hang(t);
+	if (sysctl_hung_task_panic) {
+		console_verbose();
+		hung_task_call_panic = true;
+	}
+	/*
+	 * This thread failed to terminate for more than
+	 * sysctl_hung_task_timeout_secs seconds, complain:
+	 */
+	pr_err("INFO: task %s:%d can't die for more than %ld seconds.\n",
+	       t->comm, t->pid, (jiffies - stamp) / HZ);
+	sched_show_task(t);
+	hung_task_show_lock = true;
+	touch_nmi_watchdog();
+}
+
 /*
  * To avoid extending the RCU grace period for an unbounded amount of time,
  * periodically exit the critical section and enter a new one.
@@ -192,6 +233,9 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 				goto unlock;
 			last_break = jiffies;
 		}
+		/* Check threads which are about to terminate. */
+		if (unlikely(fatal_signal_pending(t)))
+			check_killed_task(t, timeout);
 		/* use "==" to skip the TASK_KILLABLE tasks waiting on NFS */
 		if (t->state == TASK_UNINTERRUPTIBLE)
 			check_hung_task(t, timeout);
-- 
1.8.3.1

