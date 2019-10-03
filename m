Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8503FC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 655AF2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388374AbfJCRsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:48:53 -0400
Received: from foss.arm.com ([217.140.110.172]:52784 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387744AbfJCRsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 13:48:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99B421597;
        Thu,  3 Oct 2019 10:48:51 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 612ED3F739;
        Thu,  3 Oct 2019 10:48:50 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     vincenzo.frascino@arm.com, ard.biesheuvel@linaro.org,
        ndesaulniers@google.com, catalin.marinas@arm.com, will@kernel.org,
        tglx@linutronix.de, luto@kernel.org
Subject: [PATCH v5 2/6] arm64: vdso32: Detect binutils support for dmb ishld
Date:   Thu,  3 Oct 2019 18:48:34 +0100
Message-Id: <20191003174838.8872-3-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003174838.8872-1-vincenzo.frascino@arm.com>
References: <20191003174838.8872-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Older versions of binutils that do not support certain types of memory
barriers can cause build failure of the vdso32 library.

Add a compilation time mechanism that detects if binutils supports those
instructions and configure the kernel accordingly.

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Will Deacon <will@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/vdso/compat_barrier.h | 2 +-
 arch/arm64/kernel/vdso32/Makefile            | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/vdso/compat_barrier.h b/arch/arm64/include/asm/vdso/compat_barrier.h
index fb60a88b5ed4..3fd8fd6d8fc2 100644
--- a/arch/arm64/include/asm/vdso/compat_barrier.h
+++ b/arch/arm64/include/asm/vdso/compat_barrier.h
@@ -20,7 +20,7 @@
 
 #define dmb(option) __asm__ __volatile__ ("dmb " #option : : : "memory")
 
-#if __LINUX_ARM_ARCH__ >= 8
+#if __LINUX_ARM_ARCH__ >= 8 && defined(CONFIG_AS_DMB_ISHLD)
 #define aarch32_smp_mb()	dmb(ish)
 #define aarch32_smp_rmb()	dmb(ishld)
 #define aarch32_smp_wmb()	dmb(ishst)
diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index 19e0d3115ffe..77aa61340374 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -15,6 +15,8 @@ cc32-disable-warning = $(call try-run,\
 	$(COMPATCC) -W$(strip $(1)) -c -x c /dev/null -o "$$TMP",-Wno-$(strip $(1)))
 cc32-ldoption = $(call try-run,\
         $(COMPATCC) $(1) -nostdlib -x c /dev/null -o "$$TMP",$(1),$(2))
+cc32-as-instr = $(call try-run,\
+	printf "%b\n" "$(1)" | $(COMPATCC) $(VDSO_AFLAGS) -c -x assembler -o "$$TMP" -,$(2),$(3))
 
 # We cannot use the global flags to compile the vDSO files, the main reason
 # being that the 32-bit compiler may be older than the main (64-bit) compiler
@@ -53,6 +55,7 @@ endif
 VDSO_CAFLAGS += -fPIC -fno-builtin -fno-stack-protector
 VDSO_CAFLAGS += -DDISABLE_BRANCH_PROFILING
 
+
 # Try to compile for ARMv8. If the compiler is too old and doesn't support it,
 # fall back to v7. There is no easy way to check for what architecture the code
 # is being compiled, so define a macro specifying that (see arch/arm/Makefile).
@@ -89,6 +92,12 @@ VDSO_CFLAGS += -Wno-int-to-pointer-cast
 VDSO_AFLAGS := $(VDSO_CAFLAGS)
 VDSO_AFLAGS += -D__ASSEMBLY__
 
+# Check for binutils support for dmb ishld
+dmbinstr := $(call cc32-as-instr,dmb ishld,-DCONFIG_AS_DMB_ISHLD=1)
+
+VDSO_CFLAGS += $(dmbinstr)
+VDSO_AFLAGS += $(dmbinstr)
+
 VDSO_LDFLAGS := $(VDSO_CPPFLAGS)
 # From arm vDSO Makefile
 VDSO_LDFLAGS += -Wl,-Bsymbolic -Wl,--no-undefined -Wl,-soname=linux-vdso.so.1
-- 
2.23.0

