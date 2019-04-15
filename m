Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F16C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E734D2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SuH47miC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfDOOiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:38:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40548 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfDOOiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:38:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id d31so8671430pgl.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 07:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=AIqQfazSNqgaJokAcdDro2dFfhikFIqjWxYw4YigiZI=;
        b=SuH47miCIm32LQ4+GVx4b0RiF3W5u3IsWgCSZFT/vLpwrxdUSzD7Z8sXmj3u8eoZkV
         C/N1vWmbFJ2652FjmouJCx3L8vVnAaFCgpUXvlBF5Vpmj0Xg+F6XcVZ7cSDfzY3Nim1N
         K+T/cXrHWKGh7zfMTszsZnctfciUvAIxz25Do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=AIqQfazSNqgaJokAcdDro2dFfhikFIqjWxYw4YigiZI=;
        b=nq9eWZEoMSVcHdrLtAMGHDQYfKXEaIMK+2QiCrCOYaYr/GWQN+9cpjz94C/JItGsXb
         vOnsQdMyP0c5Iaq1n3li0jkrVaRNoEJmqIHYKuOiVXArhomOvYrlrk4j/EGA+A5FjNv+
         vyGUeX5rTaN6ZtWr2CLiABkufl15cnfH1FROGYIlcdOATSscQGATfawCz2g0xGan2H8t
         GMveD9aBz7/hEayierEPTJ/cIZ2tVCZ/Pv/ghQybZJhXtGY8HJFAHxLnpAu62wzeHehY
         rMSeBv/cQLrZCqE0p0vmyxUrgKpIYQ4wVUGPHjRWS51JufIQQXZPxBhf6/aRuKx3AbUr
         6OaQ==
X-Gm-Message-State: APjAAAWWIcskJ0r4eEMvDMTX7DBORVPJgA6CL6dNvu55gqNquRxeSuvo
        g1QwBGXLTfvSoSZKDpZqoUjz8ciib5E=
X-Google-Smtp-Source: APXvYqzo7u9m2mzQ8NhV5uxXsUmlvdosDxd6nNMGpGnObpCOhMT2HWcSTK+0JYqLJ0/1DnuGEKDeXA==
X-Received: by 2002:a62:e215:: with SMTP id a21mr74546155pfi.30.1555339104341;
        Mon, 15 Apr 2019 07:38:24 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id q128sm79883144pga.60.2019.04.15.07.38.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 07:38:23 -0700 (PDT)
Date:   Mon, 15 Apr 2019 07:38:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Alex Matveev <alxmtvv@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] arm64: sysreg: make mrs_s and msr_s macros work with
 Clang and LTO
Message-ID: <20190415143821.GA46880@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Matveev <alxmtvv@gmail.com>

Clang's integrated assembler does not allow assembly macros defined
in one inline asm block using the .macro directive to be used across
separate asm blocks. LLVM developers consider this a feature and not a
bug, recommending code refactoring:

  https://bugs.llvm.org/show_bug.cgi?id=19749

As binutils doesn't allow macros to be redefined, this change uses
UNDEFINE_MRS_S and UNDEFINE_MSR_S to define corresponding macros
in-place and workaround gcc and clang limitations on redefining macros
across different assembler blocks.

Specifically, the current state after preprocessing looks like this:

asm volatile(".macro mXX_s ... .endm");
void f()
{
	asm volatile("mXX_s a, b");
}

With GCC, it gives macro redefinition error because sysreg.h is included
in multiple source files, and assembler code for all of them is later
combined for LTO (I've seen an intermediate file with hundreds of
identical definitions).

With clang, it gives macro undefined error because clang doesn't allow
sharing macros between inline asm statements.

I also seem to remember catching another sort of undefined error with
GCC due to reordering of macro definition asm statement and generated
asm code for function that uses the macro.

The solution with defining and undefining for each use, while certainly
not elegant, satisfies both GCC and clang, LTO and non-LTO.

Signed-off-by: Alex Matveev <alxmtvv@gmail.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v3: split out patch as stand-alone, added more uses in irqflags,
    updated commit log, based on discussion in
    https://lore.kernel.org/patchwork/patch/851580/
---
 arch/arm64/include/asm/irqflags.h | 12 +++++--
 arch/arm64/include/asm/kvm_hyp.h  |  8 +++--
 arch/arm64/include/asm/sysreg.h   | 55 +++++++++++++++++++++----------
 3 files changed, 53 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
index 43d8366c1e87..06d3987d1546 100644
--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -43,7 +43,9 @@ static inline void arch_local_irq_enable(void)
 	asm volatile(ALTERNATIVE(
 		"msr	daifclr, #2		// arch_local_irq_enable\n"
 		"nop",
+		DEFINE_MSR_S
 		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"
+		UNDEFINE_MSR_S
 		"dsb	sy",
 		ARM64_HAS_IRQ_PRIO_MASKING)
 		:
@@ -55,7 +57,9 @@ static inline void arch_local_irq_disable(void)
 {
 	asm volatile(ALTERNATIVE(
 		"msr	daifset, #2		// arch_local_irq_disable",
-		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ", %0",
+		DEFINE_MSR_S
+		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ", %0\n"
+		UNDEFINE_MSR_S,
 		ARM64_HAS_IRQ_PRIO_MASKING)
 		:
 		: "r" ((unsigned long) GIC_PRIO_IRQOFF)
@@ -85,8 +89,10 @@ static inline unsigned long arch_local_save_flags(void)
 	asm volatile(ALTERNATIVE(
 			"mov	%0, %1\n"
 			"nop\n"
-			"nop",
+			"nop\n",
+			DEFINE_MRS_S
 			"mrs_s	%0, " __stringify(SYS_ICC_PMR_EL1) "\n"
+			UNDEFINE_MRS_S
 			"ands	%1, %1, " __stringify(PSR_I_BIT) "\n"
 			"csel	%0, %0, %2, eq",
 			ARM64_HAS_IRQ_PRIO_MASKING)
@@ -116,7 +122,9 @@ static inline void arch_local_irq_restore(unsigned long flags)
 	asm volatile(ALTERNATIVE(
 			"msr	daif, %0\n"
 			"nop",
+			DEFINE_MSR_S
 			"msr_s	" __stringify(SYS_ICC_PMR_EL1) ", %0\n"
+			UNDEFINE_MSR_S
 			"dsb	sy",
 			ARM64_HAS_IRQ_PRIO_MASKING)
 		: "+r" (flags)
diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 4da765f2cca5..9d0e7f546240 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -30,7 +30,9 @@
 	({								\
 		u64 reg;						\
 		asm volatile(ALTERNATIVE("mrs %0, " __stringify(r##nvh),\
-					 "mrs_s %0, " __stringify(r##vh),\
+					 DEFINE_MRS_S			\
+					 "mrs_s %0, " __stringify(r##vh) "\n"\
+					 UNDEFINE_MRS_S,		\
 					 ARM64_HAS_VIRT_HOST_EXTN)	\
 			     : "=r" (reg));				\
 		reg;							\
@@ -40,7 +42,9 @@
 	do {								\
 		u64 __val = (u64)(v);					\
 		asm volatile(ALTERNATIVE("msr " __stringify(r##nvh) ", %x0",\
-					 "msr_s " __stringify(r##vh) ", %x0",\
+					 DEFINE_MSR_S			\
+					 "msr_s " __stringify(r##vh) ", %x0\n"\
+					 UNDEFINE_MSR_S,		\
 					 ARM64_HAS_VIRT_HOST_EXTN)	\
 					 : : "rZ" (__val));		\
 	} while (0)
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 5b267dec6194..e9f64c237a7c 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -746,20 +746,39 @@
 #include <linux/build_bug.h>
 #include <linux/types.h>
 
-asm(
-"	.irp	num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30\n"
-"	.equ	.L__reg_num_x\\num, \\num\n"
-"	.endr\n"
+#define __DEFINE_MRS_MSR_S_REGNUM				\
+"	.irp	num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30\n" \
+"	.equ	.L__reg_num_x\\num, \\num\n"			\
+"	.endr\n"						\
 "	.equ	.L__reg_num_xzr, 31\n"
-"\n"
-"	.macro	mrs_s, rt, sreg\n"
-	__emit_inst(0xd5200000|(\\sreg)|(.L__reg_num_\\rt))
+
+#define DEFINE_MRS_S						\
+	__DEFINE_MRS_MSR_S_REGNUM				\
+"	.macro	mrs_s, rt, sreg\n"				\
+	__emit_inst(0xd5200000|(\\sreg)|(.L__reg_num_\\rt))	\
 "	.endm\n"
-"\n"
-"	.macro	msr_s, sreg, rt\n"
-	__emit_inst(0xd5000000|(\\sreg)|(.L__reg_num_\\rt))
+
+#define DEFINE_MSR_S						\
+	__DEFINE_MRS_MSR_S_REGNUM				\
+"	.macro	msr_s, sreg, rt\n"				\
+	__emit_inst(0xd5000000|(\\sreg)|(.L__reg_num_\\rt))	\
 "	.endm\n"
-);
+
+#define UNDEFINE_MRS_S						\
+"	.purgem	mrs_s\n"
+
+#define UNDEFINE_MSR_S						\
+"	.purgem	msr_s\n"
+
+#define __mrs_s(r, v)						\
+	DEFINE_MRS_S						\
+"	mrs_s %0, " __stringify(r) "\n"				\
+	UNDEFINE_MRS_S : "=r" (v)
+
+#define __msr_s(r, v)						\
+	DEFINE_MSR_S						\
+"	msr_s " __stringify(r) ", %x0\n"			\
+	UNDEFINE_MSR_S : : "rZ" (v)
 
 /*
  * Unlike read_cpuid, calls to read_sysreg are never expected to be
@@ -785,15 +804,15 @@ asm(
  * For registers without architectural names, or simply unsupported by
  * GAS.
  */
-#define read_sysreg_s(r) ({						\
-	u64 __val;							\
-	asm volatile("mrs_s %0, " __stringify(r) : "=r" (__val));	\
-	__val;								\
+#define read_sysreg_s(r) ({					\
+	u64 __val;						\
+	asm volatile(__mrs_s(r, __val));			\
+	__val;							\
 })
 
-#define write_sysreg_s(v, r) do {					\
-	u64 __val = (u64)(v);						\
-	asm volatile("msr_s " __stringify(r) ", %x0" : : "rZ" (__val));	\
+#define write_sysreg_s(v, r) do {				\
+	u64 __val = (u64)(v);					\
+	asm volatile(__msr_s(r, __val));			\
 } while (0)
 
 /*
-- 
2.17.1


-- 
Kees Cook
