Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED98C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127A420651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711186;
	bh=qgwCA/b/DrYJF97yJbUxEdZVKZVUbZKxo6a2ecnyaYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mso9gEmSH7vc4HPK/8gotow6nTBCZXxyp9XnYowDf172LF3Sohl0rpqxFKlAuIOeT
	 FXVVEaVBXTeWpHQdH4ZsPCoFpKeS6/G90TxeILSxBD2suD/ih3YDMXR/4h/TaaI3rr
	 kgqYNu65pmPOeA4Qnmi6wFEDSh4D61QWM0zBz7hQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403936AbfC0S0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:26:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391639AbfC0S0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:26:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01D0E2082F;
        Wed, 27 Mar 2019 18:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553711163;
        bh=qgwCA/b/DrYJF97yJbUxEdZVKZVUbZKxo6a2ecnyaYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hKNM9Bb91UyczkQv+gRlHlLB1uHZ4Nqr1I81Qso/qCMsYhO/y74XireRtM55+vTF3
         bwlOa/Z+0UNLtguT3UyviveW7x6sdnGOpAkT+poG01WLuehJ3FU7GgAORN2KUEv93w
         TmNrirOen4XeYhwf3HO9ALFAebe2R0uuaQHZLtvM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>, linux-doc@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 22/41] ARM: 8833/1: Ensure that NEON code always compiles with Clang
Date:   Wed, 27 Mar 2019 14:24:59 -0400
Message-Id: <20190327182518.19394-22-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327182518.19394-1-sashal@kernel.org>
References: <20190327182518.19394-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit de9c0d49d85dc563549972edc5589d195cd5e859 ]

While building arm32 allyesconfig, I ran into the following errors:

  arch/arm/lib/xor-neon.c:17:2: error: You should compile this file with
  '-mfloat-abi=softfp -mfpu=neon'

  In file included from lib/raid6/neon1.c:27:
  /home/nathan/cbl/prebuilt/lib/clang/8.0.0/include/arm_neon.h:28:2:
  error: "NEON support not enabled"

Building V=1 showed NEON_FLAGS getting passed along to Clang but
__ARM_NEON__ was not getting defined. Ultimately, it boils down to Clang
only defining __ARM_NEON__ when targeting armv7, rather than armv6k,
which is the '-march' value for allyesconfig.

>From lib/Basic/Targets/ARM.cpp in the Clang source:

  // This only gets set when Neon instructions are actually available, unlike
  // the VFP define, hence the soft float and arch check. This is subtly
  // different from gcc, we follow the intent which was that it should be set
  // when Neon instructions are actually available.
  if ((FPU & NeonFPU) && !SoftFloat && ArchVersion >= 7) {
    Builder.defineMacro("__ARM_NEON", "1");
    Builder.defineMacro("__ARM_NEON__");
    // current AArch32 NEON implementations do not support double-precision
    // floating-point even when it is present in VFP.
    Builder.defineMacro("__ARM_NEON_FP",
                        "0x" + Twine::utohexstr(HW_FP & ~HW_FP_DP));
  }

Ard Biesheuvel recommended explicitly adding '-march=armv7-a' at the
beginning of the NEON_FLAGS definitions so that __ARM_NEON__ always gets
definined by Clang. This doesn't functionally change anything because
that code will only run where NEON is supported, which is implicitly
armv7.

Link: https://github.com/ClangBuiltLinux/linux/issues/287

Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Acked-by: Nicolas Pitre <nico@linaro.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/arm/kernel_mode_neon.txt | 4 ++--
 arch/arm/lib/Makefile                  | 2 +-
 arch/arm/lib/xor-neon.c                | 2 +-
 lib/raid6/Makefile                     | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/arm/kernel_mode_neon.txt b/Documentation/arm/kernel_mode_neon.txt
index 525452726d31..b9e060c5b61e 100644
--- a/Documentation/arm/kernel_mode_neon.txt
+++ b/Documentation/arm/kernel_mode_neon.txt
@@ -6,7 +6,7 @@ TL;DR summary
 * Use only NEON instructions, or VFP instructions that don't rely on support
   code
 * Isolate your NEON code in a separate compilation unit, and compile it with
-  '-mfpu=neon -mfloat-abi=softfp'
+  '-march=armv7-a -mfpu=neon -mfloat-abi=softfp'
 * Put kernel_neon_begin() and kernel_neon_end() calls around the calls into your
   NEON code
 * Don't sleep in your NEON code, and be aware that it will be executed with
@@ -87,7 +87,7 @@ instructions appearing in unexpected places if no special care is taken.
 Therefore, the recommended and only supported way of using NEON/VFP in the
 kernel is by adhering to the following rules:
 * isolate the NEON code in a separate compilation unit and compile it with
-  '-mfpu=neon -mfloat-abi=softfp';
+  '-march=armv7-a -mfpu=neon -mfloat-abi=softfp';
 * issue the calls to kernel_neon_begin(), kernel_neon_end() as well as the calls
   into the unit containing the NEON code from a compilation unit which is *not*
   built with the GCC flag '-mfpu=neon' set.
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 0573faab96ad..830b2ddcc346 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -46,7 +46,7 @@ $(obj)/csumpartialcopy.o:	$(obj)/csumpartialcopygeneric.S
 $(obj)/csumpartialcopyuser.o:	$(obj)/csumpartialcopygeneric.S
 
 ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
-  NEON_FLAGS			:= -mfloat-abi=softfp -mfpu=neon
+  NEON_FLAGS			:= -march=armv7-a -mfloat-abi=softfp -mfpu=neon
   CFLAGS_xor-neon.o		+= $(NEON_FLAGS)
   obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
 endif
diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
index 2c40aeab3eaa..c691b901092f 100644
--- a/arch/arm/lib/xor-neon.c
+++ b/arch/arm/lib/xor-neon.c
@@ -14,7 +14,7 @@
 MODULE_LICENSE("GPL");
 
 #ifndef __ARM_NEON__
-#error You should compile this file with '-mfloat-abi=softfp -mfpu=neon'
+#error You should compile this file with '-march=armv7-a -mfloat-abi=softfp -mfpu=neon'
 #endif
 
 /*
diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
index c7dab0645554..1c3330dc5eab 100644
--- a/lib/raid6/Makefile
+++ b/lib/raid6/Makefile
@@ -23,7 +23,7 @@ endif
 ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
 NEON_FLAGS := -ffreestanding
 ifeq ($(ARCH),arm)
-NEON_FLAGS += -mfloat-abi=softfp -mfpu=neon
+NEON_FLAGS += -march=armv7-a -mfloat-abi=softfp -mfpu=neon
 endif
 ifeq ($(ARCH),arm64)
 CFLAGS_REMOVE_neon1.o += -mgeneral-regs-only
-- 
2.19.1

