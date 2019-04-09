Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37709C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0312020857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfDIRdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:33:33 -0400
Received: from foss.arm.com ([217.140.101.70]:42076 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbfDIRdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:33:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F164215BE;
        Tue,  9 Apr 2019 10:33:32 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98C3F3F59C;
        Tue,  9 Apr 2019 10:33:31 -0700 (PDT)
Subject: Re: [PATCH 07/21] dma-iommu: move the arm64 wrappers to common code
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190327080448.5500-1-hch@lst.de>
 <20190327080448.5500-8-hch@lst.de>
 <67573dd3-72c7-692d-bc1a-7edb49ff9551@arm.com>
 <20190409172309.GD14679@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <eace43d1-417e-c96d-0c13-160973fce077@arm.com>
Date:   Tue, 9 Apr 2019 18:33:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409172309.GD14679@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2019 18:23, Christoph Hellwig wrote:
> On Tue, Apr 09, 2019 at 04:07:02PM +0100, Robin Murphy wrote:
>>> -static inline int iommu_dma_init(void)
>>> +static inline void iommu_setup_dma_ops(struct device *dev, u64 dma_base,
>>> +		u64 size, const struct iommu_ops *ops)
>>>    {
>>> -	return 0;
>>>    }
>>
>> I don't think it makes sense to have a stub for that - AFAICS it should
>> only ever be called form arch code with an inherent "select IOMMU_DMA"
>> (much like the stuff which isn't stubbed currently).
>>
>> Otherwise, I'm about 97% sure the rest of the move looks OK - thanks for
>> splitting things up.
> 
> arm64 only selects IOMMU_DMA if IOMMU_SUPPORT is selected, which can
> be disabled.  So to keep some (unusual) arm64 configs compiling we'll need
> the stub..

Urgh, right, it worked out before because arm64 stubbed its own caller 
of iommu_dma_init_domain() internally... Oh well - I guess there's no 
nicer alternative, and we have always treated arch_setup_dma_ops() that way.

Robin.
