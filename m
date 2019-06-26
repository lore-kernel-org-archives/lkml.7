Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AE5C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F16216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfFZRv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 13:51:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:49817 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbfFZRvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 13:51:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 10:51:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,420,1557212400"; 
   d="scan'208";a="337288610"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga005.jf.intel.com with ESMTP; 26 Jun 2019 10:51:08 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH 10/10] x86/resctrl: Only pseudo-lock L3 cache when inclusive
Date:   Wed, 26 Jun 2019 10:48:49 -0700
Message-Id: <1e53b953147bca171814305ff764931d71eec09a.1561569068.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <cover.1561569068.git.reinette.chatre@intel.com>
References: <cover.1561569068.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1561569068.git.reinette.chatre@intel.com>
References: <cover.1561569068.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cache pseudo-locking is a model specific feature and platforms
supporting this feature are added by adding the x86 model data to the
source code after cache pseudo-locking has been validated for the
particular platform.

Indicating support for cache pseudo-locking for an entire platform is
sufficient when the cache characteristics of the platform is the same
for all instances of the platform. If this is not the case then an
additional check needs to be added. In particular, it is currently only
possible to pseudo-lock an L3 cache region if the L3 cache is inclusive
of lower level caches. If the L3 cache is not inclusive then any
pseudo-locked data would be evicted from the pseudo-locked region when
it is moved to the L2 cache.

When some SKUs of a platform may have inclusive cache while other SKUs
may have non inclusive cache it is necessary to, in addition of checking
if the platform supports cache pseudo-locking, also check if the cache
being pseudo-locked is inclusive.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 35 +++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 4e47ad582db6..e79f555d5226 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -125,6 +125,30 @@ static unsigned int get_cache_line_size(unsigned int cpu, int level)
 	return 0;
 }
 
+/**
+ * get_cache_inclusive - Determine if cache is inclusive of lower levels
+ * @cpu: CPU with which cache is associated
+ * @level: Cache level
+ *
+ * Context: @cpu has to be online.
+ * Return: 1 if cache is inclusive of lower cache levels, 0 if cache is not
+ *         inclusive of lower cache levels or on failure.
+ */
+static unsigned int get_cache_inclusive(unsigned int cpu, int level)
+{
+	struct cpu_cacheinfo *ci;
+	int i;
+
+	ci = get_cpu_cacheinfo(cpu);
+
+	for (i = 0; i < ci->num_leaves; i++) {
+		if (ci->info_list[i].level == level)
+			return ci->info_list[i].inclusive;
+	}
+
+	return 0;
+}
+
 /**
  * pseudo_lock_minor_get - Obtain available minor number
  * @minor: Pointer to where new minor number will be stored
@@ -317,6 +341,12 @@ static int pseudo_lock_single_portion_valid(struct pseudo_lock_region *plr,
 		goto err_cpu;
 	}
 
+	if (p->r->cache_level == 3 &&
+	    !get_cache_inclusive(plr->cpu, p->r->cache_level)) {
+		rdt_last_cmd_puts("L3 cache not inclusive\n");
+		goto err_cpu;
+	}
+
 	plr->line_size = get_cache_line_size(plr->cpu, p->r->cache_level);
 	if (plr->line_size == 0) {
 		rdt_last_cmd_puts("Unable to compute cache line length\n");
@@ -418,6 +448,11 @@ static int pseudo_lock_l2_l3_portions_valid(struct pseudo_lock_region *plr,
 		goto err_cpu;
 	}
 
+	if (!get_cache_inclusive(plr->cpu, l3_p->r->cache_level)) {
+		rdt_last_cmd_puts("L3 cache not inclusive\n");
+		goto err_cpu;
+	}
+
 	return 0;
 
 err_cpu:
-- 
2.17.2

