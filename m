Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9164DC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF0F21738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KDIkfh0g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbfDWX0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:26:25 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40691 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfDWX0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:26:25 -0400
Received: by mail-pg1-f195.google.com with SMTP id d31so8367562pgl.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=mE5xJwpvmjSzmi7YweRdAeZ7Il5oNdLHY5UYtn15b38=;
        b=KDIkfh0gKbUovYoyAX2E7jgQ64pOf4DqMWVMY9CMzrkaaEQNHKggkeGIjD71BBkStK
         ei0ff1XxD/MAXPw9+9bc+MOOux02fJorbiHndymB6mkHGxpfrfg+kehrJiS1E9ZIAF8c
         3Hod1lO9L7r7tfZAsn4MLWkbSB4+vtFPAgy5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=mE5xJwpvmjSzmi7YweRdAeZ7Il5oNdLHY5UYtn15b38=;
        b=AkcED60EC3PQStj4QRGCTcsiUk1vovjCeGotcj2SV/xBRhx2HIdRvZDfv8mQ7tUOTH
         NaMoVFesFgFKeXNmifu7UlHh5TPNWT9uMwOayTNB0QDFdzPvxKz8gzLsKPMXAc8upCVq
         au5k7JIxO3mDoau4H/6U2gwWgFLUbW7k05divz8jtFWy0nJdfHkp6UIFOHYOULZoO6OH
         UGeK1uE/p+xB3OYtfkArgBGo4w9/nzsKmb+RtIxJahWiMvH/wU8kWDzhmdmOZBX9iqq9
         k2jnkQlB/lIv0t8kFKAQ4S2dvvS4jcX6bHnW+oHaZZw3Kl5cYIPE/FkJ+m0fjSXni0GT
         5CLQ==
X-Gm-Message-State: APjAAAWPHt6S2fWWM6Ox2BbZJr26UVn/sUDt6wcui6YZp3Q50bMmh5Ia
        7MCrYAUKEVjylhPji23L4j1xdA==
X-Google-Smtp-Source: APXvYqz8itu+LkaRQ1EbhrAofH7b9GQt33NMuK9iMyeDOhL02F4k4mNaaMB/MvY8ICmUCbiu+x4D7A==
X-Received: by 2002:a63:a54:: with SMTP id z20mr3969590pgk.27.1556061984407;
        Tue, 23 Apr 2019 16:26:24 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id 8sm26161856pfs.50.2019.04.23.16.26.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 16:26:23 -0700 (PDT)
Date:   Tue, 23 Apr 2019 16:26:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alex Matveev <alxmtvv@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] arm64: sysreg: Make mrs_s and msr_s macros work with
 Clang and LTO
Message-ID: <20190423232622.GA11776@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Co-developed-by: Alex Matveev <alxmtvv@gmail.com>
Co-developed-by: Yury Norov <ynorov@caviumnetworks.com>
Co-developed-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v4: move to using preprocessor entirely, split constraints for "rZ" case.
v3: added more uses in irqflags, updated commit log, based on
    discussion in https://lore.kernel.org/patchwork/patch/851580/
---
 arch/arm64/include/asm/irqflags.h |  8 ++---
 arch/arm64/include/asm/kvm_hyp.h  |  4 +--
 arch/arm64/include/asm/sysreg.h   | 51 +++++++++++++++++++++++--------
 3 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
index 43d8366c1e87..d359f28765cb 100644
--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -43,7 +43,7 @@ static inline void arch_local_irq_enable(void)
 	asm volatile(ALTERNATIVE(
 		"msr	daifclr, #2		// arch_local_irq_enable\n"
 		"nop",
-		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"
+		__msr_s(SYS_ICC_PMR_EL1)
 		"dsb	sy",
 		ARM64_HAS_IRQ_PRIO_MASKING)
 		:
@@ -55,7 +55,7 @@ static inline void arch_local_irq_disable(void)
 {
 	asm volatile(ALTERNATIVE(
 		"msr	daifset, #2		// arch_local_irq_disable",
-		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ", %0",
+		__msr_s(SYS_ICC_PMR_EL1),
 		ARM64_HAS_IRQ_PRIO_MASKING)
 		:
 		: "r" ((unsigned long) GIC_PRIO_IRQOFF)
@@ -86,7 +86,7 @@ static inline unsigned long arch_local_save_flags(void)
 			"mov	%0, %1\n"
 			"nop\n"
 			"nop",
-			"mrs_s	%0, " __stringify(SYS_ICC_PMR_EL1) "\n"
+			__mrs_s(SYS_ICC_PMR_EL1)
 			"ands	%1, %1, " __stringify(PSR_I_BIT) "\n"
 			"csel	%0, %0, %2, eq",
 			ARM64_HAS_IRQ_PRIO_MASKING)
@@ -116,7 +116,7 @@ static inline void arch_local_irq_restore(unsigned long flags)
 	asm volatile(ALTERNATIVE(
 			"msr	daif, %0\n"
 			"nop",
-			"msr_s	" __stringify(SYS_ICC_PMR_EL1) ", %0\n"
+			__msr_s(SYS_ICC_PMR_EL1)
 			"dsb	sy",
 			ARM64_HAS_IRQ_PRIO_MASKING)
 		: "+r" (flags)
diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 4da765f2cca5..f2e681d657bb 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -30,7 +30,7 @@
 	({								\
 		u64 reg;						\
 		asm volatile(ALTERNATIVE("mrs %0, " __stringify(r##nvh),\
-					 "mrs_s %0, " __stringify(r##vh),\
+					 __mrs_s(r##vh),		\
 					 ARM64_HAS_VIRT_HOST_EXTN)	\
 			     : "=r" (reg));				\
 		reg;							\
@@ -40,7 +40,7 @@
 	do {								\
 		u64 __val = (u64)(v);					\
 		asm volatile(ALTERNATIVE("msr " __stringify(r##nvh) ", %x0",\
-					 "msr_s " __stringify(r##vh) ", %x0",\
+					 __msr_s_x0(r##vh),		\
 					 ARM64_HAS_VIRT_HOST_EXTN)	\
 					 : : "rZ" (__val));		\
 	} while (0)
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 5b267dec6194..21d8f6dd4d79 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -746,20 +746,45 @@
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
+#define __mrs_s(r)						\
+	DEFINE_MRS_S						\
+"	mrs_s %0, " __stringify(r) "\n"				\
+	UNDEFINE_MRS_S
+
+#define __msr_s(r)						\
+	DEFINE_MSR_S						\
+"	msr_s " __stringify(r) ", %0\n"				\
+	UNDEFINE_MSR_S
+
+/* For use with "rZ" constraints. */
+#define __msr_s_x0(r)						\
+	DEFINE_MSR_S						\
+"	msr_s " __stringify(r) ", %x0\n"			\
+	UNDEFINE_MSR_S
 
 /*
  * Unlike read_cpuid, calls to read_sysreg are never expected to be
@@ -787,13 +812,13 @@ asm(
  */
 #define read_sysreg_s(r) ({						\
 	u64 __val;							\
-	asm volatile("mrs_s %0, " __stringify(r) : "=r" (__val));	\
+	asm volatile(__mrs_s(r) : "=r" (__val));			\
 	__val;								\
 })
 
 #define write_sysreg_s(v, r) do {					\
 	u64 __val = (u64)(v);						\
-	asm volatile("msr_s " __stringify(r) ", %x0" : : "rZ" (__val));	\
+	asm volatile(__msr_s_x0(r) : : "rZ" (__val));			\
 } while (0)
 
 /*
-- 
2.17.1


-- 
Kees Cook
