Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139EBC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E795420B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfDZSnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:43:02 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46083 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfDZSnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 14:43:01 -0400
Received: by mail-qt1-f195.google.com with SMTP id w26so5170756qto.13;
        Fri, 26 Apr 2019 11:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h+WijXhsv6/Jv9J1vWUI/spfYQQ6sFmzaS3I18sGJBE=;
        b=oA+SR1lNmMDVPJLDHVZWMVBYdrN12gL6MblyLUwdiJsFfqR5F6A44CJ+iicBJclLtK
         LV5C/AfymhisPiKayjjE/1Wu76IIgCoRMRuhtU+bF18lK7RQfNqGkdHzsmBCcwkb2yPZ
         Rjnvz7Ujs9WIKxYrWXDqQ6mBUAl+eS0PgX/BYLNssCUZ2jXxMQrlo1kWVlTdfjuPuEX3
         Hdk0VnCKI9GFIQnui7wubtFvuNnUqWoNNA1RADxwhDdesMI4H7rndTJiivTTNj954H/n
         FHKMRM4BUbXpswA5neQAlXn3DSLPBbWTUZj/aJ0rGXegvAltFj/aOlEwdEASVjhJenFd
         /ZrA==
X-Gm-Message-State: APjAAAXQ00cVwRgm1REnEcRDYb8y9S54OA+RwDt+N24a93wfs4r12Fjx
        HAvStQLRsDyEfORaGXaa7QCWZgfBneEf3D3T1Ek=
X-Google-Smtp-Source: APXvYqwkz7sLNRz6nM5GTfEzeyWyPg/S+2Namakb1a1AJPUlLmKnkSTU8tbWod0e0yvkmgBkqmfpQb7YXWBG/+GbpYU=
X-Received: by 2002:ac8:8cd:: with SMTP id y13mr26650331qth.96.1556304180530;
 Fri, 26 Apr 2019 11:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190423001348.GA31639@guoren-Inspiron-7460> <20190423055548.GA12365@lst.de>
 <20190423154642.GA16001@guoren-Inspiron-7460> <d1988350-7da9-37bb-3d8b-93bedea0b732@garyguo.net>
 <20190424020803.GA27332@guoren-Inspiron-7460> <LO2P265MB0847C9F08481E25DABC77335D63C0@LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM>
 <20190424055703.GA3417@guoren-Inspiron-7460> <4e6b0816-3fe9-8c0b-a749-f7f6ef7e5742@garyguo.net>
 <20190424142306.GB20974@lst.de> <CAK8P3a36V93mKLuR-6hZzNX+j0HVpR_9bM41653PQuD+1xMTVw@mail.gmail.com>
 <20190426160558.GA10540@guoren-Inspiron-7460>
In-Reply-To: <20190426160558.GA10540@guoren-Inspiron-7460>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 26 Apr 2019 20:42:42 +0200
Message-ID: <CAK8P3a2CvvBMZ8UkkgyrczgUccSGZ35RpG8V2dGUXbuOh9AZ5A@mail.gmail.com>
Subject: Re: [PATCH] riscv: Support non-coherency memory model
To:     Guo Ren <guoren@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Gary Guo <gary@garyguo.net>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Andrew Waterman <andrew@sifive.com>,
        Anup Patel <anup.patel@wdc.com>,
        Xiang Xiaoyan <xiaoyan_xiang@c-sky.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vincent Chen <vincentc@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        "ren_guo@c-sky.com" <ren_guo@c-sky.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Scott Wood <swood@redhat.com>,
        "tech-privileged@lists.riscv.org" <tech-privileged@lists.riscv.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 6:06 PM Guo Ren <guoren@kernel.org> wrote:
> On Thu, Apr 25, 2019 at 11:50:11AM +0200, Arnd Bergmann wrote:
> > On Wed, Apr 24, 2019 at 4:23 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > You could probably get away with allowing uncached mappings only
> > for huge pages, and using one or two of the bits the PMD for it.
> > This should cover most use cases, since in practice coherent allocations
> > tend to be either small and rare (device descriptors) or very big
> > (frame buffer etc), and both cases can be handled with hugepages
> > and gen_pool_alloc, possibly CMA added in since there will likely
> > not be an IOMMU either on the systems that lack cache coherent DMA.
>
> Generally attributs in huge-tlb-entry and leaf-tlb-entry should be the
> same. Only put _PAGE_CACHE and _PAGE_BUF bits in huge-tlb-entry sounds
> a bit strange.

Well, the point is that we can't really change the meaning of the existing
low bits, but because of the alignment contraints on hugepages, the extra bits
are currently unused for hugepage TLBs.
There are other architectures that reuse the bits in clever ways, e.g.
allowing larger physical address ranges to be used with hugepages than
normal pages.

> The gen_pool_alloc only 256KB by default, but a huge tlb entry is 4MB.
> Hardware couldn't setup vitual-4MB to a phys-256KB range mapping in TLB.

I expect the size would be easily changed, as long as there is sufficient
physical memory. If the entire system has 32MB or less, setting 2MB aside
would have a fairly significant impact of course.


> > - you need to decide what is supposed to happen when there are
> >   multiple conflicting mappings for the same physical address.
>     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> What's the mulitple confilcing mappings ?

I mean when you have the linear mapping as cacheable and another
mapping for the same physical page as uncacheable, and then access
virtual address in both. This is usually a bad idea, but architectures
go to different lengths to prevent it.

The safest way would be for the CPU to produce a checkstop as soon
as there are TLB entries for the same physical address but different
caching settings. You can also do that if you have a cache-bypassing
load/store that hits a live cache line.

The other extreme would be to not do anything special and try to come
up with sane behavior, e.g. allow accesses in both ways but ensure that
a cache-bypassing load/store always flushes and invalidates cache
lines for the same physical address before its access.

       Arnd
