Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C63C3A59E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 03:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9D62339E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 03:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbfHVDKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 23:10:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32856 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729915AbfHVDKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 23:10:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 173943082128;
        Thu, 22 Aug 2019 03:10:00 +0000 (UTC)
Received: from ming.t460p (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A6ED15D9D3;
        Thu, 22 Aug 2019 03:09:53 +0000 (UTC)
Date:   Thu, 22 Aug 2019 11:09:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH V6 2/2] genirq/affinity: Spread vectors on node according
 to nr_cpu ratio
Message-ID: <20190822030947.GD28635@ming.t460p>
References: <20190819124937.9948-1-ming.lei@redhat.com>
 <20190819124937.9948-3-ming.lei@redhat.com>
 <alpine.DEB.2.21.1908191511440.2147@nanos.tec.linutronix.de>
 <20190819135217.GA10108@ming.t460p>
 <alpine.DEB.2.21.1908191601520.2147@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908191601520.2147@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 22 Aug 2019 03:10:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 04:02:21PM +0200, Thomas Gleixner wrote:
> On Mon, 19 Aug 2019, Ming Lei wrote:
> > On Mon, Aug 19, 2019 at 03:13:58PM +0200, Thomas Gleixner wrote:
> > > On Mon, 19 Aug 2019, Ming Lei wrote:
> > > 
> > > > Cc: Jon Derrick <jonathan.derrick@intel.com>
> > > > Cc: Jens Axboe <axboe@kernel.dk>
> > > > Reported-by: Jon Derrick <jonathan.derrick@intel.com>
> > > > Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
> > > > Reviewed-by: Keith Busch <kbusch@kernel.org>
> > > 
> > > This version is sufficiently different from the previous one, so I do not
> > > consider the reviewed-by tags still being valid and meaningful. Don't
> > > include them unless you just do cosmetic changes.
> > 
> > Fine.
> > 
> > However, the V6 only change isn't big, just for addressing the un-initialized
> > warning, and the change is only done on function of irq_build_affinity_masks().
> 
> They are not trivial either:
> 
>  affinity.c |   28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
> 
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -339,7 +339,7 @@ static int irq_build_affinity_masks(unsi
>  				    unsigned int firstvec,
>  				    struct irq_affinity_desc *masks)
>  {
> -	unsigned int curvec = startvec, nr_present, nr_others;
> +	unsigned int curvec = startvec, nr_present = 0, nr_others = 0;
>  	cpumask_var_t *node_to_cpumask;
>  	cpumask_var_t nmsk, npresmsk;
>  	int ret = -ENOMEM;
> @@ -354,19 +354,17 @@ static int irq_build_affinity_masks(unsi
>  	if (!node_to_cpumask)
>  		goto fail_npresmsk;
>  
> -	ret = 0;
>  	/* Stabilize the cpumasks */
>  	get_online_cpus();
>  	build_node_to_cpumask(node_to_cpumask);
>  
>  	/* Spread on present CPUs starting from affd->pre_vectors */
> -	nr_present = __irq_build_affinity_masks(curvec, numvecs,
> -						firstvec, node_to_cpumask,
> -						cpu_present_mask, nmsk, masks);
> -	if (nr_present < 0) {
> -		ret = nr_present;
> +	ret = __irq_build_affinity_masks(curvec, numvecs, firstvec,
> +					 node_to_cpumask, cpu_present_mask,
> +					 nmsk, masks);
> +	if (ret < 0)
>  		goto fail_build_affinity;
> -	}
> +	nr_present = ret;
>  
>  	/*
>  	 * Spread on non present CPUs starting from the next vector to be
> @@ -379,16 +377,16 @@ static int irq_build_affinity_masks(unsi
>  	else
>  		curvec = firstvec + nr_present;
>  	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
> -	nr_others = __irq_build_affinity_masks(curvec, numvecs,
> -					       firstvec, node_to_cpumask,
> -					       npresmsk, nmsk, masks);
> -	if (nr_others < 0)
> -		ret = nr_others;
> +	ret = __irq_build_affinity_masks(curvec, numvecs, firstvec,
> +					 node_to_cpumask, npresmsk, nmsk,
> +					 masks);
> +	if (ret >= 0)
> +		nr_others = ret;
>  
>   fail_build_affinity:
>  	put_online_cpus();
>  
> -	if (min(nr_present, nr_others) >= 0)
> +	if (ret >= 0)
>  		WARN_ON(nr_present + nr_others < numvecs);
>  
>  	free_node_to_cpumask(node_to_cpumask);
> @@ -398,7 +396,7 @@ static int irq_build_affinity_masks(unsi
>  
>   fail_nmsk:
>  	free_cpumask_var(nmsk);
> -	return ret;
> +	return ret < 0 ? ret : 0;
>  }
>  
>  static void default_calc_sets(struct irq_affinity *affd, unsigned int affvecs)

Hi Keith & Jon,

Could you review the above V6 extra change so that we can move on?

BTW, in-balanced numa nodes can be made easily via passing 'possible_cpus=N'.


Thanks, 
Ming
