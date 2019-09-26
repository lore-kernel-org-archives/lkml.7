Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EE6C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 06:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372A02146E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 06:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392760AbfIZGEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 02:04:55 -0400
Received: from foss.arm.com ([217.140.110.172]:39674 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392643AbfIZGEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 02:04:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBA091596;
        Wed, 25 Sep 2019 23:04:14 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 087603F836;
        Wed, 25 Sep 2019 23:06:48 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     vincenzo.frascino@arm.com, ard.biesheuvel@linaro.org,
        ndesaulniers@google.com, catalin.marinas@arm.com, will@kernel.org,
        tglx@linutronix.de
Subject: [PATCH 2/4] arm64: vdso32: Detect binutils support for dmb ishld
Date:   Thu, 26 Sep 2019 07:03:51 +0100
Message-Id: <20190926060353.54894-3-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190926060353.54894-1-vincenzo.frascino@arm.com>
References: <20190920142738.qlsjwguc6bpnez63@willie-the-truck>
 <20190926060353.54894-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by Will Deacon, older versions of binutils that do not
support certain types of memory barriers can cause build failure of the
vdso32 library.

Add a compilation time mechanism that detects if binutils supports those
instructions and configure the kernel accordingly.

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/include/asm/vdso/compat_barrier.h | 2 +-
 arch/arm64/kernel/vdso32/Makefile            | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

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
index 1fba0776ed40..1a3299d901b1 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -55,6 +55,9 @@ endif
 VDSO_CAFLAGS += -fPIC -fno-builtin -fno-stack-protector
 VDSO_CAFLAGS += -DDISABLE_BRANCH_PROFILING
 
+# Check for binutils support for dmb ishld
+dmbinstr := $(call as-instr,dmb ishld,-DCONFIG_AS_DMB_ISHLD=1)
+
 # Try to compile for ARMv8. If the compiler is too old and doesn't support it,
 # fall back to v7. There is no easy way to check for what architecture the code
 # is being compiled, so define a macro specifying that (see arch/arm/Makefile).
@@ -62,7 +65,7 @@ VDSO_CAFLAGS += $(call cc32-option,-march=armv8-a -D__LINUX_ARM_ARCH__=8,\
                                    -march=armv7-a -D__LINUX_ARM_ARCH__=7)
 
 VDSO_CFLAGS := $(VDSO_CAFLAGS)
-VDSO_CFLAGS += -DENABLE_COMPAT_VDSO=1
+VDSO_CFLAGS += -DENABLE_COMPAT_VDSO=1 $(dmbinstr)
 # KBUILD_CFLAGS from top-level Makefile
 VDSO_CFLAGS += -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
                -fno-strict-aliasing -fno-common \
-- 
2.23.0

