Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E646FC46478
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9A7218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YGnNDsOJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfGCU0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 16:26:40 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19744 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfGCU0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 16:26:39 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d1d0f7d0000>; Wed, 03 Jul 2019 13:26:37 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 03 Jul 2019 13:26:38 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 03 Jul 2019 13:26:38 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 3 Jul
 2019 20:26:34 +0000
Subject: Re: [PATCH 5/5] mm: remove the legacy hmm_pfn_* APIs
To:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
CC:     <linux-mm@kvack.org>, <nouveau@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20190703184502.16234-1-hch@lst.de>
 <20190703184502.16234-6-hch@lst.de>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <d234738d-92ee-a841-5d9b-22881f2ac545@nvidia.com>
Date:   Wed, 3 Jul 2019 13:26:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190703184502.16234-6-hch@lst.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562185597; bh=rm6vHnMn1NjJ83H8wZDmyjFoYuZQHy+fENvMn/j452Q=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=YGnNDsOJPDkrHnZlPSB55fjBHjofdZ1pqmg5mfa3pGUujmhe6o4wkL5zQFrut+fQL
         EmRJT13nJsodHkdgKjpZR4k/NVQ+p2haLqoN51ApjjBfdxsQu37mRCZGfnn6ihTByE
         RqPRggRXqjKi+TPrFy0qX8AWs4E/HIO1hxx+f7X5zz0G3WndR2YJOusT3+PpWP3WqJ
         GC1OQ7RZna/YgqfIZhbnEszK6cBofosZXX+Adtv7Nj+x4Kwh931vt2y8xYJ1ObEqrj
         DN+gXSpIZpsebWAzOqem2frFsJh0Yzu9UH1ZaH7KUfDvQlih8aYWqZh7VPKCTVXycB
         sw34ttIzrFWiQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/3/19 11:45 AM, Christoph Hellwig wrote:
> Switch the one remaining user in nouveau over to its replacement,
> and remove all the wrappers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

> ---
>   drivers/gpu/drm/nouveau/nouveau_dmem.c |  2 +-
>   include/linux/hmm.h                    | 34 --------------------------
>   2 files changed, 1 insertion(+), 35 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> index 42c026010938..b9ced2e61667 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> @@ -844,7 +844,7 @@ nouveau_dmem_convert_pfn(struct nouveau_drm *drm,
>   		struct page *page;
>   		uint64_t addr;
>   
> -		page = hmm_pfn_to_page(range, range->pfns[i]);
> +		page = hmm_device_entry_to_page(range, range->pfns[i]);
>   		if (page == NULL)
>   			continue;
>   
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index 657606f48796..cdcd78627393 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -290,40 +290,6 @@ static inline uint64_t hmm_device_entry_from_pfn(const struct hmm_range *range,
>   		range->flags[HMM_PFN_VALID];
>   }
>   
> -/*
> - * Old API:
> - * hmm_pfn_to_page()
> - * hmm_pfn_to_pfn()
> - * hmm_pfn_from_page()
> - * hmm_pfn_from_pfn()
> - *
> - * This are the OLD API please use new API, it is here to avoid cross-tree
> - * merge painfullness ie we convert things to new API in stages.
> - */
> -static inline struct page *hmm_pfn_to_page(const struct hmm_range *range,
> -					   uint64_t pfn)
> -{
> -	return hmm_device_entry_to_page(range, pfn);
> -}
> -
> -static inline unsigned long hmm_pfn_to_pfn(const struct hmm_range *range,
> -					   uint64_t pfn)
> -{
> -	return hmm_device_entry_to_pfn(range, pfn);
> -}
> -
> -static inline uint64_t hmm_pfn_from_page(const struct hmm_range *range,
> -					 struct page *page)
> -{
> -	return hmm_device_entry_from_page(range, page);
> -}
> -
> -static inline uint64_t hmm_pfn_from_pfn(const struct hmm_range *range,
> -					unsigned long pfn)
> -{
> -	return hmm_device_entry_from_pfn(range, pfn);
> -}
> -
>   /*
>    * Mirroring: how to synchronize device page table with CPU page table.
>    *
> 
