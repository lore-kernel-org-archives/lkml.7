Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAA0C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 10:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7ED20859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 10:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfE0KQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 06:16:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33584 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725943AbfE0KQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 06:16:57 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4RADOiS104757
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 06:16:56 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2srcf3wfm3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 06:16:56 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 27 May 2019 11:16:55 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 27 May 2019 11:16:48 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4RAFWrv38928602
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 May 2019 10:15:33 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFDC9B2065;
        Mon, 27 May 2019 10:15:32 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8833B205F;
        Mon, 27 May 2019 10:15:32 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.199.73])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 27 May 2019 10:15:32 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 482C916C3573; Mon, 27 May 2019 03:15:36 -0700 (PDT)
Date:   Mon, 27 May 2019 03:15:36 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Rik van Riel <riel@redhat.com>, Jan Kara <jack@suse.cz>,
        Dave Jiang <dave.jiang@intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH -mm] mm, swap: Simplify total_swapcache_pages() with
 get_swap_device()
Reply-To: paulmck@linux.ibm.com
References: <20190527082714.12151-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190527082714.12151-1-ying.huang@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19052710-2213-0000-0000-000003965E56
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011171; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01209261; UDB=6.00635237; IPR=6.00990287;
 MB=3.00027069; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-27 10:16:53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052710-2214-0000-0000-00005E99536B
Message-Id: <20190527101536.GI28207@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-27_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905270073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 04:27:14PM +0800, Huang, Ying wrote:
> From: Huang Ying <ying.huang@intel.com>
> 
> total_swapcache_pages() may race with swapper_spaces[] allocation and
> freeing.  Previously, this is protected with a swapper_spaces[]
> specific RCU mechanism.  To simplify the logic/code complexity, it is
> replaced with get/put_swap_device().  The code line number is reduced
> too.  Although not so important, the swapoff() performance improves
> too because one synchronize_rcu() call during swapoff() is deleted.

I am guessing that total_swapcache_pages() is not used on any
fastpaths, but must defer to others on this.  Of course, if the
performance/scalability of total_swapcache_pages() is important,
benchmarking is needed.

But where do I find get_swap_device() and put_swap_device()?  I do not
see them in current mainline.

							Thanx, Paul

> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Jérôme Glisse <jglisse@redhat.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Rik van Riel <riel@redhat.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
> Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
> ---
>  mm/swap_state.c | 28 ++++++++++------------------
>  1 file changed, 10 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index f509cdaa81b1..b84c58b572ca 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -73,23 +73,19 @@ unsigned long total_swapcache_pages(void)
>  	unsigned int i, j, nr;
>  	unsigned long ret = 0;
>  	struct address_space *spaces;
> +	struct swap_info_struct *si;
> 
> -	rcu_read_lock();
>  	for (i = 0; i < MAX_SWAPFILES; i++) {
> -		/*
> -		 * The corresponding entries in nr_swapper_spaces and
> -		 * swapper_spaces will be reused only after at least
> -		 * one grace period.  So it is impossible for them
> -		 * belongs to different usage.
> -		 */
> -		nr = nr_swapper_spaces[i];
> -		spaces = rcu_dereference(swapper_spaces[i]);
> -		if (!nr || !spaces)
> +		/* Prevent swapoff to free swapper_spaces */
> +		si = get_swap_device(swp_entry(i, 1));
> +		if (!si)
>  			continue;
> +		nr = nr_swapper_spaces[i];
> +		spaces = swapper_spaces[i];
>  		for (j = 0; j < nr; j++)
>  			ret += spaces[j].nrpages;
> +		put_swap_device(si);
>  	}
> -	rcu_read_unlock();
>  	return ret;
>  }
> 
> @@ -611,20 +607,16 @@ int init_swap_address_space(unsigned int type, unsigned long nr_pages)
>  		mapping_set_no_writeback_tags(space);
>  	}
>  	nr_swapper_spaces[type] = nr;
> -	rcu_assign_pointer(swapper_spaces[type], spaces);
> +	swapper_spaces[type] = spaces;
> 
>  	return 0;
>  }
> 
>  void exit_swap_address_space(unsigned int type)
>  {
> -	struct address_space *spaces;
> -
> -	spaces = swapper_spaces[type];
> +	kvfree(swapper_spaces[type]);
>  	nr_swapper_spaces[type] = 0;
> -	rcu_assign_pointer(swapper_spaces[type], NULL);
> -	synchronize_rcu();
> -	kvfree(spaces);
> +	swapper_spaces[type] = NULL;
>  }
> 
>  static inline void swap_ra_clamp_pfn(struct vm_area_struct *vma,
> -- 
> 2.20.1
> 

