Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5227C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 21:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B33217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 21:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ASVWYtcu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgABVOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 16:14:08 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:32960 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgABVOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 16:14:06 -0500
Received: by mail-qt1-f193.google.com with SMTP id d5so35583664qto.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 13:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=OGOfxfwChenCUUYWwVx63kTdDOJ5xGJqR8SyGhsE/0o=;
        b=ASVWYtcuY5JgNsB9AmozFOaf3IagjfA7LG3Kld7VSh0wYdUywlMDvMCo/I8a8oS5Zo
         iFquKkCITUBqnTv97Xw9a4spOa16Ao90LXXcKxSco8vKrPptHC6t48IMitnpndg5KWwX
         5rFUdBFejur9ImoKK+WQFhdw+wJcf5cNhI8CGlMrDDUNKcCB2W7OWG3ipnFtsga7Aqaw
         GXE6e6Y2Uag5Xdz5iQSfJJkoxlqtFdLDAw8cdgiGekyjuc06GpLIG0PGd78mI8UIVx2d
         yUg+045k3AZZGpxH8hyN6yQ52VCHgdxjIbPXYY2MwMroUxCwBur7C1ZK7AE0k5sYjaXK
         yJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=OGOfxfwChenCUUYWwVx63kTdDOJ5xGJqR8SyGhsE/0o=;
        b=C5HCi7LWejuNSS2DqNDuAoqTNFKiH1QiLwMrlVQSbym2PeHUzlkvj2hPt4tMmNsWft
         dOpgaPTfdR0CGNVMydmlilg6P4TxI2XAOkMc2WKPASjoar7oYdzHi1a2/TtCx1EhTIuh
         PiypaFWGeHjDd8uC5z1gs0lJsBuSZK5tenFYLhZqO+IJgTs616LSdtIXhZ6OcVnLlN5E
         lqHaCBFfGVUs2v30tWcpOBXrOtwCN1XUU4ejjboiRC1YwjqQz0GdkhBW6U7cArmXSayl
         6IxKYP2vNaTUrxfoVJl2DxzyR6xeCRMewxquu5zgf7WK67HnZFSBvd1rla6liPfYgz7Y
         s1Wg==
X-Gm-Message-State: APjAAAWTLNsgrfVBdZrihy1gkJf8bd+JNXFHbLWjxmcDqdhHCu/hqfy/
        mZjk/WrF1W0l7ZfTT0U3ch7Yqg==
X-Google-Smtp-Source: APXvYqw7yHNZGnj4/bjHHjA907ucWBhe02hvFPT3nG+AplQbPkSo5eatsNyv95qLjtjyuw+nv2SNWQ==
X-Received: by 2002:ac8:410f:: with SMTP id q15mr61226584qtl.192.1577999645574;
        Thu, 02 Jan 2020 13:14:05 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id f97sm17384185qtb.18.2020.01.02.13.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 13:14:04 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, steve.capper@arm.com,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com, mark.rutland@arm.com,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com,
        sstabellini@kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, stefan@agner.ch, yamada.masahiro@socionext.com,
        xen-devel@lists.xenproject.org, linux@armlinux.org.uk,
        andrew.cooper3@citrix.com, julien@xen.org
Subject: [PATCH v5 3/6] arm64: remove uaccess_ttbr0 asm macros from cache functions
Date:   Thu,  2 Jan 2020 16:13:54 -0500
Message-Id: <20200102211357.8042-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200102211357.8042-1-pasha.tatashin@soleen.com>
References: <20200102211357.8042-1-pasha.tatashin@soleen.com>
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
 arch/arm64/include/asm/asm-uaccess.h | 22 ----------------
 arch/arm64/include/asm/cacheflush.h  | 39 +++++++++++++++++++++++++---
 arch/arm64/mm/cache.S                | 36 ++++++++++---------------
 arch/arm64/mm/flush.c                |  2 +-
 4 files changed, 50 insertions(+), 49 deletions(-)

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
index 665c78e0665a..cb00c61e0bde 100644
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
+extern int  __asm_invalidate_icache_range(unsigned long start,
+					  unsigned long end);
 extern void __flush_dcache_area(void *addr, size_t len);
 extern void __inval_dcache_area(void *addr, size_t len);
 extern void __clean_dcache_area_poc(void *addr, size_t len);
 extern void __clean_dcache_area_pop(void *addr, size_t len);
 extern void __clean_dcache_area_pou(void *addr, size_t len);
-extern long __flush_cache_user_range(unsigned long start, unsigned long end);
 extern void sync_icache_aliases(void *kaddr, unsigned long len);
 
+static inline long __flush_cache_user_range(unsigned long start,
+					    unsigned long end)
+{
+	int ret;
+
+	uaccess_ttbr0_enable();
+	ret = __asm_flush_cache_user_range(start, end);
+	uaccess_ttbr0_disable();
+
+	return ret;
+}
+
+static inline void __flush_icache_range(unsigned long start, unsigned long end)
+{
+	uaccess_ttbr0_enable();
+	__asm_flush_icache_range(start, end);
+	uaccess_ttbr0_disable();
+}
+
+static inline int invalidate_icache_range(unsigned long start,
+					  unsigned long end)
+{
+	int ret;
+
+	uaccess_ttbr0_enable();
+	ret = __asm_invalidate_icache_range(start, end);
+	uaccess_ttbr0_disable();
+
+	return ret;
+}
+
 static inline void flush_icache_range(unsigned long start, unsigned long end)
 {
 	__flush_icache_range(start, end);
diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index db767b072601..602b9aa8603a 100644
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
@@ -60,41 +59,32 @@ alternative_if ARM64_HAS_CACHE_DIC
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
+ *	__asm_invalidate_icache_range(start,end)
  *
  *	Ensure that the I cache is invalid within specified region.
  *
  *	- start   - virtual start address of region
  *	- end     - virtual end address of region
  */
-ENTRY(invalidate_icache_range)
+ENTRY(__asm_invalidate_icache_range)
 alternative_if ARM64_HAS_CACHE_DIC
 	mov	x0, xzr
 	isb
 	ret
 alternative_else_nop_endif
-
-	uaccess_ttbr0_enable x2, x3, x4
-
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
+ENDPROC(__asm_invalidate_icache_range)
 
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
2.17.1

