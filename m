Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD764C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C9220693
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbfDCHwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:52:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46696 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfDCHwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:52:41 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 83F573DE;
        Wed,  3 Apr 2019 07:52:40 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A9F1F1001DDD;
        Wed,  3 Apr 2019 07:52:39 +0000 (UTC)
Date:   Wed, 3 Apr 2019 15:52:36 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        n-horiguchi@ah.jp.nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb: Get rid of NODEMASK_ALLOC
Message-ID: <20190403075236.GB31828@MiWiFi-R3L-srv>
References: <20190402133415.21983-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402133415.21983-1-osalvador@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 03 Apr 2019 07:52:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/19 at 03:34pm, Oscar Salvador wrote:
> NODEMASK_ALLOC is used to allocate a nodemask bitmap, ant it does it by
                                                         ~ and
> first determining whether it should be allocated in the stack or dinamically
                                                              dynamically^^
> depending on NODES_SHIFT.
> Right now, it goes the dynamic path whenever the nodemask_t is above 32
> bytes.
> 
> Although we could bump it to a reasonable value, the largest a nodemask_t
> can get is 128 bytes, so since __nr_hugepages_store_common is called from
> a rather shore stack we can just get rid of the NODEMASK_ALLOC call here.
> 
> This reduces some code churn and complexity.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  mm/hugetlb.c | 36 +++++++++++-------------------------
>  1 file changed, 11 insertions(+), 25 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f79ae4e42159..9cb2f91af897 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2447,44 +2447,30 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
>  					   unsigned long count, size_t len)
>  {
>  	int err;
> -	NODEMASK_ALLOC(nodemask_t, nodes_allowed, GFP_KERNEL | __GFP_NORETRY);
> +	nodemask_t nodes_allowed, *n_mask;
>  
> -	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported()) {
> -		err = -EINVAL;
> -		goto out;
> -	}
> +	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> +		return -EINVAL;
>  
>  	if (nid == NUMA_NO_NODE) {
>  		/*
>  		 * global hstate attribute
>  		 */
>  		if (!(obey_mempolicy &&
> -				init_nodemask_of_mempolicy(nodes_allowed))) {
> -			NODEMASK_FREE(nodes_allowed);
> -			nodes_allowed = &node_states[N_MEMORY];
> -		}
> -	} else if (nodes_allowed) {
> +				init_nodemask_of_mempolicy(&nodes_allowed)))
> +			n_mask = &node_states[N_MEMORY];
> +		else
> +			n_mask = &nodes_allowed;
> +	} else {
>  		/*
>  		 * Node specific request.  count adjustment happens in
>  		 * set_max_huge_pages() after acquiring hugetlb_lock.
>  		 */
> -		init_nodemask_of_node(nodes_allowed, nid);
> -	} else {
> -		/*
> -		 * Node specific request, but we could not allocate the few
> -		 * words required for a node mask.  We are unlikely to hit
> -		 * this condition.  Since we can not pass down the appropriate
> -		 * node mask, just return ENOMEM.
> -		 */
> -		err = -ENOMEM;
> -		goto out;
> +		init_nodemask_of_node(&nodes_allowed, nid);
> +		n_mask = &nodes_allowed;
>  	}
>  
> -	err = set_max_huge_pages(h, count, nid, nodes_allowed);
> -
> -out:
> -	if (nodes_allowed != &node_states[N_MEMORY])
> -		NODEMASK_FREE(nodes_allowed);
> +	err = set_max_huge_pages(h, count, nid, n_mask);
>  
>  	return err ? err : len;
>  }
> -- 
> 2.13.7
> 
