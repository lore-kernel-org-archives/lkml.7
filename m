Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A463EC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 14:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6472726A10
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 14:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfEaOLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 10:11:15 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:50858 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfEaOLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 10:11:15 -0400
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x4VEBAhw054732;
        Fri, 31 May 2019 23:11:11 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp);
 Fri, 31 May 2019 23:11:10 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x4VEB33X054613
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 31 May 2019 23:11:09 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC] printk/sysrq: Don't play with console_loglevel
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20190528002412.1625-1-dima@arista.com>
 <20190528041500.GB26865@jagdpanzerIV> <20190528044619.GA3429@jagdpanzerIV>
 <20190528134227.xyb3622gjwu52q4r@pathway.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <82605abd-14d9-376a-446c-48475ae305dc@i-love.sakura.ne.jp>
Date:   Fri, 31 May 2019 23:11:02 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190528134227.xyb3622gjwu52q4r@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/05/28 22:42, Petr Mladek wrote:
> On Tue 2019-05-28 13:46:19, Sergey Senozhatsky wrote:
>> On (05/28/19 13:15), Sergey Senozhatsky wrote:
>>> On (05/28/19 01:24), Dmitry Safonov wrote:
>>> [..]
>>>> While handling sysrq the console_loglevel is bumped to default to print
>>>> sysrq headers. It's done to print sysrq messages with WARNING level for
>>>> consumers of /proc/kmsg, though it sucks by the following reasons:
>>>> - changing console_loglevel may produce tons of messages (especially on
>>>>   bloated with debug/info prints systems)
>>>> - it doesn't guarantee that the message will be printed as printk may
>>>>   deffer the actual console output from buffer (see the comment near
>>>>   printk() in kernel/printk/printk.c)
>>>>
>>>> Provide KERN_UNSUPPRESSED printk() annotation for such legacy places.
>>>> Make sysrq print the headers unsuppressed instead of changing
>>>> console_loglevel.
> 
> I like this idea. console_loglevel is temporary manipulated only
> when some messages should or should never appear on the console.
> Storing this information in the message flags would help
> to solve all the related races.

Something like this?

---
 arch/ia64/kernel/mca.c        | 37 +++++++++++++++------------
 arch/x86/platform/uv/uv_nmi.c |  6 ++---
 drivers/tty/sysrq.c           |  9 +++----
 include/linux/printk.h        | 24 +++++++++---------
 include/linux/sched.h         |  3 +++
 kernel/debug/kdb/kdb_bt.c     |  5 ++--
 kernel/debug/kdb/kdb_io.c     |  5 ++--
 kernel/debug/kdb/kdb_main.c   |  5 ++--
 kernel/printk/printk.c        | 59 +++++++++++++++++++++++++++++++++++++++----
 kernel/printk/printk_safe.c   |  2 ++
 10 files changed, 105 insertions(+), 50 deletions(-)

diff --git a/arch/ia64/kernel/mca.c b/arch/ia64/kernel/mca.c
index 6a52d76..5f3968c 100644
--- a/arch/ia64/kernel/mca.c
+++ b/arch/ia64/kernel/mca.c
@@ -189,19 +189,24 @@
 static unsigned long mlogbuf_timestamp = 0;
 
 static int loglevel_save = -1;
-#define BREAK_LOGLEVEL(__console_loglevel)		\
-	oops_in_progress = 1;				\
-	if (loglevel_save < 0)				\
-		loglevel_save = __console_loglevel;	\
-	__console_loglevel = 15;
-
-#define RESTORE_LOGLEVEL(__console_loglevel)		\
-	if (loglevel_save >= 0) {			\
-		__console_loglevel = loglevel_save;	\
-		loglevel_save = -1;			\
-	}						\
-	mlogbuf_finished = 0;				\
-	oops_in_progress = 0;
+#define BREAK_LOGLEVEL()						\
+	do {								\
+		int ret;						\
+		oops_in_progress = 1;					\
+		ret = set_local_loglevel(CONSOLE_LOGLEVEL_MOTORMOUTH);	\
+		if (loglevel_save < 0)					\
+			loglevel_save = ret;				\
+	} while (0)
+
+#define RESTORE_LOGLEVEL()					\
+	do {							\
+		if (loglevel_save >= 0) {			\
+			set_local_loglevel(loglevel_save);	\
+			loglevel_save = -1;			\
+		}						\
+		mlogbuf_finished = 0;				\
+		oops_in_progress = 0;				\
+	} while (0)
 
 /*
  * Push messages into buffer, print them later if not urgent.
@@ -288,7 +293,7 @@ void ia64_mlogbuf_dump(void)
  */
 static void ia64_mlogbuf_finish(int wait)
 {
-	BREAK_LOGLEVEL(console_loglevel);
+	BREAK_LOGLEVEL();
 
 	spin_lock_init(&mlogbuf_rlock);
 	ia64_mlogbuf_dump();
@@ -1623,7 +1628,7 @@ static void mca_insert_tr(u64 iord)
 	 * To enable show_stack from INIT, we use oops_in_progress which should
 	 * be used in real oops. This would cause something wrong after INIT.
 	 */
-	BREAK_LOGLEVEL(console_loglevel);
+	BREAK_LOGLEVEL();
 	ia64_mlogbuf_dump_from_init();
 
 	printk(KERN_ERR "Processes interrupted by INIT -");
@@ -1648,7 +1653,7 @@ static void mca_insert_tr(u64 iord)
 		read_unlock(&tasklist_lock);
 	}
 	/* FIXME: This will not restore zapped printk locks. */
-	RESTORE_LOGLEVEL(console_loglevel);
+	RESTORE_LOGLEVEL();
 	return NOTIFY_DONE;
 }
 
diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index b21a932..48592d1 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -766,13 +766,13 @@ static void uv_nmi_dump_state(int cpu, struct pt_regs *regs, int master)
 	if (master) {
 		int tcpu;
 		int ignored = 0;
-		int saved_console_loglevel = console_loglevel;
+		int saved_loglevel;
 
 		pr_alert("UV: tracing %s for %d CPUs from CPU %d\n",
 			uv_nmi_action_is("ips") ? "IPs" : "processes",
 			atomic_read(&uv_nmi_cpus_in_nmi), cpu);
 
-		console_loglevel = uv_nmi_loglevel;
+		saved_loglevel = set_local_loglevel(uv_nmi_loglevel);
 		atomic_set(&uv_nmi_slave_continue, SLAVE_EXIT);
 		for_each_online_cpu(tcpu) {
 			if (cpumask_test_cpu(tcpu, uv_nmi_cpu_mask))
@@ -785,7 +785,7 @@ static void uv_nmi_dump_state(int cpu, struct pt_regs *regs, int master)
 		if (ignored)
 			pr_alert("UV: %d CPUs ignored NMI\n", ignored);
 
-		console_loglevel = saved_console_loglevel;
+		set_local_loglevel(saved_loglevel);
 		pr_alert("UV: process trace complete\n");
 	} else {
 		while (!atomic_read(&uv_nmi_slave_continue))
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 573b205..5675977 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -541,8 +541,7 @@ void __handle_sysrq(int key, bool check_mask)
 	 * simply emit this at KERN_EMERG as that would change message
 	 * routing in the consumers of /proc/kmsg.
 	 */
-	orig_log_level = console_loglevel;
-	console_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
+	orig_log_level = set_local_loglevel(CONSOLE_LOGLEVEL_DEFAULT);
 
         op_p = __sysrq_get_key_op(key);
         if (op_p) {
@@ -552,11 +551,11 @@ void __handle_sysrq(int key, bool check_mask)
 		 */
 		if (!check_mask || sysrq_on_mask(op_p->enable_mask)) {
 			pr_info("%s\n", op_p->action_msg);
-			console_loglevel = orig_log_level;
+			set_local_loglevel(orig_log_level);
 			op_p->handler(key);
 		} else {
 			pr_info("This sysrq operation is disabled.\n");
-			console_loglevel = orig_log_level;
+			set_local_loglevel(orig_log_level);
 		}
 	} else {
 		pr_info("HELP : ");
@@ -574,7 +573,7 @@ void __handle_sysrq(int key, bool check_mask)
 			}
 		}
 		pr_cont("\n");
-		console_loglevel = orig_log_level;
+		set_local_loglevel(orig_log_level);
 	}
 	rcu_read_unlock();
 	rcu_sysrq_end();
diff --git a/include/linux/printk.h b/include/linux/printk.h
index cefd374..b2dd248 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -47,7 +47,7 @@ static inline const char *printk_skip_headers(const char *buffer)
 #define MESSAGE_LOGLEVEL_DEFAULT CONFIG_MESSAGE_LOGLEVEL_DEFAULT
 
 /* We show everything that is MORE important than this.. */
-#define CONSOLE_LOGLEVEL_SILENT  0 /* Mum's the word */
+#define CONSOLE_LOGLEVEL_SILENT -1 /* Mum's the word */
 #define CONSOLE_LOGLEVEL_MIN	 1 /* Minimum loglevel we let people use */
 #define CONSOLE_LOGLEVEL_DEBUG	10 /* issue debug messages */
 #define CONSOLE_LOGLEVEL_MOTORMOUTH 15	/* You can't shut this one up */
@@ -66,17 +66,6 @@ static inline const char *printk_skip_headers(const char *buffer)
 #define minimum_console_loglevel (console_printk[2])
 #define default_console_loglevel (console_printk[3])
 
-static inline void console_silent(void)
-{
-	console_loglevel = CONSOLE_LOGLEVEL_SILENT;
-}
-
-static inline void console_verbose(void)
-{
-	if (console_loglevel)
-		console_loglevel = CONSOLE_LOGLEVEL_MOTORMOUTH;
-}
-
 /* strlen("ratelimit") + 1 */
 #define DEVKMSG_STR_MAX_SIZE 10
 extern char devkmsg_log_str[];
@@ -205,6 +194,7 @@ extern bool printk_timed_ratelimit(unsigned long *caller_jiffies,
 extern void printk_safe_init(void);
 extern void printk_safe_flush(void);
 extern void printk_safe_flush_on_panic(void);
+char set_local_loglevel(char level);
 #else
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
@@ -280,8 +270,18 @@ static inline void printk_safe_flush(void)
 static inline void printk_safe_flush_on_panic(void)
 {
 }
+
+static inline char set_local_loglevel(char level)
+{
+	return 0;
+}
 #endif
 
+static inline void console_verbose(void)
+{
+	set_local_loglevel(CONSOLE_LOGLEVEL_MOTORMOUTH);
+}
+
 extern int kptr_restrict;
 
 #ifndef pr_fmt
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1183741..283d0d2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -732,6 +732,9 @@ struct task_struct {
 	/* to be used once the psi infrastructure lands upstream. */
 	unsigned			use_memdelay:1;
 #endif
+#ifdef CONFIG_PRINTK
+	unsigned			printk_loglevel:8;
+#endif
 
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
 
diff --git a/kernel/debug/kdb/kdb_bt.c b/kernel/debug/kdb/kdb_bt.c
index 7e2379a..b385a7e 100644
--- a/kernel/debug/kdb/kdb_bt.c
+++ b/kernel/debug/kdb/kdb_bt.c
@@ -21,8 +21,7 @@
 
 static void kdb_show_stack(struct task_struct *p, void *addr)
 {
-	int old_lvl = console_loglevel;
-	console_loglevel = CONSOLE_LOGLEVEL_MOTORMOUTH;
+	int old_lvl = set_local_loglevel(CONSOLE_LOGLEVEL_MOTORMOUTH);
 	kdb_trap_printk++;
 	kdb_set_current_task(p);
 	if (addr) {
@@ -36,7 +35,7 @@ static void kdb_show_stack(struct task_struct *p, void *addr)
 	} else {
 		show_stack(p, NULL);
 	}
-	console_loglevel = old_lvl;
+	set_local_loglevel(old_lvl);
 	kdb_trap_printk--;
 }
 
diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 3a5184e..8b76103 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -715,8 +715,7 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
 		}
 	}
 	if (logging) {
-		saved_loglevel = console_loglevel;
-		console_loglevel = CONSOLE_LOGLEVEL_SILENT;
+		saved_loglevel = set_local_loglevel(CONSOLE_LOGLEVEL_SILENT);
 		if (printk_get_level(kdb_buffer) || src == KDB_MSGSRC_PRINTK)
 			printk("%s", kdb_buffer);
 		else
@@ -845,7 +844,7 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
 kdb_print_out:
 	suspend_grep = 0; /* end of what may have been a recursive call */
 	if (logging)
-		console_loglevel = saved_loglevel;
+		set_local_loglevel(saved_loglevel);
 	/* kdb_printf_cpu locked the code above. */
 	smp_store_release(&kdb_printf_cpu, old_cpu);
 	local_irq_restore(flags);
diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 9ecfa37..395eb98 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -1130,13 +1130,12 @@ static int kdb_reboot(int argc, const char **argv)
 
 static void kdb_dumpregs(struct pt_regs *regs)
 {
-	int old_lvl = console_loglevel;
-	console_loglevel = CONSOLE_LOGLEVEL_MOTORMOUTH;
+	int old_lvl = set_local_loglevel(CONSOLE_LOGLEVEL_MOTORMOUTH);
 	kdb_trap_printk++;
 	show_regs(regs);
 	kdb_trap_printk--;
 	kdb_printf("\n");
-	console_loglevel = old_lvl;
+	set_local_loglevel(old_lvl);
 }
 
 void kdb_set_current_task(struct task_struct *p)
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1888f6a..dfdefe9 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -351,7 +351,9 @@ enum con_msg_format_flags {
  */
 
 enum log_flags {
-	LOG_NEWLINE	= 2,	/* text ended with a newline */
+	LOG_ALWAYS_CON  = 1,    /* Force suppress_message_printing() = false */
+	LOG_NEVER_CON   = 2,    /* Force suppress_message_printing() = true */
+	LOG_NEWLINE	= 4,	/* text ended with a newline */
 	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
 };
 
@@ -1172,6 +1174,9 @@ void __init setup_log_buf(int early)
 }
 
 static bool __read_mostly ignore_loglevel;
+static DEFINE_PER_CPU(char, printk_loglevel_nmi);
+static DEFINE_PER_CPU(char, printk_loglevel_irq);
+static DEFINE_PER_CPU(char, printk_loglevel_softirq);
 
 static int __init ignore_loglevel_setup(char *str)
 {
@@ -1186,11 +1191,36 @@ static int __init ignore_loglevel_setup(char *str)
 MODULE_PARM_DESC(ignore_loglevel,
 		 "ignore loglevel setting (prints all kernel messages to the console)");
 
-static bool suppress_message_printing(int level)
+static bool suppress_message_printing(int flags, int level)
 {
+	if (flags & LOG_ALWAYS_CON)
+		return false;
+	if (flags & LOG_NEVER_CON)
+		return true;
 	return (level >= console_loglevel && !ignore_loglevel);
 }
 
+char set_local_loglevel(char level)
+{
+	char old;
+
+	if (in_nmi()) {
+		old = this_cpu_read(printk_loglevel_nmi);
+		this_cpu_write(printk_loglevel_nmi, level);
+	} else if (in_irq()) {
+		old = this_cpu_read(printk_loglevel_irq);
+		this_cpu_write(printk_loglevel_irq, level);
+	} else if (in_serving_softirq()) {
+		old = this_cpu_read(printk_loglevel_softirq);
+		this_cpu_write(printk_loglevel_softirq, level);
+	} else {
+		old = current->printk_loglevel;
+		current->printk_loglevel = level;
+	}
+	return old;
+}
+EXPORT_SYMBOL(set_local_loglevel);
+
 #ifdef CONFIG_BOOT_PRINTK_DELAY
 
 static int boot_delay; /* msecs delay after each printk during bootup */
@@ -1220,7 +1250,7 @@ static void boot_delay_msec(int level)
 	unsigned long timeout;
 
 	if ((boot_delay == 0 || system_state >= SYSTEM_RUNNING)
-		|| suppress_message_printing(level)) {
+	    || suppress_message_printing(0, level)) {
 		return;
 	}
 
@@ -1934,6 +1964,25 @@ int vprintk_store(int facility, int level,
 	if (level == LOGLEVEL_DEFAULT)
 		level = default_message_loglevel;
 
+	{
+		char loglevel;
+
+		if (in_nmi())
+			loglevel = this_cpu_read(printk_loglevel_nmi);
+		else if (in_irq())
+			loglevel = this_cpu_read(printk_loglevel_irq);
+		else if (in_serving_softirq())
+			loglevel = this_cpu_read(printk_loglevel_softirq);
+		else
+			loglevel = current->printk_loglevel;
+		if (loglevel) {
+			if (level >= (int) loglevel && !ignore_loglevel)
+				lflags |= LOG_NEVER_CON;
+			else
+				lflags |= LOG_ALWAYS_CON;
+		}
+	}
+
 	if (dict)
 		lflags |= LOG_NEWLINE;
 
@@ -2080,7 +2129,7 @@ static void call_console_drivers(const char *ext_text, size_t ext_len,
 				 const char *text, size_t len) {}
 static size_t msg_print_text(const struct printk_log *msg, bool syslog,
 			     bool time, char *buf, size_t size) { return 0; }
-static bool suppress_message_printing(int level) { return false; }
+static bool suppress_message_printing(int flags, int level) { return false; }
 
 #endif /* CONFIG_PRINTK */
 
@@ -2418,7 +2467,7 @@ void console_unlock(void)
 			break;
 
 		msg = log_from_idx(console_idx);
-		if (suppress_message_printing(msg->level)) {
+		if (suppress_message_printing(msg->flags, msg->level)) {
 			/*
 			 * Skip record we have buffered and already printed
 			 * directly to the console when we received it, and
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index b4045e7..d33bea5 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -186,6 +186,7 @@ static void __printk_safe_flush(struct irq_work *work)
 	unsigned long flags;
 	size_t len;
 	int i;
+	char level = set_local_loglevel(CONSOLE_LOGLEVEL_MOTORMOUTH);
 
 	/*
 	 * The lock has two functions. First, one reader has to flush all
@@ -232,6 +233,7 @@ static void __printk_safe_flush(struct irq_work *work)
 out:
 	report_message_lost(s);
 	raw_spin_unlock_irqrestore(&read_lock, flags);
+	set_local_loglevel(level);
 }
 
 /**
-- 
1.8.3.1
