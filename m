Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BDEC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B0720679
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404950AbfFKJuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 05:50:12 -0400
Received: from foss.arm.com ([217.140.110.172]:56822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728865AbfFKJuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 05:50:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30E24337;
        Tue, 11 Jun 2019 02:50:11 -0700 (PDT)
Received: from [10.162.43.135] (p8cg001049571a15.blr.arm.com [10.162.43.135])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC1593F73C;
        Tue, 11 Jun 2019 02:51:50 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] mm: hugetlb: soft-offline:
 dissolve_free_huge_page() return zero on !PageHuge
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        xishi.qiuxishi@alibaba-inc.com,
        "Chen, Jerry T" <jerry.t.chen@intel.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, linux-kernel@vger.kernel.org
References: <1560154686-18497-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <1560154686-18497-3-git-send-email-n-horiguchi@ah.jp.nec.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <4a1ea5f4-d35d-f3a6-920c-c35520234aa3@arm.com>
Date:   Tue, 11 Jun 2019 15:20:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1560154686-18497-3-git-send-email-n-horiguchi@ah.jp.nec.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/10/2019 01:48 PM, Naoya Horiguchi wrote:
> madvise(MADV_SOFT_OFFLINE) often returns -EBUSY when calling soft offline
> for hugepages with overcommitting enabled. That was caused by the suboptimal
> code in current soft-offline code. See the following part:
> 
>     ret = migrate_pages(&pagelist, new_page, NULL, MPOL_MF_MOVE_ALL,
>                             MIGRATE_SYNC, MR_MEMORY_FAILURE);
>     if (ret) {
>             ...
>     } else {
>             /*
>              * We set PG_hwpoison only when the migration source hugepage
>              * was successfully dissolved, because otherwise hwpoisoned
>              * hugepage remains on free hugepage list, then userspace will
>              * find it as SIGBUS by allocation failure. That's not expected
>              * in soft-offlining.
>              */
>             ret = dissolve_free_huge_page(page);
>             if (!ret) {
>                     if (set_hwpoison_free_buddy_page(page))
>                             num_poisoned_pages_inc();
>             }
>     }
>     return ret;
> 
> Here dissolve_free_huge_page() returns -EBUSY if the migration source page
> was freed into buddy in migrate_pages(), but even in that case we actually

Over committed source pages will be released into buddy and the normal ones
will not be ? dissolve_free_huge_page() returns -EBUSY because PageHuge()
return negative on already released pages ? How dissolve_free_huge_page()
will behave differently with over committed pages. I might be missing some
recent developments here.

> has a chance that set_hwpoison_free_buddy_page() succeeds. So that means
> current code gives up offlining too early now.

Hmm. It gives up early as the return value from dissolve_free_huge_page(EBUSY)
gets back as the return code for soft_offline_huge_page() without attempting
set_hwpoison_free_buddy_page() which still has a chance to succeed for freed
normal buddy pages.

> 
> dissolve_free_huge_page() checks that a given hugepage is suitable for
> dissolving, where we should return success for !PageHuge() case because
> the given hugepage is considered as already dissolved.

Right. It should return 0 (as a success) for freed normal buddy pages. Should
not it then check explicitly for PageBuddy() as well ?

> 
> This change also affects other callers of dissolve_free_huge_page(),
> which are cleaned up together.
> 
> Reported-by: Chen, Jerry T <jerry.t.chen@intel.com>
> Tested-by: Chen, Jerry T <jerry.t.chen@intel.com>
> Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Fixes: 6bc9b56433b76 ("mm: fix race on soft-offlining")
> Cc: <stable@vger.kernel.org> # v4.19+
> ---
>  mm/hugetlb.c        | 15 +++++++++------
>  mm/memory-failure.c |  5 +----
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git v5.2-rc3/mm/hugetlb.c v5.2-rc3_patched/mm/hugetlb.c
> index ac843d3..048d071 100644
> --- v5.2-rc3/mm/hugetlb.c
> +++ v5.2-rc3_patched/mm/hugetlb.c
> @@ -1519,7 +1519,12 @@ int dissolve_free_huge_page(struct page *page)
>  	int rc = -EBUSY;
>  
>  	spin_lock(&hugetlb_lock);
> -	if (PageHuge(page) && !page_count(page)) {
> +	if (!PageHuge(page)) {
> +		rc = 0;
> +		goto out;
> +	}

With this early bail out it maintains the functionality when called from
soft_offline_free_page() for normal pages. For huge page, it continues
on the previous path.

> +
> +	if (!page_count(page)) {
>  		struct page *head = compound_head(page);
>  		struct hstate *h = page_hstate(head);
>  		int nid = page_to_nid(head);
> @@ -1564,11 +1569,9 @@ int dissolve_free_huge_pages(unsigned long start_pfn, unsigned long end_pfn)
>  
>  	for (pfn = start_pfn; pfn < end_pfn; pfn += 1 << minimum_order) {
>  		page = pfn_to_page(pfn);
> -		if (PageHuge(page) && !page_count(page)) {

Right. These checks are now redundant.
