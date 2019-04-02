Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB37C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E8F62070B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731662AbfDBNkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:40:31 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43370 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731462AbfDBNkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:08 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJe0-0002oP-Il; Tue, 02 Apr 2019 14:40:04 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdx-0004wG-C2; Tue, 02 Apr 2019 14:40:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Breno Leitao" <leitao@debian.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>
Date:   Tue, 02 Apr 2019 14:38:28 +0100
Message-ID: <lsq.1554212308.638403049@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 72/99] powerpc/tm: Set MSR[TS] just prior to recheckpoint
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

commit e1c3743e1a20647c53b719dbf28b48f45d23f2cd upstream.

On a signal handler return, the user could set a context with MSR[TS] bits
set, and these bits would be copied to task regs->msr.

At restore_tm_sigcontexts(), after current task regs->msr[TS] bits are set,
several __get_user() are called and then a recheckpoint is executed.

This is a problem since a page fault (in kernel space) could happen when
calling __get_user(). If it happens, the process MSR[TS] bits were
already set, but recheckpoint was not executed, and SPRs are still invalid.

The page fault can cause the current process to be de-scheduled, with
MSR[TS] active and without tm_recheckpoint() being called.  More
importantly, without TEXASR[FS] bit set also.

Since TEXASR might not have the FS bit set, and when the process is
scheduled back, it will try to reclaim, which will be aborted because of
the CPU is not in the suspended state, and, then, recheckpoint. This
recheckpoint will restore thread->texasr into TEXASR SPR, which might be
zero, hitting a BUG_ON().

	kernel BUG at /build/linux-sf3Co9/linux-4.9.30/arch/powerpc/kernel/tm.S:434!
	cpu 0xb: Vector: 700 (Program Check) at [c00000041f1576d0]
	    pc: c000000000054550: restore_gprs+0xb0/0x180
	    lr: 0000000000000000
	    sp: c00000041f157950
	   msr: 8000000100021033
	  current = 0xc00000041f143000
	  paca    = 0xc00000000fb86300	 softe: 0	 irq_happened: 0x01
	    pid   = 1021, comm = kworker/11:1
	kernel BUG at /build/linux-sf3Co9/linux-4.9.30/arch/powerpc/kernel/tm.S:434!
	Linux version 4.9.0-3-powerpc64le (debian-kernel@lists.debian.org) (gcc version 6.3.0 20170516 (Debian 6.3.0-18) ) #1 SMP Debian 4.9.30-2+deb9u2 (2017-06-26)
	enter ? for help
	[c00000041f157b30] c00000000001bc3c tm_recheckpoint.part.11+0x6c/0xa0
	[c00000041f157b70] c00000000001d184 __switch_to+0x1e4/0x4c0
	[c00000041f157bd0] c00000000082eeb8 __schedule+0x2f8/0x990
	[c00000041f157cb0] c00000000082f598 schedule+0x48/0xc0
	[c00000041f157ce0] c0000000000f0d28 worker_thread+0x148/0x610
	[c00000041f157d80] c0000000000f96b0 kthread+0x120/0x140
	[c00000041f157e30] c00000000000c0e0 ret_from_kernel_thread+0x5c/0x7c

This patch simply delays the MSR[TS] set, so, if there is any page fault in
the __get_user() section, it does not have regs->msr[TS] set, since the TM
structures are still invalid, thus avoiding doing TM operations for
in-kernel exceptions and possible process reschedule.

With this patch, the MSR[TS] will only be set just before recheckpointing
and setting TEXASR[FS] = 1, thus avoiding an interrupt with TM registers in
invalid state.

Other than that, if CONFIG_PREEMPT is set, there might be a preemption just
after setting MSR[TS] and before tm_recheckpoint(), thus, this block must
be atomic from a preemption perspective, thus, calling
preempt_disable/enable() on this code.

It is not possible to move tm_recheckpoint to happen earlier, because it is
required to get the checkpointed registers from userspace, with
__get_user(), thus, the only way to avoid this undesired behavior is
delaying the MSR[TS] set.

The 32-bits signal handler seems to be safe this current issue, but, it
might be exposed to the preemption issue, thus, disabling preemption in
this chunk of code.

Changes from v2:
 * Run the critical section with preempt_disable.

Fixes: 87b4e5393af7 ("powerpc/tm: Fix return of active 64bit signals")
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
[bwh: Backported to 3.16:
 - We don't forceably enable TM here; don't change that, and drop the
   comment about it
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -882,7 +882,23 @@ static long restore_tm_user_regs(struct
 	/* If TM bits are set to the reserved value, it's an invalid context */
 	if (MSR_TM_RESV(msr_hi))
 		return 1;
-	/* Pull in the MSR TM bits from the user context */
+
+	/*
+	 * Disabling preemption, since it is unsafe to be preempted
+	 * with MSR[TS] set without recheckpointing.
+	 */
+	preempt_disable();
+
+	/*
+	 * CAUTION:
+	 * After regs->MSR[TS] being updated, make sure that get_user(),
+	 * put_user() or similar functions are *not* called. These
+	 * functions can generate page faults which will cause the process
+	 * to be de-scheduled with MSR[TS] set but without calling
+	 * tm_recheckpoint(). This can cause a bug.
+	 *
+	 * Pull in the MSR TM bits from the user context
+	 */
 	regs->msr = (regs->msr & ~MSR_TS_MASK) | (msr_hi & MSR_TS_MASK);
 	/* Now, recheckpoint.  This loads up all of the checkpointed (older)
 	 * registers, including FP and V[S]Rs.  After recheckpointing, the
@@ -906,6 +922,8 @@ static long restore_tm_user_regs(struct
 	}
 #endif
 
+	preempt_enable();
+
 	return 0;
 }
 #endif
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -431,9 +431,6 @@ static long restore_tm_sigcontexts(struc
 	if (MSR_TM_RESV(msr))
 		return -EINVAL;
 
-	/* pull in MSR TM from user context */
-	regs->msr = (regs->msr & ~MSR_TS_MASK) | (msr & MSR_TS_MASK);
-
 	/* pull in MSR LE from user context */
 	regs->msr = (regs->msr & ~MSR_LE) | (msr & MSR_LE);
 
@@ -532,6 +529,25 @@ static long restore_tm_sigcontexts(struc
 	tm_enable();
 	/* Make sure the transaction is marked as failed */
 	current->thread.tm_texasr |= TEXASR_FS;
+
+	/*
+	 * Disabling preemption, since it is unsafe to be preempted
+	 * with MSR[TS] set without recheckpointing.
+	 */
+	preempt_disable();
+
+	/* pull in MSR TM from user context */
+	regs->msr = (regs->msr & ~MSR_TS_MASK) | (msr & MSR_TS_MASK);
+
+	/*
+	 * CAUTION:
+	 * After regs->MSR[TS] being updated, make sure that get_user(),
+	 * put_user() or similar functions are *not* called. These
+	 * functions can generate page faults which will cause the process
+	 * to be de-scheduled with MSR[TS] set but without calling
+	 * tm_recheckpoint(). This can cause a bug.
+	 */
+
 	/* This loads the checkpointed FP/VEC state, if used */
 	tm_recheckpoint(&current->thread, msr);
 
@@ -547,6 +563,8 @@ static long restore_tm_sigcontexts(struc
 	}
 #endif
 
+	preempt_enable();
+
 	return err;
 }
 #endif

