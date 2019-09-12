Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80312C4CEC8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 20:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E06208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 20:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfILUIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 16:08:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:35554 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbfILUH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 16:07:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2019 13:07:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="336688238"
Received: from chang-linux-3.sc.intel.com ([172.25.66.185])
  by orsmga004.jf.intel.com with ESMTP; 12 Sep 2019 13:07:55 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     ravi.v.shankar@intel.com, chang.seok.bae@intel.com,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH v8 08/17] x86/entry/64: Clean up paranoid exit
Date:   Thu, 12 Sep 2019 13:06:49 -0700
Message-Id: <1568318818-4091-9-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568318818-4091-1-git-send-email-chang.seok.bae@intel.com>
References: <1568318818-4091-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

All that paranoid exit needs to do is to disable IRQs, handle IRQ tracing,
then restore CR3, and restore GS base. Simply do those actions in that
order. Cleaning up the spaghetti code.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Vegard Nossum <vegard.nossum@oracle.com>
---

Changes from v7:
* Included as a new patch. Took the cleanup part from the Andy Lutomirski's
  original patch [*] and edited its changelog a little bit.

[*] https://lkml.kernel.org/r/59725ceb08977359489fbed979716949ad45f616.1562035429.git.luto@kernel.org
---
 arch/x86/entry/entry_64.S | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index b7c3ea4..dd0d62a 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1265,20 +1265,25 @@ END(paranoid_entry)
 ENTRY(paranoid_exit)
 	UNWIND_HINT_REGS
 	DISABLE_INTERRUPTS(CLBR_ANY)
+
+	/*
+	 * The order of operations is important. IRQ tracing requires
+	 * kernel GS base and CR3. RESTORE_CR3 requires kernel GS base.
+	 *
+	 * NB to anyone to try to optimize this code: this code does
+	 * not execute at all for exceptions from user mode. Those
+	 * exceptions go through error_exit instead.
+	 */
 	TRACE_IRQS_OFF_DEBUG
-	testl	%ebx, %ebx			/* swapgs needed? */
-	jnz	.Lparanoid_exit_no_swapgs
-	TRACE_IRQS_IRETQ
-	/* Always restore stashed CR3 value (see paranoid_entry) */
-	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
+	RESTORE_CR3	scratch_reg=%rax save_reg=%r14
+
+	/* If EBX is 0, SWAPGS is required */
+	testl	%ebx, %ebx
+	jnz	restore_regs_and_return_to_kernel
+
+	/* We are returning to a context with user GS base */
 	SWAPGS_UNSAFE_STACK
-	jmp	.Lparanoid_exit_restore
-.Lparanoid_exit_no_swapgs:
-	TRACE_IRQS_IRETQ_DEBUG
-	/* Always restore stashed CR3 value (see paranoid_entry) */
-	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
-.Lparanoid_exit_restore:
-	jmp restore_regs_and_return_to_kernel
+	jmp	restore_regs_and_return_to_kernel
 END(paranoid_exit)
 
 /*
-- 
2.7.4

