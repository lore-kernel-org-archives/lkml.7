Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905DCC2BCA1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 02:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A682208C0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 02:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbfFHCqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 22:46:00 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:59766 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbfFHCqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 22:46:00 -0400
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x582jv6c062306;
        Sat, 8 Jun 2019 11:45:57 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp);
 Sat, 08 Jun 2019 11:45:57 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp)
Received: from [192.168.3.2] (softbank126209254060.bbtec.net [126.209.254.60])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x582jjQ2062253
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 8 Jun 2019 11:45:56 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC] printk/sysrq: Don't play with console_loglevel
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20190528002412.1625-1-dima@arista.com>
 <4a9c1b20-777d-079a-33f5-ddf0a39ff788@i-love.sakura.ne.jp>
 <20190528042208.GD26865@jagdpanzerIV>
 <90a22327-922d-6415-538a-6a3fcbe9f3e1@i-love.sakura.ne.jp>
 <20190528084825.GA9676@jagdpanzerIV>
 <966f1a8d-68ab-a808-9140-4ecf1453421d@i-love.sakura.ne.jp>
 <20190607170922.GA17017@xo-6d-61-c0.localdomain>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <b28da439-1d2c-9a1c-17be-fa8b8476d313@i-love.sakura.ne.jp>
Date:   Sat, 8 Jun 2019 11:45:45 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190607170922.GA17017@xo-6d-61-c0.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/06/08 2:09, Pavel Machek wrote:
> On Tue 2019-05-28 19:15:43, Tetsuo Handa wrote:
>> On 2019/05/28 17:51, Sergey Senozhatsky wrote:
>>>> You are trying to omit passing KERN_UNSUPPRESSED by utilizing implicit printk
>>>> context information. But doesn't such attempt resemble find_printk_buffer() ?
>>>
>>> Adding KERN_UNSUPPRESSED to all printks down the op_p->handler()
>>> line is hardly possible. At the same time I'd really prefer not
>>> to have buffering for sysrq.
>>
>> I don't think it is hardly possible. And I really prefer having
>> deferred printing for SysRq.
> 
> Well, magic SysRq was meant for situation where system is in weird/broken state.
> "Give me backtrace where it is hung", etc. Direct printing is more likely to work
> in that cases.

Magic SysRq from keyboard is for situation where system is in weird/broken state.

But I want to use Magic SysRq from /proc for situation where system is not fatally
weird/broken state. I have trouble getting SysRq-t from /proc when something bad
happened (e.g. some health check process did not return for 60 seconds). Since
/proc/pid/wchan shows only 1 line, it is useless for understanding why that process
got stuck. If direct printing is enforced, "echo t > /proc/sysrq-trigger" might take
many minutes. If direct printing is not enforced, "echo t > /proc/sysrq-trigger"
should complete within less than one second. If syslog is working (which is almost
equivalent to being able to write to /proc/sysrq-trigger), the latter is more helpful
for taking snapshots for multiple times (e.g. 5 times with 10 seconds interval) in
order to understand why that process got stuck. That's why I added

  At first I though that we also want to apply temporary
  manipulation of console loglevel for SysRq to the body lines, for showing
  only the header line is hardly helpful. But I realized that we should not
  force showing the body lines because some users might be triggering SysRq
  from /proc and reading via syslog rather than via console output. Users
  who need to read via console output should be able to manipulate console
  loglevel by triggering SysRq from console.

part in https://lkml.kernel.org/r/c265f674-e293-332b-a037-895025354a69@i-love.sakura.ne.jp .

A snapshot which was taken within less than one second and a snapshot which was taken
across more than many minutes, which one likely shows more accurate "snapshot" ?
I know we need to take a snapshot like vmcore if we need a perfect snapshot which
was taken with CPUs stopped. But in enterprise systems where it is difficult to
do "echo c > /proc/sysrq-trigger" in order to take a perfect snapshot, snapshots
which can be taken without destroying the VM comes in handy. There are situations
where something went wrong but still able to operate.

Also, regarding Magic SysRq from keyboard case, my intent is to allow SysRq
to just store the messages to printk() buffer, in order to avoid stalls and
take better snapshots for multiple times. And my intent of

  And I really prefer having deferred printing for SysRq.

is "we can let some other SysRq command (e.g. SysRq-h) to write to consoles in printk() buffer,
when printk() buffer filled by SysRq-t did not get written to consoles automatically".
We can implement it by introducing "printk() which uses global printk() buffer but
do not try to write to consoles" and "passing context information which tells whether
printk() messages should be written to consoles synchronously". An example is shown below.

 drivers/tty/sysrq.c    |  3 +++
 include/linux/printk.h | 15 ++++++++++++
 include/linux/sched.h  |  1 +
 kernel/printk/printk.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++-
 mm/oom_kill.c          |  3 +++
 mm/page_alloc.c        |  3 +++
 6 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 18cb58e52e9b..135acbe5c389 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -543,6 +543,7 @@ void __handle_sysrq(int key, bool check_mask)
 	 */
 	orig_log_level = get_local_loglevel();
 	set_local_loglevel(CONSOLE_LOGLEVEL_DEFAULT);
+	enable_deferred_output();
 
         op_p = __sysrq_get_key_op(key);
         if (op_p) {
@@ -576,10 +577,12 @@ void __handle_sysrq(int key, bool check_mask)
 		pr_cont("\n");
 		set_local_loglevel(orig_log_level);
 	}
+	disable_deferred_output();
 	rcu_read_unlock();
 	rcu_sysrq_end();
 
 	suppress_printk = orig_suppress_printk;
+	trigger_deferred_output();
 }
 
 void handle_sysrq(int key)
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 78b357a1b109..18392376932b 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -196,6 +196,9 @@ extern void printk_safe_flush(void);
 extern void printk_safe_flush_on_panic(void);
 int get_local_loglevel(void);
 void set_local_loglevel(int level);
+void enable_deferred_output(void);
+void disable_deferred_output(void);
+void trigger_deferred_output(void);
 #else
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
@@ -280,6 +283,18 @@ static inline int get_local_loglevel(void)
 static inline void set_local_loglevel(int level)
 {
 }
+
+static inline void enable_deferred_output(void)
+{
+}
+
+static inline void disable_deferred_output(void)
+{
+}
+
+static inline void trigger_deferred_output(void)
+{
+}
 #endif
 
 static inline void console_verbose(void)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 283d0d2d4546..fc538ab1f2e2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -734,6 +734,7 @@ struct task_struct {
 #endif
 #ifdef CONFIG_PRINTK
 	unsigned			printk_loglevel:8;
+	unsigned int			printk_deferred_output;
 #endif
 
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 9adb1801ca54..266125ffea4c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1994,6 +1994,66 @@ int vprintk_store(int facility, int level,
 			  dict, dictlen, text, text_len);
 }
 
+static DEFINE_PER_CPU(unsigned int, deferred_output_nmi);
+static DEFINE_PER_CPU(unsigned int, deferred_output_irq);
+static DEFINE_PER_CPU(unsigned int, deferred_output_softirq);
+
+void enable_deferred_output(void)
+{
+	if (in_nmi())
+		this_cpu_inc(deferred_output_nmi);
+	else if (in_irq())
+		this_cpu_inc(deferred_output_irq);
+	else if (in_serving_softirq())
+		this_cpu_inc(deferred_output_softirq);
+	else
+		current->printk_deferred_output++;
+}
+EXPORT_SYMBOL(enable_deferred_output);
+
+void disable_deferred_output(void)
+{
+	if (in_nmi())
+		this_cpu_dec(deferred_output_nmi);
+	else if (in_irq())
+		this_cpu_dec(deferred_output_irq);
+	else if (in_serving_softirq())
+		this_cpu_dec(deferred_output_softirq);
+	else
+		current->printk_deferred_output--;
+}
+EXPORT_SYMBOL(disable_deferred_output);
+
+static inline bool should_defer_output(void)
+{
+	if (oops_in_progress)
+		return false;
+	if (in_nmi())
+		return this_cpu_read(deferred_output_nmi);
+	if (in_irq())
+		return this_cpu_read(deferred_output_irq);
+	if (in_serving_softirq())
+		return this_cpu_read(deferred_output_softirq);
+	return current->printk_deferred_output;
+}
+
+static void console_writer_work_func(struct irq_work *irq_work)
+{
+	preempt_disable();
+	if (console_trylock_spinning())
+		console_unlock();
+	preempt_enable();
+}
+
+void trigger_deferred_output(void)
+{
+	static DEFINE_IRQ_WORK(console_writer_work, console_writer_work_func);
+
+	if (!in_nmi())
+		irq_work_queue(&console_writer_work);
+}
+EXPORT_SYMBOL(trigger_deferred_output);
+
 asmlinkage int vprintk_emit(int facility, int level,
 			    const char *dict, size_t dictlen,
 			    const char *fmt, va_list args)
@@ -2023,7 +2083,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 	logbuf_unlock_irqrestore(flags);
 
 	/* If called from the scheduler, we can not call up(). */
-	if (!in_sched && pending_output) {
+	if (!in_sched && pending_output && !should_defer_output()) {
 		/*
 		 * Disable preemption to avoid being preempted while holding
 		 * console_sem which would prevent anyone from printing to
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 5a58778c91d4..6ab738061f61 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -961,6 +961,7 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
 	}
 	task_unlock(victim);
 
+	enable_deferred_output();
 	if (__ratelimit(&oom_rs))
 		dump_header(oc, victim);
 
@@ -982,6 +983,8 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
 				      (void*)message);
 		mem_cgroup_put(oom_group);
 	}
+	disable_deferred_output();
+	trigger_deferred_output();
 }
 
 /*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d66bc8abe0af..c8063c23bb82 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3682,6 +3682,7 @@ void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
 	if ((gfp_mask & __GFP_NOWARN) || !__ratelimit(&nopage_rs))
 		return;
 
+	enable_deferred_output();
 	va_start(args, fmt);
 	vaf.fmt = fmt;
 	vaf.va = &args;
@@ -3694,6 +3695,8 @@ void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
 	pr_cont("\n");
 	dump_stack();
 	warn_alloc_show_mem(gfp_mask, nodemask);
+	disable_deferred_output();
+	trigger_deferred_output();
 }
 
 static inline struct page *
-- 
2.16.5

