Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07164C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7607206B6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369879;
	bh=21ulPBKgGcQy4HCHiKpXdlcPxgN7R/39pzKTN30nt1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fy055t+xiMUul0jhvF+xr1JJho3xapCSMiBpZdJAhpSxALlkEJ4OMh+8yVRCjjPCQ
	 AWLkXA2NqyQA3zGI7hCz6A5kH00l8gCEp7Ldb9mpECOhp+2yFn6ai5vc9t2vkMheKd
	 75RZ2zyc+SO4oKAwItEvGvAc18TR5mpOUWk6YbHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733223AbfDDJOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:14:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733012AbfDDJOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:14:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5881120693;
        Thu,  4 Apr 2019 09:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369261;
        bh=21ulPBKgGcQy4HCHiKpXdlcPxgN7R/39pzKTN30nt1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=14cEmsgmtK4EZmb+dNtXC29uSc//mAvurW/r8Ujh8jftTv3nW39hTAcT7DfKykEiF
         CUV8+uAXOPgCJDUHEqSqUwhOXEqIbyHze+romPcb+8s8N3kXrkJRYxUaBZ2KP1iaVh
         gBECwQSTHeiUWALm+ILWZl4yERoUZrh8WOBNYr38=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nicolas Pitre <nico@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stefan Agner <stefan@agner.ch>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 144/246] ARM: 8833/1: Ensure that NEON code always compiles with Clang
Date:   Thu,  4 Apr 2019 10:47:24 +0200
Message-Id: <20190404084624.209472681@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index ad25fd1872c7..0bff0176db2c 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -39,7 +39,7 @@ $(obj)/csumpartialcopy.o:	$(obj)/csumpartialcopygeneric.S
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
index 4e90d443d1b0..e723eacf7868 100644
--- a/lib/raid6/Makefile
+++ b/lib/raid6/Makefile
@@ -39,7 +39,7 @@ endif
 ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
 NEON_FLAGS := -ffreestanding
 ifeq ($(ARCH),arm)
-NEON_FLAGS += -mfloat-abi=softfp -mfpu=neon
+NEON_FLAGS += -march=armv7-a -mfloat-abi=softfp -mfpu=neon
 endif
 CFLAGS_recov_neon_inner.o += $(NEON_FLAGS)
 ifeq ($(ARCH),arm64)
-- 
2.19.1



