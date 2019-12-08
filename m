Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144CDC43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 14:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D0420637
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 14:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfLHO6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 09:58:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36725 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfLHO6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 09:58:38 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1idy10-0000Qx-NE; Sun, 08 Dec 2019 15:58:30 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5B0271C2886;
        Sun,  8 Dec 2019 15:58:30 +0100 (CET)
Date:   Sun, 08 Dec 2019 14:58:30 -0000
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/rt, locking: Use CONFIG_PREEMPTION
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191015191821.11479-32-bigeasy@linutronix.de>
References: <20191015191821.11479-32-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <157581711027.21853.10949763858370689710.tip-bot2@tip-bot2>
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

Commit-ID:     1b40cd56f3bcffcfedb43bc30bd431b52240fb3b
Gitweb:        https://git.kernel.org/tip/1b40cd56f3bcffcfedb43bc30bd431b52240fb3b
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 15 Oct 2019 21:18:18 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 08 Dec 2019 14:37:36 +01:00

sched/rt, locking: Use CONFIG_PREEMPTION

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Switch the Kconfig dependency to use CONFIG_PREEMPTION.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20191015191821.11479-32-bigeasy@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/Kconfig.locks | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
index e0852dc..3de8fd1 100644
--- a/kernel/Kconfig.locks
+++ b/kernel/Kconfig.locks
@@ -101,7 +101,7 @@ config UNINLINE_SPIN_UNLOCK
 # unlock and unlock_irq functions are inlined when:
 #   - DEBUG_SPINLOCK=n and ARCH_INLINE_*LOCK=y
 #  or
-#   - DEBUG_SPINLOCK=n and PREEMPT=n
+#   - DEBUG_SPINLOCK=n and PREEMPTION=n
 #
 # unlock_bh and unlock_irqrestore functions are inlined when:
 #   - DEBUG_SPINLOCK=n and ARCH_INLINE_*LOCK=y
@@ -139,7 +139,7 @@ config INLINE_SPIN_UNLOCK_BH
 
 config INLINE_SPIN_UNLOCK_IRQ
 	def_bool y
-	depends on !PREEMPT || ARCH_INLINE_SPIN_UNLOCK_IRQ
+	depends on !PREEMPTION || ARCH_INLINE_SPIN_UNLOCK_IRQ
 
 config INLINE_SPIN_UNLOCK_IRQRESTORE
 	def_bool y
@@ -168,7 +168,7 @@ config INLINE_READ_LOCK_IRQSAVE
 
 config INLINE_READ_UNLOCK
 	def_bool y
-	depends on !PREEMPT || ARCH_INLINE_READ_UNLOCK
+	depends on !PREEMPTION || ARCH_INLINE_READ_UNLOCK
 
 config INLINE_READ_UNLOCK_BH
 	def_bool y
@@ -176,7 +176,7 @@ config INLINE_READ_UNLOCK_BH
 
 config INLINE_READ_UNLOCK_IRQ
 	def_bool y
-	depends on !PREEMPT || ARCH_INLINE_READ_UNLOCK_IRQ
+	depends on !PREEMPTION || ARCH_INLINE_READ_UNLOCK_IRQ
 
 config INLINE_READ_UNLOCK_IRQRESTORE
 	def_bool y
@@ -205,7 +205,7 @@ config INLINE_WRITE_LOCK_IRQSAVE
 
 config INLINE_WRITE_UNLOCK
 	def_bool y
-	depends on !PREEMPT || ARCH_INLINE_WRITE_UNLOCK
+	depends on !PREEMPTION || ARCH_INLINE_WRITE_UNLOCK
 
 config INLINE_WRITE_UNLOCK_BH
 	def_bool y
@@ -213,7 +213,7 @@ config INLINE_WRITE_UNLOCK_BH
 
 config INLINE_WRITE_UNLOCK_IRQ
 	def_bool y
-	depends on !PREEMPT || ARCH_INLINE_WRITE_UNLOCK_IRQ
+	depends on !PREEMPTION || ARCH_INLINE_WRITE_UNLOCK_IRQ
 
 config INLINE_WRITE_UNLOCK_IRQRESTORE
 	def_bool y
