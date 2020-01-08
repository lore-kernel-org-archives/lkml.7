Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22538C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 031C52070E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgAHP7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:59:34 -0500
Received: from mga11.intel.com ([192.55.52.93]:64327 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbgAHP7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:59:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 07:59:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="395782729"
Received: from xshen14-linux.bj.intel.com ([10.238.155.105])
  by orsmga005.jf.intel.com with ESMTP; 08 Jan 2020 07:59:29 -0800
From:   Xiaochen Shen <xiaochen.shen@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        tony.luck@intel.com, fenghua.yu@intel.com,
        reinette.chatre@intel.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, pei.p.jia@intel.com,
        xiaochen.shen@intel.com
Subject: [PATCH 4/4] x86/resctrl: Clean up unused function parameter in mkdir path
Date:   Thu,  9 Jan 2020 00:28:06 +0800
Message-Id: <1578500886-21771-5-git-send-email-xiaochen.shen@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578500886-21771-1-git-send-email-xiaochen.shen@intel.com>
References: <1578500886-21771-1-git-send-email-xiaochen.shen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous patch ("x86/resctrl: Fix a deadlock due to inaccurate
active reference of kernfs node") changed the argument to
rdtgroup_kn_lock_live()/rdtgroup_kn_unlock() within mkdir_rdt_prepare().
That change resulted in an unused function parameter to
mkdir_rdt_prepare().

Clean up unused function parameter in mkdir_rdt_prepare() and its
callers rdtgroup_mkdir_mon() and rdtgroup_mkdir_ctrl_mon().

Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 2c79fcd83271..8ebef16e10be 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2648,7 +2648,6 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 }
 
 static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
-			     struct kernfs_node *prgrp_kn,
 			     const char *name, umode_t mode,
 			     enum rdt_group_type rtype, struct rdtgroup **r)
 {
@@ -2758,15 +2757,12 @@ static void mkdir_rdt_prepare_clean(struct rdtgroup *rgrp)
  * to monitor a subset of tasks and cpus in its parent ctrl_mon group.
  */
 static int rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
-			      struct kernfs_node *prgrp_kn,
-			      const char *name,
-			      umode_t mode)
+			      const char *name, umode_t mode)
 {
 	struct rdtgroup *rdtgrp, *prgrp;
 	int ret;
 
-	ret = mkdir_rdt_prepare(parent_kn, prgrp_kn, name, mode, RDTMON_GROUP,
-				&rdtgrp);
+	ret = mkdir_rdt_prepare(parent_kn, name, mode, RDTMON_GROUP, &rdtgrp);
 	if (ret)
 		return ret;
 
@@ -2788,7 +2784,6 @@ static int rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
  * to allocate and monitor resources.
  */
 static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
-				   struct kernfs_node *prgrp_kn,
 				   const char *name, umode_t mode)
 {
 	struct rdtgroup *rdtgrp;
@@ -2796,8 +2791,7 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
 	u32 closid;
 	int ret;
 
-	ret = mkdir_rdt_prepare(parent_kn, prgrp_kn, name, mode, RDTCTRL_GROUP,
-				&rdtgrp);
+	ret = mkdir_rdt_prepare(parent_kn, name, mode, RDTCTRL_GROUP, &rdtgrp);
 	if (ret)
 		return ret;
 
@@ -2871,14 +2865,14 @@ static int rdtgroup_mkdir(struct kernfs_node *parent_kn, const char *name,
 	 * subdirectory
 	 */
 	if (rdt_alloc_capable && parent_kn == rdtgroup_default.kn)
-		return rdtgroup_mkdir_ctrl_mon(parent_kn, parent_kn, name, mode);
+		return rdtgroup_mkdir_ctrl_mon(parent_kn, name, mode);
 
 	/*
 	 * If RDT monitoring is supported and the parent directory is a valid
 	 * "mon_groups" directory, add a monitoring subdirectory.
 	 */
 	if (rdt_mon_capable && is_mon_groups(parent_kn, name))
-		return rdtgroup_mkdir_mon(parent_kn, parent_kn->parent, name, mode);
+		return rdtgroup_mkdir_mon(parent_kn, name, mode);
 
 	return -EPERM;
 }
-- 
1.8.3.1

