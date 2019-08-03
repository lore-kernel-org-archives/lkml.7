Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2308C31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 06:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB682073D
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 06:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfHCGsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 02:48:17 -0400
Received: from verein.lst.de ([213.95.11.211]:58712 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726797AbfHCGsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 02:48:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3208868BFE; Sat,  3 Aug 2019 08:48:13 +0200 (CEST)
Date:   Sat, 3 Aug 2019 08:48:12 +0200
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
Message-ID: <20190803064812.GA29746@lst.de>
References: <20190801142118.21225-1-hch@lst.de> <20190801142118.21225-2-hch@lst.de> <20190801162305.3m32chycsdjmdejk@willie-the-truck> <20190801163457.GB26588@lst.de> <20190801164411.kmsl4japtfkgvzxe@willie-the-truck> <20190802081441.GA9725@lst.de> <20190802103803.3qrbhqwxlasojsco@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190802103803.3qrbhqwxlasojsco@willie-the-truck>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 11:38:03AM +0100, Will Deacon wrote:
> 
> So this boils down to a terminology mismatch. The Arm architecture doesn't have
> anything called "write combine", so in Linux we instead provide what the Arm
> architecture calls "Normal non-cacheable" memory for pgprot_writecombine().
> Amongst other things, this memory type permits speculation, unaligned accesses
> and merging of writes. I found something in the architecture spec about
> non-cachable memory, but it's written in Armglish[1].
> 
> pgprot_noncached(), on the other hand, provides what the architecture calls
> Strongly Ordered or Device-nGnRnE memory. This is intended for mapping MMIO
> (i.e. PCI config space) and therefore forbids speculation, preserves access
> size, requires strict alignment and also forces write responses to come from
> the endpoint.
> 
> I think the naming mismatch is historical, but on arm64 we wanted to use the
> same names as arm32 so that any drivers using these things directly would get
> the same behaviour.

That all makes sense, but it totally needs a comment.  I'll try to draft
one based on this.  I've also looked at the arm32 code a bit more, and
it seems arm always (?) supported Normal non-cacheable attribute, but
Linux only optionally uses it for arm v6+ because of fears of drivers
missing barriers.  The other really weird things is that in arm32
pgprot_dmacoherent incudes the L_PTE_XN bit, which from my understanding
is the no-execture bit, but pgprot_writecombine does not.  This seems to
not very unintentional.  So minus that the whole DMA_ATTR_WRITE_COMBІNE
seems to be about flagging old arm specific drivers as having the proper
barriers in places and otherwise is a no-op.

Here is my tentative plan:

 - respin this patch with a small fix to handle the
   DMA_ATTR_NON_CONSISTENT (as in ignore it unless actually supported),
   but keep the name as-is to avoid churn.  This should allow 5.3
   inclusion and backports
 - remove DMA_ATTR_WRITE_COMBINE support from mips, probably also 5.3
   material.
 - move all architectures but arm over to just define
   pgprot_dmacoherent, including a comment with the above explanation
   for arm64.
 - make DMA_ATTR_WRITE_COMBINE a no-op and schedule it for removal,
   thus removing the last instances of arch_dma_mmap_pgprot
