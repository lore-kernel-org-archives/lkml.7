Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F09C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74A3206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfDZPNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:13:47 -0400
Received: from verein.lst.de ([213.95.11.211]:46642 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbfDZPNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:13:46 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 8230D227A81; Fri, 26 Apr 2019 17:13:30 +0200 (CEST)
Date:   Fri, 26 Apr 2019 17:13:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] dma-mapping: create iommu mapping for newly
 allocated dma coherent mem
Message-ID: <20190426151330.GC20438@lst.de>
References: <20190422165125.21704-1-laurentiu.tudor@nxp.com> <20190422181100.GB32490@lst.de> <VI1PR04MB513407A66107759EC0DFE175EC230@VI1PR04MB5134.eurprd04.prod.outlook.com> <20190424145705.GB21480@lst.de> <b9f2b425-dde9-f9a1-b8fa-b7710e764b16@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9f2b425-dde9-f9a1-b8fa-b7710e764b16@nxp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 11:30:54AM +0000, Laurentiu Tudor wrote:
> > I think the first step is to move the two USB controller that can only
> > DMA to their own BAR off the existing DMA coherent infrastructure.  The
> > controllers are already identified using the HCD_LOCAL_MEM flag, so we
> > just need to key off that in the hcd_buffer_* routines and call into a
> 
> So if HCD_LOCAL_MEM is set I should call into the gen_pool api instead 
> of existing dma_{alloc,free}_coherent().

Yes.

> > genalloc that has been fed using the bar, replacing the current
> > dma_declare_coherent usage.  Take a look at drivers/pci/p2pdma.c
> > for another example of allocating bits of a BAR using genalloc.
> 
> Where should I place the reference to the gen_pool? How does local_pool 
> in 'struct hcd_usb' sound?

Sounds fine to me, but in the end the usb maintainers will have
to decide.
