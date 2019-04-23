Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7A7C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068EE218CD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556034418;
	bh=xlGscSs9dL++G38J6mR9vhBpBgSSGaJk6NuPAmkk4ZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SlJMonQ1jo1sQXskDEqy70xYhLPEHPDWUpfLxRwSFS+REGBT2seITcM3O97STPqBu
	 nS9Wz4vssEwdRA88+skaV1nJSKCURefHRtbvYAxMXyFfW3I5Uq+cItYxuz1yoZQZMi
	 YxLIdbVwPpt5rdcLjGMn33ojHqSjJm31QhBidl38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbfDWPq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:46:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727467AbfDWPq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 11:46:56 -0400
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E36B02175B;
        Tue, 23 Apr 2019 15:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556034415;
        bh=xlGscSs9dL++G38J6mR9vhBpBgSSGaJk6NuPAmkk4ZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sxjGlt/RLN5FWJu3zm9yn7ED1H8Wq1e8MepLObKBUMimx+34tJgixpBn+zxiMcgdo
         tu7FzUwnpdYI7OVVF28cPpdmDsB6FN5xOUi2vFZeigTCAgcEJ556VywrxjCHFr0qF2
         rBMnPVss4iyiv2MPvrB5GQIkiGcFw4Ds6gd6F/kQ=
Date:   Tue, 23 Apr 2019 23:46:42 +0800
From:   Guo Ren <guoren@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     ren_guo@c-sky.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        tech-privileged@lists.riscv.org,
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
Message-ID: <20190423154642.GA16001@guoren-Inspiron-7460>
References: <1555947870-23014-1-git-send-email-guoren@kernel.org>
 <20190422161814.GA30694@lst.de>
 <20190423001348.GA31639@guoren-Inspiron-7460>
 <20190423055548.GA12365@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423055548.GA12365@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 07:55:48AM +0200, Christoph Hellwig wrote:
> On Tue, Apr 23, 2019 at 08:13:48AM +0800, Guo Ren wrote:
> > > We should probably start a working group for this ASAP unless we can
> > > get another working group to help taking care of it.
> > Good news, I prefer to use instructions directly instead of SBI_CALL.
> > 
> > Our instruction is "dcache.c/iva %0" (one cache line) and the parameter is
> > virtual address in S-state. When get into M-state by SBI_CALL, we could
> > let dcache.c/iva use physical addres directly and it needn't kmap page
> > for RV32 with highmem (Of cause highmem is not ready in RV32 now).
> 
> So you only have one instruction variant?  Normally we'd have two or
> three to implement the non-coherent DMA (or pmem) semantics:
dcache.c/iva means three instructions:
 - dcache.cva %0  : writeback     by virtual address cacheline
 - dcache.iva %0  : invalid       by virtual address cacheline
 - dcache.civa %0 : writeback+inv by virtual address cacheline

We also have memory barrier instructions, ref:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/csky/include/asm/barrier.h

> 
> cache writeback, cache invalidate and potentially cache writeback +
> invalidate to optimize that case.  Here is the table how Linux
> uses them for DMA:
> 
>           |   map          ==  for_device     |   unmap     ==  for_cpu
>           |----------------------------------------------------------------
>  TO_DEV   |   writeback        writeback      |   none          none
>  FROM_DEV |   invalidate       invalidate     |   invalidate*   invalidate*
>  BIDI     |   writeback+inv    writeback+inv  |   invalidate    invalidate
> 
>      [*] needed for CPU speculative prefetches
> 
> 
> We already have a discussion on isa-dev on something like these
> instructions:
> 
> https://groups.google.com/a/groups.riscv.org/forum/#!msg/isa-dev/qXbzqaQbDXU/4ThcEAeCCAAJ
> 
> It got a little side tracked, both due to the usual noise on isa-dev
> and due to the proposal including a lot more instructions that might be
> a little more contentious, but it might be a good start to bring this
> into a working group.
I think using sbi_call as a temporary solution is a good choice before
the instruction is determined.

> 
> > > Also is this really a coherent flag, or an 'uncached' flag like in
> > > many other architectures?
> > There are a lot of features about coherency attributes, eg: cacheable,
> > bufferable, strong order ..., and coherency is a more abstract name to
> > contain all of these. In our hardware, coherence = uncached +
> > unbufferable + (stong order).
> > 
> > But I'm not very care about the name is, uncached is also ok. My key
> > point is the bits of page attributes is very precious and this patch
> > will use the last unused attribute bit in PTE.
> 
> I don't care about the name actually, more about having defined semantics.
> Totally uncached should include unbuffered.  I don't think we need the
> strong ordering for DMA memory either.
Yes, memory don't need strong order and strong order in PMA also implies
uncached, unbuffered for IO address. If the entry of PMA is strong
order, the page mapping must be uncached + unbuffered + strong-order
without _PAGE_COHENCY in PTE.

> 
> > Another point is we could get more attribute bits by modify the riscv
> > spec:
> >  - Remove Global bit, I think it's duplicate with the User bit in linux.
> 
> It is in Linux, but it is conceptually very different.
Yes, but hardware could ignore one of them and in riscv linux
_PAGE_GLOBAL is no use at all, see:
grep _PAGE_GLOBAL arch/riscv -r

In fact, the _PAGE_KERNEL for pte doesn't contain _PAGE_GLOBAL and it
works on FU540 and qemu. As I've mentioned page attribute bits is very
precious, define a useless bit make people confused.

> 
> >  - Change _PAGE_PFN_SHIFT from 10 to 12, because the huge pfn in RV32 is
> >    very useless and current RV32 linux doesn't even implement highmem.
> 
> This would seem sensible to me, but I'm not sure everyone agrees.  Even
> then we are very late in the game for changes like that.
Agree.

Best Regards
 Guo Ren
