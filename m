Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A02C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 03:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6082171F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 03:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="2AllWECy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbfCXDco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 23:32:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47086 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbfCXDco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 23:32:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id o1so6354291wrs.13
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 20:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5r5BnJmBdEeR/Dv9Ixv/XBgxXRYB+lCzjMiA1TLjrxM=;
        b=2AllWECyHNVdDWdGmXG3lZ/Yh4+CrRBHOFVG/W8CmEa/aq913z87NR6MXsFItvj4gJ
         PY6v0y6rpiElfAIuWXSI+EXbQ1F5aS5AwWYrekhxYKatsylJhe9DuRZZQG124crIQM7Y
         MLE1gfSsWSNZRedEewc3lruHi15EeaSo/lWkxp+zMN1qyKM+PddhKs462wdGueehZRRi
         FyhZ4mEomgfhpKJGpGfrcAP04UaNrIu12gKvgKaP6PKWeG2txus1f6SFNEG3iEmrrFic
         ycK02sKtwiR5QbS7gFi3QBL/w4CbJjwWNRIGt6mL+/IRwzsh//aDKVDO+X0JldoDQaPB
         tHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5r5BnJmBdEeR/Dv9Ixv/XBgxXRYB+lCzjMiA1TLjrxM=;
        b=fKaXC/2feFQ6dcs4ZyB/vzmjHgDxfCblRFe/fkG2EjM6w7+yw4T5H0pSF5JjrjAbYy
         70mqmdV5VAEAv6Zimk9jtvSbINqSfvWDoXCGSspf0AR0IEuTeQMukI2mPihjzVUz34em
         aGqy53yQETnIuNFAyjnEPnB0vufzbTTkUHwvqoyFpmPjcXKTfqjl8U1gLAl6w4gPbihE
         74JGS+aWfZinvUf8ZJbRZgbLCPicHwS2XhSTKmyZOs9CAIaE2m6vhurq2Cm/ItQmwzak
         xDD7MbaRYxKGJ0z2BtGRrNGddv3sF/XHHRJNkgd63p8glOYkbqh/d9R0P/IhRQk6e9rv
         MIZw==
X-Gm-Message-State: APjAAAW/YMmIrB+k6n83ng6EwdaMPVtgL1DcpAhZPwnhTF/yIb2MndgL
        TWmgmRUT/WlGD54lnKIg3diUhKVMXgsLh6P09Iy3qQ==
X-Google-Smtp-Source: APXvYqzZOBi3gtlVEklHVhBx+XcBOyXaK4/PmJSGRdZ/nRYL0+FoevrUxknF1S3nGnpQDeJH2UVQdr2gYqarqLUYto4=
X-Received: by 2002:adf:fe03:: with SMTP id n3mr6925904wrr.59.1553398362654;
 Sat, 23 Mar 2019 20:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190321094710.16552-1-anup.patel@wdc.com> <20190321094710.16552-4-anup.patel@wdc.com>
 <20190323154012.GA25149@rapoport-lnx>
In-Reply-To: <20190323154012.GA25149@rapoport-lnx>
From:   Anup Patel <anup@brainfault.org>
Date:   Sun, 24 Mar 2019 09:02:31 +0530
Message-ID: <CAAhSdy1enG_9o1rtZcwhht6e_-t2G1-yUy8Q5ENjnQKKW4UTeA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] RISC-V: Allow booting kernel from any 4KB aligned address
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

On Sat, Mar 23, 2019 at 9:10 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Thu, Mar 21, 2019 at 09:47:51AM +0000, Anup Patel wrote:
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
> > 1. We add kconfig option BOOT_PAGE_ALIGNED. When it is enabled we use
> >    4KB mappings in initial page table setup otherwise we use 2MB/4MB
> >    mappings.
> > 2. We map kernel and dtb (few MBs) in setup_vm() (called from head.S)
> > 3. Once we reach paging_init() (called from setup_arch()) after
> >    memblock setup, we map all available memory banks.
> >
> > With this patch in-place, the booting constraint for RISCV32 and RISCV64
> > kernel is much more relaxed when CONFIG_BOOT_PAGE_ALIGNED=y and we can
> > now boot kernel very close to RAM start thereby minimizng memory wastage.
>
> I have no general objection, but I presume the patch will be significantly
> simplified if the addition of 4K pages support will follow the removal of
> the trampoline_pd_dir.
>
> That said, I didn't look into the details, since they will change
> substantially, only some comments on the Kconfig part.
>
> On the high level, have you considered using large pages in setup_vm() and
> the remapping everything with 4K pages in setup_vm_final()?  This might
> save you the whole ops-> churn.

Yes, it can save the ops churn in setup_vm() but we should let setup_vm()
choose best possible mapping size based on load address alignment hence
it's better have common page table setup code shared between early and
final page table setup which can create mapping of any size.

For example, if we are booted from 1G aligned load address then setup_vm()
should create 1G mapping thereby getting better performance compared to
2M mappings.

Regards,
Anup
