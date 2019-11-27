Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDE2C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B546207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="eznVBLON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfK0SpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 13:45:04 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41303 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfK0SpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 13:45:01 -0500
Received: by mail-qk1-f193.google.com with SMTP id m125so20429483qkd.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 10:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FcqPaEmX1C8efPcruT1Ss1wL4IPrdaYzf7CQNMsgj94=;
        b=eznVBLONWH9RFdeS+JWy0FGl8QAD+vm34z6dm1k2p5zZ7HI/8kjI36VWlkWqDfubeh
         lEd78mcbZwoqmJ7F5+KAxxTIFaBL6G9fSDL8/ukeSwC810swC1cKx9/8HSV0NBoFKg9Y
         wIoaXrXkUeM4AXY49Bsoo3CAOCUB2fs01Fq7BYq1L9JH3lV+TdRn8+jEueaUdGkkk4UY
         HB/rqkhuzNEPqEkkNmO5FnRFsFjekB5xmmsdDbY4BPP94oCrK94N4kQcUAL42YPfuFt0
         1MyFLFDzOXAT5KmLPlFmxy00UWnou60rtqyNAyWi5fDUd5HVt5zlKYcp3I7NjXNzN3r5
         FlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FcqPaEmX1C8efPcruT1Ss1wL4IPrdaYzf7CQNMsgj94=;
        b=mPTMw98Bt99iSeTBywSi5qj9TP2AsxaFo6dhUcC7uo0VSXhNtohFPZY2bod7wPIBlc
         culXu1ck7DbLOo90CmAiCal2/8gBq4aixSjEfKN6hy0xcc+IlI2TKObiQERBsFKKcuj8
         bPT9B1ZTwgi0QjDHQckEyFCOYdmrNG8gSyM1DYKDimUbtep+nGzr1BRqyd8iTfz8a+tE
         +D8Is4qQzAjfcKpUknhGKrXtvdRlkN40MuAXVPRhBXqiLxtYQd+auIlEWut6j68w4lQJ
         SyPpAQG7I/WYfTZhxuwslBqnhLuBAPNub8SeoKpvcf0jSYzJ11TuMd6fP0IUbyAw/Be+
         poqA==
X-Gm-Message-State: APjAAAVqP5ykY4jNevaShfbEho8DO1Wcw7AEgRgc80UHyHbPCIVZ0Ccg
        5DgC2VShljYgTwS9rEW3vCDsxg==
X-Google-Smtp-Source: APXvYqxODZjoyu3d3RGASH7OUduNJ/cZUXkrbGjWhw9cRiiL8AHlBVoF9V2wf1+s54sFfgF+kEcm/g==
X-Received: by 2002:a37:61c2:: with SMTP id v185mr6048615qkb.429.1574880300941;
        Wed, 27 Nov 2019 10:45:00 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id o62sm2748024qte.76.2019.11.27.10.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 10:45:00 -0800 (PST)
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
Subject: [PATCH 3/3] arm64: remove the rest of asm-uaccess.h
Date:   Wed, 27 Nov 2019 13:44:53 -0500
Message-Id: <20191127184453.229321-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127184453.229321-1-pasha.tatashin@soleen.com>
References: <20191127184453.229321-1-pasha.tatashin@soleen.com>
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
index a48b6dba304e..f7130c30d6e3 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -12,7 +12,6 @@
 #include <asm/assembler.h>
 #include <asm/cpufeature.h>
 #include <asm/alternative.h>
-#include <asm/asm-uaccess.h>
 
 /*
  *	__asm_flush_icache_range(start,end)
-- 
2.24.0

