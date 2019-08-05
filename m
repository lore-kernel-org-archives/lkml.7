Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC35C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9F320856
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565003501;
	bh=C2Ctd1MvdXa5DGWc55IrA9FVrPvuDYnXj8n2EiSAHhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cb9fBBJgLu3zjRNbMhdXMzHyAjT8PtkoGMCG88OkYFDqWyPPV2p3FZj8jtCsKRnzc
	 fcPAvwShxiZyz7GbsFRN5lAKP0bftEBjdRJmrfh7aDkPeGOv19tuEE2R9w5H8IUblp
	 HcoqWjfzyiAxi4+OhLJbTtSroSDHPeNs1D+Guis0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbfHELLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 07:11:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:52442 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727158AbfHELLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 07:11:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 735B0AEF3;
        Mon,  5 Aug 2019 11:11:38 +0000 (UTC)
Date:   Mon, 5 Aug 2019 13:11:35 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH v2] mm: memcontrol: switch to rcu protection in
 drain_all_stock()
Message-ID: <20190805111135.GE7597@dhcp22.suse.cz>
References: <20190802192241.3253165-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802192241.3253165-1-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 02-08-19 12:22:41, Roman Gushchin wrote:
> Commit 72f0184c8a00 ("mm, memcg: remove hotplug locking from try_charge")
> introduced css_tryget()/css_put() calls in drain_all_stock(),
> which are supposed to protect the target memory cgroup from being
> released during the mem_cgroup_is_descendant() call.
> 
> However, it's not completely safe. In theory, memcg can go away
> between reading stock->cached pointer and calling css_tryget().
> 
> This can happen if drain_all_stock() races with drain_local_stock()
> performed on the remote cpu as a result of a work, scheduled
> by the previous invocation of drain_all_stock().

Maybe I am still missing something but I do not see how 72f0184c8a00
changed the existing race. get_online_cpus doesn't prevent the same race
right? If this is the case then it would be great to clarify that. I
know that you are mostly after clarifying that css_tryget is
insufficient but the above sounds like 72f0184c8a00 has introduced a
regression.

> The race is a bit theoretical and there are few chances to trigger
> it, but the current code looks a bit confusing, so it makes sense
> to fix it anyway. The code looks like as if css_tryget() and
> css_put() are used to protect stocks drainage. It's not necessary
> because stocked pages are holding references to the cached cgroup.
> And it obviously won't work for works, scheduled on other cpus.
> 
> So, let's read the stock->cached pointer and evaluate the memory
> cgroup inside a rcu read section, and get rid of
> css_tryget()/css_put() calls.
> 
> v2: added some explanations to the commit message, no code changes
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Hillf Danton <hdanton@sina.com>

Other than that.
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 5c7b9facb0eb..d856b64426b7 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2235,21 +2235,22 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
>  	for_each_online_cpu(cpu) {
>  		struct memcg_stock_pcp *stock = &per_cpu(memcg_stock, cpu);
>  		struct mem_cgroup *memcg;
> +		bool flush = false;
>  
> +		rcu_read_lock();
>  		memcg = stock->cached;
> -		if (!memcg || !stock->nr_pages || !css_tryget(&memcg->css))
> -			continue;
> -		if (!mem_cgroup_is_descendant(memcg, root_memcg)) {
> -			css_put(&memcg->css);
> -			continue;
> -		}
> -		if (!test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags)) {
> +		if (memcg && stock->nr_pages &&
> +		    mem_cgroup_is_descendant(memcg, root_memcg))
> +			flush = true;
> +		rcu_read_unlock();
> +
> +		if (flush &&
> +		    !test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags)) {
>  			if (cpu == curcpu)
>  				drain_local_stock(&stock->work);
>  			else
>  				schedule_work_on(cpu, &stock->work);
>  		}
> -		css_put(&memcg->css);
>  	}
>  	put_cpu();
>  	mutex_unlock(&percpu_charge_mutex);
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
