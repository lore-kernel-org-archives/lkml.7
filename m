Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38007C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2EAF2070D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="2RiDmuXn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfCMVGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:06:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32883 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfCMVGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 17:06:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id c13so5341966wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 14:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jooKZ6bjOshpJ4KeSFoPxNiKTgfel8e+7adx53/EYZI=;
        b=2RiDmuXnNuN0BEV42QZDZB35/jW0v86X1mIML1uA5+ylaPHh5Puryetbenqf/rbiUk
         pd14iTL8EUIBgqt05xdLIZlD8X12gDn3ipwaQx5MOYfPg1k8qQ2r5Q+tejQJytgMK8tn
         46Zk1AetVsw48nXVb8CWigq+y9mkzcrC77IihtRa9IgujCfS5hUydXbDvUJQ1/vKyWwg
         Lzr3Hshm2iXIbVSrrgPsVlsUrfBwF0qSIU/8BHeSi9hr+iyOzH1ksDSLfMJCVIrcgenM
         zh9xko+RaygiBnWvqbGjivptbfq2pEMp4H7EpWbQBZWsQStj7YmisOgdoPBRjIdq4eec
         YQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jooKZ6bjOshpJ4KeSFoPxNiKTgfel8e+7adx53/EYZI=;
        b=TnoSVGSzXhgO7wQUmlC3PrSVAo+3owSJzTSxNPtQEmTmnrOobC1dKm1ywpz1rJs/cA
         1aEQstPn5ExxSuaEbQJH+o5KbASjDwxL7DZym4mxi7rkGD3b03cMBy80cOK1a8GVo+i3
         zbEAT2u37Sl6oaHRrjj86M5iTU8cM4Jvgzb90OiRXbceI6i2jYvIg4sg0+R9ZvQIgSiR
         OhfuLz0MQcYXRVR9/G0N4yIYbYaovfi9ub4Jtme7GIsM5aPbqu1ADm1122NSFPG0xFNC
         AjNOUK8BqJKTGfxG2A+SGj++BkhdyU/KH5JtWzni/jf5/VJSiC3lM3BeQkBg2GqgOyyV
         r+mQ==
X-Gm-Message-State: APjAAAWPmMrhwL3Pf/UhUjlkjCDBs8Ti9Zq1iakaZSl2Kau23hKEQCEA
        VloaIvJ2Thv0MGolhiWVFEj0UM9Lo4Mxg/jQwtBpKg+K
X-Google-Smtp-Source: APXvYqyiVLuOBtzhh7YfprNbwUo2FOcmqGAFw45zxzCJIZgbG3DNDdUt3J+A6GailyukrbGR8C+ESqZWoHB2f6+1fbU=
X-Received: by 2002:a7b:c0d5:: with SMTP id s21mr90829wmh.153.1552511172923;
 Wed, 13 Mar 2019 14:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190312220752.128141-1-anup.patel@wdc.com> <20190312220752.128141-4-anup.patel@wdc.com>
 <20190313183121.GB28630@rapoport-lnx>
In-Reply-To: <20190313183121.GB28630@rapoport-lnx>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 14 Mar 2019 02:36:01 +0530
Message-ID: <CAAhSdy1mrV2CakS0cfOY8F1B7uH_yXjO3W-CiMUcYonkRnVbeQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] RISC-V: Allow booting kernel from any 4KB aligned address
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

On Thu, Mar 14, 2019 at 12:01 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Tue, Mar 12, 2019 at 10:08:22PM +0000, Anup Patel wrote:
> > Currently, we have to boot RISCV64 kernel from a 2MB aligned physical
> > address and RISCV32 kernel from a 4MB aligned physical address. This
> > constraint is because initial pagetable setup (i.e. setup_vm()) maps
> > entire RAM using hugepages (i.e. 2MB for 3-level pagetable and 4MB for
> > 2-level pagetable).
> >
> > Further, the above booting contraint also results in memory wastage
> > because if we boot kernel from some <xyz> address (which is not same as
> > RAM start address) then RISCV kernel will map PAGE_OFFSET virtual address
> > lineraly to <xyz> physical address and memory between RAM start and <xyz>
> > will be reserved/unusable.
> >
> > For example, RISCV64 kernel booted from 0x80200000 will waste 2MB of RAM
> > and RISCV32 kernel booted from 0x80400000 will waste 4MB of RAM.
> >
> > This patch re-writes the initial pagetable setup code to allow booting
> > RISV32 and RISCV64 kernel from any 4KB (i.e. PAGE_SIZE) aligned address.
> >
> > To achieve this:
> > 1. We map kernel, dtb and only some amount of RAM (few MBs) using 4KB
> >    mappings in setup_vm() (called from head.S)
> > 2. Once we reach paging_init() (called from setup_arch()) after
> >    memblock setup, we map all available memory banks using 4KB
> >    mappings and memblock APIs.
>
> I'm not really familiar with RISC-V, but my guess would be that you'd get
> worse TLB performance with 4KB mappings. Not mentioning the amount of
> memory required for the page table itself.

I agree we will see a hit in TLB performance due to 4KB mappings.

To address this we can create, 2MB (or 4MB on 32bit system) mappings
whenever load_pa is aligned to it otherwise we prefer 4KB mappings. In other
words, we create bigger mappings whenever possible and fallback to 4KB
mappings when not possible.

This way if kernel is booted from 2MB (or 4MB) aligned address then we will
see good TLB performance for kernel addresses. Also, users are still free to
boot Linux RISC-V kernel from any 4KB aligned address.

Of course, we will have to document this as part of Linux RISC-V booting
requirements under Documentation/ (which does not exist currently).

>
> If the only goal is to utilize the physical memory below the kernel, it
> simply should not be reserved at the first place, something like:

Well, our goal was two-fold:

1. We wanted to unify boot-time alignment requirements for 32bit and
64bit RISC-V systems
2. Save memory by allowing users to place kernel just after the runtime
firmware at starting of RAM.

>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index b379a75..6301ced 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -108,6 +108,7 @@ void __init setup_bootmem(void)
>         /* Find the memory region containing the kernel */
>         for_each_memblock(memory, reg) {
>                 phys_addr_t vmlinux_end = __pa(_end);
> +               phys_addr_t vmlinux_start = __pa(start);
>                 phys_addr_t end = reg->base + reg->size;
>
>                 if (reg->base <= vmlinux_end && vmlinux_end <= end) {
> @@ -115,7 +116,8 @@ void __init setup_bootmem(void)
>                          * Reserve from the start of the region to the end of
>                          * the kernel
>                          */
> -                       memblock_reserve(reg->base, vmlinux_end - reg->base);
> +                       memblock_reserve(vmlinux_start,
> +                                        vmlinux_end - vmlinux_start);
>                         mem_size = min(reg->size, (phys_addr_t)-PAGE_OFFSET);
>                 }
>         }

Thanks for above changes. I will include them in my next revision.

Regards,
Anup
