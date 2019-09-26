Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AE6C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 15:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D634021D80
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 15:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfIZPN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 11:13:56 -0400
Received: from foss.arm.com ([217.140.110.172]:52450 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfIZPNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 11:13:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EADC428;
        Thu, 26 Sep 2019 08:13:54 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDE583F534;
        Thu, 26 Sep 2019 08:13:53 -0700 (PDT)
Date:   Thu, 26 Sep 2019 16:13:51 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, ndesaulniers@google.com,
        will@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v2 1/4] arm64: vdso32: Introduce COMPAT_CC_IS_GCC
Message-ID: <20190926151351.GG9689@arrakis.emea.arm.com>
References: <20190926133805.52348-1-vincenzo.frascino@arm.com>
 <20190926133805.52348-2-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926133805.52348-2-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 02:38:02PM +0100, Vincenzo Frascino wrote:
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 37c610963eee..13e2d2e16af7 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -110,7 +110,7 @@ config ARM64
>  	select GENERIC_STRNLEN_USER
>  	select GENERIC_TIME_VSYSCALL
>  	select GENERIC_GETTIMEOFDAY
> -	select GENERIC_COMPAT_VDSO if (!CPU_BIG_ENDIAN && COMPAT)
> +	select GENERIC_COMPAT_VDSO if (!CPU_BIG_ENDIAN && COMPAT && COMPATCC_IS_GCC)
>  	select HANDLE_DOMAIN_IRQ
>  	select HARDIRQS_SW_RESEND
>  	select HAVE_PCI
> @@ -313,6 +313,9 @@ config KASAN_SHADOW_OFFSET
>  	default 0xeffffff900000000 if ARM64_VA_BITS_36 && KASAN_SW_TAGS
>  	default 0xffffffffffffffff
>  
> +config COMPATCC_IS_GCC
> +	def_bool $(success,$(CROSS_COMPILE_COMPAT)gcc --version | head -n 1 | grep -q arm)

Nitpick: COMPAT_CC_IS_ARM_GCC together with 'grep -q "arm-.*-gcc"'

The patch below allows me to use $(COMPATCC) directly here and also set
either CROSS_COMPILE_COMPAT or COMPATCC on the command line:

----------8<----------------------------------
diff --git a/arch/arm64/Kbuild b/arch/arm64/Kbuild
index 75cf8c796d0e..d6465823b281 100644
--- a/arch/arm64/Kbuild
+++ b/arch/arm64/Kbuild
@@ -4,9 +4,3 @@ obj-$(CONFIG_NET)	+= net/
 obj-$(CONFIG_KVM)	+= kvm/
 obj-$(CONFIG_XEN)	+= xen/
 obj-$(CONFIG_CRYPTO)	+= crypto/
-
-# as-instr-compat
-# Usage: cflags-y += $(call as-instr-compat,instr,option1,option2)
-
-as-instr-compat = $(call try-run,\
-	printf "%b\n" "$(1)" | $(COMPATCC) $(KBUILD_AFLAGS) -c -x assembler -o "$$TMP" -,$(2),$(3))
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5d4be0b4f980..811c89fa2b71 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -110,7 +110,7 @@ config ARM64
 	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
-	select GENERIC_COMPAT_VDSO if (!CPU_BIG_ENDIAN && COMPAT && COMPATCC_IS_GCC)
+	select GENERIC_COMPAT_VDSO if (!CPU_BIG_ENDIAN && COMPAT && COMPATCC_IS_ARM_GCC)
 	select HANDLE_DOMAIN_IRQ
 	select HARDIRQS_SW_RESEND
 	select HAVE_PCI
@@ -313,8 +313,8 @@ config KASAN_SHADOW_OFFSET
 	default 0xeffffff900000000 if ARM64_VA_BITS_36 && KASAN_SW_TAGS
 	default 0xffffffffffffffff
 
-config COMPATCC_IS_GCC
-	def_bool $(success,$(CROSS_COMPILE_COMPAT)gcc --version | head -n 1 | grep -q arm)
+config COMPATCC_IS_ARM_GCC
+	def_bool $(success,$(COMPATCC) --version | head -n 1 | grep -q "arm-.*-gcc")
 
 source "arch/arm64/Kconfig.platforms"
 
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 34f53eb11878..6b4eb5c444c5 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -53,6 +53,9 @@ $(warning Detected assembler with broken .inst; disassembly will be unreliable)
   endif
 endif
 
+COMPATCC	?= $(CROSS_COMPILE_COMPAT)gcc
+export		COMPATCC
+
 ifeq ($(CONFIG_GENERIC_COMPAT_VDSO), y)
   export CONFIG_COMPAT_VDSO := y
   compat_vdso := -DCONFIG_COMPAT_VDSO=1
diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index 22f0d31ea528..77aa61340374 100644
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
