Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C4AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F30F2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="UBgSdKiC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbfC2KAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:00:20 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:33258 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727387AbfC2KAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:00:03 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44Vy001RHrz9v1Nx;
        Fri, 29 Mar 2019 11:00:00 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=UBgSdKiC; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id YIYA5ogW4pbs; Fri, 29 Mar 2019 11:00:00 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44Vy000C0sz9v1N5;
        Fri, 29 Mar 2019 11:00:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1553853600; bh=hdjQ8Wt9f4+cfq42Pa+br2CMnxyexL9038BQZ3EONhM=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=UBgSdKiC1em6CZ4ZbDFCoDYnh49lgsV4TJcp/1D/TcFz+XEMkmFLdlBhl5wewt1HW
         KmAg5dsLmOyAHI4GAJzbFC5ScBs7NtQPwPSxa7WtiyDvSGQ8pokQMW07W3q2OofaWw
         PcF44foNo5RmWaDCTusi56C2CvZHVczO2myjD9Oo=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1B3DC8B88A;
        Fri, 29 Mar 2019 11:00:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id LosMpcEChIUR; Fri, 29 Mar 2019 11:00:01 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E62F08B889;
        Fri, 29 Mar 2019 11:00:00 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id D92A66FC95; Fri, 29 Mar 2019 10:00:00 +0000 (UTC)
Message-Id: <c4afde657ef9e4ad0266ae62e9907313c41c4a16.1553853405.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1553853405.git.christophe.leroy@c-s.fr>
References: <cover.1553853405.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 2/4] powerpc/mm: Move book3s64 specifics in subdirectory
 mm/book3s64
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 29 Mar 2019 10:00:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many files in arch/powerpc/mm are only for book3S64. This patch
creates a subdirectory for them.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/Makefile                           | 25 +++----------------
 arch/powerpc/mm/book3s64/Makefile                  | 28 ++++++++++++++++++++++
 arch/powerpc/mm/{ => book3s64}/hash64_4k.c         |  0
 arch/powerpc/mm/{ => book3s64}/hash64_64k.c        |  0
 arch/powerpc/mm/{ => book3s64}/hash_native_64.c    |  0
 arch/powerpc/mm/{ => book3s64}/hash_utils_64.c     |  0
 arch/powerpc/mm/{ => book3s64}/hugepage-hash64.c   |  0
 .../powerpc/mm/{ => book3s64}/hugetlbpage-hash64.c |  0
 arch/powerpc/mm/{ => book3s64}/hugetlbpage-radix.c |  0
 .../mm/{ => book3s64}/mmu_context_book3s64.c       |  0
 arch/powerpc/mm/{ => book3s64}/mmu_context_iommu.c |  0
 arch/powerpc/mm/{ => book3s64}/pgtable-book3s64.c  |  0
 arch/powerpc/mm/{ => book3s64}/pgtable-hash64.c    |  0
 arch/powerpc/mm/{ => book3s64}/pgtable-radix.c     |  0
 arch/powerpc/mm/{ => book3s64}/pkeys.c             |  0
 arch/powerpc/mm/{ => book3s64}/slb.c               |  0
 arch/powerpc/mm/{ => book3s64}/subpage-prot.c      |  0
 arch/powerpc/mm/{ => book3s64}/tlb-radix.c         |  0
 arch/powerpc/mm/{ => book3s64}/tlb_hash64.c        |  0
 arch/powerpc/mm/{ => book3s64}/vphn.c              |  0
 arch/powerpc/mm/{ => book3s64}/vphn.h              |  0
 arch/powerpc/mm/numa.c                             |  2 +-
 22 files changed, 32 insertions(+), 23 deletions(-)
 create mode 100644 arch/powerpc/mm/book3s64/Makefile
 rename arch/powerpc/mm/{ => book3s64}/hash64_4k.c (100%)
 rename arch/powerpc/mm/{ => book3s64}/hash64_64k.c (100%)
 rename arch/powerpc/mm/{ => book3s64}/hash_native_64.c (100%)
 rename arch/powerpc/mm/{ => book3s64}/hash_utils_64.c (100%)
 rename arch/powerpc/mm/{ => book3s64}/hugepage-hash64.c (100%)
 rename arch/powerpc/mm/{ => book3s64}/hugetlbpage-hash64.c (100%)
 rename arch/powerpc/mm/{ => book3s64}/hugetlbpage-radix.c (100%)
 rename arch/powerpc/mm/{ => book3s64}/mmu_context_book3s64.c (100%)
 rename arch/powerpc/mm/{ => book3s64}/mmu_context_iommu.c (100%)
 rename arch/powerpc/mm/{ => book3s64}/pgtable-book3s64.c (100%)
 rename arch/powerpc/mm/{ => book3s64}/pgtable-hash64.c (100%)
 rename arch/powerpc/mm/{ => book3s64}/pgtable-radix.c (100%)
 rename arch/powerpc/mm/{ => book3s64}/pkeys.c (100%)
 rename arch/powerpc/mm/{ => book3s64}/slb.c (100%)
 rename arch/powerpc/mm/{ => book3s64}/subpage-prot.c (100%)
 rename arch/powerpc/mm/{ => book3s64}/tlb-radix.c (100%)
 rename arch/powerpc/mm/{ => book3s64}/tlb_hash64.c (100%)
 rename arch/powerpc/mm/{ => book3s64}/vphn.c (100%)
 rename arch/powerpc/mm/{ => book3s64}/vphn.h (100%)

diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 3c1bd9fa23cd..a137fdf775e2 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -5,53 +5,34 @@
 
 ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
 
-CFLAGS_REMOVE_slb.o = $(CC_FLAGS_FTRACE)
-
 obj-y				:= fault.o mem.o pgtable.o mmap.o \
 				   init_$(BITS).o pgtable_$(BITS).o \
 				   init-common.o mmu_context.o drmem.o
 obj-$(CONFIG_PPC_MMU_NOHASH)	+= mmu_context_nohash.o tlb_nohash.o \
 				   tlb_nohash_low.o
 obj-$(CONFIG_PPC_BOOK3E)	+= tlb_low_$(BITS)e.o
-hash64-$(CONFIG_PPC_NATIVE)	:= hash_native_64.o
 obj-$(CONFIG_PPC_BOOK3E_64)   += pgtable-book3e.o
-obj-$(CONFIG_PPC_BOOK3S_64)	+= pgtable-hash64.o hash_utils_64.o slb.o \
-				   $(hash64-y) mmu_context_book3s64.o \
-				   pgtable-book3s64.o pgtable-frag.o
+obj-$(CONFIG_PPC_BOOK3S_64)	+= book3s64/
+obj-$(CONFIG_PPC_BOOK3S_64)	+= pgtable-frag.o
 obj-$(CONFIG_PPC32)		+= pgtable-frag.o
-obj-$(CONFIG_PPC_RADIX_MMU)	+= pgtable-radix.o tlb-radix.o
 obj-$(CONFIG_PPC_BOOK3S_32)	+= ppc_mmu_32.o hash_low_32.o mmu_context_hash32.o
-obj-$(CONFIG_PPC_BOOK3S)	+= tlb_hash$(BITS).o
-ifdef CONFIG_PPC_BOOK3S_64
-obj-$(CONFIG_PPC_4K_PAGES)	+= hash64_4k.o
-obj-$(CONFIG_PPC_64K_PAGES)	+= hash64_64k.o
-endif
+obj-$(CONFIG_PPC_BOOK3S_32)	+= tlb_hash32.o
 obj-$(CONFIG_40x)		+= 40x_mmu.o
 obj-$(CONFIG_44x)		+= 44x_mmu.o
 obj-$(CONFIG_PPC_8xx)		+= 8xx_mmu.o
 obj-$(CONFIG_PPC_FSL_BOOK3E)	+= fsl_booke_mmu.o
 obj-$(CONFIG_NEED_MULTIPLE_NODES) += numa.o
-obj-$(CONFIG_PPC_SPLPAR)	+= vphn.o
 obj-$(CONFIG_PPC_MM_SLICES)	+= slice.o
 obj-y				+= hugetlbpage.o
 ifdef CONFIG_HUGETLB_PAGE
-obj-$(CONFIG_PPC_BOOK3S_64)	+= hugetlbpage-hash64.o
-obj-$(CONFIG_PPC_RADIX_MMU)	+= hugetlbpage-radix.o
 obj-$(CONFIG_PPC_BOOK3E_MMU)	+= hugetlbpage-book3e.o
 endif
-obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += hugepage-hash64.o
-obj-$(CONFIG_PPC_SUBPAGE_PROT)	+= subpage-prot.o
 obj-$(CONFIG_NOT_COHERENT_CACHE) += dma-noncoherent.o
 obj-$(CONFIG_HIGHMEM)		+= highmem.o
 obj-$(CONFIG_PPC_COPRO_BASE)	+= copro_fault.o
-obj-$(CONFIG_SPAPR_TCE_IOMMU)	+= mmu_context_iommu.o
 obj-$(CONFIG_PPC_PTDUMP)	+= ptdump/
-obj-$(CONFIG_PPC_MEM_KEYS)	+= pkeys.o
 
 # Disable kcov instrumentation on sensitive code
 # This is necessary for booting with kcov enabled on book3e machines
 KCOV_INSTRUMENT_tlb_nohash.o := n
 KCOV_INSTRUMENT_fsl_booke_mmu.o := n
-
-# Instrumenting the SLB fault path can lead to duplicate SLB entries
-KCOV_INSTRUMENT_slb.o := n
diff --git a/arch/powerpc/mm/book3s64/Makefile b/arch/powerpc/mm/book3s64/Makefile
new file mode 100644
index 000000000000..cfea527b66d9
--- /dev/null
+++ b/arch/powerpc/mm/book3s64/Makefile
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the linux ppc-specific parts of the memory manager.
+#
+
+ccflags-y	:= $(NO_MINIMAL_TOC)
+
+CFLAGS_REMOVE_slb.o = $(CC_FLAGS_FTRACE)
+
+obj-y				+= pgtable-hash64.o hash_utils_64.o slb.o \
+				   mmu_context_book3s64.o pgtable-book3s64.o \
+				   tlb_hash64.o
+obj-$(CONFIG_PPC_NATIVE)	+= hash_native_64.o
+obj-$(CONFIG_PPC_RADIX_MMU)	+= pgtable-radix.o tlb-radix.o
+obj-$(CONFIG_PPC_4K_PAGES)	+= hash64_4k.o
+obj-$(CONFIG_PPC_64K_PAGES)	+= hash64_64k.o
+obj-$(CONFIG_PPC_SPLPAR)	+= vphn.o
+obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage-hash64.o
+ifdef CONFIG_HUGETLB_PAGE
+obj-$(CONFIG_PPC_RADIX_MMU)	+= hugetlbpage-radix.o
+endif
+obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += hugepage-hash64.o
+obj-$(CONFIG_PPC_SUBPAGE_PROT)	+= subpage-prot.o
+obj-$(CONFIG_SPAPR_TCE_IOMMU)	+= mmu_context_iommu.o
+obj-$(CONFIG_PPC_MEM_KEYS)	+= pkeys.o
+
+# Instrumenting the SLB fault path can lead to duplicate SLB entries
+KCOV_INSTRUMENT_slb.o := n
diff --git a/arch/powerpc/mm/hash64_4k.c b/arch/powerpc/mm/book3s64/hash64_4k.c
similarity index 100%
rename from arch/powerpc/mm/hash64_4k.c
rename to arch/powerpc/mm/book3s64/hash64_4k.c
diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/book3s64/hash64_64k.c
similarity index 100%
rename from arch/powerpc/mm/hash64_64k.c
rename to arch/powerpc/mm/book3s64/hash64_64k.c
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/book3s64/hash_native_64.c
similarity index 100%
rename from arch/powerpc/mm/hash_native_64.c
rename to arch/powerpc/mm/book3s64/hash_native_64.c
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/book3s64/hash_utils_64.c
similarity index 100%
rename from arch/powerpc/mm/hash_utils_64.c
rename to arch/powerpc/mm/book3s64/hash_utils_64.c
diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/book3s64/hugepage-hash64.c
similarity index 100%
rename from arch/powerpc/mm/hugepage-hash64.c
rename to arch/powerpc/mm/book3s64/hugepage-hash64.c
diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/book3s64/hugetlbpage-hash64.c
similarity index 100%
rename from arch/powerpc/mm/hugetlbpage-hash64.c
rename to arch/powerpc/mm/book3s64/hugetlbpage-hash64.c
diff --git a/arch/powerpc/mm/hugetlbpage-radix.c b/arch/powerpc/mm/book3s64/hugetlbpage-radix.c
similarity index 100%
rename from arch/powerpc/mm/hugetlbpage-radix.c
rename to arch/powerpc/mm/book3s64/hugetlbpage-radix.c
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/book3s64/mmu_context_book3s64.c
similarity index 100%
rename from arch/powerpc/mm/mmu_context_book3s64.c
rename to arch/powerpc/mm/book3s64/mmu_context_book3s64.c
diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/book3s64/mmu_context_iommu.c
similarity index 100%
rename from arch/powerpc/mm/mmu_context_iommu.c
rename to arch/powerpc/mm/book3s64/mmu_context_iommu.c
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/book3s64/pgtable-book3s64.c
similarity index 100%
rename from arch/powerpc/mm/pgtable-book3s64.c
rename to arch/powerpc/mm/book3s64/pgtable-book3s64.c
diff --git a/arch/powerpc/mm/pgtable-hash64.c b/arch/powerpc/mm/book3s64/pgtable-hash64.c
similarity index 100%
rename from arch/powerpc/mm/pgtable-hash64.c
rename to arch/powerpc/mm/book3s64/pgtable-hash64.c
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/book3s64/pgtable-radix.c
similarity index 100%
rename from arch/powerpc/mm/pgtable-radix.c
rename to arch/powerpc/mm/book3s64/pgtable-radix.c
diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/book3s64/pkeys.c
similarity index 100%
rename from arch/powerpc/mm/pkeys.c
rename to arch/powerpc/mm/book3s64/pkeys.c
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/book3s64/slb.c
similarity index 100%
rename from arch/powerpc/mm/slb.c
rename to arch/powerpc/mm/book3s64/slb.c
diff --git a/arch/powerpc/mm/subpage-prot.c b/arch/powerpc/mm/book3s64/subpage-prot.c
similarity index 100%
rename from arch/powerpc/mm/subpage-prot.c
rename to arch/powerpc/mm/book3s64/subpage-prot.c
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/book3s64/tlb-radix.c
similarity index 100%
rename from arch/powerpc/mm/tlb-radix.c
rename to arch/powerpc/mm/book3s64/tlb-radix.c
diff --git a/arch/powerpc/mm/tlb_hash64.c b/arch/powerpc/mm/book3s64/tlb_hash64.c
similarity index 100%
rename from arch/powerpc/mm/tlb_hash64.c
rename to arch/powerpc/mm/book3s64/tlb_hash64.c
diff --git a/arch/powerpc/mm/vphn.c b/arch/powerpc/mm/book3s64/vphn.c
similarity index 100%
rename from arch/powerpc/mm/vphn.c
rename to arch/powerpc/mm/book3s64/vphn.c
diff --git a/arch/powerpc/mm/vphn.h b/arch/powerpc/mm/book3s64/vphn.h
similarity index 100%
rename from arch/powerpc/mm/vphn.h
rename to arch/powerpc/mm/book3s64/vphn.h
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index f976676004ad..6ef516718da3 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1063,7 +1063,7 @@ u64 memory_hotplug_max(void)
 /* Virtual Processor Home Node (VPHN) support */
 #ifdef CONFIG_PPC_SPLPAR
 
-#include "vphn.h"
+#include "book3s64/vphn.h"
 
 struct topology_update_data {
 	struct topology_update_data *next;
-- 
2.13.3

