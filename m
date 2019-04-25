Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF258C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD45217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556174941;
	bh=MFo2rs2Ksm6iIGTkbw6Qnp6OfwD7vUc2eJoOI9F2Diw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nr5/8Qz+tW8puXKoCLV31t7uFk6cyLiRefWTFcxMpK76VTuepDoxPRZGGFm0DahQr
	 ynM4W841vv61phFN2cR6QD0CaJzhTpSDZMHAzmZngxaUF7+NP4cdm7x8AhZyXQHXtd
	 08miIpscbHuGH56pHqgnz1il3bAIsdi5Ta4EtyVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388049AbfDYGtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 02:49:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:57804 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725970AbfDYGtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 02:49:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0BE0DABF4;
        Thu, 25 Apr 2019 06:48:59 +0000 (UTC)
Date:   Thu, 25 Apr 2019 08:48:58 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] memcg: refill_stock for kmem uncharging too
Message-ID: <20190425064858.GL12751@dhcp22.suse.cz>
References: <20190423154405.259178-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423154405.259178-1-shakeelb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 23-04-19 08:44:05, Shakeel Butt wrote:
> The commit 475d0487a2ad ("mm: memcontrol: use per-cpu stocks for socket
> memory uncharging") added refill_stock() for skmem uncharging path to
> optimize workloads having high network traffic. Do the same for the kmem
> uncharging as well. Though we can bypass the refill for the offlined
> memcgs but it may impact the performance of network traffic for the
> sockets used by other cgroups.

While the change makes sense, I would really like to see what kind of
effect on performance does it really have. Do you have any specific
workload that benefits from it?

Thanks!

> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
> Changelog since v1:
> - No need to bypass offline memcgs in the refill.
> 
>  mm/memcontrol.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 2535e54e7989..2713b45ec3f0 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2768,17 +2768,13 @@ void __memcg_kmem_uncharge(struct page *page, int order)
>  	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
>  		page_counter_uncharge(&memcg->kmem, nr_pages);
>  
> -	page_counter_uncharge(&memcg->memory, nr_pages);
> -	if (do_memsw_account())
> -		page_counter_uncharge(&memcg->memsw, nr_pages);
> -
>  	page->mem_cgroup = NULL;
>  
>  	/* slab pages do not have PageKmemcg flag set */
>  	if (PageKmemcg(page))
>  		__ClearPageKmemcg(page);
>  
> -	css_put_many(&memcg->css, nr_pages);
> +	refill_stock(memcg, nr_pages);
>  }
>  #endif /* CONFIG_MEMCG_KMEM */
>  
> -- 
> 2.21.0.593.g511ec345e18-goog
> 

-- 
Michal Hocko
SUSE Labs
