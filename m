Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846B1C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61ED721726
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfFZRvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 13:51:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:49814 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfFZRvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 13:51:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 10:51:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,420,1557212400"; 
   d="scan'208";a="337288597"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga005.jf.intel.com with ESMTP; 26 Jun 2019 10:51:08 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH 06/10] x86/resctrl: Introduce utility to return pseudo-locked cache portion
Date:   Wed, 26 Jun 2019 10:48:45 -0700
Message-Id: <f64478fab77211c05df848658ad523ce942ce3b1.1561569068.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <cover.1561569068.git.reinette.chatre@intel.com>
References: <cover.1561569068.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1561569068.git.reinette.chatre@intel.com>
References: <cover.1561569068.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prevent eviction of pseudo-locked memory it is required that no
other resource group uses any portion of a cache that is in use by
a cache pseudo-locked region.

Introduce a utility that will return a Capacity BitMask (CBM) indicating
all portions of a provided cache instance being used for cache
pseudo-locking. This CBM can be used in overlap checking as well as
cache usage reporting.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h    |  1 +
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 65f558a2e806..f17633cf4776 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -568,6 +568,7 @@ int rdtgroup_tasks_assigned(struct rdtgroup *r);
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
 int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp);
 bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_domain *d, unsigned long cbm);
+u32 rdtgroup_pseudo_locked_bits(struct rdt_resource *r, struct rdt_domain *d);
 bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d);
 int rdt_pseudo_lock_init(void);
 void rdt_pseudo_lock_release(void);
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 3ad0c5b59d34..9a4dbdb72d3e 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -1630,3 +1630,26 @@ void rdt_pseudo_lock_release(void)
 	unregister_chrdev(pseudo_lock_major, "pseudo_lock");
 	pseudo_lock_major = 0;
 }
+
+/**
+ * rdt_pseudo_locked_bits - Portions of cache instance used for pseudo-locking
+ * @r:		RDT resource to which cache instance belongs
+ * @d:		Cache instance
+ *
+ * Return: bits in CBM of @d that are used for cache pseudo-locking
+ */
+u32 rdtgroup_pseudo_locked_bits(struct rdt_resource *r, struct rdt_domain *d)
+{
+	struct rdtgroup *rdtgrp;
+	u32 pseudo_locked = 0;
+
+	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
+		if (!rdtgrp->plr)
+			continue;
+		if (rdtgrp->plr->r && rdtgrp->plr->r->rid == r->rid &&
+		    rdtgrp->plr->d_id == d->id)
+			pseudo_locked |= rdtgrp->plr->cbm;
+	}
+
+	return pseudo_locked;
+}
-- 
2.17.2

