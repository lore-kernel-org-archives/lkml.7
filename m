Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374D9C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066E820820
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Vrtn7mNe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfFVKJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 06:09:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39641 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfFVKJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 06:09:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5MA9kem2097070
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 22 Jun 2019 03:09:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5MA9kem2097070
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561198187;
        bh=g5pNh2ZJ1FYy0xHwSBmXNITSp3hGcodHBKn0wlhxs50=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Vrtn7mNeHPshiYGz383UHDCnTiCSN21ykBoY4XB4zBbdDg6bPQeqDiCdJakYN1QQZ
         432R/WK7pFX1LLqrjE04qxWZbuqGXWiefDHm2uyXgvIHuA9qNWb6qPc9Zwa+yobR8O
         bRfC2iMHSafs6tJWXF73NRZV/2Tlqpa+/rfib8NIHuvL3nWmq9JXCWw0XjQgHMWMrO
         57Z+h3u3QMp60V5N67J6D44OgTfdHGel21ooDhtjOvmFn6DkHjpqb65m5iHQ68E2fs
         /HrEi4NQ+t9neLYd1tlUdhQNaZtvPUHyg2a+oAX45FtqH0TcgDsQ80jK11R3oF3IxB
         UsLu5sqUdzygw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5MA9k0O2097063;
        Sat, 22 Jun 2019 03:09:46 -0700
Date:   Sat, 22 Jun 2019 03:09:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Chang S. Bae" <tipbot@zytor.com>
Message-ID: <tip-1d07316b1363a004ed548c3759584f8e8b1e24e3@git.kernel.org>
Cc:     dave.hansen@linux.intel.com, chang.seok.bae@intel.com,
        ak@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@kernel.org,
        ravi.v.shankar@intel.com
Reply-To: linux-kernel@vger.kernel.org, ravi.v.shankar@intel.com,
          mingo@kernel.org, luto@kernel.org, tglx@linutronix.de,
          dave.hansen@linux.intel.com, ak@linux.intel.com, hpa@zytor.com,
          chang.seok.bae@intel.com
In-Reply-To: <1557309753-24073-11-git-send-email-chang.seok.bae@intel.com>
References: <1557309753-24073-11-git-send-email-chang.seok.bae@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/entry/64: Switch CR3 before SWAPGS in paranoid
 entry
Git-Commit-ID: 1d07316b1363a004ed548c3759584f8e8b1e24e3
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

Commit-ID:  1d07316b1363a004ed548c3759584f8e8b1e24e3
Gitweb:     https://git.kernel.org/tip/1d07316b1363a004ed548c3759584f8e8b1e24e3
Author:     Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate: Wed, 8 May 2019 03:02:25 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 11:38:53 +0200

x86/entry/64: Switch CR3 before SWAPGS in paranoid entry

When FSGSBASE is enabled, the GSBASE handling in paranoid entry will need
to retrieve the kernel GSBASE which requires that the kernel page table is
active.

As the CR3 switch to the kernel page tables (PTI is active) does not depend
on kernel GSBASE, move the CR3 switch in front of the GSBASE handling.

Comment the EBX content while at it.

No functional change.

[ tglx: Rewrote changelog and comments ]

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Link: https://lkml.kernel.org/r/1557309753-24073-11-git-send-email-chang.seok.bae@intel.com

---
 arch/x86/entry/entry_64.S | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 11aa3b2afa4d..aaa846f8850a 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1173,13 +1173,6 @@ ENTRY(paranoid_entry)
 	cld
 	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
-	movl	$1, %ebx
-	movl	$MSR_GS_BASE, %ecx
-	rdmsr
-	testl	%edx, %edx
-	js	1f				/* negative -> in kernel */
-	SWAPGS
-	xorl	%ebx, %ebx
 
 1:
 	/*
@@ -1191,9 +1184,30 @@ ENTRY(paranoid_entry)
 	 * This is also why CS (stashed in the "iret frame" by the
 	 * hardware at entry) can not be used: this may be a return
 	 * to kernel code, but with a user CR3 value.
+	 *
+	 * Switching CR3 does not depend on kernel GSBASE so it can
+	 * be done before switching to the kernel GSBASE. This is
+	 * required for FSGSBASE because the kernel GSBASE has to
+	 * be retrieved from a kernel internal table.
 	 */
 	SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg=%rax save_reg=%r14
 
+	/* EBX = 1 -> kernel GSBASE active, no restore required */
+	movl	$1, %ebx
+	/*
+	 * The kernel-enforced convention is a negative GSBASE indicates
+	 * a kernel value. No SWAPGS needed on entry and exit.
+	 */
+	movl	$MSR_GS_BASE, %ecx
+	rdmsr
+	testl	%edx, %edx
+	jns	.Lparanoid_entry_swapgs
+	ret
+
+.Lparanoid_entry_swapgs:
+	SWAPGS
+	/* EBX = 0 -> SWAPGS required on exit */
+	xorl	%ebx, %ebx
 	ret
 END(paranoid_entry)
 
@@ -1213,7 +1227,8 @@ ENTRY(paranoid_exit)
 	UNWIND_HINT_REGS
 	DISABLE_INTERRUPTS(CLBR_ANY)
 	TRACE_IRQS_OFF_DEBUG
-	testl	%ebx, %ebx			/* swapgs needed? */
+	/* If EBX is 0, SWAPGS is required */
+	testl	%ebx, %ebx
 	jnz	.Lparanoid_exit_no_swapgs
 	TRACE_IRQS_IRETQ
 	/* Always restore stashed CR3 value (see paranoid_entry) */
