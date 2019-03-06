Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0E8C10F00
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E8A20840
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbfCFJlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 04:41:36 -0500
Received: from charybdis-ext.suse.de ([195.135.221.2]:7170 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726596AbfCFJlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 04:41:36 -0500
Received: by suse.de (Postfix, from userid 1000)
        id A3FDF44A0; Wed,  6 Mar 2019 10:41:34 +0100 (CET)
Date:   Wed, 6 Mar 2019 10:41:34 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Jing Xiangfeng <jingxiangfeng@huawei.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "hughd@google.com" <hughd@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH v4] mm/hugetlb: Fix unsigned overflow in
 __nr_hugepages_store_common()
Message-ID: <20190306094130.q5v7qfgbekatnmyk@d104.suse.de>
References: <8c167be7-06fa-a8c0-8ee7-0bfad41eaba2@oracle.com>
 <13400ee2-3d3b-e5d6-2d78-a770820417de@oracle.com>
 <alpine.DEB.2.21.1902251116180.167839@chino.kir.corp.google.com>
 <5C74A2DA.1030304@huawei.com>
 <alpine.DEB.2.21.1902252220310.40851@chino.kir.corp.google.com>
 <e2bded2f-40ca-c308-5525-0a21777ed221@oracle.com>
 <20190226143620.c6af15c7c897d3362b191e36@linux-foundation.org>
 <086c4a4b-a37d-f144-00c0-d9a4062cc5fe@oracle.com>
 <20190305000402.GA4698@hori.linux.bs1.fc.nec.co.jp>
 <8f3aede3-c07e-ac15-1577-7667e5b70d2f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f3aede3-c07e-ac15-1577-7667e5b70d2f@oracle.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 08:15:40PM -0800, Mike Kravetz wrote:
> In addition, the code in __nr_hugepages_store_common() which tries to
> handle the case of not being able to allocate a node mask would likely
> result in incorrect behavior.  Luckily, it is very unlikely we will
> ever take this path.  If we do, simply return ENOMEM.

Hi Mike,

I still thnk that we could just get rid of the NODEMASK_ALLOC machinery
here, it adds a needlessly complexity IMHO.
Note that before "(5df66d306ec9: mm: fix comment for NODEMASK_ALLOC)",
the comment about the size was wrong, showing a much bigger size that it
actually was, and I would not be surprised if people started to add
NODEMASK_ALLOC here and there because of that.

Actually, there was a little talk about removing NODEMASK_ALLOC altogether,
but some further checks must be done before.

> Reported-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

But the overall change looks good to me:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/hugetlb.c | 42 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 33 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index c5c4558e4a79..5a190a652cac 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2274,7 +2274,7 @@ static int adjust_pool_surplus(struct hstate *h, nodemask_t *nodes_allowed,
>  }
>  
>  #define persistent_huge_pages(h) (h->nr_huge_pages - h->surplus_huge_pages)
> -static int set_max_huge_pages(struct hstate *h, unsigned long count,
> +static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>  						nodemask_t *nodes_allowed)
>  {
>  	unsigned long min_count, ret;
> @@ -2289,6 +2289,28 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count,
>  		goto decrease_pool;
>  	}
>  
> +	spin_lock(&hugetlb_lock);
> +
> +	/*
> +	 * Check for a node specific request.
> +	 * Changing node specific huge page count may require a corresponding
> +	 * change to the global count.  In any case, the passed node mask
> +	 * (nodes_allowed) will restrict alloc/free to the specified node.
> +	 */
> +	if (nid != NUMA_NO_NODE) {
> +		unsigned long old_count = count;
> +
> +		count += h->nr_huge_pages - h->nr_huge_pages_node[nid];
> +		/*
> +		 * User may have specified a large count value which caused the
> +		 * above calculation to overflow.  In this case, they wanted
> +		 * to allocate as many huge pages as possible.  Set count to
> +		 * largest possible value to align with their intention.
> +		 */
> +		if (count < old_count)
> +			count = ULONG_MAX;
> +	}
> +
>  	/*
>  	 * Increase the pool size
>  	 * First take pages out of surplus state.  Then make up the
> @@ -2300,7 +2322,6 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count,
>  	 * pool might be one hugepage larger than it needs to be, but
>  	 * within all the constraints specified by the sysctls.
>  	 */
> -	spin_lock(&hugetlb_lock);
>  	while (h->surplus_huge_pages && count > persistent_huge_pages(h)) {
>  		if (!adjust_pool_surplus(h, nodes_allowed, -1))
>  			break;
> @@ -2421,16 +2442,19 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
>  			nodes_allowed = &node_states[N_MEMORY];
>  		}
>  	} else if (nodes_allowed) {
> +		/* Node specific request */
> +		init_nodemask_of_node(nodes_allowed, nid);
> +	} else {
>  		/*
> -		 * per node hstate attribute: adjust count to global,
> -		 * but restrict alloc/free to the specified node.
> +		 * Node specific request, but we could not allocate the few
> +		 * words required for a node mask.  We are unlikely to hit
> +		 * this condition.  Since we can not pass down the appropriate
> +		 * node mask, just return ENOMEM.
>  		 */
> -		count += h->nr_huge_pages - h->nr_huge_pages_node[nid];
> -		init_nodemask_of_node(nodes_allowed, nid);
> -	} else
> -		nodes_allowed = &node_states[N_MEMORY];
> +		return -ENOMEM;
> +	}
>  
> -	err = set_max_huge_pages(h, count, nodes_allowed);
> +	err = set_max_huge_pages(h, count, nid, nodes_allowed);
>  	if (err)
>  		goto out;
>  
> -- 
> 2.17.2
> 

-- 
Oscar Salvador
SUSE L3
