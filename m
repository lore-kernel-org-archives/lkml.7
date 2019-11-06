Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A81C5DF60
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D6720659
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="UdMa2T9n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387617AbfKFDGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:06:49 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36346 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387468AbfKFDGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:06:48 -0500
Received: by mail-pg1-f193.google.com with SMTP id k13so4802199pgh.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nwR9CcGfOm2RmcVXjGycnTvK5Jd4c8Blttv9a/CZC/0=;
        b=UdMa2T9nHqA3LFMjK+pWj3K+yUaB0z+1BTvAUCLmq8bQfol0rDqOC2+1gH4O9E8A9h
         Yi3ZNqIkyTDIMhE55E4+6l5JYmf1RRUfULTwc8I4vanYKybs0i9ArtMod2CFq/SOJLw2
         KnSYnHKIMaIL2XcMxRpUhPlYwJFOmRTCCHEU5DlqpgSQLqQbxQTZAHuNRTKN2Cz7aD9W
         7Gw3ucM5qf3dc1YvUsn7RHLOhSt96s/fiOikxCDqUghfr0/RSTT59T66YrQNRhOZKKmT
         /fJjmAKh+QfzxwWjzZQJ7cAlhzHwS/6TkrU0xM2DT/MK7f37dnWPTFlgo9doHiy4Gab6
         JOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nwR9CcGfOm2RmcVXjGycnTvK5Jd4c8Blttv9a/CZC/0=;
        b=r/RBPbSJ+GZLGd/hiWUnq3wjn2hVkbloqnXLm9VBy67QSgbQyE1eHPl+luXaWvSXQ3
         rP35cycOMi4iX7uBvy5AAmBkx8DcauypPjpjolLwj/5wrnmQHJcDATvnwdXlf031cB43
         E9MFr6HfqMlTPH2SnYOmyJ2giu/udp3dkc3L2Nw0EzT+HoUjyzdOOQ7Tm33eNuSntF2F
         ZBRXx6cMsaDG2LegDCFF4E183vR8NOqvcy8pQqkFWudqvT/mXSVXJ7epRCQazZUTy39q
         LPaUI6NaRLw3apQIC9dhDO2YmCiRNPnPO8Mmkht8PbcuDSmOHq9uLRpOzL7gGcIhTh8m
         SzcQ==
X-Gm-Message-State: APjAAAWCk3wk4cUnvYuxFa0PR7LgP10NZHWpOq+cSBNw7+oPGpySWd9R
        72in6Qn4bL6QX9RbRNVfMyEHKL0OEB8=
X-Google-Smtp-Source: APXvYqwl/ZkAnlXpWL33fvgsLGduP6TX1qo4dNY9VgxsWQ+dEiLM8Z4M9dI8XtEOR6FKqmqdz4o4Jg==
X-Received: by 2002:a63:f441:: with SMTP id p1mr197683pgk.362.1573009605013;
        Tue, 05 Nov 2019 19:06:45 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:06:43 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 09/50] arm64: Add loglvl to dump_backtrace()
Date:   Wed,  6 Nov 2019 03:05:00 +0000
Message-Id: <20191106030542.868541-10-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106030542.868541-1-dima@arista.com>
References: <20191106030542.868541-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the log-level of show_stack() depends on a platform
realization. It creates situations where the headers are printed with
lower log level or higher than the stacktrace (depending on
a platform or user).

Furthermore, it forces the logic decision from user to an architecture
side. In result, some users as sysrq/kdb/etc are doing tricks with
temporary rising console_loglevel while printing their messages.
And in result it not only may print unwanted messages from other CPUs,
but also omit printing at all in the unlucky case where the printk()
was deferred.

Introducing log-level parameter and KERN_UNSUPPRESSED [1] seems
an easier approach than introducing more printk buffers.
Also, it will consolidate printings with headers.

Add log level argument to dump_backtrace() as a preparation for
introducing show_stack_loglvl().

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/arm64/include/asm/stacktrace.h |  3 ++-
 arch/arm64/kernel/process.c         |  2 +-
 arch/arm64/kernel/traps.c           | 17 +++++++++--------
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index 4d9b1f48dc39..fdb913cc0bcb 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -64,7 +64,8 @@ struct stackframe {
 extern int unwind_frame(struct task_struct *tsk, struct stackframe *frame);
 extern void walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
 			    int (*fn)(struct stackframe *, void *), void *data);
-extern void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk);
+extern void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
+			   const char *loglvl);
 
 DECLARE_PER_CPU(unsigned long *, irq_stack_ptr);
 
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 71f788cd2b18..1a6b58b1be2c 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -291,7 +291,7 @@ void __show_regs(struct pt_regs *regs)
 void show_regs(struct pt_regs * regs)
 {
 	__show_regs(regs);
-	dump_backtrace(regs, NULL);
+	dump_backtrace(regs, NULL, KERN_DEFAULT);
 }
 
 static void tls_thread_flush(void)
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 34739e80211b..59072c7b9fb4 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -52,9 +52,9 @@ static const char *handler[]= {
 
 int show_unhandled_signals = 0;
 
-static void dump_backtrace_entry(unsigned long where)
+static void dump_backtrace_entry(unsigned long where, const char *loglvl)
 {
-	printk(" %pS\n", (void *)where);
+	printk("%s %pS\n", loglvl, (void *)where);
 }
 
 static void dump_kernel_instr(const char *lvl, struct pt_regs *regs)
@@ -82,12 +82,13 @@ static void dump_kernel_instr(const char *lvl, struct pt_regs *regs)
 	printk("%sCode: %s\n", lvl, str);
 }
 
-void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
+void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
+		    const char *loglvl)
 {
 	struct stackframe frame;
 	int skip = 0;
 
-	pr_debug("%s(regs = %p tsk = %p)\n", __func__, regs, tsk);
+	printk("%s%s(regs = %p tsk = %p)\n", loglvl, __func__, regs, tsk);
 
 	if (regs) {
 		if (user_mode(regs))
@@ -114,11 +115,11 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 				thread_saved_pc(tsk));
 	}
 
-	printk("Call trace:\n");
+	printk("%sCall trace:\n", loglvl);
 	do {
 		/* skip until specified stack frame */
 		if (!skip) {
-			dump_backtrace_entry(frame.pc);
+			dump_backtrace_entry(frame.pc, loglvl);
 		} else if (frame.fp == regs->regs[29]) {
 			skip = 0;
 			/*
@@ -128,7 +129,7 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 			 * at which an exception has taken place, use regs->pc
 			 * instead.
 			 */
-			dump_backtrace_entry(regs->pc);
+			dump_backtrace_entry(regs->pc, loglvl);
 		}
 	} while (!unwind_frame(tsk, &frame));
 
@@ -137,7 +138,7 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 
 void show_stack(struct task_struct *tsk, unsigned long *sp)
 {
-	dump_backtrace(NULL, tsk);
+	dump_backtrace(NULL, tsk, KERN_DEFAULT);
 	barrier();
 }
 
-- 
2.23.0

