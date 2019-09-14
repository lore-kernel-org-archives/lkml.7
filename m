Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7921C4CEC7
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 10:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D2E206A4
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 10:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f71+i13v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbfINKdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 06:33:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38644 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfINKdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 06:33:51 -0400
Received: by mail-wm1-f68.google.com with SMTP id o184so5211927wme.3;
        Sat, 14 Sep 2019 03:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=RFGEI9cLeT+ICRrH8lD0vtyoieMj4FxXtXODF3qwM7A=;
        b=f71+i13vq3Vzt+nWipLQbfTuVqZubeBYWuFCwg0FexDNec5n0cV/z+qNmzQCZT/ZZW
         l//42cUEnqpToL1HRdkgjx2xxFn3c5WKEl7eHEtmthFI16HQFW6NB1tbY6RBeSjMR63m
         sgqr+jCt94Hj3NqtRpN7NnLhZkNS/21n42RVp2POepcR+LDOTI+hB/IJNi1gAV94f3Yl
         UMnNpYKDo6g3O/D0hmVoit10VRrlDWXvYwlqoeAqpcC7YPXw/t87ZAoQ1AWWHGwWRrk/
         V4g7Beoi7Y+88r9V/BspZxxuKoT8mi4VKBd16HVhl8Xi6P5urdIF/zflhJ7f4aHa4s//
         WqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RFGEI9cLeT+ICRrH8lD0vtyoieMj4FxXtXODF3qwM7A=;
        b=iLuY9F/b2nvnYW8j0ShHtrcahGL0l7apFic/0nivLYRCj/kfAudpWW5XlcRY9cXAxv
         YOsAS9aghZSiK34ifEr2ac+hH2enSdSEVnBtSNqUzSoGDHQRDiay+b/JEdichlJSblDz
         LQ3b3VOpwLncNLgGHCuwxSu1lksrFhKsajSCbop4wljWGoL9Lw37sna4B0gXs21M0eDX
         9OFnNy3DupjF4uFcrhQWGZmfi/ezV1mj++55Ab96I1dLJSQWJXXpV7EWLiX0SWcEVMk+
         KqbPhFP3r57QxDcEgYRdBjqbBGZNxWW1vyxfY5187jrY68M7uKphOBhbDJxdyjG6ekax
         HSKg==
X-Gm-Message-State: APjAAAWwB5Urgr7y1DXWoF5/gVv2Djhy4XWlS3ETTgUA4vfm1a+c14Zq
        ZGILs6ISi4TosUPw3IVIXg==
X-Google-Smtp-Source: APXvYqyf09lLao/95ViAGryJPvxC4ygKdWgLm0Id9auPHTlEQq6G5zpbb1qCbwJ+u12iwzrT7ja4Ww==
X-Received: by 2002:a05:600c:2308:: with SMTP id 8mr7223418wmo.67.1568457228424;
        Sat, 14 Sep 2019 03:33:48 -0700 (PDT)
Received: from avx2 ([46.53.250.254])
        by smtp.gmail.com with ESMTPSA id d9sm52720356wrc.44.2019.09.14.03.33.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Sep 2019 03:33:47 -0700 (PDT)
Date:   Sat, 14 Sep 2019 13:33:45 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org, x86@vger.kernel.org,
        linux@rasmusvillemoes.dk, torvalds@linux-foundation.org
Subject: [PATCH] x86_64: new and improved memset()
Message-ID: <20190914103345.GA5856@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current memset() implementation does silly things:
* multiplication to get register-wide constant:
	waste of cycles if filler is known at compile time,

* REP STOSQ followed by REP STOSB:
	REP STOSB setup overhead is very high because trailing length
	is very low (< 8)

* suboptimal calling convention:
	REP STOSB/STOSQ favours (rdi, rcx), ABI gives (rdi, rsi, rdx).
	While shuffling registers is free, rcx and rdx are equivalent
	code generation wise.

* memset_orig():
	memset(..., 0, ...) could be done within 3 registers,
	memset(..., != 0, ...) -- within 4 registers, anything else is
	a waste. CPUs which required unrolling are hopefully gone by now.

New implementation is based on the following observations:
* c == 0 is the most common form,
	filler can be done with "xor eax, eax" and pushed into memset()
	saving 2 bytes per call and multiplication

* "len" divisible by 8 is the most common form:
	all it takes is one pointer or unsigned long inside structure,
	dispatch at compile time to code without those ugly "lets fill
	at most 7 bytes" tails,

* multiplication to get wider filler value can be done at compile time
  for "c != 0" with 1 insn/10 bytes at most saving multiplication.

Note: "memset0" name is chosen because "bzero" is officially deprecated.

Note: memset(,0,) form is interleaved into memset(,c,) form to save space.

TODO:
	CONFIG_FORTIFY_SOURCE is enabled by distros
	inline "xor eax, eax; rep stosb"
	benchmarks
	testing

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/x86/boot/compressed/Makefile     |    1 
 arch/x86/include/asm/string_64.h      |  104 ++++++++++++++++++++++++++++++++++
 arch/x86/lib/Makefile                 |    1 
 arch/x86/lib/memset0_64.S             |   86 ++++++++++++++++++++++++++++
 drivers/firmware/efi/libstub/Makefile |    2 
 5 files changed, 193 insertions(+), 1 deletion(-)

--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -38,6 +38,7 @@ KBUILD_CFLAGS += $(call cc-option,-fno-stack-protector)
 KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
 KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
 KBUILD_CFLAGS += -Wno-pointer-sign
+KBUILD_CFLAGS += -D_ARCH_X86_BOOT
 
 KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
 GCOV_PROFILE := n
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -15,7 +15,111 @@ extern void *memcpy(void *to, const void *from, size_t len);
 extern void *__memcpy(void *to, const void *from, size_t len);
 
 #define __HAVE_ARCH_MEMSET
+#if defined(_ARCH_X86_BOOT) || defined(CONFIG_FORTIFY_SOURCE)
 void *memset(void *s, int c, size_t n);
+#else
+#include <asm/alternative.h>
+#include <asm/cpufeatures.h>
+
+/* Internal, do not use. */
+static __always_inline void memset0(void *s, size_t n)
+{
+	/* Internal, do not use. */
+	void _memset0_mov(void);
+	void _memset0_rep_stosq(void);
+	void memset0_mov(void);
+	void memset0_rep_stosq(void);
+	void memset0_rep_stosb(void);
+
+	if (__builtin_constant_p(n) && n == 0) {
+	} else if (__builtin_constant_p(n) && n == 1) {
+		*(uint8_t *)s = 0;
+	} else if (__builtin_constant_p(n) && n == 2) {
+		*(uint16_t *)s = 0;
+	} else if (__builtin_constant_p(n) && n == 4) {
+		*(uint32_t *)s = 0;
+	} else if (__builtin_constant_p(n) && n == 6) {
+		*(uint32_t *)s = 0;
+		*(uint16_t *)(s + 4) = 0;
+	} else if (__builtin_constant_p(n) && n == 8) {
+		*(uint64_t *)s = 0;
+	} else if (__builtin_constant_p(n) && (n & 7) == 0) {
+		alternative_call_2(
+			_memset0_mov,
+			_memset0_rep_stosq, X86_FEATURE_REP_GOOD,
+			memset0_rep_stosb, X86_FEATURE_ERMS,
+			ASM_OUTPUT2("=D" (s), "=c" (n)),
+			"D" (s), "c" (n)
+			: "rax", "cc", "memory"
+		);
+	} else {
+		alternative_call_2(
+			memset0_mov,
+			memset0_rep_stosq, X86_FEATURE_REP_GOOD,
+			memset0_rep_stosb, X86_FEATURE_ERMS,
+			ASM_OUTPUT2("=D" (s), "=c" (n)),
+			"D" (s), "c" (n)
+			: "rax", "rsi", "cc", "memory"
+		);
+	}
+}
+
+/* Internal, do not use. */
+static __always_inline void memsetx(void *s, int c, size_t n)
+{
+	/* Internal, do not use. */
+	void _memsetx_mov(void);
+	void _memsetx_rep_stosq(void);
+	void memsetx_mov(void);
+	void memsetx_rep_stosq(void);
+	void memsetx_rep_stosb(void);
+
+	const uint64_t ccc = (uint8_t)c * 0x0101010101010101ULL;
+
+	if (__builtin_constant_p(n) && n == 0) {
+	} else if (__builtin_constant_p(n) && n == 1) {
+		*(uint8_t *)s = ccc;
+	} else if (__builtin_constant_p(n) && n == 2) {
+		*(uint16_t *)s = ccc;
+	} else if (__builtin_constant_p(n) && n == 4) {
+		*(uint32_t *)s = ccc;
+	} else if (__builtin_constant_p(n) && n == 8) {
+		*(uint64_t *)s = ccc;
+	} else if (__builtin_constant_p(n) && (n & 7) == 0) {
+		alternative_call_2(
+			_memsetx_mov,
+			_memsetx_rep_stosq, X86_FEATURE_REP_GOOD,
+			memsetx_rep_stosb, X86_FEATURE_ERMS,
+			ASM_OUTPUT2("=D" (s), "=c" (n)),
+			"D" (s), "c" (n), "a" (ccc)
+			: "cc", "memory"
+		);
+	} else {
+		alternative_call_2(
+			memsetx_mov,
+			memsetx_rep_stosq, X86_FEATURE_REP_GOOD,
+			memsetx_rep_stosb, X86_FEATURE_ERMS,
+			ASM_OUTPUT2("=D" (s), "=c" (n)),
+			"D" (s), "c" (n), "a" (ccc)
+			: "rsi", "cc", "memory"
+		);
+	}
+}
+
+static __always_inline void *memset(void *s, int c, size_t n)
+{
+	if (__builtin_constant_p(c)) {
+		if (c == 0) {
+			memset0(s, n);
+		} else {
+			memsetx(s, c, n);
+		}
+		return s;
+	} else {
+		return __builtin_memset(s, c, n);
+	}
+}
+#endif
 void *__memset(void *s, int c, size_t n);
 
 #define __HAVE_ARCH_MEMSET16
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -58,6 +58,7 @@ else
         lib-y += csum-partial_64.o csum-copy_64.o csum-wrappers_64.o
         lib-y += clear_page_64.o copy_page_64.o
         lib-y += memmove_64.o memset_64.o
+	lib-y += memset0_64.o
         lib-y += copy_user_64.o
 	lib-y += cmpxchg16b_emu.o
 endif
new file mode 100644
--- /dev/null
+++ b/arch/x86/lib/memset0_64.S
@@ -0,0 +1,86 @@
+#include <linux/linkage.h>
+#include <asm/export.h>
+
+.intel_syntax noprefix
+
+ENTRY(memset0_rep_stosb)
+	xor	eax, eax
+.globl memsetx_rep_stosb
+memsetx_rep_stosb:
+	rep stosb
+	ret
+ENDPROC(memset0_rep_stosb)
+ENDPROC(memsetx_rep_stosb)
+EXPORT_SYMBOL(memset0_rep_stosb)
+EXPORT_SYMBOL(memsetx_rep_stosb)
+
+ENTRY(_memset0_rep_stosq)
+	xor	eax, eax
+.globl _memsetx_rep_stosq
+_memsetx_rep_stosq:
+	shr	rcx, 3
+	rep stosq
+	ret
+ENDPROC(_memset0_rep_stosq)
+ENDPROC(_memsetx_rep_stosq)
+EXPORT_SYMBOL(_memset0_rep_stosq)
+EXPORT_SYMBOL(_memsetx_rep_stosq)
+
+ENTRY(memset0_rep_stosq)
+	xor	eax, eax
+.globl memsetx_rep_stosq
+memsetx_rep_stosq:
+	lea	rsi, [rdi + rcx]
+	shr	rcx, 3
+	rep stosq
+	cmp	rdi, rsi
+	je	1f
+2:
+	mov	[rdi], al
+	add	rdi, 1
+	cmp	rdi, rsi
+	jne	2b
+1:
+	ret
+ENDPROC(memset0_rep_stosq)
+ENDPROC(memsetx_rep_stosq)
+EXPORT_SYMBOL(memset0_rep_stosq)
+EXPORT_SYMBOL(memsetx_rep_stosq)
+
+ENTRY(_memset0_mov)
+	xor	eax, eax
+.globl _memsetx_mov
+_memsetx_mov:
+	add	rcx, rdi
+	cmp	rdi, rcx
+	je	1f
+2:
+	mov	[rdi], rax
+	add	rdi, 8
+	cmp	rdi, rcx
+	jne	2b
+1:
+	ret
+ENDPROC(_memset0_mov)
+ENDPROC(_memsetx_mov)
+EXPORT_SYMBOL(_memset0_mov)
+EXPORT_SYMBOL(_memsetx_mov)
+
+ENTRY(memset0_mov)
+	xor	eax, eax
+.globl memsetx_mov
+memsetx_mov:
+	lea	rsi, [rdi + rcx]
+	cmp	rdi, rsi
+	je	1f
+2:
+	mov	[rdi], al
+	add	rdi, 1
+	cmp	rdi, rsi
+	jne	2b
+1:
+	ret
+ENDPROC(memset0_mov)
+ENDPROC(memsetx_mov)
+EXPORT_SYMBOL(memset0_mov)
+EXPORT_SYMBOL(memsetx_mov)
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -28,7 +28,7 @@ KBUILD_CFLAGS			:= $(cflags-y) -DDISABLE_BRANCH_PROFILING \
 				   -D__NO_FORTIFY \
 				   $(call cc-option,-ffreestanding) \
 				   $(call cc-option,-fno-stack-protector) \
-				   -D__DISABLE_EXPORTS
+				   -D__DISABLE_EXPORTS -D_ARCH_X86_BOOT
 
 GCOV_PROFILE			:= n
 KASAN_SANITIZE			:= n
