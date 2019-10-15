Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20024C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008ED20854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389521AbfJOTS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 15:18:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45718 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389470AbfJOTSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:18:52 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iKSL8-00067i-RD; Tue, 15 Oct 2019 21:18:38 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 18/34] sh: Use CONFIG_PREEMPTION
Date:   Tue, 15 Oct 2019 21:18:05 +0200
Message-Id: <20191015191821.11479-19-bigeasy@linutronix.de>
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

Switch the entry code over to use CONFIG_PREEMPTION.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[bigeasy: +Kconfig]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/sh/Kconfig                | 2 +-
 arch/sh/kernel/cpu/sh5/entry.S | 4 ++--
 arch/sh/kernel/entry-common.S  | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index f356ee674d89b..9ece111b02548 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -108,7 +108,7 @@ config GENERIC_CALIBRATE_DELAY
=20
 config GENERIC_LOCKBREAK
 	def_bool y
-	depends on SMP && PREEMPT
+	depends on SMP && PREEMPTION
=20
 config ARCH_SUSPEND_POSSIBLE
 	def_bool n
diff --git a/arch/sh/kernel/cpu/sh5/entry.S b/arch/sh/kernel/cpu/sh5/entry.S
index de68ffdfffbf5..81c8b64b977ff 100644
--- a/arch/sh/kernel/cpu/sh5/entry.S
+++ b/arch/sh/kernel/cpu/sh5/entry.S
@@ -86,7 +86,7 @@
 	andi	r6, ~0xf0, r6;		\
 	putcon	r6, SR;
=20
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 #  define preempt_stop()	CLI()
 #else
 #  define preempt_stop()
@@ -884,7 +884,7 @@ LRESVEC_block_end:			/* Marker. Unused. */
=20
 	/* Check softirqs */
=20
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	pta   ret_from_syscall, tr0
 	blink   tr0, ZERO
=20
diff --git a/arch/sh/kernel/entry-common.S b/arch/sh/kernel/entry-common.S
index d31f66e82ce51..956a7a03b0c83 100644
--- a/arch/sh/kernel/entry-common.S
+++ b/arch/sh/kernel/entry-common.S
@@ -41,7 +41,7 @@
  */
 #include <asm/dwarf.h>
=20
-#if defined(CONFIG_PREEMPT)
+#if defined(CONFIG_PREEMPTION)
 #  define preempt_stop()	cli ; TRACE_IRQS_OFF
 #else
 #  define preempt_stop()
@@ -84,7 +84,7 @@ ENTRY(ret_from_irq)
 	get_current_thread_info r8, r0
 	bt	resume_kernel	! Yes, it's from kernel, go back soon
=20
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	bra	resume_userspace
 	 nop
 ENTRY(resume_kernel)
--=20
2.23.0

