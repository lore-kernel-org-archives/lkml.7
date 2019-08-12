Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D004C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D85A52070C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565623778;
	bh=NwnWW7s4bzNd/UDSOpbHkGwtcYHsZAFWP/l3RFoqLXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S2GmwnrVCSBwu1f8zHQxtpmqxACX5SNuwLBDpGqUwvdVwIf5sqPVyNhhubBIzTPk1
	 QxBLNTTSQytjD2038UCjkyY2UyZeN7CNP5R/IGlNrcONX9C4ZIRlnY9Xcr613pF0TS
	 ikMfJ5letoWdEYXPwM7EOUp+9c3hKlqvmLAbcjEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbfHLP3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 11:29:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:46330 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbfHLP3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 11:29:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 08:29:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,377,1559545200"; 
   d="scan'208";a="177514233"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga007.fm.intel.com with ESMTP; 12 Aug 2019 08:29:35 -0700
Date:   Mon, 12 Aug 2019 09:27:18 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH V2 2/3] genirq/affinity: Spread vectors on node according
 to nr_cpu ratio
Message-ID: <20190812152718.GA32550@localhost.localdomain>
References: <20190812095709.25623-1-ming.lei@redhat.com>
 <20190812095709.25623-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812095709.25623-3-ming.lei@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 05:57:08PM +0800, Ming Lei wrote:
> Now __irq_build_affinity_masks() spreads vectors evenly per node, and
> all vectors may not be spread in case that each numa node has different
> CPU number, then the following warning in irq_build_affinity_masks() can
> be triggered:
> 
> 	if (nr_present < numvecs)
> 		WARN_ON(nr_present + nr_others < numvecs);
> 
> Improve current spreading algorithm by assigning vectors according to
> the ratio of node's nr_cpu to nr_remaining_cpus, meantime running the
> assignment from smaller nodes to bigger nodes to guarantee that every
> active node gets allocated at least one vector, then we can avoid
> cross-node spread.
> 
> Meantime the reported warning can be fixed.
> 
> Another big goodness is that the spread approach becomes more fair if
> node has different CPU number.
> 
> For example, on the following machine:
> 	[root@ktest-01 ~]# lscpu
> 	...
> 	CPU(s):              16
> 	On-line CPU(s) list: 0-15
> 	Thread(s) per core:  1
> 	Core(s) per socket:  8
> 	Socket(s):           2
> 	NUMA node(s):        2
> 	...
> 	NUMA node0 CPU(s):   0,1,3,5-9,11,13-15
> 	NUMA node1 CPU(s):   2,4,10,12
> 
> When driver requests to allocate 8 vectors, the following spread can
> be got:
> 	irq 31, cpu list 2,4
> 	irq 32, cpu list 10,12
> 	irq 33, cpu list 0-1
> 	irq 34, cpu list 3,5
> 	irq 35, cpu list 6-7
> 	irq 36, cpu list 8-9
> 	irq 37, cpu list 11,13
> 	irq 38, cpu list 14-15
> 
> Without this patch, kernel warning is triggered on above situation, and
> allocation result was supposed to be 4 vectors for each node.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: linux-nvme@lists.infradead.org,
> Cc: Jon Derrick <jonathan.derrick@intel.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Reported-by: Jon Derrick <jonathan.derrick@intel.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  kernel/irq/affinity.c | 141 +++++++++++++++++++++++++++++++++++-------
>  1 file changed, 117 insertions(+), 24 deletions(-)
> 
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index c7cca942bd8a..927dcbe80482 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -7,6 +7,7 @@
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/cpu.h>
> +#include <linux/sort.h>
>  
>  static void irq_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
>  				unsigned int cpus_per_vec)
> @@ -94,6 +95,87 @@ static int get_nodes_in_cpumask(cpumask_var_t *node_to_cpumask,
>  	return nodes;
>  }
>  
> +struct node_nr_vectors {
> +	unsigned n;
> +
> +	union {
> +		unsigned nvectors;
> +		unsigned ncpus;
> +	};
> +};
> +
> +static int ncpus_cmp_func(const void *l, const void *r)
> +{
> +	const struct node_nr_vectors *ln = l;
> +	const struct node_nr_vectors *rn = r;
> +
> +	if (ln->ncpus < rn->ncpus)
> +		return -1;
> +	if (ln->ncpus > rn->ncpus)
> +		return 1;
> +	return 0;

You can collapse these to one line:

	return ln->ncpus - rn->ncpus;

> +}
> +
> +static void alloc_nodes_vectors(unsigned int numvecs,
> +				const cpumask_var_t *node_to_cpumask,
> +				const struct cpumask *cpu_mask,
> +				const nodemask_t nodemsk,
> +				struct cpumask *nmsk,
> +				struct node_nr_vectors *node_vectors)
> +{
> +	unsigned remaining_ncpus = 0;
> +	unsigned n;
> +
> +	for (n = 0; n < nr_node_ids; n++) {
> +		node_vectors[n].n = n;
> +		node_vectors[n].ncpus = UINT_MAX;
> +	}
> +
> +	for_each_node_mask(n, nodemsk) {
> +		unsigned ncpus;
> +
> +		cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
> +		ncpus = cpumask_weight(nmsk);
> +
> +		if (!ncpus)
> +			continue;
> +		remaining_ncpus += ncpus;
> +		node_vectors[n].ncpus = ncpus;
> +	}
> +
> +	sort(node_vectors, nr_node_ids, sizeof(node_vectors[0]),
> +	     ncpus_cmp_func, NULL);
> +
> +	/*
> +	 * Allocate vectors for each node according to the ratio of this
> +	 * node's nr_cpus to remaining un-assigned ncpus. 'numvecs' is
> +	 * bigger than number of active numa nodes. Always start the
> +	 * allocation from the node with minimized nr_cpus.
> +	 *
> +	 * This way guarantees that each active node gets allocated at
> +	 * least one vector, and the theory is simple: over-allocation
> +	 * is only done when this node is assigned by one vector, so
> +	 * other nodes will be allocated >= 1 vector, since 'numvecs' is
> +	 * bigger than number of numa nodes.
> +	 */
> +	for (n = 0; n < nr_node_ids; n++) {
> +		unsigned nvectors, ncpus;
> +
> +		if (node_vectors[n].ncpus == UINT_MAX)
> +			continue;
> +
> +		WARN_ON_ONCE(numvecs == 0);
> +
> +		ncpus = node_vectors[n].ncpus;
> +		nvectors = max_t(unsigned, 1,
> +				 numvecs * ncpus / remaining_ncpus);
> +
> +		node_vectors[n].nvectors = nvectors;
> +		remaining_ncpus -= ncpus;
> +		numvecs -= nvectors;
> +	}

This looks good to me.

> +}
> +
>  static int __irq_build_affinity_masks(unsigned int startvec,
>  				      unsigned int numvecs,
>  				      unsigned int firstvec,
> @@ -102,10 +184,11 @@ static int __irq_build_affinity_masks(unsigned int startvec,
>  				      struct cpumask *nmsk,
>  				      struct irq_affinity_desc *masks)
>  {
> -	unsigned int n, nodes, cpus_per_vec, extra_vecs, done = 0;
> +	unsigned int i, n, nodes, cpus_per_vec, extra_vecs, done = 0;
>  	unsigned int last_affv = firstvec + numvecs;
>  	unsigned int curvec = startvec;
>  	nodemask_t nodemsk = NODE_MASK_NONE;
> +	struct node_nr_vectors *node_vectors;
>  
>  	if (!cpumask_weight(cpu_mask))
>  		return 0;
> @@ -126,8 +209,23 @@ static int __irq_build_affinity_masks(unsigned int startvec,
>  		return numvecs;
>  	}
>  
> -	for_each_node_mask(n, nodemsk) {
> -		unsigned int ncpus, v, vecs_to_assign, vecs_per_node;
> +	node_vectors = kcalloc(nr_node_ids,
> +			       sizeof(struct node_nr_vectors),
> +			       GFP_KERNEL);
> +	if (!node_vectors)
> +		return 0;

I think we need to get this -ENOMEM condition back to the caller and
have that condition handled.

> @@ -165,13 +250,21 @@ static int __irq_build_affinity_masks(unsigned int startvec,
>  			}
>  			irq_spread_init_one(&masks[curvec].mask, nmsk,
>  						cpus_per_vec);
> +			/*
> +			 * alloc_nodes_vectors() is intelligent enough to
> +			 * allocate vectors on all nodes, so wrapping
> +			 * shouldn't be triggered usually. However, if it
> +			 * happens when allocated vectors is bigger than
> +			 * node's CPU number becasue of round down, wraps
> +			 * to the first vector allocated for this node, then
> +			 * cross-node spread can be avoided.
> +			 */
> +			if (curvec >= last_affv)
> +				curvec -= v;

Could you explain again how this could happen? The round-down should mean we
apply a vector to more CPUs so that the number of vectors applied to a
node wthin the loop should never require wrapping to hit all those CPUs.
And if that's true, the check should probably be a warn because it
should never happen.

In any case, if you can hit that condition where curvec >= last_affv,
the assignment to masks[curvec] just above may be out-of-bounds.

>  		}
> -
>  		done += v;
> -		if (curvec >= last_affv)
> -			curvec = firstvec;
> -		--nodes;
>  	}
> +	kfree(node_vectors);
>  	return done < numvecs ? done : numvecs;
>  }
