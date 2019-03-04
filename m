Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0F3C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA44206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiLoAMGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfCDRTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 12:19:25 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:35085 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfCDRTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 12:19:24 -0500
Received: by mail-wr1-f54.google.com with SMTP id t18so6443341wrx.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 09:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=1IQT3p++QBOSLZVupcNH3SUQPOAgIHRCSHL+aNxoTXw=;
        b=ZiLoAMGIjB7mHR/RFYqjg6a0SuhdW52HqiP6enDBj/UED3vnvSXzj1gJYdhcnAqUMd
         xe9eYxYk7VrUyIQRkCrhfk1W67D6JDWDvO8sF7oacttGqSLbcdoBu0gju+nBBO5byXaT
         cKh3rBPzr+DdeH+r7UlDjF8JWvEhnQlv6eA3eKl6dYXelRAXBY37Lo436H18h0wkuZiW
         f6zcBu1lv0Vfk8ZXl1nof3Z/XMHf7AgvWTgzSZqUpSHPfkYQd/XgLDlfv/YaJLu71hgZ
         293jW2oEgHzsTuFqTZeXnGx2XWKHa3h0YElTNaoOfqeat2L009fJ/l5v4mrFQ80vizZH
         fQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1IQT3p++QBOSLZVupcNH3SUQPOAgIHRCSHL+aNxoTXw=;
        b=GqXDs7jYhnqPomZ1MRmesMBE95fJReu5gZcaP4rlMhFVhO79/ZXmE1B4M77jItj7i1
         WquUbGY17b0mHjh/eCP3Ot/syARj8fAvWEX0zWKCJp9VjyWAyILcUjsx+/7Na5rwsC1c
         auHsNS3+Vk0SzFgAeR9NoFhV4aKf12nu83F2GfN4Uz5rid2lqim3yVI50CbIqsYm1ygD
         g9vjBVeU++fjNmIEuR7nSoAQFkZ7XB5BV6Q9IThej7CcN3/8zUedTg/NMXImiKbnwi4W
         X/m7FM3VhJd3JUzoy8Klm11agVqnGYPXwT//7qpcShliQZGYU6tUOUE5MZq3VJZbMqEI
         tpkA==
X-Gm-Message-State: APjAAAVKTmda10A5YXVXra4dTt0+xvKMVUCPos7usnnjQ+aY2igFDOPR
        /0qEGSJE/aPqhbN+FW2qgd8jo5Q=
X-Google-Smtp-Source: APXvYqwoSX7JNB9P0Fcyn/5rHwQU7CxvTpV1V5p0Wgm2nG4WE5zz2KuF/Hs7gqi2vzPUJ3SQN5pCtQ==
X-Received: by 2002:adf:e5cc:: with SMTP id a12mr14388127wrn.130.1551719960030;
        Mon, 04 Mar 2019 09:19:20 -0800 (PST)
Received: from avx2 ([46.53.246.15])
        by smtp.gmail.com with ESMTPSA id t2sm6523704wmi.37.2019.03.04.09.19.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 09:19:19 -0800 (PST)
Date:   Mon, 4 Mar 2019 20:19:16 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org
Subject: Linux 5.0-ad1: -march=native support
Message-ID: <20190304171916.GA1694@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-ad1 patchset adds support for compiling kernel with "-march=native"
compiler option optimizing kernel for the specific CPU. "-march=native"
has been available in userspace for a long time and is trivial to enable
in Gentoo specifically.

"-march=native" can be used for folks like me who compile kernels on
their home machines and never share binaries.

See the link for more information:

    https://www.shlomifish.org/humour/by-others/funroll-loops/Gentoo-is-Rice.html

Requirements:

	Intel CPU
	x86_64 arch

Usage:

	# apply -ad1 patchset

	# copy regular kernel .config

	# enable "-march=native" support in
	#	"Processor type and features"
	#	"Processor family"

	# ensure CONFIG_MARCH_NATIVE is enabled
	$ grep -e CONFIG_MARCH_NATIVE .config

	# workaround kbuild race condition if "-j" is used
	$ make syncconfig

	# build the kernel
	$ make ...

	# install kernel, reboot into new kernel

	# verify detected CONFIG_MARCH_NATIVE_* options
	$ gzip -d </proc/config.gz | grep -e CONFIG_MARCH_NATIVE

Ping me over email of something breaks or horribly slow.

Original announcement:
https://marc.info/?l=linux-kernel&m=151268659328024&w=4

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 Makefile                                      |   16 +++
 arch/x86/Kconfig.cpu                          |    8 +
 arch/x86/Makefile                             |   27 +++++-
 arch/x86/boot/compressed/head_64.S            |    4 
 arch/x86/crypto/des3_ede-asm_64.S             |   28 ++++++
 arch/x86/crypto/sha1_ssse3_asm.S              |    7 +
 arch/x86/include/asm/arch_hweight.h           |   28 ++++++
 arch/x86/include/asm/page_64.h                |   26 ++++++
 arch/x86/include/asm/segment.h                |    1 
 arch/x86/kernel/relocate_kernel_64.S          |   15 +++
 arch/x86/kernel/verify_cpu.S                  |   27 ++++++
 arch/x86/lib/Makefile                         |   12 ++
 arch/x86/lib/memcpy_64.S                      |   13 +++
 arch/x86/lib/memset_64.S                      |   15 +++
 arch/x86/lib/usercopy_64.c                    |   16 +++
 arch/x86/platform/pvh/head.S                  |    4 
 drivers/net/wireless/mediatek/mt76/mac80211.c |    2 
 include/linux/bitops.h                        |    2 
 lib/Makefile                                  |    2 
 scripts/kconfig/.gitignore                    |    1 
 scripts/kconfig/Makefile                      |    7 +
 scripts/kconfig/cpuid.c                       |  108 ++++++++++++++++++++++++++
 scripts/march-native.sh                       |   74 +++++++++++++++++
 23 files changed, 429 insertions(+), 14 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -2,7 +2,7 @@
 VERSION = 5
 PATCHLEVEL = 0
 SUBLEVEL = 0
-EXTRAVERSION =
+EXTRAVERSION = -ad1
 NAME = Shy Crocodile
 
 # *DOCUMENTATION*
@@ -370,10 +370,10 @@ HOST_LFS_LIBS := $(shell getconf LFS_LIBS 2>/dev/null)
 
 HOSTCC       = gcc
 HOSTCXX      = g++
-KBUILD_HOSTCFLAGS   := -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 \
+KBUILD_HOSTCFLAGS   := -Wall -Wmissing-prototypes -Wstrict-prototypes -march=native -O2 \
 		-fomit-frame-pointer -std=gnu89 $(HOST_LFS_CFLAGS) \
 		$(HOSTCFLAGS)
-KBUILD_HOSTCXXFLAGS := -O2 $(HOST_LFS_CFLAGS) $(HOSTCXXFLAGS)
+KBUILD_HOSTCXXFLAGS := -march=native -O2 $(HOST_LFS_CFLAGS) $(HOSTCXXFLAGS)
 KBUILD_HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS) $(HOSTLDFLAGS)
 KBUILD_HOSTLDLIBS   := $(HOST_LFS_LIBS) $(HOSTLDLIBS)
 
@@ -594,6 +594,16 @@ ifeq ($(dot-config),1)
 include include/config/auto.conf
 endif
 
+ifdef CONFIG_MARCH_NATIVE
+KBUILD_CFLAGS += -march=native
+endif
+ifdef CONFIG_MARCH_NATIVE_REP_MOVSB
+KBUILD_CFLAGS += -mmemcpy-strategy=rep_byte:-1:align,rep_byte:-1:noalign
+endif
+ifdef CONFIG_MARCH_NATIVE_REP_STOSB
+KBUILD_CFLAGS += -mmemset-strategy=rep_byte:-1:align,rep_byte:-1:noalign
+endif
+
 # The all: target is the default when no target is given on the
 # command line.
 # This allow a user to issue only 'make' to build a kernel including modules
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -287,6 +287,12 @@ config GENERIC_CPU
 	  Generic x86-64 CPU.
 	  Run equally well on all x86-64 CPUs.
 
+config MARCH_NATIVE
+	bool "-march=native"
+	depends on X86_64
+	---help---
+	  -march=native support.
+
 endchoice
 
 config X86_GENERIC
@@ -307,6 +313,7 @@ config X86_INTERNODE_CACHE_SHIFT
 	int
 	default "12" if X86_VSMP
 	default X86_L1_CACHE_SHIFT
+	depends on !MARCH_NATIVE
 
 config X86_L1_CACHE_SHIFT
 	int
@@ -314,6 +321,7 @@ config X86_L1_CACHE_SHIFT
 	default "6" if MK7 || MK8 || MPENTIUMM || MCORE2 || MATOM || MVIAC7 || X86_GENERIC || GENERIC_CPU
 	default "4" if MELAN || M486 || MGEODEGX1
 	default "5" if MWINCHIP3D || MWINCHIPC6 || MCRUSOE || MEFFICEON || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2 || MGEODE_LX
+	depends on !MARCH_NATIVE
 
 config X86_F00F_BUG
 	def_bool y
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -12,6 +12,28 @@ else
         KBUILD_DEFCONFIG := $(ARCH)_defconfig
 endif
 
+CFLAGS_NO_FP :=
+CFLAGS_NO_FP += $(call cc-option,-mno-mmx,)
+CFLAGS_NO_FP += $(call cc-option,-mno-sse,)
+CFLAGS_NO_FP += $(call cc-option,-mno-sse2,)
+CFLAGS_NO_FP += $(call cc-option,-mno-sse3,)
+CFLAGS_NO_FP += $(call cc-option,-mno-ssse3,)
+CFLAGS_NO_FP += $(call cc-option,-mno-sse4,)
+CFLAGS_NO_FP += $(call cc-option,-mno-sse4a,)
+CFLAGS_NO_FP += $(call cc-option,-mno-sse4.1,)
+CFLAGS_NO_FP += $(call cc-option,-mno-sse4.2,)
+CFLAGS_NO_FP += $(call cc-option,-mno-avx,)
+CFLAGS_NO_FP += $(call cc-option,-mno-avx2,)
+CFLAGS_NO_FP += $(call cc-option,-mno-avx512f,)
+CFLAGS_NO_FP += $(call cc-option,-mno-avx512pf,)
+CFLAGS_NO_FP += $(call cc-option,-mno-avx512er,)
+CFLAGS_NO_FP += $(call cc-option,-mno-avx512cd,)
+CFLAGS_NO_FP += $(call cc-option,-mno-avx512vl,)
+CFLAGS_NO_FP += $(call cc-option,-mno-avx512bw,)
+CFLAGS_NO_FP += $(call cc-option,-mno-avx512dq,)
+CFLAGS_NO_FP += $(call cc-option,-mno-avx512ifma,)
+CFLAGS_NO_FP += $(call cc-option,-mno-avx512vbmi,)
+
 # For gcc stack alignment is specified with -mpreferred-stack-boundary,
 # clang has the option -mstack-alignment for that purpose.
 ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
@@ -34,7 +56,7 @@ M16_CFLAGS	 := $(call cc-option, -m16, $(CODE16GCC_CFLAGS))
 REALMODE_CFLAGS	:= $(M16_CFLAGS) -g -Os -DDISABLE_BRANCH_PROFILING \
 		   -Wall -Wstrict-prototypes -march=i386 -mregparm=3 \
 		   -fno-strict-aliasing -fomit-frame-pointer -fno-pic \
-		   -mno-mmx -mno-sse
+		   $(CFLAGS_NO_FP)
 
 REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -ffreestanding)
 REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -fno-stack-protector)
@@ -57,8 +79,7 @@ endif
 #
 #    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=53383
 #
-KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow
-KBUILD_CFLAGS += $(call cc-option,-mno-avx,)
+KBUILD_CFLAGS += $(CFLAGS_NO_FP)
 
 ifeq ($(CONFIG_X86_32),y)
         BITS := 32
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -517,8 +517,12 @@ relocated:
 	leaq    _bss(%rip), %rdi
 	leaq    _ebss(%rip), %rcx
 	subq	%rdi, %rcx
+#ifdef CONFIG_MARCH_NATIVE_REP_STOSB
+	rep stosb
+#else
 	shrq	$3, %rcx
 	rep	stosq
+#endif
 
 /*
  * Do the extraction, and jump to the new kernel..
--- a/arch/x86/crypto/des3_ede-asm_64.S
+++ b/arch/x86/crypto/des3_ede-asm_64.S
@@ -159,6 +159,15 @@
 
 #define dummy2(a, b) /*_*/
 
+#ifdef CONFIG_MARCH_NATIVE_MOVBE
+#define read_block(io, left, right) \
+	movbe	 (io), left##d; \
+	movbe	4(io), right##d;
+
+#define write_block(io, left, right) \
+	movbe	left##d,   (io); \
+	movbe	right##d, 4(io);
+#else
 #define read_block(io, left, right) \
 	movl    (io), left##d; \
 	movl   4(io), right##d; \
@@ -170,6 +179,7 @@
 	bswapl right##d; \
 	movl   left##d,   (io); \
 	movl   right##d, 4(io);
+#endif
 
 ENTRY(des3_ede_x86_64_crypt_blk)
 	/* input:
@@ -443,6 +453,14 @@ ENTRY(des3_ede_x86_64_crypt_blk_3way)
 	pushq %rsi /* dst */
 
 	/* load input */
+#ifdef CONFIG_MARCH_NATIVE_MOVBE
+	movbe 0 * 4(%rdx), RL0d;
+	movbe 1 * 4(%rdx), RR0d;
+	movbe 2 * 4(%rdx), RL1d;
+	movbe 3 * 4(%rdx), RR1d;
+	movbe 4 * 4(%rdx), RL2d;
+	movbe 5 * 4(%rdx), RR2d;
+#else
 	movl 0 * 4(%rdx), RL0d;
 	movl 1 * 4(%rdx), RR0d;
 	movl 2 * 4(%rdx), RL1d;
@@ -456,6 +474,7 @@ ENTRY(des3_ede_x86_64_crypt_blk_3way)
 	bswapl RR1d;
 	bswapl RL2d;
 	bswapl RR2d;
+#endif
 
 	initial_permutation3(RL, RR);
 
@@ -516,6 +535,14 @@ ENTRY(des3_ede_x86_64_crypt_blk_3way)
 
 	final_permutation3(RR, RL);
 
+#ifdef CONFIG_MARCH_NATIVE_MOVBE
+	movbe RR0d, 0 * 4(%rsi);
+	movbe RL0d, 1 * 4(%rsi);
+	movbe RR1d, 2 * 4(%rsi);
+	movbe RL1d, 3 * 4(%rsi);
+	movbe RR2d, 4 * 4(%rsi);
+	movbe RL2d, 5 * 4(%rsi);
+#else
 	bswapl RR0d;
 	bswapl RL0d;
 	bswapl RR1d;
@@ -530,6 +557,7 @@ ENTRY(des3_ede_x86_64_crypt_blk_3way)
 	movl RL1d, 3 * 4(%rsi);
 	movl RR2d, 4 * 4(%rsi);
 	movl RL2d, 5 * 4(%rsi);
+#endif
 
 	popq %r15;
 	popq %r14;
--- a/arch/x86/crypto/sha1_ssse3_asm.S
+++ b/arch/x86/crypto/sha1_ssse3_asm.S
@@ -94,10 +94,15 @@
 	SHA1_PIPELINED_MAIN_BODY
 
 	# cleanup workspace
-	mov	$8, %ecx
 	mov	%rsp, %rdi
 	xor	%eax, %eax
+#ifdef CONFIG_MARCH_NATIVE_REP_STOSB
+	mov	$64, %ecx
+	rep stosb
+#else
+	mov	$8, %ecx
 	rep stosq
+#endif
 
 	mov	%rbp, %rsp		# deallocate workspace
 	pop	%rbp
--- a/arch/x86/include/asm/arch_hweight.h
+++ b/arch/x86/include/asm/arch_hweight.h
@@ -2,6 +2,30 @@
 #ifndef _ASM_X86_HWEIGHT_H
 #define _ASM_X86_HWEIGHT_H
 
+#define __HAVE_ARCH_SW_HWEIGHT
+
+#ifdef CONFIG_MARCH_NATIVE_POPCNT
+static inline unsigned int __arch_hweight64(uint64_t x)
+{
+	return __builtin_popcountll(x);
+}
+
+static inline unsigned int __arch_hweight32(uint32_t x)
+{
+	return __builtin_popcount(x);
+}
+
+static inline unsigned int __arch_hweight16(uint16_t x)
+{
+	return __builtin_popcount(x);
+}
+
+static inline unsigned int __arch_hweight8(uint8_t x)
+{
+	return __builtin_popcount(x);
+}
+#else
+
 #include <asm/cpufeatures.h>
 
 #ifdef CONFIG_64BIT
@@ -12,8 +36,6 @@
 #define REG_OUT "a"
 #endif
 
-#define __HAVE_ARCH_SW_HWEIGHT
-
 static __always_inline unsigned int __arch_hweight32(unsigned int w)
 {
 	unsigned int res;
@@ -55,3 +77,5 @@ static __always_inline unsigned long __arch_hweight64(__u64 w)
 #endif /* CONFIG_X86_32 */
 
 #endif
+
+#endif
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -40,6 +40,18 @@ extern unsigned long __phys_addr_symbol(unsigned long);
 #define pfn_valid(pfn)          ((pfn) < max_pfn)
 #endif
 
+#ifdef CONFIG_MARCH_NATIVE_REP_STOSB
+static __always_inline void clear_page(void *page)
+{
+	uint32_t len = PAGE_SIZE;
+	asm volatile (
+		"rep stosb"
+		: "+D" (page), "+c" (len)
+		: "a" (0)
+		: "memory"
+	);
+}
+#else
 void clear_page_orig(void *page);
 void clear_page_rep(void *page);
 void clear_page_erms(void *page);
@@ -53,8 +65,22 @@ static inline void clear_page(void *page)
 			   "0" (page)
 			   : "cc", "memory", "rax", "rcx");
 }
+#endif
 
+#ifdef CONFIG_MARCH_NATIVE_REP_MOVSB
+static __always_inline void copy_page(void *to, void *from)
+{
+	uint32_t len = PAGE_SIZE;
+	asm volatile (
+		"rep movsb"
+		: "+D" (to), "+S" (from), "+c" (len)
+		:
+		: "memory"
+	);
+}
+#else
 void copy_page(void *to, void *from);
+#endif
 
 #endif	/* !__ASSEMBLY__ */
 
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -4,6 +4,7 @@
 
 #include <linux/const.h>
 #include <asm/alternative.h>
+#include <asm/cpufeatures.h>
 
 /*
  * Constructor for a conventional segment GDT (or LDT) entry.
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -268,18 +268,33 @@ swap_pages:
 	movq	%rsi, %rax
 
 	movq	%r10, %rdi
+#ifdef CONFIG_MARCH_NATIVE_REP_MOVSB
+	mov	$4096, %ecx
+	rep movsb
+#else
 	movl	$512, %ecx
 	rep ; movsq
+#endif
 
 	movq	%rax, %rdi
 	movq	%rdx, %rsi
+#ifdef CONFIG_MARCH_NATIVE_REP_MOVSB
+	mov	$4096, %ecx
+	rep movsb
+#else
 	movl	$512, %ecx
 	rep ; movsq
+#endif
 
 	movq	%rdx, %rdi
 	movq	%r10, %rsi
+#ifdef CONFIG_MARCH_NATIVE_REP_MOVSB
+	mov	$4096, %ecx
+	rep movsb
+#else
 	movl	$512, %ecx
 	rep ; movsq
+#endif
 
 	lea	PAGE_SIZE(%rax), %rsi
 	jmp	0b
--- a/arch/x86/kernel/verify_cpu.S
+++ b/arch/x86/kernel/verify_cpu.S
@@ -136,6 +136,33 @@ ENTRY(verify_cpu)
 	movl $1,%eax
 	ret
 .Lverify_cpu_sse_ok:
+
+#ifdef CONFIG_MARCH_NATIVE_POPCNT
+	mov	$1, %eax
+	cpuid
+	bt	$23, %ecx
+	jnc	.Lverify_cpu_no_longmode
+#endif
+
+#ifdef CONFIG_MARCH_NATIVE_MOVBE
+	mov	$1, %eax
+	cpuid
+	bt	$22, %ecx
+	jnc	.Lverify_cpu_no_longmode
+#endif
+
+#if defined(CONFIG_MARCH_NATIVE_REP_MOVSB) || defined(CONFIG_MARCH_NATIVE_REP_STOSB)
+	xor	%eax, %eax
+	cpuid
+	cmp	$7, %eax
+	jb	.Lverify_cpu_no_longmode
+	mov	$7, %eax
+	xor	%ecx, %ecx
+	cpuid
+	bt	$9, %ebx
+	jnc	.Lverify_cpu_no_longmode
+#endif
+
 	popf				# Restore caller passed flags
 	xorl %eax, %eax
 	ret
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -29,7 +29,10 @@ lib-$(CONFIG_RANDOMIZE_BASE) += kaslr.o
 lib-$(CONFIG_FUNCTION_ERROR_INJECTION)	+= error-inject.o
 lib-$(CONFIG_RETPOLINE) += retpoline.o
 
-obj-y += msr.o msr-reg.o msr-reg-export.o hweight.o
+obj-y += msr.o msr-reg.o msr-reg-export.o
+ifneq ($(CONFIG_MARCH_NATIVE_POPCNT),y)
+	obj-y += hweight.o
+endif
 obj-y += iomem.o
 
 ifeq ($(CONFIG_X86_32),y)
@@ -45,7 +48,12 @@ endif
 else
         obj-y += iomap_copy_64.o
         lib-y += csum-partial_64.o csum-copy_64.o csum-wrappers_64.o
-        lib-y += clear_page_64.o copy_page_64.o
+ifneq ($(CONFIG_MARCH_NATIVE_REP_STOSB),y)
+        lib-y += clear_page_64.o
+endif
+ifneq ($(CONFIG_MARCH_NATIVE_REP_MOVSB),y)
+	lib-y += copy_page_64.o
+endif
         lib-y += memmove_64.o memset_64.o
         lib-y += copy_user_64.o
 	lib-y += cmpxchg16b_emu.o
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -16,6 +16,18 @@
 
 .weak memcpy
 
+#ifdef CONFIG_MARCH_NATIVE_REP_MOVSB
+ENTRY(__memcpy)
+ENTRY(memcpy)
+	mov	%rdi, %rax
+	mov	%rdx, %rcx
+	rep movsb
+	ret
+ENDPROC(memcpy)
+ENDPROC(__memcpy)
+EXPORT_SYMBOL(memcpy)
+EXPORT_SYMBOL(__memcpy)
+#else
 /*
  * memcpy - Copy a memory block.
  *
@@ -182,6 +194,7 @@ ENTRY(memcpy_orig)
 .Lend:
 	retq
 ENDPROC(memcpy_orig)
+#endif
 
 #ifndef CONFIG_UML
 
--- a/arch/x86/lib/memset_64.S
+++ b/arch/x86/lib/memset_64.S
@@ -8,6 +8,20 @@
 
 .weak memset
 
+#ifdef CONFIG_MARCH_NATIVE_REP_STOSB
+ENTRY(memset)
+ENTRY(__memset)
+	mov	%esi, %eax
+	mov	%rdi, %rsi
+	mov	%rdx, %rcx
+	rep stosb
+	mov	%rsi, %rax
+	ret
+ENDPROC(memset)
+ENDPROC(__memset)
+EXPORT_SYMBOL(memset)
+EXPORT_SYMBOL(__memset)
+#else
 /*
  * ISO C memset - set a memory block to a byte value. This function uses fast
  * string to get better performance than the original function. The code is
@@ -140,3 +154,4 @@ ENTRY(memset_orig)
 	jmp .Lafter_bad_alignment
 .Lfinal:
 ENDPROC(memset_orig)
+#endif
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -15,11 +15,23 @@
 
 unsigned long __clear_user(void __user *addr, unsigned long size)
 {
-	long __d0;
 	might_fault();
 	/* no memory constraint because it doesn't change any memory gcc knows
 	   about */
 	stac();
+
+#ifdef CONFIG_MARCH_NATIVE_REP_STOSB
+	asm volatile (
+		"0:     rep stosb\n"
+		"1:\n"
+		_ASM_EXTABLE(0b,1b)
+		: "+D" (addr), "+c" (size)
+		: "a" (0)
+		: "memory"
+	);
+#else
+	{
+	long __d0;
 	asm volatile(
 		"	testq  %[size8],%[size8]\n"
 		"	jz     4f\n"
@@ -41,6 +53,8 @@ unsigned long __clear_user(void __user *addr, unsigned long size)
 		_ASM_EXTABLE_UA(1b, 2b)
 		: [size8] "=&c"(size), [dst] "=&D" (__d0)
 		: [size1] "r"(size & 7), "[size8]" (size / 8), "[dst]"(addr));
+	}
+#endif
 	clac();
 	return size;
 }
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -64,9 +64,13 @@ ENTRY(pvh_start_xen)
 	mov $_pa(pvh_start_info), %edi
 	mov %ebx, %esi
 	mov _pa(pvh_start_info_sz), %ecx
+#ifdef CONFIG_MARCH_NATIVE_REP_MOVSB
+	rep movsb
+#else
 	shr $2,%ecx
 	rep
 	movsl
+#endif
 
 	mov $_pa(early_stack_end), %esp
 
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -124,7 +124,7 @@ static void mt76_init_stream_cap(struct mt76_dev *dev,
 				 bool vht)
 {
 	struct ieee80211_sta_ht_cap *ht_cap = &sband->ht_cap;
-	int i, nstream = __sw_hweight8(dev->antenna_mask);
+	int i, nstream = hweight8(dev->antenna_mask);
 	struct ieee80211_sta_vht_cap *vht_cap;
 	u16 mcs_map = 0;
 
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -7,10 +7,12 @@
 #define BITS_PER_TYPE(type) (sizeof(type) * BITS_PER_BYTE)
 #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
 
+#ifndef CONFIG_MARCH_NATIVE_POPCNT
 extern unsigned int __sw_hweight8(unsigned int w);
 extern unsigned int __sw_hweight16(unsigned int w);
 extern unsigned int __sw_hweight32(unsigned int w);
 extern unsigned long __sw_hweight64(__u64 w);
+#endif
 
 /*
  * Include this here because some architectures need generic_ffs/fls in
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -93,7 +93,9 @@ obj-$(CONFIG_DEBUG_LOCKING_API_SELFTESTS) += locking-selftest.o
 
 obj-y += logic_pio.o
 
+ifneq ($(CONFIG_MARCH_NATIVE_POPCNT),y)
 obj-$(CONFIG_GENERIC_HWEIGHT) += hweight.o
+endif
 
 obj-$(CONFIG_BTREE) += btree.o
 obj-$(CONFIG_INTERVAL_TREE) += interval_tree.o
--- a/scripts/kconfig/.gitignore
+++ b/scripts/kconfig/.gitignore
@@ -8,6 +8,7 @@
 # configuration programs
 #
 conf
+cpuid
 mconf
 nconf
 qconf
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -65,8 +65,9 @@ simple-targets := oldconfig allnoconfig allyesconfig allmodconfig \
 	alldefconfig randconfig listnewconfig olddefconfig syncconfig
 PHONY += $(simple-targets)
 
-$(simple-targets): $(obj)/conf
+$(simple-targets): $(obj)/conf $(obj)/cpuid
 	$< $(silent) --$@ $(Kconfig)
+	$(Q)$(srctree)/scripts/march-native.sh $(CC) $(obj)/cpuid
 
 PHONY += savedefconfig defconfig
 
@@ -149,6 +150,10 @@ $(obj)/zconf.lex.o: $(obj)/zconf.tab.h
 HOSTCFLAGS_zconf.lex.o	:= -I$(src)
 HOSTCFLAGS_zconf.tab.o	:= -I$(src)
 
+# cpuid: -march=native, CONFIG_MARCH_NATIVE_* detection
+hostprogs-y	+= cpuid
+cpuid-objs	:= cpuid.o
+
 # conf: Used for defconfig, oldconfig and related targets
 hostprogs-y	+= conf
 conf-objs	:= conf.o $(common-objs)
new file mode 100644
--- /dev/null
+++ b/scripts/kconfig/cpuid.c
@@ -0,0 +1,108 @@
+/*
+ * Copyright (c) 2017 Alexey Dobriyan <adobriyan@gmail.com>
+ *
+ * Permission to use, copy, modify, and distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ */
+#ifdef __x86_64__
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+static inline bool streq(const char *s1, const char *s2)
+{
+	return strcmp(s1, s2) == 0;
+}
+
+static inline void cpuid(uint32_t eax0, uint32_t *eax, uint32_t *ecx, uint32_t *edx, uint32_t *ebx)
+{
+	asm volatile (
+		"cpuid"
+		: "=a" (*eax), "=c" (*ecx), "=d" (*edx), "=b" (*ebx)
+		: "0" (eax0)
+	);
+}
+
+static inline void cpuid2(uint32_t eax0, uint32_t ecx0, uint32_t *eax, uint32_t *ecx, uint32_t *edx, uint32_t *ebx)
+{
+	asm volatile (
+		"cpuid"
+		: "=a" (*eax), "=c" (*ecx), "=d" (*edx), "=b" (*ebx)
+		: "0" (eax0), "1" (ecx0)
+	);
+}
+
+static bool movbe	= false;
+static bool popcnt	= false;
+static bool rep_movsb	= false;
+static bool rep_stosb	= false;
+
+static uint32_t eax0_max;
+
+static void intel(void)
+{
+	uint32_t eax, ecx, edx, ebx;
+
+	if (eax0_max >= 1) {
+		cpuid(1, &eax, &ecx, &edx, &ebx);
+//		printf("%08x %08x %08x %08x\n", eax, ecx, edx, ebx);
+
+		if (ecx & (1 << 22))
+			movbe = true;
+		if (ecx & (1 << 23))
+			popcnt = true;
+	}
+	if (eax0_max >= 7) {
+		cpuid2(7, 0, &eax, &ecx, &edx, &ebx);
+//		printf("%08x %08x %08x %08x\n", eax, ecx, edx, ebx);
+
+		if (ebx & (1 << 9)) {
+			rep_movsb = true;
+			rep_stosb = true;
+		}
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	const char *opt = argv[1];
+	uint32_t eax, ecx, edx, ebx;
+
+	if (argc != 2)
+		return EXIT_FAILURE;
+
+	cpuid(0, &eax, &ecx, &edx, &ebx);
+//	printf("%08x %08x %08x %08x\n", eax, ecx, edx, ebx);
+	eax0_max = eax;
+
+	if (ecx == 0x6c65746e && edx == 0x49656e69 && ebx == 0x756e6547) {
+		intel();
+	}
+
+#define _(x)	if (streq(opt, #x)) return x ? EXIT_SUCCESS : EXIT_FAILURE
+	_(movbe);
+	_(popcnt);
+	_(rep_movsb);
+	_(rep_stosb);
+#undef _
+
+	return EXIT_FAILURE;
+}
+#else
+#include <stdlib.h>
+int main(void)
+{
+	return EXIT_FAILURE;
+}
+#endif
new file mode 100755
--- /dev/null
+++ b/scripts/march-native.sh
@@ -0,0 +1,74 @@
+#!/bin/sh
+# Copyright (c) 2017-2019 Alexey Dobriyan <adobriyan@gmail.com>
+if test "$(uname -m)" != "x86_64"; then
+	exit 0
+fi
+
+CC="$1"
+CPUID="$2"
+CONFIG=".config"
+AUTOCONF1="include/config/auto.conf"
+AUTOCONF2="include/generated/autoconf.h"
+
+if ! grep -q -e '^CONFIG_MARCH_NATIVE=y$' "$CONFIG"; then
+	sed -i -e '/^CONFIG_MARCH_NATIVE/d' "$AUTOCONF1" "$AUTOCONF2" >/dev/null 2>&1
+	exit 0
+fi
+
+if ! "$CC" -march=native -x c -c -o /dev/null /dev/null >/dev/null 2>&1; then
+	echo >&2 "error: unsupported '-march=native' compiler option"
+	exit 1
+fi
+
+_option() {
+	echo "$1=$2"		>>"$CONFIG"
+	echo "$1=$2"		>>"$AUTOCONF1"
+	echo "#define $1 $2"	>>"$AUTOCONF2"
+}
+
+option() {
+	echo "$1=y"		>>"$CONFIG"
+	echo "$1=y"		>>"$AUTOCONF1"
+	echo "#define $1 1"	>>"$AUTOCONF2"
+}
+
+if test ! -f "$CONFIG" -o ! -f "$AUTOCONF1" -o ! -f "$AUTOCONF2"; then
+	exit 0
+fi
+
+COLLECT_GCC_OPTIONS=$(
+	"$CC" -march=native -v -E -x c -c /dev/null 2>&1	|\
+	sed -ne '/^COLLECT_GCC_OPTIONS=/{n;p}'			|\
+	awk '{$1=$1};1'
+)
+echo "-march=native: $COLLECT_GCC_OPTIONS"
+_option "CONFIG_MARCH_NATIVE_CC_OPTIONS" "\"$COLLECT_GCC_OPTIONS\""
+
+"$CPUID" movbe		&& option "CONFIG_MARCH_NATIVE_MOVBE"
+"$CPUID" popcnt		&& option "CONFIG_MARCH_NATIVE_POPCNT"
+"$CPUID" rep_movsb	&& option "CONFIG_MARCH_NATIVE_REP_MOVSB"
+"$CPUID" rep_stosb	&& option "CONFIG_MARCH_NATIVE_REP_STOSB"
+
+for i in $COLLECT_GCC_OPTIONS; do
+	case $i in
+		*/cc1|-E|-quiet|-v|/dev/null|--param|-fstack-protector*)
+			;;
+
+		l1-cache-line-size=64)
+			_option "CONFIG_X86_L1_CACHE_SHIFT"		6
+			_option "CONFIG_X86_INTERNODE_CACHE_SHIFT"	6
+			;;
+
+		l1-cache-size=*);;
+		l2-cache-size=*);;
+
+		-march=*);;
+		-mtune=*);;
+
+		-m*);;
+		-mno-*);;
+
+		*)
+			echo >&2 "warning: unexpected -march=native option '$i'"
+	esac
+done
