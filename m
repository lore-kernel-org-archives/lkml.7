Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1ABC3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9DF20578
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfH1I6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 04:58:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47454 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbfH1I6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 04:58:25 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 236D030842B0;
        Wed, 28 Aug 2019 08:58:25 +0000 (UTC)
Received: from localhost (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA3D21001B05;
        Wed, 28 Aug 2019 08:58:21 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        kbuild test robot <lkp@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH] genirq/affinity: Fix build waring in __irq_build_affinity_masks
Date:   Wed, 28 Aug 2019 16:58:15 +0800
Message-Id: <20190828085815.19931-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 28 Aug 2019 08:58:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_CPUMASK_OFFSTACK isn't enabled, 'cpumask_var_t' will be
defined as 'typedef struct cpumask cpumask_var_t[1]', so we can't
declare the argument of 'node_to_cpumask' as 'const cpumask_var_t *'
for alloc_nodes_vectors().

Fixes the following warning:

   kernel/irq/affinity.c: In function '__irq_build_affinity_masks':
>> kernel/irq/affinity.c:287:31: warning: passing argument 2 of 'alloc_nodes_vectors' from incompatible pointer type
     alloc_nodes_vectors(numvecs, node_to_cpumask, cpu_mask,
                                  ^
   kernel/irq/affinity.c:128:13: note: expected 'const struct cpumask (*)[1]' but argument is of type 'struct cpumask (*)[1]'
    static void alloc_nodes_vectors(unsigned int numvecs,
                ^

Fixes: b1a5a73e64e9 ("genirq/affinity: Spread vectors on node according to nr_cpu ratio")
Reported-by: kbuild test robot <lkp@intel.com>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Jon Derrick <jonathan.derrick@intel.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 kernel/irq/affinity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index d905e844bf3a..4d89ad4fae3b 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -126,7 +126,7 @@ static int ncpus_cmp_func(const void *l, const void *r)
  * for each node.
  */
 static void alloc_nodes_vectors(unsigned int numvecs,
-				const cpumask_var_t *node_to_cpumask,
+				cpumask_var_t *node_to_cpumask,
 				const struct cpumask *cpu_mask,
 				const nodemask_t nodemsk,
 				struct cpumask *nmsk,
-- 
2.20.1

