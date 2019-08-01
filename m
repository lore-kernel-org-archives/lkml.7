Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162E9C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9714206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbfHAGtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 02:49:18 -0400
Received: from verein.lst.de ([213.95.11.211]:40711 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730296AbfHAGtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 02:49:18 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A602568B05; Thu,  1 Aug 2019 08:49:14 +0200 (CEST)
Date:   Thu, 1 Aug 2019 08:49:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/13] mm: remove the page_shift member from struct
 hmm_range
Message-ID: <20190801064914.GA15404@lst.de>
References: <20190730055203.28467-1-hch@lst.de> <20190730055203.28467-8-hch@lst.de> <20190730125512.GF24038@mellanox.com> <20190730131430.GC4566@lst.de> <20190730175011.GL24038@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730175011.GL24038@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 05:50:16PM +0000, Jason Gunthorpe wrote:
> The way ODP seems to work is once in hugetlb mode the dma addresses
> must give huge pages or the page fault will be failed. I think that is
> a terrible design, but this is how the driver is ..
> 
> So, from this HMM perspective if the caller asked for huge pages then
> the results have to be all huge pages or a hard failure.

Which isn't how the page_shift member works at moment.  It still
allows non-hugetlb mappings even with the member.

> It is not negotiated as an optimization like you are thinking.
> 
> [note, I haven't yet checked carefully how this works in ODP, every
>  time I look at parts of it the thing seems crazy]

This seems pretty crazy.  Especially as hugetlb use in applications
seems to fade in favour of THP, for which this ODP scheme does not seem
to work at all.

> > The best API for mlx4 would of course be to pass a biovec-style
> > variable length structure that hmm_fault could fill out, but that would
> > be a major restructure.
> 
> It would work, but the driver has to expand that into a page list
> right awayhow.
> 
> We can't even dma map the biovec with today's dma API as it needs the
> ability to remap on a page granularity.

We can do dma_map_page loops over each biovec entry pretty trivially,
and that won't be any worse than the current loop over each page in
the hmm dma helpers.  Once I get around the work to have a better
API for iommu mappings for bio_vecs we could coalesce it similar to
how we do it with scatterlist (but without all the mess of a new
structure).  That work is going to take a little longer through, as
it needs the amd and intell iommu drivers to be convered to dma-iommu
which isn't making progress as far as I hoped.

Let me know if you want to keep this code for now despite the issues,
or if we'd rather reimplement it once you've made sense of the ODP
code.
