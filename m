Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9122C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8020D206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbfG3NOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 09:14:34 -0400
Received: from verein.lst.de ([213.95.11.211]:51210 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728361AbfG3NOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 09:14:34 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9486D68AFE; Tue, 30 Jul 2019 15:14:30 +0200 (CEST)
Date:   Tue, 30 Jul 2019 15:14:30 +0200
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
Message-ID: <20190730131430.GC4566@lst.de>
References: <20190730055203.28467-1-hch@lst.de> <20190730055203.28467-8-hch@lst.de> <20190730125512.GF24038@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730125512.GF24038@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 12:55:17PM +0000, Jason Gunthorpe wrote:
> I suspect this was added for the ODP conversion that does use both
> page sizes. I think the ODP code for this is kind of broken, but I
> haven't delved into that..
> 
> The challenge is that the driver needs to know what page size to
> configure the hardware before it does any range stuff.
> 
> The other challenge is that the HW is configured to do only one page
> size, and if the underlying CPU page side changes it goes south.
> 
> What I would prefer is if the driver could somehow dynamically adjust
> the the page size after each dma map, but I don't know if ODP HW can
> do that.
> 
> Since this is all driving toward making ODP use this maybe we should
> keep this API? 
> 
> I'm not sure I can loose the crappy huge page support in ODP.

The problem is that I see no way how to use the current API.  To know
the huge page size you need to have the vma, and the current API
doesn't require a vma to be passed in.

That's why I suggested an api where we pass in a flag that huge pages
are ok into hmm_range_fault, and it then could pass the shift out, and
limits itself to a single vma (which it normally doesn't, that is an
additional complication).  But all this seems really awkward in terms
of an API still.  AFAIK ODP is only used by mlx5, and mlx5 unlike other
IB HCAs can use scatterlist style MRs with variable length per entry,
so even if we pass multiple pages per entry from hmm it could coalesce
them.  The best API for mlx4 would of course be to pass a biovec-style
variable length structure that hmm_fault could fill out, but that would
be a major restructure.
