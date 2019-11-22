Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607D1C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 02:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C32B206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 02:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="NCJD76gl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfKVCYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 21:24:19 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45865 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfKVCYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 21:24:14 -0500
Received: by mail-qt1-f194.google.com with SMTP id 30so6098405qtz.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 18:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HgQtjc5acLHzjiwVf/zPdL0W3rJRgxp/Mq6B1WIDDxY=;
        b=NCJD76glok7tVpPWeRPMFMOTsJyN4W7x2c/GCYOWTwrHjqgkhGGyM4V97AkUHi7MJ8
         KGTYQXByuaFA/HeJ/VPbTjcCKJ1GKPTm/770K7AeT6xPogT8ulU3rOP9qd11J7e3lcP1
         QpEXRRxNPL/pyJn7e5Km8+UTwxnuBqX2xB6z45Aodil6sdu5WtiHlqtHjexiVH9xBs9h
         zn9vt/ZcjNmX4zQzavX5aYNETygv+Fy21dmaPT6M8AV/hr7nhpf+0pCuDj86VttXSygY
         B+SFKXJNsZUDaDYm066fXl8fGA4gF2/m3CEO9ntre4m2w/kNPPa7QP6LMBMl3WSEEyFs
         xtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HgQtjc5acLHzjiwVf/zPdL0W3rJRgxp/Mq6B1WIDDxY=;
        b=DFWB23Pw29qaAdVWSWBGwHKzjeHE6hSPfZX74IL0OmUIucIBVHQwDy1x8dprd8sYJk
         WLiQfnB8ZMw+VR3xvdhliODXgISAOQ0S2YjTp7nkKKK0x8Rw4whfO+APA6ekhTVeIvWS
         Rh842AR46wy68HDdU7k/p0y11tSO8xo/T4sULbTwuG69+3U4jsHP0+3bEWGnDhPzmgZB
         PdP+/IRxC+KJrzY1TC54gzna5j8ALUXhs1VJ71NgOHh8UNANAD5n49mODiCGtOYr4eDB
         nAV1GYPK3CJCifRTom35M7Ie2thncBmjzsifoxNlq1a45XyOI+H372i6tbY1Es61OYXX
         P5lQ==
X-Gm-Message-State: APjAAAXz4wzOUkDEaUFwySgIKbD0byIsGWmObVCdbOL4sscFtTas4gGv
        ZUXjhslZFhAHjLdLrfPOWb/zpQ==
X-Google-Smtp-Source: APXvYqyII7bwvpdPFvB1uClYqq9YlCH8qAJI5DdRg1eAxlpjXNOJ/Xqjeo/s4oaH3hLXKnjnqntnXg==
X-Received: by 2002:ac8:1084:: with SMTP id a4mr12202956qtj.114.1574389451666;
        Thu, 21 Nov 2019 18:24:11 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id z5sm2609801qtm.9.2019.11.21.18.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 18:24:11 -0800 (PST)
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
Subject: [PATCH v2 2/3] arm64: remove uaccess_ttbr0 asm macros from cache functions
Date:   Thu, 21 Nov 2019 21:24:05 -0500
Message-Id: <20191122022406.590141-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122022406.590141-1-pasha.tatashin@soleen.com>
References: <20191122022406.590141-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the uaccess_ttbr0_disable/uaccess_ttbr0_enable via
inline variants, and remove asm macros.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/asm-uaccess.h | 22 ----------------
 arch/arm64/include/asm/cacheflush.h  | 38 +++++++++++++++++++++++++---
 arch/arm64/mm/cache.S                | 30 ++++++++--------------
 arch/arm64/mm/flush.c                |  2 +-
 4 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/arch/arm64/include/asm/asm-uaccess.h b/arch/arm64/include/asm/asm-uaccess.h
index 35e6145e1402..8f763e5b41b1 100644
--- a/arch/arm64/include/asm/asm-uaccess.h
+++ b/arch/arm64/include/asm/asm-uaccess.h
@@ -34,27 +34,5 @@
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
index 665c78e0665a..cdd4a8eb8708 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -61,16 +61,48 @@
  *		- kaddr  - page address
  *		- size   - region size
  */
-extern void __flush_icache_range(unsigned long start, unsigned long end);
-extern int  invalidate_icache_range(unsigned long start, unsigned long end);
+extern void __arch_flush_icache_range(unsigned long start, unsigned long end);
+extern long __arch_flush_cache_user_range(unsigned long start,
+					  unsigned long end);
+extern int  arch_invalidate_icache_range(unsigned long start,
+					 unsigned long end);
+
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
+	__arch_flush_icache_range(start, end);
+	uaccess_ttbr0_disable();
+}
+
+static inline void __flush_cache_user_range(unsigned long start,
+					    unsigned long end)
+{
+	uaccess_ttbr0_enable();
+	__arch_flush_cache_user_range(start, end);
+	uaccess_ttbr0_disable();
+}
+
+static inline int invalidate_icache_range(unsigned long start,
+					  unsigned long end)
+{
+	int rv;
+#if ARM64_HAS_CACHE_DIC
+	rv = arch_invalidate_icache_range(start, end);
+#else
+	uaccess_ttbr0_enable();
+	rv = arch_invalidate_icache_range(start, end);
+	uaccess_ttbr0_disable();
+#endif
+	return rv;
+}
+
 static inline void flush_icache_range(unsigned long start, unsigned long end)
 {
 	__flush_icache_range(start, end);
diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index db767b072601..408d317a47d2 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -15,7 +15,7 @@
 #include <asm/asm-uaccess.h>
 
 /*
- *	flush_icache_range(start,end)
+ *	__arch_flush_icache_range(start,end)
  *
  *	Ensure that the I and D caches are coherent within specified region.
  *	This is typically used when code has been written to a memory region,
@@ -24,11 +24,11 @@
  *	- start   - virtual start address of region
  *	- end     - virtual end address of region
  */
-ENTRY(__flush_icache_range)
+ENTRY(__arch_flush_icache_range)
 	/* FALLTHROUGH */
 
 /*
- *	__flush_cache_user_range(start,end)
+ *	__arch_flush_cache_user_range(start,end)
  *
  *	Ensure that the I and D caches are coherent within specified region.
  *	This is typically used when code has been written to a memory region,
@@ -37,8 +37,7 @@ ENTRY(__flush_icache_range)
  *	- start   - virtual start address of region
  *	- end     - virtual end address of region
  */
-ENTRY(__flush_cache_user_range)
-	uaccess_ttbr0_enable x2, x3, x4
+ENTRY(__arch_flush_cache_user_range)
 alternative_if ARM64_HAS_CACHE_IDC
 	dsb	ishst
 	b	7f
@@ -60,14 +59,11 @@ alternative_if ARM64_HAS_CACHE_DIC
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
+ENDPROC(__arch_flush_icache_range)
+ENDPROC(__arch_flush_cache_user_range)
 
 /*
  *	invalidate_icache_range(start,end)
@@ -83,16 +79,10 @@ alternative_if ARM64_HAS_CACHE_DIC
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
 ENDPROC(invalidate_icache_range)
 
diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index ac485163a4a7..66249fca2092 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -75,7 +75,7 @@ EXPORT_SYMBOL(flush_dcache_page);
 /*
  * Additional functions defined in assembly.
  */
-EXPORT_SYMBOL(__flush_icache_range);
+EXPORT_SYMBOL(__arch_flush_icache_range);
 
 #ifdef CONFIG_ARCH_HAS_PMEM_API
 void arch_wb_cache_pmem(void *addr, size_t size)
-- 
2.24.0

