Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDAAC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E3B204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564733067;
	bh=wvf0PiugaCURGdxEwCafgHMn3ZBYyBaQT2iMFPxYXYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y00owavtm6C34Iyw6o/7uf1ExRjYBKsru1I8YVHfC+hTREHtUqlaHA5u5LMXbMx97
	 SiRer36Et0NS3coWjmEhj9XuoDh5ZkG8452em0gFx50IOy/lMSBBR0LkQmfuhRurbO
	 QGwcL2Xi+3x9gYZBSoyqMcqI0BcIwO7pbiu3ptVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403807AbfHBIE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 04:04:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:60822 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726974AbfHBIE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 04:04:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C636EAE35;
        Fri,  2 Aug 2019 08:04:24 +0000 (UTC)
Date:   Fri, 2 Aug 2019 10:04:22 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: switch to rcu protection in
 drain_all_stock()
Message-ID: <20190802080422.GA6461@dhcp22.suse.cz>
References: <20190801233513.137917-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801233513.137917-1-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01-08-19 16:35:13, Roman Gushchin wrote:
> Commit 72f0184c8a00 ("mm, memcg: remove hotplug locking from try_charge")
> introduced css_tryget()/css_put() calls in drain_all_stock(),
> which are supposed to protect the target memory cgroup from being
> released during the mem_cgroup_is_descendant() call.
> 
> However, it's not completely safe. In theory, memcg can go away
> between reading stock->cached pointer and calling css_tryget().

I have to remember how is this whole thing supposed to work, it's been
some time since I've looked into that.

> So, let's read the stock->cached pointer and evaluate the memory
> cgroup inside a rcu read section, and get rid of
> css_tryget()/css_put() calls.

Could you be more specific why does RCU help here?

> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Michal Hocko <mhocko@suse.com>
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
