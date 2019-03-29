Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D02C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 05:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DFD220700
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 05:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbfC2FXC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 01:23:02 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:41647 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfC2FXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 01:23:01 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x2T5MY9A021796
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 29 Mar 2019 14:22:34 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x2T5MYk2002617;
        Fri, 29 Mar 2019 14:22:34 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x2T5MYgr026380;
        Fri, 29 Mar 2019 14:22:34 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.148] [10.38.151.148]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-3804741; Fri, 29 Mar 2019 14:20:57 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC20GP.gisp.nec.co.jp ([10.38.151.148]) with mapi id 14.03.0319.002; Fri,
 29 Mar 2019 14:20:56 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        "David Rientjes" <rientjes@google.com>, Alex Ghiti <alex@ghiti.fr>,
        Jing Xiangfeng <jingxiangfeng@huawei.com>
Subject: Re: [PATCH REBASED] hugetlbfs: fix potential over/underflow setting
 node specific nr_hugepages
Thread-Topic: [PATCH REBASED] hugetlbfs: fix potential over/underflow
 setting node specific nr_hugepages
Thread-Index: AQHU5bJpwT7PIMyllUOstwX/Np6niKYhfBmA
Date:   Fri, 29 Mar 2019 05:20:56 +0000
Message-ID: <20190329052055.GA32733@hori.linux.bs1.fc.nec.co.jp>
References: <20190328220533.19884-1-mike.kravetz@oracle.com>
In-Reply-To: <20190328220533.19884-1-mike.kravetz@oracle.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.148]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <100B784E0786CF49863E2D1C40235DF7@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 03:05:33PM -0700, Mike Kravetz wrote:
> The number of node specific huge pages can be set via a file such as:
> /sys/devices/system/node/node1/hugepages/hugepages-2048kB/nr_hugepages
> When a node specific value is specified, the global number of huge
> pages must also be adjusted.  This adjustment is calculated as the
> specified node specific value + (global value - current node value).
> If the node specific value provided by the user is large enough, this
> calculation could overflow an unsigned long leading to a smaller
> than expected number of huge pages.
> 
> To fix, check the calculation for overflow.  If overflow is detected,
> use ULONG_MAX as the requested value.  This is inline with the user
> request to allocate as many huge pages as possible.
> 
> It was also noticed that the above calculation was done outside the
> hugetlb_lock.  Therefore, the values could be inconsistent and result
> in underflow.  To fix, the calculation is moved within the routine
> set_max_huge_pages() where the lock is held.
> 
> In addition, the code in __nr_hugepages_store_common() which tries to
> handle the case of not being able to allocate a node mask would likely
> result in incorrect behavior.  Luckily, it is very unlikely we will
> ever take this path.  If we do, simply return ENOMEM.
> 
> Reported-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Looks good to me.

Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

> ---
> This was sent upstream during 5.1 merge window, but dropped as it was
> based on an earlier version of Alex Ghiti's patch which was dropped.
> Now rebased on top of Alex Ghiti's "[PATCH v8 0/4] Fix free/allocation
> of runtime gigantic pages" series which was just added to mmotm.
> 
>  mm/hugetlb.c | 41 ++++++++++++++++++++++++++++++++++-------
>  1 file changed, 34 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f3e84c1bef11..f79ae4e42159 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2287,13 +2287,33 @@ static int adjust_pool_surplus(struct hstate *h, nodemask_t *nodes_allowed,
>  }
>  
>  #define persistent_huge_pages(h) (h->nr_huge_pages - h->surplus_huge_pages)
> -static int set_max_huge_pages(struct hstate *h, unsigned long count,
> +static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>  			      nodemask_t *nodes_allowed)
>  {
>  	unsigned long min_count, ret;
>  
>  	spin_lock(&hugetlb_lock);
>  
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
>  	 * Gigantic pages runtime allocation depend on the capability for large
>  	 * page range allocation.
> @@ -2445,15 +2465,22 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
>  		}
>  	} else if (nodes_allowed) {
>  		/*
> -		 * per node hstate attribute: adjust count to global,
> -		 * but restrict alloc/free to the specified node.
> +		 * Node specific request.  count adjustment happens in
> +		 * set_max_huge_pages() after acquiring hugetlb_lock.
>  		 */
> -		count += h->nr_huge_pages - h->nr_huge_pages_node[nid];
>  		init_nodemask_of_node(nodes_allowed, nid);
> -	} else
> -		nodes_allowed = &node_states[N_MEMORY];
> +	} else {
> +		/*
> +		 * Node specific request, but we could not allocate the few
> +		 * words required for a node mask.  We are unlikely to hit
> +		 * this condition.  Since we can not pass down the appropriate
> +		 * node mask, just return ENOMEM.
> +		 */
> +		err = -ENOMEM;
> +		goto out;
> +	}
>  
> -	err = set_max_huge_pages(h, count, nodes_allowed);
> +	err = set_max_huge_pages(h, count, nid, nodes_allowed);
>  
>  out:
>  	if (nodes_allowed != &node_states[N_MEMORY])
> -- 
> 2.20.1
> 
> 
