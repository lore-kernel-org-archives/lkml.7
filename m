Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BDDC41514
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 21:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF812189F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 21:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565299310;
	bh=LgjCrDBOFNjZIGmWfH/ct2Mm4aiB1Es4buMJn30aQvY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=GjGizyS+ESMDxxhbo7jEdbmjjqL7BgLHihfTpHCj8jQmRu2lZoOcb8WZPvJHIkIPF
	 Z5R/AjgmPxJIqdWWeQHyRz9UWxUuh0ADBBpCgK1Us/sTM11Ginj9nejlkhrcnb8ctn
	 BbpaZQgRCm6p+od1vX+LaY164XictDuZV5I811RY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390326AbfHHVVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 17:21:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729780AbfHHVVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 17:21:48 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BB582166E;
        Thu,  8 Aug 2019 21:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565299307;
        bh=LgjCrDBOFNjZIGmWfH/ct2Mm4aiB1Es4buMJn30aQvY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2ImeMMybV064Z0DxdUeprm+KuyhJO20DaFsupoAvVIlLSqheXfGcf1uuRXh14Sd2p
         ga56EsJLL90V5ZbfzYXSkTVMRDVOsVZzV0sYKuee53I+nxBGGQiS+dMEWj0I6g58kM
         FTn+JRSENWS2+lhaf+crG46ih3HBKYmNxyVr3cVg=
Date:   Thu, 8 Aug 2019 14:21:46 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH] mm: memcontrol: flush slab vmstats on kmem offlining
Message-Id: <20190808142146.a328cd673c66d5fdbca26f79@linux-foundation.org>
In-Reply-To: <20190808203604.3413318-1-guro@fb.com>
References: <20190808203604.3413318-1-guro@fb.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2019 13:36:04 -0700 Roman Gushchin <guro@fb.com> wrote:

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
> 
> To fix this issue, let's flush percpu slab memcg and lruvec stats
> on memcg offlining. This guarantees that numbers on all ancestor
> levels are accurate and match the actual number of outstanding
> slab pages.
> 

Looks expensive.  How frequently can these functions be called?

> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3412,6 +3412,50 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
>  	return 0;
>  }
>  
> +static void memcg_flush_slab_node_stats(struct mem_cgroup *memcg, int node)
> +{
> +	struct mem_cgroup_per_node *pn = memcg->nodeinfo[node];
> +	struct mem_cgroup_per_node *pi;
> +	unsigned long recl = 0, unrecl = 0;
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		recl += raw_cpu_read(
> +			pn->lruvec_stat_cpu->count[NR_SLAB_RECLAIMABLE]);
> +		unrecl += raw_cpu_read(
> +			pn->lruvec_stat_cpu->count[NR_SLAB_UNRECLAIMABLE]);
> +	}
> +
> +	for (pi = pn; pi; pi = parent_nodeinfo(pi, node)) {
> +		atomic_long_add(recl,
> +				&pi->lruvec_stat[NR_SLAB_RECLAIMABLE]);
> +		atomic_long_add(unrecl,
> +				&pi->lruvec_stat[NR_SLAB_UNRECLAIMABLE]);
> +	}
> +}
> +
> +static void memcg_flush_slab_vmstats(struct mem_cgroup *memcg)
> +{
> +	struct mem_cgroup *mi;
> +	unsigned long recl = 0, unrecl = 0;
> +	int node, cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		recl += raw_cpu_read(
> +			memcg->vmstats_percpu->stat[NR_SLAB_RECLAIMABLE]);
> +		unrecl += raw_cpu_read(
> +			memcg->vmstats_percpu->stat[NR_SLAB_UNRECLAIMABLE]);
> +	}
> +
> +	for (mi = memcg; mi; mi = parent_mem_cgroup(mi)) {
> +		atomic_long_add(recl, &mi->vmstats[NR_SLAB_RECLAIMABLE]);
> +		atomic_long_add(unrecl, &mi->vmstats[NR_SLAB_UNRECLAIMABLE]);
> +	}
> +
> +	for_each_node(node)
> +		memcg_flush_slab_node_stats(memcg, node);

This loops across all possible CPUs once for each possible node.  Ouch.

Implementing hotplug handlers in here (which is surprisingly simple)
brings this down to num_online_nodes * num_online_cpus which is, I
think, potentially vastly better.

