Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EAEC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E5F20850
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfDIRJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:09:26 -0400
Received: from verein.lst.de ([213.95.11.211]:51734 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbfDIRJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:09:26 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B96E768B02; Tue,  9 Apr 2019 19:09:13 +0200 (CEST)
Date:   Tue, 9 Apr 2019 19:09:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/21] arm64/iommu: improve mmap bounds checking
Message-ID: <20190409170913.GA14679@lst.de>
References: <20190327080448.5500-1-hch@lst.de> <20190327080448.5500-3-hch@lst.de> <3629087c-a8cb-d66e-840b-cfee125bdf4c@arm.com> <20190407065923.GA9086@lst.de> <45672f18-c741-601d-6bb2-92f50b77e981@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45672f18-c741-601d-6bb2-92f50b77e981@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 04:12:51PM +0100, Robin Murphy wrote:
> On 07/04/2019 07:59, Christoph Hellwig wrote:
>> On Fri, Apr 05, 2019 at 06:30:52PM +0100, Robin Murphy wrote:
>>> On 27/03/2019 08:04, Christoph Hellwig wrote:
>>>> The nr_pages checks should be done for all mmap requests, not just those
>>>> using remap_pfn_range.
>>>
>>> Hmm, the logic in iommu_dma_mmap() inherently returns an error for the "off
>>>> = nr_pages" case already. It's also supposed to be robust against the
>>> "vma_pages(vma) > nr_pages - off" condition, although by making the partial
>>> mapping and treating it as a success, rather than doing nothing and
>>> returning an error. What's the exact motivation here?
>>
>> Have one error check at the front of the function that is identical
>> to the mmap checks in the other dma_map_ops instances so that:
>>
>>   a) we get the same error behavior for partial requests everywhere
>>   b) we can lift these checks into common code in the next round.
>>
>
> Fair enough, but in that case why isn't the dma_mmap_from_coherent() path 
> also covered?

dma_mmap_from_coherent currently duplicates those checks itself, and
because of that the other callers also don't include it in their
checks.  I don't actually like that situation and have patches to
refactor and clean up that whole mess by also moving the dma coherent
mmap to common code, and share the checks that I plan to also lift.

But for now I'm holding these back as they would conflict with this
series and I'm not sure if it will go in and if yes if that is through
the dma-mapping or iommu tree.
