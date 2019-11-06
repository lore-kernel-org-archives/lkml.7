Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E995FC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A805B222D1
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="nLP1d2e2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387815AbfKFDHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:07:19 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43861 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387798AbfKFDHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:07:17 -0500
Received: by mail-pl1-f196.google.com with SMTP id a18so9586719plm.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JZYE/ewgIGVQN3SETqRGCKyRRQ9kPJBSjSctgfCGzmI=;
        b=nLP1d2e2Te0gn5nPvtAOYRih9fumFyfqXn754d1E64bS9B713b9m99kHMOkDo5Fo10
         Cj/h2S4vDwUB8g5tc/IFIfJk/Lp1XMqidQJvUIV1low09lFNrrioTZtVJpR33BqIAVdw
         XrWrJux36oGAT4EPD8s/uSmQecQ3Zph56hvTmGr2GhYFYm/G4jpsCBcPCf2FmaV6cYFU
         A1LG1vvMjeAXLPeG30wLZ/V2z97NzHzu28O1IG7PJahuflj6FBvbf5vXPv/T7meXQHXu
         vDpDBbnvU9NTGbq+uT+9lAsE81sS3hJ0zFRfwRdSee2iRYpM1iyFU80zPc0LI+++jEDa
         6vGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JZYE/ewgIGVQN3SETqRGCKyRRQ9kPJBSjSctgfCGzmI=;
        b=I8OwWY392oUEbuljH0jBNK2hx8dXd2ynNEC/OaxniuhHkXCHOKhNZ8INDIXrArH3/F
         UsaezzrBUDTbhZoKLs698aG6eXIw+gBChcO6P9sYBhbPjQasRamIUCfXJCz5X9OcNdsn
         pBMX83wKQNzEgCt55p1UEdGodQQ2oQu2gHikTJYZ+XHc1HVFxDjkXOkZaSLBPzxWN+id
         8NNb0Gl8NhRQPt0t/Z4vZV9zQs3wkNerqZt7NQLx3pbO681UR2UwBlAknTWgdgOxeCHD
         nJY0z2Zm3VVPwxy7Vl9wrqefJlN2I37foDugh0jgySsCc+I2xw9ECCX/V/w4Qu0+Mqtb
         3qSQ==
X-Gm-Message-State: APjAAAVmUvms4SLGR4Q+aBLmm3Qxz4eYpdMuEz2a9cXUSxtUA0LrEQ2+
        aYel7/5wo4flGlRDWsysnj4BLHGzqko=
X-Google-Smtp-Source: APXvYqxwKpKOinPS7MCoZCLsdjm51eQZfBWI/b586LSINuZfk8leVuwP2FNWJwCLQK88K7XbfzTlPQ==
X-Received: by 2002:a17:902:9681:: with SMTP id n1mr158196plp.87.1573009636050;
        Tue, 05 Nov 2019 19:07:16 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:07:15 -0800 (PST)
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
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH 17/50] m68k: Add show_stack_loglvl()
Date:   Wed,  6 Nov 2019 03:05:08 +0000
Message-Id: <20191106030542.868541-18-dima@arista.com>
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

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/m68k/kernel/traps.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
index 344f93d36a9a..ffcc5ec4fac3 100644
--- a/arch/m68k/kernel/traps.c
+++ b/arch/m68k/kernel/traps.c
@@ -811,13 +811,13 @@ asmlinkage void buserr_c(struct frame *fp)
 
 static int kstack_depth_to_print = 48;
 
-void show_trace(unsigned long *stack)
+static void show_trace(unsigned long *stack, const char *loglvl)
 {
 	unsigned long *endstack;
 	unsigned long addr;
 	int i;
 
-	pr_info("Call Trace:");
+	printk("%sCall Trace:", loglvl);
 	addr = (unsigned long)stack + THREAD_SIZE - 1;
 	endstack = (unsigned long *)(addr & -THREAD_SIZE);
 	i = 0;
@@ -935,7 +935,8 @@ void show_registers(struct pt_regs *regs)
 	pr_cont("\n");
 }
 
-void show_stack(struct task_struct *task, unsigned long *stack)
+void show_stack_loglvl(struct task_struct *task, unsigned long *stack,
+		       const char *loglvl)
 {
 	unsigned long *p;
 	unsigned long *endstack;
@@ -949,7 +950,7 @@ void show_stack(struct task_struct *task, unsigned long *stack)
 	}
 	endstack = (unsigned long *)(((unsigned long)stack + THREAD_SIZE - 1) & -THREAD_SIZE);
 
-	pr_info("Stack from %08lx:", (unsigned long)stack);
+	printk("%sStack from %08lx:", loglvl, (unsigned long)stack);
 	p = stack;
 	for (i = 0; i < kstack_depth_to_print; i++) {
 		if (p + 1 > endstack)
@@ -959,7 +960,12 @@ void show_stack(struct task_struct *task, unsigned long *stack)
 		pr_cont(" %08lx", *p++);
 	}
 	pr_cont("\n");
-	show_trace(stack);
+	show_trace(stack, loglvl);
+}
+
+void show_stack(struct task_struct *task, unsigned long *stack)
+{
+	show_stack_loglvl(task, stack, KERN_INFO);
 }
 
 /*
-- 
2.23.0

