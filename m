Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A43C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1594208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556294772;
	bh=355LDZZF5SsAW/JoaL+5ckFu/tIXsBseyPFco5aHxrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TFIQp6uqPMu1vHvZ43+7hBVR03h354VvmxktJs5p+4dhdh2UgrKAZG8C2s2VzgMrj
	 peb9+5GBD4fDt6we9tKxKWek+YQQaBgLrzdQ1huTtkDSSgsAerZ02+6lOU11LzU8pI
	 +fIIUH7kuVPULjZPVRhH6HpwyRiWfP7BG2DrO7PQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfDZQGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:06:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbfDZQGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 12:06:11 -0400
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C6EC2077B;
        Fri, 26 Apr 2019 16:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556294769;
        bh=355LDZZF5SsAW/JoaL+5ckFu/tIXsBseyPFco5aHxrM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s1pp8Xn88ach76ZLeCYA2w9qxm1lphHGjNx7oO7GATQVaoyWuXOvAd/SYTJlD5UoP
         WatczYj6RKG+1P1kAzs5c0tssr3mfz8HNf4CKc+jaXeTljvTVubWZPB7LQhmolXKUF
         ewNIp/eT/coCaaNXeplTnWhSwbkEiewrKuZmg95w=
Date:   Sat, 27 Apr 2019 00:05:58 +0800
From:   Guo Ren <guoren@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
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
Subject: Re: [PATCH] riscv: Support non-coherency memory model
Message-ID: <20190426160558.GA10540@guoren-Inspiron-7460>
References: <20190423001348.GA31639@guoren-Inspiron-7460>
 <20190423055548.GA12365@lst.de>
 <20190423154642.GA16001@guoren-Inspiron-7460>
 <d1988350-7da9-37bb-3d8b-93bedea0b732@garyguo.net>
 <20190424020803.GA27332@guoren-Inspiron-7460>
 <LO2P265MB0847C9F08481E25DABC77335D63C0@LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM>
 <20190424055703.GA3417@guoren-Inspiron-7460>
 <4e6b0816-3fe9-8c0b-a749-f7f6ef7e5742@garyguo.net>
 <20190424142306.GB20974@lst.de>
 <CAK8P3a36V93mKLuR-6hZzNX+j0HVpR_9bM41653PQuD+1xMTVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a36V93mKLuR-6hZzNX+j0HVpR_9bM41653PQuD+1xMTVw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Thu, Apr 25, 2019 at 11:50:11AM +0200, Arnd Bergmann wrote:
> On Wed, Apr 24, 2019 at 4:23 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Wed, Apr 24, 2019 at 12:45:56PM +0000, Gary Guo wrote:
> > > The RISC-V privileged spec is explicitly designed to allow the
> > > techniques described above (this is the sole purpose of MSTATUS.TVM). It
> > > might be as high performance as a hardware with H-extension, but is
> > > definitely a legit use case. In fact, it is vital for use cases like
> > > recursive virtualization.
> > >
> > > Also, I believe the PTE format of RISC-V is already frozen -- therefore
> > > it is impossible now to merge GLOBAL and USER bit, nor to replace RSW
> > > bit with another bit.
> >
> > Yes, I do not think we can just repurpose a bit.  Even using a currently
> > unused one would require some gymnastics.
> >
> > That being said IFF we want to support non-coherent DMA (and I think we
> > do as people glue together their SOCs using shoestring and paper clips,
> > as already demonstrated by Andes and C-SKY in RISC-V space, and most
> > arm, mips and ppc SOCs) we need something like this flag.  The current
> > RISC-V method that only allows M-mode to set up such attributes on
> > a small number or PMP regions just doesn't work well with the way how
> > Linux and most non-trivial OSes implement DMA memory allocations.
> >
> > Note that I said well - in theory we can have a firmware provided
> > uncached pool - that is what Linux does on most nommu (that is without
> > pagetables) ports, but the fixed sized pool really does suck and will
> > make users very unhappy.
> 
> You could probably get away with allowing uncached mappings only
> for huge pages, and using one or two of the bits the PMD for it.
> This should cover most use cases, since in practice coherent allocations
> tend to be either small and rare (device descriptors) or very big
> (frame buffer etc), and both cases can be handled with hugepages
> and gen_pool_alloc, possibly CMA added in since there will likely
> not be an IOMMU either on the systems that lack cache coherent DMA.
Generally attributs in huge-tlb-entry and leaf-tlb-entry should be the
same. Only put _PAGE_CACHE and _PAGE_BUF bits in huge-tlb-entry sounds
a bit strange.

The gen_pool_alloc only 256KB by default, but a huge tlb entry is 4MB.
Hardware couldn't setup vitual-4MB to a phys-256KB range mapping in TLB.

> 
> One downside is that you need a little more care for drivers that
> use dma_mmap_coherent() to expose coherent buffers to user space.
> 
> Two other points about the proposal:
> - Aside from completely uncached/unbuffered mappings, you typically
>   want uncached/buffered mappings to cover dma_alloc_wc() that is
>   typically used for frame buffers etc that need write-combining to get
>   acceptable performance
I agree dma_alloc_wc is necessary, and we need add another more attribute
bit in PTE: _PAGE_BUF. 
Perhaps using _PAGE_BUF + _PAGE_CACHE are better then _PAGE_CONHENCY.

> - you need to decide what is supposed to happen when there are
>   multiple conflicting mappings for the same physical address.
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
What's the mulitple confilcing mappings ?

Best Regards
 Guo Ren
