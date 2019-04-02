Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B7FC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF0920856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731915AbfDBNp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:45:28 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43388 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731463AbfDBNkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:08 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJe0-0002nu-H8; Tue, 02 Apr 2019 14:40:04 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdx-0004wK-Cl; Tue, 02 Apr 2019 14:40:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Breno Leitao" <leitao@debian.org>,
        "Michal =?UTF-8?Q?Such=C3=A1nek?=" <msuchanek@suse.de>
Date:   Tue, 02 Apr 2019 14:38:28 +0100
Message-ID: <lsq.1554212308.975682778@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 73/99] powerpc/tm: Unset MSR[TS] if not recheckpointing
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Breno Leitao <leitao@debian.org>

commit 6f5b9f018f4c7686fd944d920209d1382d320e4e upstream.

There is a TM Bad Thing bug that can be caused when you return from a
signal context in a suspended transaction but with ucontext MSR[TS] unset.

This forces regs->msr[TS] to be set at syscall entrance (since the CPU
state is transactional). It also calls treclaim() to flush the transaction
state, which is done based on the live (mfmsr) MSR state.

Since user context MSR[TS] is not set, then restore_tm_sigcontexts() is not
called, thus, not executing recheckpoint, keeping the CPU state as not
transactional. When calling rfid, SRR1 will have MSR[TS] set, but the CPU
state is non transactional, causing the TM Bad Thing with the following
stack:

	[   33.862316] Bad kernel stack pointer 3fffd9dce3e0 at c00000000000c47c
	cpu 0x8: Vector: 700 (Program Check) at [c00000003ff7fd40]
	    pc: c00000000000c47c: fast_exception_return+0xac/0xb4
	    lr: 00003fff865f442c
	    sp: 3fffd9dce3e0
	   msr: 8000000102a03031
	  current = 0xc00000041f68b700
	  paca    = 0xc00000000fb84800   softe: 0        irq_happened: 0x01
	    pid   = 1721, comm = tm-signal-sigre
	Linux version 4.9.0-3-powerpc64le (debian-kernel@lists.debian.org) (gcc version 6.3.0 20170516 (Debian 6.3.0-18) ) #1 SMP Debian 4.9.30-2+deb9u2 (2017-06-26)
	WARNING: exception is not recoverable, can't continue

The same problem happens on 32-bits signal handler, and the fix is very
similar, if tm_recheckpoint() is not executed, then regs->msr[TS] should be
zeroed.

This patch also fixes a sparse warning related to lack of indentation when
CONFIG_PPC_TRANSACTIONAL_MEM is set.

Fixes: 2b0a576d15e0e ("powerpc: Add new transactional memory state to the signal context")
Signed-off-by: Breno Leitao <leitao@debian.org>
Tested-by: Michal Suchánek <msuchanek@suse.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/powerpc/kernel/signal_32.c | 18 +++++++++++++-----
 arch/powerpc/kernel/signal_64.c | 20 ++++++++++++++++----
 2 files changed, 29 insertions(+), 9 deletions(-)

--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -1246,11 +1246,11 @@ long sys_rt_sigreturn(int r3, int r4, in
 		     struct pt_regs *regs)
 {
 	struct rt_sigframe __user *rt_sf;
+	int tm_restore = 0;
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	struct ucontext __user *uc_transact;
 	unsigned long msr_hi;
 	unsigned long tmp;
-	int tm_restore = 0;
 #endif
 	/* Always make any pending restarted system calls return -EINTR */
 	current_thread_info()->restart_block.fn = do_no_restart_syscall;
@@ -1284,11 +1284,19 @@ long sys_rt_sigreturn(int r3, int r4, in
 				goto bad;
 		}
 	}
-	if (!tm_restore)
-		/* Fall through, for non-TM restore */
+	if (!tm_restore) {
+		/*
+		 * Unset regs->msr because ucontext MSR TS is not
+		 * set, and recheckpoint was not called. This avoid
+		 * hitting a TM Bad thing at RFID
+		 */
+		regs->msr &= ~MSR_TS_MASK;
+	}
+	/* Fall through, for non-TM restore */
 #endif
-	if (do_setcontext(&rt_sf->uc, regs, 1))
-		goto bad;
+	if (!tm_restore)
+		if (do_setcontext(&rt_sf->uc, regs, 1))
+			goto bad;
 
 	/*
 	 * It's not clear whether or why it is desirable to save the
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -708,11 +708,23 @@ int sys_rt_sigreturn(unsigned long r3, u
 					   &uc_transact->uc_mcontext))
 			goto badframe;
 	}
-	else
-	/* Fall through, for non-TM restore */
 #endif
-	if (restore_sigcontext(regs, NULL, 1, &uc->uc_mcontext))
-		goto badframe;
+	/* Fall through, for non-TM restore */
+	if (!MSR_TM_ACTIVE(msr)) {
+		/*
+		 * Unset MSR[TS] on the thread regs since MSR from user
+		 * context does not have MSR active, and recheckpoint was
+		 * not called since restore_tm_sigcontexts() was not called
+		 * also.
+		 *
+		 * If not unsetting it, the code can RFID to userspace with
+		 * MSR[TS] set, but without CPU in the proper state,
+		 * causing a TM bad thing.
+		 */
+		current->thread.regs->msr &= ~MSR_TS_MASK;
+		if (restore_sigcontext(regs, NULL, 1, &uc->uc_mcontext))
+			goto badframe;
+	}
 
 	if (restore_altstack(&uc->uc_stack))
 		goto badframe;

