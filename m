Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9886C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43FC205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565782366;
	bh=MtjEzRWbPiG6EVM0rtPP4w5o57pmiryRcKW53PcseX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jHtG1fnyku8Ir+xNYqEfqD0LRflPYLBv570M4o/68LqlOvWayd+Mr1mWt+9Di3K+4
	 sCTdVfmaoQDNcr2LEjuNrS6/T0JDcYJ2Mlb6qVCYfVDDzjTAnMelyKVNwWafpKz5s2
	 yt5r8X9jM6c3gTj77FDqN6gpvtNhVyWWjUto43aU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbfHNLcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 07:32:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:40342 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727617AbfHNLcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 07:32:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6F9C7AEA5;
        Wed, 14 Aug 2019 11:32:43 +0000 (UTC)
Date:   Wed, 14 Aug 2019 13:32:42 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: memcontrol: flush percpu slab vmstats on kmem
 offlining
Message-ID: <20190814113242.GV17933@dhcp22.suse.cz>
References: <20190812222911.2364802-1-guro@fb.com>
 <20190812222911.2364802-3-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812222911.2364802-3-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 12-08-19 15:29:11, Roman Gushchin wrote:
> I've noticed that the "slab" value in memory.stat is sometimes 0,
> even if some children memory cgroups have a non-zero "slab" value.
> The following investigation showed that this is the result
> of the kmem_cache reparenting in combination with the per-cpu
> batching of slab vmstats.
> 
> At the offlining some vmstat value may leave in the percpu cache,
> not being propagated upwards by the cgroup hierarchy. It means
> that stats on ancestor levels are lower than actual. Later when
> slab pages are released, the precise number of pages is substracted
> on the parent level, making the value negative. We don't show negative
> values, 0 is printed instead.

So the difference with other counters is that slab ones are reparented
and that's why we have treat them specially? I guess that is what the
comment in the code suggest but being explicit in the changelog would be
nice.

[...]
> -static void memcg_flush_percpu_vmstats(struct mem_cgroup *memcg)
> +static void memcg_flush_percpu_vmstats(struct mem_cgroup *memcg, bool slab_only)
>  {
>  	unsigned long stat[MEMCG_NR_STAT];
>  	struct mem_cgroup *mi;
>  	int node, cpu, i;
> +	int min_idx, max_idx;
>  
> -	for (i = 0; i < MEMCG_NR_STAT; i++)
> +	if (slab_only) {
> +		min_idx = NR_SLAB_RECLAIMABLE;
> +		max_idx = NR_SLAB_UNRECLAIMABLE;
> +	} else {
> +		min_idx = 0;
> +		max_idx = MEMCG_NR_STAT;
> +	}

This is just ugly has hell! I really detest how this implicitly makes
counters value very special without any note in the node_stat_item
definition. Is it such a big deal to have a per counter flush and do
the loop over all counters resp. specific counters around it so much
worse? This should be really a slow path to safe few instructions or
cache misses, no?
-- 
Michal Hocko
SUSE Labs
