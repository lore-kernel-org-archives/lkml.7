Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32732C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 08:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A912087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 08:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732870AbfCAItU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 03:49:20 -0500
Received: from mga04.intel.com ([192.55.52.120]:55522 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbfCAItT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 03:49:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Mar 2019 00:49:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,426,1544515200"; 
   d="scan'208";a="151096993"
Received: from shbuild999.sh.intel.com ([10.239.147.118])
  by fmsmga001.fm.intel.com with ESMTP; 01 Mar 2019 00:49:16 -0800
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v6] panic: Avoid the extra noise dmesg
Date:   Fri,  1 Mar 2019 16:49:46 +0800
Message-Id: <1551430186-24169-1-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kernel panic happens, it will first print the panic call stack,
then the ending msg like:

[   35.743249] ---[ end Kernel panic - not syncing: Fatal exception
[   35.749975] ------------[ cut here ]------------

The above message are very useful for debugging.

But if system is configured to not reboot on panic, say the "panic_timeout"
parameter equals 0, it will likely print out many noisy message like
WARN() call stack for each and every CPU except the panic one, messages
like below:

	WARNING: CPU: 1 PID: 280 at kernel/sched/core.c:1198 set_task_cpu+0x183/0x190
	Call Trace:
	<IRQ>
	try_to_wake_up
	default_wake_function
	autoremove_wake_function
	__wake_up_common
	__wake_up_common_lock
	__wake_up
	wake_up_klogd_work_func
	irq_work_run_list
	irq_work_tick
	update_process_times
	tick_sched_timer
	__hrtimer_run_queues
	hrtimer_interrupt
	smp_apic_timer_interrupt
	apic_timer_interrupt

For people working in console mode, the screen will first show the panic
call stack, but immediately overridden by these noisy extra messages, which
makes debugging much more difficult, as the original context gets lost on
screen.

Also these noisy messages will confuse some users, as I have seen many bug
reporters posted the noisy message into bugzilla, instead of the real panic
call stack and context.

Adding a flag "suppress_printk" which gets set in panic() to avoid those
noisy messages, without changing current kernel behavior that both panic
blinking and sysrq magic key can work as is, suggested by Petr Mladek.

To verify this, make sure kernel is not configured to reboot on panic and
in console
 # echo c > /proc/sysrq-trigger
to see if console only prints out the panic call stack.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Sasha Levin <sashal@kernel.org>
---
Change log:

  v6:
    - change the flag name from "panic_suppress_printk" to
      suppress_printk, as suggested by Andrew Morton

  v5:
    - use a flag to notify printk not to print unimportant
      messages, while keeping panic blinking and sysrq working,
      as suggested by Petr Mladek

  v4:
    - make the local_irq_enable conditional and default off
    to cover possible use of interrupt/scheduling, as
    mentioned by Sergey and Petr

  v3:
    - Make the change log clearer as suggested by Andrew Morton

  v2:
    - Move the solution from hacking arch/scheduler code back
    to panic.c

 drivers/tty/sysrq.c    |  6 ++++++
 include/linux/printk.h |  2 ++
 kernel/panic.c         |  3 +++
 kernel/printk/printk.c | 10 ++++++++++
 4 files changed, 21 insertions(+)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 1f03078..ddc2d8a 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -527,8 +527,12 @@ void __handle_sysrq(int key, bool check_mask)
 {
 	struct sysrq_key_op *op_p;
 	int orig_log_level;
+	int orig_suppress_printk;
 	int i;
 
+	orig_suppress_printk = suppress_printk;
+	suppress_printk = 0;
+
 	rcu_sysrq_start();
 	rcu_read_lock();
 	/*
@@ -574,6 +578,8 @@ void __handle_sysrq(int key, bool check_mask)
 	}
 	rcu_read_unlock();
 	rcu_sysrq_end();
+
+	suppress_printk = orig_suppress_printk;
 }
 
 void handle_sysrq(int key)
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 77740a5..a010cdf 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -83,6 +83,8 @@ static inline void console_verbose(void)
 extern char devkmsg_log_str[];
 struct ctl_table;
 
+extern int suppress_printk;
+
 struct va_format {
 	const char *fmt;
 	va_list *va;
diff --git a/kernel/panic.c b/kernel/panic.c
index f121e6b..960fdfa 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -326,6 +326,9 @@ void panic(const char *fmt, ...)
 	}
 #endif
 	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
+
+	/* Do not scroll important messages printed above */
+	suppress_printk = 1;
 	local_irq_enable();
 	for (i = 0; ; i += PANIC_TIMER_STEP) {
 		touch_softlockup_watchdog();
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d3d1703..8f1c19f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -85,6 +85,12 @@ static DEFINE_SEMAPHORE(console_sem);
 struct console *console_drivers;
 EXPORT_SYMBOL_GPL(console_drivers);
 
+/*
+ * System may need to suppress printk message under certain
+ * circumstances, like after kernel panic happens.
+ */
+int __read_mostly suppress_printk;
+
 #ifdef CONFIG_LOCKDEP
 static struct lockdep_map console_lock_dep_map = {
 	.name = "console_lock"
@@ -1899,6 +1905,10 @@ asmlinkage int vprintk_emit(int facility, int level,
 	unsigned long flags;
 	u64 curr_log_seq;
 
+	/* Suppress unimportant messages after panic happens */
+	if (unlikely(suppress_printk))
+		return 0;
+
 	if (level == LOGLEVEL_SCHED) {
 		level = LOGLEVEL_DEFAULT;
 		in_sched = true;
-- 
2.7.4

