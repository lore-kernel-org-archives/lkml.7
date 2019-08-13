Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98534C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 20:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC6E2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 20:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="m2wsXbIC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfHMULj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 16:11:39 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:30639 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbfHMULh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 16:11:37 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 467P4R2X1Kz9v0CK;
        Tue, 13 Aug 2019 22:11:35 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=m2wsXbIC; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id FXJUkPWYbuOq; Tue, 13 Aug 2019 22:11:35 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 467P4R1Ggmz9v05l;
        Tue, 13 Aug 2019 22:11:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1565727095; bh=MpE4sHyXChSzFM0+Qh7c4gCmiyISLBjS1Wfw7mRzjbA=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=m2wsXbICCHvCfQ8BAHtgUxZ6C46Dzfj8vI3YIDvNIa7RigrJ4yX9pR92XMPvcbGHV
         mhHifXHuNTVb292QqVq/i8K7v6YT5WjFbVOIyWDtRRUSfadJBFYPXlKyZIdMJsKJbk
         H/T65zPjdqL6xqi/rSa58uhunUr7mD/K031cplwc=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 58A018B7F2;
        Tue, 13 Aug 2019 22:11:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id UOJhWaMQ3j-o; Tue, 13 Aug 2019 22:11:35 +0200 (CEST)
Received: from pc17473vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 144848B7F0;
        Tue, 13 Aug 2019 22:11:35 +0200 (CEST)
Received: by pc17473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id E867569632; Tue, 13 Aug 2019 20:11:34 +0000 (UTC)
Message-Id: <d6049aee232029c01c7569975d49455058c945fe.1565726867.git.christophe.leroy@c-s.fr>
In-Reply-To: <6bc35eca507359075528bc0e55938bc1ce8ee485.1565726867.git.christophe.leroy@c-s.fr>
References: <6bc35eca507359075528bc0e55938bc1ce8ee485.1565726867.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 02/10] powerpc/mm: rework io-workaround invocation.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 13 Aug 2019 20:11:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ppc_md.ioremap() is only used for I/O workaround on CELL platform,
so indirect function call can be avoided.

This patch reworks the io-workaround and ioremap() functions to
use static keys for the activation of io-workaround.

When CONFIG_PPC_IO_WORKAROUNDS or CONFIG_PPC_INDIRECT_MMIO are not
selected, the I/O workaround ioremap() voids and the static key is
not used at all.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/io-workarounds.h | 19 +++++++++++++++++++
 arch/powerpc/include/asm/machdep.h        |  2 --
 arch/powerpc/kernel/io-workarounds.c      | 11 ++++++-----
 arch/powerpc/mm/pgtable_64.c              | 17 +++++++++--------
 4 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/io-workarounds.h b/arch/powerpc/include/asm/io-workarounds.h
index 01567ea4ceaf..ce337d17ac40 100644
--- a/arch/powerpc/include/asm/io-workarounds.h
+++ b/arch/powerpc/include/asm/io-workarounds.h
@@ -8,6 +8,7 @@
 #ifndef _IO_WORKAROUNDS_H
 #define _IO_WORKAROUNDS_H
 
+#ifdef CONFIG_PPC_IO_WORKAROUNDS
 #include <linux/io.h>
 #include <asm/pci-bridge.h>
 
@@ -32,4 +33,22 @@ extern int spiderpci_iowa_init(struct iowa_bus *, void *);
 #define SPIDER_PCI_DUMMY_READ		0x0810
 #define SPIDER_PCI_DUMMY_READ_BASE	0x0814
 
+#endif
+
+#if defined(CONFIG_PPC_IO_WORKAROUNDS) && defined(CONFIG_PPC_INDIRECT_MMIO)
+DECLARE_STATIC_KEY_FALSE(iowa_key);
+static inline bool iowa_is_active(void)
+{
+	return static_branch_unlikely(&iowa_key);
+}
+#else
+static inline bool iowa_is_active(void)
+{
+	return false;
+}
+#endif
+
+void __iomem *iowa_ioremap(phys_addr_t addr, unsigned long size,
+			   pgprot_t prot, void *caller);
+
 #endif /* _IO_WORKAROUNDS_H */
diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 3370df4bdaa0..657ec893bdcb 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -31,8 +31,6 @@ struct pci_host_bridge;
 struct machdep_calls {
 	char		*name;
 #ifdef CONFIG_PPC64
-	void __iomem *	(*ioremap)(phys_addr_t addr, unsigned long size,
-				   pgprot_t prot, void *caller);
 #ifdef CONFIG_PM
 	void		(*iommu_save)(void);
 	void		(*iommu_restore)(void);
diff --git a/arch/powerpc/kernel/io-workarounds.c b/arch/powerpc/kernel/io-workarounds.c
index fbd2d0007c52..8b5b2aa70840 100644
--- a/arch/powerpc/kernel/io-workarounds.c
+++ b/arch/powerpc/kernel/io-workarounds.c
@@ -18,6 +18,7 @@
 #include <asm/io-workarounds.h>
 #include <asm/pte-walk.h>
 
+DEFINE_STATIC_KEY_FALSE(iowa_key);
 
 #define IOWA_MAX_BUS	8
 
@@ -149,8 +150,8 @@ static const struct ppc_pci_io iowa_pci_io = {
 };
 
 #ifdef CONFIG_PPC_INDIRECT_MMIO
-static void __iomem *iowa_ioremap(phys_addr_t addr, unsigned long size,
-				  pgprot_t prot, void *caller)
+void __iomem *iowa_ioremap(phys_addr_t addr, unsigned long size,
+			   pgprot_t prot, void *caller)
 {
 	struct iowa_bus *bus;
 	void __iomem *res = __ioremap_caller(addr, size, prot, caller);
@@ -163,8 +164,6 @@ static void __iomem *iowa_ioremap(phys_addr_t addr, unsigned long size,
 	}
 	return res;
 }
-#else /* CONFIG_PPC_INDIRECT_MMIO */
-#define iowa_ioremap NULL
 #endif /* !CONFIG_PPC_INDIRECT_MMIO */
 
 /* Enable IO workaround */
@@ -175,7 +174,9 @@ static void io_workaround_init(void)
 	if (io_workaround_inited)
 		return;
 	ppc_pci_io = iowa_pci_io;
-	ppc_md.ioremap = iowa_ioremap;
+#ifdef CONFIG_PPC_INDIRECT_MMIO
+	static_branch_enable(&iowa_key);
+#endif
 	io_workaround_inited = 1;
 }
 
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 11eb90ea2d4f..194efc6f39fb 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -35,6 +35,7 @@
 #include <asm/page.h>
 #include <asm/prom.h>
 #include <asm/io.h>
+#include <asm/io-workarounds.h>
 #include <asm/mmu_context.h>
 #include <asm/pgtable.h>
 #include <asm/mmu.h>
@@ -214,8 +215,8 @@ void __iomem * ioremap(phys_addr_t addr, unsigned long size)
 	pgprot_t prot = pgprot_noncached(PAGE_KERNEL);
 	void *caller = __builtin_return_address(0);
 
-	if (ppc_md.ioremap)
-		return ppc_md.ioremap(addr, size, prot, caller);
+	if (iowa_is_active())
+		return iowa_ioremap(addr, size, prot, caller);
 	return __ioremap_caller(addr, size, prot, caller);
 }
 
@@ -224,8 +225,8 @@ void __iomem * ioremap_wc(phys_addr_t addr, unsigned long size)
 	pgprot_t prot = pgprot_noncached_wc(PAGE_KERNEL);
 	void *caller = __builtin_return_address(0);
 
-	if (ppc_md.ioremap)
-		return ppc_md.ioremap(addr, size, prot, caller);
+	if (iowa_is_active())
+		return iowa_ioremap(addr, size, prot, caller);
 	return __ioremap_caller(addr, size, prot, caller);
 }
 
@@ -234,8 +235,8 @@ void __iomem *ioremap_coherent(phys_addr_t addr, unsigned long size)
 	pgprot_t prot = pgprot_cached(PAGE_KERNEL);
 	void *caller = __builtin_return_address(0);
 
-	if (ppc_md.ioremap)
-		return ppc_md.ioremap(addr, size, prot, caller);
+	if (iowa_is_active())
+		return iowa_ioremap(addr, size, prot, caller);
 	return __ioremap_caller(addr, size, prot, caller);
 }
 
@@ -256,8 +257,8 @@ void __iomem * ioremap_prot(phys_addr_t addr, unsigned long size,
 	 */
 	pte = pte_mkprivileged(pte);
 
-	if (ppc_md.ioremap)
-		return ppc_md.ioremap(addr, size, pte_pgprot(pte), caller);
+	if (iowa_is_active())
+		return iowa_ioremap(addr, size, pte_pgprot(pte), caller);
 	return __ioremap_caller(addr, size, pte_pgprot(pte), caller);
 }
 
-- 
2.13.3

