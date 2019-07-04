Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4447C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 20:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A2D218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 20:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGpkDLHX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfGDUsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 16:48:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50949 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbfGDUsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 16:48:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id n9so6838764wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 13:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xMBJlAzlhFijqRnAtF2IaI7ccrEXwENgSjQVFisQ2lU=;
        b=MGpkDLHXZlsmvIapEkQ09tUXrQXhMed5B0EVF1e/2f3GvZrQoIma5aeEWU++FaP4fM
         PC2JqiOnH414WahVRgrQNvsbBihrartfj5wnu24blihaynT6nkqqeJaH/9hjErZe1CG4
         bGDAvPkX6cEQjIbhESBCROt3JyBUGrwbvY1Dn2DWp4/9hWIpRzkLDb8tgRGJ7cA5H1+F
         Hz6RJz6/Maj9VQKuUa2Udg7r47Lpvlg/4TgKuBIYWPyOhtPG6fORUL3VStJkTNiWiRfm
         V0Cdu8YsC2w1tlafYFYzr1ryS2gvJ2KCRcJNZq1hT0wnrLb9pnpyLAUQWAL7iGEEaaOb
         ZIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xMBJlAzlhFijqRnAtF2IaI7ccrEXwENgSjQVFisQ2lU=;
        b=PTRIN+YUuF6MKMxScyfzqXTm14aH/qfs2s1mvzAqJnNl6mfXbG/WChP+I/1wti5HUE
         oNbmG1A7gdapxPn+8SEW/KhvS9MUMEXV7SXYYCEww00xCWT6XNYWMYiE2sj6dzdJDPPa
         pXkFc4es0SMDRRa5QqNAcJoUZpxEPK6NjZG19QLRI2OgbriNOlp4DksUjOlCldGolv7m
         3jkgb+gFc2uNPcW6DVFiWKqWnxEbFLmlGvaQDuNE4Y18cleJIkWeZayb1mcEDWGsA1nR
         WHSopdF5JhK+6whurLNlo3LuFAEjVGLroBVsmuRKiyNX16vHT09KR/G2cyQsw+thbN7E
         fTYw==
X-Gm-Message-State: APjAAAUaMQ/UMYhkTtAKU9yYaIKl/jiYHe7HB2Km7CFMDKB3W9QqvtF3
        wukIZAiyCQw17tArmU4qkg==
X-Google-Smtp-Source: APXvYqw6/3EIrzRF4cgQFDsUBQUx+ZmWoY7XyarMi/v7HrX0q0ef8w2gzkIZbh3NrLAdgJjqhFAwuA==
X-Received: by 2002:a1c:6545:: with SMTP id z66mr8648wmb.77.1562273282129;
        Thu, 04 Jul 2019 13:48:02 -0700 (PDT)
Received: from localhost.localdomain ([46.53.251.222])
        by smtp.gmail.com with ESMTPSA id l11sm6042581wrw.97.2019.07.04.13.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 13:48:01 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, adobriyan@gmail.com
Subject: [PATCH 4/5] x86_64, -march=native: REP STOSB support
Date:   Thu,  4 Jul 2019 23:47:36 +0300
Message-Id: <20190704204737.5267-4-adobriyan@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190704204737.5267-1-adobriyan@gmail.com>
References: <20190704204737.5267-1-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use REP STOSB everywhere if CPU advertises fast REP STOSB.

Gcc LOVES to unroll memset(), using -mmemset-strategy saves terabytes of
.text.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 Makefile                           |  3 +++
 arch/x86/boot/compressed/head_64.S |  4 ++++
 arch/x86/crypto/sha1_ssse3_asm.S   |  7 ++++++-
 arch/x86/include/asm/page_64.h     | 13 +++++++++++++
 arch/x86/kernel/verify_cpu.S       |  2 +-
 arch/x86/lib/Makefile              |  2 ++
 arch/x86/lib/memset_64.S           | 15 +++++++++++++++
 arch/x86/lib/usercopy_64.c         | 16 +++++++++++++++-
 scripts/kconfig/cpuid.c            |  6 +++++-
 scripts/march-native.sh            |  1 +
 10 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 4422dcf1254b..8b7e6769886e 100644
--- a/Makefile
+++ b/Makefile
@@ -609,6 +609,9 @@ endif
 ifdef CONFIG_MARCH_NATIVE_REP_MOVSB
 KBUILD_CFLAGS += -mmemcpy-strategy=rep_byte:-1:align,rep_byte:-1:noalign
 endif
+ifdef CONFIG_MARCH_NATIVE_REP_STOSB
+KBUILD_CFLAGS += -mmemset-strategy=rep_byte:-1:align,rep_byte:-1:noalign
+endif
 
 ifeq ($(KBUILD_EXTMOD),)
 # Objects we will link into vmlinux / subdirs we need to visit
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index fafb75c6c592..72ed646301b0 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -520,8 +520,12 @@ relocated:
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
diff --git a/arch/x86/crypto/sha1_ssse3_asm.S b/arch/x86/crypto/sha1_ssse3_asm.S
index 99c5b8c4dc38..c98f8f2aead6 100644
--- a/arch/x86/crypto/sha1_ssse3_asm.S
+++ b/arch/x86/crypto/sha1_ssse3_asm.S
@@ -90,10 +90,15 @@
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
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index 051da768273d..7654d5544e0b 100644
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
@@ -53,6 +65,7 @@ static inline void clear_page(void *page)
 			   "0" (page)
 			   : "cc", "memory", "rax", "rcx");
 }
+#endif
 
 #ifdef CONFIG_MARCH_NATIVE_REP_MOVSB
 static __always_inline void copy_page(void *to, void *from)
diff --git a/arch/x86/kernel/verify_cpu.S b/arch/x86/kernel/verify_cpu.S
index 57b41dafc592..d3f3370e7dab 100644
--- a/arch/x86/kernel/verify_cpu.S
+++ b/arch/x86/kernel/verify_cpu.S
@@ -142,7 +142,7 @@ ENTRY(verify_cpu)
 	jnc	.Lverify_cpu_no_longmode
 #endif
 
-#ifdef CONFIG_MARCH_NATIVE_REP_MOVSB
+#if defined(CONFIG_MARCH_NATIVE_REP_MOVSB) || defined(CONFIG_MARCH_NATIVE_REP_STOSB)
 	xor	%eax, %eax
 	cpuid
 	cmp	$7, %eax
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index fa24cc717fb1..ed71e88cb859 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -59,7 +59,9 @@ endif
 else
         obj-y += iomap_copy_64.o
         lib-y += csum-partial_64.o csum-copy_64.o csum-wrappers_64.o
+ifneq ($(CONFIG_MARCH_NATIVE_REP_STOSB),y)
         lib-y += clear_page_64.o
+endif
 ifneq ($(CONFIG_MARCH_NATIVE_REP_MOVSB),y)
 	lib-y += copy_page_64.o
 endif
diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
index 9bc861c71e75..7786d1a65423 100644
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
diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
index e0e006f1624e..9e9d957bd8b3 100644
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -16,11 +16,23 @@
 
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
@@ -42,6 +54,8 @@ unsigned long __clear_user(void __user *addr, unsigned long size)
 		_ASM_EXTABLE_UA(1b, 2b)
 		: [size8] "=&c"(size), [dst] "=&D" (__d0)
 		: [size1] "r"(size & 7), "[size8]" (size / 8), "[dst]"(addr));
+	}
+#endif
 	clac();
 	return size;
 }
diff --git a/scripts/kconfig/cpuid.c b/scripts/kconfig/cpuid.c
index 2d78fba1dcc7..58d09bda61e5 100644
--- a/scripts/kconfig/cpuid.c
+++ b/scripts/kconfig/cpuid.c
@@ -45,6 +45,7 @@ static inline void cpuid2(uint32_t eax0, uint32_t ecx0, uint32_t *eax, uint32_t
 
 static bool popcnt	= false;
 static bool rep_movsb	= false;
+static bool rep_stosb	= false;
 
 static uint32_t eax0_max;
 
@@ -64,8 +65,10 @@ static void intel(void)
 		cpuid2(7, 0, &eax, &ecx, &edx, &ebx);
 //		printf("%08x %08x %08x %08x\n", eax, ecx, edx, ebx);
 
-		if (ebx & (1 << 9))
+		if (ebx & (1 << 9)) {
 			rep_movsb = true;
+			rep_stosb = true;
+		}
 	}
 }
 
@@ -88,6 +91,7 @@ int main(int argc, char *argv[])
 #define _(x)	if (streq(opt, #x)) return x ? EXIT_SUCCESS : EXIT_FAILURE
 	_(popcnt);
 	_(rep_movsb);
+	_(rep_stosb);
 #undef _
 
 	return EXIT_FAILURE;
diff --git a/scripts/march-native.sh b/scripts/march-native.sh
index 87f00cdb8e10..a41a15a64df4 100755
--- a/scripts/march-native.sh
+++ b/scripts/march-native.sh
@@ -43,6 +43,7 @@ echo "-march=native: $COLLECT_GCC_OPTIONS"
 
 "$CPUID" popcnt		&& option "CONFIG_MARCH_NATIVE_POPCNT"
 "$CPUID" rep_movsb	&& option "CONFIG_MARCH_NATIVE_REP_MOVSB"
+"$CPUID" rep_stosb	&& option "CONFIG_MARCH_NATIVE_REP_STOSB"
 
 for i in $COLLECT_GCC_OPTIONS; do
 	case $i in
-- 
2.21.0

