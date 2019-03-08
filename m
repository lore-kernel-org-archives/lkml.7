Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DD0C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 01:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA36920675
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 01:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="mH4F7IR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfCHBgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 20:36:00 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:54172 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfCHBgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 20:36:00 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 5E8D924E1512;
        Thu,  7 Mar 2019 17:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1552008959; bh=gCgURrA501fUR/zP8KVu04cYBl3f3l9ywqA/dQ8U384=;
        h=From:To:CC:Subject:Date:From;
        b=mH4F7IR41HvrARwBxH/67Wbl8Mut/Z6aSsSUr5afiUk0EPMVHQB/cjN9nJX96gR7m
         V6EfrV1QRmGBUdUxZNYPXzQGWJ/PbSMN6KjGW90zjYHCQL0tJKn9EeeJAyJvvp1GO3
         Zl3ED6aw+b3ZzVTMjeeMawYB/DsqHQLotsmDut3xFkndUAwmFxCTTEr1cfRAVU2m+0
         qUxT5waDDj8MYQwDYglka9HktnUnHdf8y9bgZn2FZ7yCBwujIOO5ul6qcrV459zKTj
         rT/Em8nxa8b4dmvN/1gLIB807PRNX0Gjt7Nq6DiZ3AdgLGODBsruUbuySdhoNsypZL
         +U2z8STvYPS6w==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id F2C44A0091;
        Fri,  8 Mar 2019 01:35:57 +0000 (UTC)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 7 Mar 2019 17:35:57 -0800
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.105) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.103) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 8 Mar 2019 07:06:02 +0530
Received: from vineetg-Latitude-E7450.internal.synopsys.com (10.10.161.89) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 8 Mar 2019 07:06:01 +0530
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     <linux-snps-arc@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Subject: [PATCH] ARCv2: spinlock: remove the extra smp_mb before lock, after unlock
Date:   Thu, 7 Mar 2019 17:35:46 -0800
Message-ID: <1552008946-8008-1-git-send-email-vgupta@synopsys.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.10.161.89]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - ARCv2 LLSC based spinlocks smp_mb() both before and after the LLSC
   instructions, which is not required per lkmm ACQ/REL semantics.
   smp_mb() is only needed _after_ lock and _before_ unlock.
   So remove the extra barriers.
   The reason they were there was mainly historical. At the time of
   initial SMP Linux bringup on HS38 cores, I was too conservative,
   given the fluidity of both hw and sw. The last attempt to ditch the
   extra barrier showed some hackbench regression which is apparently
   not the case now (atleast for LLSC case, read on...)

 - EX based spinlocks (!CONFIG_ARC_HAS_LLSC) still needs the extra
   smp_mb(), not due to lkmm, but due to some hardware shenanigans.
   W/o that, hackbench triggers RCU stall splat. This is not a "real"
   Linux use case anyways so I'm not worried about it.

   | [ARCLinux]# for i in (seq 1 1 5) ; do hackbench; done
   | Running with 10 groups 400 process
   | INFO: task hackbench:158 blocked for more than 10 seconds.
   |       Not tainted 4.20.0-00005-g96b18288a88e-dirty #117
   | "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
   | hackbench       D    0   158    135 0x00000000
   |
   | Stack Trace:
   | watchdog: BUG: soft lockup - CPU#3 stuck for 59s! [hackbench:469]
   | Modules linked in:
   | Path: (null)
   | CPU: 3 PID: 469 Comm: hackbench Not tainted 4.20.0-00005-g96b18288a88e-dirty
   |
   | [ECR   ]: 0x00000000 => Check Programmer's Manual
   | [EFA   ]: 0x00000000
   | [BLINK ]: do_exit+0x4a6/0x7d0
   | [ERET  ]: _raw_write_unlock_irq+0x44/0x5c

 - And while at it, remove the extar smp_mb() from EX based
   arch_read_trylock() since the spin lock there guarantees a full
   barrier anyways

 - For LLSC case, hackbench threads improves with this patch (HAPS @ 50MHz)

   ---- before ----
   |
   | [ARCLinux]# for i in 1 2 3 4 5; do hackbench 10 thread; done
   | Running with 10 groups 400 threads
   | Time: 16.253
   | Time: 16.445
   | Time: 16.590
   | Time: 16.721
   | Time: 16.544

   ---- after ----
   |
   | [ARCLinux]# for i in 1 2 3 4 5; do hackbench 10 thread; done
   | Running with 10 groups 400 threads
   | Time: 15.638
   | Time: 15.730
   | Time: 15.870
   | Time: 15.842
   | Time: 15.729

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/spinlock.h | 45 +++++++++++------------------------------
 1 file changed, 12 insertions(+), 33 deletions(-)

diff --git a/arch/arc/include/asm/spinlock.h b/arch/arc/include/asm/spinlock.h
index 2ba04a7db621..be603859fb04 100644
--- a/arch/arc/include/asm/spinlock.h
+++ b/arch/arc/include/asm/spinlock.h
@@ -21,8 +21,6 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
 {
 	unsigned int val;
 
-	smp_mb();
-
 	__asm__ __volatile__(
 	"1:	llock	%[val], [%[slock]]	\n"
 	"	breq	%[val], %[LOCKED], 1b	\n"	/* spin while LOCKED */
@@ -34,6 +32,14 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
 	  [LOCKED]	"r"	(__ARCH_SPIN_LOCK_LOCKED__)
 	: "memory", "cc");
 
+	/*
+	 * ACQUIRE barrier to ensure load/store after taking the lock
+	 * don't "bleed-up" out of the critical section (leak-in is allowed)
+	 * http://www.spinics.net/lists/kernel/msg2010409.html
+	 *
+	 * ARCv2 only has load-load, store-store and all-all barrier
+	 * thus need the full all-all barrier
+	 */
 	smp_mb();
 }
 
@@ -42,8 +48,6 @@ static inline int arch_spin_trylock(arch_spinlock_t *lock)
 {
 	unsigned int val, got_it = 0;
 
-	smp_mb();
-
 	__asm__ __volatile__(
 	"1:	llock	%[val], [%[slock]]	\n"
 	"	breq	%[val], %[LOCKED], 4f	\n"	/* already LOCKED, just bail */
@@ -68,8 +72,6 @@ static inline void arch_spin_unlock(arch_spinlock_t *lock)
 	smp_mb();
 
 	lock->slock = __ARCH_SPIN_LOCK_UNLOCKED__;
-
-	smp_mb();
 }
 
 /*
@@ -81,8 +83,6 @@ static inline void arch_read_lock(arch_rwlock_t *rw)
 {
 	unsigned int val;
 
-	smp_mb();
-
 	/*
 	 * zero means writer holds the lock exclusively, deny Reader.
 	 * Otherwise grant lock to first/subseq reader
@@ -113,8 +113,6 @@ static inline int arch_read_trylock(arch_rwlock_t *rw)
 {
 	unsigned int val, got_it = 0;
 
-	smp_mb();
-
 	__asm__ __volatile__(
 	"1:	llock	%[val], [%[rwlock]]	\n"
 	"	brls	%[val], %[WR_LOCKED], 4f\n"	/* <= 0: already write locked, bail */
@@ -140,8 +138,6 @@ static inline void arch_write_lock(arch_rwlock_t *rw)
 {
 	unsigned int val;
 
-	smp_mb();
-
 	/*
 	 * If reader(s) hold lock (lock < __ARCH_RW_LOCK_UNLOCKED__),
 	 * deny writer. Otherwise if unlocked grant to writer
@@ -175,8 +171,6 @@ static inline int arch_write_trylock(arch_rwlock_t *rw)
 {
 	unsigned int val, got_it = 0;
 
-	smp_mb();
-
 	__asm__ __volatile__(
 	"1:	llock	%[val], [%[rwlock]]	\n"
 	"	brne	%[val], %[UNLOCKED], 4f	\n"	/* !UNLOCKED, bail */
@@ -217,8 +211,6 @@ static inline void arch_read_unlock(arch_rwlock_t *rw)
 	: [val]		"=&r"	(val)
 	: [rwlock]	"r"	(&(rw->counter))
 	: "memory", "cc");
-
-	smp_mb();
 }
 
 static inline void arch_write_unlock(arch_rwlock_t *rw)
@@ -226,8 +218,6 @@ static inline void arch_write_unlock(arch_rwlock_t *rw)
 	smp_mb();
 
 	rw->counter = __ARCH_RW_LOCK_UNLOCKED__;
-
-	smp_mb();
 }
 
 #else	/* !CONFIG_ARC_HAS_LLSC */
@@ -237,10 +227,9 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
 	unsigned int val = __ARCH_SPIN_LOCK_LOCKED__;
 
 	/*
-	 * This smp_mb() is technically superfluous, we only need the one
-	 * after the lock for providing the ACQUIRE semantics.
-	 * However doing the "right" thing was regressing hackbench
-	 * so keeping this, pending further investigation
+	 * Per lkmm, smp_mb() is only required after _lock (and before_unlock)
+	 * for ACQ and REL semantics respectively. However EX based spinlocks
+	 * need the extra smp_mb to workaround a hardware quirk.
 	 */
 	smp_mb();
 
@@ -257,14 +246,6 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
 #endif
 	: "memory");
 
-	/*
-	 * ACQUIRE barrier to ensure load/store after taking the lock
-	 * don't "bleed-up" out of the critical section (leak-in is allowed)
-	 * http://www.spinics.net/lists/kernel/msg2010409.html
-	 *
-	 * ARCv2 only has load-load, store-store and all-all barrier
-	 * thus need the full all-all barrier
-	 */
 	smp_mb();
 }
 
@@ -309,8 +290,7 @@ static inline void arch_spin_unlock(arch_spinlock_t *lock)
 	: "memory");
 
 	/*
-	 * superfluous, but keeping for now - see pairing version in
-	 * arch_spin_lock above
+	 * see pairing version/comment in arch_spin_lock above
 	 */
 	smp_mb();
 }
@@ -344,7 +324,6 @@ static inline int arch_read_trylock(arch_rwlock_t *rw)
 	arch_spin_unlock(&(rw->lock_mutex));
 	local_irq_restore(flags);
 
-	smp_mb();
 	return ret;
 }
 
-- 
2.7.4

