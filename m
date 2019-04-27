Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D68AC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766E1208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfD0PWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:22:25 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33772 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727545AbfD0PPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:31 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP32-0000zK-Dv; Sat, 27 Apr 2019 16:15:28 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2l-0004Xe-4V; Sat, 27 Apr 2019 16:15:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Richard Weinberger" <richard@nod.at>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.139885900@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 115/202] ia64: Use get_signal() signal_setup_done()
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

commit 98c20309b97fc30001adf643cf876125f334fd8a upstream.

Use the more generic functions get_signal() signal_setup_done()
for signal delivery.
This inverts also the return codes of force_sigsegv_info()
and setup_frame() to follow the kernel convention.

Signed-off-by: Richard Weinberger <richard@nod.at>
[bwh: Backported to 3.16 as dependency of commit 35634ffa1751
 "signal: Always notice exiting tasks"]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/ia64/kernel/signal.c | 46 ++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

--- a/arch/ia64/kernel/signal.c
+++ b/arch/ia64/kernel/signal.c
@@ -309,12 +309,11 @@ force_sigsegv_info (int sig, void __user
 	si.si_uid = from_kuid_munged(current_user_ns(), current_uid());
 	si.si_addr = addr;
 	force_sig_info(SIGSEGV, &si, current);
-	return 0;
+	return 1;
 }
 
 static long
-setup_frame (int sig, struct k_sigaction *ka, siginfo_t *info, sigset_t *set,
-	     struct sigscratch *scr)
+setup_frame(struct ksignal *ksig, sigset_t *set, struct sigscratch *scr)
 {
 	extern char __kernel_sigtramp[];
 	unsigned long tramp_addr, new_rbs = 0, new_sp;
@@ -323,7 +322,7 @@ setup_frame (int sig, struct k_sigaction
 
 	new_sp = scr->pt.r12;
 	tramp_addr = (unsigned long) __kernel_sigtramp;
-	if (ka->sa.sa_flags & SA_ONSTACK) {
+	if (ksig->ka.sa.sa_flags & SA_ONSTACK) {
 		int onstack = sas_ss_flags(new_sp);
 
 		if (onstack == 0) {
@@ -347,29 +346,29 @@ setup_frame (int sig, struct k_sigaction
 			 */
 			check_sp = (new_sp - sizeof(*frame)) & -STACK_ALIGN;
 			if (!likely(on_sig_stack(check_sp)))
-				return force_sigsegv_info(sig, (void __user *)
+				return force_sigsegv_info(ksig->sig, (void __user *)
 							  check_sp);
 		}
 	}
 	frame = (void __user *) ((new_sp - sizeof(*frame)) & -STACK_ALIGN);
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
-		return force_sigsegv_info(sig, frame);
+		return force_sigsegv_info(ksig->sig, frame);
 
-	err  = __put_user(sig, &frame->arg0);
+	err  = __put_user(ksig->sig, &frame->arg0);
 	err |= __put_user(&frame->info, &frame->arg1);
 	err |= __put_user(&frame->sc, &frame->arg2);
 	err |= __put_user(new_rbs, &frame->sc.sc_rbs_base);
 	err |= __put_user(0, &frame->sc.sc_loadrs);	/* initialize to zero */
-	err |= __put_user(ka->sa.sa_handler, &frame->handler);
+	err |= __put_user(ksig->ka.sa.sa_handler, &frame->handler);
 
-	err |= copy_siginfo_to_user(&frame->info, info);
+	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
 
 	err |= __save_altstack(&frame->sc.sc_stack, scr->pt.r12);
 	err |= setup_sigcontext(&frame->sc, set, scr);
 
 	if (unlikely(err))
-		return force_sigsegv_info(sig, frame);
+		return force_sigsegv_info(ksig->sig, frame);
 
 	scr->pt.r12 = (unsigned long) frame - 16;	/* new stack pointer */
 	scr->pt.ar_fpsr = FPSR_DEFAULT;			/* reset fpsr for signal handler */
@@ -394,22 +393,20 @@ setup_frame (int sig, struct k_sigaction
 
 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sig=%d sp=%lx ip=%lx handler=%p\n",
-	       current->comm, current->pid, sig, scr->pt.r12, frame->sc.sc_ip, frame->handler);
+	       current->comm, current->pid, ksig->sig, scr->pt.r12, frame->sc.sc_ip, frame->handler);
 #endif
-	return 1;
+	return 0;
 }
 
 static long
-handle_signal (unsigned long sig, struct k_sigaction *ka, siginfo_t *info,
-	       struct sigscratch *scr)
+handle_signal (struct ksignal *ksig, struct sigscratch *scr)
 {
-	if (!setup_frame(sig, ka, info, sigmask_to_save(), scr))
-		return 0;
+	int ret = setup_frame(ksig, sigmask_to_save(), scr);
 
-	signal_delivered(sig, info, ka, &scr->pt,
-				 test_thread_flag(TIF_SINGLESTEP));
+	if (!ret)
+		signal_setup_done(ret, ksig, test_thread_flag(TIF_SINGLESTEP));
 
-	return 1;
+	return ret;
 }
 
 /*
@@ -419,17 +416,16 @@ handle_signal (unsigned long sig, struct
 void
 ia64_do_signal (struct sigscratch *scr, long in_syscall)
 {
-	struct k_sigaction ka;
-	siginfo_t info;
 	long restart = in_syscall;
 	long errno = scr->pt.r8;
+	struct ksignal ksig;
 
 	/*
 	 * This only loops in the rare cases of handle_signal() failing, in which case we
 	 * need to push through a forced SIGSEGV.
 	 */
 	while (1) {
-		int signr = get_signal_to_deliver(&info, &ka, &scr->pt, NULL);
+		get_signal(&ksig);
 
 		/*
 		 * get_signal_to_deliver() may have run a debugger (via notify_parent())
@@ -446,7 +442,7 @@ ia64_do_signal (struct sigscratch *scr,
 			 */
 			restart = 0;
 
-		if (signr <= 0)
+		if (ksig.sig <= 0)
 			break;
 
 		if (unlikely(restart)) {
@@ -458,7 +454,7 @@ ia64_do_signal (struct sigscratch *scr,
 				break;
 
 			      case ERESTARTSYS:
-				if ((ka.sa.sa_flags & SA_RESTART) == 0) {
+				if ((ksig.ka.sa.sa_flags & SA_RESTART) == 0) {
 					scr->pt.r8 = EINTR;
 					/* note: scr->pt.r10 is already -1 */
 					break;
@@ -473,7 +469,7 @@ ia64_do_signal (struct sigscratch *scr,
 		 * Whee!  Actually deliver the signal.  If the delivery failed, we need to
 		 * continue to iterate in this loop so we can deliver the SIGSEGV...
 		 */
-		if (handle_signal(signr, &ka, &info, scr))
+		if (handle_signal(&ksig, scr))
 			return;
 	}
 

