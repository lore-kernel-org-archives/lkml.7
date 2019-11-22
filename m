Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE41C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 02:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82F520692
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 02:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="kwnVkpxG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfKVCYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 21:24:21 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45931 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfKVCYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 21:24:14 -0500
Received: by mail-qk1-f194.google.com with SMTP id q70so4955118qke.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 18:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Vc6oPAqmMqVCIczgKwZs+8hK0w4omxkwGTKIqDEJ73U=;
        b=kwnVkpxGQoCtsJNASNIZDVDRzn/vp16uisiSxJCrDZMvkgMG+MsqKetS8v4OgzSilK
         4JvYSVEyU7KrZTJYLt+1IrdKcb1VCPHZQhGChvWCXi8Ukw1Xkjv0RenuU3sCy7l5LbeK
         nxdquDRZNLmOq9URwEGMSpS+E+mDwSF7nrgFHyzxNMWBosn1GMIP0ztA8BRYlCJA/Wgl
         cZ7QPRe0j6941FI0Yi8wSCtbC3KYyf//tsPi5eBL7gUPWkir5axoF1VQX2NXzWTfgmDX
         TOuRq+q5Jp6n3+ZZs4yMyiG4KSPUHgNWiBcCY2ydi7yle4vEaHPGt4M0l6PbpaiY3sMZ
         SkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vc6oPAqmMqVCIczgKwZs+8hK0w4omxkwGTKIqDEJ73U=;
        b=B9nd+DwyatI/hBFOMaK3SeuuOHFyS+c4iJKLe2CVSNFi/YGKkegs5XCXtJN7tVHZ8h
         V2r3KmwL1OZ1WNGkvWXWpJKENGAg3JYZ7PF6Ybu2XsQKcP8IrXhFeWE5PMMypJggL0YS
         buxTNfImmyXGDzBxexIo6Eug7VkB/H70guJHirEuslJIoRvQHDiBhUf8BHY8tJnDGaKr
         JWbXc6XfkgKHZJt30H3YtuVZz/XaThew6THSBSP9M1YjUg/dE0WhDpLb60hiPADwdU26
         /pWRjAHcQqL9OcivQxA0ssTz0Ata/PipL18eb7cp5FqrlmAwt407Z01gqec/GROYVvZ7
         9cRA==
X-Gm-Message-State: APjAAAWm7VKwZbC0aXlnm36Mg1tlEzt5PhHDASwG4SkVyF2sJxsRpXQb
        f8Jr1jJBOqvj0wORgRpfcB8AhQ==
X-Google-Smtp-Source: APXvYqzJF3qnLMfzHgSwlWYs/UJk7GCvCnhv4oTIwSXg5D3daIPC/puS357rga4cHnfLQ3u54qVatw==
X-Received: by 2002:a05:620a:219b:: with SMTP id g27mr2734759qka.137.1574389453243;
        Thu, 21 Nov 2019 18:24:13 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id z5sm2609801qtm.9.2019.11.21.18.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 18:24:12 -0800 (PST)
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
Subject: [PATCH v2 3/3] arm64: remove the rest of asm-uaccess.h
Date:   Thu, 21 Nov 2019 21:24:06 -0500
Message-Id: <20191122022406.590141-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122022406.590141-1-pasha.tatashin@soleen.com>
References: <20191122022406.590141-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __uaccess_ttbr0_disable and __uaccess_ttbr0_enable,
are the last two macros defined in asm-uaccess.h.

Replace them with C wrappers and call C functions from
kernel_entry and kernel_exit.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/asm-uaccess.h | 38 ----------------------------
 arch/arm64/kernel/entry.S            |  6 ++---
 arch/arm64/lib/clear_user.S          |  2 +-
 arch/arm64/lib/copy_from_user.S      |  2 +-
 arch/arm64/lib/copy_in_user.S        |  2 +-
 arch/arm64/lib/copy_to_user.S        |  2 +-
 arch/arm64/mm/cache.S                |  1 -
 arch/arm64/mm/context.c              | 12 +++++++++
 8 files changed, 19 insertions(+), 46 deletions(-)
 delete mode 100644 arch/arm64/include/asm/asm-uaccess.h

diff --git a/arch/arm64/include/asm/asm-uaccess.h b/arch/arm64/include/asm/asm-uaccess.h
deleted file mode 100644
index 8f763e5b41b1..000000000000
--- a/arch/arm64/include/asm/asm-uaccess.h
+++ /dev/null
@@ -1,38 +0,0 @@
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
-#endif
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 583f71abbe98..c7b571e6d0f2 100644
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
@@ -219,7 +219,7 @@ alternative_else_nop_endif
 	and	x23, x23, #~PSR_PAN_BIT		// Clear the emulated PAN in the saved SPSR
 	.endif
 
-	__uaccess_ttbr0_disable x21
+	bl __uaccess_ttbr0_disable_c
 1:
 #endif
 
@@ -293,7 +293,7 @@ alternative_else_nop_endif
 	tbnz	x22, #22, 1f			// Skip re-enabling TTBR0 access if the PSR_PAN_BIT is set
 	.endif
 
-	__uaccess_ttbr0_enable x0, x1
+	bl	__uaccess_ttbr0_enable_c
 
 	.if	\el == 0
 	/*
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
index 408d317a47d2..7940d6ef5da5 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -12,7 +12,6 @@
 #include <asm/assembler.h>
 #include <asm/cpufeature.h>
 #include <asm/alternative.h>
-#include <asm/asm-uaccess.h>
 
 /*
  *	__arch_flush_icache_range(start,end)
diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index b5e329fde2dd..4fc32c504dea 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -237,6 +237,18 @@ void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
 		cpu_switch_mm(mm->pgd, mm);
 }
 
+#ifdef CONFIG_ARM64_SW_TTBR0_PAN
+asmlinkage void __uaccess_ttbr0_enable_c(void)
+{
+	__uaccess_ttbr0_enable();
+}
+
+asmlinkage void __uaccess_ttbr0_disable_c(void)
+{
+	__uaccess_ttbr0_disable();
+}
+#endif
+
 /* Errata workaround post TTBRx_EL1 update. */
 asmlinkage void post_ttbr_update_workaround(void)
 {
-- 
2.24.0

