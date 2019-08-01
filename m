Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27E1C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF96320838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730707AbfHAHmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 03:42:25 -0400
Received: from verein.lst.de ([213.95.11.211]:41121 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730577AbfHAHmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 03:42:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D5C1E227A81; Thu,  1 Aug 2019 09:42:20 +0200 (CEST)
Date:   Thu, 1 Aug 2019 09:42:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] mm: turn migrate_vma upside down
Message-ID: <20190801074220.GB16178@lst.de>
References: <20190729142843.22320-1-hch@lst.de> <20190729142843.22320-2-hch@lst.de> <33b82c28-74be-8767-08fa-e41516d11c7e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33b82c28-74be-8767-08fa-e41516d11c7e@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 06:46:25PM -0700, Ralph Campbell wrote:
>>   	for (i = 0; i < npages; i += c) {
>> -		unsigned long next;
>> -
>>   		c = min(SG_MAX_SINGLE_ALLOC, npages);
>> -		next = start + (c << PAGE_SHIFT);
>> -		ret = migrate_vma(&nouveau_dmem_migrate_ops, vma, start,
>> -				  next, src_pfns, dst_pfns, &migrate);
>> +		args.end = start + (c << PAGE_SHIFT);
>
> Since migrate_vma_setup() is called in a loop, either args.cpages and
> args.npages need to be cleared here or cleared in migrate_vma_setup().

I think clearing everything that is not used for argument passing in
migrate_vma_setup is a good idea.  I'll do that.

Btw, it seems like this was a fullquote just for the little comment
as far as I could tell from wading through it.  It would be very
appreciated to properly quote the replies.
