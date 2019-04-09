Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9DFC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C831620850
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfDIR1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:27:04 -0400
Received: from verein.lst.de ([213.95.11.211]:51873 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbfDIR1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:27:04 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7CEBC68B02; Tue,  9 Apr 2019 19:26:52 +0200 (CEST)
Date:   Tue, 9 Apr 2019 19:26:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/21] dma-iommu: refactor iommu_dma_get_sgtable
Message-ID: <20190409172652.GF14679@lst.de>
References: <20190327080448.5500-1-hch@lst.de> <20190327080448.5500-10-hch@lst.de> <a42133a5-c88b-76c7-80fa-671cfbdd9759@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a42133a5-c88b-76c7-80fa-671cfbdd9759@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 04:49:30PM +0100, Robin Murphy wrote:
>> *cpu_addr,
>> +		size_t size)
>> +{
>> +	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>> +	struct vm_struct *area = find_vm_area(cpu_addr);
>> +
>> +	if (WARN_ON(!area || !area->pages))
>> +		return -ENXIO;
>> +	return sg_alloc_table_from_pages(sgt, area->pages, count, 0, size,
>> +			GFP_KERNEL);
>> +}
>> +
>
> Is this complex enough to deserve being broken out? Really I'd prefer to 
> keep get_sgtable() as small and consolidated as possible so that it's that 
> much easier to delete in future :)

Well, it is logically separate, and this keeps it tidy.  But I agree
with the long term goal of killing off this awkward API that should
never have been added.

>
> I guess there is a certain symmetry with mmap(), so if that's the angle 
> you're dead set on, could we at least keep this guy down where 
> __iommu_dma_get_sgtable_page() was?

It is up there so that we can reduce the number of ifdef blocks for
dma remapping later on.
