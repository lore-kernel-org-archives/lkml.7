Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8AAC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31252171F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfDCTmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 15:42:32 -0400
Received: from verein.lst.de ([213.95.11.211]:35263 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbfDCTmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 15:42:32 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 605FD68AFE; Wed,  3 Apr 2019 21:42:20 +0200 (CEST)
Date:   Wed, 3 Apr 2019 21:42:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, x86@kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: remove NULL struct device support in the DMA API
Message-ID: <20190403194220.GA30376@lst.de>
References: <20190321225235.30648-1-hch@lst.de> <20190403182640.2ca6w2hngjqp35mt@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403182640.2ca6w2hngjqp35mt@shell.armlinux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 07:26:40PM +0100, Russell King - ARM Linux admin wrote:
> On Thu, Mar 21, 2019 at 03:52:28PM -0700, Christoph Hellwig wrote:
> > We still have a few drivers which pass a NULL struct device pointer
> > to DMA API functions, which generally is a bad idea as the API
> > implementations rely on the device not only for ops selection, but
> > also the dma mask and various other attributes, and many implementations
> > have been broken for NULL device support for a while.
> 
> I think I must be missing something, but...
> 
> My understanding is that ISA DMA is normally limited to 24 bits of
> address

Yes.

> - indeed, the x86 version only programs 24 bits of DMA address.
> Looking through this series, it appears that the conversions mean that
> the DMA mask for ISA becomes the full all-ones DMA mask, which would
> of course lead to memory corruption if only 24 bits of the address end
> up being programmed into the hardware.

In the generic dma mapping code no struct device has always meant a
32-bit DMA mask - take a look at the dma_get_mask() function.

> Maybe you could say why you think this series is safe in regard to ISA
> DMA?

ISA DMA has always been rather painful in a myriad of ways, and the
DMA API so far hasn't helped, given that we don't do bounce buffering
for the 24-bit limit, but just the higher limits.  So far even if you
do use the DMA API and pass a device ISA DMA so far always meant
that the higher layers had to assure things are addressable, either
by using GFP_DMA allocation in the drivers, or mid-layer hacks like
the unchecked_isa_dma flag in SCSI and/or BLK_BOUNCE_ISA in the
block layer.

This series doesn't change those facts at all.  I have some half
started series to clean some of this up but it isn't high up on
the priority list.
