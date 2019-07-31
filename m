Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4A9C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B3520693
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRbFbCRg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfGaG7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 02:59:54 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45552 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfGaG7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 02:59:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id r1so31301634pfq.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 23:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nEN8oqirkC5/zUVLMb3jLlbuCM21Xywpuw8Wx4KmBX4=;
        b=aRbFbCRgNQ+EOfm+MAC13oGRwRN7m6batq9sUFGgB5PoUurgB3kyXXtxp23TaDkoLc
         A6uEzbLTGuJ9P2Ax4tagrsMpYHjutB+OeDgn1sf6JGI5GnEja7AgxIB5znGVTRJpDIha
         +Dnzd3qQnR+u6bQ14jEsoxRjjLXh1Ulf8EuU8ceeuEclqexP77WPf9sJ4ZOn+eChmOTh
         Gq6TZLw4kfYT7PlCtIq319SkSeS5q5ygcgDQmbnY/15HHu2choWiJ+GnroS5OLhCugjH
         XCjPFL9rtg3GQe4ZSxFE4gVgKmI/x7rHGZ5xkWdna93Jscq+il2wke9+IuLKQPlvXtRf
         Mtmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nEN8oqirkC5/zUVLMb3jLlbuCM21Xywpuw8Wx4KmBX4=;
        b=mWB5lS8VfsFM1q+no3NoOb9QsA/YtHNVFfYeeLoWVvEfN3Psahxwj1Q5ThD2COcrlY
         +UtypO7AEU7mB19DIE5WwayYrxB81sjXCVZv8RAZrZ0TEW6rOJSpm9hhya8p7C4a4bAY
         JEJ/np8TbY/+/wu1EF793rpqyvs5BfJxyg7ru8XUQ2C7Y8Wt/VQnEavzr3AdyoqYoqqX
         SlLXrvbtB55Ug/4s2wv7pJpQgMmqf/C6ZVcHyvRr7BdOY3hjwMMDr+AXqno2c5BZRM27
         alqh61a49J0Qn9FHpkm/64M05is9AL6mjVj6zAHMwQAAIXItzpUJ2INXvnhgU6CDUeOD
         xVcg==
X-Gm-Message-State: APjAAAUK4qLEG61OAbwOVVOuRyH90NoCAwF5ZP+O68JeH8jjeik6yQzn
        7LKlP348TSkYxGSvAwypDjI=
X-Google-Smtp-Source: APXvYqyi+1pgi0IfFs3IKQ/Ldrd8BWHPXriDiTU2JdPuGEdmCq9Rbs32+E9hSQh6QwMAvUjaFLHVWQ==
X-Received: by 2002:a62:b408:: with SMTP id h8mr44742895pfn.46.1564556393858;
        Tue, 30 Jul 2019 23:59:53 -0700 (PDT)
Received: from localhost ([110.70.57.12])
        by smtp.gmail.com with ESMTPSA id e124sm109317004pfh.181.2019.07.30.23.59.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 23:59:53 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:59:49 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Konstantin Khlebnikov <koct9i@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Tesarik <ptesarik@suse.cz>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH 1/2] printk/panic: Access the main printk log in panic()
 only when safe
Message-ID: <20190731065949.GB1756@jagdpanzerIV>
References: <20190716072805.22445-1-pmladek@suse.com>
 <20190716072805.22445-2-pmladek@suse.com>
 <20190717095615.GD3664@jagdpanzerIV>
 <20190718083629.nso3vwbvmankqgks@pathway.suse.cz>
 <20190718094934.GA10041@jagdpanzerIV>
 <20190719125753.miniwfq4nhicy76n@pathway.suse.cz>
 <20190723031340.GA19463@jagdpanzerIV>
 <20190724122711.qquevkcuge24bhdd@pathway.suse.cz>
 <20190731060839.GA1756@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731060839.GA1756@jagdpanzerIV>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (07/31/19 15:08), Sergey Senozhatsky wrote:
> When you have a chance, mind to take a look at the patch below?
> Doesn't look very difficult (half of it are white-spaces and
> comments, I believe).

I'm very sorry for annoyance.

Updated version:
-- passes !PRINTK build
-- moved WRITE_ONCE(console_waiter, false) in printk_enter_panic_mode()
-- added panic_in_progress_on_other_cpu() to console_trylock_spinning()

No more updates this week. Will wait for feedback.

Once again, sorry!

---
 include/linux/printk.h |  5 ++++
 kernel/panic.c         |  9 +++++-
 kernel/printk/printk.c | 64 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 57c9473f4a81..8293156d8243 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -245,6 +245,7 @@ extern asmlinkage void dump_stack(void) __cold;
 extern void printk_safe_init(void);
 extern void printk_safe_flush(void);
 extern void printk_safe_flush_on_panic(void);
+extern void printk_enter_panic_mode(int cpu);
 #else
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
@@ -320,6 +321,10 @@ static inline void printk_safe_flush(void)
 static inline void printk_safe_flush_on_panic(void)
 {
 }
+
+static inline void printk_enter_panic_mode(int cpu)
+{
+}
 #endif
 
 extern int kptr_restrict;
diff --git a/kernel/panic.c b/kernel/panic.c
index d1ece4c363b9..85fac975a90f 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -254,13 +254,20 @@ void panic(const char *fmt, ...)
 		crash_smp_send_stop();
 	}
 
+	/* Misbehaving secondary CPUs cannot printk() to the main logbuf now */
+	printk_enter_panic_mode(this_cpu);
+
 	/*
 	 * Run any panic handlers, including those that might need to
 	 * add information to the kmsg dump output.
 	 */
 	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
 
-	/* Call flush even twice. It tries harder with a single online CPU */
+	/*
+	 * Call flush even twice. It tries harder with a single online CPU.
+	 * Even if we failed to stop some of secondary CPUs we have printk
+	 * locks re-initialized and keep secondary CPUs off printk().
+	 */
 	printk_safe_flush_on_panic();
 	kmsg_dump(KMSG_DUMP_PANIC);
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f0bc37a511a7..cd51aa7d08a9 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1625,6 +1625,57 @@ static DEFINE_RAW_SPINLOCK(console_owner_lock);
 static struct task_struct *console_owner;
 static bool console_waiter;
 
+/*
+ * When system is in panic() this is used to permit printk() calls only from
+ * panic_cpu.
+ */
+static atomic_t __read_mostly printk_panic_cpu = ATOMIC_INIT(PANIC_CPU_INVALID);
+
+static int panic_in_progress_on_other_cpu(void)
+{
+	int cpu = atomic_read(&printk_panic_cpu);
+
+	return cpu != PANIC_CPU_INVALID && cpu != smp_processor_id();
+}
+
+void printk_enter_panic_mode(int cpu)
+{
+	unsigned long timeout;
+
+	cpu = atomic_cmpxchg(&printk_panic_cpu, PANIC_CPU_INVALID, cpu);
+	/* printk can enter panic mode only once */
+	if (cpu != PANIC_CPU_INVALID)
+		return;
+
+	WRITE_ONCE(console_waiter, false);
+
+	/*
+	 * Wait for active secondary CPUs (if there are any) to leave
+	 * console_unlock() printing loop (for up to one second).
+	 */
+	if (num_online_cpus() > 1) {
+		timeout = USEC_PER_SEC;
+		while (num_online_cpus() > 1 && timeout--)
+			udelay(1);
+	}
+
+	debug_locks_off();
+	/*
+	 * On some platforms crash_smp_send_stop() can kill CPUs via NMI
+	 * vector. Re-init printk() locks just in case if any of those killed
+	 * CPUs held any of printk() locks. On platforms which don't support
+	 * NMI stop, misbehaving secondary CPUs will be handled by
+	 * panic_in_progress_on_other_cpu() test.
+	 *
+	 * We re-init only printk() locks here. oops_in_progress is expected
+	 * to be set by now, so good console drivers are in lockless mode,
+	 * bad console drivers, however, can deadlock.
+	 */
+	raw_spin_lock_init(&logbuf_lock);
+	sema_init(&console_sem, 1);
+	raw_spin_lock_init(&console_owner_lock);
+}
+
 /**
  * console_lock_spinning_enable - mark beginning of code where another
  *	thread might safely busy wait
@@ -1739,6 +1790,10 @@ static int console_trylock_spinning(void)
 	spin_release(&console_owner_dep_map, 1, _THIS_IP_);
 
 	printk_safe_exit_irqrestore(flags);
+
+	if (panic_in_progress_on_other_cpu())
+		return 0;
+
 	/*
 	 * The owner passed the console lock to us.
 	 * Since we did not spin on console lock, annotate
@@ -1900,6 +1955,9 @@ int vprintk_store(int facility, int level,
 	size_t text_len;
 	enum log_flags lflags = 0;
 
+	if (panic_in_progress_on_other_cpu())
+		return 0;
+
 	/*
 	 * The printf needs to come first; we need the syslog
 	 * prefix which might be passed-in as a parameter.
@@ -2076,6 +2134,7 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
 				  char *text, size_t text_len) { return 0; }
 static void console_lock_spinning_enable(void) { }
 static int console_lock_spinning_disable_and_check(void) { return 0; }
+static int panic_in_progress_on_other_cpu(void) { return 0; }
 static void call_console_drivers(const char *ext_text, size_t ext_len,
 				 const char *text, size_t len) {}
 static size_t msg_print_text(const struct printk_log *msg, bool syslog,
@@ -2468,6 +2527,11 @@ void console_unlock(void)
 			return;
 		}
 
+		if (panic_in_progress_on_other_cpu()) {
+			printk_safe_exit_irqrestore(flags);
+			return;
+		}
+
 		printk_safe_exit_irqrestore(flags);
 
 		if (do_cond_resched)
-- 
2.22.0

