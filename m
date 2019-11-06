Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B1AC5DF60
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F3E21D7F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Y78ib1EA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730978AbfKFDGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:06:18 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42344 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730562AbfKFDGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:06:17 -0500
Received: by mail-pl1-f195.google.com with SMTP id j12so8780978plt.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4PbPbG3xiwoOJTkylYr8VA6+FLnFH1+TvXbWRkNE+nU=;
        b=Y78ib1EAmjlsARGcXbwqm9h8m+Cl/nHAT2wuTf58ICIMhaYMJ/xFZCpMMZRmfuYB6P
         iRoBMOXe4IL9fNry8o+5G+c90uPUP/mDzS4Drkgfd7ZSUA97U317PThYtttJgJQuoRb3
         WPkVBXS+alxCP3Musb9oxPejy9RpiKLy/3dyLieHKWqhryvV1N2vWCVg99HERCE6+mgz
         bFmdzeRFg4+3KfU3pRlKpnxsylHPjXU5nkdQzJ2ClfyNADDwDcyneAwz9Hm7md9u48xb
         Fl0yKQUcss+4I5F9/2xiazlJhRPcn+eAFgR0PLHGQte3/EDoJ/wXmAt2bRPlv5eAVoyE
         7N4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4PbPbG3xiwoOJTkylYr8VA6+FLnFH1+TvXbWRkNE+nU=;
        b=i+x9SUEjbcfj0IBmb8wcqAV4+mk7A44Hta35w0Hrbwd0sAAFXkyi/QCHYQvzH1xSqJ
         +IzqNoE0iCpIbnNKqfkL9YnGufXObmNrEUocU3r2UZCGiOv8wji6hyQ+FoDhJmrjeh7r
         V3pjzGIuGaoDZYMygZ22ZRWUYQSLqkO3ibxrcjYnpZLrqikUhfNt62OmV0rmn21yUWCk
         l+rP1Tf0evMMBLhjKOZOE2nklejcr9oZ3bqioOmQ5h0rDAELT98eFJ61hMrMxYlpvSCy
         ynZkxomxE4N0fddKi2Erez1ZxVte+clZifFfoaOxSntI39spnJiBXbn16TkLtVuxotZM
         S9wQ==
X-Gm-Message-State: APjAAAUDurFCN7H2v8Tggo97xzCqK0CIaKunIFqz0ygXdw89pahwF/V+
        NVR7+aw/dobtISLlg3gQynm0G3dnq5w=
X-Google-Smtp-Source: APXvYqzbnfA55uz7FrhcowDlwwnuG8AO3taSS1bAU60wYgHHe/i2mtrt7hSdTb/FYPlgUPwyC5frFg==
X-Received: by 2002:a17:902:aa0b:: with SMTP id be11mr175019plb.258.1573009575902;
        Tue, 05 Nov 2019 19:06:15 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:06:14 -0800 (PST)
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
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Richard Henderson <rth@twiddle.net>,
        linux-alpha@vger.kernel.org
Subject: [PATCH 02/50] alpha: Add show_stack_loglvl()
Date:   Wed,  6 Nov 2019 03:04:53 +0000
Message-Id: <20191106030542.868541-3-dima@arista.com>
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

Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: linux-alpha@vger.kernel.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/alpha/kernel/traps.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/alpha/kernel/traps.c b/arch/alpha/kernel/traps.c
index f6b9664ac504..2402f1777f54 100644
--- a/arch/alpha/kernel/traps.c
+++ b/arch/alpha/kernel/traps.c
@@ -121,10 +121,10 @@ dik_show_code(unsigned int *pc)
 }
 
 static void
-dik_show_trace(unsigned long *sp)
+dik_show_trace(unsigned long *sp, const char *loglvl)
 {
 	long i = 0;
-	printk("Trace:\n");
+	printk("%sTrace:\n", loglvl);
 	while (0x1ff8 & (unsigned long) sp) {
 		extern char _stext[], _etext[];
 		unsigned long tmp = *sp;
@@ -133,24 +133,25 @@ dik_show_trace(unsigned long *sp)
 			continue;
 		if (tmp >= (unsigned long) &_etext)
 			continue;
-		printk("[<%lx>] %pSR\n", tmp, (void *)tmp);
+		printk("%s[<%lx>] %pSR\n", loglvl, tmp, (void *)tmp);
 		if (i > 40) {
-			printk(" ...");
+			printk("%s ...", loglvl);
 			break;
 		}
 	}
-	printk("\n");
+	printk("%s\n", loglvl);
 }
 
 static int kstack_depth_to_print = 24;
 
-void show_stack(struct task_struct *task, unsigned long *sp)
+void show_stack_loglvl(struct task_struct *task, unsigned long *sp,
+			const char *loglvl)
 {
 	unsigned long *stack;
 	int i;
 
 	/*
-	 * debugging aid: "show_stack(NULL);" prints the
+	 * debugging aid: "show_stack(NULL, NULL, KERN_EMERG);" prints the
 	 * back trace for this cpu.
 	 */
 	if(sp==NULL)
@@ -163,14 +164,19 @@ void show_stack(struct task_struct *task, unsigned long *sp)
 		if ((i % 4) == 0) {
 			if (i)
 				pr_cont("\n");
-			printk("       ");
+			printk("%s       ", loglvl);
 		} else {
 			pr_cont(" ");
 		}
 		pr_cont("%016lx", *stack++);
 	}
 	pr_cont("\n");
-	dik_show_trace(sp);
+	dik_show_trace(sp, loglvl);
+}
+
+void show_stack(struct task_struct *task, unsigned long *sp)
+{
+	show_stack_loglvl(task, sp, KERN_DEFAULT);
 }
 
 void
@@ -184,7 +190,7 @@ die_if_kernel(char * str, struct pt_regs *regs, long err, unsigned long *r9_15)
 	printk("%s(%d): %s %ld\n", current->comm, task_pid_nr(current), str, err);
 	dik_show_regs(regs, r9_15);
 	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
-	dik_show_trace((unsigned long *)(regs+1));
+	dik_show_trace((unsigned long *)(regs+1), KERN_DEFAULT);
 	dik_show_code((unsigned int *)regs->pc);
 
 	if (test_and_set_thread_flag (TIF_DIE_IF_KERNEL)) {
@@ -625,7 +631,7 @@ do_entUna(void * va, unsigned long opcode, unsigned long reg,
 	printk("gp = %016lx  sp = %p\n", regs->gp, regs+1);
 
 	dik_show_code((unsigned int *)pc);
-	dik_show_trace((unsigned long *)(regs+1));
+	dik_show_trace((unsigned long *)(regs+1), KERN_DEFAULT);
 
 	if (test_and_set_thread_flag (TIF_DIE_IF_KERNEL)) {
 		printk("die_if_kernel recursion detected.\n");
-- 
2.23.0

