Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3C1C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D94217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Nf5JGZ/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388014AbfKFDHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:07:51 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39157 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387725AbfKFDHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:07:49 -0500
Received: by mail-pg1-f196.google.com with SMTP id 29so4803587pgm.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A42sQfdtZGvvJpni2Nb7vaaL0m1YMvpAbCmvF65Mdzo=;
        b=Nf5JGZ/vip8cpITlSsoBa9786IxBla7auOYhFREcClO6iKKT0OjXzSwHV59fzD+2Q6
         IwhkOWOPi1FNiR7brBxHFfA5Gt5QzN/Ya6VO9thrccpKgCTEhXAkgo3DZYsuMpQZcGzs
         G8YqmUbK2DK5MP6l8MQnlNMehEezmP6Ik/aZ7fNZLZfFztlw1377d8iPpShLfE/YZWiT
         FH0GzxhdW/A87Vvoou9rZogo+0Qf+2Bc3CFe8gVTYDG9YUnHsq29MTelAUchDsuxGsqs
         H+kFsPZl+HrcubwVXzmT7oN/6EIH/+hj+0O/VTARA3tsUpOhKjdZrGmM+5chI2gxr7QX
         ee6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A42sQfdtZGvvJpni2Nb7vaaL0m1YMvpAbCmvF65Mdzo=;
        b=hEi4bk+DmuVdLr1MZ1IDlK2kxj7yzT0SOabJ8b6C2GYyy4QimDNkS7OHJxF4d9JlGJ
         dx8Coxz/QkUZpM2+lSgMjIFGD7IiVXQuv0HwMtRE4hNMRkdMhJr+jEuZdi3HMeVMsTPy
         sAeevsZ8dkkVgeUgoimFI7/onEcW6QRPb7bAvO2twiVHZldE8EwMLaTHMZ9ddJlctT+b
         VI0pNFUzGqEF6lRdXtMiJOoxaFNYL+zUAOx3RZhtID+AGlm1T+TRlrgkcMoF1hu1ype7
         XVomy7QCcNsy8YzfRIDKbMYLPmHXBmBjFWGCpDcD9RzCNho7wPgGOOKwHUeWAfHaJkOv
         HX1w==
X-Gm-Message-State: APjAAAVzv34ObesyFKolBHlubczYZgfGq55U1oxsg/Y0VGEx4ywavZpY
        IpLLmy6OQG5qH9pFkJ3vo/zsu3perg0=
X-Google-Smtp-Source: APXvYqyYY7aG4uJ1aEuuexdWlbBTCRur/Byf7xyppq3DhY1cc29CyH3Dmh0y0d0cvxhW2psMqzHzrQ==
X-Received: by 2002:a65:49c7:: with SMTP id t7mr161066pgs.431.1573009668489;
        Tue, 05 Nov 2019 19:07:48 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:07:47 -0800 (PST)
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
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 26/50] powerpc: Add show_stack_loglvl()
Date:   Wed,  6 Nov 2019 03:05:17 +0000
Message-Id: <20191106030542.868541-27-dima@arista.com>
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

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/powerpc/kernel/process.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 639ceae7da9d..34b46680a196 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -2028,7 +2028,8 @@ unsigned long get_wchan(struct task_struct *p)
 
 static int kstack_depth_to_print = CONFIG_PRINT_STACK_DEPTH;
 
-void show_stack(struct task_struct *tsk, unsigned long *stack)
+void show_stack_loglvl(struct task_struct *tsk, unsigned long *stack,
+		       const char *loglvl)
 {
 	unsigned long sp, ip, lr, newsp;
 	int count = 0;
@@ -2053,7 +2054,7 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
 	}
 
 	lr = 0;
-	printk("Call Trace:\n");
+	printk("%sCall Trace:\n", loglvl);
 	do {
 		if (!validate_sp(sp, tsk, STACK_FRAME_OVERHEAD))
 			break;
@@ -2062,7 +2063,8 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
 		newsp = stack[0];
 		ip = stack[STACK_FRAME_LR_SAVE];
 		if (!firstframe || ip != lr) {
-			printk("["REG"] ["REG"] %pS", sp, ip, (void *)ip);
+			printk("%s["REG"] ["REG"] %pS",
+				loglvl, sp, ip, (void *)ip);
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 			ret_addr = ftrace_graph_ret_addr(current,
 						&ftrace_idx, ip, stack);
@@ -2084,8 +2086,9 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
 			struct pt_regs *regs = (struct pt_regs *)
 				(sp + STACK_FRAME_OVERHEAD);
 			lr = regs->link;
-			printk("--- interrupt: %lx at %pS\n    LR = %pS\n",
-			       regs->trap, (void *)regs->nip, (void *)lr);
+			printk("%s--- interrupt: %lx at %pS\n    LR = %pS\n",
+			       loglvl, regs->trap,
+			       (void *)regs->nip, (void *)lr);
 			firstframe = 1;
 		}
 
@@ -2095,6 +2098,11 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
 	put_task_stack(tsk);
 }
 
+void show_stack(struct task_struct *tsk, unsigned long *stack)
+{
+	show_stack_loglvl(tsk, stack, KERN_DEFAULT);
+}
+
 #ifdef CONFIG_PPC64
 /* Called with hard IRQs off */
 void notrace __ppc64_runlatch_on(void)
-- 
2.23.0

