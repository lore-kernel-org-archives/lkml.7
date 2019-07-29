Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAF6C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 23:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FFA0216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 23:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dkCF/sqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbfG2XmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 19:42:08 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18889 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbfG2XmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 19:42:07 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d3f844f0000>; Mon, 29 Jul 2019 16:42:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 29 Jul 2019 16:42:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 29 Jul 2019 16:42:07 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 29 Jul
 2019 23:42:02 +0000
Subject: Re: [PATCH 9/9] mm: remove the MIGRATE_PFN_WRITE flag
To:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
CC:     Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <nouveau@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20190729142843.22320-1-hch@lst.de>
 <20190729142843.22320-10-hch@lst.de>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <1f0ef337-6ca5-54fa-e627-41a46be73f2b@nvidia.com>
Date:   Mon, 29 Jul 2019 16:42:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190729142843.22320-10-hch@lst.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564443727; bh=mEZj3q5EnGdFR96z4O+Iz+WRmNblkDEHHCZr6fLsRoI=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=dkCF/sqUubSJ16D0gzxWuIiRNyylExBkjSHrf+wBYiOEClAdNIcs4OLHo2fvbGIoX
         1HoTvy5tiILWD6dBrPFwdRF2JWe6qCogaekLOh7Q9mzfJygH45h8qJ5PLN8swqY07T
         H1AJG4slDbp8zFXaoA4gVYQpxo9dk3Ja5/reP1N0iQzGM2uEGVxa5oPVE2ahLha6XU
         XU7vinMQxUun59ktKiGlAoPT5x2NslQA58ySa1FgSzuEL5AR9P4hKjpvOH9Ww28B4H
         /6XKbzh2v/KF3c26Bvn4BAaIQuv9vhITJ4xA1s6tfjdxhUZXgaQvU2ZRaV1RuodxD0
         NRxR0aABTDx7Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/29/19 7:28 AM, Christoph Hellwig wrote:
> The MIGRATE_PFN_WRITE is only used locally in migrate_vma_collect_pmd,
> where it can be replaced with a simple boolean local variable.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

> ---
>   include/linux/migrate.h | 1 -
>   mm/migrate.c            | 9 +++++----
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 8b46cfdb1a0e..ba74ef5a7702 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -165,7 +165,6 @@ static inline int migrate_misplaced_transhuge_page(struct mm_struct *mm,
>   #define MIGRATE_PFN_VALID	(1UL << 0)
>   #define MIGRATE_PFN_MIGRATE	(1UL << 1)
>   #define MIGRATE_PFN_LOCKED	(1UL << 2)
> -#define MIGRATE_PFN_WRITE	(1UL << 3)
>   #define MIGRATE_PFN_SHIFT	6
>   
>   static inline struct page *migrate_pfn_to_page(unsigned long mpfn)
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 74735256e260..724f92dcc31b 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2212,6 +2212,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>   		unsigned long mpfn, pfn;
>   		struct page *page;
>   		swp_entry_t entry;
> +		bool writable = false;
>   		pte_t pte;
>   
>   		pte = *ptep;
> @@ -2240,7 +2241,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>   			mpfn = migrate_pfn(page_to_pfn(page)) |
>   					MIGRATE_PFN_MIGRATE;
>   			if (is_write_device_private_entry(entry))
> -				mpfn |= MIGRATE_PFN_WRITE;
> +				writable = true;
>   		} else {
>   			if (is_zero_pfn(pfn)) {
>   				mpfn = MIGRATE_PFN_MIGRATE;
> @@ -2250,7 +2251,8 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>   			}
>   			page = vm_normal_page(migrate->vma, addr, pte);
>   			mpfn = migrate_pfn(pfn) | MIGRATE_PFN_MIGRATE;
> -			mpfn |= pte_write(pte) ? MIGRATE_PFN_WRITE : 0;
> +			if (pte_write(pte))
> +				writable = true;
>   		}
>   
>   		/* FIXME support THP */
> @@ -2284,8 +2286,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>   			ptep_get_and_clear(mm, addr, ptep);
>   
>   			/* Setup special migration page table entry */
> -			entry = make_migration_entry(page, mpfn &
> -						     MIGRATE_PFN_WRITE);
> +			entry = make_migration_entry(page, writable);
>   			swp_pte = swp_entry_to_pte(entry);
>   			if (pte_soft_dirty(pte))
>   				swp_pte = pte_swp_mksoft_dirty(swp_pte);
> 

MIGRATE_PFN_WRITE may mot being used but that seems like a bug to me.
If a page is migrated to device memory, it could be mapped at the same
time to avoid a device page fault but it would need the flag to know
whether to map it RW or RO. But I suppose that could be inferred from
the vma->vm_flags.
