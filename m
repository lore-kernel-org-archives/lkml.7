Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EB4C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 16:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27FC520644
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 16:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566489912;
	bh=gpJ14bcnbxVJuiRnwlAbDSsYWgu2sS2XwT8/pjzYSwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ilg7nJ0lB3+T4c9GU4ZCIfY6fAUfZPXvJV7gWjxnrrc1oiAVhI+7AG/TKUOduw44+
	 WpucPzSKylfW4DWPm/mBlYWd4mHWs4vYwpjPshJEe9DkNWycLyNfmxEUiBASkzVuXw
	 HHC6BhL0dxgC3G5bKlomwHLTsssPnmn4jz2VToK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389705AbfHVQFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 12:05:11 -0400
Received: from mga02.intel.com ([134.134.136.20]:22511 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729718AbfHVQFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 12:05:10 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 09:05:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,417,1559545200"; 
   d="scan'208";a="181431201"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga003.jf.intel.com with ESMTP; 22 Aug 2019 09:05:09 -0700
Date:   Thu, 22 Aug 2019 10:03:12 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH V6 1/2] genirq/affinity: Improve
 __irq_build_affinity_masks()
Message-ID: <20190822160311.GA15264@localhost.localdomain>
References: <20190819124937.9948-1-ming.lei@redhat.com>
 <20190819124937.9948-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819124937.9948-2-ming.lei@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 05:49:36AM -0700, Ming Lei wrote:
> One invariant of __irq_build_affinity_masks() is that all CPUs in the
> specified masks( cpu_mask AND node_to_cpumask for each node) should be
> covered during the spread. Even though all requested vectors have been
> reached, we still need to spread vectors among remained CPUs. The similar
> policy has been taken in case of 'numvecs <= nodes' already:
> 
> So remove the following check inside the loop:
> 
> 	if (done >= numvecs)
> 		break;
> 
> Meantime assign at least 1 vector for remained nodes if 'numvecs' vectors
> have been handled already.
> 
> Also, if the specified cpumask for one numa node is empty, simply not
> spread vectors on this node.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: linux-nvme@lists.infradead.org,
> Cc: Jon Derrick <jonathan.derrick@intel.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good to me

Reviewed-by: Keith Busch <kbusch@kernel.org>
 
> ---
>  kernel/irq/affinity.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index 6fef48033f96..c7cca942bd8a 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -129,14 +129,26 @@ static int __irq_build_affinity_masks(unsigned int startvec,
>  	for_each_node_mask(n, nodemsk) {
>  		unsigned int ncpus, v, vecs_to_assign, vecs_per_node;
>  
> -		/* Spread the vectors per node */
> -		vecs_per_node = (numvecs - (curvec - firstvec)) / nodes;
> -
>  		/* Get the cpus on this node which are in the mask */
>  		cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
> -
> -		/* Calculate the number of cpus per vector */
>  		ncpus = cpumask_weight(nmsk);
> +		if (!ncpus)
> +			continue;
> +
> +		/*
> +		 * Calculate the number of cpus per vector
> +		 *
> +		 * Spread the vectors evenly per node. If the requested
> +		 * vector number has been reached, simply allocate one
> +		 * vector for each remaining node so that all nodes can
> +		 * be covered
> +		 */
> +		if (numvecs > done)
> +			vecs_per_node = max_t(unsigned,
> +					(numvecs - done) / nodes, 1);
> +		else
> +			vecs_per_node = 1;
> +
>  		vecs_to_assign = min(vecs_per_node, ncpus);
>  
>  		/* Account for rounding errors */
> @@ -156,13 +168,11 @@ static int __irq_build_affinity_masks(unsigned int startvec,
>  		}
>  
>  		done += v;
> -		if (done >= numvecs)
> -			break;
>  		if (curvec >= last_affv)
>  			curvec = firstvec;
>  		--nodes;
>  	}
> -	return done;
> +	return done < numvecs ? done : numvecs;
>  }
>  
>  /*
> -- 
