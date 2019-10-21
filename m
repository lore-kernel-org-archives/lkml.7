Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B32CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC76206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+kNgEV8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfJUJeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:34:11 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37001 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfJUJeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:34:10 -0400
Received: by mail-qt1-f193.google.com with SMTP id g50so5822476qtb.4;
        Mon, 21 Oct 2019 02:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8CxkzgTmPkrymJWAPgp0fFXJhTloQdA6b1Ea9fnYKuY=;
        b=L+kNgEV8QbF5ZsQfyH8RpPoSaKJD31XAaPMxUBqwz7vm3U4fZThVvllEBss6dO+71B
         7eDZAPqEdGoI5MK40AfCoKSwLW58Xr0+chN1wfo7/e/hhzYsdzDCiE7aTpH/20Npa4Jb
         z48I2Pc5CcA0JYLW0lDplJfRZjlRhBbXpuom1d4/qE/OSC+Bgw4uA8O2wQBzfoYgw1XV
         49UrrhsWzuUb98hyfyaWybiJIuWJnWlZaCD/ssyJyXV2fIjLNV6ntC3+RmCNvLPPEKYy
         /AytOfri4t3KoyV0OZp9Tr6cFCFb3KHo5/gpmqdkUTWdmsjvJbZBVOW74NmbNtvsSEA9
         0xrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8CxkzgTmPkrymJWAPgp0fFXJhTloQdA6b1Ea9fnYKuY=;
        b=Ys0tokxXWk+QftpDp+xFuUZ5hc1rs9OZqIMeDVvWvrTQjdnhP0ZBUh1rQriKfrlpxb
         PwhfvoEJ6UvKK3j+8syjBPl1UI0QzzXF+/mY0Wx17TGYs2cw0N732gJw6KL9jHYVu1QK
         8PlVrKSLoPnzcbo5v2ARmLMna2XHvmxQNBUUuqDXiMQkWfV5pL+tqCkaPySleYTHMaQf
         BgXlQzi5usE2z6GxgL3hiusxHKciIzgRd080vc0ilbxpPKe+P/Mc15qR+B83/vcm+XIu
         Xu9fpxTMrAUPDxakxMZhKhLXCisJ08p/nIXvGScm+b5zZo5SNYoXJEfP4o4eBG/H2PNF
         KAlA==
X-Gm-Message-State: APjAAAX++nwiuojWYk/L4yWQt61uXdWI8ODK8jHevq7T1zvG++d6cLcM
        Xb/g0zfrXizxJ1Lcj6uWjKYf+/GLcS1d+A9ig/c=
X-Google-Smtp-Source: APXvYqy5XWNX/s45M0McpPWie+MRsqfaR3wgkLI5TwKSG32xUTpsZgc2DzZEd1w7Wm1rgnHd5oZvjh0UI229VE/NC+8=
X-Received: by 2002:ac8:24d4:: with SMTP id t20mr23895504qtt.114.1571650448518;
 Mon, 21 Oct 2019 02:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1570514544.git.nickhu@andestech.com> <8d86d53e904bece0623cb8969cdc70f782fa2bae.1570514544.git.nickhu@andestech.com>
In-Reply-To: <8d86d53e904bece0623cb8969cdc70f782fa2bae.1570514544.git.nickhu@andestech.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Mon, 21 Oct 2019 17:33:31 +0800
Message-ID: <CAEbi=3fTKqt545tEz6c-RCdKniq2ZxOqvamFpJsbe=D+gpGBcQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] riscv: Add KASAN support
To:     Nick Hu <nickhu@andestech.com>,
        Greentime Hu <greentime.hu@sifive.com>
Cc:     alankao@andestech.com, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, aryabinin@virtuozzo.com,
        glider@google.com, dvyukov@google.com, corbet@lwn.net,
        alexios.zavras@intel.com, allison@lohutok.net, Anup.Patel@wdc.com,
        Thomas Gleixner <tglx@linutronix.de>,
        gregkh@linuxfoundation.org, atish.patra@wdc.com,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Hu <nickhu@andestech.com> =E6=96=BC 2019=E5=B9=B410=E6=9C=888=E6=97=A5=
 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=882:17=E5=AF=AB=E9=81=93=EF=BC=9A
>
> This patch ports the feature Kernel Address SANitizer (KASAN).
>
> Note: The start address of shadow memory is at the beginning of kernel
> space, which is 2^64 - (2^39 / 2) in SV39. The size of the kernel space i=
s
> 2^38 bytes so the size of shadow memory should be 2^38 / 8. Thus, the
> shadow memory would not overlap with the fixmap area.
>
> There are currently two limitations in this port,
>
> 1. RV64 only: KASAN need large address space for extra shadow memory
> region.
>
> 2. KASAN can't debug the modules since the modules are allocated in VMALL=
OC
> area. We mapped the shadow memory, which corresponding to VMALLOC area, t=
o
> the kasan_early_shadow_page because we don't have enough physical space f=
or
> all the shadow memory corresponding to VMALLOC area.
>
> Signed-off-by: Nick Hu <nickhu@andestech.com>
> ---
>  arch/riscv/Kconfig                  |   1 +
>  arch/riscv/include/asm/kasan.h      |  27 ++++++++
>  arch/riscv/include/asm/pgtable-64.h |   5 ++
>  arch/riscv/include/asm/string.h     |   9 +++
>  arch/riscv/kernel/head.S            |   3 +
>  arch/riscv/kernel/riscv_ksyms.c     |   2 +
>  arch/riscv/kernel/setup.c           |   5 ++
>  arch/riscv/kernel/vmlinux.lds.S     |   1 +
>  arch/riscv/lib/memcpy.S             |   5 +-
>  arch/riscv/lib/memset.S             |   5 +-
>  arch/riscv/mm/Makefile              |   6 ++
>  arch/riscv/mm/kasan_init.c          | 104 ++++++++++++++++++++++++++++
>  12 files changed, 169 insertions(+), 4 deletions(-)
>  create mode 100644 arch/riscv/include/asm/kasan.h
>  create mode 100644 arch/riscv/mm/kasan_init.c
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 8eebbc8860bb..ca2fc8ba8550 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -61,6 +61,7 @@ config RISCV
>         select SPARSEMEM_STATIC if 32BIT
>         select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
>         select HAVE_ARCH_MMAP_RND_BITS
> +       select HAVE_ARCH_KASAN if MMU && 64BIT
>
>  config ARCH_MMAP_RND_BITS_MIN
>         default 18 if 64BIT
> diff --git a/arch/riscv/include/asm/kasan.h b/arch/riscv/include/asm/kasa=
n.h
> new file mode 100644
> index 000000000000..eb9b1a2f641c
> --- /dev/null
> +++ b/arch/riscv/include/asm/kasan.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2019 Andes Technology Corporation */
> +
> +#ifndef __ASM_KASAN_H
> +#define __ASM_KASAN_H
> +
> +#ifndef __ASSEMBLY__
> +
> +#ifdef CONFIG_KASAN
> +
> +#include <asm/pgtable.h>
> +
> +#define KASAN_SHADOW_SCALE_SHIFT       3
> +
> +#define KASAN_SHADOW_SIZE      (UL(1) << (38 - KASAN_SHADOW_SCALE_SHIFT)=
)
> +#define KASAN_SHADOW_START     0xffffffc000000000 // 2^64 - 2^38
> +#define KASAN_SHADOW_END       (KASAN_SHADOW_START + KASAN_SHADOW_SIZE)
> +
> +#define KASAN_SHADOW_OFFSET    (KASAN_SHADOW_END - (1ULL << \
> +                                       (64 - KASAN_SHADOW_SCALE_SHIFT)))
> +
> +void kasan_init(void);
> +asmlinkage void kasan_early_init(void);
> +
> +#endif
> +#endif
> +#endif /* __ASM_KASAN_H */
> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm=
/pgtable-64.h
> index 7df8daa66cc8..777a1dddb3df 100644
> --- a/arch/riscv/include/asm/pgtable-64.h
> +++ b/arch/riscv/include/asm/pgtable-64.h
> @@ -59,6 +59,11 @@ static inline unsigned long pud_page_vaddr(pud_t pud)
>         return (unsigned long)pfn_to_virt(pud_val(pud) >> _PAGE_PFN_SHIFT=
);
>  }
>
> +static inline struct page *pud_page(pud_t pud)
> +{
> +       return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
> +}
> +
>  #define pmd_index(addr) (((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
>
>  static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
> diff --git a/arch/riscv/include/asm/string.h b/arch/riscv/include/asm/str=
ing.h
> index 1b5d44585962..a4451f768826 100644
> --- a/arch/riscv/include/asm/string.h
> +++ b/arch/riscv/include/asm/string.h
> @@ -11,8 +11,17 @@
>
>  #define __HAVE_ARCH_MEMSET
>  extern asmlinkage void *memset(void *, int, size_t);
> +extern asmlinkage void *__memset(void *, int, size_t);
>
>  #define __HAVE_ARCH_MEMCPY
>  extern asmlinkage void *memcpy(void *, const void *, size_t);
> +extern asmlinkage void *__memcpy(void *, const void *, size_t);
>
> +// For those files which don't want to check by kasan.
> +#if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
> +
> +#define memcpy(dst, src, len) __memcpy(dst, src, len)
> +#define memset(s, c, n) __memset(s, c, n)
> +
> +#endif
>  #endif /* _ASM_RISCV_STRING_H */
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 72f89b7590dd..95eca23cd811 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -102,6 +102,9 @@ clear_bss_done:
>         sw zero, TASK_TI_CPU(tp)
>         la sp, init_thread_union + THREAD_SIZE
>
> +#ifdef CONFIG_KASAN
> +       call kasan_early_init
> +#endif
>         /* Start the kernel */
>         call parse_dtb
>         tail start_kernel
> diff --git a/arch/riscv/kernel/riscv_ksyms.c b/arch/riscv/kernel/riscv_ks=
yms.c
> index 4800cf703186..376bba7f65ce 100644
> --- a/arch/riscv/kernel/riscv_ksyms.c
> +++ b/arch/riscv/kernel/riscv_ksyms.c
> @@ -14,3 +14,5 @@ EXPORT_SYMBOL(__asm_copy_to_user);
>  EXPORT_SYMBOL(__asm_copy_from_user);
>  EXPORT_SYMBOL(memset);
>  EXPORT_SYMBOL(memcpy);
> +EXPORT_SYMBOL(__memset);
> +EXPORT_SYMBOL(__memcpy);
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index a990a6cb184f..41f7eae9bc4d 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -23,6 +23,7 @@
>  #include <asm/smp.h>
>  #include <asm/tlbflush.h>
>  #include <asm/thread_info.h>
> +#include <asm/kasan.h>
>
>  #ifdef CONFIG_DUMMY_CONSOLE
>  struct screen_info screen_info =3D {
> @@ -70,6 +71,10 @@ void __init setup_arch(char **cmdline_p)
>         swiotlb_init(1);
>  #endif
>
> +#ifdef CONFIG_KASAN
> +       kasan_init();
> +#endif
> +
>  #ifdef CONFIG_SMP
>         setup_smp();
>  #endif
> diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.=
lds.S
> index 23cd1a9e52a1..97009803ba9f 100644
> --- a/arch/riscv/kernel/vmlinux.lds.S
> +++ b/arch/riscv/kernel/vmlinux.lds.S
> @@ -46,6 +46,7 @@ SECTIONS
>                 KPROBES_TEXT
>                 ENTRY_TEXT
>                 IRQENTRY_TEXT
> +               SOFTIRQENTRY_TEXT
>                 *(.fixup)
>                 _etext =3D .;
>         }
> diff --git a/arch/riscv/lib/memcpy.S b/arch/riscv/lib/memcpy.S
> index b4c477846e91..51ab716253fa 100644
> --- a/arch/riscv/lib/memcpy.S
> +++ b/arch/riscv/lib/memcpy.S
> @@ -7,7 +7,8 @@
>  #include <asm/asm.h>
>
>  /* void *memcpy(void *, const void *, size_t) */
> -ENTRY(memcpy)
> +ENTRY(__memcpy)
> +WEAK(memcpy)
>         move t6, a0  /* Preserve return value */
>
>         /* Defer to byte-oriented copy for small sizes */
> @@ -104,4 +105,4 @@ ENTRY(memcpy)
>         bltu a1, a3, 5b
>  6:
>         ret
> -END(memcpy)
> +END(__memcpy)
> diff --git a/arch/riscv/lib/memset.S b/arch/riscv/lib/memset.S
> index 5a7386b47175..34c5360c6705 100644
> --- a/arch/riscv/lib/memset.S
> +++ b/arch/riscv/lib/memset.S
> @@ -8,7 +8,8 @@
>  #include <asm/asm.h>
>
>  /* void *memset(void *, int, size_t) */
> -ENTRY(memset)
> +ENTRY(__memset)
> +WEAK(memset)
>         move t0, a0  /* Preserve return value */
>
>         /* Defer to byte-oriented fill for small sizes */
> @@ -109,4 +110,4 @@ ENTRY(memset)
>         bltu t0, a3, 5b
>  6:
>         ret
> -END(memset)
> +END(__memset)
> diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> index 9d9a17335686..b8a8ca71f86e 100644
> --- a/arch/riscv/mm/Makefile
> +++ b/arch/riscv/mm/Makefile
> @@ -17,3 +17,9 @@ ifeq ($(CONFIG_MMU),y)
>  obj-$(CONFIG_SMP) +=3D tlbflush.o
>  endif
>  obj-$(CONFIG_HUGETLB_PAGE) +=3D hugetlbpage.o
> +obj-$(CONFIG_KASAN)   +=3D kasan_init.o
> +
> +ifdef CONFIG_KASAN
> +KASAN_SANITIZE_kasan_init.o :=3D n
> +KASAN_SANITIZE_init.o :=3D n
> +endif
> diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
> new file mode 100644
> index 000000000000..c3152768cdbe
> --- /dev/null
> +++ b/arch/riscv/mm/kasan_init.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2019 Andes Technology Corporation
> +
> +#include <linux/pfn.h>
> +#include <linux/init_task.h>
> +#include <linux/kasan.h>
> +#include <linux/kernel.h>
> +#include <linux/memblock.h>
> +#include <asm/tlbflush.h>
> +#include <asm/pgtable.h>
> +#include <asm/fixmap.h>
> +
> +extern pgd_t early_pg_dir[PTRS_PER_PGD];
> +asmlinkage void __init kasan_early_init(void)
> +{
> +       uintptr_t i;
> +       pgd_t *pgd =3D early_pg_dir + pgd_index(KASAN_SHADOW_START);
> +
> +       for (i =3D 0; i < PTRS_PER_PTE; ++i)
> +               set_pte(kasan_early_shadow_pte + i,
> +                       mk_pte(virt_to_page(kasan_early_shadow_page),
> +                       PAGE_KERNEL));
> +
> +       for (i =3D 0; i < PTRS_PER_PMD; ++i)
> +               set_pmd(kasan_early_shadow_pmd + i,
> +                pfn_pmd(PFN_DOWN(__pa((uintptr_t)kasan_early_shadow_pte)=
),
> +                       __pgprot(_PAGE_TABLE)));
> +
> +       for (i =3D KASAN_SHADOW_START; i < KASAN_SHADOW_END;
> +            i +=3D PGDIR_SIZE, ++pgd)
> +               set_pgd(pgd,
> +                pfn_pgd(PFN_DOWN(__pa(((uintptr_t)kasan_early_shadow_pmd=
))),
> +                       __pgprot(_PAGE_TABLE)));
> +
> +       // init for swapper_pg_dir
> +       pgd =3D pgd_offset_k(KASAN_SHADOW_START);
> +
> +       for (i =3D KASAN_SHADOW_START; i < KASAN_SHADOW_END;
> +            i +=3D PGDIR_SIZE, ++pgd)
> +               set_pgd(pgd,
> +                pfn_pgd(PFN_DOWN(__pa(((uintptr_t)kasan_early_shadow_pmd=
))),
> +                       __pgprot(_PAGE_TABLE)));
> +
> +       flush_tlb_all();
> +}
> +
> +static void __init populate(void *start, void *end)
> +{
> +       unsigned long i;
> +       unsigned long vaddr =3D (unsigned long)start & PAGE_MASK;
> +       unsigned long vend =3D PAGE_ALIGN((unsigned long)end);
> +       unsigned long n_pages =3D (vend - vaddr) / PAGE_SIZE;
> +       unsigned long n_pmds =3D
> +               (n_pages % PTRS_PER_PTE) ? n_pages / PTRS_PER_PTE + 1 :
> +                                               n_pages / PTRS_PER_PTE;
> +       pgd_t *pgd =3D pgd_offset_k(vaddr);
> +       pmd_t *pmd =3D memblock_alloc(n_pmds * sizeof(pmd_t), PAGE_SIZE);
> +       pte_t *pte =3D memblock_alloc(n_pages * sizeof(pte_t), PAGE_SIZE)=
;
> +
> +       for (i =3D 0; i < n_pages; i++) {
> +               phys_addr_t phys =3D memblock_phys_alloc(PAGE_SIZE, PAGE_=
SIZE);
> +
> +               set_pte(pte + i, pfn_pte(PHYS_PFN(phys), PAGE_KERNEL));
> +       }
> +
> +       for (i =3D 0; i < n_pages; ++pmd, i +=3D PTRS_PER_PTE)
> +               set_pmd(pmd, pfn_pmd(PFN_DOWN(__pa((uintptr_t)(pte + i)))=
,
> +                               __pgprot(_PAGE_TABLE)));
> +
> +       for (i =3D vaddr; i < vend; i +=3D PGDIR_SIZE, ++pgd)
> +               set_pgd(pgd, pfn_pgd(PFN_DOWN(__pa(((uintptr_t)pmd))),
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +                               __pgprot(_PAGE_TABLE)));
> +

Hi Nick,

I verify this patch in Qemu and Unleashed board.
I found it works well if DRAM size is less than 4GB.
It will get an access fault if the DRAM size is larger than 4GB.

I spend some time to debug this case and I found it hang in the
following memset().
It is because the mapping is not created correctly. I check the page
table creating logic again and I found it always sets the last pmd
here.
