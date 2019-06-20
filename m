Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A46C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 11:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 243E62075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 11:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="p6VbguMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731739AbfFTLjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 07:39:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55771 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfFTLjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 07:39:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5KBcdkL946384
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 20 Jun 2019 04:38:39 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5KBcdkL946384
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561030720;
        bh=tS1XAjpDigpBTn2j4TBO7NVMbdSZzdbdrZXPVG3WvWI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=p6VbguMwCzYM4YHr3lpcPHliZBlrYEA8lz4t2DWFxNacGx+f91/lLK1PuiRd5tU9t
         t5NOfJ7k0zQA5gXaGSvcxrH/AVPTGfoXmB7aZJIQIGnST11YuJAebAGueRCc4nN0PX
         mktYFlw4mnrQgdJ/66HOy2ZMA6OF8uASElUzYw0LE/LDJoM5OuYQjtyMn+dXWwDBUx
         D3sTnT6ftCuqXnVWgaJ1SPk3hN5BqotYEGoHHt5XicwA+tq2HDsBdxgw+c3X9Qul2h
         CtGtTW6yzFXXVBtWV43R0Ad94ouqOnHglsSjXiKITHaD7APAKP2Inn8BC+Mjy9oQ5w
         qp2e8/6cyswxw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5KBccuE946377;
        Thu, 20 Jun 2019 04:38:38 -0700
Date:   Thu, 20 Jun 2019 04:38:38 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Fenghua Yu <tipbot@zytor.com>
Message-ID: <tip-b302e4b176d00e1cbc80148c5d0aee36751f7480@git.kernel.org>
Cc:     fenghua.yu@intel.com, bp@suse.de, robert.hu@linux.intel.com,
        Thomas.Lendacky@amd.com, chang.seok.bae@intel.com,
        pasha.tatashin@oracle.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, frederic@kernel.org, mpe@ellerman.id.au,
        mingo@kernel.org, hpa@zytor.com, jannh@google.com,
        pfeiner@google.com, rafael.j.wysocki@intel.com,
        sean.j.christopherson@intel.com, x86@kernel.org,
        yamada.masahiro@socionext.com, mingo@redhat.com,
        pbonzini@redhat.com, ravi.v.shankar@intel.com, namit@vmware.com,
        rkrcmar@redhat.com
Reply-To: fenghua.yu@intel.com, robert.hu@linux.intel.com,
          pasha.tatashin@oracle.com, Thomas.Lendacky@amd.com,
          tglx@linutronix.de, frederic@kernel.org,
          rafael.j.wysocki@intel.com, pfeiner@google.com, x86@kernel.org,
          sean.j.christopherson@intel.com, bp@suse.de,
          linux-kernel@vger.kernel.org, chang.seok.bae@intel.com,
          mpe@ellerman.id.au, jannh@google.com, mingo@kernel.org,
          hpa@zytor.com, mingo@redhat.com, yamada.masahiro@socionext.com,
          rkrcmar@redhat.com, namit@vmware.com, pbonzini@redhat.com,
          ravi.v.shankar@intel.com
In-Reply-To: <1560794416-217638-3-git-send-email-fenghua.yu@intel.com>
References: <1560794416-217638-3-git-send-email-fenghua.yu@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/cpufeatures: Enumerate the new AVX512 BFLOAT16
 instructions
Git-Commit-ID: b302e4b176d00e1cbc80148c5d0aee36751f7480
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

Commit-ID:  b302e4b176d00e1cbc80148c5d0aee36751f7480
Gitweb:     https://git.kernel.org/tip/b302e4b176d00e1cbc80148c5d0aee36751f7480
Author:     Fenghua Yu <fenghua.yu@intel.com>
AuthorDate: Mon, 17 Jun 2019 11:00:16 -0700
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 20 Jun 2019 12:38:49 +0200

x86/cpufeatures: Enumerate the new AVX512 BFLOAT16 instructions

AVX512 BFLOAT16 instructions support 16-bit BFLOAT16 floating-point
format (BF16) for deep learning optimization.

BF16 is a short version of 32-bit single-precision floating-point
format (FP32) and has several advantages over 16-bit half-precision
floating-point format (FP16). BF16 keeps FP32 accumulation after
multiplication without loss of precision, offers more than enough
range for deep learning training tasks, and doesn't need to handle
hardware exception.

AVX512 BFLOAT16 instructions are enumerated in CPUID.7.1:EAX[bit 5]
AVX512_BF16.

CPUID.7.1:EAX contains only feature bits. Reuse the currently empty
word 12 as a pure features word to hold the feature bits including
AVX512_BF16.

Detailed information of the CPUID bit and AVX512 BFLOAT16 instructions
can be found in the latest Intel Architecture Instruction Set Extensions
and Future Features Programming Reference.

 [ bp: Check CPUID(7) subleaf validity before accessing subleaf 1. ]

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nadav Amit <namit@vmware.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Peter Feiner <pfeiner@google.com>
Cc: Radim Krcmar <rkrcmar@redhat.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc: Robert Hoo <robert.hu@linux.intel.com>
Cc: "Sean J Christopherson" <sean.j.christopherson@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>
Cc: x86 <x86@kernel.org>
Link: https://lkml.kernel.org/r/1560794416-217638-3-git-send-email-fenghua.yu@intel.com
---
 arch/x86/include/asm/cpufeature.h  | 2 +-
 arch/x86/include/asm/cpufeatures.h | 3 +++
 arch/x86/kernel/cpu/common.c       | 6 ++++++
 arch/x86/kernel/cpu/cpuid-deps.c   | 1 +
 4 files changed, 11 insertions(+), 1 deletion(-)

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
index be858b86023a..8ecd9fac97c3 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -282,6 +282,9 @@
 #define X86_FEATURE_CQM_MBM_TOTAL	(11*32+ 2) /* LLC Total MBM monitoring */
 #define X86_FEATURE_CQM_MBM_LOCAL	(11*32+ 3) /* LLC Local MBM monitoring */
 
+/* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
+#define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
+
 /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13 */
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
 #define X86_FEATURE_IRPERF		(13*32+ 1) /* Instructions Retired Count */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index efb114298cfb..dad20bc891d5 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -847,6 +847,12 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 		c->x86_capability[CPUID_7_0_EBX] = ebx;
 		c->x86_capability[CPUID_7_ECX] = ecx;
 		c->x86_capability[CPUID_7_EDX] = edx;
+
+		/* Check valid sub-leaf index before accessing it */
+		if (eax >= 1) {
+			cpuid_count(0x00000007, 1, &eax, &ebx, &ecx, &edx);
+			c->x86_capability[CPUID_7_1_EAX] = eax;
+		}
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
 
