Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690DBC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D444216B7
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565107742;
	bh=v0k57mTDkfDZaJNeGslFkP/p8/lZF5e0EN6d5zbeXJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B5lD0/hfT3b8xCXnv4uLAxHUvc2ww6QRDbq1cfw4A9outeSADpoG5rBIk1sOgM0ev
	 rqak9ukwZ8TGIjFsCp3vxE42+56KiCoXUrnft7T5ZEoN3dRBompakylDUVpuVubBTr
	 l5FnmZLpg4JHMmsNya0bucUmYxynhgRmQ5lzym2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387664AbfHFQJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 12:09:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732203AbfHFQJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 12:09:00 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 981C320679;
        Tue,  6 Aug 2019 16:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565107739;
        bh=v0k57mTDkfDZaJNeGslFkP/p8/lZF5e0EN6d5zbeXJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QwYLVlSCvE5RkEzMUkxya/17HqX4ysozqlmTdPTPO5zBru0s7lkz8yZHQi0kE7QPa
         J3nsmuubbBmALdIHYivFeIBCfxouhnJ+9TQ0HskYPSpEl7ePJW8QWsSwlXZEvwICkA
         ksIz9c1GMc0XmZhCNFQc096KaCxj+m1SMXGhPUZc=
Date:   Tue, 6 Aug 2019 17:08:54 +0100
From:   Will Deacon <will@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Shawn Anastasio <shawn@anastas.io>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: fix page attributes for dma_mmap_*
Message-ID: <20190806160854.htk67msiyadlrl4m@willie-the-truck>
References: <20190801142118.21225-1-hch@lst.de>
 <20190801142118.21225-2-hch@lst.de>
 <20190801162305.3m32chycsdjmdejk@willie-the-truck>
 <20190801163457.GB26588@lst.de>
 <20190801164411.kmsl4japtfkgvzxe@willie-the-truck>
 <20190802081441.GA9725@lst.de>
 <20190802103803.3qrbhqwxlasojsco@willie-the-truck>
 <20190803064812.GA29746@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190803064812.GA29746@lst.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 03, 2019 at 08:48:12AM +0200, Christoph Hellwig wrote:
> On Fri, Aug 02, 2019 at 11:38:03AM +0100, Will Deacon wrote:
> > 
> > So this boils down to a terminology mismatch. The Arm architecture doesn't have
> > anything called "write combine", so in Linux we instead provide what the Arm
> > architecture calls "Normal non-cacheable" memory for pgprot_writecombine().
> > Amongst other things, this memory type permits speculation, unaligned accesses
> > and merging of writes. I found something in the architecture spec about
> > non-cachable memory, but it's written in Armglish[1].
> > 
> > pgprot_noncached(), on the other hand, provides what the architecture calls
> > Strongly Ordered or Device-nGnRnE memory. This is intended for mapping MMIO
> > (i.e. PCI config space) and therefore forbids speculation, preserves access
> > size, requires strict alignment and also forces write responses to come from
> > the endpoint.
> > 
> > I think the naming mismatch is historical, but on arm64 we wanted to use the
> > same names as arm32 so that any drivers using these things directly would get
> > the same behaviour.
> 
> That all makes sense, but it totally needs a comment.  I'll try to draft
> one based on this.  I've also looked at the arm32 code a bit more, and
> it seems arm always (?) supported Normal non-cacheable attribute, but
> Linux only optionally uses it for arm v6+ because of fears of drivers
> missing barriers.

I think it was also to do with aliasing, but I don't recall all of the
details.

> The other really weird things is that in arm32
> pgprot_dmacoherent incudes the L_PTE_XN bit, which from my understanding
> is the no-execture bit, but pgprot_writecombine does not.  This seems to
> not very unintentional.  So minus that the whole DMA_ATTR_WRITE_COMBІNE
> seems to be about flagging old arm specific drivers as having the proper
> barriers in places and otherwise is a no-op.

I think it only matters for Armv7 CPUs, but yes, we should probably be
setting L_PTE_XN for both of these memory types.

> Here is my tentative plan:
> 
>  - respin this patch with a small fix to handle the
>    DMA_ATTR_NON_CONSISTENT (as in ignore it unless actually supported),
>    but keep the name as-is to avoid churn.  This should allow 5.3
>    inclusion and backports
>  - remove DMA_ATTR_WRITE_COMBINE support from mips, probably also 5.3
>    material.
>  - move all architectures but arm over to just define
>    pgprot_dmacoherent, including a comment with the above explanation
>    for arm64.

That would be great, thanks.

>  - make DMA_ATTR_WRITE_COMBINE a no-op and schedule it for removal,
>    thus removing the last instances of arch_dma_mmap_pgprot

All sounds good to me, although I suppose 32-bit Arm platforms without
CONFIG_ARM_DMA_MEM_BUFFERABLE may run into issues if DMA_ATTR_WRITE_COMBINE
disappears. Only one way to find out...

Will
