Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4259EC4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3BF21835
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391387AbfJPH4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:56:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55810 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbfJPH4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:56:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 02240309DEF8;
        Wed, 16 Oct 2019 07:56:22 +0000 (UTC)
Received: from [10.36.117.237] (ovpn-117-237.ams2.redhat.com [10.36.117.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 719A760A97;
        Wed, 16 Oct 2019 07:56:20 +0000 (UTC)
Subject: Re: [PATCH] mm, soft-offline: convert parameter to pfn
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20191016070924.GA10178@hori.linux.bs1.fc.nec.co.jp>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <e931b14b-da27-2720-5344-b5c0b08b38ad@redhat.com>
Date:   Wed, 16 Oct 2019 09:56:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191016070924.GA10178@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 16 Oct 2019 07:56:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.10.19 09:09, Naoya Horiguchi wrote:
> Hi,
> 
> I wrote a simple cleanup for parameter of soft_offline_page(),
> based on thread https://lkml.org/lkml/2019/10/11/57.
> 
> I know that we need more cleanup on hwpoison-inject, but I think
> that will be mentioned in re-write patchset Oscar is preparing now.
> So let me shared only this part as a separate one now.
> 
> Thanks,
> Naoya Horiguchi
> ---
> From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Date: Wed, 16 Oct 2019 15:49:00 +0900
> Subject: [PATCH] mm, soft-offline: convert parameter to pfn
> 
> Currently soft_offline_page() receives struct page, and its sibling
> memory_failure() receives pfn. This discrepancy looks weird and makes
> precheck on pfn validity tricky. So let's align them.
> 
> Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> ---
>   drivers/base/memory.c | 2 +-
>   include/linux/mm.h    | 2 +-
>   mm/madvise.c          | 2 +-
>   mm/memory-failure.c   | 8 ++++----
>   4 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index e5485c22ef77..04e469c82852 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -540,7 +540,7 @@ static ssize_t soft_offline_page_store(struct device *dev,
>   	pfn >>= PAGE_SHIFT;
>   	if (!pfn_valid(pfn))
>   		return -ENXIO;
> -	ret = soft_offline_page(pfn_to_page(pfn));
> +	ret = soft_offline_page(pfn);
>   	return ret == 0 ? count : ret;
>   }
>   
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 3eba26324ff1..0a452020edf5 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2783,7 +2783,7 @@ extern int sysctl_memory_failure_early_kill;
>   extern int sysctl_memory_failure_recovery;
>   extern void shake_page(struct page *p, int access);
>   extern atomic_long_t num_poisoned_pages __read_mostly;
> -extern int soft_offline_page(struct page *page);
> +extern int soft_offline_page(unsigned long pfn);
>   
>   
>   /*
> diff --git a/mm/madvise.c b/mm/madvise.c
> index fd221b610b52..df198d1e5e2e 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -893,7 +893,7 @@ static int madvise_inject_error(int behavior,
>   		if (behavior == MADV_SOFT_OFFLINE) {
>   			pr_info("Soft offlining pfn %#lx at process virtual address %#lx\n",
>   				 pfn, start);
> -			ret = soft_offline_page(page);
> +			ret = soft_offline_page(pfn);
>   			if (ret)
>   				return ret;
>   		} else {
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 4f16e0a7e7cc..eb4fd5e8d5e1 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1514,7 +1514,7 @@ static void memory_failure_work_func(struct work_struct *work)
>   		if (!gotten)
>   			break;
>   		if (entry.flags & MF_SOFT_OFFLINE)
> -			soft_offline_page(pfn_to_page(entry.pfn));
> +			soft_offline_page(entry.pfn);
>   		else
>   			memory_failure(entry.pfn, entry.flags);
>   	}
> @@ -1822,7 +1822,7 @@ static int soft_offline_free_page(struct page *page)
>   
>   /**
>    * soft_offline_page - Soft offline a page.
> - * @page: page to offline
> + * @pfn: pfn to soft-offline
>    *
>    * Returns 0 on success, otherwise negated errno.
>    *
> @@ -1841,10 +1841,10 @@ static int soft_offline_free_page(struct page *page)
>    * This is not a 100% solution for all memory, but tries to be
>    * ``good enough'' for the majority of memory.
>    */
> -int soft_offline_page(struct page *page)
> +int soft_offline_page(unsigned long pfn)
>   {
>   	int ret;
> -	unsigned long pfn = page_to_pfn(page);
> +	struct page *page = pfn_to_page(pfn);
>   
>   	if (is_zone_device_page(page)) {
>   		pr_debug_ratelimited("soft_offline: %#lx page is device page\n",
> 

I think you should rebase that patch on linux-next (where the  
pfn_to_online_page() check is in place). I assume you'll want to move  
the pfn_to_online_page() check into soft_offline_page() then as well?

-- 

Thanks,

David / dhildenb
