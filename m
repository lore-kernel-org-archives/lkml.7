Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26535C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 06:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A962184E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 06:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731223AbfHHG7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 02:59:37 -0400
Received: from verein.lst.de ([213.95.11.211]:43750 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbfHHG7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 02:59:37 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D398268AEF; Thu,  8 Aug 2019 08:59:33 +0200 (CEST)
Date:   Thu, 8 Aug 2019 08:59:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>, Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/15] mm: remove the pgmap field from struct
 hmm_vma_walk
Message-ID: <20190808065933.GA29382@lst.de>
References: <20190806160554.14046-1-hch@lst.de> <20190806160554.14046-5-hch@lst.de> <20190807174548.GJ1571@mellanox.com> <CAPcyv4hPCuHBLhSJgZZEh0CbuuJNPLFDA3f-79FX5uVOO0yubA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hPCuHBLhSJgZZEh0CbuuJNPLFDA3f-79FX5uVOO0yubA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 11:47:22AM -0700, Dan Williams wrote:
> > Unrelated to this patch, but what is the point of getting checking
> > that the pgmap exists for the page and then immediately releasing it?
> > This code has this pattern in several places.
> >
> > It feels racy
> 
> Agree, not sure what the intent is here. The only other reason call
> get_dev_pagemap() is to just check in general if the pfn is indeed
> owned by some ZONE_DEVICE instance, but if the intent is to make sure
> the device is still attached/enabled that check is invalidated at
> put_dev_pagemap().
> 
> If it's the former case, validating ZONE_DEVICE pfns, I imagine we can
> do something cheaper with a helper that is on the order of the same
> cost as pfn_valid(). I.e. replace PTE_DEVMAP with a mem_section flag
> or something similar.

The hmm literally never dereferences the pgmap, so validity checking is
the only explanation for it.

> > +               /*
> > +                * We do put_dev_pagemap() here so that we can leverage
> > +                * get_dev_pagemap() optimization which will not re-take a
> > +                * reference on a pgmap if we already have one.
> > +                */
> > +               if (hmm_vma_walk->pgmap)
> > +                       put_dev_pagemap(hmm_vma_walk->pgmap);
> > +
> 
> Seems ok, but only if the caller is guaranteeing that the range does
> not span outside of a single pagemap instance. If that guarantee is
> met why not just have the caller pass in a pinned pagemap? If that
> guarantee is not met, then I think we're back to your race concern.

It iterates over multiple ptes in a non-huge pmd.  Is there any kind of
limitations on different pgmap instances inside a pmd?  I can't think
of one, so this might actually be a bug.
