Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D051C41517
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 06:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F328320644
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 06:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfGXGvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 02:51:48 -0400
Received: from verein.lst.de ([213.95.11.211]:48150 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbfGXGvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 02:51:48 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6DD4768B02; Wed, 24 Jul 2019 08:51:46 +0200 (CEST)
Date:   Wed, 24 Jul 2019 08:51:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] mm/hmm: make full use of walk_page_range()
Message-ID: <20190724065146.GA2061@lst.de>
References: <20190723233016.26403-1-rcampbell@nvidia.com> <20190723233016.26403-3-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723233016.26403-3-rcampbell@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 04:30:16PM -0700, Ralph Campbell wrote:
> hmm_range_snapshot() and hmm_range_fault() both call find_vma() and
> walk_page_range() in a loop. This is unnecessary duplication since
> walk_page_range() calls find_vma() in a loop already.
> Simplify hmm_range_snapshot() and hmm_range_fault() by defining a
> walk_test() callback function to filter unhandled vmas.

I like the approach a lot!

But we really need to sort out the duplication between hmm_range_fault
and hmm_range_snapshot first, as they are basically the same code.  I
have patches here:

http://git.infradead.org/users/hch/misc.git/commitdiff/a34ccd30ee8a8a3111d9e91711c12901ed7dea74

http://git.infradead.org/users/hch/misc.git/commitdiff/81f442ebac7170815af7770a1efa9c4ab662137e

That being said we don't really have any users for the snapshot mode
or non-blocking faults, and I don't see any in the immediate pipeline
either.  It might actually be a better idea to just kill that stuff off
for now until we have a user, as code without users is per definition
untested and will just bitrot and break.

> +	const unsigned long device_vma = VM_IO | VM_PFNMAP | VM_MIXEDMAP;
> +	struct hmm_vma_walk *hmm_vma_walk = walk->private;
> +	struct hmm_range *range = hmm_vma_walk->range;
> +	struct vm_area_struct *vma = walk->vma;
> +
> +	/* If range is no longer valid, force retry. */
> +	if (!range->valid)
> +		return -EBUSY;
> +
> +	if (vma->vm_flags & device_vma)

Can we just kill off this odd device_vma variable?

	if (vma->vm_flags & (VM_IO | VM_PFNMAP | VM_MIXEDMAP))

and maybe add a comment on why we are skipping them (because they
don't have struct page backing I guess..)
