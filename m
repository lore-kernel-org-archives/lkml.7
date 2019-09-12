Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53471C5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 08:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C75220650
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 08:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbfILI0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 04:26:17 -0400
Received: from verein.lst.de ([213.95.11.211]:45327 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbfILI0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 04:26:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 573D1227A81; Thu, 12 Sep 2019 10:26:13 +0200 (CEST)
Date:   Thu, 12 Sep 2019 10:26:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/4] mm/hmm: make full use of walk_page_range()
Message-ID: <20190912082613.GA14368@lst.de>
References: <20190911222829.28874-1-rcampbell@nvidia.com> <20190911222829.28874-2-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911222829.28874-2-rcampbell@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int hmm_pfns_fill(unsigned long addr,
> +			 unsigned long end,
> +			 struct hmm_range *range,
> +			 enum hmm_pfn_value_e value)

Nit: can we use the space a little more efficient, e.g.:

static int hmm_pfns_fill(unsigned long addr, unsigned long end,
		struct hmm_range *range, enum hmm_pfn_value_e value)

> +static int hmm_vma_walk_test(unsigned long start,
> +			     unsigned long end,
> +			     struct mm_walk *walk)

Same here.

> +	if (!(vma->vm_flags & VM_READ)) {
> +		(void) hmm_pfns_fill(start, end, range, HMM_PFN_NONE);

There should be no need for the void cast here.
