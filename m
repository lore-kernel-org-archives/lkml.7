Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B79C41514
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 22:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6045B206BB
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 22:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbfHXWjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 18:39:11 -0400
Received: from verein.lst.de ([213.95.11.211]:37672 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727907AbfHXWjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 18:39:10 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BB04B68B02; Sun, 25 Aug 2019 00:39:07 +0200 (CEST)
Date:   Sun, 25 Aug 2019 00:39:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] mm/hmm: hmm_range_fault() infinite loop
Message-ID: <20190824223907.GB21891@lst.de>
References: <20190823221753.2514-1-rcampbell@nvidia.com> <20190823221753.2514-3-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823221753.2514-3-rcampbell@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 03:17:53PM -0700, Ralph Campbell wrote:
> Normally, callers to handle_mm_fault() are supposed to check the
> vma->vm_flags first. hmm_range_fault() checks for VM_READ but doesn't
> check for VM_WRITE if the caller requests a page to be faulted in
> with write permission (via the hmm_range.pfns[] value).
> If the vma is write protected, this can result in an infinite loop:
>   hmm_range_fault()
>     walk_page_range()
>       ...
>       hmm_vma_walk_hole()
>         hmm_vma_walk_hole_()
>           hmm_vma_do_fault()
>             handle_mm_fault(FAULT_FLAG_WRITE)
>             /* returns VM_FAULT_WRITE */
>           /* returns -EBUSY */
>         /* returns -EBUSY */
>       /* returns -EBUSY */
>     /* loops on -EBUSY and range->valid */
> Prevent this by checking for vma->vm_flags & VM_WRITE before calling
> handle_mm_fault().
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
