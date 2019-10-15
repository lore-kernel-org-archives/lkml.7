Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFD4ECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7A320854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389477AbfJOTSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 15:18:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45684 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389425AbfJOTSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:18:47 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iKSLE-00067i-DS; Tue, 15 Oct 2019 21:18:44 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>
Subject: [PATCH 31/34] locking: Use CONFIG_PREEMPTION
Date:   Tue, 15 Oct 2019 21:18:18 +0200
Message-Id: <20191015191821.11479-32-bigeasy@linutronix.de>
In-Reply-To: <20191015191821.11479-1-bigeasy@linutronix.de>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Switch the Kconfig dependency to use CONFIG_PREEMPTION.

Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/Kconfig.locks | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
index e0852dc333acd..3de8fd11873b4 100644
--- a/kernel/Kconfig.locks
+++ b/kernel/Kconfig.locks
@@ -101,7 +101,7 @@ config UNINLINE_SPIN_UNLOCK
 # unlock and unlock_irq functions are inlined when:
 #   - DEBUG_SPINLOCK=3Dn and ARCH_INLINE_*LOCK=3Dy
 #  or
-#   - DEBUG_SPINLOCK=3Dn and PREEMPT=3Dn
+#   - DEBUG_SPINLOCK=3Dn and PREEMPTION=3Dn
 #
 # unlock_bh and unlock_irqrestore functions are inlined when:
 #   - DEBUG_SPINLOCK=3Dn and ARCH_INLINE_*LOCK=3Dy
@@ -139,7 +139,7 @@ config INLINE_SPIN_UNLOCK_BH
=20
 config INLINE_SPIN_UNLOCK_IRQ
 	def_bool y
-	depends on !PREEMPT || ARCH_INLINE_SPIN_UNLOCK_IRQ
+	depends on !PREEMPTION || ARCH_INLINE_SPIN_UNLOCK_IRQ
=20
 config INLINE_SPIN_UNLOCK_IRQRESTORE
 	def_bool y
@@ -168,7 +168,7 @@ config INLINE_READ_LOCK_IRQSAVE
=20
 config INLINE_READ_UNLOCK
 	def_bool y
-	depends on !PREEMPT || ARCH_INLINE_READ_UNLOCK
+	depends on !PREEMPTION || ARCH_INLINE_READ_UNLOCK
=20
 config INLINE_READ_UNLOCK_BH
 	def_bool y
@@ -176,7 +176,7 @@ config INLINE_READ_UNLOCK_BH
=20
 config INLINE_READ_UNLOCK_IRQ
 	def_bool y
-	depends on !PREEMPT || ARCH_INLINE_READ_UNLOCK_IRQ
+	depends on !PREEMPTION || ARCH_INLINE_READ_UNLOCK_IRQ
=20
 config INLINE_READ_UNLOCK_IRQRESTORE
 	def_bool y
@@ -205,7 +205,7 @@ config INLINE_WRITE_LOCK_IRQSAVE
=20
 config INLINE_WRITE_UNLOCK
 	def_bool y
-	depends on !PREEMPT || ARCH_INLINE_WRITE_UNLOCK
+	depends on !PREEMPTION || ARCH_INLINE_WRITE_UNLOCK
=20
 config INLINE_WRITE_UNLOCK_BH
 	def_bool y
@@ -213,7 +213,7 @@ config INLINE_WRITE_UNLOCK_BH
=20
 config INLINE_WRITE_UNLOCK_IRQ
 	def_bool y
-	depends on !PREEMPT || ARCH_INLINE_WRITE_UNLOCK_IRQ
+	depends on !PREEMPTION || ARCH_INLINE_WRITE_UNLOCK_IRQ
=20
 config INLINE_WRITE_UNLOCK_IRQRESTORE
 	def_bool y
--=20
2.23.0

