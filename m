Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E981C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5895D206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvsmJSY7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfGaGa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 02:30:59 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38415 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbfGaGa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 02:30:58 -0400
Received: by mail-qt1-f193.google.com with SMTP id n11so65455974qtl.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 23:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g8nItbMM/u3EZmck6TSNg6UVm0fJwxDLYDMDa7Zz324=;
        b=FvsmJSY7dAxlvRpffF12qeOoNVbiPRYAtPSJI8O61y8XN0fX3BpGPf3KCwJCQQjOTa
         /A6M1qqQKlqsdVUApUKgVgBKFawv5IvWbFQBMoX3bmmLAG3SDIVjgGiyHBNsR/vwjnNC
         wNyTLEXeB715LxE9/cxqtl0/0hA1KUUTpMFeOZuxF2h2FcwXVQFb2bKtikYmwhj9YWMq
         CToXCOxel+3tMooDBoxkilLn2A9HXfJ+yX54yKE3GJX07HgxxfroWKsRQ2dhvmLc0Kbe
         R8avhGBHXwlyQ2R8j40tOnTvMGbFVQ3qKRhEKov62p0SOYjSSifJLocTgsEx1vLHxgjw
         Z0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g8nItbMM/u3EZmck6TSNg6UVm0fJwxDLYDMDa7Zz324=;
        b=sEomRJFNOU9Jh3x5+4xR9PZKslubcLjdV91FfEk6uLuxMF5lUJN2dSO59mgRebWMTn
         7JLDW6Z8ZbLanT3UBwYmj4p84yeXRzOiqeyv/hG28qtj9FHY3dNlL9WBPDS2/kchk1Jg
         vV6yaAbE3hiPwsPf9fq4eu34yzM27BVfmbOhatwmr3vV0j/qP6mw03mdEzxBwqzex2KI
         D7EaKvc1iciDbjsbQQ+Z1RdnNPJb1GLxRUwz4gHQ1qSCJFqvAi5XhIVpNEuWZYRVrrkw
         mGw4LIIpBug2VV7EHdbkKxIfT3aQ9872FXV/E4DztDhoYv33KtFgyDep4MWe+BN6zOnz
         FErg==
X-Gm-Message-State: APjAAAUoo1xMZsh1JK4iZ6LRPVkXWiideBCUeM1pvefvN3DeusiAL+hx
        7mXORob+U0dnlR4y1CUDw2j+y4YoschFiQ7NboA=
X-Google-Smtp-Source: APXvYqzhKs1RXGLfufF8Chihr4VcG9vF870gLMrR+3UH/rdIoTDvdAyHdH4erUbGIhEiU6XLGYCV7AsFm3VOV9MAwHU=
X-Received: by 2002:ac8:32a1:: with SMTP id z30mr85187344qta.117.1564554657287;
 Tue, 30 Jul 2019 23:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190109203911.7887-1-logang@deltatee.com> <20190109203911.7887-3-logang@deltatee.com>
In-Reply-To: <20190109203911.7887-3-logang@deltatee.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Wed, 31 Jul 2019 14:30:22 +0800
Message-ID: <CAEbi=3d0RNVKbDUwRL-o70O12XBV7q6n_UT-pLqFoh9omYJZKQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] RISC-V: Implement sparsemem
To:     Logan Gunthorpe <logang@deltatee.com>, greentime.hu@sifive.com,
        paul.walmsley@sifive.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        Stephen Bates <sbates@raithlin.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Christoph Hellwig <hch@lst.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Waterman <andrew@sifive.com>,
        Olof Johansson <olof@lixom.net>,
        Michael Clark <michaeljclark@mac.com>,
        Rob Herring <robh@kernel.org>, Zong Li <zong@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Logan,

Logan Gunthorpe <logang@deltatee.com> =E6=96=BC 2019=E5=B9=B41=E6=9C=8810=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=885:07=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> This patch implements sparsemem support for risc-v which helps pave the
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
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Andrew Waterman <andrew@sifive.com>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Michael Clark <michaeljclark@mac.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Zong Li <zong@andestech.com>
> ---
>  arch/riscv/Kconfig                 | 23 +++++++++++++++++++++++
>  arch/riscv/include/asm/pgtable.h   | 21 +++++++++++++++++----
>  arch/riscv/include/asm/sparsemem.h | 11 +++++++++++
>  arch/riscv/kernel/setup.c          |  4 +++-
>  arch/riscv/mm/init.c               |  8 ++++++++
>  5 files changed, 62 insertions(+), 5 deletions(-)
>  create mode 100644 arch/riscv/include/asm/sparsemem.h
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index e0d7d61779a6..bd659327bc6b 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -54,12 +54,32 @@ config ZONE_DMA32
>         bool
>         default y if 64BIT
>
> +config VA_BITS
> +       int
> +       default 32 if 32BIT
> +       default 39 if 64BIT
> +
> +config PA_BITS
> +       int
> +       default 34 if 32BIT
> +       default 56 if 64BIT
> +
>  config PAGE_OFFSET
>         hex
>         default 0xC0000000 if 32BIT && MAXPHYSMEM_2GB
>         default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
>         default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
>
> +config ARCH_FLATMEM_ENABLE
> +       def_bool y
> +
> +config ARCH_SPARSEMEM_ENABLE
> +       def_bool y
> +       select SPARSEMEM_VMEMMAP_ENABLE
> +
> +config ARCH_SELECT_MEMORY_MODEL
> +       def_bool ARCH_SPARSEMEM_ENABLE
> +
>  config STACKTRACE_SUPPORT
>         def_bool y
>
> @@ -94,6 +114,9 @@ config PGTABLE_LEVELS
>  config HAVE_KPROBES
>         def_bool n
>
> +config HAVE_ARCH_PFN_VALID
> +       def_bool y
> +
>  menu "Platform type"
>
>  choice
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pg=
table.h
> index 16301966d65b..e1162336f5ea 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -89,6 +89,23 @@ extern pgd_t swapper_pg_dir[];
>  #define __S110 PAGE_SHARED_EXEC
>  #define __S111 PAGE_SHARED_EXEC
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
> +       (CONFIG_VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
> +#define VMEMMAP_SIZE   (1UL << VMEMMAP_SHIFT)
> +#define VMEMMAP_END    (VMALLOC_START - 1)
> +#define VMEMMAP_START  (VMALLOC_START - VMEMMAP_SIZE)
> +
> +#define vmemmap                ((struct page *)VMEMMAP_START)
> +
>  /*
>   * ZERO_PAGE is a global shared page that is always zero,
>   * used for zero-mapped memory areas, etc.
> @@ -411,10 +428,6 @@ static inline void pgtable_cache_init(void)
>         /* No page table caches to initialize */
>  }
>
> -#define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
> -#define VMALLOC_END      (PAGE_OFFSET - 1)
> -#define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
> -
>  /*
>   * Task size is 0x40000000000 for RV64 or 0xb800000 for RV32.
>   * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
> diff --git a/arch/riscv/include/asm/sparsemem.h b/arch/riscv/include/asm/=
sparsemem.h
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
> +#define MAX_PHYSMEM_BITS       CONFIG_PA_BITS
> +#define SECTION_SIZE_BITS      27
> +#endif /* CONFIG_SPARSEMEM */
> +
> +#endif /* __ASM_SPARSEMEM_H */
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index fc8006a042eb..98f39adefb1a 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -193,6 +193,9 @@ static void __init setup_bootmem(void)
>                                   PFN_PHYS(end_pfn - start_pfn),
>                                   &memblock.memory, 0);
>         }
> +
> +       memblocks_present();
> +       sparse_init();
>  }

I just applied this patch to Linux kernel 5.2.
I used a dts with 2 memory nodes with hole int it.

memory@80000000 {
    device_type =3D "memory";
    reg =3D <0x0 0x80000000 0x0 0x40000000>;
};
memory@180000000 {
    device_type =3D "memory";
    reg =3D <0x1 0x80000000 0x0 0x40000000>;
};

I found it will boot failure. Did I miss anything?

[ 0.000000] Sorting __ex_table...
[ 0.000000] BUG: Bad page state in process swapper pfn:180001
[ 0.000000] page:ffffffcf05400038 refcount:0 mapcount:94371937
mapping:00000000ffffffff index:0x4000000000000000
[ 0.000000] anon
[ 0.000000] flags: 0x0()
[ 0.000000] raw: 0000000000000000 0000000000000000 0000000000000000
00000000ffffffff
[ 0.000000] raw: 4000000000000000 ffffffcf05a00060 0000000005a00060
[ 0.000000] page dumped because: non-NULL mapping
[ 0.000000] Modules linked in:
[ 0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.2.0-00001-g737d8214d9=
a9 #3
[ 0.000000] Call Trace:
[ 0.000000] [<ffffffe00017759c>] walk_stackframe+0x0/0xa0
[ 0.000000] [<ffffffe00017769c>] show_stack+0x2a/0x34
[ 0.000000] [<ffffffe00070c53e>] dump_stack+0x62/0x7c
[ 0.000000] [<ffffffe0002330ae>] bad_page+0xca/0x120
[ 0.000000] [<ffffffe00023313c>] free_pages_check_bad+0x38/0x7a
[ 0.000000] [<ffffffe00023368a>] __free_pages_ok+0x496/0x4ba
[ 0.000000] [<ffffffe000234a82>] __free_pages.part.4+0xe/0x22
[ 0.000000] [<ffffffe000234c9e>] __free_pages_core+0x9a/0xa6
[ 0.000000] [<ffffffe000009b0a>] memblock_free_pages+0x12/0x1a
[ 0.000000] [<ffffffe00000b496>] memblock_free_all+0x144/0x1a8
[ 0.000000] [<ffffffe00000274a>] mem_init+0x28/0x36
[ 0.000000] [<ffffffe0000008a0>] start_kernel+0x1bc/0x360
[ 0.000000] [<ffffffe000000074>] clear_bss_done+0x34/0x38
[ 0.000000] Disabling lock debugging due to kernel taint
[ 0.000000] BUG: Bad page state in process swapper pfn:180002
[ 0.000000] page:ffffffcf05400070 refcount:0 mapcount:94371993
mapping:00000000ffffffff index:0x4000000000000000
[ 0.000000] anon
[ 0.000000] flags: 0x0()
[ 0.000000] raw: 0000000000000000 0000000000000000 0000000000000000
00000000ffffffff
[ 0.000000] raw: 4000000000000000 ffffffcf05a00098 0000000005a00098
[ 0.000000] page dumped because: non-NULL mapping
[ 0.000000] Modules linked in:
[ 0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G B
5.2.0-00001-g737d8214d9a9 #3
[ 0.000000] Call Trace:
[ 0.000000] [<ffffffe00017759c>] walk_stackframe+0x0/0xa0
[ 0.000000] [<ffffffe00017769c>] show_stack+0x2a/0x34
[ 0.000000] [<ffffffe00070c53e>] dump_stack+0x62/0x7c
[ 0.000000] [<ffffffe0002330ae>] bad_page+0xca/0x120
[ 0.000000] [<ffffffe00023313c>] free_pages_check_bad+0x38/0x7a
[ 0.000000] [<ffffffe00023368a>] __free_pages_ok+0x496/0x4ba
[ 0.000000] [<ffffffe000234a82>] __free_pages.part.4+0xe/0x22
[ 0.000000] [<ffffffe000234c9e>] __free_pages_core+0x9a/0xa6
[ 0.000000] [<ffffffe000009b0a>] memblock_free_pages+0x12/0x1a
[ 0.000000] [<ffffffe00000b496>] memblock_free_all+0x144/0x1a8
[ 0.000000] [<ffffffe00000274a>] mem_init+0x28/0x36
[ 0.000000] [<ffffffe0000008a0>] start_kernel+0x1bc/0x360
[ 0.000000] [<ffffffe000000074>] clear_bss_done+0x34/0x38
[ 0.000000] BUG: Bad page state in process swapper pfn:180003
[ 0.000000] page:ffffffcf054000a8 refcount:0 mapcount:94372049
mapping:00000000ffffffff index:0x4000000000000000
[ 0.000000] anon
[ 0.000000] flags: 0x0()
[ 0.000000] raw: 0000000000000000 0000000000000000 0000000000000000
00000000ffffffff
[ 0.000000] raw: 4000000000000000 ffffffcf05a000d0 0000000005a000d0
[ 0.000000] page dumped because: non-NULL mapping

I look this issue more closely.
I found it always sets each memblock region to node 0. Does this make sense=
?
I am not sure if I understand this correctly. Do you have any idea for
this? Thank you. :)

for_each_memblock(memory, reg) {
    unsigned long start_pfn =3D memblock_region_memory_base_pfn(reg);
    unsigned long end_pfn =3D memblock_region_memory_end_pfn(reg);
    memblock_set_node(PFN_PHYS(start_pfn), PFN_PHYS(end_pfn -
start_pfn), &memblock.memory, 0);


                     ^^^
}

[ 0.000000] Early memory node ranges
[ 0.000000] node 0: [mem 0x0000000080200000-0x00000000bfffffff]
[ 0.000000] node 0: [mem 0x0000000180000000-0x00000001bfffffff]
[ 0.000000] Initmem setup node 0 [mem 0x0000000080200000-0x00000001bfffffff=
]
