Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F696C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 20:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D96921922
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 20:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389277AbfHGUK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 16:10:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:16763 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730180AbfHGUK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 16:10:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 13:10:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,358,1559545200"; 
   d="scan'208";a="165457363"
Received: from jderrick-mobl.amr.corp.intel.com ([10.232.115.152])
  by orsmga007.jf.intel.com with ESMTP; 07 Aug 2019 13:10:55 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
Cc:     <linux-nvme@lists.infradead.org>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH] genirq/affinity: report extra vectors on uneven nodes
Date:   Wed,  7 Aug 2019 14:10:51 -0600
Message-Id: <20190807201051.32662-1-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current irq spreading algorithm spreads vectors amongst cpus evenly
per node. If a node has more cpus than another node, the extra vectors
being spread may not be reported back to the caller.

This is most apparent with the NVMe driver and nr_cpus < vectors, where
the underreporting results in the caller's WARN being triggered:

irq_build_affinity_masks()
...
	if (nr_present < numvecs)
		WARN_ON(nr_present + nr_others < numvecs);

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 kernel/irq/affinity.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 4352b08ae48d..9beafb8c7e92 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -127,7 +127,8 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 	}
 
 	for_each_node_mask(n, nodemsk) {
-		unsigned int ncpus, v, vecs_to_assign, vecs_per_node;
+		unsigned int ncpus, v, vecs_to_assign, total_vecs_to_assign,
+			vecs_per_node;
 
 		/* Spread the vectors per node */
 		vecs_per_node = (numvecs - (curvec - firstvec)) / nodes;
@@ -141,14 +142,16 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 
 		/* Account for rounding errors */
 		extra_vecs = ncpus - vecs_to_assign * (ncpus / vecs_to_assign);
+		total_vecs_to_assign = vecs_to_assign + extra_vecs;
 
-		for (v = 0; curvec < last_affv && v < vecs_to_assign;
+		for (v = 0; curvec < last_affv && v < total_vecs_to_assign;
 		     curvec++, v++) {
 			cpus_per_vec = ncpus / vecs_to_assign;
 
 			/* Account for extra vectors to compensate rounding errors */
 			if (extra_vecs) {
 				cpus_per_vec++;
+				v++;
 				--extra_vecs;
 			}
 			irq_spread_init_one(&masks[curvec].mask, nmsk,
-- 
2.20.1

