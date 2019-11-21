Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46F0C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37C9206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="D8TF57oZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfKUSsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 13:48:18 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42371 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfKUSsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 13:48:12 -0500
Received: by mail-qt1-f195.google.com with SMTP id t20so4808132qtn.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 10:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HgQtjc5acLHzjiwVf/zPdL0W3rJRgxp/Mq6B1WIDDxY=;
        b=D8TF57oZonJsJ7ptNQX1Oql+1bGPweH7IQDgGXFghl6XLlpJMfByo9jtn6lWNVKneh
         s2cJgTr1kQWATQJrBvnkf95d+I3h7dwVBG/raggpy0IJob7OGHVHg9IPdtDdarosd954
         KFR3q4XmVCuDk6cTsFQy47BxZ22+ZDDQIEsZIop543H+GCFV/vAHhe7jJIwfww5UYbL5
         Gs9GL4HTjVd2fG46M2jukbPbRS4huhvRfKChueNRZEhzrnriSSgwr01jRIkK+k34OPaf
         xGvsJeSVsHNnl3tY0THdt6/yxjIzUUj/KIQb1SVBDN0kj4MtWe+F1Muehw4EuSxPRpXX
         0l4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HgQtjc5acLHzjiwVf/zPdL0W3rJRgxp/Mq6B1WIDDxY=;
        b=nzm2MiDhrD82ZUtz6QRl+3VxeWOQrcBZCnJ4zvQP3TYa24vhkn9pg6A8o6fO117mDX
         FJ0Fb7c0J+ahNUhLUd7+t8sFLeZyjb/8z9YGjTHHZHjql3CuveB0gl3T6xD4iZX3RhX9
         J/+v4cTyDWcNDKzByLXAPZGX06ggbeFQa3a0L+NO1NeHFlp2Xi6icnqfflefMAM2JovH
         Rj5tIujuAYze6fTE+Eq52fpA7KDMJPoMEo1QP40NdgXGTGzNk0TsBkbXlMuR1rrxj1GT
         ItMCIFqlTOgGRXzi3OFr8qoJDwVL+sFc3KlyIYNrbGbLG+9nBQdRLFLfjE2yBSbO/bs3
         XuwA==
X-Gm-Message-State: APjAAAUAKEO6JCFEWc5rDoLAvZAgVM/RXNyHBZqeXaWi2Jz9LUwiz9EP
        FydbVyBNmuRca8ecFrcNkHxNQg==
X-Google-Smtp-Source: APXvYqyC5mwODRFAu6hCA10XUD/HEGjTmVXQZnPp2NesFrAjEuQLsTPPaA4uJEbcoHdfWmybnns7cA==
X-Received: by 2002:ac8:7444:: with SMTP id h4mr10138097qtr.102.1574362091132;
        Thu, 21 Nov 2019 10:48:11 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id t2sm1811634qkt.95.2019.11.21.10.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 10:48:10 -0800 (PST)
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
Date:   Thu, 21 Nov 2019 13:48:04 -0500
Message-Id: <20191121184805.414758-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191121184805.414758-1-pasha.tatashin@soleen.com>
References: <20191121184805.414758-1-pasha.tatashin@soleen.com>
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

