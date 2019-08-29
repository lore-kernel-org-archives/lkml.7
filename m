Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46C9C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 23:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713CC21874
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 23:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AjbYn0rj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfH2Xiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 19:38:54 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40803 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfH2Xiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 19:38:54 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so2450264pgj.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 16:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=MhwlPzIY2kWdj4huKVrX0QedBuBaf5TUkq7wJBwSziA=;
        b=AjbYn0rj8UN1t0FpZhBmRkqOqbbIpSyRF97SiXdd323h7jqjLTxHrT2CURedxxVGyJ
         RopFDkKd7XDYAb3INqyhjgV6Yz+AOQnkl9c9y4m4FsQR3n5MNpSSGgMLJPL0f+SnFVzf
         rHyM7FCGbstRrPIoI0w4x+hzphrG+kS13qKDxTNahqjhS6xhsvEkyCPkyTzL9HaeskGX
         KvL1a8X16f4c0JGi9Coi3lfRTMGAgbmxnYPLnlGAtOA4y4elVcWv/cu1DSnHUNqhT4Qy
         ojx63ov5E7LdzIm46wX3AP+/tyUMlOVQULWaXzy2l6tUWzHxyS59dt0S0EBgC2EbaSU+
         fAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=MhwlPzIY2kWdj4huKVrX0QedBuBaf5TUkq7wJBwSziA=;
        b=TZbSCcrG/RB+/8UMRc4MlHNYhosuAleEsh/0r54beY6lq9IlKdArkcKqS3Mq7UpNvj
         LV3rqYuP5XT45GD4X7tKMKKKOkjZN12ZIGzdII+XHUZJ81CfjadTGZf6L/MpMN6uQZUB
         zFq2mSsSmDmtlEDvFEWexYWmRXcRfuaiE4U+3PQNEdchlumZmu4jqCTayuPfYtFZ/yCY
         4K2ZkmRJtdL8/vNWwd5bhnNhVWMDZPq/1pXmuUrFPUgaUeHdU6wFl//iZgi7qUpxMVzD
         t4CjwFDvgRUM0QLNFTusw6UzVUlT06kcv4E8MSov74sbzuoNvwuy65PVMzUew0e3GyWo
         MPsQ==
X-Gm-Message-State: APjAAAVVMKn/MaY6gsDNp2W7EHZDn10KryExut/08519kizqsEMFbBeD
        FtRVwuiQhxcM8YUV0pvzJyXa7Q==
X-Google-Smtp-Source: APXvYqyKyJFMV4QNWMqW6ChFYPOX0fBiVWJM8o9mEdQt2BxufNattcY7BM6Mgq9CbYsoGq04plM9/w==
X-Received: by 2002:a17:90a:22f0:: with SMTP id s103mr13216264pjc.56.1567121933242;
        Thu, 29 Aug 2019 16:38:53 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id a1sm2881310pgh.61.2019.08.29.16.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 16:38:52 -0700 (PDT)
Date:   Thu, 29 Aug 2019 16:38:51 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Logan Gunthorpe <logang@deltatee.com>
cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Rob Herring <robh@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Waterman <andrew@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Zong Li <zong@andestech.com>,
        Michael Clark <michaeljclark@mac.com>,
        Olof Johansson <olof@lixom.net>,
        Greentime Hu <greentime.hu@sifive.com>,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6] RISC-V: Implement sparsemem
In-Reply-To: <20190828214054.3562-1-logang@deltatee.com>
Message-ID: <alpine.DEB.2.21.9999.1908291542160.12266@viisi.sifive.com>
References: <20190828214054.3562-1-logang@deltatee.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Logan,

On Wed, 28 Aug 2019, Logan Gunthorpe wrote:

> Implement sparsemem support for Risc-v which helps pave the
> way for memory hotplug and eventually P2P support.

Thanks very much for following up on this patch set.

One question:

> diff --git a/arch/riscv/include/asm/sparsemem.h b/arch/riscv/include/asm/sparsemem.h
> new file mode 100644
> index 000000000000..b58ba2d9ed6e
> --- /dev/null
> +++ b/arch/riscv/include/asm/sparsemem.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __ASM_SPARSEMEM_H
> +#define __ASM_SPARSEMEM_H
> +
> +#ifdef CONFIG_SPARSEMEM
> +#define MAX_PHYSMEM_BITS	CONFIG_PA_BITS
> +#define SECTION_SIZE_BITS	27

Do you have a specific rationale behind this selection, or is this simply 
a reasonable starting point?

> +#endif /* CONFIG_SPARSEMEM */
> +
> +#endif /* __ASM_SPARSEMEM_H */

The following is what I'm getting ready to queue.


- Paul


From: Logan Gunthorpe <logang@deltatee.com>
Date: Wed, 28 Aug 2019 15:40:54 -0600
Subject: [PATCH] RISC-V: Implement sparsemem

Implement sparsemem support for Risc-v which helps pave the
way for memory hotplug and eventually P2P support.

Introduce Kconfig options for virtual and physical address bits which
are used to calculate the size of the vmemmap and set the
MAX_PHYSMEM_BITS.

The vmemmap is located directly before the VMALLOC region and sized
such that we can allocate enough pages to populate all the virtual
address space in the system (similar to the way it's done in arm64).

During initialization, call memblocks_present() and sparse_init(),
and provide a stub for vmemmap_populate() (all of which is similar to
arm64).

[greentime.hu@sifive.com: fixed pfn_valid, FIXADDR_TOP and fixed a bug
 rebasing onto v5.3]
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
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
[paul.walmsley@sifive.com: updated to apply; minor commit message
 reformat]
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/Kconfig                 | 21 +++++++++++++++++++++
 arch/riscv/include/asm/page.h      |  2 ++
 arch/riscv/include/asm/pgtable.h   | 13 +++++++++++++
 arch/riscv/include/asm/sparsemem.h | 11 +++++++++++
 arch/riscv/mm/init.c               | 10 ++++++++++
 5 files changed, 57 insertions(+)
 create mode 100644 arch/riscv/include/asm/sparsemem.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 59a4727ecd6c..53b7556beb4a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -54,6 +54,7 @@ config RISCV
 	select EDAC_SUPPORT
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
+	select SPARSEMEM_STATIC if 32BIT
 
 config MMU
 	def_bool y
@@ -62,12 +63,32 @@ config ZONE_DMA32
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
index c24a083b3e12..80905b27ee98 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -83,6 +83,19 @@ extern pgd_t swapper_pg_dir[];
 #define __S110	PAGE_SHARED_EXEC
 #define __S111	PAGE_SHARED_EXEC
 
+/*
+ * Roughly size the vmemmap space to be large enough to fit enough
+ * struct pages to map half the virtual address space. Then
+ * position vmemmap directly below the VMALLOC region.
+ */
+#define VMEMMAP_SHIFT \
+	(CONFIG_VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
+#define VMEMMAP_SIZE	BIT(VMEMMAP_SHIFT)
+#define VMEMMAP_END	(VMALLOC_START - 1)
+#define VMEMMAP_START	(VMALLOC_START - VMEMMAP_SIZE)
+
+#define vmemmap		((struct page *)VMEMMAP_START)
+
 /*
  * ZERO_PAGE is a global shared page that is always zero,
  * used for zero-mapped memory areas, etc.
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
2.23.0

