Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E788C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D57206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JC3wUTM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfGaGIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 02:08:44 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43041 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725209AbfGaGIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 02:08:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id r22so3781210pgk.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 23:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JDEeV/Y6EACfYNrIRxXQKYDfgmcSELMlyvb7H8H7iY8=;
        b=JC3wUTM3UMEYP6qFYXxkpp2C8k6UmEVIvsNyg1B+fd9yBNv453+JhHdCNvnB/lvSan
         Kcm2u+BIu8oZ1blUwPpY5stGVYpHaGvHrvJsNn5wJPhneQJsNCsAz/h1hbHEkfXMFFcd
         egCfboeEaCZ+snTSo9qQKDWrx+xOO+qlouvaU3UbIVQfOMeC2Hn7Dr90j5SGWrdkiyN1
         ovXCjZLDIlyZT385Y+VWJbikI+p3SfmR5/tKVB/lUM0H3S8ZVJCrednIFRUZfUtKYfVl
         s71JdJXuqemP7t+A8JTsBDYvZakuvJLkcTMVcLtJoq1c9BbhpGsYpWn+THmZ2sFwG9c5
         1KAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JDEeV/Y6EACfYNrIRxXQKYDfgmcSELMlyvb7H8H7iY8=;
        b=bl+LTgqeKZjkUQoNvcH+DuK1yr6dnWmTyz8yakO3lxpIxb8LFN7t73SpxEA53H4trc
         A8w365kvtalTGLIjHbynK10ntBf3sUhwJuTthfxcSwyIK5c8a2S5jHeY8X6NGRjJ2fVi
         vNolvrxORGM93CVOZhzeMJntlEb0nqSQn9aiLv0GiX1u53fEckae79xMzRu6XU2avLXM
         uTHmVKd4tZDjozQKMRB2Tg0gSqbg27cJbT1RYY9eCuHNhUYZAgt58vbBGSMmpVURblgT
         nCbclN0NAM9W4oMqupqg50ZX0Yy/40Zym/cWsThdxYw0EYnB7M8HblplQA9n/2jNyK7V
         hkpA==
X-Gm-Message-State: APjAAAXYOa+VmyqbDX6NeiKBjRYK+2uVSwK9olSxMthXat0xsVjGF7xN
        vk/c1DWT0a+rJfcuNekpOVA=
X-Google-Smtp-Source: APXvYqx68QMWRBroWoeuy/KXgACCfbMnSXDiXOdTRVPQaOrRtnwBt4j+EpeCjf8quVodZ63GDfx0wg==
X-Received: by 2002:a17:90a:30aa:: with SMTP id h39mr1195348pjb.32.1564553323116;
        Tue, 30 Jul 2019 23:08:43 -0700 (PDT)
Received: from localhost ([110.70.57.12])
        by smtp.gmail.com with ESMTPSA id g2sm83146412pfb.95.2019.07.30.23.08.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 23:08:42 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:08:39 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Tesarik <ptesarik@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] printk/panic: Access the main printk log in panic()
 only when safe
Message-ID: <20190731060839.GA1756@jagdpanzerIV>
References: <20190716072805.22445-1-pmladek@suse.com>
 <20190716072805.22445-2-pmladek@suse.com>
 <20190717095615.GD3664@jagdpanzerIV>
 <20190718083629.nso3vwbvmankqgks@pathway.suse.cz>
 <20190718094934.GA10041@jagdpanzerIV>
 <20190719125753.miniwfq4nhicy76n@pathway.suse.cz>
 <20190723031340.GA19463@jagdpanzerIV>
 <20190724122711.qquevkcuge24bhdd@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724122711.qquevkcuge24bhdd@pathway.suse.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the delayed response.

On (07/24/19 14:27), Petr Mladek wrote:
[..]
> > And this is where the idea of "disconnecting" those CPUs from main
> > logbuf come from.
> > 
> > So what we can do:
> > - smp_send_stop()
> > - disconnect all-but-self from logbuf (via printk-safe)
> 
> printk_safe is not really necessary. As you wrote, nobody
> is interested into messages from CPUs that are supposed
> to be stopped.

OK.
Doing it in printk.c makes it easier to handle console_owner/waiter,
which are not exported.

> It might be enough to set some global variable, for example,
> with the CPU number that is calling panic() and is the only
> one allowed to print messages from this point on.

Sounds good.

> It might even be used to force console lock owner to leave
> the cycle immediately.

Yes, makes sense.

[..]
> > So, shall we try one more time with the "disconnect" misbehaving CPUs
> > approach? I can send an RFC patch.
> 
> IMHO, it will be acceptable only when it is reasonably simple and
> straightforward. The panic() code is full of special hacks and
> it is already complicated to follow all the twists.

When you have a chance, mind to take a look at the patch below?
Doesn't look very difficult (half of it are white-spaces and
comments, I believe).

> Especially because this scenario came up from a theoretical
> discussion. Note that my original, real bug report, was
> with logbuf_lock NMI, enabled kdump notifiers, ...

I understand. The idea is that this patch should handle your real
scenario + theoretical scenario.

---
 include/linux/printk.h |  2 ++
 kernel/panic.c         |  9 ++++++-
 kernel/printk/printk.c | 53 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 57c9473f4a81..016f5ba06e94 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -322,6 +322,8 @@ static inline void printk_safe_flush_on_panic(void)
 }
 #endif
 
+void printk_enter_panic_mode(int cpu);
+
 extern int kptr_restrict;
 
 #ifndef pr_fmt
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
index f0bc37a511a7..750f83c3b589 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -87,6 +87,8 @@ static DEFINE_SEMAPHORE(console_sem);
 struct console *console_drivers;
 EXPORT_SYMBOL_GPL(console_drivers);
 
+static atomic_t __read_mostly printk_panic_cpu = ATOMIC_INIT(PANIC_CPU_INVALID);
+
 /*
  * System may need to suppress printk message under certain
  * circumstances, like after kernel panic happens.
@@ -1644,6 +1646,49 @@ static void console_lock_spinning_enable(void)
 	spin_acquire(&console_owner_dep_map, 0, 0, _THIS_IP_);
 }
 
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
+	WRITE_ONCE(console_waiter, false);
+	raw_spin_lock_init(&console_owner_lock);
+}
+
 /**
  * console_lock_spinning_disable_and_check - mark end of code where another
  *	thread was able to busy wait and check if there is a waiter
@@ -1900,6 +1945,9 @@ int vprintk_store(int facility, int level,
 	size_t text_len;
 	enum log_flags lflags = 0;
 
+	if (panic_in_progress_on_other_cpu())
+		return 0;
+
 	/*
 	 * The printf needs to come first; we need the syslog
 	 * prefix which might be passed-in as a parameter.
@@ -2468,6 +2516,11 @@ void console_unlock(void)
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

