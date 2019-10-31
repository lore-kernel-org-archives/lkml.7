Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A65CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 07:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0128420862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 07:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572507551;
	bh=KQKf5adc1/vNVg1bPYs9bZmVvF0VIjw98i5+m2UnPDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oD5AfYPUnru4vnRZJqjUkr+My48sQOc8nUVEvtX6sbq/ul3dmBTJg/ZkIpxdVzzhJ
	 NtiSM4AuZE0ONb0I2eVPvxaUuamYoEV30lzu/EdXjl6R8ePNu92CvQ3Rw5u8+Uk4aQ
	 mpm4s2ZoC4aZ+uGxJfx8CYlnguI02ZbnrMGyZSEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfJaHjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 03:39:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:48474 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726596AbfJaHjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 03:39:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5AE7CAC2E;
        Thu, 31 Oct 2019 07:39:06 +0000 (UTC)
Date:   Thu, 31 Oct 2019 08:39:05 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     linux-kernel@vger.kernel.org, yuqi jin <jinyuqi@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Paul Burton <paul.burton@mips.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] lib: optimize cpumask_local_spread()
Message-ID: <20191031073905.GD13102@dhcp22.suse.cz>
References: <1572501813-2125-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572501813-2125-1-git-send-email-zhangshaokun@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 31-10-19 14:03:33, Shaokun Zhang wrote:
> From: yuqi jin <jinyuqi@huawei.com>
> 
> In the multi-processor and NUMA system, A device may have many numa
> nodes belonging to multiple cpus. When we get a local numa, it is better
> to find the node closest to the local numa node to return instead of
> going to the online cpu immediately.
> 
> For example, In Huawei Kunpeng 920 system, there are 4 NUMA node(0 -3)
> in the 2-socket system(0 - 1). If the I/O device is in socket1
> and the local NUMA node is 2, we shall choose the non-local node3 in
> the same socket when cpu core in NUMA node2 is less that I/O requirements.
> If we directly pick one cpu core from all online ones, it may be in
> the another socket and it is not friendly for performance.

My previous review feedback included a request for a much better
description of the actual problem and how much of a performance gain we
are talking about along with a workoload description.

Besides that I do not think that the implementation is great either.
Relying on GFP_ATOMIC is very dubious. Is there any specific reason why
the data structure cannot pre reallocated? The comment for
cpumask_local_spread says that this is not the most efficient function
so users should better be prepared to not call it from hot paths AFAIU.
That would imply that an internal locking should be acceptable as well
so a preallocated data structure could be used.

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: yuqi jin <jinyuqi@huawei.com>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
> Changes from RFC:
>      Address Michal Hocko's comment: Use GFP_ATOMIC instead of GFP_KERNEL
> 
>  lib/cpumask.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 65 insertions(+), 11 deletions(-)
> 
> diff --git a/lib/cpumask.c b/lib/cpumask.c
> index 0cb672eb107c..c92177b0e095 100644
> --- a/lib/cpumask.c
> +++ b/lib/cpumask.c
> @@ -192,6 +192,33 @@ void __init free_bootmem_cpumask_var(cpumask_var_t mask)
>  }
>  #endif
>  
> +static void calc_node_distance(int *node_dist, int node)
> +{
> +	int i;
> +
> +	for (i = 0; i < nr_node_ids; i++)
> +		node_dist[i] = node_distance(node, i);
> +}
> +
> +static int find_nearest_node(int *node_dist, bool *used_flag)
> +{
> +	int i, min_dist = node_dist[0], node_id = -1;
> +
> +	for (i = 0; i < nr_node_ids; i++)
> +		if (used_flag[i] == 0) {
> +			min_dist = node_dist[i];
> +			node_id = i;
> +			break;
> +		}
> +	for (i = 0; i < nr_node_ids; i++)
> +		if (node_dist[i] < min_dist && used_flag[i] == 0) {
> +			min_dist = node_dist[i];
> +			node_id = i;
> +		}
> +
> +	return node_id;
> +}
> +
>  /**
>   * cpumask_local_spread - select the i'th cpu with local numa cpu's first
>   * @i: index number
> @@ -205,7 +232,8 @@ void __init free_bootmem_cpumask_var(cpumask_var_t mask)
>   */
>  unsigned int cpumask_local_spread(unsigned int i, int node)
>  {
> -	int cpu;
> +	int cpu, j, id, *node_dist;
> +	bool *used_flag;
>  
>  	/* Wrap: we always want a cpu. */
>  	i %= num_online_cpus();
> @@ -215,19 +243,45 @@ unsigned int cpumask_local_spread(unsigned int i, int node)
>  			if (i-- == 0)
>  				return cpu;
>  	} else {
> -		/* NUMA first. */
> -		for_each_cpu_and(cpu, cpumask_of_node(node), cpu_online_mask)
> -			if (i-- == 0)
> -				return cpu;
> +		node_dist = kmalloc_array(nr_node_ids, sizeof(int), GFP_ATOMIC);
> +		if (!node_dist)
> +			for_each_cpu(cpu, cpu_online_mask)
> +				if (i-- == 0)
> +					return cpu;
>  
> -		for_each_cpu(cpu, cpu_online_mask) {
> -			/* Skip NUMA nodes, done above. */
> -			if (cpumask_test_cpu(cpu, cpumask_of_node(node)))
> -				continue;
> +		used_flag = kmalloc_array(nr_node_ids, sizeof(bool), GFP_ATOMIC);
> +		if (!used_flag)
> +			for_each_cpu(cpu, cpu_online_mask)
> +				if (i-- == 0) {
> +					kfree(node_dist);
> +					return cpu;
> +				}
> +		memset(used_flag, 0, nr_node_ids * sizeof(bool));
>  
> -			if (i-- == 0)
> -				return cpu;
> +		calc_node_distance(node_dist, node);
> +		for (j = 0; j < nr_node_ids; j++) {
> +			id = find_nearest_node(node_dist, used_flag);
> +			if (id < 0)
> +				break;
> +			for_each_cpu_and(cpu,
> +				cpumask_of_node(id), cpu_online_mask)
> +				if (i-- == 0) {
> +					kfree(node_dist);
> +					kfree(used_flag);
> +					return cpu;
> +				}
> +			used_flag[id] = 1;
>  		}
> +
> +		for_each_cpu(cpu, cpu_online_mask)
> +			if (i-- == 0) {
> +				kfree(node_dist);
> +				kfree(used_flag);
> +				return cpu;
> +			}
> +
> +		kfree(node_dist);
> +		kfree(used_flag);
>  	}
>  	BUG();
>  }
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
