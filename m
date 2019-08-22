Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEACC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 16:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705D2206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 16:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389685AbfHVQEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 12:04:46 -0400
Received: from ale.deltatee.com ([207.54.116.67]:47726 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388270AbfHVQEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 12:04:46 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1i0pZq-000720-27; Thu, 22 Aug 2019 10:04:44 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1i0pZo-0001Ct-AT; Thu, 22 Aug 2019 10:04:40 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Waterman <andrew@sifive.com>,
        Olof Johansson <olof@lixom.net>,
        Michael Clark <michaeljclark@mac.com>,
        Rob Herring <robh@kernel.org>, Zong Li <zong@andestech.com>
Date:   Thu, 22 Aug 2019 10:04:39 -0600
Message-Id: <20190822160439.4598-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, sbates@raithlin.com, hch@lst.de, logang@deltatee.com, aou@eecs.berkeley.edu, palmer@sifive.com, greentime.hu@sifive.com, andrew@sifive.com, olof@lixom.net, michaeljclark@mac.com, robh@kernel.org, zong@andestech.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v5] RISC-V: Implement sparsemem
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements sparsemem support for risc-v which helps pave the
way for memory hotplug and eventually P2P support.

We introduce Kconfig options for virtual and physical address bits which
are used to calculate the size of the vmemmap and set the
MAX_PHYSMEM_BITS.

The vmemmap is located directly before the VMALLOC region and sized
such that we can allocate enough pages to populate all the virtual
address space in the system (similar to the way it's done in arm64).

During initialization, call memblocks_present() and sparse_init(),
and provide a stub for vmemmap_populate() (all of which is similar to
arm64).

[greentime.hu@sifive.com:
  fixed pfn_valid, FIXADDR_TOP and fixed a bug rebasing onto v5.3]
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Andrew Waterman <andrew@sifive.com>
Cc: Olof Johansson <olof@lixom.net>
Cc: Michael Clark <michaeljclark@mac.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Zong Li <zong@andestech.com>
---

Changes in v5:
 * Rebased onto v5.3-rc5 (required moving the initialization to
   after setup_vm_final() in paging_init())
 * Fixed FIXADDR_TOP value (per Greentime)
 * Use generic pfn_valid() function for sparsemem to fix a bug
   with having holes in memory (also Greentime)

Changes in v4:
 * Rebased onto v5.0-rc1
 * Changed the SECTION_SIZE_BITS to 27, per Nick Kossifidis

Changes in v3 (only sent the common patches):
 * Rebased on v4.20-rc1
 * Minor fixups
 * Collected Ack from Will Deacon

Changes in v2:
 * Rebase on v4.19-rc8
 * Move the STRUCT_PAGE_MAX_SHIFT define into a common header (near
   the definition of struct page). As suggested by Christoph.
 * Clean up the unnecessary nid variable in the memblocks_present()
   function, per Christoph.
 * Collected tags from Palmer and Catalin.

 arch/riscv/Kconfig                 | 20 ++++++++++++++++++++
 arch/riscv/include/asm/fixmap.h    |  2 +-
 arch/riscv/include/asm/page.h      |  2 ++
 arch/riscv/include/asm/pgtable.h   | 21 +++++++++++++++++----
 arch/riscv/include/asm/sparsemem.h | 11 +++++++++++
 arch/riscv/mm/init.c               | 10 ++++++++++
 6 files changed, 61 insertions(+), 5 deletions(-)
 create mode 100644 arch/riscv/include/asm/sparsemem.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 59a4727ecd6c..83faa929853c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -62,12 +62,32 @@ config ZONE_DMA32
 	bool
 	default y if 64BIT

+config VA_BITS
+	int
+	default 32 if 32BIT
+	default 39 if 64BIT
+
+config PA_BITS
+	int
+	default 34 if 32BIT
+	default 56 if 64BIT
+
 config PAGE_OFFSET
 	hex
 	default 0xC0000000 if 32BIT && MAXPHYSMEM_2GB
 	default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
 	default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB

+config ARCH_FLATMEM_ENABLE
+	def_bool y
+
+config ARCH_SPARSEMEM_ENABLE
+	def_bool y
+	select SPARSEMEM_VMEMMAP_ENABLE
+
+config ARCH_SELECT_MEMORY_MODEL
+	def_bool ARCH_SPARSEMEM_ENABLE
+
 config ARCH_WANT_GENERAL_HUGETLB
 	def_bool y

diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
index 9c66033c3a54..7b0259c044c9 100644
--- a/arch/riscv/include/asm/fixmap.h
+++ b/arch/riscv/include/asm/fixmap.h
@@ -31,7 +31,7 @@ enum fixed_addresses {
 };

 #define FIXADDR_SIZE		(__end_of_fixed_addresses * PAGE_SIZE)
-#define FIXADDR_TOP		(VMALLOC_START)
+#define FIXADDR_TOP		(VMEMMAP_START)
 #define FIXADDR_START		(FIXADDR_TOP - FIXADDR_SIZE)

 #define FIXMAP_PAGE_IO		PAGE_KERNEL
diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 707e00a8430b..3db261c4810f 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -110,8 +110,10 @@ extern unsigned long min_low_pfn;
 #define page_to_bus(page)	(page_to_phys(page))
 #define phys_to_page(paddr)	(pfn_to_page(phys_to_pfn(paddr)))

+#ifdef CONFIG_FLATMEM
 #define pfn_valid(pfn) \
 	(((pfn) >= pfn_base) && (((pfn)-pfn_base) < max_mapnr))
+#endif

 #define ARCH_PFN_OFFSET		(pfn_base)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index a364aba23d55..dbc19e61ee66 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -83,6 +83,23 @@ extern pgd_t swapper_pg_dir[];
 #define __S110	PAGE_SHARED_EXEC
 #define __S111	PAGE_SHARED_EXEC

+#define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
+#define VMALLOC_END      (PAGE_OFFSET - 1)
+#define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
+
+/*
+ * Roughly size the vmemmap space to be large enough to fit enough
+ * struct pages to map half the virtual address space. Then
+ * position vmemmap directly below the VMALLOC region.
+ */
+#define VMEMMAP_SHIFT \
+	(CONFIG_VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
+#define VMEMMAP_SIZE	(1UL << VMEMMAP_SHIFT)
+#define VMEMMAP_END	(VMALLOC_START - 1)
+#define VMEMMAP_START	(VMALLOC_START - VMEMMAP_SIZE)
+
+#define vmemmap		((struct page *)VMEMMAP_START)
+
 /*
  * ZERO_PAGE is a global shared page that is always zero,
  * used for zero-mapped memory areas, etc.
@@ -416,10 +433,6 @@ static inline void pgtable_cache_init(void)
 	/* No page table caches to initialize */
 }

-#define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
-#define VMALLOC_END      (PAGE_OFFSET - 1)
-#define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
-
 /*
  * Task size is 0x4000000000 for RV64 or 0xb800000 for RV32.
  * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
diff --git a/arch/riscv/include/asm/sparsemem.h b/arch/riscv/include/asm/sparsemem.h
new file mode 100644
index 000000000000..b58ba2d9ed6e
--- /dev/null
+++ b/arch/riscv/include/asm/sparsemem.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_SPARSEMEM_H
+#define __ASM_SPARSEMEM_H
+
+#ifdef CONFIG_SPARSEMEM
+#define MAX_PHYSMEM_BITS	CONFIG_PA_BITS
+#define SECTION_SIZE_BITS	27
+#endif /* CONFIG_SPARSEMEM */
+
+#endif /* __ASM_SPARSEMEM_H */
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 42bf939693d3..73f40c9d3dee 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -442,6 +442,16 @@ static void __init setup_vm_final(void)
 void __init paging_init(void)
 {
 	setup_vm_final();
+	memblocks_present();
+	sparse_init();
 	setup_zero_page();
 	zone_sizes_init();
 }
+
+#ifdef CONFIG_SPARSEMEM
+int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
+			       struct vmem_altmap *altmap)
+{
+	return vmemmap_populate_basepages(start, end, node);
+}
+#endif
--
2.20.1
