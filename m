Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F98C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7102173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="iDDm4imj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfC1KEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:04:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38257 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfC1KEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:04:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id w15so3253887wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 03:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HmLIFXfNkZvraaMu+SUWaKZg9Szlg4DGUc3DWtzRI/c=;
        b=iDDm4imj3H5g6r+2ywDcxyDVyLwQacKDck/R0DG/ClAifvTD8sVa5lqX0oOgr9DKSn
         wgKaCfk3MkiHAO0j5XotFlU+plkW9aaHmXPkn8r+sALt1rHQthbiu1kP13aUZ19fMmv8
         rXX9sp6oeig0M9wsWpUF6w7Y1N7rdQM1qUaeD4vLPBaMY+GRCPGcVSve4T9wsPX2ocAL
         8coswoFgypSrMJaOILpEmMn9omO4qf2jq90kEFj9AdLSaKjR5Qtr0ZotD4yGqGh2tZA+
         ENU+xIlvcdXBGwcWse3hLYBjROiGg2MaaYZVxyXpJwMiAC3TVHxFDmE9pJJUfevoy0aq
         nwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HmLIFXfNkZvraaMu+SUWaKZg9Szlg4DGUc3DWtzRI/c=;
        b=Gjk6SJqeiJ3QSrlieKO56BSmXXYhc9pBZwqVtJDt5CvdUUKzbczFLFlPPNSGv++U9L
         6dSxCVR4TYCmgx5alJxt/ve1yIbQX2dw2MT745R/lBzZc4talWTtV7/OIbNgXrL+W/z5
         KmCyNng5VTUaOFsNxxxfvVbXVl9hicS5B3Y+a5uVM5Sbf1T+cxN08PGQCgI18kCs6Wz9
         pnO+nbosn6X0l7yywHq914XdUYkZ19MTz2K2+IrpyzbWVTnmIJ0xuBESpZ94JJ72k1Ks
         W5ib9neVQnI/UcJ5ODcQmVyn3Td4S9vOjJK060npXUxrPFuR07hxZNf+os0uWQ3qPaTP
         L6ww==
X-Gm-Message-State: APjAAAUYGBSioeHRHS95k0wTBhTWN4LnALmuBvF76t4wnCbmNQKg1xyc
        VV3jVRYJp+KWFrDBi0FxUhcW2wlS+TSzD+Hfoj4OOA==
X-Google-Smtp-Source: APXvYqwL8sv6SSmbjr8nblpcDxHSKAKqE1uaw7r0/DezE8ufGA7VZDZPof2VI7HlpcuSNMY0vWWJbP8yGDElX5Y2oFY=
X-Received: by 2002:a1c:e185:: with SMTP id y127mr16247791wmg.76.1553767443262;
 Thu, 28 Mar 2019 03:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190327213643.23789-1-logang@deltatee.com> <20190327213643.23789-5-logang@deltatee.com>
In-Reply-To: <20190327213643.23789-5-logang@deltatee.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 28 Mar 2019 15:33:52 +0530
Message-ID: <CAAhSdy0rZCNG4582gCd2wJ9zWwRZJ8uohPLs91=Ww=+=JnG4=w@mail.gmail.com>
Subject: Re: [PATCH 4/7] RISC-V: Update page tables to cover the whole linear mapping
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        Stephen Bates <sbates@raithlin.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Christoph Hellwig <hch@lst.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Zong Li <zongbox@gmail.com>, Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 3:06 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
> With the new virtual address changes in an earlier patch, we want the
> page tables to cover more of the linear mapping region. Instead of
> only mapping from PAGE_OFFSET and up, we instead map starting
> from an aligned version of va_pa_offset such that all of the physical
> address space will be mapped.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Anup Patel <anup.patel@wdc.com>
> Cc: Atish Patra <atish.patra@wdc.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Zong Li <zongbox@gmail.com>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/riscv/kernel/setup.c |  1 -
>  arch/riscv/mm/init.c      | 27 +++++++++++++++------------
>  2 files changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index ecb654f6a79e..8286df8be31a 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -59,7 +59,6 @@ EXPORT_SYMBOL(empty_zero_page);
>  /* The lucky hart to first increment this variable will boot the other cores */
>  atomic_t hart_lottery;
>  unsigned long boot_cpu_hartid;
> -
>  void __init parse_dtb(unsigned int hartid, void *dtb)
>  {
>         if (early_init_dt_scan(__va(dtb)))
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index b9d50031e78f..315194557c3d 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -150,8 +150,8 @@ pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>  pgd_t trampoline_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
>
>  #ifndef __PAGETABLE_PMD_FOLDED
> -#define NUM_SWAPPER_PMDS ((uintptr_t)-PAGE_OFFSET >> PGDIR_SHIFT)
> -pmd_t swapper_pmd[PTRS_PER_PMD*((-PAGE_OFFSET)/PGDIR_SIZE)] __page_aligned_bss;
> +#define NUM_SWAPPER_PMDS ((uintptr_t)-VMALLOC_END >> PGDIR_SHIFT)
> +pmd_t swapper_pmd[PTRS_PER_PMD*((-VMALLOC_END)/PGDIR_SIZE)] __page_aligned_bss;
>  pmd_t trampoline_pmd[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
>  pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
>  #endif
> @@ -180,13 +180,18 @@ asmlinkage void __init setup_vm(void)
>         extern char _start;
>         uintptr_t i;
>         uintptr_t pa = (uintptr_t) &_start;
> +       uintptr_t linear_start;
> +       uintptr_t off;
>         pgprot_t prot = __pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_EXEC);
>
>         va_pa_offset = PAGE_OFFSET - pa;
>         pfn_base = PFN_DOWN(pa);
>
> +       linear_start = ALIGN_DOWN(va_pa_offset, PGDIR_SIZE);
> +       off = linear_start - va_pa_offset;
> +
>         /* Sanity check alignment and size */
> -       BUG_ON((PAGE_OFFSET % PGDIR_SIZE) != 0);
> +       BUG_ON(linear_start <= VMALLOC_END);
>         BUG_ON((pa % (PAGE_SIZE * PTRS_PER_PTE)) != 0);
>
>  #ifndef __PAGETABLE_PMD_FOLDED
> @@ -195,15 +200,14 @@ asmlinkage void __init setup_vm(void)
>                         __pgprot(_PAGE_TABLE));
>         trampoline_pmd[0] = pfn_pmd(PFN_DOWN(pa), prot);
>
> -       for (i = 0; i < (-PAGE_OFFSET)/PGDIR_SIZE; ++i) {
> -               size_t o = (PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD + i;
> -
> +       for (i = 0; i < (-linear_start)/PGDIR_SIZE; ++i) {
> +               size_t o = (linear_start >> PGDIR_SHIFT) % PTRS_PER_PGD + i;
>                 swapper_pg_dir[o] =
>                         pfn_pgd(PFN_DOWN((uintptr_t)swapper_pmd) + i,
>                                 __pgprot(_PAGE_TABLE));
>         }
>         for (i = 0; i < ARRAY_SIZE(swapper_pmd); i++)
> -               swapper_pmd[i] = pfn_pmd(PFN_DOWN(pa + i * PMD_SIZE), prot);
> +               swapper_pmd[i] = pfn_pmd(PFN_DOWN(off + i * PMD_SIZE), prot);
>
>         swapper_pg_dir[(FIXADDR_START >> PGDIR_SHIFT) % PTRS_PER_PGD] =
>                 pfn_pgd(PFN_DOWN((uintptr_t)fixmap_pmd),
> @@ -215,11 +219,10 @@ asmlinkage void __init setup_vm(void)
>         trampoline_pg_dir[(PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD] =
>                 pfn_pgd(PFN_DOWN(pa), prot);
>
> -       for (i = 0; i < (-PAGE_OFFSET)/PGDIR_SIZE; ++i) {
> -               size_t o = (PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD + i;
> -
> -               swapper_pg_dir[o] =
> -                       pfn_pgd(PFN_DOWN(pa + i * PGDIR_SIZE), prot);
> +       for (i = 0; i < (-linear_start)/PGDIR_SIZE; ++i) {
> +               size_t o = (linear_start >> PGDIR_SHIFT) % PTRS_PER_PGD + i;
> +               swapper_pg_dir[o] = pfn_pgd(PFN_DOWN(off + i * PGDIR_SIZE),
> +                                           prot);
>         }
>
>         swapper_pg_dir[(FIXADDR_START >> PGDIR_SHIFT) % PTRS_PER_PGD] =
> --
> 2.20.1
>

I understand that this patch is inline with your virtual memory layout cleanup
but the way we map virtual memory in swapper_pg_dir is bound to change.

We should not be mapping complete virtual memory in swapper_pd_dir()
rather we should only map based on amount of RAM available.

Refer, https://www.lkml.org/lkml/2019/3/24/3

The setup_vm() should only map vmlinux_start to vmlinux_end plus the
FDT. Complete virtual memory mapping should be done after we have
done early parsing of FDT when we know available memory banks in
setup_vm_final() (called from paging_init())

Regards,
Anup
