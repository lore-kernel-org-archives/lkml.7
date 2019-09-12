Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5B5C4CEC5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 570922075C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="qSf3nUDL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732322AbfILNtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 09:49:47 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:44730 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732266AbfILNtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 09:49:45 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46Tg9y2BcKz9tynD;
        Thu, 12 Sep 2019 15:49:42 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=qSf3nUDL; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id wo9dfjP_jZ3y; Thu, 12 Sep 2019 15:49:42 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46Tg9y18Gtz9tyn0;
        Thu, 12 Sep 2019 15:49:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1568296182; bh=S5Rj/VsPllO/e67elAP3xa/DfriYgmF1nk3PLh8/2RU=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=qSf3nUDLKiLU2lBqGhyyAhITHckttWe3DqGacdZRODYCzyQ/gEjLCXajrgbmbIyi2
         7+Pf20K6FQk3+TkVuOS9qg9SbjUu2xe+21tJi5GeflaFB1anVm3RNxdjlczgEBlbw1
         kQMNRgAXS97IZdSs89QMtmKaSd7j80YxaBg8VcXQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B44EE8B93B;
        Thu, 12 Sep 2019 15:49:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id uXCJ-p7asimr; Thu, 12 Sep 2019 15:49:43 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 74CB98B933;
        Thu, 12 Sep 2019 15:49:43 +0200 (CEST)
Received: by pc16032vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 568E16B736; Thu, 12 Sep 2019 13:49:43 +0000 (UTC)
Message-Id: <412c7eaa6a373d8f82a3c3ee01e6a65a1a6589de.1568295907.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1568295907.git.christophe.leroy@c-s.fr>
References: <cover.1568295907.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 3/4] powerpc: Add support for GENERIC_EARLY_IOREMAP
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        hch@infradead.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 12 Sep 2019 13:49:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for GENERIC_EARLY_IOREMAP.

Let's define 16 slots of 256Kbytes each for early ioremap.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig              |  1 +
 arch/powerpc/include/asm/Kbuild   |  1 +
 arch/powerpc/include/asm/fixmap.h | 12 ++++++++++++
 arch/powerpc/kernel/setup_32.c    |  3 +++
 arch/powerpc/kernel/setup_64.c    |  3 +++
 5 files changed, 20 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6a7c797fa9d2..8fe252962518 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -161,6 +161,7 @@ config PPC
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_CPU_VULNERABILITIES	if PPC_BARRIER_NOSPEC
+	select GENERIC_EARLY_IOREMAP
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
 	select GENERIC_PCI_IOMAP		if PCI
diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
index 9a1d2fc6ceb7..30829120659c 100644
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -12,3 +12,4 @@ generic-y += preempt.h
 generic-y += vtime.h
 generic-y += msi.h
 generic-y += simd.h
+generic-y += early_ioremap.h
diff --git a/arch/powerpc/include/asm/fixmap.h b/arch/powerpc/include/asm/fixmap.h
index 722289a1d000..d5c4d357bd33 100644
--- a/arch/powerpc/include/asm/fixmap.h
+++ b/arch/powerpc/include/asm/fixmap.h
@@ -15,6 +15,7 @@
 #define _ASM_FIXMAP_H
 
 #ifndef __ASSEMBLY__
+#include <linux/sizes.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #ifdef CONFIG_HIGHMEM
@@ -64,6 +65,14 @@ enum fixed_addresses {
 		       FIX_IMMR_SIZE,
 #endif
 	/* FIX_PCIE_MCFG, */
+	__end_of_permanent_fixed_addresses,
+
+#define NR_FIX_BTMAPS		(SZ_256K / PAGE_SIZE)
+#define FIX_BTMAPS_SLOTS	16
+#define TOTAL_FIX_BTMAPS	(NR_FIX_BTMAPS * FIX_BTMAPS_SLOTS)
+
+	FIX_BTMAP_END = __end_of_permanent_fixed_addresses,
+	FIX_BTMAP_BEGIN = FIX_BTMAP_END + TOTAL_FIX_BTMAPS - 1,
 	__end_of_fixed_addresses
 };
 
@@ -71,6 +80,7 @@ enum fixed_addresses {
 #define FIXADDR_START		(FIXADDR_TOP - __FIXADDR_SIZE)
 
 #define FIXMAP_PAGE_NOCACHE PAGE_KERNEL_NCG
+#define FIXMAP_PAGE_IO	PAGE_KERNEL_NCG
 
 #include <asm-generic/fixmap.h>
 
@@ -85,5 +95,7 @@ static inline void __set_fixmap(enum fixed_addresses idx,
 	map_kernel_page(__fix_to_virt(idx), phys, flags);
 }
 
+#define __early_set_fixmap	__set_fixmap
+
 #endif /* !__ASSEMBLY__ */
 #endif
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index a7541edf0cdb..dcffe927f5b9 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -44,6 +44,7 @@
 #include <asm/asm-prototypes.h>
 #include <asm/kdump.h>
 #include <asm/feature-fixups.h>
+#include <asm/early_ioremap.h>
 
 #include "setup.h"
 
@@ -80,6 +81,8 @@ notrace void __init machine_init(u64 dt_ptr)
 	/* Configure static keys first, now that we're relocated. */
 	setup_feature_keys();
 
+	early_ioremap_setup();
+
 	/* Enable early debugging if any specified (see udbg.h) */
 	udbg_early_init();
 
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 44b4c432a273..b85f6a1cc3a1 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -65,6 +65,7 @@
 #include <asm/hw_irq.h>
 #include <asm/feature-fixups.h>
 #include <asm/kup.h>
+#include <asm/early_ioremap.h>
 
 #include "setup.h"
 
@@ -338,6 +339,8 @@ void __init early_setup(unsigned long dt_ptr)
 	apply_feature_fixups();
 	setup_feature_keys();
 
+	early_ioremap_setup();
+
 	/* Initialize the hash table or TLB handling */
 	early_init_mmu();
 
-- 
2.13.3

