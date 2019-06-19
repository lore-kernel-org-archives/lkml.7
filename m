Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006FAC43613
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 21:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2621208CA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 21:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbfFSVnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 17:43:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:31057 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfFSVnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 17:43:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 14:43:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,394,1557212400"; 
   d="scan'208";a="182870099"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga004.fm.intel.com with ESMTP; 19 Jun 2019 14:43:38 -0700
Date:   Wed, 19 Jun 2019 14:34:04 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Christopherson Sean J <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v2 2/2] x86/cpufeatures: Enumerate new AVX512 BFLOAT16
 instructions
Message-ID: <20190619213404.GB234387@romley-ivt3.sc.intel.com>
References: <1560794416-217638-1-git-send-email-fenghua.yu@intel.com>
 <1560794416-217638-3-git-send-email-fenghua.yu@intel.com>
 <20190619173140.GH9574@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619173140.GH9574@zn.tnic>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 07:31:40PM +0200, Borislav Petkov wrote:
> On Mon, Jun 17, 2019 at 11:00:16AM -0700, Fenghua Yu wrote:
> > AVX512 Vector Neural Network Instructions (VNNI) in Intel Deep Learning
> > Boost support BFLOAT16 format (BF16).
> 
> That sentence is a mouthful and I have no clue what it means. Marketing
> junk? If so, either rewrite it for mere mortals or kill it.
> 
> > BF16 is a short version of FP32
> 
> FP32?
> 
> Please write out.
> 
> > and has several advantages over FP16.
> 
> Ditto.
> 
> > BF16 offers more than enough range for
> > deep learning training tasks and doesn't need to handle hardware exception
> > as this is a performance optimization. FP32 accumulation after the
> > multiply is essential to achieve sufficient numerical behavior on an
> > application level.
> > 
> > AVX512 BFLOAT16 instructions can be enumerated by:
> > 	CPUID.7.1:EAX[bit 5] AVX512_BF16
> > 
> > Use word 12, which is empty now, to hold features in CPUID.7.1:EAX
> > including AVX512_BF16.
> 
> ... because that leaf is features only, right?
> 
> > Leaf CPUID_DUMMY is renamed as CPUID_7_1_EAX.
> 
> That's obvious from the patch, ain't it?
> 

Hi, Boris,

I corrected the commit message per your comment. Except the commit
message, I didn't change anything else.

Now I send the updated patch here. Is the patch right now?
Should I send the patch to you in another thread?

Thanks.

-Fenghua


From 6265ae0a0fac5ecf7e67b8bfc4b6791afb88e56c Mon Sep 17 00:00:00 2001
From: Fenghua Yu <fenghua.yu@intel.com>
Date: Tue, 11 Jun 2019 23:06:05 +0000
Subject: [PATCH v3 3/3] x86/cpufeatures: Enumerate new AVX512 BFLOAT16
 instructions

AVX512 BFLOAT16 instructions support 16-bit BFLOAT16 floating-point
format (BF16) for deep learning optimization.

BF16 is a short version of 32-bit single-precision floating-point
format (FP32) and has several advantages over 16-bit half-precision
floating-point format (FP16). BF16 keeps FP32 accumulation after
multiplication without loss of precision, offers more than enough
range for deep learning training tasks, and doesn't need to handle
hardware exception.

AVX512 BFLOAT16 instructions can be enumerated by:
	CPUID.7.1:EAX[bit 5] AVX512_BF16

CPUID.7.1:EAX contains only feature bits. Re-define currently empty
word 12 as a pure features word to hold the feature bits including
AVV512_BF16.

Detailed information of the CPUID bit and AVX512 BFLOAT16 instructions
can be found in the latest Intel Architecture Instruction Set Extensions
and Future Features Programming Reference.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/include/asm/cpufeature.h  | 2 +-
 arch/x86/include/asm/cpufeatures.h | 3 +++
 arch/x86/kernel/cpu/common.c       | 3 +++
 arch/x86/kernel/cpu/cpuid-deps.c   | 1 +
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 403f70c2e431..58acda503817 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -23,7 +23,7 @@ enum cpuid_leafs
 	CPUID_7_0_EBX,
 	CPUID_D_1_EAX,
 	CPUID_LNX_4,
-	CPUID_DUMMY,
+	CPUID_7_1_EAX,
 	CPUID_8000_0008_EBX,
 	CPUID_6_EAX,
 	CPUID_8000_000A_EDX,
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 7103007abe17..a49498834c6c 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -280,6 +280,9 @@
 #define X86_FEATURE_CQM_MBM_TOTAL	(11*32+ 2) /* LLC Total MBM monitoring */
 #define X86_FEATURE_CQM_MBM_LOCAL	(11*32+ 3) /* LLC Local MBM monitoring */
 
+/* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
+#define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
+
 /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13 */
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
 #define X86_FEATURE_IRPERF		(13*32+ 1) /* Instructions Retired Count */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index efb114298cfb..4910cb421b82 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -847,6 +847,9 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 		c->x86_capability[CPUID_7_0_EBX] = ebx;
 		c->x86_capability[CPUID_7_ECX] = ecx;
 		c->x86_capability[CPUID_7_EDX] = edx;
+
+		cpuid_count(0x00000007, 1, &eax, &ebx, &ecx, &edx);
+		c->x86_capability[CPUID_7_1_EAX] = eax;
 	}
 
 	/* Extended state features: level 0x0000000d */
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index fa07a224e7b9..a444028d8145 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -62,6 +62,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_CQM_OCCUP_LLC,	X86_FEATURE_CQM_LLC   },
 	{ X86_FEATURE_CQM_MBM_TOTAL,	X86_FEATURE_CQM_LLC   },
 	{ X86_FEATURE_CQM_MBM_LOCAL,	X86_FEATURE_CQM_LLC   },
+	{ X86_FEATURE_AVX512_BF16,	X86_FEATURE_AVX512VL  },
 	{}
 };
 
-- 
2.19.1


