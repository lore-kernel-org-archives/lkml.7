Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030E3C32750
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 01:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE15F206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 01:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ajEzn9uW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfGaBBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 21:01:15 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8983 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfGaBBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 21:01:14 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d40e8620000>; Tue, 30 Jul 2019 18:01:23 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 30 Jul 2019 18:01:14 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 30 Jul 2019 18:01:14 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 31 Jul
 2019 01:01:11 +0000
Subject: Re: [PATCH 08/13] mm: remove the mask variable in
 hmm_vma_walk_hugetlb_entry
To:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
CC:     <linux-mm@kvack.org>, <nouveau@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
References: <20190730055203.28467-1-hch@lst.de>
 <20190730055203.28467-9-hch@lst.de>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <5f8e6310-5e97-3e57-bfbf-5eef553b4d91@nvidia.com>
Date:   Tue, 30 Jul 2019 18:01:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190730055203.28467-9-hch@lst.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564534883; bh=OHyHSrA6JVDY2Oejcs6WpJIunzrly1fjS6RVFY7YqjM=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ajEzn9uWQgkCJeHEaoBa1ebIKX456rMGd39kWLEC/7A9cOmd9kLxD/rfHhXnnzvtr
         p8dxFxMmc9Ht+btkwqvj95qMs6DnmoOqgpiDmTYwV4dQWlBWsw5Les1qXHiV0VM+pc
         6eLW+qk0O9HGG/H3cFIxfLKOcWS5roJB4JnQLeWEgBgvU0eJQEGHKIwFkwqHg8yEvK
         UqHAkGFEpMKcWKCnqFErM2grwMv5QR13mPLqhQIdIi6Nq4GCA2AI47+gTlrUlw3Bz/
         teNwUz4zv3BXuhvbEzfoJagndrzFIMXS9QDwkJi6PrOjJJZYCP5Xb7mMbAmAJq3QId
         Pp062/GoAjfpg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/29/19 10:51 PM, Christoph Hellwig wrote:
> The pagewalk code already passes the value as the hmask parameter.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   mm/hmm.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/hmm.c b/mm/hmm.c
> index f26d6abc4ed2..88b77a4a6a1e 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -771,19 +771,16 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
>   				      struct mm_walk *walk)
>   {
>   #ifdef CONFIG_HUGETLB_PAGE
> -	unsigned long addr = start, i, pfn, mask;
> +	unsigned long addr = start, i, pfn;
>   	struct hmm_vma_walk *hmm_vma_walk = walk->private;
>   	struct hmm_range *range = hmm_vma_walk->range;
>   	struct vm_area_struct *vma = walk->vma;
> -	struct hstate *h = hstate_vma(vma);
>   	uint64_t orig_pfn, cpu_flags;
>   	bool fault, write_fault;
>   	spinlock_t *ptl;
>   	pte_t entry;
>   	int ret = 0;
>   
> -	mask = huge_page_size(h) - 1;
> -
>   	ptl = huge_pte_lock(hstate_vma(vma), walk->mm, pte);
>   	entry = huge_ptep_get(pte);
>   
> @@ -799,7 +796,7 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
>   		goto unlock;
>   	}
>   
> -	pfn = pte_pfn(entry) + ((start & mask) >> PAGE_SHIFT);
> +	pfn = pte_pfn(entry) + ((start & hmask) >> PAGE_SHIFT);

This needs to be "~hmask" so that the upper bits of the start address
are not added to the pfn. It's the middle bits of the address that
offset into the huge page that are needed.

>   	for (; addr < end; addr += PAGE_SIZE, i++, pfn++)
>   		range->pfns[i] = hmm_device_entry_from_pfn(range, pfn) |
>   				 cpu_flags;
> 
