Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDBCC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 23:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2351522522
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 23:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="i1g8jJxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbfLDXVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 18:21:16 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35599 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbfLDXVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 18:21:12 -0500
Received: by mail-qk1-f195.google.com with SMTP id v23so1699414qkg.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 15:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZHIYboDwl4EWd97Tklkdkm+url9a5Lp8rxT6bERrC+M=;
        b=i1g8jJxL0yaISsSkQcVG1T+YRVLPQorkORTVckOF1ul4UmdgjxetevbONnxu7GHHR6
         WXK96ycRVB4k6ym6P0dlJ6VstgCOx1UZBEAX/OKcv1s2MPsWxgrk5CYfyx4cV6pd9Bw5
         jUsEz55BdSZdY6HhBAwTU4pjFn1ewPD8PlkxMk6lZhxQkCzDxJaV1DXZuXgeL6O172ce
         zJ2PNOb2JKEKgzLuvO8xUfDa7vPnEm7mX+/dOykrVC8c2EX4Wux0z26m27bI2YNOPLNh
         oAQa/+PV4LAQAqd/k1eK3LpIC4vlgv+RQN+BcKlhvKmUX7V+YJHfxJL87xtqtSABCsrW
         1OWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZHIYboDwl4EWd97Tklkdkm+url9a5Lp8rxT6bERrC+M=;
        b=kHtl6GNBFmGSfAlh5jCRwvWC0vIXm8JbjwmQlpagVk6GibwU8s0+1goHmU/lJXMqlD
         AyFofmiDtIx7KkjxaEwgZ7wOdRSNRFk4W3Uo2ZedMB38B6afTMsFnLRx+ulhkdn+iNeo
         DeL8zMmTlw6gi/zo5E7hlv++dGD7SmrR9lLGhS7jI5jiwlhHppuO7I6l1793bq7xlNp3
         GVjOKYFODGfU+lsTVTgpdCQMAoKKFR4oxuWC71rS2Ft5XYDuh8ZAzNe+xAx7eCKSa7zf
         k+150Ta6j7OTI6bak2ma7nrnWeoQBQE8w6cun7hsamXJBTrlHyZNVWcORNNx+X4zmfgz
         N9bw==
X-Gm-Message-State: APjAAAUob0rALUdP5wuWucILiugoMPHkTbuj0ZzrOL1Lm0vhlDMazBBJ
        gNqliTsIBuie5eJSPL+CjIbAOg==
X-Google-Smtp-Source: APXvYqyth5Vky9Sws+q1XOgIKaCf88qENA0eXdBaqBMhh1L+UlvBd0q1SnZjvczRgcyocJAH0Tk8+g==
X-Received: by 2002:a37:6691:: with SMTP id a139mr5530912qkc.393.1575501671951;
        Wed, 04 Dec 2019 15:21:11 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id t38sm4667864qta.78.2019.12.04.15.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 15:21:11 -0800 (PST)
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
Subject: [PATCH v4 6/6] arm64: remove the rest of asm-uaccess.h
Date:   Wed,  4 Dec 2019 18:20:58 -0500
Message-Id: <20191204232058.2500117-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204232058.2500117-1-pasha.tatashin@soleen.com>
References: <20191204232058.2500117-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __uaccess_ttbr0_disable and __uaccess_ttbr0_enable,
are the last two macros defined in asm-uaccess.h.

For now move them to entry.S where they are used. Eventually,
these macros should be replaced with C wrappers to reduce the
maintenance burden.

Also, once these macros are unified with the C counterparts, it
is a good idea to check that PAN is in correct state on every
enable/disable calls.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/asm-uaccess.h | 39 ----------------------------
 arch/arm64/kernel/entry.S            | 27 ++++++++++++++++++-
 arch/arm64/lib/clear_user.S          |  2 +-
 arch/arm64/lib/copy_from_user.S      |  2 +-
 arch/arm64/lib/copy_in_user.S        |  2 +-
 arch/arm64/lib/copy_to_user.S        |  2 +-
 arch/arm64/mm/cache.S                |  1 -
 7 files changed, 30 insertions(+), 45 deletions(-)
 delete mode 100644 arch/arm64/include/asm/asm-uaccess.h

diff --git a/arch/arm64/include/asm/asm-uaccess.h b/arch/arm64/include/asm/asm-uaccess.h
deleted file mode 100644
index fba2a69f7fef..000000000000
--- a/arch/arm64/include/asm/asm-uaccess.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_ASM_UACCESS_H
-#define __ASM_ASM_UACCESS_H
-
-#include <asm/alternative.h>
-#include <asm/kernel-pgtable.h>
-#include <asm/mmu.h>
-#include <asm/sysreg.h>
-#include <asm/assembler.h>
-
-/*
- * User access enabling/disabling macros.
- */
-#ifdef CONFIG_ARM64_SW_TTBR0_PAN
-	.macro	__uaccess_ttbr0_disable, tmp1
-	mrs	\tmp1, ttbr1_el1			// swapper_pg_dir
-	bic	\tmp1, \tmp1, #TTBR_ASID_MASK
-	sub	\tmp1, \tmp1, #RESERVED_TTBR0_SIZE	// reserved_ttbr0 just before swapper_pg_dir
-	msr	ttbr0_el1, \tmp1			// set reserved TTBR0_EL1
-	isb
-	add	\tmp1, \tmp1, #RESERVED_TTBR0_SIZE
-	msr	ttbr1_el1, \tmp1		// set reserved ASID
-	isb
-	.endm
-
-	.macro	__uaccess_ttbr0_enable, tmp1, tmp2
-	get_current_task \tmp1
-	ldr	\tmp1, [\tmp1, #TSK_TI_TTBR0]	// load saved TTBR0_EL1
-	mrs	\tmp2, ttbr1_el1
-	extr    \tmp2, \tmp2, \tmp1, #48
-	ror     \tmp2, \tmp2, #16
-	msr	ttbr1_el1, \tmp2		// set the active ASID
-	isb
-	msr	ttbr0_el1, \tmp1		// set the non-PAN TTBR0_EL1
-	isb
-	.endm
-#endif
-
-#endif
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 583f71abbe98..446d90ab31af 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -22,8 +22,8 @@
 #include <asm/mmu.h>
 #include <asm/processor.h>
 #include <asm/ptrace.h>
+#include <asm/kernel-pgtable.h>
 #include <asm/thread_info.h>
-#include <asm/asm-uaccess.h>
 #include <asm/unistd.h>
 
 /*
@@ -143,6 +143,31 @@ alternative_cb_end
 #endif
 	.endm
 
+#ifdef CONFIG_ARM64_SW_TTBR0_PAN
+	.macro	__uaccess_ttbr0_disable, tmp1
+	mrs	\tmp1, ttbr1_el1		// swapper_pg_dir
+	bic	\tmp1, \tmp1, #TTBR_ASID_MASK
+	sub	\tmp1, \tmp1, #RESERVED_TTBR0_SIZE // reserved_ttbr0 just before swapper_pg_dir
+	msr	ttbr0_el1, \tmp1		// set reserved TTBR0_EL1
+	isb
+	add	\tmp1, \tmp1, #RESERVED_TTBR0_SIZE
+	msr	ttbr1_el1, \tmp1		// set reserved ASID
+	isb
+	.endm
+
+	.macro	__uaccess_ttbr0_enable, tmp1, tmp2
+	get_current_task \tmp1
+	ldr	\tmp1, [\tmp1, #TSK_TI_TTBR0]	// load saved TTBR0_EL1
+	mrs	\tmp2, ttbr1_el1
+	extr	\tmp2, \tmp2, \tmp1, #48
+	ror	\tmp2, \tmp2, #16
+	msr	ttbr1_el1, \tmp2		// set the active ASID
+	isb
+	msr	ttbr0_el1, \tmp1		// set the non-PAN TTBR0_EL1
+	isb
+	.endm
+#endif
+
 	.macro	kernel_entry, el, regsize = 64
 	.if	\regsize == 32
 	mov	w0, w0				// zero upper 32 bits of x0
diff --git a/arch/arm64/lib/clear_user.S b/arch/arm64/lib/clear_user.S
index aeafc03e961a..b0b4a86a09e2 100644
--- a/arch/arm64/lib/clear_user.S
+++ b/arch/arm64/lib/clear_user.S
@@ -6,7 +6,7 @@
  */
 #include <linux/linkage.h>
 
-#include <asm/asm-uaccess.h>
+#include <asm/alternative.h>
 #include <asm/assembler.h>
 
 	.text
diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
index ebb3c06cbb5d..142bc7505518 100644
--- a/arch/arm64/lib/copy_from_user.S
+++ b/arch/arm64/lib/copy_from_user.S
@@ -5,7 +5,7 @@
 
 #include <linux/linkage.h>
 
-#include <asm/asm-uaccess.h>
+#include <asm/alternative.h>
 #include <asm/assembler.h>
 #include <asm/cache.h>
 
diff --git a/arch/arm64/lib/copy_in_user.S b/arch/arm64/lib/copy_in_user.S
index 3d8153a1ebce..04dc48ca26f7 100644
--- a/arch/arm64/lib/copy_in_user.S
+++ b/arch/arm64/lib/copy_in_user.S
@@ -7,7 +7,7 @@
 
 #include <linux/linkage.h>
 
-#include <asm/asm-uaccess.h>
+#include <asm/alternative.h>
 #include <asm/assembler.h>
 #include <asm/cache.h>
 
diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
index 357eae2c18eb..8f3218ae88ab 100644
--- a/arch/arm64/lib/copy_to_user.S
+++ b/arch/arm64/lib/copy_to_user.S
@@ -5,7 +5,7 @@
 
 #include <linux/linkage.h>
 
-#include <asm/asm-uaccess.h>
+#include <asm/alternative.h>
 #include <asm/assembler.h>
 #include <asm/cache.h>
 
diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index 0093bb9fcd12..627be857b8d0 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -12,7 +12,6 @@
 #include <asm/assembler.h>
 #include <asm/cpufeature.h>
 #include <asm/alternative.h>
-#include <asm/asm-uaccess.h>
 
 /*
  *	__asm_flush_cache_user_range(start,end)
-- 
2.24.0

