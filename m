Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC61CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07A2222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408628AbfJRNvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 09:51:48 -0400
Received: from [217.140.110.172] ([217.140.110.172]:40036 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1728022AbfJRNvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 09:51:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92E89FC2;
        Fri, 18 Oct 2019 06:51:27 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A52A03F6C4;
        Fri, 18 Oct 2019 06:51:26 -0700 (PDT)
Subject: Re: [PATCH] iommu/dma: Relax locking in iommu_dma_prepare_msi()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     joro@8bytes.org, iommu@lists.linux-foundation.org, maz@kernel.org,
        julien.grall@arm.com, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
References: <5af5e77102ca52576cb96816f0abcf6398820055.1571245656.git.robin.murphy@arm.com>
 <20191017162453.GA6012@infradead.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <2309c311-7378-385d-bf97-57965d36c18b@arm.com>
Date:   Fri, 18 Oct 2019 14:51:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191017162453.GA6012@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/2019 17:24, Christoph Hellwig wrote:
> On Wed, Oct 16, 2019 at 06:07:36PM +0100, Robin Murphy wrote:
>> @@ -1180,7 +1179,7 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
>>   	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>>   	struct iommu_dma_cookie *cookie;
>>   	struct iommu_dma_msi_page *msi_page;
>> -	unsigned long flags;
>> +	static DEFINE_MUTEX(msi_prepare_lock);
> 
> Just a style nitpick, but I find locks declared inside functions
> really weird.  In addition to that locks not embedded into a structure
> and not directly next to variables or data structures they protect
> really need a comment explaining what they are trying to serialize.

Hmm, the lock itself is merely a glorified comment, it's named for the 
operation it protects, its entire existence spans 15 consecutive lines, 
and 27% of those lines are dedicated to explaining that it's technically 
redundant. Is there *really* anything that isn't clear from the context?

Robin.
