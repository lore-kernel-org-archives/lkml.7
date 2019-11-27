Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A35C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C7220835
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="IQsLDxJ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfK0SpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 13:45:03 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:35190 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfK0SpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 13:45:01 -0500
Received: by mail-qv1-f66.google.com with SMTP id y18so9347638qve.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 10:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9lPl6Jq4cYK2gojP+93gKcsx89x6uNAQ+LS+NmqUUhU=;
        b=IQsLDxJ+1VvjHD/P7eC7cAA4v7pBTTpIKgyonX2PX42sEHf/f/SKXneXyDBIlknS2r
         oIELbxkyYWw6JbpVPgNBOFnYRlCp6Br362toJf3SCfGcztLqkclw7ACoh7fDogq4pBtK
         re+SrGOuchzjshkDeb9CSCsDa6ss5XZDFOaQphuLrxn+gKsLt2ORYD1LWoWzNdPyb9N6
         kc2zITJLABah5HoRpMLGVXN9gKAi3DTawfv9mZ9nwsKWLXRlK/EaWipM1dsdz3hkZGX5
         RR+w9/UlQwePfQyXu6ondg/qhbrne1w+wbomDMRP2AgPE/1v+Plq9RlH8qbjRrM/T6Dy
         odRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9lPl6Jq4cYK2gojP+93gKcsx89x6uNAQ+LS+NmqUUhU=;
        b=lP1ohVGL3S+s1aybYAs7g2WTT1U0pQyl4Ow1ulAKDec3Q8P0YfwlyRmhjki2taXlzN
         GuQjXB7F/49yR4mI2e+sRTl6K1yScxV4f0TvakvJmryWehecIxwIKf5Oeet5zSsQWZdO
         CdPkAHK7OoyyyfVy5hz7Jh14ODwI8HZO/BhyQs30/dKXAMhzjHQ1YkoHDLqJSO9mYA6X
         EE7u9MO7qQXcKHI73/pStpDcWXt4b7fw8cNjrYT/GxyjawlEuZAcRsW1gVzx4MSQTZI6
         2wK/ED8cdD4OHavL5XwViKqCLTFG47UxVFWP5yXhOWapnAvOT7FL4YUhz41kbpGnEolk
         HQUQ==
X-Gm-Message-State: APjAAAWFFJUNcuPDEbjXIL/KkSQ4IyFNOEH32NMA9UjHoo1hZbx52rSE
        ToJ8C+2SgnaIc+LF3DtvqR9C0w==
X-Google-Smtp-Source: APXvYqzmB2+/vCZ7yiPOaRcYDbuGKkTFb4dB7fx5MMvjqYVhbYaDdbIryOEqm0eCwEaXqsRLhNlikw==
X-Received: by 2002:a0c:dd01:: with SMTP id u1mr6637926qvk.69.1574880299262;
        Wed, 27 Nov 2019 10:44:59 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id o62sm2748024qte.76.2019.11.27.10.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 10:44:58 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, steve.capper@arm.com,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com, mark.rutland@arm.com,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com,
        sstabellini@kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, stefan@agner.ch, yamada.masahiro@socionext.com,
        xen-devel@lists.xenproject.org, linux@armlinux.org.uk
Subject: [PATCH 2/3] arm64: remove uaccess_ttbr0 asm macros from cache functions
Date:   Wed, 27 Nov 2019 13:44:52 -0500
Message-Id: <20191127184453.229321-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127184453.229321-1-pasha.tatashin@soleen.com>
References: <20191127184453.229321-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently duplicate the logic to enable/disable uaccess via TTBR0,
with C functions and assembly macros. This is a maintenenace burden
and is liable to lead to subtle bugs, so let's get rid of the assembly
macros, and always use the C functions. This requires refactoring
some assembly functions to have a C wrapper.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/asm-uaccess.h | 22 ---------------
 arch/arm64/include/asm/cacheflush.h  | 39 ++++++++++++++++++++++++--
 arch/arm64/mm/cache.S                | 41 +++++++++-------------------
 arch/arm64/mm/flush.c                |  2 +-
 4 files changed, 50 insertions(+), 54 deletions(-)

diff --git a/arch/arm64/include/asm/asm-uaccess.h b/arch/arm64/include/asm/asm-uaccess.h
index f68a0e64482a..fba2a69f7fef 100644
--- a/arch/arm64/include/asm/asm-uaccess.h
+++ b/arch/arm64/include/asm/asm-uaccess.h
@@ -34,28 +34,6 @@
 	msr	ttbr0_el1, \tmp1		// set the non-PAN TTBR0_EL1
 	isb
 	.endm
-
-	.macro	uaccess_ttbr0_disable, tmp1, tmp2
-alternative_if_not ARM64_HAS_PAN
-	save_and_disable_irq \tmp2		// avoid preemption
-	__uaccess_ttbr0_disable \tmp1
-	restore_irq \tmp2
-alternative_else_nop_endif
-	.endm
-
-	.macro	uaccess_ttbr0_enable, tmp1, tmp2, tmp3
-alternative_if_not ARM64_HAS_PAN
-	save_and_disable_irq \tmp3		// avoid preemption
-	__uaccess_ttbr0_enable \tmp1, \tmp2
-	restore_irq \tmp3
-alternative_else_nop_endif
-	.endm
-#else
-	.macro	uaccess_ttbr0_disable, tmp1, tmp2
-	.endm
-
-	.macro	uaccess_ttbr0_enable, tmp1, tmp2, tmp3
-	.endm
 #endif
 
 #endif
diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index 665c78e0665a..c0b265e12d9d 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -61,16 +61,49 @@
  *		- kaddr  - page address
  *		- size   - region size
  */
-extern void __flush_icache_range(unsigned long start, unsigned long end);
-extern int  invalidate_icache_range(unsigned long start, unsigned long end);
+extern void __asm_flush_icache_range(unsigned long start, unsigned long end);
+extern long __asm_flush_cache_user_range(unsigned long start,
+					 unsigned long end);
+extern int  asm_invalidate_icache_range(unsigned long start,
+					unsigned long end);
 extern void __flush_dcache_area(void *addr, size_t len);
 extern void __inval_dcache_area(void *addr, size_t len);
 extern void __clean_dcache_area_poc(void *addr, size_t len);
 extern void __clean_dcache_area_pop(void *addr, size_t len);
 extern void __clean_dcache_area_pou(void *addr, size_t len);
-extern long __flush_cache_user_range(unsigned long start, unsigned long end);
 extern void sync_icache_aliases(void *kaddr, unsigned long len);
 
+static inline void __flush_icache_range(unsigned long start, unsigned long end)
+{
+	uaccess_ttbr0_enable();
+	__asm_flush_icache_range(start, end);
+	uaccess_ttbr0_disable();
+}
+
+static inline void __flush_cache_user_range(unsigned long start,
+					    unsigned long end)
+{
+	uaccess_ttbr0_enable();
+	__asm_flush_cache_user_range(start, end);
+	uaccess_ttbr0_disable();
+}
+
+static inline int invalidate_icache_range(unsigned long start,
+					  unsigned long end)
+{
+	int rv;
+
+	if (cpus_have_const_cap(ARM64_HAS_CACHE_DIC)) {
+		isb();
+		return 0;
+	}
+	uaccess_ttbr0_enable();
+	rv = asm_invalidate_icache_range(start, end);
+	uaccess_ttbr0_disable();
+
+	return rv;
+}
+
 static inline void flush_icache_range(unsigned long start, unsigned long end)
 {
 	__flush_icache_range(start, end);
diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index db767b072601..a48b6dba304e 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -15,7 +15,7 @@
 #include <asm/asm-uaccess.h>
 
 /*
- *	flush_icache_range(start,end)
+ *	__asm_flush_icache_range(start,end)
  *
  *	Ensure that the I and D caches are coherent within specified region.
  *	This is typically used when code has been written to a memory region,
@@ -24,11 +24,11 @@
  *	- start   - virtual start address of region
  *	- end     - virtual end address of region
  */
-ENTRY(__flush_icache_range)
+ENTRY(__asm_flush_icache_range)
 	/* FALLTHROUGH */
 
 /*
- *	__flush_cache_user_range(start,end)
+ *	__asm_flush_cache_user_range(start,end)
  *
  *	Ensure that the I and D caches are coherent within specified region.
  *	This is typically used when code has been written to a memory region,
@@ -37,8 +37,7 @@ ENTRY(__flush_icache_range)
  *	- start   - virtual start address of region
  *	- end     - virtual end address of region
  */
-ENTRY(__flush_cache_user_range)
-	uaccess_ttbr0_enable x2, x3, x4
+ENTRY(__asm_flush_cache_user_range)
 alternative_if ARM64_HAS_CACHE_IDC
 	dsb	ishst
 	b	7f
@@ -60,41 +59,27 @@ alternative_if ARM64_HAS_CACHE_DIC
 alternative_else_nop_endif
 	invalidate_icache_by_line x0, x1, x2, x3, 9f
 8:	mov	x0, #0
-1:
-	uaccess_ttbr0_disable x1, x2
-	ret
-9:
-	mov	x0, #-EFAULT
+1:	ret
+9:	mov	x0, #-EFAULT
 	b	1b
-ENDPROC(__flush_icache_range)
-ENDPROC(__flush_cache_user_range)
+ENDPROC(__asm_flush_icache_range)
+ENDPROC(__asm_flush_cache_user_range)
 
 /*
- *	invalidate_icache_range(start,end)
+ *	asm_invalidate_icache_range(start,end)
  *
  *	Ensure that the I cache is invalid within specified region.
  *
  *	- start   - virtual start address of region
  *	- end     - virtual end address of region
  */
-ENTRY(invalidate_icache_range)
-alternative_if ARM64_HAS_CACHE_DIC
-	mov	x0, xzr
-	isb
-	ret
-alternative_else_nop_endif
-
-	uaccess_ttbr0_enable x2, x3, x4
-
+ENTRY(asm_invalidate_icache_range)
 	invalidate_icache_by_line x0, x1, x2, x3, 2f
 	mov	x0, xzr
-1:
-	uaccess_ttbr0_disable x1, x2
-	ret
-2:
-	mov	x0, #-EFAULT
+1:	ret
+2:	mov	x0, #-EFAULT
 	b	1b
-ENDPROC(invalidate_icache_range)
+ENDPROC(asm_invalidate_icache_range)
 
 /*
  *	__flush_dcache_area(kaddr, size)
diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index ac485163a4a7..b23f34d23f31 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -75,7 +75,7 @@ EXPORT_SYMBOL(flush_dcache_page);
 /*
  * Additional functions defined in assembly.
  */
-EXPORT_SYMBOL(__flush_icache_range);
+EXPORT_SYMBOL(__asm_flush_icache_range);
 
 #ifdef CONFIG_ARCH_HAS_PMEM_API
 void arch_wb_cache_pmem(void *addr, size_t size)
-- 
2.24.0

