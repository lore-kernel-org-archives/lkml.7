Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742FAC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24567222C9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="dGYz6wv+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388335AbfKFDId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:08:33 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34677 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388273AbfKFDI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:08:26 -0500
Received: by mail-pf1-f196.google.com with SMTP id n13so6017398pff.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P3KAk4JFoRkmJY5UYpiE9Ad5UYmzG6Av2SQ7Rw3IXDc=;
        b=dGYz6wv+PceywAO0mjiAaPM4I4bawDqWfU0ekn7Khp2ckO0xcUgC6siNIdOcsLrIJa
         CwNbiBvkxpIeOwrQG0ige6I0s0ZUJZJXCCn0XLM9SL05aboewYqMvzrLYy474/QrUgPX
         HSe32vbj8VdIN4wjowemksP8tv+Z4nMKtzvqmJct24falWE7rbEDc0MB/qPr1yReKu4m
         cZSNYjqbdGQJsEhjsiC3YA5jp766XNhrQ2J8Ba7zdsJncLXScFm8v8WL1R1+JfRuozuX
         ope2lbXxPUS1ru6xuoqxDO4VZENci0YUGSCH27LJrKvs2uF0SGZDLU2Dg/bPb4M7os2A
         o/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P3KAk4JFoRkmJY5UYpiE9Ad5UYmzG6Av2SQ7Rw3IXDc=;
        b=PADCZjHeeIJocDa7JODDjUkz+f8473Mqtv+qtJKR6RymRZiVOYz1gV4FgyDmz7t4uC
         eu8ylfb0QLdFMsATytSVLqkJ03wvnc5lam9/we2JZ4B3+wPRy7vtz1Fal5UsN16EJEKb
         qlpANkQv5ghCVJsaKZNvzial3ZX0YQ+YUWA/9jDQALlHCsWyBwNLeYLNahp5a1xjm2BL
         voz+BtQUrmdvT6mZkKbBsYcqCUTQ3v6yNSatM2mq3rYsmTGA93C2iBpuEJxlsB7pE703
         NtabvCiYk90eJz9yM4gXVH30NhOv7bU7mRIWxdX8uCxIvwr5dH2D5Aim5fEMz0+sJudV
         JllA==
X-Gm-Message-State: APjAAAXKENu5H004AdszW7rKxH40VBqLlaG9RJowH+aq38f1m/44xLdm
        FD6vcF/iimNjHVGYLvpUODAjSHXzmXQ=
X-Google-Smtp-Source: APXvYqzdoADpYOilv6zYZDLM1SN3kH63KqdGum7CjWRsWYBdHmb16/bpBc5NmIQ9TPPC/7aTNfzH4g==
X-Received: by 2002:a17:90a:340c:: with SMTP id o12mr657765pjb.18.1573009705238;
        Tue, 05 Nov 2019 19:08:25 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:08:24 -0800 (PST)
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
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org
Subject: [PATCH 36/50] um: Add show_stack_loglvl()
Date:   Wed,  6 Nov 2019 03:05:27 +0000
Message-Id: <20191106030542.868541-37-dima@arista.com>
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

Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: linux-um@lists.infradead.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/um/kernel/sysrq.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/um/kernel/sysrq.c b/arch/um/kernel/sysrq.c
index c831a1c2eb94..1b54b6431499 100644
--- a/arch/um/kernel/sysrq.c
+++ b/arch/um/kernel/sysrq.c
@@ -17,7 +17,9 @@
 
 static void _print_addr(void *data, unsigned long address, int reliable)
 {
-	pr_info(" [<%08lx>] %s%pS\n", address, reliable ? "" : "? ",
+	const char *loglvl = data;
+
+	printk("%s [<%08lx>] %s%pS\n", loglvl, address, reliable ? "" : "? ",
 		(void *)address);
 }
 
@@ -25,7 +27,8 @@ static const struct stacktrace_ops stackops = {
 	.address = _print_addr
 };
 
-void show_stack(struct task_struct *task, unsigned long *stack)
+void show_stack_loglvl(struct task_struct *task, unsigned long *stack,
+		       const char *loglvl)
 {
 	struct pt_regs *segv_regs = current->thread.segv_regs;
 	int i;
@@ -39,17 +42,22 @@ void show_stack(struct task_struct *task, unsigned long *stack)
 	if (!stack)
 		stack = get_stack_pointer(task, segv_regs);
 
-	pr_info("Stack:\n");
+	printk("%sStack:\n", loglvl);
 	for (i = 0; i < 3 * STACKSLOTS_PER_LINE; i++) {
 		if (kstack_end(stack))
 			break;
 		if (i && ((i % STACKSLOTS_PER_LINE) == 0))
-			pr_cont("\n");
+			printk("%s\n", loglvl);
 		pr_cont(" %08lx", *stack++);
 	}
-	pr_cont("\n");
+	printk("%s\n", loglvl);
+
+	printk("%sCall Trace:\n", loglvl);
+	dump_trace(current, &stackops, (void *)loglvl);
+	printk("%s\n", loglvl);
+}
 
-	pr_info("Call Trace:\n");
-	dump_trace(current, &stackops, NULL);
-	pr_info("\n");
+void show_stack(struct task_struct *task, unsigned long *stack)
+{
+	show_stack_loglvl(task, stack, KERN_INFO);
 }
-- 
2.23.0

