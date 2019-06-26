Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AD1C48BDA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A11A21743
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfFZRvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 13:51:17 -0400
Received: from mga01.intel.com ([192.55.52.88]:49814 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbfFZRvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 13:51:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 10:51:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,420,1557212400"; 
   d="scan'208";a="337288591"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga005.jf.intel.com with ESMTP; 26 Jun 2019 10:51:08 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH 04/10] x86/resctrl: Set cache line size using new utility
Date:   Wed, 26 Jun 2019 10:48:43 -0700
Message-Id: <4f97fcb9c4bd36d5378b6bf3c67710dcf2b53be3.1561569068.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <cover.1561569068.git.reinette.chatre@intel.com>
References: <cover.1561569068.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1561569068.git.reinette.chatre@intel.com>
References: <cover.1561569068.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for support of pseudo-locked regions spanning two
cache levels the cache line size computation is moved to a utility.

Setting of the cache line size is moved a few lines earlier, before
the C-states are constrained, to reduce the amount of cleanup needed
on failure.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 42 +++++++++++++++++------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 519057b6741f..3d73b08871cc 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -101,6 +101,30 @@ static u64 get_prefetch_disable_bits(void)
 	return 0;
 }
 
+/**
+ * get_cache_line_size - Determine the cache coherency line size
+ * @cpu: CPU with which cache is associated
+ * @level: Cache level
+ *
+ * Context: @cpu has to be online.
+ * Return: The cache coherency line size for cache level @level associated
+ * with CPU @cpu. Zero on failure.
+ */
+static unsigned int get_cache_line_size(unsigned int cpu, int level)
+{
+	struct cpu_cacheinfo *ci;
+	int i;
+
+	ci = get_cpu_cacheinfo(cpu);
+
+	for (i = 0; i < ci->num_leaves; i++) {
+		if (ci->info_list[i].level == level)
+			return ci->info_list[i].coherency_line_size;
+	}
+
+	return 0;
+}
+
 /**
  * pseudo_lock_minor_get - Obtain available minor number
  * @minor: Pointer to where new minor number will be stored
@@ -281,9 +305,7 @@ static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
  */
 static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
 {
-	struct cpu_cacheinfo *ci;
 	int ret;
-	int i;
 
 	/* Pick the first cpu we find that is associated with the cache. */
 	plr->cpu = cpumask_first(&plr->d->cpu_mask);
@@ -295,7 +317,12 @@ static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
 		goto out_region;
 	}
 
-	ci = get_cpu_cacheinfo(plr->cpu);
+	plr->line_size = get_cache_line_size(plr->cpu, plr->r->cache_level);
+	if (plr->line_size == 0) {
+		rdt_last_cmd_puts("Unable to determine cache line size\n");
+		ret = -1;
+		goto out_region;
+	}
 
 	plr->size = rdtgroup_cbm_to_size(plr->r, plr->d, plr->cbm);
 
@@ -303,15 +330,8 @@ static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
 	if (ret < 0)
 		goto out_region;
 
-	for (i = 0; i < ci->num_leaves; i++) {
-		if (ci->info_list[i].level == plr->r->cache_level) {
-			plr->line_size = ci->info_list[i].coherency_line_size;
-			return 0;
-		}
-	}
+	return 0;
 
-	ret = -1;
-	rdt_last_cmd_puts("Unable to determine cache line size\n");
 out_region:
 	pseudo_lock_region_clear(plr);
 	return ret;
-- 
2.17.2

