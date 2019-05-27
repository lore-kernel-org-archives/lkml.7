Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7D6C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1EC21726
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfE0OOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 10:14:23 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57165 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfE0OOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 10:14:22 -0400
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x4RECPOj004246;
        Mon, 27 May 2019 23:12:25 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp);
 Mon, 27 May 2019 23:12:25 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x4RECNAa004233
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 27 May 2019 23:12:24 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] kernel/hung_task.c: Monitor killed tasks.
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Liu Chuansheng <chuansheng.liu@intel.com>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <1557745331-10367-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20190515105540.vyzh6n62rqi5imqv@pathway.suse.cz>
 <ee7501c6-d996-1684-1652-f0f838ba69c3@i-love.sakura.ne.jp>
 <20190516115758.6v7oitg3vbkfhh5j@pathway.suse.cz>
 <a3d9de97-46e8-aa43-1743-ebf66b434830@i-love.sakura.ne.jp>
Message-ID: <60d1d7f6-b201-3dcb-a51b-76a31bcfa919@i-love.sakura.ne.jp>
Date:   Mon, 27 May 2019 23:12:20 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <a3d9de97-46e8-aa43-1743-ebf66b434830@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, I updated description part. Please carry this patch.
----------
[PATCH] kernel/hung_task.c: Monitor killed tasks.

syzbot's current top report is "no output from test machine" where the
userspace process failed to spawn a new test process for 300 seconds
for some reason. One of reasons which can result in this report is that
an already spawned test process was unable to terminate (e.g. trapped at
an unkillable retry loop due to some bug) after SIGKILL was sent to that
process. Therefore, reporting when a thread is failing to terminate
despite a fatal signal is pending would give us more useful information.

In the context of syzbot's testing where there are only 2 CPUs in the
target VM (which means that only small number of threads and not so much
memory) and threads get SIGKILL after 5 seconds from fork(), being unable
to reach do_exit() within 10 seconds is likely a sign of something went
wrong. Therefore, I would like to try this patch in linux-next.git for
feasibility testing whether this patch helps finding more bugs and
reproducers for such bugs, by bringing "unable to terminate threads"
reports out of "no output from test machine" reports.

Potential bad effect of this patch will be that kernel code becomes
killable without addressing the root cause of being unable to terminate,
for use of killable wait will bypass both TASK_UNINTERRUPTIBLE stall test
and SIGKILL after 5 seconds behavior, which will result in failing to
detect in real systems where SIGKILL won't be sent after 5 seconds when
something went wrong.

This version shares existing sysctl settings (e.g. check interval,
timeout, whether to panic) used for detecting TASK_UNINTERRUPTIBLE
threads. We will likely want to use different sysctl settings for
monitoring killed threads. But let's start as linux-next.git patch
without introducing new sysctl settings. We can add sysctl settings
before sending to linux.git.

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

