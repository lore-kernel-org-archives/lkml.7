Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A92CC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B9FF204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbfHSOCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:02:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47355 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbfHSOC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:02:29 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hziEo-00056R-9c; Mon, 19 Aug 2019 16:02:22 +0200
Date:   Mon, 19 Aug 2019 16:02:21 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ming Lei <ming.lei@redhat.com>
cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH V6 2/2] genirq/affinity: Spread vectors on node according
 to nr_cpu ratio
In-Reply-To: <20190819135217.GA10108@ming.t460p>
Message-ID: <alpine.DEB.2.21.1908191601520.2147@nanos.tec.linutronix.de>
References: <20190819124937.9948-1-ming.lei@redhat.com> <20190819124937.9948-3-ming.lei@redhat.com> <alpine.DEB.2.21.1908191511440.2147@nanos.tec.linutronix.de> <20190819135217.GA10108@ming.t460p>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2019, Ming Lei wrote:
> On Mon, Aug 19, 2019 at 03:13:58PM +0200, Thomas Gleixner wrote:
> > On Mon, 19 Aug 2019, Ming Lei wrote:
> > 
> > > Cc: Jon Derrick <jonathan.derrick@intel.com>
> > > Cc: Jens Axboe <axboe@kernel.dk>
> > > Reported-by: Jon Derrick <jonathan.derrick@intel.com>
> > > Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
> > > Reviewed-by: Keith Busch <kbusch@kernel.org>
> > 
> > This version is sufficiently different from the previous one, so I do not
> > consider the reviewed-by tags still being valid and meaningful. Don't
> > include them unless you just do cosmetic changes.
> 
> Fine.
> 
> However, the V6 only change isn't big, just for addressing the un-initialized
> warning, and the change is only done on function of irq_build_affinity_masks().

They are not trivial either:

 affinity.c |   28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -339,7 +339,7 @@ static int irq_build_affinity_masks(unsi
 				    unsigned int firstvec,
 				    struct irq_affinity_desc *masks)
 {
-	unsigned int curvec = startvec, nr_present, nr_others;
+	unsigned int curvec = startvec, nr_present = 0, nr_others = 0;
 	cpumask_var_t *node_to_cpumask;
 	cpumask_var_t nmsk, npresmsk;
 	int ret = -ENOMEM;
@@ -354,19 +354,17 @@ static int irq_build_affinity_masks(unsi
 	if (!node_to_cpumask)
 		goto fail_npresmsk;
 
-	ret = 0;
 	/* Stabilize the cpumasks */
 	get_online_cpus();
 	build_node_to_cpumask(node_to_cpumask);
 
 	/* Spread on present CPUs starting from affd->pre_vectors */
-	nr_present = __irq_build_affinity_masks(curvec, numvecs,
-						firstvec, node_to_cpumask,
-						cpu_present_mask, nmsk, masks);
-	if (nr_present < 0) {
-		ret = nr_present;
+	ret = __irq_build_affinity_masks(curvec, numvecs, firstvec,
+					 node_to_cpumask, cpu_present_mask,
+					 nmsk, masks);
+	if (ret < 0)
 		goto fail_build_affinity;
-	}
+	nr_present = ret;
 
 	/*
 	 * Spread on non present CPUs starting from the next vector to be
@@ -379,16 +377,16 @@ static int irq_build_affinity_masks(unsi
 	else
 		curvec = firstvec + nr_present;
 	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
-	nr_others = __irq_build_affinity_masks(curvec, numvecs,
-					       firstvec, node_to_cpumask,
-					       npresmsk, nmsk, masks);
-	if (nr_others < 0)
-		ret = nr_others;
+	ret = __irq_build_affinity_masks(curvec, numvecs, firstvec,
+					 node_to_cpumask, npresmsk, nmsk,
+					 masks);
+	if (ret >= 0)
+		nr_others = ret;
 
  fail_build_affinity:
 	put_online_cpus();
 
-	if (min(nr_present, nr_others) >= 0)
+	if (ret >= 0)
 		WARN_ON(nr_present + nr_others < numvecs);
 
 	free_node_to_cpumask(node_to_cpumask);
@@ -398,7 +396,7 @@ static int irq_build_affinity_masks(unsi
 
  fail_nmsk:
 	free_cpumask_var(nmsk);
-	return ret;
+	return ret < 0 ? ret : 0;
 }
 
 static void default_calc_sets(struct irq_affinity *affd, unsigned int affvecs)
