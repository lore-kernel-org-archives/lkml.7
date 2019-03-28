Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8994FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3921F2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="njbrBmW5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfC1G3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 02:29:10 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38830 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfC1G3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 02:29:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id w15so2558316wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 23:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WHI5lsOf5xW8J86nqQCpKYOyKYcjxk3VbdXPr/wbqAs=;
        b=njbrBmW5t0u+VavJ0412k/ceO79/fQNiGS95FUdo2JOCvrxx8DopB1ERYy6PptL5xQ
         VohfSYdpWBVj/WfKZhj974MnLFrWfapGodCsTMAKzLnZcPZQisqtY2yrLyco/Z1L1Lv8
         jJNrQGxOQifexu88rGpkvmu1ojTzZxQQ5zLyVXeY+fRI0JK4t3jJVcuJnPoomDN9cnGJ
         N70Rn95Nk9Ut67HWQ2wQNjPNxa/F+1798aauaeLioD9CH4OpetUOA9Z/PHR+eOOE2dR/
         CX16VFckuaAptNFPgWFbfP5g4R5m0cTsVXx96+VCsh5GfOYD0Uz3jdpJvObAvlDemAFw
         u/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WHI5lsOf5xW8J86nqQCpKYOyKYcjxk3VbdXPr/wbqAs=;
        b=px77ezVN9tW+UfT5+2fWZL5F2ut8+X/7HbNrwOQV7eYGurEOcqIfjO5ITXbF7a2ScG
         SBvHjJOc+VxiGNExcx7W8m0n8SVCW9t6k/07VI/eykyN8KE2i2BwcyF5Z6wysHFmPkU/
         sEXCzYnkBBmiQtVJ6lzAeFyqfHMNjxkiIgYycLqq7MszrH4NIBMULSy9uRrRk3jADvII
         fW6fd5OB6v7zS3+Ux2S32CzLLS9rf27VgQyp7+yuoZEn7qGuhy8gvzsV7eZ4LwRGn0GZ
         00JpL/VB8MZfSUwTCMdLHLFpTpy5Z6HL/PvLzNveRSMXqqg7M556QwUfFoDPXgEmb9Ro
         YfEA==
X-Gm-Message-State: APjAAAU2VWc5ZYm4iagRPmQdg5KyPA7SKoaCpbowpZc71ZZnB9AGKS4H
        xnAhnKr6pSZjclwQiG99krQKAESB6oCSFXT0vTNCFQ==
X-Google-Smtp-Source: APXvYqzs4aS1CeGoPk0xoQCqxqnuWWEd1RcZq14orAqIKXaPecNl37WRHUKrY4oMB1itaEPC9tuq+UitC/UadKKIwkw=
X-Received: by 2002:a1c:9c14:: with SMTP id f20mr14645718wme.16.1553754547845;
 Wed, 27 Mar 2019 23:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190327213643.23789-4-logang@deltatee.com> <mhng-fca98e1a-ad61-40b6-abd8-60b0e752dcf2@palmer-si-x1c4>
In-Reply-To: <mhng-fca98e1a-ad61-40b6-abd8-60b0e752dcf2@palmer-si-x1c4>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 28 Mar 2019 11:58:56 +0530
Message-ID: <CAAhSdy1UoiGaAph3MnmnBfxhTpscjd5jYrrzr0ES6ZPcz8tH4w@mail.gmail.com>
Subject: Re: [PATCH 3/7] RISC-V: Rework kernel's virtual address space mapping
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     logang@deltatee.com,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org, sbates@raithlin.com,
        Christoph Hellwig <hch@lst.de>,
        Albert Ou <aou@eecs.berkeley.edu>, antonynpavlov@gmail.com,
        sorear2@gmail.com, Anup Patel <anup.patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 11:09 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Wed, 27 Mar 2019 14:36:39 PDT (-0700), logang@deltatee.com wrote:
> > The motivation for this is to support P2P transactions. P2P requires
> > having struct pages for IO memory which means the linear mapping must
> > be able to cover all of the IO regions. Unfortunately with Sv39 we are
> > not able to cover all the IO regions available on existing hardware,
> > but we can do better than what we currently do (which only cover's
> > physical memory).
> >
> > To this end, we restructure the kernel's virtual address space region.
> > We position the vmemmap at the beginning of the region (based on how
> > many virtual address bits we have) and the VMALLOC region comes
> > immediately after. The linear mapping then takes up the remaining space.
> > PAGE_OFFSET will need to be within the linear mapping but may not be
> > the start of the mapping seeing many machines don't have RAM at address
> > zero and we may still want to access lower addresses through the
> > linear mapping.
> >
> > With these changes, on a 64-bit system the virtual memory map (with
> > sparsemem enabled) will be:
> >
> > 32-bit:
> >
> > 00000000 - 7fffffff   user space, different per mm (2G)
> > 80000000 - 81ffffff   virtual memory map (32MB)
> > 82000000 - bfffffff   vmalloc/ioremap space (1GB - 32MB)
> > c0000000 - ffffffff   direct mapping of all phys. memory (1GB)
> >
> > 64-bit, Sv39:
> >
> > 0000000000000000 - 0000003fffffffff  user space, different per mm (256GB)
> > hole caused by [38:63] sign extension
> > ffffffc000000000 - ffffffc0ffffffff  virtual memory map (4GB)
> > ffffffc100000000 - ffffffd0ffffffff  vmalloc/ioremap spac (64GB)
> > ffffffd100000000 - ffffffffffffffff  linear mapping of phys. space (188GB)
> >
> > On the Sifive hardware this allows us to provide struct pages for
> > the lower I/O TileLink address ranges, the 32-bit and 34-bit DRAM areas
> > and 172GB of 240GB of the high I/O TileLink region. Once we progress to
> > Sv48 we should be able to cover all the available memory regions..
> >
> > For the MAXPHYSMEM_2GB case, the physical memory must be in the highest
> > 2GB of address space, so we cannot cover the any of the I/O regions
> > that are higher than it but we do cover the lower I/O TileLink range.
>
> IIRC there was another patch floating around to fix an issue with overlapping
> regions in the 32-bit port, did you also fix that issue?  It's somewhere in my
> email queue...

That was a patch I submitted to fix overlapping FIXMAP and VMALLOC
regions.

This patch does not consider FIXMAP region.

I suggest we introduce asm/memory.h where we have all critical defines
related to virtual memory layout. Also, this header should have detailed
comments about virtual memory layout.

>
> > Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> > Cc: Palmer Dabbelt <palmer@sifive.com>
> > Cc: Albert Ou <aou@eecs.berkeley.edu>
> > Cc: Antony Pavlov <antonynpavlov@gmail.com>
> > Cc: "Stefan O'Rear" <sorear2@gmail.com>
> > Cc: Anup Patel <anup.patel@wdc.com>
> > ---
> >  arch/riscv/Kconfig               |  2 +-
> >  arch/riscv/include/asm/page.h    |  2 --
> >  arch/riscv/include/asm/pgtable.h | 27 ++++++++++++++++++---------
> >  3 files changed, 19 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 76fc340ae38e..d21e6a12e8b6 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -71,7 +71,7 @@ config PAGE_OFFSET
> >       hex
> >       default 0xC0000000 if 32BIT && MAXPHYSMEM_2GB
> >       default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
> > -     default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
> > +     default 0xffffffd200000000 if 64BIT && MAXPHYSMEM_128GB
> >
> >  config ARCH_FLATMEM_ENABLE
> >       def_bool y
> > diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> > index 2a546a52f02a..fa0b8058a246 100644
> > --- a/arch/riscv/include/asm/page.h
> > +++ b/arch/riscv/include/asm/page.h
> > @@ -31,8 +31,6 @@
> >   */
> >  #define PAGE_OFFSET          _AC(CONFIG_PAGE_OFFSET, UL)
> >
> > -#define KERN_VIRT_SIZE (-PAGE_OFFSET)
> > -
> >  #ifndef __ASSEMBLY__
> >
> >  #define PAGE_UP(addr)        (((addr)+((PAGE_SIZE)-1))&(~((PAGE_SIZE)-1)))
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> > index 5a9fea00ba09..2a5070540996 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -89,22 +89,31 @@ extern pgd_t swapper_pg_dir[];
> >  #define __S110       PAGE_SHARED_EXEC
> >  #define __S111       PAGE_SHARED_EXEC
> >
> > -#define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
> > -#define VMALLOC_END      (PAGE_OFFSET - 1)
> > -#define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
> > +#define KERN_SPACE_START     (-1UL << (CONFIG_VA_BITS - 1))
> >
> >  /*
> >   * Roughly size the vmemmap space to be large enough to fit enough
> >   * struct pages to map half the virtual address space. Then
> >   * position vmemmap directly below the VMALLOC region.
> >   */
> > -#define VMEMMAP_SHIFT \
> > -     (CONFIG_VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
> > -#define VMEMMAP_SIZE (1UL << VMEMMAP_SHIFT)
> > -#define VMEMMAP_END  (VMALLOC_START - 1)
> > -#define VMEMMAP_START        (VMALLOC_START - VMEMMAP_SIZE)
> > -
> > +#ifdef CONFIG_SPARSEMEM
> > +#define VMEMMAP_SIZE (UL(1) << (CONFIG_VA_BITS - PAGE_SHIFT - 1 + \
> > +                                STRUCT_PAGE_MAX_SHIFT))
> > +#define VMEMMAP_START        (KERN_SPACE_START)
> > +#define VMEMMAP_END  (VMEMMAP_START + VMEMMAP_SIZE - 1)
> >  #define vmemmap              ((struct page *)VMEMMAP_START)
> > +#else
> > +#define VMEMMAP_END  KERN_SPACE_START
> > +#endif
> > +
> > +#ifdef CONFIG_32BIT
> > +#define VMALLOC_SIZE ((1UL << 30) - VMEMMAP_SIZE)
> > +#else
> > +#define VMALLOC_SIZE (64UL << 30)
> > +#endif
> > +
> > +#define VMALLOC_START        (VMEMMAP_END + 1)
> > +#define VMALLOC_END  (VMALLOC_START + VMALLOC_SIZE - 1)
> >
> >  /*
> >   * ZERO_PAGE is a global shared page that is always zero,

Regards,
Anup
