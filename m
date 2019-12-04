Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDA5C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 23:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D472077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 23:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Cqr2IaSk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbfLDXVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 18:21:12 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39202 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbfLDXVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 18:21:09 -0500
Received: by mail-qk1-f194.google.com with SMTP id d124so1665285qke.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 15:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cJGBuyv8MEIEHzLn/Uzof9JuYF+NT8m3hWWPuvSYlYo=;
        b=Cqr2IaSkSM3+ylTz/1+aa0wyv0GTLmyzuvfeKqJdPU6Ym61dE8ilpQ/o6O3zLo76yG
         yWs4zxmVduoS9thvdX42Qhy/yXxpxLqmowjGfyNWNr2CrS0btzvUZX1xjS5/NQKuKc9m
         09+5SGckvzu6mOOsgNPtOpMxLWPdDl8+PqcmsBcfflKtmm4meriKJKjLOG29yS1QWciV
         0Wcks1MLbJb1W3cxbNWfbO8w7CCl3rfq/IVgDaUT9y3uk+unlYn3uMSIPYga04jFVfkX
         ZrVptH6pK0eqeK+rnhBPLi9SvwE1cFLa6IaeQSpSBwJircBHJEjEs6Y3XEWblHYg0XxR
         IQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cJGBuyv8MEIEHzLn/Uzof9JuYF+NT8m3hWWPuvSYlYo=;
        b=NT10eDrTIriWqW1DyIe9PDX/Xf4SPHIDi8XcsucBWmDRoUKkhOf4si3lQUU/qt7ySN
         LjQlOoe/7uSTm7Me3zMqdU42tGc0LpHpThVqoWxl734yasEQXRNMS5zSR2IMc2iFO4/s
         EUc1+kXjBwq9cMpDs3RzfgNZeDutfTNQ+QiFHfCE7cCqqA2NMtCs4P7mJhSJiTtZrOyi
         plKDQPU9Gk3QnOy8zfomKb1Ex6jCDkDIncxXGYgGJzaH6+V8c2sjeBQb22BhSsnQsNj2
         A8aqLdqKv7X6DMDdTyy72DIbDm4NDoMAm8i5UulnIjstx9xJbv7pbhAi1OwlHugGDEkK
         ATlA==
X-Gm-Message-State: APjAAAUpKM0tJ4PKXQ1p97ZAWweClFhR2GZ2G7LpEqkmcc9xBIcgBPRw
        qXq2UdtJYUFjKIUn2FCKUwsZNQ==
X-Google-Smtp-Source: APXvYqyIMm2ogNBIfOvl3Mqg4T1YApxStKZp5KMJvJR//w2WVxMty/nhPiOLBe4oOlxwY24OIF3FHA==
X-Received: by 2002:ae9:e115:: with SMTP id g21mr53454qkm.187.1575501668421;
        Wed, 04 Dec 2019 15:21:08 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id t38sm4667864qta.78.2019.12.04.15.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 15:21:07 -0800 (PST)
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
Subject: [PATCH v4 4/6] arm64: remove __asm_flush_icache_range
Date:   Wed,  4 Dec 2019 18:20:56 -0500
Message-Id: <20191204232058.2500117-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204232058.2500117-1-pasha.tatashin@soleen.com>
References: <20191204232058.2500117-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__asm_flush_icache_range is an alias to __asm_flush_cache_user_range,
but now that these functions are called from C wrappers the fall
through can instead be done at a higher level.

Remove the __asm_flush_icache_range alias in assembly, and instead call
__flush_cache_user_range() from __flush_icache_range().

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/cacheflush.h |  5 +----
 arch/arm64/mm/cache.S               | 14 --------------
 arch/arm64/mm/flush.c               |  2 +-
 3 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index 431f8da2dd02..ea563344b4ad 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -61,7 +61,6 @@
  *		- kaddr  - page address
  *		- size   - region size
  */
-extern void __asm_flush_icache_range(unsigned long start, unsigned long end);
 extern long __asm_flush_cache_user_range(unsigned long start,
 					 unsigned long end);
 extern int  __asm_invalidate_icache_range(unsigned long start,
@@ -83,9 +82,7 @@ static inline void __flush_cache_user_range(unsigned long start,
 
 static inline void __flush_icache_range(unsigned long start, unsigned long end)
 {
-	uaccess_ttbr0_enable();
-	__asm_flush_icache_range(start, end);
-	uaccess_ttbr0_disable();
+	__flush_cache_user_range(start, end);
 }
 
 static inline int invalidate_icache_range(unsigned long start,
diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index 602b9aa8603a..1981cbaf5d92 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -14,19 +14,6 @@
 #include <asm/alternative.h>
 #include <asm/asm-uaccess.h>
 
-/*
- *	__asm_flush_icache_range(start,end)
- *
- *	Ensure that the I and D caches are coherent within specified region.
- *	This is typically used when code has been written to a memory region,
- *	and will be executed.
- *
- *	- start   - virtual start address of region
- *	- end     - virtual end address of region
- */
-ENTRY(__asm_flush_icache_range)
-	/* FALLTHROUGH */
-
 /*
  *	__asm_flush_cache_user_range(start,end)
  *
@@ -62,7 +49,6 @@ alternative_else_nop_endif
 1:	ret
 9:	mov	x0, #-EFAULT
 	b	1b
-ENDPROC(__asm_flush_icache_range)
 ENDPROC(__asm_flush_cache_user_range)
 
 /*
diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index b23f34d23f31..61521285f27d 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -75,7 +75,7 @@ EXPORT_SYMBOL(flush_dcache_page);
 /*
  * Additional functions defined in assembly.
  */
-EXPORT_SYMBOL(__asm_flush_icache_range);
+EXPORT_SYMBOL(__asm_flush_cache_user_range);
 
 #ifdef CONFIG_ARCH_HAS_PMEM_API
 void arch_wb_cache_pmem(void *addr, size_t size)
-- 
2.24.0

