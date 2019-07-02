Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D09CC5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 06:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7E621721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 06:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="UhBu9cW3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfGBGup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 02:50:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36369 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfGBGup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 02:50:45 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x626oQS32680406
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 1 Jul 2019 23:50:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x626oQS32680406
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562050227;
        bh=dMoFTRvS86LPmZa4tUjD8/8R+ZdhbMDdXuUXDuSvgpg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=UhBu9cW3kzrZKxQQPsS7zQoefHpfnArn3A43gknMpO4ETSCqkmjAN/ZI1di2/kSFq
         9ev7lix+Di+znzEoGgPcwps2dz3q7UgpMZG1+RZ1BJAPS/15LBPRxJ1S1a20trk6DW
         lkNFXhac3hF2uCZrOfOZskl7psfq2J8X8HWiIefoQdfV/bfoNkzTRugSDpacj5TXwf
         PlNQzWL3w52uE5TNvJsMGkERifQI9uw/InHATUTJvDs1DHNnq/QUx8O1L15jVU48N8
         Zz0kbmqTwHcqSDsMOIMZC25+PkwbrTuCJvwijeWg4hyDqwiJE6r8YSVsSULxSlUTPR
         T3JBjG52xHWQQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x626oQ3i2680403;
        Mon, 1 Jul 2019 23:50:26 -0700
Date:   Mon, 1 Jul 2019 23:50:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-539bca535decb11a0861b6205c6684b8e908589b@git.kernel.org>
Cc:     mingo@kernel.org, vegard.nossum@oracle.com, bp@alien8.de,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com,
        ak@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        tglx@linutronix.de, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Reply-To: chang.seok.bae@intel.com, ak@linux.intel.com, hpa@zytor.com,
          mingo@kernel.org, vegard.nossum@oracle.com, bp@alien8.de,
          ravi.v.shankar@intel.com, luto@kernel.org, tglx@linutronix.de,
          peterz@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <59725ceb08977359489fbed979716949ad45f616.1562035429.git.luto@kernel.org>
References: <59725ceb08977359489fbed979716949ad45f616.1562035429.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/entry/64: Fix and clean up paranoid_exit
Git-Commit-ID: 539bca535decb11a0861b6205c6684b8e908589b
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

Commit-ID:  539bca535decb11a0861b6205c6684b8e908589b
Gitweb:     https://git.kernel.org/tip/539bca535decb11a0861b6205c6684b8e908589b
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Mon, 1 Jul 2019 20:43:21 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 2 Jul 2019 08:45:20 +0200

x86/entry/64: Fix and clean up paranoid_exit

paranoid_exit needs to restore CR3 before GSBASE.  Doing it in the opposite
order crashes if the exception came from a context with user GSBASE and
user CR3 -- RESTORE_CR3 cannot resture user CR3 if run with user GSBASE.
This results in infinitely recursing exceptions if user code does SYSENTER
with TF set if both FSGSBASE and PTI are enabled.

The old code worked if user code just set TF without SYSENTER because #DB
from user mode is special cased in idtentry and paranoid_exit doesn't run.

Fix it by cleaning up the spaghetti code.  All that paranoid_exit needs to
do is to disable IRQs, handle IRQ tracing, then restore CR3, and restore
GSBASE.  Simply do those actions in that order.

Fixes: 708078f65721 ("x86/entry/64: Handle FSGSBASE enabled paranoid entry/exit")
Reported-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Link: https://lkml.kernel.org/r/59725ceb08977359489fbed979716949ad45f616.1562035429.git.luto@kernel.org

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
 
