Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A32C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B8B2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="iNoDmqx3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbfCNR6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 13:58:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36145 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfCNR6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 13:58:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id e16so3682851wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 10:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eIGC0C5In0SH1lK8Am1FXe/fvjtgabXZQmRnvk65lLs=;
        b=iNoDmqx3l8Mo1FKmw3iL9Z819dRDQ6vpPRKnKIX11LvHcKTzD1B0Xxy0P08UIatPVS
         /SLutMfSdqIDIBreSEjcv2y2SqQcHbaOkYH1/JcSodRJWZjsXkiz2ay14YUtj3WCSE7A
         pS4TW7GRbuiV9d+2LAdWgZ+XuIKrjiLUhGvdRgsWqzJdr/kBU0PpZumRLONER5wLaHZv
         WEQfqe2Ht5tvR35RxxnYcKNybLG7Fp7v18/4wtE8IpGOhjEj5nKOOsaqqDjxHk3JzE5U
         bZwLrX5weCeqznAQgWPRES3gmwz2I5dCzpow+S13QiD28slsnHhhLGXaszKxtIqYCKeO
         tEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eIGC0C5In0SH1lK8Am1FXe/fvjtgabXZQmRnvk65lLs=;
        b=mf+GO9jvFhN4mcx2fSQfwa1f+MrBq25Zc4DFF/3bSg5wURElusNiCJlxE3uHaskA/i
         24TLX0RO8ZpuPkS5wHzpAeDF86aaOj+RTO9x5QZnohfHs80Lho/UpwEbUNgLclfRqskS
         WntCIviVkwxj3PzwtQVWDs+eVQh6JINXXAMnEmx8gK1KKnjs9g8q7vZCs4f5aCrZXYum
         IIMbOQ+upQBMdXgeqI6+eFWUQ1XZXT1FM+x7uqfmEiUqWkvSoLfQY0AV6QIxgWkk9WYv
         2APFVMMMljV6lSsTt3cQn90yu4MIvA8zaHJCNaaH0oB+iBNVJHqGX3iQRT26wlUd6Qao
         tOlA==
X-Gm-Message-State: APjAAAViJwKU7Cf80+IdyCy/dKMOq1c5rZH6xZSIhfzpp7p8UohMVXSA
        hD6GQlh6GQoBFI/UtctgYOMZU4xOCYCtAGZg1eDktg==
X-Google-Smtp-Source: APXvYqx+mp8SrxWThkSu4UUCKQe4xP/dBIPqf4BT2wptCL1bzVxZ+N1EZjCzzyf2BMK/dbEE/ZzCSaWV6HfUbbTm13k=
X-Received: by 2002:a1c:9c12:: with SMTP id f18mr3465802wme.16.1552586324060;
 Thu, 14 Mar 2019 10:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190312220752.128141-1-anup.patel@wdc.com> <20190312220752.128141-4-anup.patel@wdc.com>
 <20190313183121.GB28630@rapoport-lnx> <CAAhSdy1mrV2CakS0cfOY8F1B7uH_yXjO3W-CiMUcYonkRnVbeQ@mail.gmail.com>
 <20190314065311.GC24380@rapoport-lnx>
In-Reply-To: <20190314065311.GC24380@rapoport-lnx>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 14 Mar 2019 23:28:32 +0530
Message-ID: <CAAhSdy2uEgyvs=5NdoZ3H208qeDGJ9OrTOeaz6HQ+1va+R3dUA@mail.gmail.com>
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

On Thu, Mar 14, 2019 at 12:23 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Thu, Mar 14, 2019 at 02:36:01AM +0530, Anup Patel wrote:
> > On Thu, Mar 14, 2019 at 12:01 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > >
> > > On Tue, Mar 12, 2019 at 10:08:22PM +0000, Anup Patel wrote:
> > > > Currently, we have to boot RISCV64 kernel from a 2MB aligned physical
> > > > address and RISCV32 kernel from a 4MB aligned physical address. This
> > > > constraint is because initial pagetable setup (i.e. setup_vm()) maps
> > > > entire RAM using hugepages (i.e. 2MB for 3-level pagetable and 4MB for
> > > > 2-level pagetable).
> > > >
> > > > Further, the above booting contraint also results in memory wastage
> > > > because if we boot kernel from some <xyz> address (which is not same as
> > > > RAM start address) then RISCV kernel will map PAGE_OFFSET virtual address
> > > > lineraly to <xyz> physical address and memory between RAM start and <xyz>
> > > > will be reserved/unusable.
> > > >
> > > > For example, RISCV64 kernel booted from 0x80200000 will waste 2MB of RAM
> > > > and RISCV32 kernel booted from 0x80400000 will waste 4MB of RAM.
> > > >
> > > > This patch re-writes the initial pagetable setup code to allow booting
> > > > RISV32 and RISCV64 kernel from any 4KB (i.e. PAGE_SIZE) aligned address.
> > > >
> > > > To achieve this:
> > > > 1. We map kernel, dtb and only some amount of RAM (few MBs) using 4KB
> > > >    mappings in setup_vm() (called from head.S)
> > > > 2. Once we reach paging_init() (called from setup_arch()) after
> > > >    memblock setup, we map all available memory banks using 4KB
> > > >    mappings and memblock APIs.
> > >
> > > I'm not really familiar with RISC-V, but my guess would be that you'd get
> > > worse TLB performance with 4KB mappings. Not mentioning the amount of
> > > memory required for the page table itself.
> >
> > I agree we will see a hit in TLB performance due to 4KB mappings.
> >
> > To address this we can create, 2MB (or 4MB on 32bit system) mappings
> > whenever load_pa is aligned to it otherwise we prefer 4KB mappings. In other
> > words, we create bigger mappings whenever possible and fallback to 4KB
> > mappings when not possible.
> >
> > This way if kernel is booted from 2MB (or 4MB) aligned address then we will
> > see good TLB performance for kernel addresses. Also, users are still free to
> > boot Linux RISC-V kernel from any 4KB aligned address.
> >
> > Of course, we will have to document this as part of Linux RISC-V booting
> > requirements under Documentation/ (which does not exist currently).
> >
> > >
> > > If the only goal is to utilize the physical memory below the kernel, it
> > > simply should not be reserved at the first place, something like:
> >
> > Well, our goal was two-fold:
> >
> > 1. We wanted to unify boot-time alignment requirements for 32bit and
> > 64bit RISC-V systems
>
> Can't they both start from 4MB aligned address provided the memory below
> the kernel can be freed?

Yes, they can both start from 4MB aligned address.

>
> > 2. Save memory by allowing users to place kernel just after the runtime
> > firmware at starting of RAM.
>
> If the firmware should be alive after kernel boot, it's memory is the only
> part that should be reserved below the kernel. Otherwise, the entire region
> <physical memory start> - <kernel start> can be free.
>
> Using 4K pages for the swapper_pg_dir is quite a change and I'm not
> convinced its really justified.

I understand your concern about TLB performance and more page
tables.

Not just 2MB/4MB mappings, we should be able to create even 1GB
mappings as well for good TLB performance.

I suggest we should use best possible mapping size (4KB, 2MB, or
1GB) based on alignment of kernel load address. This way users can
boot from any 4KB aligned address and setup_vm() will try to use
biggest possible mapping size.

For example, If the kernel load address is aligned to 2MB then we 2MB
mappings bigger mappings and use fewer page tables. Same thing
possible for 1GB mappings as well.

Regards,
Anup
