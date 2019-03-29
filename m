Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BFEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0222C20811
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Bju0SG+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbfC2KAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:00:07 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:49584 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728934AbfC2KAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:00:05 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44Vy021nkTz9v4yM;
        Fri, 29 Mar 2019 11:00:02 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Bju0SG+x; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id D7xPgzbR1DXr; Fri, 29 Mar 2019 11:00:02 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44Vy020hylz9v4yL;
        Fri, 29 Mar 2019 11:00:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1553853602; bh=J927/YRhwOF2gHU65SwHNZZSjTNcbiAI8FfauRb44GM=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=Bju0SG+xX5biaDjAWQ8nbh78G5u7qh8VUhPIKV8iRKgb7etPW/M96qvLmhtyL+7Id
         vG/guu5VHqqmWbUyGQzrFIUbdG6wi9CvHplCL3jcz7tmOyOZiBIkRi/hQa1cLvPE9J
         jVEKM+rKlDZnN7IPtY2e8QFGLSVg17i7WEVxw23Y=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2D5788B88C;
        Fri, 29 Mar 2019 11:00:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id JFBFpTtcTjsB; Fri, 29 Mar 2019 11:00:03 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0AC1A8B88A;
        Fri, 29 Mar 2019 11:00:03 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id E48596FC95; Fri, 29 Mar 2019 10:00:02 +0000 (UTC)
Message-Id: <a87606761d285e4f3dee5c2de1e6691f04e429b6.1553853405.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1553853405.git.christophe.leroy@c-s.fr>
References: <cover.1553853405.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 4/4] powerpc/mm: Move nohash specifics in subdirectory
 mm/nohash
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 29 Mar 2019 10:00:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many files in arch/powerpc/mm are only for nohash. This patch
creates a subdirectory for them.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/Makefile                          | 17 +----------------
 arch/powerpc/mm/{ => nohash}/40x_mmu.c            |  0
 arch/powerpc/mm/{ => nohash}/44x_mmu.c            |  0
 arch/powerpc/mm/{ => nohash}/8xx_mmu.c            |  0
 arch/powerpc/mm/nohash/Makefile                   | 21 +++++++++++++++++++++
 arch/powerpc/mm/{ => nohash}/fsl_booke_mmu.c      |  0
 arch/powerpc/mm/{ => nohash}/hugetlbpage-book3e.c |  0
 arch/powerpc/mm/{ => nohash}/mmu_context_nohash.c |  0
 arch/powerpc/mm/{ => nohash}/pgtable-book3e.c     |  0
 arch/powerpc/mm/{ => nohash}/tlb_low_64e.S        |  0
 arch/powerpc/mm/{ => nohash}/tlb_nohash.c         |  0
 arch/powerpc/mm/{ => nohash}/tlb_nohash_low.S     |  0
 12 files changed, 22 insertions(+), 16 deletions(-)
 rename arch/powerpc/mm/{ => nohash}/40x_mmu.c (100%)
 rename arch/powerpc/mm/{ => nohash}/44x_mmu.c (100%)
 rename arch/powerpc/mm/{ => nohash}/8xx_mmu.c (100%)
 create mode 100644 arch/powerpc/mm/nohash/Makefile
 rename arch/powerpc/mm/{ => nohash}/fsl_booke_mmu.c (100%)
 rename arch/powerpc/mm/{ => nohash}/hugetlbpage-book3e.c (100%)
 rename arch/powerpc/mm/{ => nohash}/mmu_context_nohash.c (100%)
 rename arch/powerpc/mm/{ => nohash}/pgtable-book3e.c (100%)
 rename arch/powerpc/mm/{ => nohash}/tlb_low_64e.S (100%)
 rename arch/powerpc/mm/{ => nohash}/tlb_nohash.c (100%)
 rename arch/powerpc/mm/{ => nohash}/tlb_nohash_low.S (100%)

diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 68cb1e840b5e..08557bae6fa1 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -8,30 +8,15 @@ ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
 obj-y				:= fault.o mem.o pgtable.o mmap.o \
 				   init_$(BITS).o pgtable_$(BITS).o \
 				   init-common.o mmu_context.o drmem.o
-obj-$(CONFIG_PPC_MMU_NOHASH)	+= mmu_context_nohash.o tlb_nohash.o \
-				   tlb_nohash_low.o
-obj-$(CONFIG_PPC_BOOK3E)	+= tlb_low_$(BITS)e.o
-obj-$(CONFIG_PPC_BOOK3E_64)   += pgtable-book3e.o
+obj-$(CONFIG_PPC_MMU_NOHASH)	+= nohash/
 obj-$(CONFIG_PPC_BOOK3S_32)	+= book3s32/
 obj-$(CONFIG_PPC_BOOK3S_64)	+= book3s64/
 obj-$(CONFIG_PPC_BOOK3S_64)	+= pgtable-frag.o
 obj-$(CONFIG_PPC32)		+= pgtable-frag.o
-obj-$(CONFIG_40x)		+= 40x_mmu.o
-obj-$(CONFIG_44x)		+= 44x_mmu.o
-obj-$(CONFIG_PPC_8xx)		+= 8xx_mmu.o
-obj-$(CONFIG_PPC_FSL_BOOK3E)	+= fsl_booke_mmu.o
 obj-$(CONFIG_NEED_MULTIPLE_NODES) += numa.o
 obj-$(CONFIG_PPC_MM_SLICES)	+= slice.o
 obj-y				+= hugetlbpage.o
-ifdef CONFIG_HUGETLB_PAGE
-obj-$(CONFIG_PPC_BOOK3E_MMU)	+= hugetlbpage-book3e.o
-endif
 obj-$(CONFIG_NOT_COHERENT_CACHE) += dma-noncoherent.o
 obj-$(CONFIG_HIGHMEM)		+= highmem.o
 obj-$(CONFIG_PPC_COPRO_BASE)	+= copro_fault.o
 obj-$(CONFIG_PPC_PTDUMP)	+= ptdump/
-
-# Disable kcov instrumentation on sensitive code
-# This is necessary for booting with kcov enabled on book3e machines
-KCOV_INSTRUMENT_tlb_nohash.o := n
-KCOV_INSTRUMENT_fsl_booke_mmu.o := n
diff --git a/arch/powerpc/mm/40x_mmu.c b/arch/powerpc/mm/nohash/40x_mmu.c
similarity index 100%
rename from arch/powerpc/mm/40x_mmu.c
rename to arch/powerpc/mm/nohash/40x_mmu.c
diff --git a/arch/powerpc/mm/44x_mmu.c b/arch/powerpc/mm/nohash/44x_mmu.c
similarity index 100%
rename from arch/powerpc/mm/44x_mmu.c
rename to arch/powerpc/mm/nohash/44x_mmu.c
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/nohash/8xx_mmu.c
similarity index 100%
rename from arch/powerpc/mm/8xx_mmu.c
rename to arch/powerpc/mm/nohash/8xx_mmu.c
diff --git a/arch/powerpc/mm/nohash/Makefile b/arch/powerpc/mm/nohash/Makefile
new file mode 100644
index 000000000000..f9f5161fd487
--- /dev/null
+++ b/arch/powerpc/mm/nohash/Makefile
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the linux ppc-specific parts of the memory manager.
+#
+
+ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
+
+obj-y				+= mmu_context_nohash.o tlb_nohash.o tlb_nohash_low.o
+obj-$(CONFIG_PPC_BOOK3E_64)  	+= tlb_low_64e.o pgtable-book3e.o
+obj-$(CONFIG_40x)		+= 40x_mmu.o
+obj-$(CONFIG_44x)		+= 44x_mmu.o
+obj-$(CONFIG_PPC_8xx)		+= 8xx_mmu.o
+obj-$(CONFIG_PPC_FSL_BOOK3E)	+= fsl_booke_mmu.o
+ifdef CONFIG_HUGETLB_PAGE
+obj-$(CONFIG_PPC_BOOK3E_MMU)	+= hugetlbpage-book3e.o
+endif
+
+# Disable kcov instrumentation on sensitive code
+# This is necessary for booting with kcov enabled on book3e machines
+KCOV_INSTRUMENT_tlb_nohash.o := n
+KCOV_INSTRUMENT_fsl_booke_mmu.o := n
diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/nohash/fsl_booke_mmu.c
similarity index 100%
rename from arch/powerpc/mm/fsl_booke_mmu.c
rename to arch/powerpc/mm/nohash/fsl_booke_mmu.c
diff --git a/arch/powerpc/mm/hugetlbpage-book3e.c b/arch/powerpc/mm/nohash/hugetlbpage-book3e.c
similarity index 100%
rename from arch/powerpc/mm/hugetlbpage-book3e.c
rename to arch/powerpc/mm/nohash/hugetlbpage-book3e.c
diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/nohash/mmu_context_nohash.c
similarity index 100%
rename from arch/powerpc/mm/mmu_context_nohash.c
rename to arch/powerpc/mm/nohash/mmu_context_nohash.c
diff --git a/arch/powerpc/mm/pgtable-book3e.c b/arch/powerpc/mm/nohash/pgtable-book3e.c
similarity index 100%
rename from arch/powerpc/mm/pgtable-book3e.c
rename to arch/powerpc/mm/nohash/pgtable-book3e.c
diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/nohash/tlb_low_64e.S
similarity index 100%
rename from arch/powerpc/mm/tlb_low_64e.S
rename to arch/powerpc/mm/nohash/tlb_low_64e.S
diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/nohash/tlb_nohash.c
similarity index 100%
rename from arch/powerpc/mm/tlb_nohash.c
rename to arch/powerpc/mm/nohash/tlb_nohash.c
diff --git a/arch/powerpc/mm/tlb_nohash_low.S b/arch/powerpc/mm/nohash/tlb_nohash_low.S
similarity index 100%
rename from arch/powerpc/mm/tlb_nohash_low.S
rename to arch/powerpc/mm/nohash/tlb_nohash_low.S
-- 
2.13.3

