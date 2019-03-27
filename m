Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE70BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C299221734
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbfC0Vgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 17:36:54 -0400
Received: from ale.deltatee.com ([207.54.116.67]:58662 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728257AbfC0Vgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 17:36:50 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1h9GE3-0006DJ-81; Wed, 27 Mar 2019 15:36:49 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1h9GE2-0006Ce-4j; Wed, 27 Mar 2019 15:36:46 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Christoph Hellwig <hch@lst.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Logan Gunthorpe <logang@deltatee.com>,
        Antony Pavlov <antonynpavlov@gmail.com>,
        "Stefan O'Rear" <sorear2@gmail.com>,
        Anup Patel <anup.patel@wdc.com>
Date:   Wed, 27 Mar 2019 15:36:39 -0600
Message-Id: <20190327213643.23789-4-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327213643.23789-1-logang@deltatee.com>
References: <20190327213643.23789-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, sbates@raithlin.com, palmer@sifive.com, hch@lst.de, aou@eecs.berkeley.edu, logang@deltatee.com, antonynpavlov@gmail.com, sorear2@gmail.com, anup.patel@wdc.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 3/7] RISC-V: Rework kernel's virtual address space mapping
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The motivation for this is to support P2P transactions. P2P requires
having struct pages for IO memory which means the linear mapping must
be able to cover all of the IO regions. Unfortunately with Sv39 we are
not able to cover all the IO regions available on existing hardware,
but we can do better than what we currently do (which only cover's
physical memory).

To this end, we restructure the kernel's virtual address space region.
We position the vmemmap at the beginning of the region (based on how
many virtual address bits we have) and the VMALLOC region comes
immediately after. The linear mapping then takes up the remaining space.
PAGE_OFFSET will need to be within the linear mapping but may not be
the start of the mapping seeing many machines don't have RAM at address
zero and we may still want to access lower addresses through the
linear mapping.

With these changes, on a 64-bit system the virtual memory map (with
sparsemem enabled) will be:

32-bit:

00000000 - 7fffffff   user space, different per mm (2G)
80000000 - 81ffffff   virtual memory map (32MB)
82000000 - bfffffff   vmalloc/ioremap space (1GB - 32MB)
c0000000 - ffffffff   direct mapping of all phys. memory (1GB)

64-bit, Sv39:

0000000000000000 - 0000003fffffffff  user space, different per mm (256GB)
hole caused by [38:63] sign extension
ffffffc000000000 - ffffffc0ffffffff  virtual memory map (4GB)
ffffffc100000000 - ffffffd0ffffffff  vmalloc/ioremap spac (64GB)
ffffffd100000000 - ffffffffffffffff  linear mapping of phys. space (188GB)

On the Sifive hardware this allows us to provide struct pages for
the lower I/O TileLink address ranges, the 32-bit and 34-bit DRAM areas
and 172GB of 240GB of the high I/O TileLink region. Once we progress to
Sv48 we should be able to cover all the available memory regions..

For the MAXPHYSMEM_2GB case, the physical memory must be in the highest
2GB of address space, so we cannot cover the any of the I/O regions
that are higher than it but we do cover the lower I/O TileLink range.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Antony Pavlov <antonynpavlov@gmail.com>
Cc: "Stefan O'Rear" <sorear2@gmail.com>
Cc: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/Kconfig               |  2 +-
 arch/riscv/include/asm/page.h    |  2 --
 arch/riscv/include/asm/pgtable.h | 27 ++++++++++++++++++---------
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 76fc340ae38e..d21e6a12e8b6 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -71,7 +71,7 @@ config PAGE_OFFSET
 	hex
 	default 0xC0000000 if 32BIT && MAXPHYSMEM_2GB
 	default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
-	default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
+	default 0xffffffd200000000 if 64BIT && MAXPHYSMEM_128GB
 
 config ARCH_FLATMEM_ENABLE
 	def_bool y
diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 2a546a52f02a..fa0b8058a246 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -31,8 +31,6 @@
  */
 #define PAGE_OFFSET		_AC(CONFIG_PAGE_OFFSET, UL)
 
-#define KERN_VIRT_SIZE (-PAGE_OFFSET)
-
 #ifndef __ASSEMBLY__
 
 #define PAGE_UP(addr)	(((addr)+((PAGE_SIZE)-1))&(~((PAGE_SIZE)-1)))
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 5a9fea00ba09..2a5070540996 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -89,22 +89,31 @@ extern pgd_t swapper_pg_dir[];
 #define __S110	PAGE_SHARED_EXEC
 #define __S111	PAGE_SHARED_EXEC
 
-#define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
-#define VMALLOC_END      (PAGE_OFFSET - 1)
-#define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
+#define KERN_SPACE_START	(-1UL << (CONFIG_VA_BITS - 1))
 
 /*
  * Roughly size the vmemmap space to be large enough to fit enough
  * struct pages to map half the virtual address space. Then
  * position vmemmap directly below the VMALLOC region.
  */
-#define VMEMMAP_SHIFT \
-	(CONFIG_VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
-#define VMEMMAP_SIZE	(1UL << VMEMMAP_SHIFT)
-#define VMEMMAP_END	(VMALLOC_START - 1)
-#define VMEMMAP_START	(VMALLOC_START - VMEMMAP_SIZE)
-
+#ifdef CONFIG_SPARSEMEM
+#define VMEMMAP_SIZE	(UL(1) << (CONFIG_VA_BITS - PAGE_SHIFT - 1 + \
+				   STRUCT_PAGE_MAX_SHIFT))
+#define VMEMMAP_START	(KERN_SPACE_START)
+#define VMEMMAP_END	(VMEMMAP_START + VMEMMAP_SIZE - 1)
 #define vmemmap		((struct page *)VMEMMAP_START)
+#else
+#define VMEMMAP_END	KERN_SPACE_START
+#endif
+
+#ifdef CONFIG_32BIT
+#define VMALLOC_SIZE	((1UL << 30) - VMEMMAP_SIZE)
+#else
+#define VMALLOC_SIZE	(64UL << 30)
+#endif
+
+#define VMALLOC_START	(VMEMMAP_END + 1)
+#define VMALLOC_END	(VMALLOC_START + VMALLOC_SIZE - 1)
 
 /*
  * ZERO_PAGE is a global shared page that is always zero,
-- 
2.20.1

