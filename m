Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1C4C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67134204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbfDJIRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:17:38 -0400
Received: from mga05.intel.com ([192.55.52.43]:28987 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729080AbfDJIRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 04:17:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 01:17:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="141498237"
Received: from unknown (HELO xshen14-linux.bj.intel.com) ([10.238.155.105])
  by orsmga003.jf.intel.com with ESMTP; 10 Apr 2019 01:17:34 -0700
From:   Xiaochen Shen <xiaochen.shen@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        tony.luck@intel.com, fenghua.yu@intel.com,
        reinette.chatre@intel.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, pei.p.jia@intel.com,
        xiaochen.shen@intel.com
Subject: [PATCH 2/2] x86/resctrl: Initialize new resource group with default MBA values
Date:   Wed, 10 Apr 2019 16:24:28 +0800
Message-Id: <1554884668-24462-1-git-send-email-xiaochen.shen@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when a new resource group is created, the allocation values
of MBA resource are not initialized and remain meaningless data.

For example:
mkdir /sys/fs/resctrl/p1
cat /sys/fs/resctrl/p1/schemata
MB:0=100;1=100

echo "MB:0=10;1=20" > /sys/fs/resctrl/p1/schemata
cat /sys/fs/resctrl/p1/schemata
MB:0= 10;1= 20

rmdir /sys/fs/resctrl/p1
mkdir /sys/fs/resctrl/p2
cat /sys/fs/resctrl/p2/schemata
MB:0= 10;1= 20

When the new group is created, it is reasonable to initialize MBA
resource with default values.

Initialize MBA resource and cache resources in separate functions.

Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |   4 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 139 ++++++++++++++++--------------
 2 files changed, 75 insertions(+), 68 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 2dbd990..576bb6a 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -342,10 +342,10 @@ int update_domains(struct rdt_resource *r, int closid)
 	if (cpumask_empty(cpu_mask) || mba_sc)
 		goto done;
 	cpu = get_cpu();
-	/* Update CBM on this cpu if it's in cpu_mask. */
+	/* Update resource control msr on this cpu if it's in cpu_mask. */
 	if (cpumask_test_cpu(cpu, cpu_mask))
 		rdt_ctrl_update(&msr_param);
-	/* Update CBM on other cpus. */
+	/* Update resource control msr on other cpus. */
 	smp_call_function_many(cpu_mask, rdt_ctrl_update, &msr_param, 1);
 	put_cpu();
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 08e0333..9f12a02 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2516,8 +2516,8 @@ static void cbm_ensure_valid(u32 *_val, struct rdt_resource *r)
 	bitmap_clear(val, zero_bit, cbm_len - zero_bit);
 }
 
-/**
- * rdtgroup_init_alloc - Initialize the new RDT group's allocations
+/*
+ * Initialize cache resources with default values.
  *
  * A new RDT group is being created on an allocation capable (CAT)
  * supporting system. Set this group up to start off with all usable
@@ -2526,85 +2526,92 @@ static void cbm_ensure_valid(u32 *_val, struct rdt_resource *r)
  * All-zero CBM is invalid. If there are no more shareable bits available
  * on any domain then the entire allocation will fail.
  */
-static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
+static int rdtgroup_init_cat(struct rdt_resource *r, u32 closid)
 {
 	struct rdt_resource *r_cdp = NULL;
 	struct rdt_domain *d_cdp = NULL;
 	u32 used_b = 0, unused_b = 0;
-	u32 closid = rdtgrp->closid;
-	struct rdt_resource *r;
 	unsigned long tmp_cbm;
 	enum rdtgrp_mode mode;
 	struct rdt_domain *d;
 	u32 peer_ctl, *ctrl;
-	int i, ret;
+	int i;
 
-	for_each_alloc_enabled_rdt_resource(r) {
+	list_for_each_entry(d, &r->domains, list) {
+		rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp);
+		d->have_new_ctrl = false;
+		d->new_ctrl = r->cache.shareable_bits;
+		used_b = r->cache.shareable_bits;
+		ctrl = d->ctrl_val;
+		for (i = 0; i < closids_supported(); i++, ctrl++) {
+			if (closid_allocated(i) && i != closid) {
+				mode = rdtgroup_mode_by_closid(i);
+				if (mode == RDT_MODE_PSEUDO_LOCKSETUP)
+					break;
+				/*
+				 * If CDP is active include peer
+				 * domain's usage to ensure there
+				 * is no overlap with an exclusive
+				 * group.
+				 */
+				if (d_cdp)
+					peer_ctl = d_cdp->ctrl_val[i];
+				else
+					peer_ctl = 0;
+				used_b |= *ctrl | peer_ctl;
+				if (mode == RDT_MODE_SHAREABLE)
+					d->new_ctrl |= *ctrl | peer_ctl;
+			}
+		}
+		if (d->plr && d->plr->cbm > 0)
+			used_b |= d->plr->cbm;
+		unused_b = used_b ^ (BIT_MASK(r->cache.cbm_len) - 1);
+		unused_b &= BIT_MASK(r->cache.cbm_len) - 1;
+		d->new_ctrl |= unused_b;
+		cbm_ensure_valid(&d->new_ctrl, r);
 		/*
-		 * Only initialize default allocations for CBM cache
-		 * resources
+		 * Assign the u32 CBM to an unsigned long to ensure
+		 * that bitmap_weight() does not access out-of-bound
+		 * memory.
 		 */
-		if (r->rid == RDT_RESOURCE_MBA)
-			continue;
-		list_for_each_entry(d, &r->domains, list) {
-			rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp);
-			d->have_new_ctrl = false;
-			d->new_ctrl = r->cache.shareable_bits;
-			used_b = r->cache.shareable_bits;
-			ctrl = d->ctrl_val;
-			for (i = 0; i < closids_supported(); i++, ctrl++) {
-				if (closid_allocated(i) && i != closid) {
-					mode = rdtgroup_mode_by_closid(i);
-					if (mode == RDT_MODE_PSEUDO_LOCKSETUP)
-						break;
-					/*
-					 * If CDP is active include peer
-					 * domain's usage to ensure there
-					 * is no overlap with an exclusive
-					 * group.
-					 */
-					if (d_cdp)
-						peer_ctl = d_cdp->ctrl_val[i];
-					else
-						peer_ctl = 0;
-					used_b |= *ctrl | peer_ctl;
-					if (mode == RDT_MODE_SHAREABLE)
-						d->new_ctrl |= *ctrl | peer_ctl;
-				}
-			}
-			if (d->plr && d->plr->cbm > 0)
-				used_b |= d->plr->cbm;
-			unused_b = used_b ^ (BIT_MASK(r->cache.cbm_len) - 1);
-			unused_b &= BIT_MASK(r->cache.cbm_len) - 1;
-			d->new_ctrl |= unused_b;
-			/*
-			 * Force the initial CBM to be valid, user can
-			 * modify the CBM based on system availability.
-			 */
-			cbm_ensure_valid(&d->new_ctrl, r);
-			/*
-			 * Assign the u32 CBM to an unsigned long to ensure
-			 * that bitmap_weight() does not access out-of-bound
-			 * memory.
-			 */
-			tmp_cbm = d->new_ctrl;
-			if (bitmap_weight(&tmp_cbm, r->cache.cbm_len) <
-			    r->cache.min_cbm_bits) {
-				rdt_last_cmd_printf("No space on %s:%d\n",
-						    r->name, d->id);
-				return -ENOSPC;
-			}
-			d->have_new_ctrl = true;
+		tmp_cbm = d->new_ctrl;
+		if (bitmap_weight(&tmp_cbm, r->cache.cbm_len) <
+		    r->cache.min_cbm_bits) {
+			rdt_last_cmd_printf("No space on %s:%d\n",
+					    r->name, d->id);
+			return -ENOSPC;
 		}
+		d->have_new_ctrl = true;
 	}
 
+	return 0;
+}
+
+/* Initialize MBA resource with default values. */
+static void rdtgroup_init_mba(struct rdt_resource *r)
+{
+	struct rdt_domain *d;
+
+	list_for_each_entry(d, &r->domains, list) {
+		d->new_ctrl = is_mba_sc(r) ? MBA_MAX_MBPS : r->default_ctrl;
+		d->have_new_ctrl = true;
+	}
+}
+
+/* Initialize the RDT group's allocations. */
+static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
+{
+	struct rdt_resource *r;
+	int ret;
+
 	for_each_alloc_enabled_rdt_resource(r) {
-		/*
-		 * Only initialize default allocations for CBM cache
-		 * resources
-		 */
-		if (r->rid == RDT_RESOURCE_MBA)
-			continue;
+		if (r->rid == RDT_RESOURCE_MBA) {
+			rdtgroup_init_mba(r);
+		} else {
+			ret = rdtgroup_init_cat(r, rdtgrp->closid);
+			if (ret < 0)
+				return ret;
+		}
 		ret = update_domains(r, rdtgrp->closid);
 		if (ret < 0) {
 			rdt_last_cmd_puts("Failed to initialize allocations\n");
-- 
1.8.3.1

