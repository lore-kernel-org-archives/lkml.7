Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507C8C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8C5206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbfD0PX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:23:59 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33594 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727502AbfD0PP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:29 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2z-0000z8-4c; Sat, 27 Apr 2019 16:15:25 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2l-0004Z1-NO; Sat, 27 Apr 2019 16:15:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Richard Weinberger" <richard@nod.at>,
        "Guenter Roeck" <linux@roeck-us.net>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.770620836@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 132/202] unicore32: Fix build error
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

From: Guenter Roeck <linux@roeck-us.net>

commit ca98565a6182a960cd857d7546267a0775154eb8 upstream.

unicore32 builds fail with

  arch/unicore32/kernel/signal.c: In function ‘setup_frame’:
  arch/unicore32/kernel/signal.c:257: error: ‘usig’ undeclared (first use in this function)
  arch/unicore32/kernel/signal.c:279: error: ‘usig’ undeclared (first use in this function)
  arch/unicore32/kernel/signal.c: In function ‘handle_signal’:
  arch/unicore32/kernel/signal.c:306: warning: unused variable ‘tsk’
  arch/unicore32/kernel/signal.c: In function ‘do_signal’:
  arch/unicore32/kernel/signal.c:376: error: implicit declaration of function ‘get_signsl’
  make[1]: *** [arch/unicore32/kernel/signal.o] Error 1
  make: *** [arch/unicore32/kernel/signal.o] Error 2

Bisect points to commit 649671c90eaf ("unicore32: Use get_signal()
signal_setup_done()").

This code never even compiled.  Reverting the patch does not work, since
previously used functions no longer exist, so try to fix it up.  Compile
tested only.

Fixes: 649671c90eaf ("unicore32: Use get_signal() signal_setup_done()")
Cc: Richard Weinberger <richard@nod.at>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/unicore32/kernel/signal.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/arch/unicore32/kernel/signal.c
+++ b/arch/unicore32/kernel/signal.c
@@ -254,7 +254,8 @@ static int setup_frame(struct ksignal *k
 
 	err |= setup_sigframe(frame, regs, set);
 	if (err == 0)
-		err |= setup_return(regs, &ksig->ka, frame->retcode, frame, usig);
+		err |= setup_return(regs, &ksig->ka, frame->retcode, frame,
+				    ksig->sig);
 
 	return err;
 }
@@ -276,7 +277,8 @@ static int setup_rt_frame(struct ksignal
 	err |= __save_altstack(&frame->sig.uc.uc_stack, regs->UCreg_sp);
 	err |= setup_sigframe(&frame->sig, regs, set);
 	if (err == 0)
-		err |= setup_return(regs, &ksig->ka, frame->sig.retcode, frame, usig);
+		err |= setup_return(regs, &ksig->ka, frame->sig.retcode, frame,
+				    ksig->sig);
 
 	if (err == 0) {
 		/*
@@ -303,7 +305,6 @@ static void handle_signal(struct ksignal
 			  int syscall)
 {
 	struct thread_info *thread = current_thread_info();
-	struct task_struct *tsk = current;
 	sigset_t *oldset = sigmask_to_save();
 	int usig = ksig->sig;
 	int ret;
@@ -373,7 +374,7 @@ static void do_signal(struct pt_regs *re
 	if (!user_mode(regs))
 		return;
 
-	if (get_signsl(&ksig)) {
+	if (get_signal(&ksig)) {
 		handle_signal(&ksig, regs, syscall);
 		return;
 	}

