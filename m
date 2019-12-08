Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E35C43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 14:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5698206DB
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 14:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfLHO6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 09:58:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36761 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfLHO6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 09:58:42 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1idy12-0000TC-Eq; Sun, 08 Dec 2019 15:58:32 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1C3E31C2885;
        Sun,  8 Dec 2019 15:58:32 +0100 (CET)
Date:   Sun, 08 Dec 2019 14:58:31 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/rt, sh: Use CONFIG_PREEMPTION
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191015191821.11479-19-bigeasy@linutronix.de>
References: <20191015191821.11479-19-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <157581711194.21853.14714840736791910225.tip-bot2@tip-bot2>
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

Commit-ID:     7be60ccbc59098f5251edae51bbf08e2d2226da0
Gitweb:        https://git.kernel.org/tip/7be60ccbc59098f5251edae51bbf08e2d2226da0
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 15 Oct 2019 21:18:05 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 08 Dec 2019 14:37:35 +01:00

sched/rt, sh: Use CONFIG_PREEMPTION

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Switch the entry code over to use CONFIG_PREEMPTION.

[bigeasy: +Kconfig]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rich Felker <dalias@libc.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org
Link: https://lore.kernel.org/r/20191015191821.11479-19-bigeasy@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/sh/Kconfig                | 2 +-
 arch/sh/kernel/cpu/sh5/entry.S | 4 ++--
 arch/sh/kernel/entry-common.S  | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index f356ee6..9ece111 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -108,7 +108,7 @@ config GENERIC_CALIBRATE_DELAY
 
 config GENERIC_LOCKBREAK
 	def_bool y
-	depends on SMP && PREEMPT
+	depends on SMP && PREEMPTION
 
 config ARCH_SUSPEND_POSSIBLE
 	def_bool n
diff --git a/arch/sh/kernel/cpu/sh5/entry.S b/arch/sh/kernel/cpu/sh5/entry.S
index de68ffd..81c8b64 100644
--- a/arch/sh/kernel/cpu/sh5/entry.S
+++ b/arch/sh/kernel/cpu/sh5/entry.S
@@ -86,7 +86,7 @@
 	andi	r6, ~0xf0, r6;		\
 	putcon	r6, SR;
 
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 #  define preempt_stop()	CLI()
 #else
 #  define preempt_stop()
@@ -884,7 +884,7 @@ ret_from_exception:
 
 	/* Check softirqs */
 
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	pta   ret_from_syscall, tr0
 	blink   tr0, ZERO
 
diff --git a/arch/sh/kernel/entry-common.S b/arch/sh/kernel/entry-common.S
index d31f66e..956a7a0 100644
--- a/arch/sh/kernel/entry-common.S
+++ b/arch/sh/kernel/entry-common.S
@@ -41,7 +41,7 @@
  */
 #include <asm/dwarf.h>
 
-#if defined(CONFIG_PREEMPT)
+#if defined(CONFIG_PREEMPTION)
 #  define preempt_stop()	cli ; TRACE_IRQS_OFF
 #else
 #  define preempt_stop()
@@ -84,7 +84,7 @@ ENTRY(ret_from_irq)
 	get_current_thread_info r8, r0
 	bt	resume_kernel	! Yes, it's from kernel, go back soon
 
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	bra	resume_userspace
 	 nop
 ENTRY(resume_kernel)
