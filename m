Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270AAC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 06:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0700322CF7
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 06:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfHYGzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 02:55:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33104 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725792AbfHYGzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 02:55:40 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7P6rHMA125960
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 02:55:38 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ukjknv3kv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 02:55:38 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Sun, 25 Aug 2019 07:55:36 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 25 Aug 2019 07:55:31 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7P6tUiC40894948
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Aug 2019 06:55:30 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4F1F11C04A;
        Sun, 25 Aug 2019 06:55:30 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7A4F11C050;
        Sun, 25 Aug 2019 06:55:29 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.59])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 25 Aug 2019 06:55:29 +0000 (GMT)
Date:   Sun, 25 Aug 2019 09:55:28 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Rob Herring <robh@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Waterman <andrew@sifive.com>,
        Stephen Bates <sbates@raithlin.com>,
        Zong Li <zong@andestech.com>, Olof Johansson <olof@lixom.net>,
        Greentime Hu <greentime.hu@sifive.com>,
        Michael Clark <michaeljclark@mac.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5] RISC-V: Implement sparsemem
References: <20190822160439.4598-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822160439.4598-1-logang@deltatee.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19082506-0020-0000-0000-00000363BED1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082506-0021-0000-0000-000021B90303
Message-Id: <20190825065527.GA4655@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-25_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908250078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 10:04:39AM -0600, Logan Gunthorpe wrote:
> This patch implements sparsemem support for risc-v which helps pave the

Please avoid "This patch" in the commit message:
git grep "This patch" Documentation/process/submitting-patches.rst

> way for memory hotplug and eventually P2P support.
> 
> We introduce Kconfig options for virtual and physical address bits which
> are used to calculate the size of the vmemmap and set the
> MAX_PHYSMEM_BITS.
> 
> The vmemmap is located directly before the VMALLOC region and sized
> such that we can allocate enough pages to populate all the virtual
> address space in the system (similar to the way it's done in arm64).
> 
> During initialization, call memblocks_present() and sparse_init(),
> and provide a stub for vmemmap_populate() (all of which is similar to
> arm64).
> 
> [greentime.hu@sifive.com:
>   fixed pfn_valid, FIXADDR_TOP and fixed a bug rebasing onto v5.3]
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Andrew Waterman <andrew@sifive.com>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Michael Clark <michaeljclark@mac.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Zong Li <zong@andestech.com>
> ---
> 
> Changes in v5:
>  * Rebased onto v5.3-rc5 (required moving the initialization to
>    after setup_vm_final() in paging_init())
>  * Fixed FIXADDR_TOP value (per Greentime)
>  * Use generic pfn_valid() function for sparsemem to fix a bug
>    with having holes in memory (also Greentime)
> 
> Changes in v4:
>  * Rebased onto v5.0-rc1
>  * Changed the SECTION_SIZE_BITS to 27, per Nick Kossifidis
> 
> Changes in v3 (only sent the common patches):
>  * Rebased on v4.20-rc1
>  * Minor fixups
>  * Collected Ack from Will Deacon
> 
> Changes in v2:
>  * Rebase on v4.19-rc8
>  * Move the STRUCT_PAGE_MAX_SHIFT define into a common header (near
>    the definition of struct page). As suggested by Christoph.
>  * Clean up the unnecessary nid variable in the memblocks_present()
>    function, per Christoph.
>  * Collected tags from Palmer and Catalin.
> 
>  arch/riscv/Kconfig                 | 20 ++++++++++++++++++++
>  arch/riscv/include/asm/fixmap.h    |  2 +-
>  arch/riscv/include/asm/page.h      |  2 ++
>  arch/riscv/include/asm/pgtable.h   | 21 +++++++++++++++++----
>  arch/riscv/include/asm/sparsemem.h | 11 +++++++++++
>  arch/riscv/mm/init.c               | 10 ++++++++++
>  6 files changed, 61 insertions(+), 5 deletions(-)
>  create mode 100644 arch/riscv/include/asm/sparsemem.h
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 59a4727ecd6c..83faa929853c 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -62,12 +62,32 @@ config ZONE_DMA32
>  	bool
>  	default y if 64BIT
> 
> +config VA_BITS
> +	int
> +	default 32 if 32BIT
> +	default 39 if 64BIT
> +
> +config PA_BITS
> +	int
> +	default 34 if 32BIT
> +	default 56 if 64BIT
> +
>  config PAGE_OFFSET
>  	hex
>  	default 0xC0000000 if 32BIT && MAXPHYSMEM_2GB
>  	default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
>  	default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
> 
> +config ARCH_FLATMEM_ENABLE
> +	def_bool y
> +
> +config ARCH_SPARSEMEM_ENABLE
> +	def_bool y
> +	select SPARSEMEM_VMEMMAP_ENABLE

This will implicitly select CONFIG_SPARSEMEM_EXTREME=y. Probably for 32-bit
it's overkill.

> +
> +config ARCH_SELECT_MEMORY_MODEL
> +	def_bool ARCH_SPARSEMEM_ENABLE
> +
>  config ARCH_WANT_GENERAL_HUGETLB
>  	def_bool y
> 
> diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
> index 9c66033c3a54..7b0259c044c9 100644
> --- a/arch/riscv/include/asm/fixmap.h
> +++ b/arch/riscv/include/asm/fixmap.h
> @@ -31,7 +31,7 @@ enum fixed_addresses {
>  };
> 
>  #define FIXADDR_SIZE		(__end_of_fixed_addresses * PAGE_SIZE)
> -#define FIXADDR_TOP		(VMALLOC_START)
> +#define FIXADDR_TOP		(VMEMMAP_START)
>  #define FIXADDR_START		(FIXADDR_TOP - FIXADDR_SIZE)
> 
>  #define FIXMAP_PAGE_IO		PAGE_KERNEL
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index 707e00a8430b..3db261c4810f 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -110,8 +110,10 @@ extern unsigned long min_low_pfn;
>  #define page_to_bus(page)	(page_to_phys(page))
>  #define phys_to_page(paddr)	(pfn_to_page(phys_to_pfn(paddr)))
> 
> +#ifdef CONFIG_FLATMEM
>  #define pfn_valid(pfn) \
>  	(((pfn) >= pfn_base) && (((pfn)-pfn_base) < max_mapnr))
> +#endif
> 
>  #define ARCH_PFN_OFFSET		(pfn_base)
> 
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index a364aba23d55..dbc19e61ee66 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -83,6 +83,23 @@ extern pgd_t swapper_pg_dir[];
>  #define __S110	PAGE_SHARED_EXEC
>  #define __S111	PAGE_SHARED_EXEC
> 
> +#define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
> +#define VMALLOC_END      (PAGE_OFFSET - 1)
> +#define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
> +
> +/*
> + * Roughly size the vmemmap space to be large enough to fit enough
> + * struct pages to map half the virtual address space. Then
> + * position vmemmap directly below the VMALLOC region.
> + */
> +#define VMEMMAP_SHIFT \
> +	(CONFIG_VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
> +#define VMEMMAP_SIZE	(1UL << VMEMMAP_SHIFT)
> +#define VMEMMAP_END	(VMALLOC_START - 1)
> +#define VMEMMAP_START	(VMALLOC_START - VMEMMAP_SIZE)
> +
> +#define vmemmap		((struct page *)VMEMMAP_START)
> +
>  /*
>   * ZERO_PAGE is a global shared page that is always zero,
>   * used for zero-mapped memory areas, etc.
> @@ -416,10 +433,6 @@ static inline void pgtable_cache_init(void)
>  	/* No page table caches to initialize */
>  }
> 
> -#define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
> -#define VMALLOC_END      (PAGE_OFFSET - 1)
> -#define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
> -
>  /*
>   * Task size is 0x4000000000 for RV64 or 0xb800000 for RV32.
>   * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
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
> +#endif /* CONFIG_SPARSEMEM */
> +
> +#endif /* __ASM_SPARSEMEM_H */
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 42bf939693d3..73f40c9d3dee 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -442,6 +442,16 @@ static void __init setup_vm_final(void)
>  void __init paging_init(void)
>  {
>  	setup_vm_final();
> +	memblocks_present();
> +	sparse_init();
>  	setup_zero_page();
>  	zone_sizes_init();
>  }
> +
> +#ifdef CONFIG_SPARSEMEM
> +int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
> +			       struct vmem_altmap *altmap)
> +{
> +	return vmemmap_populate_basepages(start, end, node);
> +}
> +#endif
> --
> 2.20.1
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

-- 
Sincerely yours,
Mike.

