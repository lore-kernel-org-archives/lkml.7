Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E906ECE58A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F41F21783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfJBOmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 10:42:11 -0400
Received: from foss.arm.com ([217.140.110.172]:45744 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfJBOmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 10:42:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E8C41597;
        Wed,  2 Oct 2019 07:42:09 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2615D3F706;
        Wed,  2 Oct 2019 07:42:08 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     vincenzo.frascino@arm.com, ard.biesheuvel@linaro.org,
        ndesaulniers@google.com, catalin.marinas@arm.com, will@kernel.org,
        tglx@linutronix.de, luto@kernel.org
Subject: [PATCH v4 1/6] arm64: vdso32: Fix syncconfig errors.
Date:   Wed,  2 Oct 2019 15:41:51 +0100
Message-Id: <20191002144156.2174-2-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191002144156.2174-1-vincenzo.frascino@arm.com>
References: <20191002144156.2174-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .config file and the generated include/config/auto.conf can
end up out of sync after a set of commands since
CONFIG_CROSS_COMPILE_COMPAT_VDSO is not updated correctly.

The sequence can be reproduced as follows:

$ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig
[...]
$ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- menuconfig
[set CONFIG_CROSS_COMPILE_COMPAT_VDSO="arm-linux-gnueabihf-"]
$ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-

Which results in:

arch/arm64/Makefile:62: CROSS_COMPILE_COMPAT not defined or empty,
the compat vDSO will not be built

even though the compat vDSO has been built:

$ file arch/arm64/kernel/vdso32/vdso.so
arch/arm64/kernel/vdso32/vdso.so: ELF 32-bit LSB pie executable, ARM,
EABI5 version 1 (SYSV), dynamically linked,
BuildID[sha1]=c67f6c786f2d2d6f86c71f708595594aa25247f6, stripped

A similar case that involves changing the configuration parameter multiple
times can be reconducted to the same family of problems.

The reason behind it comes from the fact that the master Makefile includes
that architecture Makefile twice, once before the syncconfig and one after.
Since the synchronization of the files happens only upon syncconfig, the
architecture Makefile included before this event does not see the change in
configuration.

As a consequence of this it is not possible to handle the cross compiler
definitions inside the architecture Makefile.

Address the problem refactoring the arm64 main Makefile and removing the
misleading warnings.

As a consequence of this it is not possible anymore to set the compat
cross compiler from menuconfig but it requires to be exported via
command line.

E.g.:

$ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
CROSS_COMPILE_COMPAT=arm-linux-gnueabihf-

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Will Deacon <will@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/Makefile               | 18 +++++-------------
 arch/arm64/kernel/vdso32/Makefile |  2 --
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 84a3d502c5a5..dfa6a5cb99e4 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -53,20 +53,12 @@ $(warning Detected assembler with broken .inst; disassembly will be unreliable)
   endif
 endif
 
+COMPATCC ?= $(CROSS_COMPILE_COMPAT)gcc
+export COMPATCC
+
 ifeq ($(CONFIG_GENERIC_COMPAT_VDSO), y)
-  CROSS_COMPILE_COMPAT ?= $(CONFIG_CROSS_COMPILE_COMPAT_VDSO:"%"=%)
-
-  ifeq ($(CONFIG_CC_IS_CLANG), y)
-    $(warning CROSS_COMPILE_COMPAT is clang, the compat vDSO will not be built)
-  else ifeq ($(strip $(CROSS_COMPILE_COMPAT)),)
-    $(warning CROSS_COMPILE_COMPAT not defined or empty, the compat vDSO will not be built)
-  else ifeq ($(shell which $(CROSS_COMPILE_COMPAT)gcc 2> /dev/null),)
-    $(error $(CROSS_COMPILE_COMPAT)gcc not found, check CROSS_COMPILE_COMPAT)
-  else
-    export CROSS_COMPILE_COMPAT
-    export CONFIG_COMPAT_VDSO := y
-    compat_vdso := -DCONFIG_COMPAT_VDSO=1
-  endif
+  export CONFIG_COMPAT_VDSO := y
+  compat_vdso := -DCONFIG_COMPAT_VDSO=1
 endif
 
 KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr) $(brokengasinst)	\
diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index 1fba0776ed40..19e0d3115ffe 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -8,8 +8,6 @@
 ARCH_REL_TYPE_ABS := R_ARM_JUMP_SLOT|R_ARM_GLOB_DAT|R_ARM_ABS32
 include $(srctree)/lib/vdso/Makefile
 
-COMPATCC := $(CROSS_COMPILE_COMPAT)gcc
-
 # Same as cc-*option, but using COMPATCC instead of CC
 cc32-option = $(call try-run,\
         $(COMPATCC) $(1) -c -x c /dev/null -o "$$TMP",$(1),$(2))
-- 
2.23.0

