Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B820C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132FE206C1
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfHMIPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 04:15:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32880 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbfHMIPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 04:15:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A7E0520ABB;
        Tue, 13 Aug 2019 08:15:17 +0000 (UTC)
Received: from localhost (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E556C7981E;
        Tue, 13 Aug 2019 08:15:15 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org,
        Jon Derrick <jonathan.derrick@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH V3 3/3] genirq/affinity: Spread vectors on node according to nr_cpu ratio
Date:   Tue, 13 Aug 2019 16:14:47 +0800
Message-Id: <20190813081447.1396-4-ming.lei@redhat.com>
In-Reply-To: <20190813081447.1396-1-ming.lei@redhat.com>
References: <20190813081447.1396-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 13 Aug 2019 08:15:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now __irq_build_affinity_masks() spreads vectors evenly per node, and
all vectors may not be spread in case that each numa node has different
CPU number, then the following warning in irq_build_affinity_masks() can
be triggered:

	if (nr_present < numvecs)
		WARN_ON(nr_present + nr_others < numvecs);

Improve current spreading algorithm by assigning vectors according to
the ratio of node's nr_cpu to nr_remaining_cpus, meantime running the
assignment from smaller nodes to bigger nodes to guarantee that every
active node gets allocated at least one vector, then we can avoid
cross-node spread.

Meantime the reported warning can be fixed.

Another big goodness is that the spread approach becomes more fair if
node has different CPU number.

For example, on the following machine:
	[root@ktest-01 ~]# lscpu
	...
	CPU(s):              16
	On-line CPU(s) list: 0-15
	Thread(s) per core:  1
	Core(s) per socket:  8
	Socket(s):           2
	NUMA node(s):        2
	...
	NUMA node0 CPU(s):   0,1,3,5-9,11,13-15
	NUMA node1 CPU(s):   2,4,10,12

When driver requests to allocate 8 vectors, the following spread can
be got:
	irq 31, cpu list 2,4
	irq 32, cpu list 10,12
	irq 33, cpu list 0-1
	irq 34, cpu list 3,5
	irq 35, cpu list 6-7
	irq 36, cpu list 8-9
	irq 37, cpu list 11,13
	irq 38, cpu list 14-15

Without this patch, kernel warning is triggered on above situation, and
allocation result was supposed to be 4 vectors for each node.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org,
Cc: Jon Derrick <jonathan.derrick@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>
Reported-by: Jon Derrick <jonathan.derrick@intel.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 kernel/irq/affinity.c | 196 +++++++++++++++++++++++++++++++++---------
 1 file changed, 156 insertions(+), 40 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 4e329495e9dc..717592879a54 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/cpu.h>
+#include <linux/sort.h>
 
 static void irq_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 				unsigned int cpus_per_vec)
@@ -94,6 +95,127 @@ static int get_nodes_in_cpumask(cpumask_var_t *node_to_cpumask,
 	return nodes;
 }
 
+struct node_nr_vectors {
+	unsigned n;
+
+	union {
+		unsigned nvectors;
+		unsigned ncpus;
+	};
+};
+
+static int ncpus_cmp_func(const void *l, const void *r)
+{
+	const struct node_nr_vectors *ln = l;
+	const struct node_nr_vectors *rn = r;
+
+	return ln->ncpus - rn->ncpus;
+}
+
+static void alloc_nodes_vectors(unsigned int numvecs,
+				const cpumask_var_t *node_to_cpumask,
+				const struct cpumask *cpu_mask,
+				const nodemask_t nodemsk,
+				struct cpumask *nmsk,
+				struct node_nr_vectors *node_vectors)
+{
+	unsigned remaining_ncpus = 0;
+	unsigned n;
+
+	for (n = 0; n < nr_node_ids; n++) {
+		node_vectors[n].n = n;
+		node_vectors[n].ncpus = UINT_MAX;
+	}
+
+	for_each_node_mask(n, nodemsk) {
+		unsigned ncpus;
+
+		cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
+		ncpus = cpumask_weight(nmsk);
+
+		if (!ncpus)
+			continue;
+		remaining_ncpus += ncpus;
+		node_vectors[n].ncpus = ncpus;
+	}
+
+	sort(node_vectors, nr_node_ids, sizeof(node_vectors[0]),
+	     ncpus_cmp_func, NULL);
+
+	/*
+	 * Allocate vectors for each node according to the ratio of this
+	 * node's nr_cpus to remaining un-assigned ncpus. 'numvecs' is
+	 * bigger than number of active numa nodes. Always start the
+	 * allocation from the node with minimized nr_cpus.
+	 *
+	 * This way guarantees that each active node gets allocated at
+	 * least one vector, and the theory is simple: over-allocation
+	 * is only done when this node is assigned by one vector, so
+	 * other nodes will be allocated >= 1 vector, since 'numvecs' is
+	 * bigger than number of numa nodes.
+	 */
+	for (n = 0; n < nr_node_ids; n++) {
+		unsigned nvectors, ncpus;
+
+		if (node_vectors[n].ncpus == UINT_MAX)
+			continue;
+
+		WARN_ON_ONCE(numvecs == 0);
+
+		ncpus = node_vectors[n].ncpus;
+		nvectors = max_t(unsigned, 1,
+				 numvecs * ncpus / remaining_ncpus);
+
+		node_vectors[n].nvectors = nvectors;
+		remaining_ncpus -= ncpus;
+		numvecs -= nvectors;
+	}
+}
+
+/**
+ * irq_spread_vectors_on_node - Spread vectors on one node
+ * @startvec:	The 1st vector to be spread
+ * @numvecs:	The number of vectors to be spread
+ * @nmsk:	The cpumask of this node
+ * @masks:	The cpumask array for storing vector affinity
+ */
+static void irq_spread_vectors_on_node(unsigned startvec, unsigned numvecs,
+				       struct cpumask *nmsk,
+				       struct irq_affinity_desc *masks)
+{
+	unsigned ncpus = cpumask_weight(nmsk);
+
+	while (numvecs > 0) {
+		unsigned v, vecs_to_assign, extra_vecs;
+		unsigned curvec = startvec;
+
+		/*
+		 * alloc_nodes_vectors() is intelligent enough to
+		 * allocate vectors for each node. If the allocated
+		 * vectors is bigger than node's CPU number because
+		 * of rounddown, wraps to the first vector for this
+		 * node, then cross-node spread can be avoided.
+		 */
+		vecs_to_assign = min(numvecs, ncpus);
+
+		/* Account for rounding errors */
+		extra_vecs = ncpus - vecs_to_assign * (ncpus / vecs_to_assign);
+
+		for (v = 0; v < vecs_to_assign; v++, curvec++) {
+			unsigned cpus_per_vec = ncpus / vecs_to_assign;
+
+			/* Account for extra vectors to compensate rounding errors */
+			if (extra_vecs) {
+				cpus_per_vec++;
+				--extra_vecs;
+			}
+			irq_spread_init_one(&masks[curvec].mask, nmsk,
+						cpus_per_vec);
+		}
+		numvecs -= vecs_to_assign;
+	}
+}
+
 static int __irq_build_affinity_masks(unsigned int startvec,
 				      unsigned int numvecs,
 				      unsigned int firstvec,
@@ -102,10 +224,11 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 				      struct cpumask *nmsk,
 				      struct irq_affinity_desc *masks)
 {
-	unsigned int n, nodes, cpus_per_vec, extra_vecs, done = 0;
+	unsigned int i, n, nodes, done = 0;
 	unsigned int last_affv = firstvec + numvecs;
 	unsigned int curvec = startvec;
 	nodemask_t nodemsk = NODE_MASK_NONE;
+	struct node_nr_vectors *node_vectors;
 
 	if (!cpumask_weight(cpu_mask))
 		return 0;
@@ -126,52 +249,36 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 		return numvecs;
 	}
 
-	for_each_node_mask(n, nodemsk) {
-		unsigned int ncpus, v, vecs_to_assign, vecs_per_node;
+	node_vectors = kcalloc(nr_node_ids,
+			       sizeof(struct node_nr_vectors),
+			       GFP_KERNEL);
+	if (!node_vectors)
+		return -ENOMEM;
+
+	alloc_nodes_vectors(numvecs, node_to_cpumask, cpu_mask,
+			    nodemsk, nmsk, node_vectors);
+
+	for (i = 0; i < nr_node_ids; i++) {
+		unsigned int ncpus;
+		struct node_nr_vectors *nv = &node_vectors[i];
+
+		if (nv->nvectors == UINT_MAX)
+			continue;
 
 		/* Get the cpus on this node which are in the mask */
-		cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
+		cpumask_and(nmsk, cpu_mask, node_to_cpumask[nv->n]);
 		ncpus = cpumask_weight(nmsk);
 		if (!ncpus)
 			continue;
 
-		/*
-		 * Calculate the number of cpus per vector
-		 *
-		 * Spread the vectors evenly per node. If the requested
-		 * vector number has been reached, simply allocate one
-		 * vector for each remaining node so that all nodes can
-		 * be covered
-		 */
-		if (numvecs > done)
-			vecs_per_node = max_t(unsigned,
-					(numvecs - done) / nodes, 1);
-		else
-			vecs_per_node = 1;
-
-		vecs_to_assign = min(vecs_per_node, ncpus);
-
-		/* Account for rounding errors */
-		extra_vecs = ncpus - vecs_to_assign * (ncpus / vecs_to_assign);
-
-		for (v = 0; curvec < last_affv && v < vecs_to_assign;
-		     curvec++, v++) {
-			cpus_per_vec = ncpus / vecs_to_assign;
+		WARN_ON_ONCE(nv->nvectors == UINT_MAX);
+		WARN_ON_ONCE(curvec + nv->nvectors > last_affv);
+		irq_spread_vectors_on_node(curvec, nv->nvectors, nmsk, masks);
 
-			/* Account for extra vectors to compensate rounding errors */
-			if (extra_vecs) {
-				cpus_per_vec++;
-				--extra_vecs;
-			}
-			irq_spread_init_one(&masks[curvec].mask, nmsk,
-						cpus_per_vec);
-		}
-
-		done += v;
-		if (curvec >= last_affv)
-			curvec = firstvec;
-		--nodes;
+		curvec += nv->nvectors;
+		done += nv->nvectors;
 	}
+	kfree(node_vectors);
 	return done < numvecs ? done : numvecs;
 }
 
@@ -208,6 +315,10 @@ static int irq_build_affinity_masks(unsigned int startvec, unsigned int numvecs,
 	nr_present = __irq_build_affinity_masks(curvec, numvecs,
 						firstvec, node_to_cpumask,
 						cpu_present_mask, nmsk, masks);
+	if (nr_present < 0) {
+		ret = nr_present;
+		goto fail_build_affinity;
+	}
 
 	/*
 	 * Spread on non present CPUs starting from the next vector to be
@@ -223,9 +334,14 @@ static int irq_build_affinity_masks(unsigned int startvec, unsigned int numvecs,
 	nr_others = __irq_build_affinity_masks(curvec, numvecs,
 					       firstvec, node_to_cpumask,
 					       npresmsk, nmsk, masks);
+	if (nr_others < 0)
+		ret = nr_others;
+
+ fail_build_affinity:
 	put_online_cpus();
 
-	WARN_ON(max(nr_present, nr_others) < numvecs);
+	WARN_ON(min(nr_present, nr_others) >= 0 &&
+			max(nr_present, nr_others) < numvecs);
 
 	free_node_to_cpumask(node_to_cpumask);
 
-- 
2.20.1

