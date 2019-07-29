Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DDAC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 23:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F337D20679
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 23:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="NnhEWDfT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbfG2XXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 19:23:23 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17149 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbfG2XXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 19:23:23 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d3f7feb0000>; Mon, 29 Jul 2019 16:23:23 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 29 Jul 2019 16:23:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 29 Jul 2019 16:23:22 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 29 Jul
 2019 23:23:18 +0000
Subject: Re: [PATCH 4/9] nouveau: factor out dmem fence completion
To:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
CC:     Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <nouveau@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20190729142843.22320-1-hch@lst.de>
 <20190729142843.22320-5-hch@lst.de>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <f2af6247-c935-12de-fb12-e418101efdfa@nvidia.com>
Date:   Mon, 29 Jul 2019 16:23:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190729142843.22320-5-hch@lst.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564442603; bh=IyoLCbDcsQakqt7A6+W1y7A2qFkbkRJjy2RWDtkVLUI=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=NnhEWDfT1JRU+yGkNl7isRXL14uONAN+nufQA88N/0WVIGrrXe2VPqIZreLa/iM58
         rrsdH0JGvyxCRjxz6XDeOPcGsuqp6VptCocClcF1kIwsJAO2D/NW+YCRhXkKRipLWH
         botVKAowNZ8G7vOFHGBaKmiBYWS1vuuThPema3w2Ff252O84tPPld7ORsNwKXIEt5A
         gy8P/4HuT/jTrKaPQhTu13ZkYDnUvoPnsagy2yRGHgm6DOUlXGql+9UP9Sm4gEKhVK
         NDxlPJ7YZ/ogVkIam9GCXsqywqwYliQ/7clBqKCCjHiZXNN49ipCt3w4wGcTwD6dAu
         svSbpqgfcVg3A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/29/19 7:28 AM, Christoph Hellwig wrote:
> Factor out the end of fencing logic from the two migration routines.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

> ---
>   drivers/gpu/drm/nouveau/nouveau_dmem.c | 33 ++++++++++++--------------
>   1 file changed, 15 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> index d469bc334438..21052a4aaf69 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> @@ -133,6 +133,19 @@ static void nouveau_dmem_page_free(struct page *page)
>   	spin_unlock(&chunk->lock);
>   }
>   
> +static void nouveau_dmem_fence_done(struct nouveau_fence **fence)
> +{
> +	if (fence) {
> +		nouveau_fence_wait(*fence, true, false);
> +		nouveau_fence_unref(fence);
> +	} else {
> +		/*
> +		 * FIXME wait for channel to be IDLE before calling finalizing
> +		 * the hmem object.
> +		 */
> +	}
> +}
> +
>   static void
>   nouveau_dmem_fault_alloc_and_copy(struct vm_area_struct *vma,
>   				  const unsigned long *src_pfns,
> @@ -236,15 +249,7 @@ nouveau_dmem_fault_finalize_and_map(struct nouveau_dmem_fault *fault)
>   {
>   	struct nouveau_drm *drm = fault->drm;
>   
> -	if (fault->fence) {
> -		nouveau_fence_wait(fault->fence, true, false);
> -		nouveau_fence_unref(&fault->fence);
> -	} else {
> -		/*
> -		 * FIXME wait for channel to be IDLE before calling finalizing
> -		 * the hmem object below (nouveau_migrate_hmem_fini()).
> -		 */
> -	}
> +	nouveau_dmem_fence_done(&fault->fence);
>   
>   	while (fault->npages--) {
>   		dma_unmap_page(drm->dev->dev, fault->dma[fault->npages],
> @@ -748,15 +753,7 @@ nouveau_dmem_migrate_finalize_and_map(struct nouveau_migrate *migrate)
>   {
>   	struct nouveau_drm *drm = migrate->drm;
>   
> -	if (migrate->fence) {
> -		nouveau_fence_wait(migrate->fence, true, false);
> -		nouveau_fence_unref(&migrate->fence);
> -	} else {
> -		/*
> -		 * FIXME wait for channel to be IDLE before finalizing
> -		 * the hmem object below (nouveau_migrate_hmem_fini()) ?
> -		 */
> -	}
> +	nouveau_dmem_fence_done(&migrate->fence);
>   
>   	while (migrate->dma_nr--) {
>   		dma_unmap_page(drm->dev->dev, migrate->dma[migrate->dma_nr],
> 
