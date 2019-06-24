Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB00C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 05:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE08E208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 05:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfFXFQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 01:16:15 -0400
Received: from foss.arm.com ([217.140.110.172]:41224 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbfFXFQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 01:16:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95739344;
        Sun, 23 Jun 2019 22:16:14 -0700 (PDT)
Received: from [10.162.41.123] (p8cg001049571a15.blr.arm.com [10.162.41.123])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E82183F718;
        Sun, 23 Jun 2019 22:18:00 -0700 (PDT)
Subject: Re: [PATCH] mm/hugetlb: allow gigantic page allocation to migrate
 away smaller huge page
To:     Pingfan Liu <kernelfans@gmail.com>, linux-mm@kvack.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <1561350068-8966-1-git-send-email-kernelfans@gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <216a335d-f7c6-26ad-2ac1-427c8a73ca2f@arm.com>
Date:   Mon, 24 Jun 2019 10:46:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1561350068-8966-1-git-send-email-kernelfans@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/24/2019 09:51 AM, Pingfan Liu wrote:
> The current pfn_range_valid_gigantic() rejects the pud huge page allocation
> if there is a pmd huge page inside the candidate range.
> 
> But pud huge resource is more rare, which should align on 1GB on x86. It is
> worth to allow migrating away pmd huge page to make room for a pud huge
> page.
> 
> The same logic is applied to pgd and pud huge pages.

The huge page in the range can either be a THP or HugeTLB and migrating them has
different costs and chances of success. THP migration will involve splitting if
THP migration is not enabled and all related TLB related costs. Are you sure
that a PUD HugeTLB allocation really should go through these ? Is there any
guarantee that after migration of multiple PMD sized THP/HugeTLB pages on the
given range, the allocation request for PUD will succeed ?

> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-kernel@vger.kernel.org
> ---
>  mm/hugetlb.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index ac843d3..02d1978 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1081,7 +1081,11 @@ static bool pfn_range_valid_gigantic(struct zone *z,
>  			unsigned long start_pfn, unsigned long nr_pages)
>  {
>  	unsigned long i, end_pfn = start_pfn + nr_pages;
> -	struct page *page;
> +	struct page *page = pfn_to_page(start_pfn);
> +
> +	if (PageHuge(page))
> +		if (compound_order(compound_head(page)) >= nr_pages)
> +			return false;
>  
>  	for (i = start_pfn; i < end_pfn; i++) {
>  		if (!pfn_valid(i))
> @@ -1098,8 +1102,6 @@ static bool pfn_range_valid_gigantic(struct zone *z,
>  		if (page_count(page) > 0)
>  			return false;
>  
> -		if (PageHuge(page))
> -			return false;
>  	}
>  
>  	return true;
> 

So except in the case where there is a bigger huge page in the range this will
attempt migrating everything on the way. As mentioned before if it all this is
a good idea, it needs to differentiate between HugeTLB and THP and also take
into account costs of migrations and chance of subsequence allocation attempt
into account.
