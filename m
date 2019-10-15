Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D683ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0FE20872
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389679AbfJOTUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 15:20:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45652 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389378AbfJOTSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:18:42 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iKSL4-00067i-Uv; Tue, 15 Oct 2019 21:18:35 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 09/34] ia64: Use CONFIG_PREEMPTION
Date:   Tue, 15 Oct 2019 21:17:56 +0200
Message-Id: <20191015191821.11479-10-bigeasy@linutronix.de>
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

Switch the entry code and kprobes over to use CONFIG_PREEMPTION.

Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-ia64@vger.kernel.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/ia64/kernel/entry.S   | 12 ++++++------
 arch/ia64/kernel/kprobes.c |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/ia64/kernel/entry.S b/arch/ia64/kernel/entry.S
index a9992be5718b8..2ac9263315000 100644
--- a/arch/ia64/kernel/entry.S
+++ b/arch/ia64/kernel/entry.S
@@ -670,12 +670,12 @@ GLOBAL_ENTRY(ia64_leave_syscall)
 	 *
 	 * p6 controls whether current_thread_info()->flags needs to be check for
 	 * extra work.  We always check for extra work when returning to user-lev=
el.
-	 * With CONFIG_PREEMPT, we also check for extra work when the preempt_cou=
nt
+	 * With CONFIG_PREEMPTION, we also check for extra work when the preempt_=
count
 	 * is 0.  After extra work processing has been completed, execution
 	 * resumes at ia64_work_processed_syscall with p6 set to 1 if the extra-w=
ork-check
 	 * needs to be redone.
 	 */
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	RSM_PSR_I(p0, r2, r18)			// disable interrupts
 	cmp.eq pLvSys,p0=3Dr0,r0			// pLvSys=3D1: leave from syscall
 (pKStk) adds r20=3DTI_PRE_COUNT+IA64_TASK_SIZE,r13
@@ -685,7 +685,7 @@ GLOBAL_ENTRY(ia64_leave_syscall)
 (pUStk)	mov r21=3D0			// r21 <- 0
 	;;
 	cmp.eq p6,p0=3Dr21,r0		// p6 <- pUStk || (preempt_count =3D=3D 0)
-#else /* !CONFIG_PREEMPT */
+#else /* !CONFIG_PREEMPTION */
 	RSM_PSR_I(pUStk, r2, r18)
 	cmp.eq pLvSys,p0=3Dr0,r0		// pLvSys=3D1: leave from syscall
 (pUStk)	cmp.eq.unc p6,p0=3Dr0,r0		// p6 <- pUStk
@@ -814,12 +814,12 @@ GLOBAL_ENTRY(ia64_leave_kernel)
 	 *
 	 * p6 controls whether current_thread_info()->flags needs to be check for
 	 * extra work.  We always check for extra work when returning to user-lev=
el.
-	 * With CONFIG_PREEMPT, we also check for extra work when the preempt_cou=
nt
+	 * With CONFIG_PREEMPTION, we also check for extra work when the preempt_=
count
 	 * is 0.  After extra work processing has been completed, execution
 	 * resumes at .work_processed_syscall with p6 set to 1 if the extra-work-=
check
 	 * needs to be redone.
 	 */
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	RSM_PSR_I(p0, r17, r31)			// disable interrupts
 	cmp.eq p0,pLvSys=3Dr0,r0			// pLvSys=3D0: leave from kernel
 (pKStk)	adds r20=3DTI_PRE_COUNT+IA64_TASK_SIZE,r13
@@ -1120,7 +1120,7 @@ GLOBAL_ENTRY(ia64_leave_kernel)
=20
 	/*
 	 * On entry:
-	 *	r20 =3D &current->thread_info->pre_count (if CONFIG_PREEMPT)
+	 *	r20 =3D &current->thread_info->pre_count (if CONFIG_PREEMPTION)
 	 *	r31 =3D current->thread_info->flags
 	 * On exit:
 	 *	p6 =3D TRUE if work-pending-check needs to be redone
diff --git a/arch/ia64/kernel/kprobes.c b/arch/ia64/kernel/kprobes.c
index b8356edbde659..a6d6a0556f089 100644
--- a/arch/ia64/kernel/kprobes.c
+++ b/arch/ia64/kernel/kprobes.c
@@ -841,7 +841,7 @@ static int __kprobes pre_kprobes_handler(struct die_arg=
s *args)
 		return 1;
 	}
=20
-#if !defined(CONFIG_PREEMPT)
+#if !defined(CONFIG_PREEMPTION)
 	if (p->ainsn.inst_flag =3D=3D INST_FLAG_BOOSTABLE && !p->post_handler) {
 		/* Boost up -- we can execute copied instructions directly */
 		ia64_psr(regs)->ri =3D p->ainsn.slot;
--=20
2.23.0

