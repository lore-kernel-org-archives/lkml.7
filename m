Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71701C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3157C2089E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbfHAHBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 03:01:55 -0400
Received: from verein.lst.de ([213.95.11.211]:40859 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbfHAHBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 03:01:55 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8C39E68AFE; Thu,  1 Aug 2019 09:01:51 +0200 (CEST)
Date:   Thu, 1 Aug 2019 09:01:51 +0200
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
Subject: Re: [PATCH 11/13] mm: cleanup the hmm_vma_handle_pmd stub
Message-ID: <20190801070151.GB15404@lst.de>
References: <20190730055203.28467-1-hch@lst.de> <20190730055203.28467-12-hch@lst.de> <20190730175309.GN24038@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730175309.GN24038@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 05:53:14PM +0000, Jason Gunthorpe wrote:
> > -	/* If THP is not enabled then we should never reach this 
> 
> This old comment says we should never get here
> 
> > +}
> > +#else /* CONFIG_TRANSPARENT_HUGEPAGE */
> > +static int hmm_vma_handle_pmd(struct mm_walk *walk, unsigned long addr,
> > +		unsigned long end, uint64_t *pfns, pmd_t pmd)
> > +{
> >  	return -EINVAL;
> 
> So could we just do
>    #define hmm_vma_handle_pmd NULL
> 
> ?
> 
> At the very least this seems like a WARN_ON too?

Despite the name of the function hmm_vma_handle_pmd is not a callback
for the pagewalk, but actually called from hmm_vma_handle_pmd.

What we could try is just and empty non-inline prototype without an
actual implementation, which means if the compiler doesn't optimize
the calls away we'll get a link error.
