Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09688C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C314C218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="bnbn36AX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbfCOQW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:22:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34224 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfCOQW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 12:22:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id k1so9709921wre.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 09:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LDjj5RWEKhIkugf4FVrVXHHC2KLZaBYh2/nVjE3hmOA=;
        b=bnbn36AXBuz9JDIT8TjOMOHdMBqNCzKgrpwFDUmyHxP6Gv6suYegnXvzs++Y1t1VG0
         P9dBAVbYhP3lqJf6NW3ZmUM9G22TVCUJiSfgdQothHKez3kVUGxQg1bXWbkZaaCksx4S
         MwJqVCBNARQCEZKlNbPHNFj0oVBZknemI5bxCSLlhf5oVVfsev74ol33G7avvGF9BJ11
         JI/4thLhx+5lzSgxC6HGatqUoXbn1sIjrmbjZEHTpKBjutdDJWYqoOa/MBJQhTVINsys
         tXMFLmofNYE1eG4qXeDKplOii5QBNcGUvFZAVWahxNbIgESDXC/PIIV47aDHOYct+3NY
         wF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LDjj5RWEKhIkugf4FVrVXHHC2KLZaBYh2/nVjE3hmOA=;
        b=CiQEEJYdpqh3oZIbq4iHYAjoypE4TKeI0whnVJgsaW+uu/uXcJxouTh6yzfUTWpUST
         jxmyhNMQe/rOoZRZBbkw4mELVaWfNqTYMOerUn8Ipien3csiDwtKDs6/srGrFxdjzwwS
         THPufDkeW1s+R8w9Zt8B7O+nREx6JHXggOmy/3gA3l74rRgAypfp+TFC+Ahx4lm2/0g9
         1CHc7qz/MqYzFeoARqPHbYf20u7KHSl90Z9IBuolgQOvw+jPcn2hkk4uN4JCB4v/lxLr
         QMAh02dWSnKRm/WubJ+Zs0pPzJ2Uz5CLDZSfGOzxPRLQ171Tgs+EzsxGOFGYpB/tFrsT
         5pCA==
X-Gm-Message-State: APjAAAXgmMx9sCPIBRQZa8M9k/Gx7KzWBIhq3Fr+V9T9BkWwN2I2FT1Y
        /tckkFthuwUIrktBZYqRkRtgjXLSxznSPXwVbb3xPw==
X-Google-Smtp-Source: APXvYqwwRzzHlwXoXyO1XVE9JkXn15aINryN6nMYYdnW9yXHhJji31drOeoDsQL4+RjJ6r35TYGK6udaUEq6gErTtvs=
X-Received: by 2002:adf:9427:: with SMTP id 36mr2141532wrq.128.1552666976612;
 Fri, 15 Mar 2019 09:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190312220752.128141-1-anup.patel@wdc.com> <20190312220752.128141-4-anup.patel@wdc.com>
 <20190313183121.GB28630@rapoport-lnx> <CAAhSdy1mrV2CakS0cfOY8F1B7uH_yXjO3W-CiMUcYonkRnVbeQ@mail.gmail.com>
 <20190314065311.GC24380@rapoport-lnx> <CAAhSdy2uEgyvs=5NdoZ3H208qeDGJ9OrTOeaz6HQ+1va+R3dUA@mail.gmail.com>
 <20190315155828.GB920@rapoport-lnx>
In-Reply-To: <20190315155828.GB920@rapoport-lnx>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 15 Mar 2019 21:52:45 +0530
Message-ID: <CAAhSdy0HoTTccyy203Y9m3kdAjCOzjjMdrb670huU71pjOMw4A@mail.gmail.com>
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

On Fri, Mar 15, 2019 at 9:28 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Thu, Mar 14, 2019 at 11:28:32PM +0530, Anup Patel wrote:
> > On Thu, Mar 14, 2019 at 12:23 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > >
> > > On Thu, Mar 14, 2019 at 02:36:01AM +0530, Anup Patel wrote:
> > > > On Thu, Mar 14, 2019 at 12:01 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > > > >
> > > > > On Tue, Mar 12, 2019 at 10:08:22PM +0000, Anup Patel wrote:
> > > > > > Currently, we have to boot RISCV64 kernel from a 2MB aligned physical
> > > > > > address and RISCV32 kernel from a 4MB aligned physical address. This
> > > > > > constraint is because initial pagetable setup (i.e. setup_vm()) maps
> > > > > > entire RAM using hugepages (i.e. 2MB for 3-level pagetable and 4MB for
> > > > > > 2-level pagetable).
> > > > > >
> > > > > > Further, the above booting contraint also results in memory wastage
> > > > > > because if we boot kernel from some <xyz> address (which is not same as
> > > > > > RAM start address) then RISCV kernel will map PAGE_OFFSET virtual address
> > > > > > lineraly to <xyz> physical address and memory between RAM start and <xyz>
> > > > > > will be reserved/unusable.
> > > > > >
> > > > > > For example, RISCV64 kernel booted from 0x80200000 will waste 2MB of RAM
> > > > > > and RISCV32 kernel booted from 0x80400000 will waste 4MB of RAM.
> > > > > >
> > > > > > This patch re-writes the initial pagetable setup code to allow booting
> > > > > > RISV32 and RISCV64 kernel from any 4KB (i.e. PAGE_SIZE) aligned address.
> > > > > >
> > > > > > To achieve this:
> > > > > > 1. We map kernel, dtb and only some amount of RAM (few MBs) using 4KB
> > > > > >    mappings in setup_vm() (called from head.S)
> > > > > > 2. Once we reach paging_init() (called from setup_arch()) after
> > > > > >    memblock setup, we map all available memory banks using 4KB
> > > > > >    mappings and memblock APIs.
> > > > >
> > > > > I'm not really familiar with RISC-V, but my guess would be that you'd get
> > > > > worse TLB performance with 4KB mappings. Not mentioning the amount of
> > > > > memory required for the page table itself.
> > > >
> > > > I agree we will see a hit in TLB performance due to 4KB mappings.
> > > >
> > > > To address this we can create, 2MB (or 4MB on 32bit system) mappings
> > > > whenever load_pa is aligned to it otherwise we prefer 4KB mappings. In other
> > > > words, we create bigger mappings whenever possible and fallback to 4KB
> > > > mappings when not possible.
> > > >
> > > > This way if kernel is booted from 2MB (or 4MB) aligned address then we will
> > > > see good TLB performance for kernel addresses. Also, users are still free to
> > > > boot Linux RISC-V kernel from any 4KB aligned address.
> > > >
> > > > Of course, we will have to document this as part of Linux RISC-V booting
> > > > requirements under Documentation/ (which does not exist currently).
> > > >
> > > > >
> > > > > If the only goal is to utilize the physical memory below the kernel, it
> > > > > simply should not be reserved at the first place, something like:
> > > >
> > > > Well, our goal was two-fold:
> > > >
> > > > 1. We wanted to unify boot-time alignment requirements for 32bit and
> > > > 64bit RISC-V systems
> > >
> > > Can't they both start from 4MB aligned address provided the memory below
> > > the kernel can be freed?
> >
> > Yes, they can both start from 4MB aligned address.
> >
> > >
> > > > 2. Save memory by allowing users to place kernel just after the runtime
> > > > firmware at starting of RAM.
> > >
> > > If the firmware should be alive after kernel boot, it's memory is the only
> > > part that should be reserved below the kernel. Otherwise, the entire region
> > > <physical memory start> - <kernel start> can be free.
> > >
> > > Using 4K pages for the swapper_pg_dir is quite a change and I'm not
> > > convinced its really justified.
> >
> > I understand your concern about TLB performance and more page
> > tables.
> >
> > Not just 2MB/4MB mappings, we should be able to create even 1GB
> > mappings as well for good TLB performance.
> >
> > I suggest we should use best possible mapping size (4KB, 2MB, or
> > 1GB) based on alignment of kernel load address. This way users can
> > boot from any 4KB aligned address and setup_vm() will try to use
> > biggest possible mapping size.
> >
> > For example, If the kernel load address is aligned to 2MB then we 2MB
> > mappings bigger mappings and use fewer page tables. Same thing
> > possible for 1GB mappings as well.
>
> I still don't get why it is that important to relax alignment of the kernel
> load address. Provided you can use the memory below the kernel, it really
> should not matter.

Irrespective to constraint on kernel load address, we certainly need
to allow memory below kernel to be usable but that's a separate change.

Currently, the memory below kernel is ignored by
early_init_dt_add_memory_arch() in
drivers/of/fdt.c

Regards,
Anup
