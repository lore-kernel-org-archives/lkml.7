Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8051DC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D6A621848
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbfJOLik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 07:38:40 -0400
Received: from foss.arm.com ([217.140.110.172]:36630 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726927AbfJOLij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 07:38:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28B18337;
        Tue, 15 Oct 2019 04:38:39 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0F553F68E;
        Tue, 15 Oct 2019 04:38:36 -0700 (PDT)
Subject: Re: [PATCH v3 3/7] iommu/mediatek: Use gather to achieve the tlb
 range flush
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        cui.zhang@mediatek.com, chao.hao@mediatek.com,
        edison.hsieh@mediatek.com
References: <1571035101-4213-1-git-send-email-yong.wu@mediatek.com>
 <1571035101-4213-4-git-send-email-yong.wu@mediatek.com>
 <f35c8a3a-0693-facf-2050-65d3f7628929@arm.com>
 <1571117166.19130.83.camel@mhfsdcap03>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <5d03ebcb-0cd1-a9ad-0f4e-c219e351396c@arm.com>
Date:   Tue, 15 Oct 2019 12:38:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1571117166.19130.83.camel@mhfsdcap03>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/2019 06:26, Yong Wu wrote:
> On Mon, 2019-10-14 at 15:21 +0100, Robin Murphy wrote:
>> On 14/10/2019 07:38, Yong Wu wrote:
>>> Use the iommu_gather mechanism to achieve the tlb range flush.
>>> Gather the iova range in the "tlb_add_page", then flush the merged iova
>>> range in iotlb_sync.
>>>
>>> Note: If iotlb_sync comes from iommu_iotlb_gather_add_page, we have to
>>> avoid retry the lock since the spinlock have already been acquired.
>>
>> I think this could probably be even simpler - once the actual
>> register-poking is all confined to mtk_iommu_tlb_sync(), you should be
>> able get rid of the per-domain locking in map/unmap and just have a
>> single per-IOMMU lock to serialise syncs. The io-pgtable code itself
>> hasn't needed external locking for a while now.
> 
> This is more simpler! Thanks very much. I will try this.
> 
> The only concern is there is no lock in the iova_to_phys then, maybe use
> the new lock instead.

iova_to_phys isn't issuing any syncs, so you don't need any locking 
there - if anyone calls that in a way which races against the given 
address being unmapped and remapped they can't expect a meaningful 
result anyway.

Robin.

>>> Suggested-by: Tomasz Figa <tfiga@chromium.org>
>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>> ---
>>> 1) This is the special case backtrace:
>>>
>>>    mtk_iommu_iotlb_sync+0x50/0xa0
>>>    mtk_iommu_tlb_flush_page_nosync+0x5c/0xd0
>>>    __arm_v7s_unmap+0x174/0x598
>>>    arm_v7s_unmap+0x30/0x48
>>>    mtk_iommu_unmap+0x50/0x78
>>>    __iommu_unmap+0xa4/0xf8
>>>
>>> 2) The checking "if (gather->start == ULONG_MAX) return;" also is
>>> necessary. It will happened when unmap only go to _flush_walk, then
>>> enter this tlb_sync.
>>> ---
>>>    drivers/iommu/mtk_iommu.c | 29 +++++++++++++++++++++++++----
>>>    drivers/iommu/mtk_iommu.h |  1 +
>>>    2 files changed, 26 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
>>> index 5f594d6..8712afc 100644
>>> --- a/drivers/iommu/mtk_iommu.c
>>> +++ b/drivers/iommu/mtk_iommu.c
>>> @@ -234,7 +234,12 @@ static void mtk_iommu_tlb_flush_page_nosync(struct iommu_iotlb_gather *gather,
>>>    					    unsigned long iova, size_t granule,
>>>    					    void *cookie)
>>>    {
>>> -	mtk_iommu_tlb_add_flush_nosync(iova, granule, granule, true, cookie);
>>> +	struct mtk_iommu_data *data = cookie;
>>> +	struct iommu_domain *domain = &data->m4u_dom->domain;
>>> +
>>> +	data->is_in_tlb_gather_add_page = true;
>>> +	iommu_iotlb_gather_add_page(domain, gather, iova, granule);
>>> +	data->is_in_tlb_gather_add_page = false;
>>>    }
>>>    
>>>    static const struct iommu_flush_ops mtk_iommu_flush_ops = {
>>> @@ -453,12 +458,28 @@ static void mtk_iommu_flush_iotlb_all(struct iommu_domain *domain)
>>>    static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
>>>    				 struct iommu_iotlb_gather *gather)
>>>    {
>>> +	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
>>>    	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
>>> +	bool is_in_gather = data->is_in_tlb_gather_add_page;
>>> +	size_t length = gather->end - gather->start;
>>>    	unsigned long flags;
>>>    
>>> -	spin_lock_irqsave(&dom->pgtlock, flags);
>>> -	mtk_iommu_tlb_sync(mtk_iommu_get_m4u_data());
>>> -	spin_unlock_irqrestore(&dom->pgtlock, flags);
>>> +	if (gather->start == ULONG_MAX)
>>> +		return;
>>> +
>>> +	/*
>>> +	 * Avoid acquire the lock when it's in gather_add_page since the lock
>>> +	 * has already been held.
>>> +	 */
>>> +	if (!is_in_gather)
>>> +		spin_lock_irqsave(&dom->pgtlock, flags);
>>> +
>>> +	mtk_iommu_tlb_add_flush_nosync(gather->start, length, gather->pgsize,
>>> +				       false, data);
>>> +	mtk_iommu_tlb_sync(data);
>>> +
>>> +	if (!is_in_gather)
>>> +		spin_unlock_irqrestore(&dom->pgtlock, flags);
>>>    }
>>>    
>>>    static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
>>> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
>>> index fc0f16e..d29af1d 100644
>>> --- a/drivers/iommu/mtk_iommu.h
>>> +++ b/drivers/iommu/mtk_iommu.h
>>> @@ -58,6 +58,7 @@ struct mtk_iommu_data {
>>>    	struct iommu_group		*m4u_group;
>>>    	bool                            enable_4GB;
>>>    	bool				tlb_flush_active;
>>> +	bool				is_in_tlb_gather_add_page;
>>>    
>>>    	struct iommu_device		iommu;
>>>    	const struct mtk_iommu_plat_data *plat_data;
>>>
> 
> 
