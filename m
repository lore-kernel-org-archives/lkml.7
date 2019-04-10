Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234FBC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E42CC20850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfDJGML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 02:12:11 -0400
Received: from verein.lst.de ([213.95.11.211]:55014 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfDJGML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 02:12:11 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7047968B05; Wed, 10 Apr 2019 08:11:58 +0200 (CEST)
Date:   Wed, 10 Apr 2019 08:11:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/21] dma-iommu: factor atomic pool allocations into
 helpers
Message-ID: <20190410061157.GA5278@lst.de>
References: <20190327080448.5500-1-hch@lst.de> <20190327080448.5500-13-hch@lst.de> <b3f80a11-1504-e8f9-4438-92bcd5f3df7f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3f80a11-1504-e8f9-4438-92bcd5f3df7f@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 06:59:32PM +0100, Robin Murphy wrote:
> On 27/03/2019 08:04, Christoph Hellwig wrote:
>> This keeps the code together and will simplify compiling the code
>> out on architectures that are always dma coherent.
>
> And this is where things take a turn in the direction I just can't get on 
> with - I'm looking at the final result and the twisty maze of little 
> disjoint helpers all overlapping each other in functionality is really 
> difficult to follow. And I would *much* rather have things rely on 
> compile-time constant optimisation than spend the future having to fix the 
> #ifdefed parts for arm64 whenever x86-centric changes fail to test them.

Can you draft up a patch on top of my series to show me what you
want?  I can take care of finishing it up and moving the changes
into the right patches in the series.

> Conceptually, everything except the iommu_dma_alloc_remap() case is more or 
> less just dma_direct_alloc() with an IOMMU mapping on top - if we could 
> pass that an internal flag to say "don't fail or bounce because of masks" 
> it seems like that approach could end up being quite a bit simpler (I did 
> once have lofty plans to refactor the old arm64 code in such a way...)

I've been wanting to share more code between DMA direct and the iommu
allocators.  But this series already is huge and has been pending
far too long.  I'll eventually get to it..
