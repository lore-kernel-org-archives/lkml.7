Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844F1C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 21:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7C324673
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 21:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfLPVm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 16:42:57 -0500
Received: from mga06.intel.com ([134.134.136.31]:3598 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbfLPVm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 16:42:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 13:42:55 -0800
X-IronPort-AV: E=Sophos;i="5.69,323,1571727600"; 
   d="scan'208,223";a="209457143"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 13:42:55 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/cpufeatures: Add support for fast short rep mov
Date:   Mon, 16 Dec 2019 13:42:54 -0800
Message-Id: <20191216214254.26492-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191212225210.GA22094@zn.tnic>
References: <20191212225210.GA22094@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From the Intel Optimization Reference Manual:

3.7.6.1 Fast Short REP MOVSB
Beginning with processors based on Ice Lake Client microarchitecture,
REP MOVSB performance of short operations is enhanced. The enhancement
applies to string lengths between 1 and 128 bytes long.  Support for
fast-short REP MOVSB is enumerated by the CPUID feature flag: CPUID
[EAX=7H, ECX=0H).EDX.FAST_SHORT_REP_MOVSB[bit 4] = 1. There is no change
in the REP STOS performance.

Add an X86_FEATURE_FSRM flag for this.

memmove() avoids REP MOVSB for short (< 32 byte) copies. Fix it
to check FSRM and use REP MOVSB for short copies on systems that
support it.

Signed-off-by: Tony Luck <tony.luck@intel.com>

---

Time (cycles) for memmove() sizes 1..31 with neither source nor
destination in cache.

  1800 +-+-------+--------+---------+---------+---------+--------+-------+-+
       +         +        +         +         +         +        +         +
  1600 +-+                                          'memmove-fsrm' *******-+
       |   ######                                   'memmove-orig' ####### |
  1400 +-+ #     #####################                                   +-+
       |   #                          ############                         |
  1200 +-+#                                       ##################     +-+
       |  #                                                                |
  1000 +-+#                                                              +-+
       |  #                                                                |
       | #                                                                 |
   800 +-#                                                               +-+
       | #                                                                 |
   600 +-***********************                                         +-+
       |                        *****************************              |
   400 +-+                                                   *******     +-+
       |                                                                   |
   200 +-+                                                               +-+
       +         +        +         +         +         +        +         +
     0 +-+-------+--------+---------+---------+---------+--------+-------+-+
       0         5        10        15        20        25       30        35
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/lib/memmove_64.S          | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index e9b62498fe75..98c60fa31ced 100644
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
index 337830d7a59c..4a23086806e6 100644
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
@@ -43,6 +40,7 @@ SYM_FUNC_START(__memmove)
 	jg 2f
 
 .Lmemmove_begin_forward:
+	ALTERNATIVE "cmp $0x20, %rdx; jb 1f", "", X86_FEATURE_FSRM
 	ALTERNATIVE "", "movq %rdx, %rcx; rep movsb; retq", X86_FEATURE_ERMS
 
 	/*
@@ -114,6 +112,8 @@ SYM_FUNC_START(__memmove)
 	 */
 	.p2align 4
 2:
+	cmp $0x20, %rdx
+	jb	1f
 	cmp $680, %rdx
 	jb 6f
 	cmp %dil, %sil
-- 
2.20.1

