Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DB4C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 05:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2586E20843
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 05:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfDWF4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 01:56:07 -0400
Received: from verein.lst.de ([213.95.11.211]:44208 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfDWF4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 01:56:07 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 4150C68B02; Tue, 23 Apr 2019 07:55:49 +0200 (CEST)
Date:   Tue, 23 Apr 2019 07:55:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Guo Ren <guoren@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, ren_guo@c-sky.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, tech-privileged@lists.riscv.org,
        Andrew Waterman <andrew@sifive.com>,
        Anup Patel <anup.patel@wdc.com>, Arnd Bergmann <arnd@arndb.de>,
        Greentime Hu <green.hu@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Scott Wood <swood@redhat.com>,
        Vincent Chen <vincentc@andestech.com>,
        Xiang Xiaoyan <xiaoyan_xiang@c-sky.com>
Subject: Re: [PATCH] riscv: Support non-coherency memory model
Message-ID: <20190423055548.GA12365@lst.de>
References: <1555947870-23014-1-git-send-email-guoren@kernel.org> <20190422161814.GA30694@lst.de> <20190423001348.GA31639@guoren-Inspiron-7460>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423001348.GA31639@guoren-Inspiron-7460>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 08:13:48AM +0800, Guo Ren wrote:
> > We should probably start a working group for this ASAP unless we can
> > get another working group to help taking care of it.
> Good news, I prefer to use instructions directly instead of SBI_CALL.
> 
> Our instruction is "dcache.c/iva %0" (one cache line) and the parameter is
> virtual address in S-state. When get into M-state by SBI_CALL, we could
> let dcache.c/iva use physical addres directly and it needn't kmap page
> for RV32 with highmem (Of cause highmem is not ready in RV32 now).

So you only have one instruction variant?  Normally we'd have two or
three to implement the non-coherent DMA (or pmem) semantics:

cache writeback, cache invalidate and potentially cache writeback +
invalidate to optimize that case.  Here is the table how Linux
uses them for DMA:

          |   map          ==  for_device     |   unmap     ==  for_cpu
          |----------------------------------------------------------------
 TO_DEV   |   writeback        writeback      |   none          none
 FROM_DEV |   invalidate       invalidate     |   invalidate*   invalidate*
 BIDI     |   writeback+inv    writeback+inv  |   invalidate    invalidate

     [*] needed for CPU speculative prefetches


We already have a discussion on isa-dev on something like these
instructions:

https://groups.google.com/a/groups.riscv.org/forum/#!msg/isa-dev/qXbzqaQbDXU/4ThcEAeCCAAJ

It got a little side tracked, both due to the usual noise on isa-dev
and due to the proposal including a lot more instructions that might be
a little more contentious, but it might be a good start to bring this
into a working group.

> > Also is this really a coherent flag, or an 'uncached' flag like in
> > many other architectures?
> There are a lot of features about coherency attributes, eg: cacheable,
> bufferable, strong order ..., and coherency is a more abstract name to
> contain all of these. In our hardware, coherence = uncached +
> unbufferable + (stong order).
> 
> But I'm not very care about the name is, uncached is also ok. My key
> point is the bits of page attributes is very precious and this patch
> will use the last unused attribute bit in PTE.

I don't care about the name actually, more about having defined semantics.
Totally uncached should include unbuffered.  I don't think we need the
strong ordering for DMA memory either.

> Another point is we could get more attribute bits by modify the riscv
> spec:
>  - Remove Global bit, I think it's duplicate with the User bit in linux.

It is in Linux, but it is conceptually very different.

>  - Change _PAGE_PFN_SHIFT from 10 to 12, because the huge pfn in RV32 is
>    very useless and current RV32 linux doesn't even implement highmem.

This would seem sensible to me, but I'm not sure everyone agrees.  Even
then we are very late in the game for changes like that.
