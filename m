Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BA8C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 23:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA6221773
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 23:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ksFZrQt2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbfG2Xb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 19:31:28 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11275 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbfG2Xb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 19:31:28 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d3f81d70000>; Mon, 29 Jul 2019 16:31:35 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 29 Jul 2019 16:31:27 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 29 Jul 2019 16:31:27 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 29 Jul
 2019 23:31:21 +0000
Subject: Re: [PATCH 8/9] mm: remove the unused MIGRATE_PFN_DEVICE flag
To:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
CC:     Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <nouveau@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20190729142843.22320-1-hch@lst.de>
 <20190729142843.22320-9-hch@lst.de>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <ef44f3bf-0f99-c76b-bf4b-6770545b5e38@nvidia.com>
Date:   Mon, 29 Jul 2019 16:31:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190729142843.22320-9-hch@lst.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564443095; bh=O8zN+ilqdowg6XJWOKGWaqeRnGFJG/18lWzHA9AhwWg=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ksFZrQt2v45qX2vcjwJOYMc2IYWSZCkT/o6FR2ewt0B28A8Pwta4vodqAlIT7qjJ9
         zqGQu+CeunJs69LRMBaqQpcPotQy5akTZlYOxF8zf4tZ8NOYJ3kFXTJallM2SgRtki
         OjfEHbYJ0N+6ddvwlV642w+rlUwTQJ5ngnGzTgj51qvcxlg9bPNwz5KN7gch3/y9wY
         iKWVWCvXxV8WHLpLQUMgKR+iDgLBdEkyUwwunjFL3LfUHbMCmOhwdSeXZT/NMGHcYm
         zT4LqGYJMVqQKdyWKkoJt2M0YVcRGLOqrwkAr5+KyToFtSthkJ2Uvd7vW5Cci8rLNL
         bU4mBP2GsvKFg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/29/19 7:28 AM, Christoph Hellwig wrote:
> No one ever checks this flag, and we could easily get that information
> from the page if needed.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

> ---
>   drivers/gpu/drm/nouveau/nouveau_dmem.c | 3 +--
>   include/linux/migrate.h                | 1 -
>   mm/migrate.c                           | 4 ++--
>   3 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> index 6cb930755970..f04686a2c21f 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> @@ -582,8 +582,7 @@ static unsigned long nouveau_dmem_migrate_copy_one(struct nouveau_drm *drm,
>   			*dma_addr))
>   		goto out_dma_unmap;
>   
> -	return migrate_pfn(page_to_pfn(dpage)) |
> -		MIGRATE_PFN_LOCKED | MIGRATE_PFN_DEVICE;
> +	return migrate_pfn(page_to_pfn(dpage)) | MIGRATE_PFN_LOCKED;
>   
>   out_dma_unmap:
>   	dma_unmap_page(dev, *dma_addr, PAGE_SIZE, DMA_BIDIRECTIONAL);
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 229153c2c496..8b46cfdb1a0e 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -166,7 +166,6 @@ static inline int migrate_misplaced_transhuge_page(struct mm_struct *mm,
>   #define MIGRATE_PFN_MIGRATE	(1UL << 1)
>   #define MIGRATE_PFN_LOCKED	(1UL << 2)
>   #define MIGRATE_PFN_WRITE	(1UL << 3)
> -#define MIGRATE_PFN_DEVICE	(1UL << 4)
>   #define MIGRATE_PFN_SHIFT	6
>   
>   static inline struct page *migrate_pfn_to_page(unsigned long mpfn)
> diff --git a/mm/migrate.c b/mm/migrate.c
> index dc4e60a496f2..74735256e260 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2237,8 +2237,8 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>   				goto next;
>   
>   			page = device_private_entry_to_page(entry);
> -			mpfn = migrate_pfn(page_to_pfn(page))|
> -				MIGRATE_PFN_DEVICE | MIGRATE_PFN_MIGRATE;
> +			mpfn = migrate_pfn(page_to_pfn(page)) |
> +					MIGRATE_PFN_MIGRATE;
>   			if (is_write_device_private_entry(entry))
>   				mpfn |= MIGRATE_PFN_WRITE;
>   		} else {
> 
