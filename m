Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998C5C5DF60
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF2021882
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Gbz9N5N5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387677AbfKFDGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:06:55 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46756 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387468AbfKFDGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:06:54 -0500
Received: by mail-pf1-f193.google.com with SMTP id 193so16421351pfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QHTA+iC6moLipQa10hTx6WASZTRHBzKdW5w66nfFcmM=;
        b=Gbz9N5N5ZBjZJK8/uO5Az4Haqn3bo3ifeS2cEHVTwUMxpHLGJ5hWHZS6YTaHe0oFl0
         SR2O7k6uwqq/pf4+XU66FzGgrx8IWkhDLW0GjFiSa6ohJ4EaTqlZVfVoNSHu2RkN23D5
         rC5gL6SMrGQB0KQNMx0qkG2ya2T+Ky0PLBpI/4O1w5KUwWfTVtX7ZvHOV8sjIPz6/BBq
         zWGScRIX3Xn29VVh8xOzoQEzsjFdyt9Qgu4KLs+ENxxH5mAH8e8pkG1zAhvqCXLYOrMy
         GAmEJx4O8vC9YppkfAlW89okZgx9m34th8lSNZgVZpRFQ6h7T+5bIVRZuEwC7XIghEZF
         253w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QHTA+iC6moLipQa10hTx6WASZTRHBzKdW5w66nfFcmM=;
        b=sOhJ/ZQFxWmB3XsiQmfWrj5BW+dxmp2JDE/+wr4RoTru8rVs3MyetGFnLTrwKpciSH
         SmSvH3jyUb4gL/ACPF0qufrNmjOtn8K+Y2EbWzkFjQJrw8H/tokBG/vvrxzhqUWZUoxx
         rUWoKSQ16lvPrygMWyuVDA0ydQtipUgT/gEOoueH3sx99azFWDLKLJmDKpjCfjZeAFeG
         4Uj0pSpXmnmSNzh3qDmf28egTuAnTY73buf8dFUDCsn1s17pDTaCY5ogU+msv/g4r3CW
         oucbxc0kGsEi1Ee7XOIMFXg+WwMzcxpt6NEFmMHujhUL7mDi9tJNRpLr8DPZSpkvG6l4
         CSZA==
X-Gm-Message-State: APjAAAUGRjJrCeOe8DHB8RAieYWo2K8N4LhL8h51BcV+k4m2BdYQElWA
        3Y+g3SNQDZpCd/s0y1thZnVu30/IgqQ=
X-Google-Smtp-Source: APXvYqzfag2pb1ukKS/l6hb0dPvFivy5TO5gc6xFluRmfUwV5jF8z4pbTYQqz3rEvkfR9mMspyvakA==
X-Received: by 2002:a17:90a:1b69:: with SMTP id q96mr578820pjq.89.1573009613065;
        Tue, 05 Nov 2019 19:06:53 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:06:52 -0800 (PST)
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
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Mark Salter <msalter@redhat.com>, linux-c6x-dev@linux-c6x.org
Subject: [PATCH 11/50] c6x: Add show_stack_loglvl()
Date:   Wed,  6 Nov 2019 03:05:02 +0000
Message-Id: <20191106030542.868541-12-dima@arista.com>
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

Cc: Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
Cc: Mark Salter <msalter@redhat.com>
Cc: linux-c6x-dev@linux-c6x.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/c6x/kernel/traps.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/c6x/kernel/traps.c b/arch/c6x/kernel/traps.c
index ec61034fdf56..07704670236b 100644
--- a/arch/c6x/kernel/traps.c
+++ b/arch/c6x/kernel/traps.c
@@ -344,12 +344,13 @@ asmlinkage int process_exception(struct pt_regs *regs)
 
 static int kstack_depth_to_print = 48;
 
-static void show_trace(unsigned long *stack, unsigned long *endstack)
+static void show_trace(unsigned long *stack, unsigned long *endstack,
+		       const char *loglvl)
 {
 	unsigned long addr;
 	int i;
 
-	pr_debug("Call trace:");
+	printk("%sCall trace:", loglvl);
 	i = 0;
 	while (stack + 1 <= endstack) {
 		addr = *stack++;
@@ -364,16 +365,17 @@ static void show_trace(unsigned long *stack, unsigned long *endstack)
 		if (__kernel_text_address(addr)) {
 #ifndef CONFIG_KALLSYMS
 			if (i % 5 == 0)
-				pr_debug("\n	    ");
+				printk("%s\n	    ", loglvl);
 #endif
-			pr_debug(" [<%08lx>] %pS\n", addr, (void *)addr);
+			printk("%s [<%08lx>] %pS\n", loglvl, addr, (void *)addr);
 			i++;
 		}
 	}
-	pr_debug("\n");
+	printk("%s\n", loglvl);
 }
 
-void show_stack(struct task_struct *task, unsigned long *stack)
+void show_stack_loglvl(struct task_struct *task, unsigned long *stack,
+		const char *loglvl)
 {
 	unsigned long *p, *endstack;
 	int i;
@@ -389,7 +391,7 @@ void show_stack(struct task_struct *task, unsigned long *stack)
 	endstack = (unsigned long *)(((unsigned long)stack + THREAD_SIZE - 1)
 				     & -THREAD_SIZE);
 
-	pr_debug("Stack from %08lx:", (unsigned long)stack);
+	printk("%sStack from %08lx:", loglvl, (unsigned long)stack);
 	for (i = 0, p = stack; i < kstack_depth_to_print; i++) {
 		if (p + 1 > endstack)
 			break;
@@ -398,7 +400,12 @@ void show_stack(struct task_struct *task, unsigned long *stack)
 		pr_cont(" %08lx", *p++);
 	}
 	pr_cont("\n");
-	show_trace(stack, endstack);
+	show_trace(stack, endstack, loglvl);
+}
+
+void show_stack(struct task_struct *task, unsigned long *stack)
+{
+	show_stack_loglvl(task, stack, KERN_DEBUG);
 }
 
 int is_valid_bugaddr(unsigned long addr)
-- 
2.23.0

