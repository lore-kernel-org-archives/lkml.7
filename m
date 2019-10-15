Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED87EECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B912083B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389724AbfJOTVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 15:21:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45638 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389361AbfJOTSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:18:38 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iKSL6-00067i-IR; Tue, 15 Oct 2019 21:18:36 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 13/34] nds32: Use CONFIG_PREEMPTION
Date:   Tue, 15 Oct 2019 21:18:00 +0200
Message-Id: <20191015191821.11479-14-bigeasy@linutronix.de>
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

Switch the ex-exit code over to use CONFIG_PREEMPTION.

Cc: Greentime Hu <green.hu@gmail.com>
Cc: Vincent Chen <deanbo422@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[bigeasy: +Kconfig]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/nds32/Kconfig          | 2 +-
 arch/nds32/kernel/ex-exit.S | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index fbd68329737f4..abbb74e46f054 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -61,7 +61,7 @@ config GENERIC_HWEIGHT
=20
 config GENERIC_LOCKBREAK
 	def_bool y
-	depends on PREEMPT
+	depends on PREEMPTION
=20
 config TRACE_IRQFLAGS_SUPPORT
 	def_bool y
diff --git a/arch/nds32/kernel/ex-exit.S b/arch/nds32/kernel/ex-exit.S
index 1df02a7933641..6a2966c2d8c8f 100644
--- a/arch/nds32/kernel/ex-exit.S
+++ b/arch/nds32/kernel/ex-exit.S
@@ -72,7 +72,7 @@
 	restore_user_regs_last
 	.endm
=20
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	.macro	preempt_stop
 	.endm
 #else
@@ -158,7 +158,7 @@ ENTRY(ret_slow_syscall)
 /*
  * preemptive kernel
  */
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 resume_kernel:
 	gie_disable
 	lwi	$t0, [tsk+#TSK_TI_PREEMPT]
--=20
2.23.0

