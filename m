Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB81C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E08620872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="G1vAqnfZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387498AbfDQWNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 18:13:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53331 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfDQWNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 18:13:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3HMDQ7a4101467
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 15:13:26 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3HMDQ7a4101467
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555539207;
        bh=mTxY5At5zwFUiu61wwSyXV92rNLjpnNhfQHcXdR0FnY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=G1vAqnfZ2uAHsuRugMtabYbjmb02rWCzu3sw/G5BCmJgRyEreLQmkGfc6HbcWda26
         8J5PNkFOZLPLFqgHNMQUvMVD0rHFfo6IahaUWCGH1t6HcAD5rEalMx32gDkUVjdEqi
         kD8t+5XhGj4LaIeC2r/x2Ku5B0YOjGUgWqDr4h3m4UZVpqUecKum8r3gW8HZmVwh46
         3ep0SemsGrojpw1f8NMSIhfX9eJ2Yg+LrNhU4HDS3hHvStpZo1qVTJJ1GZI8XWTsA/
         qnQH+8E6hOW2xoCC72Q+7h2Dh4JXWHNuijdoCGoGRquWuTv+VVez0yp7iQSxPyEK1V
         9c0ngJtcKvvIw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3HMDQEx4101464;
        Wed, 17 Apr 2019 15:13:26 -0700
Date:   Wed, 17 Apr 2019 15:13:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Xiaochen Shen <tipbot@zytor.com>
Message-ID: <tip-7390619ab9ea9fd0ba9f4c3e4749ee20262cba7d@git.kernel.org>
Cc:     reinette.chatre@intel.com, fenghua.yu@intel.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
        bp@suse.de, mingo@redhat.com, xiaochen.shen@intel.com,
        tglx@linutronix.de, tony.luck@intel.com
Reply-To: tony.luck@intel.com, xiaochen.shen@intel.com, tglx@linutronix.de,
          bp@suse.de, mingo@redhat.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
          fenghua.yu@intel.com, reinette.chatre@intel.com
In-Reply-To: <1555499329-1170-2-git-send-email-xiaochen.shen@intel.com>
References: <1555499329-1170-2-git-send-email-xiaochen.shen@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/resctrl: Move per RDT domain initialization to
 a separate function
Git-Commit-ID: 7390619ab9ea9fd0ba9f4c3e4749ee20262cba7d
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

Commit-ID:  7390619ab9ea9fd0ba9f4c3e4749ee20262cba7d
Gitweb:     https://git.kernel.org/tip/7390619ab9ea9fd0ba9f4c3e4749ee20262cba7d
Author:     Xiaochen Shen <xiaochen.shen@intel.com>
AuthorDate: Wed, 17 Apr 2019 19:08:48 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 17 Apr 2019 23:59:56 +0200

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
index 85212a32b54d..36ace51ee705 100644
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
 
