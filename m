Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603A3C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 03:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348962184E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 03:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562039011;
	bh=hpglW7ERyrm55bmpcpbEKVW5vzQbNVkMbUEkEXIkIDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aWxEybEjAnjoTy8FF+F+b0RM1wlCpa5RODCFDczCtp+IKNFSRHBNGbURlcnEI8Jxy
	 VYLElxDg59kthj8y9JaLHwzCvVHDaKEXcKKNRrTw/5t1Ec2DRnwSVyYA3cmCGAyK5r
	 2F9ioMqD0PVTFhiPVN9hpQmWIOIn8vwu0pLW3P1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfGBDn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 23:43:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbfGBDn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 23:43:26 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2F33216C8;
        Tue,  2 Jul 2019 03:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562039005;
        bh=hpglW7ERyrm55bmpcpbEKVW5vzQbNVkMbUEkEXIkIDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c3bE/O2FQS4gNNdsQDD/wyvDvFOGCPEOw2m9mBOHg0FVNXf5Mq4ak253orIHUIAI+
         posHjFxJwvMRLCuxGKhjPQVZjqTUFrD+CwZtzSI14viOk1+Ez3Exs8ZHcHPIEN/YDn
         JiHwsZ1WNtIQCyuVUlQE12qeQYedYyf05VeoD4zU=
From:   Andy Lutomirski <luto@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>
Subject: [PATCH 3/3] x86/entry/64: Fix and clean up paranoid_exit
Date:   Mon,  1 Jul 2019 20:43:21 -0700
Message-Id: <59725ceb08977359489fbed979716949ad45f616.1562035429.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1562035429.git.luto@kernel.org>
References: <cover.1562035429.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

paranoid_exit needs to restore CR3 before GSBASE.  Doing it in the
opposite order crashes if the exception came from a context with
user GSBASE and user CR3 -- RESTORE_CR3 cannot resture user CR3 if
run with user GSBASE.  This results in infinitely recursing
exceptions if user code does SYSENTER with TF set if both FSGSBASE
and PTI are enabled.

The old code worked if user code just set TF without SYSENTER
because #DB from user mode is special cased in idtentry and
paranoid_exit doesn't run.

Fix it by cleaning up the spaghetti code.  All that paranoid_exit
needs to do is to disable IRQs, handle IRQ tracing, then restore
CR3, and restore GSBASE.  Simply do those actions in that order.

Fixes: 708078f65721 ("x86/entry/64: Handle FSGSBASE enabled paranoid entry/exit")
Reported-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: "Bae, Chang Seok" <chang.seok.bae@intel.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/entry_64.S | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 54b1b0468b2b..670306f588bf 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1256,31 +1256,32 @@ END(paranoid_entry)
 ENTRY(paranoid_exit)
 	UNWIND_HINT_REGS
 	DISABLE_INTERRUPTS(CLBR_ANY)
-	TRACE_IRQS_OFF_DEBUG
 
-	/* Handle GS depending on FSGSBASE availability */
-	ALTERNATIVE "jmp .Lparanoid_exit_checkgs", "nop",X86_FEATURE_FSGSBASE
+	/*
+	 * The order of operations is important.  IRQ tracing requires
+	 * kernel GSBASE and CR3.  RESTORE_CR3 requires kernel GS base.
+	 *
+	 * NB to anyone to tries to optimize this code: this code does
+	 * not execute at all for exceptions coming from user mode.  Those
+	 * exceptions go through error_exit instead.
+	 */
+	TRACE_IRQS_IRETQ_DEBUG
+	RESTORE_CR3	scratch_reg=%rax save_reg=%r14
+
+	/* Handle the three GSBASE cases. */
+	ALTERNATIVE "jmp .Lparanoid_exit_checkgs", "", X86_FEATURE_FSGSBASE
 
 	/* With FSGSBASE enabled, unconditionally restore GSBASE */
 	wrgsbase	%rbx
-	jmp	.Lparanoid_exit_no_swapgs;
+	jmp	restore_regs_and_return_to_kernel
 
 .Lparanoid_exit_checkgs:
 	/* On non-FSGSBASE systems, conditionally do SWAPGS */
 	testl	%ebx, %ebx
-	jnz	.Lparanoid_exit_no_swapgs
-	TRACE_IRQS_IRETQ
-	/* Always restore stashed CR3 value (see paranoid_entry) */
-	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
-	SWAPGS_UNSAFE_STACK
-	jmp	.Lparanoid_exit_restore
-
-.Lparanoid_exit_no_swapgs:
-	TRACE_IRQS_IRETQ_DEBUG
-	/* Always restore stashed CR3 value (see paranoid_entry) */
-	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
+	jnz	restore_regs_and_return_to_kernel
 
-.Lparanoid_exit_restore:
+	/* We are returning to a context with user GSBASE. */
+	SWAPGS_UNSAFE_STACK
 	jmp	restore_regs_and_return_to_kernel
 END(paranoid_exit)
 
-- 
2.21.0

