Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED660C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A53208C0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfDIPMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:12:55 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39732 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbfDIPMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 11:12:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9087115AB;
        Tue,  9 Apr 2019 08:12:54 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 365E33F68F;
        Tue,  9 Apr 2019 08:12:53 -0700 (PDT)
Subject: Re: [PATCH 02/21] arm64/iommu: improve mmap bounds checking
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190327080448.5500-1-hch@lst.de>
 <20190327080448.5500-3-hch@lst.de>
 <3629087c-a8cb-d66e-840b-cfee125bdf4c@arm.com> <20190407065923.GA9086@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <45672f18-c741-601d-6bb2-92f50b77e981@arm.com>
Date:   Tue, 9 Apr 2019 16:12:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190407065923.GA9086@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2019 07:59, Christoph Hellwig wrote:
> On Fri, Apr 05, 2019 at 06:30:52PM +0100, Robin Murphy wrote:
>> On 27/03/2019 08:04, Christoph Hellwig wrote:
>>> The nr_pages checks should be done for all mmap requests, not just those
>>> using remap_pfn_range.
>>
>> Hmm, the logic in iommu_dma_mmap() inherently returns an error for the "off
>>> = nr_pages" case already. It's also supposed to be robust against the
>> "vma_pages(vma) > nr_pages - off" condition, although by making the partial
>> mapping and treating it as a success, rather than doing nothing and
>> returning an error. What's the exact motivation here?
> 
> Have one error check at the front of the function that is identical
> to the mmap checks in the other dma_map_ops instances so that:
> 
>   a) we get the same error behavior for partial requests everywhere
>   b) we can lift these checks into common code in the next round.
> 

Fair enough, but in that case why isn't the dma_mmap_from_coherent() 
path also covered?

Robin.
