Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AC7C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04FB020659
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="MHdxQCdP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387744AbfKFDHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:07:07 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36375 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387724AbfKFDHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:07:06 -0500
Received: by mail-pg1-f196.google.com with SMTP id k13so4802669pgh.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=neEF1arVtlkYu7Te8ry9xWmO86m4L6M49fWU7Gf2erY=;
        b=MHdxQCdPIk9csU9sco3kbranbRfmNXyVfOj6R0QS2I6oNtIc8cwCmqw1f/EFTcAnWl
         cCibFUOyqIbnNRuM2BzlXj51Bb5c5qAMoJZ4xeDQYIUd8pYGppjJsGA3AAbqZSq2tIZ1
         H/jJMin+LRdXqcd2YjNZuLuSD7JmT2jfKyg8mMfvkRxVgovlnGfH6TvYdz8h0FHtQQRV
         NXTIkZi+X+AKw2g/ac5nfrChhCAMVLFVHWkDQGUC8gxeEdCTeUSZuTyDC096WgBbGTJ8
         UZMJtwIleHqvn7xt4YrV/nQqoYGb6CDGlIcV46ptRhdWIRjS1TAFyr7uk57ULeKJKZSv
         t1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=neEF1arVtlkYu7Te8ry9xWmO86m4L6M49fWU7Gf2erY=;
        b=kqfvkXdf3FG6DXVg1jahx99svF5PiYYH4Lar5WwsOGT5acIZJw+OFeOhAgwL71ecgL
         JDRwMX+SvthEQPSpr8n33IC1S/dDbdzQoXsctHMSK7kZ7Qx7hDJ/10f/1zqTaYlEIXPW
         /EddKnoDIkRmbeFOqoAa0tnkc3vFgSOQlBzuVdO4YrDhPp5MvLbDyrXEm8XmKB6SpUb5
         1H8mmn5pUrF/phTwdhxd7DE+7U6M6r5kbE2etUKxgC6V/7Y033nPNhp7otimZtPlGdwq
         NZA/yDYuKJKAUzRj4l7RcRAlDUrt393jMK7FdIBEa7pk2tsqvhhdmuA1yWRU8JiwUk+n
         zjfQ==
X-Gm-Message-State: APjAAAWMnbFQiUaEk5ReTf4UekhQB00/2zCylwGn8UK4AzSq1D1pbMZD
        p2KGWjj0yIAleeTq+ahZsHFA5tD7fKc=
X-Google-Smtp-Source: APXvYqxKAfi2Tz6zIC2M0c+D9UwVXDevSqDNALyBUPGEETUlrOjbrasGkAo4OhzwHnfoy3e2g7qstg==
X-Received: by 2002:a63:e853:: with SMTP id a19mr213781pgk.192.1573009625059;
        Tue, 05 Nov 2019 19:07:05 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:07:03 -0800 (PST)
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
        Brian Cain <bcain@codeaurora.org>,
        linux-hexagon@vger.kernel.org
Subject: [PATCH 14/50] hexagon: Add show_stack_loglvl()
Date:   Wed,  6 Nov 2019 03:05:05 +0000
Message-Id: <20191106030542.868541-15-dima@arista.com>
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

Introduce show_stack_loglvl(), that eventually will substitute
show_stack().

As a good side-effect die() now prints the stacktrace with KERN_EMERG
aligned with other messages.

Cc: Brian Cain <bcain@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/hexagon/kernel/traps.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
index 69c623b14ddd..a8a3a210d781 100644
--- a/arch/hexagon/kernel/traps.c
+++ b/arch/hexagon/kernel/traps.c
@@ -79,7 +79,7 @@ static const char *ex_name(int ex)
 }
 
 static void do_show_stack(struct task_struct *task, unsigned long *fp,
-			  unsigned long ip)
+			  unsigned long ip, const char *loglvl)
 {
 	int kstack_depth_to_print = 24;
 	unsigned long offset, size;
@@ -93,9 +93,8 @@ static void do_show_stack(struct task_struct *task, unsigned long *fp,
 	if (task == NULL)
 		task = current;
 
-	printk(KERN_INFO "CPU#%d, %s/%d, Call Trace:\n",
-	       raw_smp_processor_id(), task->comm,
-	       task_pid_nr(task));
+	printk("%sCPU#%d, %s/%d, Call Trace:\n", loglvl, raw_smp_processor_id(),
+		task->comm, task_pid_nr(task));
 
 	if (fp == NULL) {
 		if (task == current) {
@@ -108,7 +107,7 @@ static void do_show_stack(struct task_struct *task, unsigned long *fp,
 	}
 
 	if ((((unsigned long) fp) & 0x3) || ((unsigned long) fp < 0x1000)) {
-		printk(KERN_INFO "-- Corrupt frame pointer %p\n", fp);
+		printk("%s-- Corrupt frame pointer %p\n", loglvl, fp);
 		return;
 	}
 
@@ -125,8 +124,7 @@ static void do_show_stack(struct task_struct *task, unsigned long *fp,
 
 		name = kallsyms_lookup(ip, &size, &offset, &modname, tmpstr);
 
-		printk(KERN_INFO "[%p] 0x%lx: %s + 0x%lx", fp, ip, name,
-			offset);
+		printk("%s[%p] 0x%lx: %s + 0x%lx", loglvl, fp, ip, name, offset);
 		if (((unsigned long) fp < low) || (high < (unsigned long) fp))
 			printk(KERN_CONT " (FP out of bounds!)");
 		if (modname)
@@ -136,8 +134,7 @@ static void do_show_stack(struct task_struct *task, unsigned long *fp,
 		newfp = (unsigned long *) *fp;
 
 		if (((unsigned long) newfp) & 0x3) {
-			printk(KERN_INFO "-- Corrupt frame pointer %p\n",
-				newfp);
+			printk("%s-- Corrupt frame pointer %p\n", loglvl, newfp);
 			break;
 		}
 
@@ -147,7 +144,7 @@ static void do_show_stack(struct task_struct *task, unsigned long *fp,
 						+ 8);
 
 			if (regs->syscall_nr != -1) {
-				printk(KERN_INFO "-- trap0 -- syscall_nr: %ld",
+				printk("%s-- trap0 -- syscall_nr: %ld", loglvl,
 					regs->syscall_nr);
 				printk(KERN_CONT "  psp: %lx  elr: %lx\n",
 					 pt_psp(regs), pt_elr(regs));
@@ -155,7 +152,7 @@ static void do_show_stack(struct task_struct *task, unsigned long *fp,
 			} else {
 				/* really want to see more ... */
 				kstack_depth_to_print += 6;
-				printk(KERN_INFO "-- %s (0x%lx)  badva: %lx\n",
+				printk("%s-- %s (0x%lx)  badva: %lx\n", loglvl,
 					ex_name(pt_cause(regs)), pt_cause(regs),
 					pt_badva(regs));
 			}
@@ -178,10 +175,16 @@ static void do_show_stack(struct task_struct *task, unsigned long *fp,
 	}
 }
 
-void show_stack(struct task_struct *task, unsigned long *fp)
+void show_stack_loglvl(struct task_struct *task, unsigned long *fp,
+		       const char *loglvl)
 {
 	/* Saved link reg is one word above FP */
-	do_show_stack(task, fp, 0);
+	do_show_stack(task, fp, 0, loglvl);
+}
+
+void show_stack(struct task_struct *task, unsigned long *fp)
+{
+	show_stack_loglvl(task, fp, 0, KERN_INFO);
 }
 
 int die(const char *str, struct pt_regs *regs, long err)
@@ -207,7 +210,7 @@ int die(const char *str, struct pt_regs *regs, long err)
 
 	print_modules();
 	show_regs(regs);
-	do_show_stack(current, &regs->r30, pt_elr(regs));
+	do_show_stack(current, &regs->r30, pt_elr(regs), KERN_EMERG);
 
 	bust_spinlocks(0);
 	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
-- 
2.23.0

