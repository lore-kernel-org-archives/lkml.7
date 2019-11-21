Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65E6C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832692068F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfKUUOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 15:14:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33405 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfKUUOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 15:14:32 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXsqP-0004fP-Mn; Thu, 21 Nov 2019 21:14:25 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 56A7F1C1A4D;
        Thu, 21 Nov 2019 21:14:25 +0100 (CET)
Date:   Thu, 21 Nov 2019 20:14:25 -0000
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/entry/32: Move FIXUP_FRAME after pushing %fs in
 SAVE_ALL
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@kernel.org,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157436726527.21853.15902234304768528253.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     82cb8a0b1d8d07817b5d59f7fa1438e1fceafab2
Gitweb:        https://git.kernel.org/tip/82cb8a0b1d8d07817b5d59f7fa1438e1fceafab2
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Wed, 20 Nov 2019 09:56:36 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Nov 2019 19:37:43 +01:00

x86/entry/32: Move FIXUP_FRAME after pushing %fs in SAVE_ALL

This will allow us to get percpu access working before FIXUP_FRAME,
which will allow us to unwind ESPFIX earlier.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@kernel.org
---
 arch/x86/entry/entry_32.S | 66 ++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 31 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 341597e..d9f4019 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -213,54 +213,58 @@
 	 *
 	 * Be careful: we may have nonzero SS base due to ESPFIX.
 	 */
-	andl	$0x0000ffff, 3*4(%esp)
+	andl	$0x0000ffff, 4*4(%esp)
 
 #ifdef CONFIG_VM86
-	testl	$X86_EFLAGS_VM, 4*4(%esp)
+	testl	$X86_EFLAGS_VM, 5*4(%esp)
 	jnz	.Lfrom_usermode_no_fixup_\@
 #endif
-	testl	$USER_SEGMENT_RPL_MASK, 3*4(%esp)
+	testl	$USER_SEGMENT_RPL_MASK, 4*4(%esp)
 	jnz	.Lfrom_usermode_no_fixup_\@
 
-	orl	$CS_FROM_KERNEL, 3*4(%esp)
+	orl	$CS_FROM_KERNEL, 4*4(%esp)
 
 	/*
 	 * When we're here from kernel mode; the (exception) stack looks like:
 	 *
-	 *  5*4(%esp) - <previous context>
-	 *  4*4(%esp) - flags
-	 *  3*4(%esp) - cs
-	 *  2*4(%esp) - ip
-	 *  1*4(%esp) - orig_eax
-	 *  0*4(%esp) - gs / function
+	 *  6*4(%esp) - <previous context>
+	 *  5*4(%esp) - flags
+	 *  4*4(%esp) - cs
+	 *  3*4(%esp) - ip
+	 *  2*4(%esp) - orig_eax
+	 *  1*4(%esp) - gs / function
+	 *  0*4(%esp) - fs
 	 *
 	 * Lets build a 5 entry IRET frame after that, such that struct pt_regs
 	 * is complete and in particular regs->sp is correct. This gives us
-	 * the original 5 enties as gap:
+	 * the original 6 enties as gap:
 	 *
-	 * 12*4(%esp) - <previous context>
-	 * 11*4(%esp) - gap / flags
-	 * 10*4(%esp) - gap / cs
-	 *  9*4(%esp) - gap / ip
-	 *  8*4(%esp) - gap / orig_eax
-	 *  7*4(%esp) - gap / gs / function
-	 *  6*4(%esp) - ss
-	 *  5*4(%esp) - sp
-	 *  4*4(%esp) - flags
-	 *  3*4(%esp) - cs
-	 *  2*4(%esp) - ip
-	 *  1*4(%esp) - orig_eax
-	 *  0*4(%esp) - gs / function
+	 * 14*4(%esp) - <previous context>
+	 * 13*4(%esp) - gap / flags
+	 * 12*4(%esp) - gap / cs
+	 * 11*4(%esp) - gap / ip
+	 * 10*4(%esp) - gap / orig_eax
+	 *  9*4(%esp) - gap / gs / function
+	 *  8*4(%esp) - gap / fs
+	 *  7*4(%esp) - ss
+	 *  6*4(%esp) - sp
+	 *  5*4(%esp) - flags
+	 *  4*4(%esp) - cs
+	 *  3*4(%esp) - ip
+	 *  2*4(%esp) - orig_eax
+	 *  1*4(%esp) - gs / function
+	 *  0*4(%esp) - fs
 	 */
 
 	pushl	%ss		# ss
 	pushl	%esp		# sp (points at ss)
-	addl	$6*4, (%esp)	# point sp back at the previous context
-	pushl	6*4(%esp)	# flags
-	pushl	6*4(%esp)	# cs
-	pushl	6*4(%esp)	# ip
-	pushl	6*4(%esp)	# orig_eax
-	pushl	6*4(%esp)	# gs / function
+	addl	$7*4, (%esp)	# point sp back at the previous context
+	pushl	7*4(%esp)	# flags
+	pushl	7*4(%esp)	# cs
+	pushl	7*4(%esp)	# ip
+	pushl	7*4(%esp)	# orig_eax
+	pushl	7*4(%esp)	# gs / function
+	pushl	7*4(%esp)	# fs
 .Lfrom_usermode_no_fixup_\@:
 .endm
 
@@ -308,8 +312,8 @@
 .if \skip_gs == 0
 	PUSH_GS
 .endif
-	FIXUP_FRAME
 	pushl	%fs
+	FIXUP_FRAME
 	pushl	%es
 	pushl	%ds
 	pushl	\pt_regs_ax
