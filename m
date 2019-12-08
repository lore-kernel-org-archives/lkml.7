Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931EBC43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 14:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6468320709
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 14:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfLHO7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 09:59:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36902 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbfLHO7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 09:59:01 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1idy1H-0000eu-1w; Sun, 08 Dec 2019 15:58:47 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B8FE31C2894;
        Sun,  8 Dec 2019 15:58:35 +0100 (CET)
Date:   Sun, 08 Dec 2019 14:58:35 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/rt, ARM: Use CONFIG_PREEMPTION
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191015191821.11479-2-bigeasy@linutronix.de>
References: <20191015191821.11479-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <157581711564.21853.2427720102976898995.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     e7289c6de81c8e8991148e46c9ab43e2d23940f3
Gitweb:        https://git.kernel.org/tip/e7289c6de81c8e8991148e46c9ab43e2d23940f3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 15 Oct 2019 21:17:48 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 08 Dec 2019 14:37:32 +01:00

sched/rt, ARM: Use CONFIG_PREEMPTION

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Switch the entry code, cache over to use CONFIG_PREEMPTION and add output
in show_stack() for PREEMPT_RT.

[bigeasy: +traps.c]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Link: https://lore.kernel.org/r/20191015191821.11479-2-bigeasy@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/arm/include/asm/switch_to.h | 2 +-
 arch/arm/kernel/entry-armv.S     | 4 ++--
 arch/arm/kernel/traps.c          | 2 ++
 arch/arm/mm/cache-v7.S           | 4 ++--
 arch/arm/mm/cache-v7m.S          | 4 ++--
 5 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/switch_to.h b/arch/arm/include/asm/switch_to.h
index d3e937d..007d8fe 100644
--- a/arch/arm/include/asm/switch_to.h
+++ b/arch/arm/include/asm/switch_to.h
@@ -10,7 +10,7 @@
  * to ensure that the maintenance completes in case we migrate to another
  * CPU.
  */
-#if defined(CONFIG_PREEMPT) && defined(CONFIG_SMP) && defined(CONFIG_CPU_V7)
+#if defined(CONFIG_PREEMPTION) && defined(CONFIG_SMP) && defined(CONFIG_CPU_V7)
 #define __complete_pending_tlbi()	dsb(ish)
 #else
 #define __complete_pending_tlbi()
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 858d4e5..77f5483 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -211,7 +211,7 @@ __irq_svc:
 	svc_entry
 	irq_handler
 
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	ldr	r8, [tsk, #TI_PREEMPT]		@ get preempt count
 	ldr	r0, [tsk, #TI_FLAGS]		@ get flags
 	teq	r8, #0				@ if preempt count != 0
@@ -226,7 +226,7 @@ ENDPROC(__irq_svc)
 
 	.ltorg
 
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 svc_preempt:
 	mov	r8, lr
 1:	bl	preempt_schedule_irq		@ irq en/disable is done inside
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index c053abd..abb7dd7 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -248,6 +248,8 @@ void show_stack(struct task_struct *tsk, unsigned long *sp)
 
 #ifdef CONFIG_PREEMPT
 #define S_PREEMPT " PREEMPT"
+#elif defined(CONFIG_PREEMPT_RT)
+#define S_PREEMPT " PREEMPT_RT"
 #else
 #define S_PREEMPT ""
 #endif
diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index 0ee8fc4..dc8f152 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -135,13 +135,13 @@ flush_levels:
 	and	r1, r1, #7			@ mask of the bits for current cache only
 	cmp	r1, #2				@ see what cache we have at this level
 	blt	skip				@ skip if no cache, or just i-cache
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	save_and_disable_irqs_notrace r9	@ make cssr&csidr read atomic
 #endif
 	mcr	p15, 2, r10, c0, c0, 0		@ select current cache level in cssr
 	isb					@ isb to sych the new cssr&csidr
 	mrc	p15, 1, r1, c0, c0, 0		@ read the new csidr
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	restore_irqs_notrace r9
 #endif
 	and	r2, r1, #7			@ extract the length of the cache lines
diff --git a/arch/arm/mm/cache-v7m.S b/arch/arm/mm/cache-v7m.S
index a0035c4..1bc3a0a 100644
--- a/arch/arm/mm/cache-v7m.S
+++ b/arch/arm/mm/cache-v7m.S
@@ -183,13 +183,13 @@ flush_levels:
 	and	r1, r1, #7			@ mask of the bits for current cache only
 	cmp	r1, #2				@ see what cache we have at this level
 	blt	skip				@ skip if no cache, or just i-cache
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	save_and_disable_irqs_notrace r9	@ make cssr&csidr read atomic
 #endif
 	write_csselr r10, r1			@ set current cache level
 	isb					@ isb to sych the new cssr&csidr
 	read_ccsidr r1				@ read the new csidr
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	restore_irqs_notrace r9
 #endif
 	and	r2, r1, #7			@ extract the length of the cache lines
