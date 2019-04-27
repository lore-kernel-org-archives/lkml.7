Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB01DC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B668B206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfD0PWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:22:14 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33812 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727556AbfD0PPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:32 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP32-0000z8-B8; Sat, 27 Apr 2019 16:15:28 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2l-0004XU-2y; Sat, 27 Apr 2019 16:15:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Richard Weinberger" <richard@nod.at>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.878189818@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 113/202] frv: Use get_signal() signal_setup_done()
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

commit 720f36b983224ac52b6acdd8b646ce30f6b38763 upstream.

Use the more generic functions get_signal() signal_setup_done()
for signal delivery.

Signed-off-by: Richard Weinberger <richard@nod.at>
[bwh: Backported to 3.16 as dependency of commit 35634ffa1751
 "signal: Always notice exiting tasks"]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/frv/kernel/signal.c | 99 ++++++++++++++++------------------------
 1 file changed, 40 insertions(+), 59 deletions(-)

--- a/arch/frv/kernel/signal.c
+++ b/arch/frv/kernel/signal.c
@@ -180,17 +180,17 @@ static inline void __user *get_sigframe(
 /*
  *
  */
-static int setup_frame(int sig, struct k_sigaction *ka, sigset_t *set)
+static int setup_frame(struct ksignal *ksig, sigset_t *set)
 {
 	struct sigframe __user *frame;
-	int rsig;
+	int rsig, sig = ksig->sig;
 
 	set_fs(USER_DS);
 
-	frame = get_sigframe(ka, sizeof(*frame));
+	frame = get_sigframe(&ksig->ka, sizeof(*frame));
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
-		goto give_sigsegv;
+		return -EFAULT;
 
 	rsig = sig;
 	if (sig < 32 &&
@@ -199,22 +199,22 @@ static int setup_frame(int sig, struct k
 		rsig = __current_thread_info->exec_domain->signal_invmap[sig];
 
 	if (__put_user(rsig, &frame->sig) < 0)
-		goto give_sigsegv;
+		return -EFAULT;
 
 	if (setup_sigcontext(&frame->sc, set->sig[0]))
-		goto give_sigsegv;
+		return -EFAULT;
 
 	if (_NSIG_WORDS > 1) {
 		if (__copy_to_user(frame->extramask, &set->sig[1],
 				   sizeof(frame->extramask)))
-			goto give_sigsegv;
+			return -EFAULT;
 	}
 
 	/* Set up to return from userspace.  If provided, use a stub
 	 * already in userspace.  */
-	if (ka->sa.sa_flags & SA_RESTORER) {
-		if (__put_user(ka->sa.sa_restorer, &frame->pretcode) < 0)
-			goto give_sigsegv;
+	if (ksig->ka.sa.sa_flags & SA_RESTORER) {
+		if (__put_user(ksig->ka.sa.sa_restorer, &frame->pretcode) < 0)
+			return -EFAULT;
 	}
 	else {
 		/* Set up the following code on the stack:
@@ -224,7 +224,7 @@ static int setup_frame(int sig, struct k
 		if (__put_user((__sigrestore_t)frame->retcode, &frame->pretcode) ||
 		    __put_user(0x8efc0000|__NR_sigreturn, &frame->retcode[0]) ||
 		    __put_user(0xc0700000, &frame->retcode[1]))
-			goto give_sigsegv;
+			return -EFAULT;
 
 		flush_icache_range((unsigned long) frame->retcode,
 				   (unsigned long) (frame->retcode + 2));
@@ -233,14 +233,14 @@ static int setup_frame(int sig, struct k
 	/* Set up registers for the signal handler */
 	if (current->personality & FDPIC_FUNCPTRS) {
 		struct fdpic_func_descriptor __user *funcptr =
-			(struct fdpic_func_descriptor __user *) ka->sa.sa_handler;
+			(struct fdpic_func_descriptor __user *) ksig->ka.sa.sa_handler;
 		struct fdpic_func_descriptor desc;
 		if (copy_from_user(&desc, funcptr, sizeof(desc)))
-			goto give_sigsegv;
+			return -EFAULT;
 		__frame->pc = desc.text;
 		__frame->gr15 = desc.GOT;
 	} else {
-		__frame->pc   = (unsigned long) ka->sa.sa_handler;
+		__frame->pc   = (unsigned long) ksig->ka.sa.sa_handler;
 		__frame->gr15 = 0;
 	}
 
@@ -255,29 +255,23 @@ static int setup_frame(int sig, struct k
 #endif
 
 	return 0;
-
-give_sigsegv:
-	force_sigsegv(sig, current);
-	return -EFAULT;
-
 } /* end setup_frame() */
 
 /*****************************************************************************/
 /*
  *
  */
-static int setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
-			  sigset_t *set)
+static int setup_rt_frame(struct ksignal *ksig, sigset_t *set)
 {
 	struct rt_sigframe __user *frame;
-	int rsig;
+	int rsig, sig = ksig->sig;
 
 	set_fs(USER_DS);
 
-	frame = get_sigframe(ka, sizeof(*frame));
+	frame = get_sigframe(&ksig->ka, sizeof(*frame));
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
-		goto give_sigsegv;
+		return -EFAULT;
 
 	rsig = sig;
 	if (sig < 32 &&
@@ -288,28 +282,28 @@ static int setup_rt_frame(int sig, struc
 	if (__put_user(rsig,		&frame->sig) ||
 	    __put_user(&frame->info,	&frame->pinfo) ||
 	    __put_user(&frame->uc,	&frame->puc))
-		goto give_sigsegv;
+		return -EFAULT;
 
-	if (copy_siginfo_to_user(&frame->info, info))
-		goto give_sigsegv;
+	if (copy_siginfo_to_user(&frame->info, &ksig->info))
+		return -EFAULT;
 
 	/* Create the ucontext.  */
 	if (__put_user(0, &frame->uc.uc_flags) ||
 	    __put_user(NULL, &frame->uc.uc_link) ||
 	    __save_altstack(&frame->uc.uc_stack, __frame->sp))
-		goto give_sigsegv;
+		return -EFAULT;
 
 	if (setup_sigcontext(&frame->uc.uc_mcontext, set->sig[0]))
-		goto give_sigsegv;
+		return -EFAULT;
 
 	if (__copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set)))
-		goto give_sigsegv;
+		return -EFAULT;
 
 	/* Set up to return from userspace.  If provided, use a stub
 	 * already in userspace.  */
-	if (ka->sa.sa_flags & SA_RESTORER) {
-		if (__put_user(ka->sa.sa_restorer, &frame->pretcode))
-			goto give_sigsegv;
+	if (ksig->ka.sa.sa_flags & SA_RESTORER) {
+		if (__put_user(ksig->ka.sa.sa_restorer, &frame->pretcode))
+			return -EFAULT;
 	}
 	else {
 		/* Set up the following code on the stack:
@@ -319,7 +313,7 @@ static int setup_rt_frame(int sig, struc
 		if (__put_user((__sigrestore_t)frame->retcode, &frame->pretcode) ||
 		    __put_user(0x8efc0000|__NR_rt_sigreturn, &frame->retcode[0]) ||
 		    __put_user(0xc0700000, &frame->retcode[1]))
-			goto give_sigsegv;
+			return -EFAULT;
 
 		flush_icache_range((unsigned long) frame->retcode,
 				   (unsigned long) (frame->retcode + 2));
@@ -328,14 +322,14 @@ static int setup_rt_frame(int sig, struc
 	/* Set up registers for signal handler */
 	if (current->personality & FDPIC_FUNCPTRS) {
 		struct fdpic_func_descriptor __user *funcptr =
-			(struct fdpic_func_descriptor __user *) ka->sa.sa_handler;
+			(struct fdpic_func_descriptor __user *) ksig->ka.sa.sa_handler;
 		struct fdpic_func_descriptor desc;
 		if (copy_from_user(&desc, funcptr, sizeof(desc)))
-			goto give_sigsegv;
+			return -EFAULT;
 		__frame->pc = desc.text;
 		__frame->gr15 = desc.GOT;
 	} else {
-		__frame->pc   = (unsigned long) ka->sa.sa_handler;
+		__frame->pc   = (unsigned long) ksig->ka.sa.sa_handler;
 		__frame->gr15 = 0;
 	}
 
@@ -349,21 +343,15 @@ static int setup_rt_frame(int sig, struc
 	       sig, current->comm, current->pid, frame, __frame->pc,
 	       frame->pretcode);
 #endif
-
 	return 0;
 
-give_sigsegv:
-	force_sigsegv(sig, current);
-	return -EFAULT;
-
 } /* end setup_rt_frame() */
 
 /*****************************************************************************/
 /*
  * OK, we're invoking a handler
  */
-static void handle_signal(unsigned long sig, siginfo_t *info,
-			 struct k_sigaction *ka)
+static void handle_signal(struct ksignal *ksig)
 {
 	sigset_t *oldset = sigmask_to_save();
 	int ret;
@@ -378,7 +366,7 @@ static void handle_signal(unsigned long
 			break;
 
 		case -ERESTARTSYS:
-			if (!(ka->sa.sa_flags & SA_RESTART)) {
+			if (!(ksig->ka.sa.sa_flags & SA_RESTART)) {
 				__frame->gr8 = -EINTR;
 				break;
 			}
@@ -392,16 +380,12 @@ static void handle_signal(unsigned long
 	}
 
 	/* Set up the stack frame */
-	if (ka->sa.sa_flags & SA_SIGINFO)
-		ret = setup_rt_frame(sig, ka, info, oldset);
+	if (ksig->ka.sa.sa_flags & SA_SIGINFO)
+		ret = setup_rt_frame(ksig, oldset);
 	else
-		ret = setup_frame(sig, ka, oldset);
+		ret = setup_frame(ksig, oldset);
 
-	if (ret)
-		return;
-
-	signal_delivered(sig, info, ka, __frame,
-				 test_thread_flag(TIF_SINGLESTEP));
+	signal_setup_done(ret, ksig, test_thread_flag(TIF_SINGLESTEP));
 } /* end handle_signal() */
 
 /*****************************************************************************/
@@ -412,13 +396,10 @@ static void handle_signal(unsigned long
  */
 static void do_signal(void)
 {
-	struct k_sigaction ka;
-	siginfo_t info;
-	int signr;
-
-	signr = get_signal_to_deliver(&info, &ka, __frame, NULL);
-	if (signr > 0) {
-		handle_signal(signr, &info, &ka);
+	struct ksignal ksig;
+
+	if (get_signal(&ksig)) {
+		handle_signal(&ksig);
 		return;
 	}
 

