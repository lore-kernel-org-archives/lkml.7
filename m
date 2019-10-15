Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E36C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C18AE2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389372AbfJOTVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 15:21:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45642 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389367AbfJOTSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:18:39 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iKSL2-00067i-3h; Tue, 15 Oct 2019 21:18:32 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 01/34] ARM: Use CONFIG_PREEMPTION
Date:   Tue, 15 Oct 2019 21:17:48 +0200
Message-Id: <20191015191821.11479-2-bigeasy@linutronix.de>
In-Reply-To: <20191015191821.11479-1-bigeasy@linutronix.de>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Switch the entry code, cache over to use CONFIG_PREEMPTION and add
output in show_stack() for PREEMPT_RT.

Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[bigeasy: +traps.c]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/include/asm/switch_to.h | 2 +-
 arch/arm/kernel/entry-armv.S     | 4 ++--
 arch/arm/kernel/traps.c          | 2 ++
 arch/arm/mm/cache-v7.S           | 4 ++--
 arch/arm/mm/cache-v7m.S          | 4 ++--
 5 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/switch_to.h b/arch/arm/include/asm/switch=
_to.h
index d3e937dcee4d0..007d8fea71572 100644
--- a/arch/arm/include/asm/switch_to.h
+++ b/arch/arm/include/asm/switch_to.h
@@ -10,7 +10,7 @@
  * to ensure that the maintenance completes in case we migrate to another
  * CPU.
  */
-#if defined(CONFIG_PREEMPT) && defined(CONFIG_SMP) && defined(CONFIG_CPU_V=
7)
+#if defined(CONFIG_PREEMPTION) && defined(CONFIG_SMP) && defined(CONFIG_CP=
U_V7)
 #define __complete_pending_tlbi()	dsb(ish)
 #else
 #define __complete_pending_tlbi()
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 858d4e5415326..77f54830554c3 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -211,7 +211,7 @@ ENDPROC(__dabt_svc)
 	svc_entry
 	irq_handler
=20
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	ldr	r8, [tsk, #TI_PREEMPT]		@ get preempt count
 	ldr	r0, [tsk, #TI_FLAGS]		@ get flags
 	teq	r8, #0				@ if preempt count !=3D 0
@@ -226,7 +226,7 @@ ENDPROC(__irq_svc)
=20
 	.ltorg
=20
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 svc_preempt:
 	mov	r8, lr
 1:	bl	preempt_schedule_irq		@ irq en/disable is done inside
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index c053abd1fb539..abb7dd7e656fd 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -248,6 +248,8 @@ void show_stack(struct task_struct *tsk, unsigned long =
*sp)
=20
 #ifdef CONFIG_PREEMPT
 #define S_PREEMPT " PREEMPT"
+#elif defined(CONFIG_PREEMPT_RT)
+#define S_PREEMPT " PREEMPT_RT"
 #else
 #define S_PREEMPT ""
 #endif
diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index 0ee8fc4b4672c..dc8f152f35566 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -135,13 +135,13 @@ ENTRY(v7_flush_dcache_all)
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
index a0035c426ce63..1bc3a0a507539 100644
--- a/arch/arm/mm/cache-v7m.S
+++ b/arch/arm/mm/cache-v7m.S
@@ -183,13 +183,13 @@ ENTRY(v7m_flush_dcache_all)
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
--=20
2.23.0

