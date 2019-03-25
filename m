Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7DCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 04:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC032087F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 04:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="FimwOVzQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfCYEUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 00:20:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42076 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfCYEUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 00:20:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id g3so4936318wrx.9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 21:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UahRyYH4Ih3or75zRocpLOkjc4f1gcK5Sfy8DWfMjvw=;
        b=FimwOVzQtm3SYNym8xj5HugTEhzz+bFB2krZ7khQux0xtuG1ej9Z8mq0OBGl0jiQgB
         2pSMsRTQg6oUvjPRgwIUl2RqodOWCgwGJtPHsin3UHV6NhIAQTXafTgeFyvnLRCXQQmR
         3MTRxDiVElC2Jfl1O5B+zwi70bwizCZ70JBaabZE4MVqBGZOM1Rl8PHawaEZsBgCFijF
         nG05Joa+fjNuxrTKV91r7E6VqFyURu8OORMWZ7OvOlQHcY5t7ZMvDk1v2Yb5HrB9SRfF
         7ybnY3li3omD1k3zPRINiE4ZBXkF74lyQgAqEusI/shSD6mSoCiwOzHsrfJmH1flYEaF
         enEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UahRyYH4Ih3or75zRocpLOkjc4f1gcK5Sfy8DWfMjvw=;
        b=sxsT2tqKPfE4m/6o3nh8jVS/ppLhFzzhTRiESdC0IvEDDwD3CrwGFtJabKsQJ1uZ3g
         7I46PqeKU6Vt1QRXfh6pMttTlFsAh1UnIMNlie1gSFl5FsR494N0MwX0rv7VmQ07J+Kc
         oaGquUeJRnY3iDdCDc+KYzEGKl/Bj0vxCbmNVVzmLcmFi1K5WphGk0pqIE++JvT2Ok7s
         JcOW3Dg1hbitTZHPnMVU8y0iJ6U7izusvmDoP+vk/aaLAbjQgklqFrHtPlciPgxaZtkC
         onqMV+2jEqaNL95qjshIKDDWmXThs0Nla4VrFcx2o6WpaVWcpOIOP7Q1xTndfrRfqcnb
         rBDQ==
X-Gm-Message-State: APjAAAWgpVIkpwlhdZp+rXhQnpyMVo3W4/fAsFpbHq63QfziAIikfNtO
        er7r4IeFR5kF95Fh/i8DTjCI5Aa6o8ndMenKsYt1Xw==
X-Google-Smtp-Source: APXvYqw/md2Z/vPYOnvWCNPDHtz5hq563mBSa30gBWnUvp1xdQG16LjCUqhbM32AyRETg4lOy16T+rVxWZTOu5rkueU=
X-Received: by 2002:a5d:4087:: with SMTP id o7mr2383979wrp.9.1553487607801;
 Sun, 24 Mar 2019 21:20:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190321094710.16552-1-anup.patel@wdc.com> <20190321094710.16552-3-anup.patel@wdc.com>
 <20190323154459.GC25149@rapoport-lnx>
In-Reply-To: <20190323154459.GC25149@rapoport-lnx>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 25 Mar 2019 09:49:55 +0530
Message-ID: <CAAhSdy2pgoEknshuJT3z-QdPMMtw5fwWM2tzRUaGvZ1Hjn-SGQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] RISC-V: Make setup_vm() independent of GCC code model
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 9:15 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Thu, Mar 21, 2019 at 09:47:47AM +0000, Anup Patel wrote:
> > The setup_vm() must access kernel symbols in a position independent way
> > because it will be called from head.S with MMU off.
> >
> > If we compile kernel with cmodel=medany then PC-relative addressing will
> > be used in setup_vm() to access kernel symbols so it works perfectly fine.
> >
> > Although, if we compile kernel with cmodel=medlow then either absolute
> > addressing or PC-relative addressing (based on whichever requires fewer
> > instructions) is used to access kernel symbols in setup_vm(). This can
> > break setup_vm() whenever any absolute addressing is used to access
> > kernel symbols.
> >
> > With the movement of setup_vm() from kernel/setup.c to mm/init.c, the
> > setup_vm() is now broken for cmodel=medlow but it works perfectly fine
> > for cmodel=medany.
> >
> > This patch fixes setup_vm() and makes it independent of GCC code model
> > by accessing kernel symbols relative to kernel load address instead of
> > assuming PC-relative addressing.
> >
> > Fixes: 6f1e9e946f0b ("RISC-V: Move setup_vm() to mm/init.c")
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > ---
> >  arch/riscv/kernel/head.S |  1 +
> >  arch/riscv/mm/init.c     | 73 ++++++++++++++++++++++++++--------------
> >  2 files changed, 49 insertions(+), 25 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> > index fe884cd69abd..7966262b4f9d 100644
> > --- a/arch/riscv/kernel/head.S
> > +++ b/arch/riscv/kernel/head.S
> > @@ -62,6 +62,7 @@ clear_bss_done:
> >
> >       /* Initialize page tables and relocate to virtual addresses */
> >       la sp, init_thread_union + THREAD_SIZE
> > +     la a0, _start
> >       call setup_vm
> >       call relocate
> >
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index b379a75ac6a6..e38f8195e45b 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -172,55 +172,78 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
> >       }
> >  }
> >
> > -asmlinkage void __init setup_vm(void)
> > +static inline void *__load_addr(void *ptr, uintptr_t load_pa)
> >  {
> >       extern char _start;
> > +     uintptr_t va = (uintptr_t)ptr;
> > +     uintptr_t sz = (uintptr_t)(&_end) - (uintptr_t)(&_start);
> > +
> > +     if (va >= PAGE_OFFSET && va <= (PAGE_OFFSET + sz))
> > +             return (void *)(load_pa + (va - PAGE_OFFSET));
> > +     return (void *)va;
> > +}
> > +
> > +#define __load_va(ptr, load_pa)      __load_addr(ptr, load_pa)
> > +#define __load_pa(ptr, load_pa)      ((uintptr_t)__load_addr(ptr, load_pa))
> > +
> > +asmlinkage void __init setup_vm(uintptr_t load_pa)
> > +{
> >       uintptr_t i;
> > -     uintptr_t pa = (uintptr_t) &_start;
> > +#ifndef __PAGETABLE_PMD_FOLDED
> > +     pmd_t *pmdp;
> > +#endif
> > +     pgd_t *pgdp;
> > +     phys_addr_t map_pa;
> > +     pgprot_t tableprot = __pgprot(_PAGE_TABLE);
> >       pgprot_t prot = __pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_EXEC);
> >
> > -     va_pa_offset = PAGE_OFFSET - pa;
> > -     pfn_base = PFN_DOWN(pa);
> > +     va_pa_offset = PAGE_OFFSET - load_pa;
> > +     pfn_base = PFN_DOWN(load_pa);
> >
> >       /* Sanity check alignment and size */
> >       BUG_ON((PAGE_OFFSET % PGDIR_SIZE) != 0);
> > -     BUG_ON((pa % (PAGE_SIZE * PTRS_PER_PTE)) != 0);
> > +     BUG_ON((load_pa % (PAGE_SIZE * PTRS_PER_PTE)) != 0);
> >
> >  #ifndef __PAGETABLE_PMD_FOLDED
> > -     trampoline_pg_dir[(PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD] =
> > -             pfn_pgd(PFN_DOWN((uintptr_t)trampoline_pmd),
> > -                     __pgprot(_PAGE_TABLE));
> > -     trampoline_pmd[0] = pfn_pmd(PFN_DOWN(pa), prot);
> > +     pgdp = __load_va(trampoline_pg_dir, load_pa);
> > +     map_pa = __load_pa(trampoline_pmd, load_pa);
> > +     pgdp[(PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD] =
>
> Can we use pgd_index(PAGE_OFFSET) here as index to PGD?
>
> > +             pfn_pgd(PFN_DOWN(map_pa), tableprot);
>
> It seems that __load_pa result is always used with PFN_DOWN(), it's worth
> adding __load_pfn(). Then the last two statements become
>
>         map_pfn = __load_pfn(trampoline_pmd, load_pa);
>         pgdp[pgd_index(PAGE_OFFSET)] = pfn_pgd(map_pfn, tableprot);
>
> This applies to most of the mappings below as well.

Thanks for the comments.

I am going to drop this patch because we have other patch which uses
"CFLAGS_init.o := -cmodel=medany" in mm/Makefile

Regards,
Anup
