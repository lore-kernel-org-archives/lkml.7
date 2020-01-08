Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7922DC00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54523206F0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgAHKir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 05:38:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49243 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbgAHKir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 05:38:47 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ip8jW-0003WJ-4T; Wed, 08 Jan 2020 11:38:38 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 731AA1C2C92;
        Wed,  8 Jan 2020 11:38:37 +0100 (CET)
Date:   Wed, 08 Jan 2020 10:38:37 -0000
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/cpufeatures: Add support for fast short REP; MOVSB
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191216214254.26492-1-tony.luck@intel.com>
References: <20191216214254.26492-1-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <157847991723.30329.17038297307002446505.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     f444a5ff95dce07cf4353cbb85fc3e785019d430
Gitweb:        https://git.kernel.org/tip/f444a5ff95dce07cf4353cbb85fc3e785019d430
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Mon, 16 Dec 2019 13:42:54 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 08 Jan 2020 11:29:25 +01:00

x86/cpufeatures: Add support for fast short REP; MOVSB

>From the Intel Optimization Reference Manual:

3.7.6.1 Fast Short REP MOVSB
Beginning with processors based on Ice Lake Client microarchitecture,
REP MOVSB performance of short operations is enhanced. The enhancement
applies to string lengths between 1 and 128 bytes long.  Support for
fast-short REP MOVSB is enumerated by the CPUID feature flag: CPUID
[EAX=7H, ECX=0H).EDX.FAST_SHORT_REP_MOVSB[bit 4] = 1. There is no change
in the REP STOS performance.

Add an X86_FEATURE_FSRM flag for this.

memmove() avoids REP MOVSB for short (< 32 byte) copies. Check FSRM and
use REP MOVSB for short copies on systems that support it.

 [ bp: Massage and add comment. ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20191216214254.26492-1-tony.luck@intel.com
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/lib/memmove_64.S          | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index e9b6249..98c60fa 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -357,6 +357,7 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 */
 #define X86_FEATURE_AVX512_4VNNIW	(18*32+ 2) /* AVX-512 Neural Network Instructions */
 #define X86_FEATURE_AVX512_4FMAPS	(18*32+ 3) /* AVX-512 Multiply Accumulation Single precision */
+#define X86_FEATURE_FSRM		(18*32+ 4) /* Fast Short Rep Mov */
 #define X86_FEATURE_AVX512_VP2INTERSECT (18*32+ 8) /* AVX-512 Intersect for D/Q */
 #define X86_FEATURE_MD_CLEAR		(18*32+10) /* VERW clears CPU buffers */
 #define X86_FEATURE_TSX_FORCE_ABORT	(18*32+13) /* "" TSX_FORCE_ABORT */
diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
index 337830d..7ff00ea 100644
--- a/arch/x86/lib/memmove_64.S
+++ b/arch/x86/lib/memmove_64.S
@@ -29,10 +29,7 @@
 SYM_FUNC_START_ALIAS(memmove)
 SYM_FUNC_START(__memmove)
 
-	/* Handle more 32 bytes in loop */
 	mov %rdi, %rax
-	cmp $0x20, %rdx
-	jb	1f
 
 	/* Decide forward/backward copy mode */
 	cmp %rdi, %rsi
@@ -42,7 +39,9 @@ SYM_FUNC_START(__memmove)
 	cmp %rdi, %r8
 	jg 2f
 
+	/* FSRM implies ERMS => no length checks, do the copy directly */
 .Lmemmove_begin_forward:
+	ALTERNATIVE "cmp $0x20, %rdx; jb 1f", "", X86_FEATURE_FSRM
 	ALTERNATIVE "", "movq %rdx, %rcx; rep movsb; retq", X86_FEATURE_ERMS
 
 	/*
@@ -114,6 +113,8 @@ SYM_FUNC_START(__memmove)
 	 */
 	.p2align 4
 2:
+	cmp $0x20, %rdx
+	jb 1f
 	cmp $680, %rdx
 	jb 6f
 	cmp %dil, %sil
