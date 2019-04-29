Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AC5C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 19:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E78820675
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 19:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbfD2TK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 15:10:58 -0400
Received: from verein.lst.de ([213.95.11.211]:40628 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729044AbfD2TK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 15:10:57 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9DC0668AFE; Mon, 29 Apr 2019 21:10:40 +0200 (CEST)
Date:   Mon, 29 Apr 2019 21:10:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/26] iommu/dma: Factor out remapped pages lookup
Message-ID: <20190429191040.GC5637@lst.de>
References: <20190422175942.18788-1-hch@lst.de> <20190422175942.18788-12-hch@lst.de> <f8c04947-0ddb-17c5-8918-5859aabc220c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8c04947-0ddb-17c5-8918-5859aabc220c@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 02:05:46PM +0100, Robin Murphy wrote:
> On 22/04/2019 18:59, Christoph Hellwig wrote:
>> From: Robin Murphy <robin.murphy@arm.com>
>>
>> Since we duplicate the find_vm_area() logic a few times in places where
>> we only care aboute the pages, factor out a helper to abstract it.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> [hch: don't warn when not finding a region, as we'll rely on that later]
>
> Yeah, I did think about that and the things which it might make a little 
> easier, but preserved it as-is for the sake of keeping my modifications 
> quick and simple. TBH I'm now feeling more inclined to drop the WARNs 
> entirely at this point, since it's not like there's ever been any general 
> guarantee that freeing the wrong thing shouldn't just crash, but that's 
> something we can easily come back to later if need be.

Ok, I've dropped the warnings.
