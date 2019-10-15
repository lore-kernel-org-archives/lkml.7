Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A6CECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F082420854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389408AbfJOTSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 15:18:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45657 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389393AbfJOTSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:18:42 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iKSL3-00067i-To; Tue, 15 Oct 2019 21:18:34 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Yoshinori Sato <ysato@users.sourceforge.jp>,
        uclinux-h8-devel@lists.sourceforge.jp,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 07/34] h8300: Use CONFIG_PREEMPTION
Date:   Tue, 15 Oct 2019 21:17:54 +0200
Message-Id: <20191015191821.11479-8-bigeasy@linutronix.de>
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
Cc: uclinux-h8-devel@lists.sourceforge.jp
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/h8300/kernel/entry.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/h8300/kernel/entry.S b/arch/h8300/kernel/entry.S
index 4ade5f8299bae..c6e289b5f1f28 100644
--- a/arch/h8300/kernel/entry.S
+++ b/arch/h8300/kernel/entry.S
@@ -284,12 +284,12 @@ INTERRUPTS =3D 128
 	mov.l	er0,@(LER0:16,sp)
 	bra	resume_userspace
=20
-#if !defined(CONFIG_PREEMPT)
+#if !defined(CONFIG_PREEMPTION)
 #define resume_kernel restore_all
 #endif
=20
 ret_from_exception:
-#if defined(CONFIG_PREEMPT)
+#if defined(CONFIG_PREEMPTION)
 	orc	#0xc0,ccr
 #endif
 ret_from_interrupt:
@@ -319,7 +319,7 @@ INTERRUPTS =3D 128
 restore_all:
 	RESTORE_ALL			/* Does RTE */
=20
-#if defined(CONFIG_PREEMPT)
+#if defined(CONFIG_PREEMPTION)
 resume_kernel:
 	mov.l	@(TI_PRE_COUNT:16,er4),er0
 	bne	restore_all:8
--=20
2.23.0

