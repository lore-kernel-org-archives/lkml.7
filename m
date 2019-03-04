Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50DFC10F03
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 06:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B542521019
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 06:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfCDGD4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 01:03:56 -0500
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:46673 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfCDGD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 01:03:56 -0500
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x2461M5a024438
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 4 Mar 2019 15:01:22 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x2461MuS007092;
        Mon, 4 Mar 2019 15:01:22 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x245tpSt008051;
        Mon, 4 Mar 2019 15:01:22 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.151] [10.38.151.151]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-2987327; Mon, 4 Mar 2019 15:00:25 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC23GP.gisp.nec.co.jp ([10.38.151.151]) with mapi id 14.03.0319.002; Mon, 4
 Mar 2019 15:00:23 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     David Rientjes <rientjes@google.com>,
        Jing Xiangfeng <jingxiangfeng@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "hughd@google.com" <hughd@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] mm/hugetlb: Fix unsigned overflow in
 __nr_hugepages_store_common()
Thread-Topic: [PATCH v4] mm/hugetlb: Fix unsigned overflow in
 __nr_hugepages_store_common()
Thread-Index: AQHUzKNmJ08QFadITkadXECqBzMSPaXvQTOAgADisACAABkvAIAAEDUAgAB2wwCAAEK9AIAA3REAgAiLHgA=
Date:   Mon, 4 Mar 2019 06:00:23 +0000
Message-ID: <20190304060024.GA26610@hori.linux.bs1.fc.nec.co.jp>
References: <1550885529-125561-1-git-send-email-jingxiangfeng@huawei.com>
 <388cbbf5-7086-1d04-4c49-049021504b9d@oracle.com>
 <alpine.DEB.2.21.1902241913000.34632@chino.kir.corp.google.com>
 <8c167be7-06fa-a8c0-8ee7-0bfad41eaba2@oracle.com>
 <13400ee2-3d3b-e5d6-2d78-a770820417de@oracle.com>
 <alpine.DEB.2.21.1902251116180.167839@chino.kir.corp.google.com>
 <5C74A2DA.1030304@huawei.com>
 <alpine.DEB.2.21.1902252220310.40851@chino.kir.corp.google.com>
 <e2bded2f-40ca-c308-5525-0a21777ed221@oracle.com>
In-Reply-To: <e2bded2f-40ca-c308-5525-0a21777ed221@oracle.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.96]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <DF7354B168D1794AA4B3582797AC467F@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 11:32:24AM -0800, Mike Kravetz wrote:
> On 2/25/19 10:21 PM, David Rientjes wrote:
> > On Tue, 26 Feb 2019, Jing Xiangfeng wrote:
> >> On 2019/2/26 3:17, David Rientjes wrote:
> >>> On Mon, 25 Feb 2019, Mike Kravetz wrote:
> >>>
> >>>> Ok, what about just moving the calculation/check inside the lock as in the
> >>>> untested patch below?
> >>>>
> >>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> <snip>
> 
> >>>
> >>> Looks good; Jing, could you test that this fixes your case?
> >>
> >> Yes, I have tested this patch, it can also fix my case.
> > 
> > Great!
> > 
> > Reported-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> > Tested-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> > Acked-by: David Rientjes <rientjes@google.com>
> 
> Thanks Jing and David!
> 
> Here is the patch with an updated commit message and above tags:
> 
> From: Mike Kravetz <mike.kravetz@oracle.com>
> Date: Tue, 26 Feb 2019 10:43:24 -0800
> Subject: [PATCH] hugetlbfs: fix potential over/underflow setting node specific
> nr_hugepages
> 
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
> in underflow.  To fix, the calculation is moved to within the routine
> set_max_huge_pages() where the lock is held.
> 
> Reported-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> Tested-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> Acked-by: David Rientjes <rientjes@google.com>

Looks good to me with improved comments.
Thanks everyone.

Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

> ---
>  mm/hugetlb.c | 34 ++++++++++++++++++++++++++--------
>  1 file changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index b37e3100b7cc..a7e4223d2df5 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2274,7 +2274,7 @@ static int adjust_pool_surplus(struct hstate *h,
> nodemask_t *nodes_allowed,
>  }
> 
>  #define persistent_huge_pages(h) (h->nr_huge_pages - h->surplus_huge_pages)
> -static int set_max_huge_pages(struct hstate *h, unsigned long count,
> +static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>  						nodemask_t *nodes_allowed)
>  {
>  	unsigned long min_count, ret;
> @@ -2289,6 +2289,23 @@ static int set_max_huge_pages(struct hstate *h, unsigned
> long count,
>  		goto decrease_pool;
>  	}
> 
> +	spin_lock(&hugetlb_lock);
> +
> +	/*
> +	 * Check for a node specific request.  Adjust global count, but
> +	 * restrict alloc/free to the specified node.
> +	 */
> +	if (nid != NUMA_NO_NODE) {
> +		unsigned long old_count = count;
> +		count += h->nr_huge_pages - h->nr_huge_pages_node[nid];
> +		/*
> +		 * If user specified count causes overflow, set to
> +		 * largest possible value.
> +		 */
> +		if (count < old_count)
> +			count = ULONG_MAX;
> +	}
> +
>  	/*
>  	 * Increase the pool size
>  	 * First take pages out of surplus state.  Then make up the
> @@ -2300,7 +2317,6 @@ static int set_max_huge_pages(struct hstate *h, unsigned
> long count,
>  	 * pool might be one hugepage larger than it needs to be, but
>  	 * within all the constraints specified by the sysctls.
>  	 */
> -	spin_lock(&hugetlb_lock);
>  	while (h->surplus_huge_pages && count > persistent_huge_pages(h)) {
>  		if (!adjust_pool_surplus(h, nodes_allowed, -1))
>  			break;
> @@ -2421,16 +2437,18 @@ static ssize_t __nr_hugepages_store_common(bool
> obey_mempolicy,
>  			nodes_allowed = &node_states[N_MEMORY];
>  		}
>  	} else if (nodes_allowed) {
> +		/* Node specific request */
> +		init_nodemask_of_node(nodes_allowed, nid);
> +	} else {
>  		/*
> -		 * per node hstate attribute: adjust count to global,
> -		 * but restrict alloc/free to the specified node.
> +		 * Node specific request, but we could not allocate
> +		 * node mask.  Pass in ALL nodes, and clear nid.
>  		 */
> -		count += h->nr_huge_pages - h->nr_huge_pages_node[nid];
> -		init_nodemask_of_node(nodes_allowed, nid);
> -	} else
> +		nid = NUMA_NO_NODE;
>  		nodes_allowed = &node_states[N_MEMORY];
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
> 
