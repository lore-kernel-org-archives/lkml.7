Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC92C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A6421738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbfDWOwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:52:53 -0400
Received: from verein.lst.de ([213.95.11.211]:47332 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727467AbfDWOww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:52:52 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C167F68AFE; Tue, 23 Apr 2019 16:52:36 +0200 (CEST)
Date:   Tue, 23 Apr 2019 16:52:36 +0200
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
Message-ID: <20190423145236.GA22253@lst.de>
References: <20190327080448.5500-1-hch@lst.de> <20190327080448.5500-13-hch@lst.de> <b3f80a11-1504-e8f9-4438-92bcd5f3df7f@arm.com> <20190410061157.GA5278@lst.de> <20190417063358.GA24139@lst.de> <83615173-a8b4-e0eb-bac3-1a58d61ea4ef@arm.com> <20190418163512.GA25347@lst.de> <228ee57a-d7b2-48e0-a34e-81d5fba0a090@arm.com> <20190419082348.GA22299@lst.de> <0a6b3f53-79e5-af83-be39-f04c9acd8384@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a6b3f53-79e5-af83-be39-f04c9acd8384@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 11:01:44AM +0100, Robin Murphy wrote:
> On 19/04/2019 09:23, Christoph Hellwig wrote:
>> On Thu, Apr 18, 2019 at 07:15:00PM +0100, Robin Murphy wrote:
>>> Still, I've worked in the vm_map_pages() stuff pending in MM and given them
>>> the same treatment to finish the picture. Both x86_64_defconfig and
>>> i386_defconfig do indeed compile and link fine as I expected, so I really
>>> would like to understand the concern around #ifdefs better.
>>
>> This looks generally fine to me.  One thing I'd like to do is to
>> generally make use of the fact that __iommu_dma_get_pages returns NULL
>> for the force contigous case as that cleans up a few things.  Also
>> for the !DMA_REMAP case we need to try the page allocator when
>> dma_alloc_from_contiguous does not return a page.  What do you thing
>> of the following incremental diff?  If that is fine with you I can
>> fold that in and add back in the remaining patches from my series
>> not obsoleted by your patches and resend.
>
> Wouldn't this suffice? Since we also use alloc_pages() in the coherent 
> atomic case, the free path should already be able to deal with it.

Yepp, that is about what I've done in v3, except that I've also folded
that coherent atomic case in a way very similar to dma-direct.
