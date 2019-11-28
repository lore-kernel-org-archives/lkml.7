Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3537AC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 07:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11349215E5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 07:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfK1Hv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 02:51:56 -0500
Received: from verein.lst.de ([213.95.11.211]:50864 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbfK1Hvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 02:51:55 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7F47868B05; Thu, 28 Nov 2019 08:51:53 +0100 (CET)
Date:   Thu, 28 Nov 2019 08:51:53 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     Thomas Hellstrom <thellstrom@vmware.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 2/2] dma-mapping: force unencryped devices are always
 addressing limited
Message-ID: <20191128075153.GD20659@lst.de>
References: <20191127144006.25998-1-hch@lst.de> <20191127144006.25998-3-hch@lst.de> <a95d9115fc2a80de2f97f001bbcd9aba6636e685.camel@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a95d9115fc2a80de2f97f001bbcd9aba6636e685.camel@vmware.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 06:22:57PM +0000, Thomas Hellstrom wrote:
> >  bool dma_addressing_limited(struct device *dev)
> >  {
> > +	if (force_dma_unencrypted(dev))
> > +		return true;
> >  	return min_not_zero(dma_get_mask(dev), dev->bus_dma_limit) <
> >  			    dma_get_required_mask(dev);
> >  }
> 
> Any chance to have the case
> 
> (swiotlb_force == SWIOTLB_FORCE)
> 
> also included?

We have a hard time handling that in generic code.  Do we have any
good use case for SWIOTLB_FORCE not that we have force_dma_unencrypted?
I'd love to be able to get rid of it..
