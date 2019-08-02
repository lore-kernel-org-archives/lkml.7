Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56C3C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9222820679
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390663AbfHBIOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 04:14:46 -0400
Received: from verein.lst.de ([213.95.11.211]:50730 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbfHBIOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 04:14:46 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9F17E68B05; Fri,  2 Aug 2019 10:14:41 +0200 (CEST)
Date:   Fri, 2 Aug 2019 10:14:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Will Deacon <will@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Shawn Anastasio <shawn@anastas.io>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: fix page attributes for dma_mmap_*
Message-ID: <20190802081441.GA9725@lst.de>
References: <20190801142118.21225-1-hch@lst.de> <20190801142118.21225-2-hch@lst.de> <20190801162305.3m32chycsdjmdejk@willie-the-truck> <20190801163457.GB26588@lst.de> <20190801164411.kmsl4japtfkgvzxe@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801164411.kmsl4japtfkgvzxe@willie-the-truck>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 05:44:12PM +0100, Will Deacon wrote:
> > > Although arch_dma_mmap_pgprot() is a bit of a misnomer now that it only
> > > gets involved in the non-coherent case.
> > 
> > A better name is welcome.
> 
> How about arch_dma_noncoherent_mmap_pgprot() ? Too long?

Sounds a little long yes.  And doesn't fix the additional problem that
we don't just it for mmap but also for the in-kernel remapping these
days.

> > But my worry is how this interacts with architectures that have an
> > uncached segment (mips, nios2, microblaze, extensa) where we'd have
> > the kernel access DMA_ATTR_WRITE_COMBINE mappigns using the uncached
> > segment, and userspace mmaps using pgprot_writecombine, which could
> > lead to aliasing issues.  But then again mips already supports
> > DMA_ATTR_WRITE_COMBINE, so this must be ok somehow.  I guess I'll
> > need to field that question to the relevant parties.
> 
> Or it's always been busted and happens to work out in practice...

I've sent a ping to the mips folks.  While we'are at it:  arm64
and arm32 (optionally) map dma coherent allocations as write combine.
I suspect this hasn't always just been busted but intentional (of course!),
but is there any chance to get a quote from the arm architecture spec
on why this is fine as it looks rather confusion?

Also if we assume mips is buggy DMA_ATTR_WRITE_COMBINE really just seems
to be there for old arm platforms, which makes the scope pretty limited.
