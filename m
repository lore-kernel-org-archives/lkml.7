Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0507FC282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D349C20878
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbfDYJua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:50:30 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37224 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbfDYJua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:50:30 -0400
Received: by mail-qt1-f193.google.com with SMTP id z16so23665316qtn.4;
        Thu, 25 Apr 2019 02:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TbxWpLWKIwRpFlHLQpE/7eUBEau8QkMM1CkcgIZY8n0=;
        b=fR2NzGX86FO9SqpXcTZ1BpuYG658iVsbYDGa7Y+p++7qf2rOBYiTH2/MjXwz70aXoH
         nXYdZGljOoSgoyRrXlnsSChux2zVW8uhLlvG0EHhO/vjCwBfAdfTS5kfMJgApBGEW5b7
         OzNljDaYQqqrM7V3FqPQ6A1AvcC3p1l6ry7f+jokEiK3E20DW+OTCgy6noAefs/oujO0
         NuK1zMjqEtbIPlnasQXqdfoRpZYw4dSEvTtZWCvxmEbJpy7Wgi0IygTvp1zKLdSpjMx4
         yEvPhKif6gHMyZR+CFjx2iFrB6zk2b+hOiVss0sgHOcm0F04bJvc8ua/I/RZtNNoq/YH
         91PQ==
X-Gm-Message-State: APjAAAXb9ka4LrJxawpsB81KNY8S/ooC8hq0Bb0V4LzifXKbFrhRYNdB
        wvJqrDQguxTyCThfr9E/xf3EYqvd2w1h59EeOuY=
X-Google-Smtp-Source: APXvYqyOey7210Fu7vyUZmQh8Qn/2HLJRU5+Jv+RdBNIAeT0mrnxCT0c3EgvIDlhs0eX1rrHfV66lHE5kMmrThNu2Vg=
X-Received: by 2002:a0c:ebc2:: with SMTP id k2mr10610167qvq.149.1556185829097;
 Thu, 25 Apr 2019 02:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <1555947870-23014-1-git-send-email-guoren@kernel.org>
 <20190422161814.GA30694@lst.de> <20190423001348.GA31639@guoren-Inspiron-7460>
 <20190423055548.GA12365@lst.de> <20190423154642.GA16001@guoren-Inspiron-7460>
 <d1988350-7da9-37bb-3d8b-93bedea0b732@garyguo.net> <20190424020803.GA27332@guoren-Inspiron-7460>
 <LO2P265MB0847C9F08481E25DABC77335D63C0@LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM>
 <20190424055703.GA3417@guoren-Inspiron-7460> <4e6b0816-3fe9-8c0b-a749-f7f6ef7e5742@garyguo.net>
 <20190424142306.GB20974@lst.de>
In-Reply-To: <20190424142306.GB20974@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 25 Apr 2019 11:50:11 +0200
Message-ID: <CAK8P3a36V93mKLuR-6hZzNX+j0HVpR_9bM41653PQuD+1xMTVw@mail.gmail.com>
Subject: Re: [PATCH] riscv: Support non-coherency memory model
To:     Christoph Hellwig <hch@lst.de>
Cc:     Gary Guo <gary@garyguo.net>, Guo Ren <guoren@kernel.org>,
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

On Wed, Apr 24, 2019 at 4:23 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Apr 24, 2019 at 12:45:56PM +0000, Gary Guo wrote:
> > The RISC-V privileged spec is explicitly designed to allow the
> > techniques described above (this is the sole purpose of MSTATUS.TVM). It
> > might be as high performance as a hardware with H-extension, but is
> > definitely a legit use case. In fact, it is vital for use cases like
> > recursive virtualization.
> >
> > Also, I believe the PTE format of RISC-V is already frozen -- therefore
> > it is impossible now to merge GLOBAL and USER bit, nor to replace RSW
> > bit with another bit.
>
> Yes, I do not think we can just repurpose a bit.  Even using a currently
> unused one would require some gymnastics.
>
> That being said IFF we want to support non-coherent DMA (and I think we
> do as people glue together their SOCs using shoestring and paper clips,
> as already demonstrated by Andes and C-SKY in RISC-V space, and most
> arm, mips and ppc SOCs) we need something like this flag.  The current
> RISC-V method that only allows M-mode to set up such attributes on
> a small number or PMP regions just doesn't work well with the way how
> Linux and most non-trivial OSes implement DMA memory allocations.
>
> Note that I said well - in theory we can have a firmware provided
> uncached pool - that is what Linux does on most nommu (that is without
> pagetables) ports, but the fixed sized pool really does suck and will
> make users very unhappy.

You could probably get away with allowing uncached mappings only
for huge pages, and using one or two of the bits the PMD for it.
This should cover most use cases, since in practice coherent allocations
tend to be either small and rare (device descriptors) or very big
(frame buffer etc), and both cases can be handled with hugepages
and gen_pool_alloc, possibly CMA added in since there will likely
not be an IOMMU either on the systems that lack cache coherent DMA.

One downside is that you need a little more care for drivers that
use dma_mmap_coherent() to expose coherent buffers to user space.

Two other points about the proposal:
- Aside from completely uncached/unbuffered mappings, you typically
  want uncached/buffered mappings to cover dma_alloc_wc() that is
  typically used for frame buffers etc that need write-combining to get
  acceptable performance
- you need to decide what is supposed to happen when there are
  multiple conflicting mappings for the same physical address.

        Arnd
