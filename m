Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F37EC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 21:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 304022464E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 21:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="OrYEDSt9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgABVOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 16:14:10 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:42030 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgABVOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 16:14:08 -0500
Received: by mail-qv1-f66.google.com with SMTP id dc14so15485110qvb.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 13:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=DSu775/r8r2Tkmehdmqp98rpWAvc+FGMQ75JxAM97Qk=;
        b=OrYEDSt9+5eRFaPFkWqZfdDPoX8oBOMKWIx5RN37UsN5RKyL+QI/bFCjKt/9bYqTwb
         cGAKt4VFDzZWzGI8HGRlHNOOm51h9iKkmHQLaQ+ZGeK0srrJ9d1XGb/S8Iur7VBkcQxI
         MyCi32PMGR+VJwl5o/HPoHX+4mEo6v21yZPg0Yozv/0f4RoeG/gKdK1GTUm1zsmp1IzG
         Oij+HSsTiiV/BYAwNB6O6q5MrhW0WnE1lSlIG0HBRmZTt/xuarTCeW5+SFsx5RxgQYpN
         EROSSyM7QLIWulE8Z34ge0x3MEAOAjIJngvTC8mpdtwXVyRogdKoqDe3A2BMBnsEiOqS
         bEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=DSu775/r8r2Tkmehdmqp98rpWAvc+FGMQ75JxAM97Qk=;
        b=mIN5Cz012rW9vS9oGqCCYyJ2qzGoXpNiaSkWPoz+suM35ntLnikIgAq2Umj7BVMulu
         eoCb3bPynVonLZT/aS+ulXctiBvTQXiNNCuleLHvQanxp5i8n/8daODXsMlhVwVN6iCK
         9OLPUbmARHuyW/+lJ55UqcpQ+gj37bwCjODIj9KIz0mtP0fdocFrHx6edrGP67zmdkaK
         ObvPPxHvBGUb6LkaPnFra6WhtBqUbKeUaylr73XkMwRKNJl2tHZ6XdRl6IN80D0g63T4
         WKm2NM4QPcyftdy4h4Wy65xv4tX0TLKzMs9VZjATxJebgG3Cx9xBV81i5Yw7ol2qvWxt
         9y0w==
X-Gm-Message-State: APjAAAVSZRiZe4h/MtldUmyWsyFtTXBTQAisEg6XJYQeGT19reB3Q1XF
        rK7KjPQPxe+pIgqWcrQuGNny3w==
X-Google-Smtp-Source: APXvYqwxDCRcHnwDHHB6fG/rrbyOkgBibEXX240FPR8z4mLL8J0UkjGCVHk+Ow7I/qMA/mj7d2MLrg==
X-Received: by 2002:a05:6214:146e:: with SMTP id c14mr65985808qvy.82.1577999647488;
        Thu, 02 Jan 2020 13:14:07 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id f97sm17384185qtb.18.2020.01.02.13.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 13:14:06 -0800 (PST)
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
Subject: [PATCH v5 4/6] arm64: remove __asm_flush_icache_range
Date:   Thu,  2 Jan 2020 16:13:55 -0500
Message-Id: <20200102211357.8042-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200102211357.8042-1-pasha.tatashin@soleen.com>
References: <20200102211357.8042-1-pasha.tatashin@soleen.com>
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
index cb00c61e0bde..047af338ba15 100644
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
@@ -87,9 +86,7 @@ static inline long __flush_cache_user_range(unsigned long start,
 
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
2.17.1

