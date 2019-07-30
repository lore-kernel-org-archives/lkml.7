Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A279C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDE920693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731107AbfG3RcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:32:19 -0400
Received: from mga01.intel.com ([192.55.52.88]:35743 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731027AbfG3RcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:32:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2019 10:32:10 -0700
X-IronPort-AV: E=Sophos;i="5.64,327,1559545200"; 
   d="scan'208";a="162655290"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2019 10:32:10 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     kuo-lang.tseng@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V2 07/10] x86/resctrl: Remove unnecessary pointer to pseudo-locked region
Date:   Tue, 30 Jul 2019 10:29:41 -0700
Message-Id: <2930ec284cccc21dd2f265cd15aa591442e80431.1564504901.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <cover.1564504901.git.reinette.chatre@intel.com>
References: <cover.1564504901.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1564504901.git.reinette.chatre@intel.com>
References: <cover.1564504901.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each cache domain (struct rdt_domain) contains a pointer to a
pseudo-locked region that (if set) is associated with it. At the
same time each resource group (struct rdtgroup) also contains a
pointer to a pseudo-locked region that (if set) is associated with
it.

If a pointer from a cache domain to its pseudo-locked region is
maintained then multiple cache domains could point to a single
pseudo-locked region when a pseudo-locked region spans multiple
resources. Such an arrangement would make it harder to support the
current mechanism of iterating over cache domains in order to find all
pseudo-locked regions.

In preparation for pseudo-locked regions that could span multiple
resources the pointer from a cache domain to a pseudo-locked region is
removed. The pointer to a pseudo-locked region from a resource
group remains - when needing to process all pseudo-locked regions on the
system an iteration over all resource groups is used instead of an
iteration over all cache domains.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  3 +-
 arch/x86/kernel/cpu/resctrl/internal.h    |  6 +--
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 46 +++++++++++------------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  8 ++--
 4 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 072f584cb238..a0383ff80afe 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -217,7 +217,7 @@ int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
 
 	if ((rdtgrp->mode == RDT_MODE_EXCLUSIVE ||
 	     rdtgrp->mode == RDT_MODE_SHAREABLE) &&
-	    rdtgroup_cbm_overlaps_pseudo_locked(d, cbm_val)) {
+	    rdtgroup_cbm_overlaps_pseudo_locked(r, d, cbm_val)) {
 		rdt_last_cmd_puts("CBM overlaps with pseudo-locked region\n");
 		return -EINVAL;
 	}
@@ -293,7 +293,6 @@ static int parse_line(char *line, struct rdt_resource *r,
 				rdtgrp->plr->r = r;
 				rdtgrp->plr->d_id = d->id;
 				rdtgrp->plr->cbm = d->new_ctrl;
-				d->plr = rdtgrp->plr;
 				return 0;
 			}
 			goto next;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index f17633cf4776..892f38899dda 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -309,7 +309,6 @@ struct mbm_state {
  * @mbps_val:	When mba_sc is enabled, this holds the bandwidth in MBps
  * @new_ctrl:	new ctrl value to be loaded
  * @have_new_ctrl: did user provide new_ctrl for this domain
- * @plr:	pseudo-locked region (if any) associated with domain
  */
 struct rdt_domain {
 	struct list_head		list;
@@ -326,7 +325,6 @@ struct rdt_domain {
 	u32				*mbps_val;
 	u32				new_ctrl;
 	bool				have_new_ctrl;
-	struct pseudo_lock_region	*plr;
 };
 
 /**
@@ -567,7 +565,9 @@ enum rdtgrp_mode rdtgroup_mode_by_closid(int closid);
 int rdtgroup_tasks_assigned(struct rdtgroup *r);
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
 int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp);
-bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_domain *d, unsigned long cbm);
+bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_resource *r,
+					 struct rdt_domain *d,
+					 unsigned long cbm);
 u32 rdtgroup_pseudo_locked_bits(struct rdt_resource *r, struct rdt_domain *d);
 bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d);
 int rdt_pseudo_lock_init(void);
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index f16702a076a3..733cb7f34948 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -272,17 +272,10 @@ static int pseudo_lock_cstates_constrain(struct pseudo_lock_region *plr,
  */
 static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
 {
-	struct rdt_domain *d;
-
 	plr->size = 0;
 	plr->line_size = 0;
 	kfree(plr->kmem);
 	plr->kmem = NULL;
-	if (plr->r && plr->d_id >= 0) {
-		d = rdt_find_domain(plr->r, plr->d_id, NULL);
-		if (!IS_ERR_OR_NULL(d))
-			d->plr = NULL;
-	}
 	plr->r = NULL;
 	plr->d_id = -1;
 	plr->cbm = 0;
@@ -822,6 +815,7 @@ int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp)
 
 /**
  * rdtgroup_cbm_overlaps_pseudo_locked - Test if CBM or portion is pseudo-locked
+ * @r: RDT resource to which @d belongs
  * @d: RDT domain
  * @cbm: CBM to test
  *
@@ -835,17 +829,17 @@ int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp)
  * Return: true if @cbm overlaps with pseudo-locked region on @d, false
  * otherwise.
  */
-bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_domain *d, unsigned long cbm)
+bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_resource *r,
+					 struct rdt_domain *d,
+					 unsigned long cbm)
 {
+	unsigned long pseudo_locked;
 	unsigned int cbm_len;
-	unsigned long cbm_b;
 
-	if (d->plr) {
-		cbm_len = d->plr->r->cache.cbm_len;
-		cbm_b = d->plr->cbm;
-		if (bitmap_intersects(&cbm, &cbm_b, cbm_len))
-			return true;
-	}
+	pseudo_locked = rdtgroup_pseudo_locked_bits(r, d);
+	cbm_len = r->cache.cbm_len;
+	if (bitmap_intersects(&cbm, &pseudo_locked, cbm_len))
+		return true;
 	return false;
 }
 
@@ -859,13 +853,13 @@ bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_domain *d, unsigned long cbm
  * attempts to create new pseudo-locked regions in the same hierarchy.
  *
  * Return: true if a pseudo-locked region exists in the hierarchy of @d or
- *         if it is not possible to test due to memory allocation issue,
- *         false otherwise.
+ *         if it is not possible to test due to memory allocation or other
+ *         failure, false otherwise.
  */
 bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
 {
 	cpumask_var_t cpu_with_psl;
-	struct rdt_resource *r;
+	struct rdtgroup *rdtgrp;
 	struct rdt_domain *d_i;
 	bool ret = false;
 
@@ -876,11 +870,16 @@ bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
 	 * First determine which cpus have pseudo-locked regions
 	 * associated with them.
 	 */
-	for_each_alloc_enabled_rdt_resource(r) {
-		list_for_each_entry(d_i, &r->domains, list) {
-			if (d_i->plr)
-				cpumask_or(cpu_with_psl, cpu_with_psl,
-					   &d_i->cpu_mask);
+	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
+		if (rdtgrp->plr && rdtgrp->plr->d_id >= 0) {
+			d_i = rdt_find_domain(rdtgrp->plr->r, rdtgrp->plr->d_id,
+					      NULL);
+			if (IS_ERR_OR_NULL(d_i)) {
+				ret = true;
+				goto out;
+			}
+			cpumask_or(cpu_with_psl, cpu_with_psl,
+				   &d_i->cpu_mask);
 		}
 	}
 
@@ -891,6 +890,7 @@ bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
 	if (cpumask_intersects(&d->cpu_mask, cpu_with_psl))
 		ret = true;
 
+out:
 	free_cpumask_var(cpu_with_psl);
 	return ret;
 }
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index c4bf6ed8b031..0c1786f09963 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -845,8 +845,10 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 				break;
 			}
 		}
+
+		pseudo_locked = rdtgroup_pseudo_locked_bits(r, dom);
+
 		for (i = r->cache.cbm_len - 1; i >= 0; i--) {
-			pseudo_locked = dom->plr ? dom->plr->cbm : 0;
 			hwb = test_bit(i, &hw_shareable);
 			swb = test_bit(i, &sw_shareable);
 			excl = test_bit(i, &exclusive);
@@ -2541,8 +2543,8 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct rdt_resource *r,
 				d->new_ctrl |= *ctrl | peer_ctl;
 		}
 	}
-	if (d->plr && d->plr->cbm > 0)
-		used_b |= d->plr->cbm;
+
+	used_b |= rdtgroup_pseudo_locked_bits(r, d);
 	unused_b = used_b ^ (BIT_MASK(r->cache.cbm_len) - 1);
 	unused_b &= BIT_MASK(r->cache.cbm_len) - 1;
 	d->new_ctrl |= unused_b;
-- 
2.17.2

