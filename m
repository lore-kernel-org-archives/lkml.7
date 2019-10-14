Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DD6ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57CCD2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387647AbfJNQ2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 12:28:30 -0400
Received: from foss.arm.com ([217.140.110.172]:48448 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729930AbfJNQ23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 12:28:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C9BF28;
        Mon, 14 Oct 2019 09:28:29 -0700 (PDT)
Received: from [10.1.194.43] (e112269-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 391423F718;
        Mon, 14 Oct 2019 09:28:28 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
Subject: Re: [PATCH] drm/panfrost: DMA map all pages shared with the GPU
To:     Robin Murphy <robin.murphy@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
References: <20191014151616.14099-1-steven.price@arm.com>
 <99f279c5-e93d-ade6-cd97-56b3078da755@arm.com>
 <8f8bd089-102f-9b8b-335b-6be06687d0ac@arm.com>
Message-ID: <0cfd8582-b4e1-d429-7db8-23814b063403@arm.com>
Date:   Mon, 14 Oct 2019 17:28:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <8f8bd089-102f-9b8b-335b-6be06687d0ac@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2019 16:55, Steven Price wrote:
> On 14/10/2019 16:46, Robin Murphy wrote:
>> On 14/10/2019 16:16, Steven Price wrote:
>>> Pages shared with the GPU are (often) not cache coherent with the CPU so
>>> cache maintenance is required to flush the CPU's caches. This was
>>> already done when mapping pages on fault, but wasn't previously done
>>> when mapping a freshly allocated page.
>>>
>>> Fix this by moving the call to dma_map_sg() into mmu_map_sg() ensuring
>>> that it is always called when pages are mapped onto the GPU. Since
>>> mmu_map_sg() can now fail the code also now has to handle an error
>>> return.
>>>
>>> Not performing this cache maintenance can cause errors in the GPU output
>>> (CPU caches are later flushed and overwrite the GPU output). In theory
>>> it also allows the GPU (and by extension user space) to observe the
>>> memory contents prior to sanitization.
>>
>> For the non-heap case, aren't the pages already supposed to be mapped by
>> drm_gem_shmem_get_pages_sgt()?
> 
> Hmm, well yes - it looks like it *should* work - but I was definitely
> seeing cache artefacts until I did this change... let me do some more
> testing. It's possible that this is actually only affecting buffers
> imported from another driver. Perhaps it's
> drm_gem_shmem_prime_import_sg_table() that needs fixing.

Yes this does appear to only affect imported buffers from what I can
tell. Looking through the code there is something suspicious in
drm_gem_map_dma_buf(). The following "fixes" the problem. But I'm not
sure the reasoning behind DMA_ATTR_SKIP_CPU_SYNC being specified -
presumably someone though it was a good idea! I'm not sure which driver's
responsibility it is to ensure the caches are flushed.

---8<----
diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 0a2316e0e812..1f7353abd255 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -625,7 +625,7 @@ struct sg_table *drm_gem_map_dma_buf(struct dma_buf_attachment *attach,
 		sgt = obj->dev->driver->gem_prime_get_sg_table(obj);
 
 	if (!dma_map_sg_attrs(attach->dev, sgt->sgl, sgt->nents, dir,
-			      DMA_ATTR_SKIP_CPU_SYNC)) {
+			      0)) {
 		sg_free_table(sgt);
 		kfree(sgt);
 		sgt = ERR_PTR(-ENOMEM);
