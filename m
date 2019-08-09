Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7038C0650F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 03:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DDF217F4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 03:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405405AbfHIDEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 23:04:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49212 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733140AbfHIDEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 23:04:37 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 51D764F1BA;
        Fri,  9 Aug 2019 03:04:36 +0000 (UTC)
Received: from ming.t460p (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DFB019C70;
        Fri,  9 Aug 2019 03:04:30 +0000 (UTC)
Date:   Fri, 9 Aug 2019 11:04:25 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH] genirq/affinity: report extra vectors on uneven nodes
Message-ID: <20190809030424.GA17485@ming.t460p>
References: <20190807201051.32662-1-jonathan.derrick@intel.com>
 <alpine.DEB.2.21.1908080903360.2882@nanos.tec.linutronix.de>
 <20190808163224.GB27077@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808163224.GB27077@localhost.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 09 Aug 2019 03:04:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 10:32:24AM -0600, Keith Busch wrote:
> On Thu, Aug 08, 2019 at 09:04:28AM +0200, Thomas Gleixner wrote:
> > On Wed, 7 Aug 2019, Jon Derrick wrote:
> > > The current irq spreading algorithm spreads vectors amongst cpus evenly
> > > per node. If a node has more cpus than another node, the extra vectors
> > > being spread may not be reported back to the caller.
> > > 
> > > This is most apparent with the NVMe driver and nr_cpus < vectors, where
> > > the underreporting results in the caller's WARN being triggered:
> > > 
> > > irq_build_affinity_masks()
> > > ...
> > > 	if (nr_present < numvecs)
> > > 		WARN_ON(nr_present + nr_others < numvecs);
> > > 
> > > Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> > > ---
> > >  kernel/irq/affinity.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> > > index 4352b08ae48d..9beafb8c7e92 100644
> > > --- a/kernel/irq/affinity.c
> > > +++ b/kernel/irq/affinity.c
> > > @@ -127,7 +127,8 @@ static int __irq_build_affinity_masks(unsigned int startvec,
> > >  	}
> > >  
> > >  	for_each_node_mask(n, nodemsk) {
> > > -		unsigned int ncpus, v, vecs_to_assign, vecs_per_node;
> > > +		unsigned int ncpus, v, vecs_to_assign, total_vecs_to_assign,
> > > +			vecs_per_node;
> > >  
> > >  		/* Spread the vectors per node */
> > >  		vecs_per_node = (numvecs - (curvec - firstvec)) / nodes;
> > > @@ -141,14 +142,16 @@ static int __irq_build_affinity_masks(unsigned int startvec,
> > >  
> > >  		/* Account for rounding errors */
> > >  		extra_vecs = ncpus - vecs_to_assign * (ncpus / vecs_to_assign);
> > > +		total_vecs_to_assign = vecs_to_assign + extra_vecs;
> > >  
> > > -		for (v = 0; curvec < last_affv && v < vecs_to_assign;
> > > +		for (v = 0; curvec < last_affv && v < total_vecs_to_assign;
> > >  		     curvec++, v++) {
> > >  			cpus_per_vec = ncpus / vecs_to_assign;
> > >  
> > >  			/* Account for extra vectors to compensate rounding errors */
> > >  			if (extra_vecs) {
> > >  				cpus_per_vec++;
> > > +				v++;
> > >  				--extra_vecs;
> > >  			}
> > >  			irq_spread_init_one(&masks[curvec].mask, nmsk,
> > > -- 
> 
> This looks like it will break the spread to non-present CPUs since
> it's not accurately reporting how many vectors were assigned for the
> present spread.
> 
> I think the real problem is the spread's vecs_per_node doesn't account
> which nodes contribute more CPUs than others. For example:
> 
>   Node 0 has 32 CPUs
>   Node 1 has 8 CPUs
>   Assign 32 vectors
> 
> The current algorithm assigns 16 vectors to node 0 because vecs_per_node
> is calculated as 32 vectors / 2 nodes on the first iteration. The
> subsequent iteration for node 1 gets 8 vectors because it has only 8
> CPUs, leaving 8 vectors unassigned.
> 
> A more fair spread would give node 0 the remaining 8 vectors. This
> optimization, however, is a bit more complex than the current algorithm,
> which is probably why it wasn't done, so I think the warning should just
> be removed.

Another policy is to assign vectors among nodes according to the
following ratio:

	ncpus in this node / total ncpus in un-assigned nodes  

I have tried the following patch, looks it works fine:

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 6fef48033f96..a598f20701a3 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -94,6 +94,28 @@ static int get_nodes_in_cpumask(cpumask_var_t *node_to_cpumask,
 	return nodes;
 }
 
+static int nodes_cpus(unsigned start_node, const nodemask_t nodemsk,
+		const cpumask_var_t *node_to_cpumask,
+		const struct cpumask *cpu_mask, struct cpumask *nmsk)
+{
+	unsigned n, ncpus, total_cpus = 0;
+
+	for_each_node_mask(n, nodemsk) {
+		if (n < start_node)
+			continue;
+
+		/* Get the cpus on this node which are in the mask */
+		cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
+
+		/* Calculate the number of cpus per vector */
+		ncpus = cpumask_weight(nmsk);
+
+		total_cpus += ncpus;
+	}
+
+	return total_cpus;
+}
+
 static int __irq_build_affinity_masks(unsigned int startvec,
 				      unsigned int numvecs,
 				      unsigned int firstvec,
@@ -128,15 +150,25 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 
 	for_each_node_mask(n, nodemsk) {
 		unsigned int ncpus, v, vecs_to_assign, vecs_per_node;
-
-		/* Spread the vectors per node */
-		vecs_per_node = (numvecs - (curvec - firstvec)) / nodes;
+		unsigned int ncpus_left = nodes_cpus(n, nodemsk,
+				node_to_cpumask, cpu_mask, nmsk);
 
 		/* Get the cpus on this node which are in the mask */
 		cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
 
 		/* Calculate the number of cpus per vector */
 		ncpus = cpumask_weight(nmsk);
+
+		/*
+		 * Spread the vectors per node, and node with more CPUs will be
+		 * assigned to more vectors
+		 */
+		vecs_per_node = (numvecs - (curvec - firstvec)) * ncpus / ncpus_left;
+
+		/* at least assign one vector for this node */
+		if (!vecs_per_node)
+			vecs_per_node = 1;
+
 		vecs_to_assign = min(vecs_per_node, ncpus);
 
 		/* Account for rounding errors */
@@ -160,7 +192,6 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 			break;
 		if (curvec >= last_affv)
 			curvec = firstvec;
-		--nodes;
 	}
 	return done;
 }


thanks,
Ming
