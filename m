Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCFEC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A161721881
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbfH0Ogr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 10:36:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43963 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729636AbfH0Ogp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 10:36:45 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2caJ-0008Qx-Fn; Tue, 27 Aug 2019 16:36:35 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 172831C0DDE;
        Tue, 27 Aug 2019 16:36:35 +0200 (CEST)
Date:   Tue, 27 Aug 2019 14:36:35 -0000
From:   "tip-bot2 for Ming Lei" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/affinity: Spread vectors on node according to
 nr_cpu ratio
Cc:     Jon Derrick <jonathan.derrick@intel.com>,
        Ming Lei <ming.lei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <kbusch@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190816022849.14075-3-ming.lei@redhat.com>
References: <20190816022849.14075-3-ming.lei@redhat.com>
MIME-Version: 1.0
Message-ID: <156691659501.23593.1867538449039948777.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     b1a5a73e64e99faa5f4deef2ae96d7371a0fb5d0
Gitweb:        https://git.kernel.org/tip/b1a5a73e64e99faa5f4deef2ae96d7371a0fb5d0
Author:        Ming Lei <ming.lei@redhat.com>
AuthorDate:    Fri, 16 Aug 2019 10:28:49 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 27 Aug 2019 16:31:17 +02:00

genirq/affinity: Spread vectors on node according to nr_cpu ratio

Now __irq_build_affinity_masks() spreads vectors evenly per node, but there
is a case that not all vectors have been spread when each numa node has a
different number of CPUs which triggers the warning in the spreading code.

Improve the spreading algorithm by

 - assigning vectors according to the ratio of the number of CPUs on a node
   to the number of remaining CPUs.

 - running the assignment from smaller nodes to bigger nodes to guarantee
   that every active node gets allocated at least one vector.

This ensures that all vectors are spread out. Asided of that the spread
becomes more fair if the nodes have different number of CPUs.

For example, on the following machine:
	CPU(s):              16
	On-line CPU(s) list: 0-15
	Thread(s) per core:  1
	Core(s) per socket:  8
	Socket(s):           2
	NUMA node(s):        2
	...
	NUMA node0 CPU(s):   0,1,3,5-9,11,13-15
	NUMA node1 CPU(s):   2,4,10,12

When a driver requests to allocate 8 vectors, the following spread results:

	irq 31, cpu list 2,4
	irq 32, cpu list 10,12
	irq 33, cpu list 0-1
	irq 34, cpu list 3,5
	irq 35, cpu list 6-7
	irq 36, cpu list 8-9
	irq 37, cpu list 11,13
	irq 38, cpu list 14-15

So Node 0 has now 6 and Node 1 has 2 vectors assigned. The original
algorithm assigned 4 vectors on each node which was unfair versus Node 0.

[ tglx: Massaged changelog ]

Reported-by: Jon Derrick <jonathan.derrick@intel.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
Link: https://lkml.kernel.org/r/20190816022849.14075-3-ming.lei@redhat.com

---
 kernel/irq/affinity.c | 239 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 200 insertions(+), 39 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index c7cca94..d905e84 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/cpu.h>
+#include <linux/sort.h>
 
 static void irq_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 				unsigned int cpus_per_vec)
@@ -94,6 +95,155 @@ static int get_nodes_in_cpumask(cpumask_var_t *node_to_cpumask,
 	return nodes;
 }
 
+struct node_vectors {
+	unsigned id;
+
+	union {
+		unsigned nvectors;
+		unsigned ncpus;
+	};
+};
+
+static int ncpus_cmp_func(const void *l, const void *r)
+{
+	const struct node_vectors *ln = l;
+	const struct node_vectors *rn = r;
+
+	return ln->ncpus - rn->ncpus;
+}
+
+/*
+ * Allocate vector number for each node, so that for each node:
+ *
+ * 1) the allocated number is >= 1
+ *
+ * 2) the allocated numbver is <= active CPU number of this node
+ *
+ * The actual allocated total vectors may be less than @numvecs when
+ * active total CPU number is less than @numvecs.
+ *
+ * Active CPUs means the CPUs in '@cpu_mask AND @node_to_cpumask[]'
+ * for each node.
+ */
+static void alloc_nodes_vectors(unsigned int numvecs,
+				const cpumask_var_t *node_to_cpumask,
+				const struct cpumask *cpu_mask,
+				const nodemask_t nodemsk,
+				struct cpumask *nmsk,
+				struct node_vectors *node_vectors)
+{
+	unsigned n, remaining_ncpus = 0;
+
+	for (n = 0; n < nr_node_ids; n++) {
+		node_vectors[n].id = n;
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
+	numvecs = min_t(unsigned, remaining_ncpus, numvecs);
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
+	 *
+	 * One perfect invariant is that number of allocated vectors for
+	 * each node is <= CPU count of this node:
+	 *
+	 * 1) suppose there are two nodes: A and B
+	 * 	ncpu(X) is CPU count of node X
+	 * 	vecs(X) is the vector count allocated to node X via this
+	 * 	algorithm
+	 *
+	 * 	ncpu(A) <= ncpu(B)
+	 * 	ncpu(A) + ncpu(B) = N
+	 * 	vecs(A) + vecs(B) = V
+	 *
+	 * 	vecs(A) = max(1, round_down(V * ncpu(A) / N))
+	 * 	vecs(B) = V - vecs(A)
+	 *
+	 * 	both N and V are integer, and 2 <= V <= N, suppose
+	 * 	V = N - delta, and 0 <= delta <= N - 2
+	 *
+	 * 2) obviously vecs(A) <= ncpu(A) because:
+	 *
+	 * 	if vecs(A) is 1, then vecs(A) <= ncpu(A) given
+	 * 	ncpu(A) >= 1
+	 *
+	 * 	otherwise,
+	 * 		vecs(A) <= V * ncpu(A) / N <= ncpu(A), given V <= N
+	 *
+	 * 3) prove how vecs(B) <= ncpu(B):
+	 *
+	 * 	if round_down(V * ncpu(A) / N) == 0, vecs(B) won't be
+	 * 	over-allocated, so vecs(B) <= ncpu(B),
+	 *
+	 * 	otherwise:
+	 *
+	 * 	vecs(A) =
+	 * 		round_down(V * ncpu(A) / N) =
+	 * 		round_down((N - delta) * ncpu(A) / N) =
+	 * 		round_down((N * ncpu(A) - delta * ncpu(A)) / N)	 >=
+	 * 		round_down((N * ncpu(A) - delta * N) / N)	 =
+	 * 		cpu(A) - delta
+	 *
+	 * 	then:
+	 *
+	 * 	vecs(A) - V >= ncpu(A) - delta - V
+	 * 	=>
+	 * 	V - vecs(A) <= V + delta - ncpu(A)
+	 * 	=>
+	 * 	vecs(B) <= N - ncpu(A)
+	 * 	=>
+	 * 	vecs(B) <= cpu(B)
+	 *
+	 * For nodes >= 3, it can be thought as one node and another big
+	 * node given that is exactly what this algorithm is implemented,
+	 * and we always re-calculate 'remaining_ncpus' & 'numvecs', and
+	 * finally for each node X: vecs(X) <= ncpu(X).
+	 *
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
+		WARN_ON_ONCE(nvectors > ncpus);
+
+		node_vectors[n].nvectors = nvectors;
+
+		remaining_ncpus -= ncpus;
+		numvecs -= nvectors;
+	}
+}
+
 static int __irq_build_affinity_masks(unsigned int startvec,
 				      unsigned int numvecs,
 				      unsigned int firstvec,
@@ -102,10 +252,11 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 				      struct cpumask *nmsk,
 				      struct irq_affinity_desc *masks)
 {
-	unsigned int n, nodes, cpus_per_vec, extra_vecs, done = 0;
+	unsigned int i, n, nodes, cpus_per_vec, extra_vecs, done = 0;
 	unsigned int last_affv = firstvec + numvecs;
 	unsigned int curvec = startvec;
 	nodemask_t nodemsk = NODE_MASK_NONE;
+	struct node_vectors *node_vectors;
 
 	if (!cpumask_weight(cpu_mask))
 		return 0;
@@ -126,53 +277,57 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 		return numvecs;
 	}
 
-	for_each_node_mask(n, nodemsk) {
-		unsigned int ncpus, v, vecs_to_assign, vecs_per_node;
+	node_vectors = kcalloc(nr_node_ids,
+			       sizeof(struct node_vectors),
+			       GFP_KERNEL);
+	if (!node_vectors)
+		return -ENOMEM;
+
+	/* allocate vector number for each node */
+	alloc_nodes_vectors(numvecs, node_to_cpumask, cpu_mask,
+			    nodemsk, nmsk, node_vectors);
+
+	for (i = 0; i < nr_node_ids; i++) {
+		unsigned int ncpus, v;
+		struct node_vectors *nv = &node_vectors[i];
+
+		if (nv->nvectors == UINT_MAX)
+			continue;
 
 		/* Get the cpus on this node which are in the mask */
-		cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
+		cpumask_and(nmsk, cpu_mask, node_to_cpumask[nv->id]);
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
+		WARN_ON_ONCE(nv->nvectors > ncpus);
 
 		/* Account for rounding errors */
-		extra_vecs = ncpus - vecs_to_assign * (ncpus / vecs_to_assign);
+		extra_vecs = ncpus - nv->nvectors * (ncpus / nv->nvectors);
 
-		for (v = 0; curvec < last_affv && v < vecs_to_assign;
-		     curvec++, v++) {
-			cpus_per_vec = ncpus / vecs_to_assign;
+		/* Spread allocated vectors on CPUs of the current node */
+		for (v = 0; v < nv->nvectors; v++, curvec++) {
+			cpus_per_vec = ncpus / nv->nvectors;
 
 			/* Account for extra vectors to compensate rounding errors */
 			if (extra_vecs) {
 				cpus_per_vec++;
 				--extra_vecs;
 			}
+
+			/*
+			 * wrapping has to be considered given 'startvec'
+			 * may start anywhere
+			 */
+			if (curvec >= last_affv)
+				curvec = firstvec;
 			irq_spread_init_one(&masks[curvec].mask, nmsk,
 						cpus_per_vec);
 		}
-
-		done += v;
-		if (curvec >= last_affv)
-			curvec = firstvec;
-		--nodes;
+		done += nv->nvectors;
 	}
-	return done < numvecs ? done : numvecs;
+	kfree(node_vectors);
+	return done;
 }
 
 /*
@@ -184,7 +339,7 @@ static int irq_build_affinity_masks(unsigned int startvec, unsigned int numvecs,
 				    unsigned int firstvec,
 				    struct irq_affinity_desc *masks)
 {
-	unsigned int curvec = startvec, nr_present, nr_others;
+	unsigned int curvec = startvec, nr_present = 0, nr_others = 0;
 	cpumask_var_t *node_to_cpumask;
 	cpumask_var_t nmsk, npresmsk;
 	int ret = -ENOMEM;
@@ -199,15 +354,17 @@ static int irq_build_affinity_masks(unsigned int startvec, unsigned int numvecs,
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
+	ret = __irq_build_affinity_masks(curvec, numvecs, firstvec,
+					 node_to_cpumask, cpu_present_mask,
+					 nmsk, masks);
+	if (ret < 0)
+		goto fail_build_affinity;
+	nr_present = ret;
 
 	/*
 	 * Spread on non present CPUs starting from the next vector to be
@@ -220,12 +377,16 @@ static int irq_build_affinity_masks(unsigned int startvec, unsigned int numvecs,
 	else
 		curvec = firstvec + nr_present;
 	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
-	nr_others = __irq_build_affinity_masks(curvec, numvecs,
-					       firstvec, node_to_cpumask,
-					       npresmsk, nmsk, masks);
+	ret = __irq_build_affinity_masks(curvec, numvecs, firstvec,
+					 node_to_cpumask, npresmsk, nmsk,
+					 masks);
+	if (ret >= 0)
+		nr_others = ret;
+
+ fail_build_affinity:
 	put_online_cpus();
 
-	if (nr_present < numvecs)
+	if (ret >= 0)
 		WARN_ON(nr_present + nr_others < numvecs);
 
 	free_node_to_cpumask(node_to_cpumask);
@@ -235,7 +396,7 @@ static int irq_build_affinity_masks(unsigned int startvec, unsigned int numvecs,
 
  fail_nmsk:
 	free_cpumask_var(nmsk);
-	return ret;
+	return ret < 0 ? ret : 0;
 }
 
 static void default_calc_sets(struct irq_affinity *affd, unsigned int affvecs)
