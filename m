Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C9DC04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128D621773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfEUNEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 09:04:31 -0400
Received: from verein.lst.de ([213.95.11.211]:60203 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728179AbfEUNE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 09:04:29 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id AF38268B20; Tue, 21 May 2019 15:04:03 +0200 (CEST)
Date:   Tue, 21 May 2019 15:04:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dma-mapping: allow larger DMA mask than
 supported
Message-ID: <20190521130402.GA5130@lst.de>
References: <20190521124729.23559-1-hch@lst.de> <20190521124729.23559-3-hch@lst.de> <20190521130047.3bvvttpaa3pfqkdq@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521130047.3bvvttpaa3pfqkdq@shell.armlinux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 02:00:47PM +0100, Russell King - ARM Linux admin wrote:
> On Tue, May 21, 2019 at 02:47:29PM +0200, Christoph Hellwig wrote:
> > Since Linux 5.1 we allow drivers to just set the largest DMA mask they
> > support instead of falling back to smaller ones.
> 
> This doesn't make sense.  "they" is confusing - why would a driver set
> a DMA mask larger than the driver supports?  Or is "they" not
> referring to the drivers (in which case, what is it referring to?)

The current plan is:

 - the driver sets whatever the device supports, and unless that mask
   is too small to be supportable it will always succeed

Which replaces the previous scheme of:

 - the driver tries to set whatever the device supports.  If there are
   addressing limitation outside the device (e.g. the PCIe root port,
   or the AXI interconnect) that will fail, and the device will set
   a 32-bit mask instead which it assumes will generally work.

> The point of this check is to trap the case where we have, for example,
> 8GB of memory, but dma_addr_t is 32-bit.  We can allocate in the high
> 4GB, but we can't represent the address in a dma_addr_t.

Yep, and that is what patch 1/2 should handle by truncating the
dma mask to something that can work.  I don't actually have hardware
I could test this scenario on, though.
