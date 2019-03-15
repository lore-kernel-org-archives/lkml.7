Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C06C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5336721871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbfCOKtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 06:49:46 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:46126 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfCOKtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 06:49:45 -0400
Received: from fsav109.sakura.ne.jp (fsav109.sakura.ne.jp [27.133.134.236])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x2FAnh2W068575;
        Fri, 15 Mar 2019 19:49:43 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav109.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav109.sakura.ne.jp);
 Fri, 15 Mar 2019 19:49:43 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav109.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x2FAnXmx068402
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 15 Mar 2019 19:49:43 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC PATCH] printk: Introduce "store now but print later" prefix.
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Calvin Owens <calvinowens@fb.com>
References: <6b97b4bb-a9b9-75b3-17a2-bff99ae7c526@i-love.sakura.ne.jp>
 <20190304142339.mfno5mmjxxsrf47q@pathway.suse.cz>
 <201903050123.x251N312025685@www262.sakura.ne.jp>
 <20190306100404.jzfk7oqsh3turqth@pathway.suse.cz>
 <0fc95fee-8b6e-5ff0-9a91-9e0ea66028f3@i-love.sakura.ne.jp>
Message-ID: <87e0aa0e-b30a-c373-8682-c920e1df7275@i-love.sakura.ne.jp>
Date:   Fri, 15 Mar 2019 19:49:35 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <0fc95fee-8b6e-5ff0-9a91-9e0ea66028f3@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/03/07 3:24, Tetsuo Handa wrote:
> On 2019/03/06 19:04, Petr Mladek wrote:
> I'm planning to allow any shared functions which can be called from e.g.
> warn_alloc(), out_of_memory(), SysRq-t by allowing such shared functions
> to accept loglevel argument.

Calvin Owens is proposing "printk: Introduce per-console loglevel setting"
which will allow reducing overall sequential call_console_drivers() delay.

> 
>>
>> For this reason, this API is a "no no no" from my side.
>>
> 
> There are two types of printk() data. One is "small/short messages but
> partial/incomplete line (even if a few bytes) might be helpful" and
> the other is "large/long messages but partial/incomplete line is hardly
> helpful". The former uses "sync printk()s" and the latter uses "async
> printk()s followed by a sync printk()". And this API is powerful for the
> latter type which are called by for_each_*() pattern (e.g. dump_tasks()).

I am proposing "printk: Introduce "store now but print later" prefix."
which will allow deferring call_console_drivers() until the caller leaves
critical sections.

> 
>>
>> I am open to bring back discussions about a forced offload when
>> a single task is blocked in console_unlock() for too long.
> 
> This is a matter of adding hints for judging which thread
> (console_owner or console_waiter) should continue printing.

And the patch shown bottom is an example of

  we could add hints for judging which thread (console_owner or
  console_waiter) should continue printing

tuning. It is "mostly offload" rather than "forced offload".

>>     + They might improve situation in one workload and make it
>>       worse in another one.
> 
> Avoiding e.g. RCU stall / OOM stall by deferring write to consoles is
> an improvement. Reducing the side effect of accumulated pending logs
> is matters of "how we can try to offload to an idle thread (or utilize
> idle CPUs) for writing to consoles" and "how we can try to ratelimit
> appropriately".
> 
> To me, none of these concerns is a valid reason to keep "store now but
> print later" prefix away.

In "Re: [PATCH v10 1/2] printk: Make printk() completely async" at
https://lkml.kernel.org/r/20160404155149.a3e3307def2d1315e2099c63@linux-foundation.org ,
Andrew Morton said

  The whole idea remains worrisome.

but I couldn't find the reason which still holds true. We already have
"printk: Console owner and waiter logic cleanup" which allows us to put
some limit on the number of characters which the printing task will print.

Worrying memory corruption sounds strange. What if memory parity error
inverted one bit of the address stored in log_buf, or inverted one bit of
the records stored in log_buf region? There are inevitable cases where
printk() can't survive memory corruption.

Forcing all messages to be offloaded might be bad. But I think that
allowing caller specified messages (i.e. "large/long messages but
partial/incomplete line is hardly helpful" case) to be offloaded
when possible is fine.

With these patches, apart from the console driver's locking dependency
problem remains, I think that we can reasonably avoid stalls caused by
flood of printk() from critical sections.

---
 kernel/printk/printk.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 81 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 6b7654b..e1591dd 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -47,6 +47,7 @@
 #include <linux/sched/clock.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/task_stack.h>
+#include <linux/kthread.h>
 
 #include <linux/uaccess.h>
 #include <asm/sections.h>
@@ -1616,6 +1617,12 @@ int do_syslog(int type, char __user *buf, int len, int source)
 static DEFINE_RAW_SPINLOCK(console_owner_lock);
 static struct task_struct *console_owner;
 static bool console_waiter;
+static struct task_struct *console_writer;
+
+static void console_writer_work_func(struct irq_work *irq_work)
+{
+	wake_up_process(console_writer);
+}
 
 /**
  * console_lock_spinning_enable - mark beginning of code where another
@@ -1703,7 +1710,7 @@ static int console_trylock_spinning(void)
 	raw_spin_lock(&console_owner_lock);
 	owner = READ_ONCE(console_owner);
 	waiter = READ_ONCE(console_waiter);
-	if (!waiter && owner && owner != current) {
+	if (!waiter && owner && owner != current && owner != console_writer) {
 		WRITE_ONCE(console_waiter, true);
 		spin = true;
 	}
@@ -1960,6 +1967,33 @@ asmlinkage int vprintk_emit(int facility, int level,
 	/* If called from the scheduler, we can not call up(). */
 	if (!in_sched && pending_output) {
 		/*
+		 * Try to wake up the console printing intercepting kernel
+		 * thread which tries to hand over from process context.
+		 *
+		 * If current thread can call wake_up_process(), we can wake up
+		 * the thread on any CPU which is ready to execute process
+		 * context. Otherwise, we will need to wake up the thread via
+		 * IRQ work. I wish we can wake up the thread from some CPU
+		 * which is ready to flush IRQ works so that this IRQ work can
+		 * wake up the thread as soon as possible...
+		 *
+		 * This attempt will fail if the thread cannot run for some
+		 * reason (e.g. all CPUs are busy executing interrupt handlers
+		 * or high priority threads). But this attempt is allowed to
+		 * remain best-effort, for current thread will try to hand over
+		 * from current context, by finding that
+		 * console_owner != console_writer when this attempt failed,
+		 */
+		if (console_writer && console_owner != console_writer) {
+			static DEFINE_IRQ_WORK(console_writer_work,
+					       console_writer_work_func);
+
+			if (in_task())
+				wake_up_process(console_writer);
+			else
+				irq_work_queue(&console_writer_work);
+		}
+		/*
 		 * Disable preemption to avoid being preempted while holding
 		 * console_sem which would prevent anyone from printing to
 		 * console
@@ -1981,6 +2015,43 @@ asmlinkage int vprintk_emit(int facility, int level,
 }
 EXPORT_SYMBOL(vprintk_emit);
 
+static int console_writer_thread(void *unused)
+{
+	unsigned long last_woken_up = jiffies;
+
+	console_writer = current;
+	while (true) {
+		/*
+		 * Since printk() is synchronous, it is possible that a thread
+		 * which called printk() already incremented the console_seq
+		 * and console_seq == log_next_seq became true by the moment
+		 * this kernel thread got woken up.
+		 * Therefore, speculatively keep trying to become the console
+		 * waiter thread for a while, in case a series of printk() is
+		 * called within that period.
+		 */
+		if (console_seq == log_next_seq &&
+		    time_after(jiffies, last_woken_up + HZ)) {
+			schedule_timeout_idle(MAX_SCHEDULE_TIMEOUT);
+			last_woken_up = jiffies;
+		} else {
+			schedule_timeout_idle(1);
+		}
+		preempt_disable();
+		if (console_trylock_spinning())
+			console_unlock();
+		preempt_enable();
+	}
+	return 0;
+}
+
+static int __init console_writer_init(void)
+{
+	kthread_run(console_writer_thread, NULL, "console_writer");
+	return 0;
+}
+subsys_initcall(console_writer_init)
+
 asmlinkage int vprintk(const char *fmt, va_list args)
 {
 	return vprintk_func(fmt, args);
@@ -2458,8 +2529,16 @@ void console_unlock(void)
 
 		printk_safe_exit_irqrestore(flags);
 
-		if (do_cond_resched)
+		if (do_cond_resched) {
+			/*
+			 * Try to wake up the console printing intercepting
+			 * kernel thread if current thread is about to complete
+			 * console_lock()/console_unlock() section.
+			 */
+			if (console_writer)
+				wake_up_process(console_writer);
 			cond_resched();
+		}
 	}
 
 	console_locked = 0;
-- 
1.8.3.1

