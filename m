Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA584C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C8C2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733026AbfDXO5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:57:25 -0400
Received: from verein.lst.de ([213.95.11.211]:54463 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732498AbfDXO5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:57:22 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5CBC367358; Wed, 24 Apr 2019 16:57:06 +0200 (CEST)
Date:   Wed, 24 Apr 2019 16:57:05 +0200
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
Message-ID: <20190424145705.GB21480@lst.de>
References: <20190422165125.21704-1-laurentiu.tudor@nxp.com> <20190422181100.GB32490@lst.de> <VI1PR04MB513407A66107759EC0DFE175EC230@VI1PR04MB5134.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB513407A66107759EC0DFE175EC230@VI1PR04MB5134.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'd be happy to offload all of the mentioned tasks to you if you
volunteer.

I think the first step is to move the two USB controller that can only
DMA to their own BAR off the existing DMA coherent infrastructure.  The
controllers are already identified using the HCD_LOCAL_MEM flag, so we
just need to key off that in the hcd_buffer_* routines and call into a
genalloc that has been fed using the bar, replacing the current
dma_declare_coherent usage.  Take a look at drivers/pci/p2pdma.c
for another example of allocating bits of a BAR using genalloc.

Another issue in that are just popped up, which is remoteproc_virtio.c,
which looks like a complete trainwreck.  I'll need to spend time to
figure out what the hell they are trying to first, though.

Then we need to kill the dma_declare_coherent_memory and
dma_release_declared_memory exports ASAP to avoid growing more users.

Next is figuring out how we want to plumb the OF / early boot coherent
regions into the iommu drivers.  I think I want to handle them similar
to the per-device CMA regions, that is each of the DMA ops has to
manually call into it instead of the page allocator.  Fortunately we
are down to only about a hand full of instances that are relevant
for the reserved memory now.
