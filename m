Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C953DC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A30B62064A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731940AbfDQLCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:02:44 -0400
Received: from mga11.intel.com ([192.55.52.93]:19038 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731919AbfDQLCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:02:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Apr 2019 04:02:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,361,1549958400"; 
   d="scan'208";a="338274121"
Received: from unknown (HELO xshen14-linux.bj.intel.com) ([10.238.155.105])
  by fmsmga006.fm.intel.com with ESMTP; 17 Apr 2019 04:02:40 -0700
From:   Xiaochen Shen <xiaochen.shen@intel.com>
To:     bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        tony.luck@intel.com, fenghua.yu@intel.com,
        reinette.chatre@intel.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, pei.p.jia@intel.com,
        xiaochen.shen@intel.com
Subject: [PATCH v2 2/2] x86/resctrl: Initialize a new resource group with default MBA values
Date:   Wed, 17 Apr 2019 19:08:49 +0800
Message-Id: <1555499329-1170-3-git-send-email-xiaochen.shen@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1555499329-1170-1-git-send-email-xiaochen.shen@intel.com>
References: <1555499329-1170-1-git-send-email-xiaochen.shen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when a new resource group is created, the allocation values
of the MBA resource are not initialized and remain meaningless data.

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

Therefore, when the new group is created, it is reasonable to initialize
MBA resource with default values.

Initialize the MBA resource and cache resources in separate functions.

Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  4 +--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 52 +++++++++++++++++++------------
 2 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 2dbd990..89320c0 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -342,10 +342,10 @@ int update_domains(struct rdt_resource *r, int closid)
 	if (cpumask_empty(cpu_mask) || mba_sc)
 		goto done;
 	cpu = get_cpu();
-	/* Update CBM on this cpu if it's in cpu_mask. */
+	/* Update resource control msr on this CPU if it's in cpu_mask. */
 	if (cpumask_test_cpu(cpu, cpu_mask))
 		rdt_ctrl_update(&msr_param);
-	/* Update CBM on other cpus. */
+	/* Update resource control msr on other CPUs. */
 	smp_call_function_many(cpu_mask, rdt_ctrl_update, &msr_param, 1);
 	put_cpu();
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 9cb6a1d..44b6dbf 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2581,8 +2581,8 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct rdt_resource *r,
 	return 0;
 }
 
-/**
- * rdtgroup_init_alloc - Initialize the new RDT group's allocations
+/*
+ * Initialize cache resources with default values.
  *
  * A new RDT group is being created on an allocation capable (CAT)
  * supporting system. Set this group up to start off with all usable
@@ -2591,33 +2591,45 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct rdt_resource *r,
  * If there are no more shareable bits available on any domain then
  * the entire allocation will fail.
  */
+static int rdtgroup_init_cat(struct rdt_resource *r, u32 closid)
+{
+	struct rdt_domain *d;
+	int ret;
+
+	list_for_each_entry(d, &r->domains, list) {
+		ret = __init_one_rdt_domain(d, r, closid);
+		if (ret < 0)
+			return ret;
+	}
+
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
 static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 {
 	struct rdt_resource *r;
-	struct rdt_domain *d;
 	int ret;
 
 	for_each_alloc_enabled_rdt_resource(r) {
-		/*
-		 * Only initialize default allocations for CBM cache
-		 * resources
-		 */
-		if (r->rid == RDT_RESOURCE_MBA)
-			continue;
-		list_for_each_entry(d, &r->domains, list) {
-			ret = __init_one_rdt_domain(d, r, rdtgrp->closid);
+		if (r->rid == RDT_RESOURCE_MBA) {
+			rdtgroup_init_mba(r);
+		} else {
+			ret = rdtgroup_init_cat(r, rdtgrp->closid);
 			if (ret < 0)
 				return ret;
 		}
-	}
-
-	for_each_alloc_enabled_rdt_resource(r) {
-		/*
-		 * Only initialize default allocations for CBM cache
-		 * resources
-		 */
-		if (r->rid == RDT_RESOURCE_MBA)
-			continue;
 		ret = update_domains(r, rdtgrp->closid);
 		if (ret < 0) {
 			rdt_last_cmd_puts("Failed to initialize allocations\n");
-- 
1.8.3.1

