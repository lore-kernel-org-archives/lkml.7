Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C48EECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C18217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389380AbfJOTSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 15:18:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45616 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731887AbfJOTSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:18:36 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iKSL3-00067i-BD; Tue, 15 Oct 2019 21:18:33 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 05/34] c6x: Use CONFIG_PREEMPTION
Date:   Tue, 15 Oct 2019 21:17:52 +0200
Message-Id: <20191015191821.11479-6-bigeasy@linutronix.de>
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

Cc: Mark Salter <msalter@redhat.com>
Cc: Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
Cc: linux-c6x-dev@linux-c6x.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/c6x/kernel/entry.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/c6x/kernel/entry.S b/arch/c6x/kernel/entry.S
index 4332a10aec6c7..fb154d19625bc 100644
--- a/arch/c6x/kernel/entry.S
+++ b/arch/c6x/kernel/entry.S
@@ -18,7 +18,7 @@
 #define DP	B14
 #define SP	B15
=20
-#ifndef CONFIG_PREEMPT
+#ifndef CONFIG_PREEMPTION
 #define resume_kernel restore_all
 #endif
=20
@@ -287,7 +287,7 @@
 	;; is a little bit different
 	;;
 ENTRY(ret_from_exception)
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	MASK_INT B2
 #endif
=20
@@ -557,7 +557,7 @@ ENDPROC(_nmi_handler)
 	;;
 	;; Jump to schedule() then return to ret_from_isr
 	;;
-#ifdef	CONFIG_PREEMPT
+#ifdef	CONFIG_PREEMPTION
 resume_kernel:
 	GET_THREAD_INFO A12
 	LDW	.D1T1	*+A12(THREAD_INFO_PREEMPT_COUNT),A1
@@ -582,7 +582,7 @@ ENDPROC(_nmi_handler)
 	B	.S2	preempt_schedule_irq
 #endif
 	ADDKPC	.S2	preempt_schedule,B3,4
-#endif /* CONFIG_PREEMPT */
+#endif /* CONFIG_PREEMPTION */
=20
 ENTRY(enable_exception)
 	DINT
--=20
2.23.0

