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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1290C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 20:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75870218AD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 20:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvLXT7lu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfGDUsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 16:48:06 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35134 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfGDUsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 16:48:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id l2so25923wmg.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 13:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HZLOKYMGayflW0Xxy8TyideR/fv3M68HVeKYr1VPis0=;
        b=CvLXT7luGMdxLhiW8n2ytDTwfuCFSqpXM6R9xBDQCJorJp/TnDvJQ2lxvkWoij0HFG
         t6YqpKlmh076m9+r5widszsDYTyQd8CNf1c+rIvccRZ0TEs3PP+atGLEVtjmN7DiyNpE
         O566V/kvkKsi0ugBSNMfR5LbeYM7jgLWVrCifwJoFfySzBPYg0dOn7VE8BRHYkuZOFRl
         cC6ZBaplYSifBVHyXGfv4vk50VS0nu6E3z5kpq6Tvq/4suT3k6IynQ3atFJoJHJ0ntbG
         +6GRim4d1ZvS8FIlaUQ19AXYzhjLfSuHU4eWl3/v6AJBnD1XdD35qWkTxsiUsFsj4TtV
         rzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HZLOKYMGayflW0Xxy8TyideR/fv3M68HVeKYr1VPis0=;
        b=GXrd2EDjCkpnFqLWXSZoQ8hbJljGL3ZWHYFWRLXffkzk1JlTW+UxMV3YMgt+iKzVJF
         NujuCsUQNnnMmaXgC+DOptiUnWIqFQiZ8z9Y48oukhx3jTvpm9u4IRfjB799VY6VAARq
         WOZHXDXWEMh40yPE9mbddtClQy0tB979rd3GbK9aDwUmH6hK/SiKvkJrmmDNlvIjdD+2
         xYKLdrS4A9OTvH6BI+qvScGy2pqS65imFBSvpWVO1ljrAxV5haM/MFCA9eQqC6vKPbqc
         RIKH1bAu3D7Kcm933+2xUOicJMp9pU72lwCZfwUL08aGwFdnyaCWALZSvQ4mdStOYEzJ
         Y6Gw==
X-Gm-Message-State: APjAAAVeAxpj4yWCRvit/HUq+Ni7pt+6Ey7iyupuV5IPR+WhleQET3ou
        igkL1rHA6Q/esZ51skbxog==
X-Google-Smtp-Source: APXvYqydB5DebCzLmctfMDON05Bhiw/tMMBVQVYtt/ibGHkR6WuLNDJkLh/m2kSrNvHvZgxy6dHeWA==
X-Received: by 2002:a1c:2314:: with SMTP id j20mr17431wmj.152.1562273281074;
        Thu, 04 Jul 2019 13:48:01 -0700 (PDT)
Received: from localhost.localdomain ([46.53.251.222])
        by smtp.gmail.com with ESMTPSA id l11sm6042581wrw.97.2019.07.04.13.48.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 13:48:00 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, adobriyan@gmail.com
Subject: [PATCH 3/5] x86_64, -march=native: REP MOVSB support
Date:   Thu,  4 Jul 2019 23:47:35 +0300
Message-Id: <20190704204737.5267-3-adobriyan@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190704204737.5267-1-adobriyan@gmail.com>
References: <20190704204737.5267-1-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Detect fast REP MOVSB support and use it for page copying.

Inline copy_page(), this saves alternative entry and a function call
overhead which should hopefully improve code generation.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 Makefile                             |  3 +++
 arch/x86/include/asm/page_64.h       | 13 +++++++++++++
 arch/x86/kernel/relocate_kernel_64.S | 15 +++++++++++++++
 arch/x86/kernel/verify_cpu.S         | 12 ++++++++++++
 arch/x86/lib/Makefile                |  5 ++++-
 arch/x86/lib/memcpy_64.S             | 13 +++++++++++++
 arch/x86/platform/pvh/head.S         |  4 ++++
 scripts/kconfig/cpuid.c              |  9 +++++++++
 scripts/march-native.sh              |  1 +
 9 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 9b0cfca01997..4422dcf1254b 100644
--- a/Makefile
+++ b/Makefile
@@ -606,6 +606,9 @@ endif
 ifdef CONFIG_MARCH_NATIVE
 KBUILD_CFLAGS += -march=native
 endif
+ifdef CONFIG_MARCH_NATIVE_REP_MOVSB
+KBUILD_CFLAGS += -mmemcpy-strategy=rep_byte:-1:align,rep_byte:-1:noalign
+endif
 
 ifeq ($(KBUILD_EXTMOD),)
 # Objects we will link into vmlinux / subdirs we need to visit
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index 939b1cff4a7b..051da768273d 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -54,7 +54,20 @@ static inline void clear_page(void *page)
 			   : "cc", "memory", "rax", "rcx");
 }
 
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
 
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index c51ccff5cd01..822f7a3d035a 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -266,18 +266,33 @@ swap_pages:
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
diff --git a/arch/x86/kernel/verify_cpu.S b/arch/x86/kernel/verify_cpu.S
index a9be8904faa3..57b41dafc592 100644
--- a/arch/x86/kernel/verify_cpu.S
+++ b/arch/x86/kernel/verify_cpu.S
@@ -142,6 +142,18 @@ ENTRY(verify_cpu)
 	jnc	.Lverify_cpu_no_longmode
 #endif
 
+#ifdef CONFIG_MARCH_NATIVE_REP_MOVSB
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
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 7dc0e71b0ef3..fa24cc717fb1 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -59,7 +59,10 @@ endif
 else
         obj-y += iomap_copy_64.o
         lib-y += csum-partial_64.o csum-copy_64.o csum-wrappers_64.o
-        lib-y += clear_page_64.o copy_page_64.o
+        lib-y += clear_page_64.o
+ifneq ($(CONFIG_MARCH_NATIVE_REP_MOVSB),y)
+	lib-y += copy_page_64.o
+endif
         lib-y += memmove_64.o memset_64.o
         lib-y += copy_user_64.o
 	lib-y += cmpxchg16b_emu.o
diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index 92748660ba51..ab5b9662b348 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -17,6 +17,18 @@
 
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
@@ -183,6 +195,7 @@ ENTRY(memcpy_orig)
 .Lend:
 	retq
 ENDPROC(memcpy_orig)
+#endif
 
 #ifndef CONFIG_UML
 
diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index 1f8825bbaffb..2737f3e8c021 100644
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
 
diff --git a/scripts/kconfig/cpuid.c b/scripts/kconfig/cpuid.c
index 9efc0d9464d8..2d78fba1dcc7 100644
--- a/scripts/kconfig/cpuid.c
+++ b/scripts/kconfig/cpuid.c
@@ -44,6 +44,7 @@ static inline void cpuid2(uint32_t eax0, uint32_t ecx0, uint32_t *eax, uint32_t
 }
 
 static bool popcnt	= false;
+static bool rep_movsb	= false;
 
 static uint32_t eax0_max;
 
@@ -59,6 +60,13 @@ static void intel(void)
 			popcnt = true;
 		}
 	}
+	if (eax0_max >= 7) {
+		cpuid2(7, 0, &eax, &ecx, &edx, &ebx);
+//		printf("%08x %08x %08x %08x\n", eax, ecx, edx, ebx);
+
+		if (ebx & (1 << 9))
+			rep_movsb = true;
+	}
 }
 
 int main(int argc, char *argv[])
@@ -79,6 +87,7 @@ int main(int argc, char *argv[])
 
 #define _(x)	if (streq(opt, #x)) return x ? EXIT_SUCCESS : EXIT_FAILURE
 	_(popcnt);
+	_(rep_movsb);
 #undef _
 
 	return EXIT_FAILURE;
diff --git a/scripts/march-native.sh b/scripts/march-native.sh
index c3059f93ed2b..87f00cdb8e10 100755
--- a/scripts/march-native.sh
+++ b/scripts/march-native.sh
@@ -42,6 +42,7 @@ COLLECT_GCC_OPTIONS=$(
 echo "-march=native: $COLLECT_GCC_OPTIONS"
 
 "$CPUID" popcnt		&& option "CONFIG_MARCH_NATIVE_POPCNT"
+"$CPUID" rep_movsb	&& option "CONFIG_MARCH_NATIVE_REP_MOVSB"
 
 for i in $COLLECT_GCC_OPTIONS; do
 	case $i in
-- 
2.21.0

