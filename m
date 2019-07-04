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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2198C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 20:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC7C218A0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 20:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rifUJEzA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfGDUsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 16:48:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33574 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbfGDUsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 16:48:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so7817356wru.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 13:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WdSzEQHqwSMjKum+kGHPxijzUO1SKoGxKn6W7Ura5Us=;
        b=rifUJEzArqLOPnD8ZH7fBGPGZlYQKW6Y+xG5/47gz13tqIPA1FMz5wfQmDK3dj7aAz
         +s1Lc86c4MFHU8oMNj4fIpOAYKxzhfRmRVpdRgnDxT6x24cXsmi46onIyPsZBJXR5Mal
         TdtmwduxunhUIreRvsu8Phs3KXElvRc8+asekNeA0wbQNEs1E4r2CvnbB5i6q7MXifcO
         UzS6gjhnL9Bn3rucxsoHdcvPlye64pGwFGF5b8HFOs5mp7BzoQVIXem7lxkK0n++NdqG
         5F3XoB67pgO2FrNbzrSW3Sp2pw3wC9mC6Qlv3WhfIGbQuULKqDF9HZncut/wVthS/vME
         FdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WdSzEQHqwSMjKum+kGHPxijzUO1SKoGxKn6W7Ura5Us=;
        b=FUmW/2/z3PaQoCpY5aO5w6hwvdKdOs6meIM5P5EXJ/aQgCxAECDlYEHRWj1bG6pT6A
         NXic4AafcBv6nEdjdwZMlxmb1OW7u8N5WmekFvI5lSM6h5ISyfAe5yzzE99MUhuDzCqi
         ub4T401Mw9JWL7wQFvHSwZLDxzKnsrEPTvhFqb5OJl46fU02YethTQAnZwrnqt7t8yAL
         9sEbPLadbIksSzLs4v6f8KuR5VUairJoC0hbY2oW4S9JEbQI23OJESE7tyQZGPGT1taH
         3im6Fxb22jGupwAVP/NjMlAdUIG8TvJBNZ17bBD+be3WGTUM/eQ4QFaGchQQXr4/WT+Y
         lNLA==
X-Gm-Message-State: APjAAAVUrGTUd5dtEs6jTcEcG5o8F4N+uVB+C73Rv9GD4QMK2BNQluns
        sNE1x9TeHtA0zl4ygfUZtg==
X-Google-Smtp-Source: APXvYqxbuLQQht91FZVYNE9n31SWDn3CBkcgZaf6PmjzJAuEhmdTySdebLyOl9f5JerA638yM7hVfA==
X-Received: by 2002:a5d:4a8d:: with SMTP id o13mr271142wrq.350.1562273280196;
        Thu, 04 Jul 2019 13:48:00 -0700 (PDT)
Received: from localhost.localdomain ([46.53.251.222])
        by smtp.gmail.com with ESMTPSA id l11sm6042581wrw.97.2019.07.04.13.47.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 13:47:59 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, adobriyan@gmail.com
Subject: [PATCH 2/5] x86_64, -march=native: POPCNT support
Date:   Thu,  4 Jul 2019 23:47:34 +0300
Message-Id: <20190704204737.5267-2-adobriyan@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190704204737.5267-1-adobriyan@gmail.com>
References: <20190704204737.5267-1-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Detect POPCNT instruction support and inline hweigth*() functions
if it is supported by CPU.

Detect POPCNT at boot time and conditionally refuse to boot.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 arch/x86/include/asm/arch_hweight.h | 24 ++++++++++++++++++++++++
 arch/x86/include/asm/segment.h      |  1 +
 arch/x86/kernel/verify_cpu.S        |  8 ++++++++
 arch/x86/lib/Makefile               |  5 ++++-
 include/linux/bitops.h              |  2 ++
 lib/Makefile                        |  2 ++
 scripts/kconfig/cpuid.c             |  7 +++++++
 scripts/march-native.sh             |  2 ++
 8 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/arch_hweight.h b/arch/x86/include/asm/arch_hweight.h
index ba88edd0d58b..3797aa57baa5 100644
--- a/arch/x86/include/asm/arch_hweight.h
+++ b/arch/x86/include/asm/arch_hweight.h
@@ -2,6 +2,28 @@
 #ifndef _ASM_X86_HWEIGHT_H
 #define _ASM_X86_HWEIGHT_H
 
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
@@ -53,3 +75,5 @@ static __always_inline unsigned long __arch_hweight64(__u64 w)
 #endif /* CONFIG_X86_32 */
 
 #endif
+
+#endif
diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index ac3892920419..d314c6b9b632 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -4,6 +4,7 @@
 
 #include <linux/const.h>
 #include <asm/alternative.h>
+#include <asm/cpufeatures.h>
 
 /*
  * Constructor for a conventional segment GDT (or LDT) entry.
diff --git a/arch/x86/kernel/verify_cpu.S b/arch/x86/kernel/verify_cpu.S
index a024c4f7ba56..a9be8904faa3 100644
--- a/arch/x86/kernel/verify_cpu.S
+++ b/arch/x86/kernel/verify_cpu.S
@@ -134,6 +134,14 @@ ENTRY(verify_cpu)
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
 	popf				# Restore caller passed flags
 	xorl %eax, %eax
 	ret
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 5246db42de45..7dc0e71b0ef3 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -40,7 +40,10 @@ lib-$(CONFIG_RANDOMIZE_BASE) += kaslr.o
 lib-$(CONFIG_FUNCTION_ERROR_INJECTION)	+= error-inject.o
 lib-$(CONFIG_RETPOLINE) += retpoline.o
 
-obj-y += msr.o msr-reg.o msr-reg-export.o hweight.o
+obj-y += msr.o msr-reg.o msr-reg-export.o
+ifneq ($(CONFIG_MARCH_NATIVE_POPCNT),y)
+	obj-y += hweight.o
+endif
 obj-y += iomem.o
 
 ifeq ($(CONFIG_X86_32),y)
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index cf074bce3eb3..655b120bba66 100644
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
diff --git a/lib/Makefile b/lib/Makefile
index fb7697031a79..87e7b974cab1 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -112,7 +112,9 @@ obj-$(CONFIG_DEBUG_LOCKING_API_SELFTESTS) += locking-selftest.o
 
 obj-y += logic_pio.o
 
+ifneq ($(CONFIG_MARCH_NATIVE_POPCNT),y)
 obj-$(CONFIG_GENERIC_HWEIGHT) += hweight.o
+endif
 
 obj-$(CONFIG_BTREE) += btree.o
 obj-$(CONFIG_INTERVAL_TREE) += interval_tree.o
diff --git a/scripts/kconfig/cpuid.c b/scripts/kconfig/cpuid.c
index 81b292382e26..9efc0d9464d8 100644
--- a/scripts/kconfig/cpuid.c
+++ b/scripts/kconfig/cpuid.c
@@ -43,6 +43,8 @@ static inline void cpuid2(uint32_t eax0, uint32_t ecx0, uint32_t *eax, uint32_t
 	);
 }
 
+static bool popcnt	= false;
+
 static uint32_t eax0_max;
 
 static void intel(void)
@@ -52,6 +54,10 @@ static void intel(void)
 	if (eax0_max >= 1) {
 		cpuid(1, &eax, &ecx, &edx, &ebx);
 //		printf("%08x %08x %08x %08x\n", eax, ecx, edx, ebx);
+
+		if (ecx & (1 << 23)) {
+			popcnt = true;
+		}
 	}
 }
 
@@ -72,6 +78,7 @@ int main(int argc, char *argv[])
 	}
 
 #define _(x)	if (streq(opt, #x)) return x ? EXIT_SUCCESS : EXIT_FAILURE
+	_(popcnt);
 #undef _
 
 	return EXIT_FAILURE;
diff --git a/scripts/march-native.sh b/scripts/march-native.sh
index 29a33c80b62b..c3059f93ed2b 100755
--- a/scripts/march-native.sh
+++ b/scripts/march-native.sh
@@ -41,6 +41,8 @@ COLLECT_GCC_OPTIONS=$(
 )
 echo "-march=native: $COLLECT_GCC_OPTIONS"
 
+"$CPUID" popcnt		&& option "CONFIG_MARCH_NATIVE_POPCNT"
+
 for i in $COLLECT_GCC_OPTIONS; do
 	case $i in
 		*/cc1|-E|-quiet|-v|/dev/null|--param|-fstack-protector*)
-- 
2.21.0

