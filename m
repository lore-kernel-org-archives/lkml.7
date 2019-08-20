Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0D5C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A708922DA9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="LAjTxHEJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbfHTOHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 10:07:18 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:30751 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729672AbfHTOHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:07:16 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46CXfp4DJzz9v0Gh;
        Tue, 20 Aug 2019 16:07:14 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=LAjTxHEJ; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id nttQgid0pbse; Tue, 20 Aug 2019 16:07:14 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46CXfp3BBsz9v0GZ;
        Tue, 20 Aug 2019 16:07:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1566310034; bh=SBsNMvGsbMMC8XFjes4L70Rdi1s+t6kRWxXgqat2LYU=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=LAjTxHEJx9N9jYfbpDE4kpnJ8o/aFDX7HUbL23XHYrCAsdaFgnXI7AF5H4K0dStko
         3s4t1uCvwJhz5xrdvrzjV7pu4SIby9N4Jw1o5rT+mOh/3Jg04e6N5aiQCbeulOMno7
         xROrtpW8XKZv7WsxotcnPIrk0sWXzfSmvKde2pvc=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CB57E8B7C9;
        Tue, 20 Aug 2019 16:07:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id NZen0_zo3DCl; Tue, 20 Aug 2019 16:07:14 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 873088B7D0;
        Tue, 20 Aug 2019 16:07:14 +0200 (CEST)
Received: by pc16032vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 6B0536B734; Tue, 20 Aug 2019 14:07:14 +0000 (UTC)
Message-Id: <6223803ce024d6ab4dfaa919f44098aed5b4bc33.1566309262.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1566309262.git.christophe.leroy@c-s.fr>
References: <cover.1566309262.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 06/12] powerpc/mm: move common 32/64 bits ioremap functions
 into ioremap.c
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        hch@lst.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 20 Aug 2019 14:07:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ioremap(), ioremap_wc() and ioremap_coherent() are now identical on
PPC32 and PPC64 as iowa_is_active() will always return false on
PPC32. Move them into a new common location called ioremap.c

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/Makefile     |  2 +-
 arch/powerpc/mm/ioremap.c    | 36 ++++++++++++++++++++++++++++++++++++
 arch/powerpc/mm/pgtable_32.c | 27 ---------------------------
 arch/powerpc/mm/pgtable_64.c | 33 ---------------------------------
 4 files changed, 37 insertions(+), 61 deletions(-)
 create mode 100644 arch/powerpc/mm/ioremap.c

diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 0f499db315d6..29c682fe9144 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -7,7 +7,7 @@ ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
 
 obj-y				:= fault.o mem.o pgtable.o mmap.o \
 				   init_$(BITS).o pgtable_$(BITS).o \
-				   pgtable-frag.o \
+				   pgtable-frag.o ioremap.o \
 				   init-common.o mmu_context.o drmem.o
 obj-$(CONFIG_PPC_MMU_NOHASH)	+= nohash/
 obj-$(CONFIG_PPC_BOOK3S_32)	+= book3s32/
diff --git a/arch/powerpc/mm/ioremap.c b/arch/powerpc/mm/ioremap.c
new file mode 100644
index 000000000000..7f1d462e7745
--- /dev/null
+++ b/arch/powerpc/mm/ioremap.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/io.h>
+#include <asm/io-workarounds.h>
+
+void __iomem *ioremap(phys_addr_t addr, unsigned long size)
+{
+	pgprot_t prot = pgprot_noncached(PAGE_KERNEL);
+	void *caller = __builtin_return_address(0);
+
+	if (iowa_is_active())
+		return iowa_ioremap(addr, size, prot, caller);
+	return __ioremap_caller(addr, size, prot, caller);
+}
+EXPORT_SYMBOL(ioremap);
+
+void __iomem *ioremap_wc(phys_addr_t addr, unsigned long size)
+{
+	pgprot_t prot = pgprot_noncached_wc(PAGE_KERNEL);
+	void *caller = __builtin_return_address(0);
+
+	if (iowa_is_active())
+		return iowa_ioremap(addr, size, prot, caller);
+	return __ioremap_caller(addr, size, prot, caller);
+}
+EXPORT_SYMBOL(ioremap_wc);
+
+void __iomem *ioremap_coherent(phys_addr_t addr, unsigned long size)
+{
+	pgprot_t prot = pgprot_cached(PAGE_KERNEL);
+	void *caller = __builtin_return_address(0);
+
+	if (iowa_is_active())
+		return iowa_ioremap(addr, size, prot, caller);
+	return __ioremap_caller(addr, size, prot, caller);
+}
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 848ee4a30dd1..3a4972007ec0 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -39,24 +39,6 @@ EXPORT_SYMBOL(ioremap_bot);	/* aka VMALLOC_END */
 extern char etext[], _stext[], _sinittext[], _einittext[];
 
 void __iomem *
-ioremap(phys_addr_t addr, unsigned long size)
-{
-	pgprot_t prot = pgprot_noncached(PAGE_KERNEL);
-
-	return __ioremap_caller(addr, size, prot, __builtin_return_address(0));
-}
-EXPORT_SYMBOL(ioremap);
-
-void __iomem *
-ioremap_wc(phys_addr_t addr, unsigned long size)
-{
-	pgprot_t prot = pgprot_noncached_wc(PAGE_KERNEL);
-
-	return __ioremap_caller(addr, size, prot, __builtin_return_address(0));
-}
-EXPORT_SYMBOL(ioremap_wc);
-
-void __iomem *
 ioremap_wt(phys_addr_t addr, unsigned long size)
 {
 	pgprot_t prot = pgprot_cached_wthru(PAGE_KERNEL);
@@ -66,15 +48,6 @@ ioremap_wt(phys_addr_t addr, unsigned long size)
 EXPORT_SYMBOL(ioremap_wt);
 
 void __iomem *
-ioremap_coherent(phys_addr_t addr, unsigned long size)
-{
-	pgprot_t prot = pgprot_cached(PAGE_KERNEL);
-
-	return __ioremap_caller(addr, size, prot, __builtin_return_address(0));
-}
-EXPORT_SYMBOL(ioremap_coherent);
-
-void __iomem *
 ioremap_prot(phys_addr_t addr, unsigned long size, unsigned long flags)
 {
 	pte_t pte = __pte(flags);
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 0a147daeb0f2..358233ea8d85 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -35,7 +35,6 @@
 #include <asm/page.h>
 #include <asm/prom.h>
 #include <asm/io.h>
-#include <asm/io-workarounds.h>
 #include <asm/mmu_context.h>
 #include <asm/pgtable.h>
 #include <asm/mmu.h>
@@ -204,36 +203,6 @@ void __iomem * __ioremap_caller(phys_addr_t addr, unsigned long size,
 	return ret;
 }
 
-void __iomem * ioremap(phys_addr_t addr, unsigned long size)
-{
-	pgprot_t prot = pgprot_noncached(PAGE_KERNEL);
-	void *caller = __builtin_return_address(0);
-
-	if (iowa_is_active())
-		return iowa_ioremap(addr, size, prot, caller);
-	return __ioremap_caller(addr, size, prot, caller);
-}
-
-void __iomem * ioremap_wc(phys_addr_t addr, unsigned long size)
-{
-	pgprot_t prot = pgprot_noncached_wc(PAGE_KERNEL);
-	void *caller = __builtin_return_address(0);
-
-	if (iowa_is_active())
-		return iowa_ioremap(addr, size, prot, caller);
-	return __ioremap_caller(addr, size, prot, caller);
-}
-
-void __iomem *ioremap_coherent(phys_addr_t addr, unsigned long size)
-{
-	pgprot_t prot = pgprot_cached(PAGE_KERNEL);
-	void *caller = __builtin_return_address(0);
-
-	if (iowa_is_active())
-		return iowa_ioremap(addr, size, prot, caller);
-	return __ioremap_caller(addr, size, prot, caller);
-}
-
 void __iomem * ioremap_prot(phys_addr_t addr, unsigned long size,
 			     unsigned long flags)
 {
@@ -278,8 +247,6 @@ void iounmap(volatile void __iomem *token)
 	vunmap(addr);
 }
 
-EXPORT_SYMBOL(ioremap);
-EXPORT_SYMBOL(ioremap_wc);
 EXPORT_SYMBOL(ioremap_prot);
 EXPORT_SYMBOL(__ioremap_at);
 EXPORT_SYMBOL(iounmap);
-- 
2.13.3

