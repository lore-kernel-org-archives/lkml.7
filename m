Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD0FC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C7BD206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfD0PQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:16:07 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33678 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727518AbfD0PPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:30 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP31-00014H-9k; Sat, 27 Apr 2019 16:15:27 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2l-0004YD-Cw; Sat, 27 Apr 2019 16:15:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Helge Deller" <deller@gmx.de>,
        "Richard Weinberger" <richard@nod.at>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.162997328@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 122/202] parisc: Use get_signal() signal_setup_done()
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Weinberger <richard@nod.at>

commit e4dc894b61776733629b24507031dd46f5ba5efc upstream.

Use the more generic functions get_signal() signal_setup_done()
for signal delivery.

Signed-off-by: Richard Weinberger <richard@nod.at>
Acked-by: Helge Deller <deller@gmx.de>
[bwh: Backported to 3.16 as dependency of commit 35634ffa1751
 "signal: Always notice exiting tasks"]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/parisc/kernel/signal.c | 58 +++++++++++++++----------------------
 1 file changed, 24 insertions(+), 34 deletions(-)

--- a/arch/parisc/kernel/signal.c
+++ b/arch/parisc/kernel/signal.c
@@ -227,8 +227,8 @@ setup_sigcontext(struct sigcontext __use
 }
 
 static long
-setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
-	       sigset_t *set, struct pt_regs *regs, int in_syscall)
+setup_rt_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs,
+	       int in_syscall)
 {
 	struct rt_sigframe __user *frame;
 	unsigned long rp, usp;
@@ -241,10 +241,10 @@ setup_rt_frame(int sig, struct k_sigacti
 	
 	usp = (regs->gr[30] & ~(0x01UL));
 	/*FIXME: frame_size parameter is unused, remove it. */
-	frame = get_sigframe(ka, usp, sizeof(*frame));
+	frame = get_sigframe(&ksig->ka, usp, sizeof(*frame));
 
 	DBG(1,"SETUP_RT_FRAME: START\n");
-	DBG(1,"setup_rt_frame: frame %p info %p\n", frame, info);
+	DBG(1,"setup_rt_frame: frame %p info %p\n", frame, ksig->info);
 
 	
 #ifdef CONFIG_64BIT
@@ -253,7 +253,7 @@ setup_rt_frame(int sig, struct k_sigacti
 	
 	if (is_compat_task()) {
 		DBG(1,"setup_rt_frame: frame->info = 0x%p\n", &compat_frame->info);
-		err |= copy_siginfo_to_user32(&compat_frame->info, info);
+		err |= copy_siginfo_to_user32(&compat_frame->info, &ksig->info);
 		err |= __compat_save_altstack( &compat_frame->uc.uc_stack, regs->gr[30]);
 		DBG(1,"setup_rt_frame: frame->uc = 0x%p\n", &compat_frame->uc);
 		DBG(1,"setup_rt_frame: frame->uc.uc_mcontext = 0x%p\n", &compat_frame->uc.uc_mcontext);
@@ -265,7 +265,7 @@ setup_rt_frame(int sig, struct k_sigacti
 #endif
 	{	
 		DBG(1,"setup_rt_frame: frame->info = 0x%p\n", &frame->info);
-		err |= copy_siginfo_to_user(&frame->info, info);
+		err |= copy_siginfo_to_user(&frame->info, &ksig->info);
 		err |= __save_altstack(&frame->uc.uc_stack, regs->gr[30]);
 		DBG(1,"setup_rt_frame: frame->uc = 0x%p\n", &frame->uc);
 		DBG(1,"setup_rt_frame: frame->uc.uc_mcontext = 0x%p\n", &frame->uc.uc_mcontext);
@@ -275,7 +275,7 @@ setup_rt_frame(int sig, struct k_sigacti
 	}
 	
 	if (err)
-		goto give_sigsegv;
+		return -EFAULT;
 
 	/* Set up to return from userspace.  If provided, use a stub
 	   already in userspace. The first words of tramp are used to
@@ -312,9 +312,9 @@ setup_rt_frame(int sig, struct k_sigacti
 	rp = (unsigned long) &frame->tramp[SIGRESTARTBLOCK_TRAMP];
 
 	if (err)
-		goto give_sigsegv;
+		return -EFAULT;
 
-	haddr = A(ka->sa.sa_handler);
+	haddr = A(ksig->ka.sa.sa_handler);
 	/* The sa_handler may be a pointer to a function descriptor */
 #ifdef CONFIG_64BIT
 	if (is_compat_task()) {
@@ -326,7 +326,7 @@ setup_rt_frame(int sig, struct k_sigacti
 			err = __copy_from_user(&fdesc, ufdesc, sizeof(fdesc));
 
 			if (err)
-				goto give_sigsegv;
+				return -EFAULT;
 
 			haddr = fdesc.addr;
 			regs->gr[19] = fdesc.gp;
@@ -339,7 +339,7 @@ setup_rt_frame(int sig, struct k_sigacti
 		err = __copy_from_user(&fdesc, ufdesc, sizeof(fdesc));
 		
 		if (err)
-			goto give_sigsegv;
+			return -EFAULT;
 		
 		haddr = fdesc.addr;
 		regs->gr[19] = fdesc.gp;
@@ -386,7 +386,7 @@ setup_rt_frame(int sig, struct k_sigacti
 	}
 
 	regs->gr[2]  = rp;                /* userland return pointer */
-	regs->gr[26] = sig;               /* signal number */
+	regs->gr[26] = ksig->sig;               /* signal number */
 	
 #ifdef CONFIG_64BIT
 	if (is_compat_task()) {
@@ -410,11 +410,6 @@ setup_rt_frame(int sig, struct k_sigacti
 	       current->comm, current->pid, frame, regs->gr[30],
 	       regs->iaoq[0], regs->iaoq[1], rp);
 
-	return 1;
-
-give_sigsegv:
-	DBG(1,"setup_rt_frame: sending SIGSEGV\n");
-	force_sigsegv(sig, current);
 	return 0;
 }
 
@@ -423,20 +418,19 @@ give_sigsegv:
  */	
 
 static void
-handle_signal(unsigned long sig, siginfo_t *info, struct k_sigaction *ka,
-		struct pt_regs *regs, int in_syscall)
+handle_signal(struct ksignal *ksig, struct pt_regs *regs, int in_syscall)
 {
+	int ret;
 	sigset_t *oldset = sigmask_to_save();
+
 	DBG(1,"handle_signal: sig=%ld, ka=%p, info=%p, oldset=%p, regs=%p\n",
-	       sig, ka, info, oldset, regs);
+	       ksig->sig, ksig->ka, ksig->info, oldset, regs);
 	
 	/* Set up the stack frame */
-	if (!setup_rt_frame(sig, ka, info, oldset, regs, in_syscall))
-		return;
+	ret = setup_rt_frame(ksig, oldset, regs, in_syscall);
 
-	signal_delivered(sig, info, ka, regs, 
-		test_thread_flag(TIF_SINGLESTEP) ||
-		test_thread_flag(TIF_BLOCKSTEP));
+	signal_setup_done(ret, ksig, test_thread_flag(TIF_SINGLESTEP) ||
+			  test_thread_flag(TIF_BLOCKSTEP));
 
 	DBG(1,KERN_DEBUG "do_signal: Exit (success), regs->gr[28] = %ld\n",
 		regs->gr[28]);
@@ -584,22 +578,18 @@ insert_restart_trampoline(struct pt_regs
 asmlinkage void
 do_signal(struct pt_regs *regs, long in_syscall)
 {
-	siginfo_t info;
-	struct k_sigaction ka;
-	int signr;
+	struct ksignal ksig;
 
 	DBG(1,"\ndo_signal: regs=0x%p, sr7 %#lx, in_syscall=%d\n",
 	       regs, regs->sr[7], in_syscall);
 
-	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
-	DBG(3,"do_signal: signr = %d, regs->gr[28] = %ld\n", signr, regs->gr[28]); 
-	
-	if (signr > 0) {
+	if (get_signal(&ksig)) {
+		DBG(3,"do_signal: signr = %d, regs->gr[28] = %ld\n", signr, regs->gr[28]);
 		/* Restart a system call if necessary. */
 		if (in_syscall)
-			syscall_restart(regs, &ka);
+			syscall_restart(regs, &ksig.ka);
 
-		handle_signal(signr, &info, &ka, regs, in_syscall);
+		handle_signal(&ksig, regs, in_syscall);
 		return;
 	}
 

