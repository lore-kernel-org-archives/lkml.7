Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1229C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 05:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6FB4208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 05:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfFXFDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 01:03:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:32399 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbfFXFDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 01:03:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jun 2019 22:03:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,411,1557212400"; 
   d="scan'208";a="163216338"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga007.fm.intel.com with ESMTP; 23 Jun 2019 22:03:42 -0700
Date:   Sun, 23 Jun 2019 22:03:42 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-mm@kvack.org, Mike Kravetz <mike.kravetz@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb: allow gigantic page allocation to migrate
 away smaller huge page
Message-ID: <20190624050341.GB30102@iweiny-DESK2.sc.intel.com>
References: <1561350068-8966-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561350068-8966-1-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 12:21:08PM +0800, Pingfan Liu wrote:
> The current pfn_range_valid_gigantic() rejects the pud huge page allocation
> if there is a pmd huge page inside the candidate range.
> 
> But pud huge resource is more rare, which should align on 1GB on x86. It is
> worth to allow migrating away pmd huge page to make room for a pud huge
> page.
> 
> The same logic is applied to pgd and pud huge pages.

I'm sorry but I don't quite understand why we should do this.  Is this a bug or
an optimization?  It sounds like an optimization.

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

I don't think you want compound_order() here.

Ira

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
> -- 
> 2.7.5
> 
