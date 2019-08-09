Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821C0C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 10:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F3A22166E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 10:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406393AbfHIKXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 06:23:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56026 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406380AbfHIKXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 06:23:50 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A94783061524;
        Fri,  9 Aug 2019 10:23:50 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 36B1160BF3;
        Fri,  9 Aug 2019 10:23:46 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 2/2] genirq/affinity: spread vectors on node according to nr_cpu ratio
Date:   Fri,  9 Aug 2019 18:23:10 +0800
Message-Id: <20190809102310.27246-3-ming.lei@redhat.com>
In-Reply-To: <20190809102310.27246-1-ming.lei@redhat.com>
References: <20190809102310.27246-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 09 Aug 2019 10:23:50 +0000 (UTC)
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
the ratio of node's nr_cpu to nr_remaining_cpus.

Meantime the reported warning can be fixed.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org,
Cc: Jon Derrick <jonathan.derrick@intel.com>
Reported-by: Jon Derrick <jonathan.derrick@intel.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 kernel/irq/affinity.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index bc3652a2c61b..76f3d1b27d00 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -106,6 +106,7 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 	unsigned int last_affv = firstvec + numvecs;
 	unsigned int curvec = startvec;
 	nodemask_t nodemsk = NODE_MASK_NONE;
+	unsigned remaining_cpus = 0;
 
 	if (!cpumask_weight(cpu_mask))
 		return 0;
@@ -126,6 +127,11 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 		return numvecs;
 	}
 
+	for_each_node_mask(n, nodemsk) {
+		cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
+		remaining_cpus += cpumask_weight(nmsk);
+	}
+
 	for_each_node_mask(n, nodemsk) {
 		unsigned int ncpus, v, vecs_to_assign, vecs_per_node;
 
@@ -135,17 +141,22 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 		if (!ncpus)
 			continue;
 
+		if (remaining_cpus == 0)
+			break;
+
 		/*
 		 * Calculate the number of cpus per vector
 		 *
-		 * Spread the vectors evenly per node. If the requested
-		 * vector number has been reached, simply allocate one
-		 * vector for each remaining node so that all nodes can
-		 * be covered
+		 * Spread the vectors among CPUs on this node according
+		 * to the ratio of 'ncpus' to 'remaining_cpus'. If the
+		 * requested vector number has been reached, simply
+		 * spread one vector for each remaining node so that all
+		 * nodes can be covered
 		 */
 		if (numvecs > done)
 			vecs_per_node = max_t(unsigned,
-					(numvecs - done) / nodes, 1);
+					(numvecs - done) * ncpus /
+					remaining_cpus, 1);
 		else
 			vecs_per_node = 1;
 
@@ -169,7 +180,7 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 		}
 
 		done += v;
-		--nodes;
+		remaining_cpus -= ncpus;
 	}
 	return done < numvecs ? done : numvecs;
 }
-- 
2.20.1

