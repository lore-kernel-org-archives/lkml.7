Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB9BC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4DCE2073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=zytor.com header.i=@zytor.com header.b="ZTGcidZR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733238AbfDQTZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 15:25:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:32997 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730037AbfDQTZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 15:25:41 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3HJPPvK4044506
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 12:25:25 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3HJPPvK4044506
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555529126;
        bh=TM1oKx9qk4qpVXLvV6gzo9mEz2XbvXLbeuAMYEGd0xQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ZTGcidZRpHpZfNsfPvU9APkhkrzOyEu0VPegSNBYumQN4Ev0LmNYU4msLepyQ6L5P
         bqGxbzOhwDdROQouD2ArOQIl50OkvMeVbdnDuDXHEJCpsANQO1eI9FQkpuuYGiJcH5
         jmXShO/ZusKSQ7tenploCats4mgV9e4noyc23MfwaPVmPZvdPSxI52ytgs+EUtYmaZ
         oLWHdRYI3n9jWyLVE1oXZai0IaryWvHJFcA6yihHwP+0jLLfjbXzWhlg+XB38Cgu88
         7JP4+GvcHpYiYG+Z2YTBZUuNRvq2A8OdA7Ioka+hiixt+PgppaiQg8/025/qRHu9dq
         KAq8oXzuJ6SHg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3HJPPUO4044502;
        Wed, 17 Apr 2019 12:25:25 -0700
Date:   Wed, 17 Apr 2019 12:25:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Xiaochen Shen <tipbot@zytor.com>
Message-ID: <tip-8cea8808525eb3a36f3d54412843948f169d6a6e@git.kernel.org>
Cc:     fenghua.yu@intel.com, mingo@kernel.org, mingo@redhat.com,
        x86@kernel.org, reinette.chatre@intel.com, tony.luck@intel.com,
        tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        bp@suse.de, xiaochen.shen@intel.com
Reply-To: mingo@redhat.com, fenghua.yu@intel.com, mingo@kernel.org,
          x86@kernel.org, reinette.chatre@intel.com, hpa@zytor.com,
          tglx@linutronix.de, tony.luck@intel.com, bp@suse.de,
          linux-kernel@vger.kernel.org, xiaochen.shen@intel.com
In-Reply-To: <1555499329-1170-2-git-send-email-xiaochen.shen@intel.com>
References: <1555499329-1170-2-git-send-email-xiaochen.shen@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/resctrl: Move per RDT domain initialization to
 a separate function
Git-Commit-ID: 8cea8808525eb3a36f3d54412843948f169d6a6e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  8cea8808525eb3a36f3d54412843948f169d6a6e
Gitweb:     https://git.kernel.org/tip/8cea8808525eb3a36f3d54412843948f169d6a6e
Author:     Xiaochen Shen <xiaochen.shen@intel.com>
AuthorDate: Wed, 17 Apr 2019 19:08:48 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 17 Apr 2019 21:03:38 +0200

x86/resctrl: Move per RDT domain initialization to a separate function

Carve out per rdt_domain initialization code from rdtgroup_init_alloc()
into a separate function.

No functional change, make the code more readable and save us at least
two indentation levels.

Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: pei.p.jia@intel.com
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/1555499329-1170-2-git-send-email-xiaochen.shen@intel.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 131 ++++++++++++++++++---------------
 1 file changed, 72 insertions(+), 59 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 399601eda8e4..2f7e35849527 100644
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
 
