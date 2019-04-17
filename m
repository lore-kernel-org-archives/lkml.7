Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD98C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 374E52064A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731916AbfDQLCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:02:39 -0400
Received: from mga11.intel.com ([192.55.52.93]:19038 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbfDQLCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:02:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Apr 2019 04:02:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,361,1549958400"; 
   d="scan'208";a="338274098"
Received: from unknown (HELO xshen14-linux.bj.intel.com) ([10.238.155.105])
  by fmsmga006.fm.intel.com with ESMTP; 17 Apr 2019 04:02:36 -0700
From:   Xiaochen Shen <xiaochen.shen@intel.com>
To:     bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        tony.luck@intel.com, fenghua.yu@intel.com,
        reinette.chatre@intel.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, pei.p.jia@intel.com,
        xiaochen.shen@intel.com
Subject: [PATCH v2 1/2] x86/resctrl: Move per RDT domain initialization to a separate function
Date:   Wed, 17 Apr 2019 19:08:48 +0800
Message-Id: <1555499329-1170-2-git-send-email-xiaochen.shen@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1555499329-1170-1-git-send-email-xiaochen.shen@intel.com>
References: <1555499329-1170-1-git-send-email-xiaochen.shen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carve out per rdt_domain initialization code in rdtgroup_init_alloc()
into a separate function.

No functional change, this preparatory patch will make the code more
readable and save us at least two indentation levels.

Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 131 ++++++++++++++++++---------------
 1 file changed, 72 insertions(+), 59 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 08e0333..9cb6a1d 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2516,28 +2516,86 @@ static void cbm_ensure_valid(u32 *_val, struct rdt_resource *r)
 	bitmap_clear(val, zero_bit, cbm_len - zero_bit);
 }
 
+/*
+ * Initialize cache resources per RDT domain
+ *
+ * Set the RDT domain up to start off with all usable allocations. That is,
+ * all shareable and unused bits. All-zero CBM is invalid.
+ */
+static int __init_one_rdt_domain(struct rdt_domain *d, struct rdt_resource *r,
+				 u32 closid)
+{
+	struct rdt_resource *r_cdp = NULL;
+	struct rdt_domain *d_cdp = NULL;
+	u32 used_b = 0, unused_b = 0;
+	unsigned long tmp_cbm;
+	enum rdtgrp_mode mode;
+	u32 peer_ctl, *ctrl;
+	int i;
+
+	rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp);
+	d->have_new_ctrl = false;
+	d->new_ctrl = r->cache.shareable_bits;
+	used_b = r->cache.shareable_bits;
+	ctrl = d->ctrl_val;
+	for (i = 0; i < closids_supported(); i++, ctrl++) {
+		if (closid_allocated(i) && i != closid) {
+			mode = rdtgroup_mode_by_closid(i);
+			if (mode == RDT_MODE_PSEUDO_LOCKSETUP)
+				break;
+			/*
+			 * If CDP is active include peer domain's
+			 * usage to ensure there is no overlap
+			 * with an exclusive group.
+			 */
+			if (d_cdp)
+				peer_ctl = d_cdp->ctrl_val[i];
+			else
+				peer_ctl = 0;
+			used_b |= *ctrl | peer_ctl;
+			if (mode == RDT_MODE_SHAREABLE)
+				d->new_ctrl |= *ctrl | peer_ctl;
+		}
+	}
+	if (d->plr && d->plr->cbm > 0)
+		used_b |= d->plr->cbm;
+	unused_b = used_b ^ (BIT_MASK(r->cache.cbm_len) - 1);
+	unused_b &= BIT_MASK(r->cache.cbm_len) - 1;
+	d->new_ctrl |= unused_b;
+	/*
+	 * Force the initial CBM to be valid, user can
+	 * modify the CBM based on system availability.
+	 */
+	cbm_ensure_valid(&d->new_ctrl, r);
+	/*
+	 * Assign the u32 CBM to an unsigned long to ensure that
+	 * bitmap_weight() does not access out-of-bound memory.
+	 */
+	tmp_cbm = d->new_ctrl;
+	if (bitmap_weight(&tmp_cbm, r->cache.cbm_len) < r->cache.min_cbm_bits) {
+		rdt_last_cmd_printf("No space on %s:%d\n", r->name, d->id);
+		return -ENOSPC;
+	}
+	d->have_new_ctrl = true;
+
+	return 0;
+}
+
 /**
  * rdtgroup_init_alloc - Initialize the new RDT group's allocations
  *
  * A new RDT group is being created on an allocation capable (CAT)
  * supporting system. Set this group up to start off with all usable
- * allocations. That is, all shareable and unused bits.
+ * allocations.
  *
- * All-zero CBM is invalid. If there are no more shareable bits available
- * on any domain then the entire allocation will fail.
+ * If there are no more shareable bits available on any domain then
+ * the entire allocation will fail.
  */
 static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 {
-	struct rdt_resource *r_cdp = NULL;
-	struct rdt_domain *d_cdp = NULL;
-	u32 used_b = 0, unused_b = 0;
-	u32 closid = rdtgrp->closid;
 	struct rdt_resource *r;
-	unsigned long tmp_cbm;
-	enum rdtgrp_mode mode;
 	struct rdt_domain *d;
-	u32 peer_ctl, *ctrl;
-	int i, ret;
+	int ret;
 
 	for_each_alloc_enabled_rdt_resource(r) {
 		/*
@@ -2547,54 +2605,9 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 		if (r->rid == RDT_RESOURCE_MBA)
 			continue;
 		list_for_each_entry(d, &r->domains, list) {
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
+			ret = __init_one_rdt_domain(d, r, rdtgrp->closid);
+			if (ret < 0)
+				return ret;
 		}
 	}
 
-- 
1.8.3.1

