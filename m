Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB11C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 433372173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565282092;
	bh=95Er43qZvMplrezdl0LI4jtkKdBwgvpsqB/rsSHZN74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sRXRGwJelcSZeV64072f8uuznqgalU+E3NIMDTxIVlch56ieHMo4Uq2IgYk4IV2eH
	 H8pAzp6PwZ5BgsRjr9GJs4viiQIpi3zQNxwbaV0gQDRrcSJwmCQKGKJHrxUF7q7YCi
	 AVKXiem/G98l86MwewXD6CdKEeWigJO+lSFZskt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390143AbfHHQev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 12:34:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:54043 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfHHQeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 12:34:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 09:34:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,362,1559545200"; 
   d="scan'208";a="174895459"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga008.fm.intel.com with ESMTP; 08 Aug 2019 09:34:49 -0700
Date:   Thu, 8 Aug 2019 10:32:24 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jon Derrick <jonathan.derrick@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] genirq/affinity: report extra vectors on uneven nodes
Message-ID: <20190808163224.GB27077@localhost.localdomain>
References: <20190807201051.32662-1-jonathan.derrick@intel.com>
 <alpine.DEB.2.21.1908080903360.2882@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908080903360.2882@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 09:04:28AM +0200, Thomas Gleixner wrote:
> On Wed, 7 Aug 2019, Jon Derrick wrote:
> > The current irq spreading algorithm spreads vectors amongst cpus evenly
> > per node. If a node has more cpus than another node, the extra vectors
> > being spread may not be reported back to the caller.
> > 
> > This is most apparent with the NVMe driver and nr_cpus < vectors, where
> > the underreporting results in the caller's WARN being triggered:
> > 
> > irq_build_affinity_masks()
> > ...
> > 	if (nr_present < numvecs)
> > 		WARN_ON(nr_present + nr_others < numvecs);
> > 
> > Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> > ---
> >  kernel/irq/affinity.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> > index 4352b08ae48d..9beafb8c7e92 100644
> > --- a/kernel/irq/affinity.c
> > +++ b/kernel/irq/affinity.c
> > @@ -127,7 +127,8 @@ static int __irq_build_affinity_masks(unsigned int startvec,
> >  	}
> >  
> >  	for_each_node_mask(n, nodemsk) {
> > -		unsigned int ncpus, v, vecs_to_assign, vecs_per_node;
> > +		unsigned int ncpus, v, vecs_to_assign, total_vecs_to_assign,
> > +			vecs_per_node;
> >  
> >  		/* Spread the vectors per node */
> >  		vecs_per_node = (numvecs - (curvec - firstvec)) / nodes;
> > @@ -141,14 +142,16 @@ static int __irq_build_affinity_masks(unsigned int startvec,
> >  
> >  		/* Account for rounding errors */
> >  		extra_vecs = ncpus - vecs_to_assign * (ncpus / vecs_to_assign);
> > +		total_vecs_to_assign = vecs_to_assign + extra_vecs;
> >  
> > -		for (v = 0; curvec < last_affv && v < vecs_to_assign;
> > +		for (v = 0; curvec < last_affv && v < total_vecs_to_assign;
> >  		     curvec++, v++) {
> >  			cpus_per_vec = ncpus / vecs_to_assign;
> >  
> >  			/* Account for extra vectors to compensate rounding errors */
> >  			if (extra_vecs) {
> >  				cpus_per_vec++;
> > +				v++;
> >  				--extra_vecs;
> >  			}
> >  			irq_spread_init_one(&masks[curvec].mask, nmsk,
> > -- 

This looks like it will break the spread to non-present CPUs since
it's not accurately reporting how many vectors were assigned for the
present spread.

I think the real problem is the spread's vecs_per_node doesn't account
which nodes contribute more CPUs than others. For example:

  Node 0 has 32 CPUs
  Node 1 has 8 CPUs
  Assign 32 vectors

The current algorithm assigns 16 vectors to node 0 because vecs_per_node
is calculated as 32 vectors / 2 nodes on the first iteration. The
subsequent iteration for node 1 gets 8 vectors because it has only 8
CPUs, leaving 8 vectors unassigned.

A more fair spread would give node 0 the remaining 8 vectors. This
optimization, however, is a bit more complex than the current algorithm,
which is probably why it wasn't done, so I think the warning should just
be removed.
