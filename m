Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D683C76188
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 12:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E6520873
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 12:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="LyYB/1AE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbfGTMeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 08:34:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55809 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbfGTMea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 08:34:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6KCYAMp2937336
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 20 Jul 2019 05:34:10 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6KCYAMp2937336
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563626051;
        bh=BIqdpQPSj7orFSVwnut3PFwO6r+kyJBmJ85gijMBGaY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=LyYB/1AEhmzisT/QlBr0qKmOUjvwRSuy1iGbtvFjv/63gc8xuWLk9Z/tGP8GRRYJG
         MJG8+f1f7RLOGX8NY86WPdkldnEQCQuGyivhMTxBby6AoZYg8r/WRFF33AxvX4gdy6
         Nf1Lc+39iVp1DR52+gyIRKcuQ+nKdtd0F6edSuxQcyu04M+5CmD3LsfIf9kDLSnWUZ
         mT4TznkffE4bYX9me6niYAmLAuOuSk+qynxwoIZ4mHMvbEB0+kNTe1P0X2mKgG14xM
         NZT13JWgfC/4TTpyM3Gf/W/6V0RKdHVL3fWhCFTN2aa1Wm9ZX0thDLYUy0RWkPMN5B
         NYuh/s1mFm7ug==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6KCY7oM2937332;
        Sat, 20 Jul 2019 05:34:07 -0700
Date:   Sat, 20 Jul 2019 05:34:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-6879298bd0673840cadd1fb36d7225485504ceb4@git.kernel.org>
Cc:     peterz@infradead.org, tglx@linutronix.de,
        sean.j.christopherson@intel.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, mingo@kernel.org
Reply-To: peterz@infradead.org, mingo@kernel.org,
          sean.j.christopherson@intel.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <alpine.DEB.2.21.1907201020540.1782@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1907201020540.1782@nanos.tec.linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/entry/64: Prevent clobbering of saved CR2
 value
Git-Commit-ID: 6879298bd0673840cadd1fb36d7225485504ceb4
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6879298bd0673840cadd1fb36d7225485504ceb4
Gitweb:     https://git.kernel.org/tip/6879298bd0673840cadd1fb36d7225485504ceb4
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sat, 20 Jul 2019 10:56:41 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 20 Jul 2019 14:28:41 +0200

x86/entry/64: Prevent clobbering of saved CR2 value

The recent fix for CR2 corruption introduced a new way to reliably corrupt
the saved CR2 value.

CR2 is saved early in the entry code in RDX, which is the third argument to
the fault handling functions. But it missed that between saving and
invoking the fault handler enter_from_user_mode() can be called. RDX is a
caller saved register so the invoked function can freely clobber it with
the obvious consequences.

The TRACE_IRQS_OFF call is safe as it calls through the thunk which
preserves RDX, but TRACE_IRQS_OFF_DEBUG is not because it also calls into
C-code outside of the thunk.

Store CR2 in R12 instead which is a callee saved register and move R12 to
RDX just before calling the fault handler.

Fixes: a0d14b8909de ("x86/mm, tracing: Fix CR2 corruption")
Reported-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1907201020540.1782@nanos.tec.linutronix.de

---
 arch/x86/entry/entry_64.S | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 7cb2e1f1ec09..f7c70c1bee8b 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -875,7 +875,12 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
 	UNWIND_HINT_REGS
 
 	.if \read_cr2
-	GET_CR2_INTO(%rdx);			/* can clobber %rax */
+	/*
+	 * Store CR2 early so subsequent faults cannot clobber it. Use R12 as
+	 * intermediate storage as RDX can be clobbered in enter_from_user_mode().
+	 * GET_CR2_INTO can clobber RAX.
+	 */
+	GET_CR2_INTO(%r12);
 	.endif
 
 	.if \shift_ist != -1
@@ -904,6 +909,10 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
 	subq	$\ist_offset, CPU_TSS_IST(\shift_ist)
 	.endif
 
+	.if \read_cr2
+	movq	%r12, %rdx			/* Move CR2 into 3rd argument */
+	.endif
+
 	call	\do_sym
 
 	.if \shift_ist != -1
