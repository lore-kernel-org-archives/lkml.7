Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866A5C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5663620857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfDIJ5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:57:53 -0400
Received: from verein.lst.de ([213.95.11.211]:49236 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbfDIJ5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:57:52 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A73E668B02; Tue,  9 Apr 2019 11:57:40 +0200 (CEST)
Date:   Tue, 9 Apr 2019 11:57:40 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Thomas Hellstrom <thellstrom@vmware.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Deepak Singh Rawat <drawat@vmware.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: revert dma direct internals abuse
Message-ID: <20190409095740.GE6827@lst.de>
References: <20190408105525.5493-1-hch@lst.de> <7d5f35da4a6b58639519f0764c7edbfe4dd1ba02.camel@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d5f35da4a6b58639519f0764c7edbfe4dd1ba02.camel@vmware.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 06:47:52PM +0000, Thomas Hellstrom wrote:
> We HAVE discussed our needs, although admittedly some of my emails
> ended up unanswered.

And than you haven't followed up, and instead ignored the layering
instructions and just commited a broken patch?

> We've as you're well aware of had a discussion with the other
> subsystems doing user-space DMA-buffers wanting this functionality from
> the dma api (AMD graphics and RDMA people IIRC). that is a bool that
> tells us whether streaming dma mappings are coherent, and I described
> in detail why we couldn't use the dma_sync_* API and
> dma_alloc_coherent().

And that is not at all what you either check or claim to do in the
changelog (which btw, are two different things).

> The other option we have is to just fail miserably without messages if
> streaming DMA is not coherent, which I think the other drivers might
> do... That's all I'm trying to avoid here. I'd much prefer to have the
> dma API export this bool.

Both DMA direct and non-DMA direct streaming mappings can be either
coherent or incoherent, so your patch doesn't archive that.  The
commit log claims the following:

"drm/vmwgfx: Improve on IOMMU detection
    
 instead of relying on intel_iommu_enabled, use the fact that the
 dma_map_ops::map_page != dma_direct_map_page"

which has nothing to do with the fact that streaming mappings are
coherent.  It also is incorrect as there are direct mapping that
do not use dma_direct_map_page (e.g. on ARM, or x86 with VMD).
