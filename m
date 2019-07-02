Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FF3C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D79CC2054F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfGBKkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 06:40:05 -0400
Received: from foss.arm.com ([217.140.110.172]:47616 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfGBKkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 06:40:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D9BD344;
        Tue,  2 Jul 2019 03:40:04 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A51823F246;
        Tue,  2 Jul 2019 03:40:03 -0700 (PDT)
Subject: Re: [PATCH] iommu/dma: Fix calculation overflow in __finalise_sg()
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20190622043814.5003-1-nicoleotsuka@gmail.com>
 <20190701122158.GE8166@8bytes.org>
 <91a389be-fd76-c87f-7613-8cc972b69685@arm.com>
 <20190701215016.GA16247@Asurada-Nvidia.nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <d4bccb17-2f7a-65e4-6c89-e37cceb6d935@arm.com>
Date:   Tue, 2 Jul 2019 11:40:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190701215016.GA16247@Asurada-Nvidia.nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/2019 22:50, Nicolin Chen wrote:
> Hi Robin,
> 
> On Mon, Jul 01, 2019 at 01:39:55PM +0100, Robin Murphy wrote:
>>>> The max_len is a u32 type variable so the calculation on the
>>>> left hand of the last if-condition will potentially overflow
>>>> when a cur_len gets closer to UINT_MAX -- note that there're
>>>> drivers setting max_seg_size to UINT_MAX:
>>>>     drivers/dma/dw-edma/dw-edma-core.c:745:
>>>>       dma_set_max_seg_size(dma->dev, U32_MAX);
>>>>     drivers/dma/dma-axi-dmac.c:871:
>>>>       dma_set_max_seg_size(&pdev->dev, UINT_MAX);
>>>>     drivers/mmc/host/renesas_sdhi_internal_dmac.c:338:
>>>>       dma_set_max_seg_size(dev, 0xffffffff);
>>>>     drivers/nvme/host/pci.c:2520:
>>>>       dma_set_max_seg_size(dev->dev, 0xffffffff);
>>>>
>>>> So this patch just casts the cur_len in the calculation to a
>>>> size_t type to fix the overflow issue, as it's not necessary
>>>> to change the type of cur_len after all.
>>>>
>>>> Fixes: 809eac54cdd6 ("iommu/dma: Implement scatterlist segment merging")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
>>>
>>> Looks good to me, but I let Robin take a look too before I apply it,
>>> Robin?
>> I'll need to take a closer look at how exactly an overflow would happen here
> 
> It was triggered by a test case that was trying to map a 4GB
> dma_buf (1000+ nents in the scatterlist). This function then
> seemed to reduce the nents by merging most of them, probably
> because they were contiguous.

So, looking at the code now, the actual problem seems to be that this
overflow allows segments to be merged to or beyond 4GB total length,
thus sg->dma_length for the resulting segment also ends up wrapped and
truncated, and the caller will end up going downhill from there; is that
correct?

>> (just got back off some holiday), but my immediate thought is that if this
>> is a real problem, then what about 32-bit builds where size_t would still
>> overflow?
> 
> I think most of callers are also using size_t type for their
> size parameters like dma_buf, so the cur_len + s_length will
> unlikely go higher than UINT_MAX. But just in case that some
> driver allocates a large sg with a size parameter defined in
> 64-bit and uses this map() function, so it might be safer to
> change to "size_t" here to "u64"?

On reflection, I don't really think that size_t fits here anyway, since
all the members of the incoming struct scatterlist are unsigned int too.
Does the patch below work?

Robin.

----->8-----
From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] iommu/dma: Handle SG length overflow better

Since scatterlist dimensions are all unsigned ints, in the relatively
rare cases where a device's max_segment_size is set to UINT_MAX, then
the "cur_len + s_length <= max_len" check in __finalise_sg() will always
return true. As a result, the corner case of such a device mapping an
excessively large scatterlist which is mergeable to or beyond a total
length of 4GB can lead to overflow and a bogus truncated dma_length in
the resulting segment.

As we already assume that any single segment must be no longer than
max_len to begin with, this can easily be addressed by reshuffling the
comparison.

Fixes: 809eac54cdd6 ("iommu/dma: Implement scatterlist segment merging")
Reported-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 129c4badf9ae..8de6cf623362 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -721,7 +721,7 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
 		 * - and wouldn't make the resulting output segment too long
 		 */
 		if (cur_len && !s_iova_off && (dma_addr & seg_mask) &&
-		    (cur_len + s_length <= max_len)) {
+		    (max_len - cur_len >= s_length)) {
 			/* ...then concatenate it with the previous one */
 			cur_len += s_length;
 		} else {
