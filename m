Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628C3C76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 08:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27FC021851
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 08:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389474AbfGYIXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 04:23:25 -0400
Received: from relay.sw.ru ([185.231.240.75]:58410 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389405AbfGYIXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 04:23:25 -0400
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.92)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hqZ1x-0001Op-1z; Thu, 25 Jul 2019 11:23:17 +0300
Subject: Re: [PATCH] mm/rmap.c: remove set but not used variable 'cstart'
To:     YueHaibing <yuehaibing@huawei.com>, akpm@linux-foundation.org,
        jglisse@redhat.com, kirill.shutemov@linux.intel.com,
        mike.kravetz@oracle.com, rcampbell@nvidia.com,
        colin.king@canonical.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20190724141453.38536-1-yuehaibing@huawei.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <1d0acd5c-bd49-4d4a-2005-5386b38109dd@virtuozzo.com>
Date:   Thu, 25 Jul 2019 11:23:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724141453.38536-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.07.2019 17:14, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> mm/rmap.c: In function page_mkclean_one:
> mm/rmap.c:906:17: warning: variable cstart set but not used [-Wunused-but-set-variable]
> 
> It is not used any more since
> commit cdb07bdea28e ("mm/rmap.c: remove redundant variable cend")
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>

> ---
>  mm/rmap.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index ec1af8b..40e4def 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -903,10 +903,9 @@ static bool page_mkclean_one(struct page *page, struct vm_area_struct *vma,
>  	mmu_notifier_invalidate_range_start(&range);
>  
>  	while (page_vma_mapped_walk(&pvmw)) {
> -		unsigned long cstart;
>  		int ret = 0;
>  
> -		cstart = address = pvmw.address;
> +		address = pvmw.address;
>  		if (pvmw.pte) {
>  			pte_t entry;
>  			pte_t *pte = pvmw.pte;
> @@ -933,7 +932,6 @@ static bool page_mkclean_one(struct page *page, struct vm_area_struct *vma,
>  			entry = pmd_wrprotect(entry);
>  			entry = pmd_mkclean(entry);
>  			set_pmd_at(vma->vm_mm, address, pmd, entry);
> -			cstart &= PMD_MASK;
>  			ret = 1;
>  #else
>  			/* unexpected pmd-mapped page? */
> 

