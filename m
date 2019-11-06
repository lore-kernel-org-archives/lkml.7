Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33199C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D06217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732472AbfKFWEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:04:10 -0500
Received: from mga12.intel.com ([192.55.52.136]:17526 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbfKFWEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 17:04:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 14:04:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="205969023"
Received: from xshen14-linux.bj.intel.com ([10.238.155.105])
  by orsmga006.jf.intel.com with ESMTP; 06 Nov 2019 14:04:07 -0800
From:   Xiaochen Shen <xiaochen.shen@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        tony.luck@intel.com, fenghua.yu@intel.com,
        reinette.chatre@intel.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, pei.p.jia@intel.com,
        xiaochen.shen@intel.com
Subject: [PATCH] x86/resctrl: Fix potential lockdep warning
Date:   Thu,  7 Nov 2019 06:36:36 +0800
Message-Id: <1573079796-11713-1-git-send-email-xiaochen.shen@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rdtgroup_cpus_write() and mkdir_rdt_prepare() call
rdtgroup_kn_lock_live() -> kernfs_to_rdtgroup() to get 'rdtgrp', and
then call rdt_last_cmd_xxx() functions which will check if
rdtgroup_mutex is held/requires its caller to hold rdtgroup_mutex.
But if 'rdtgrp' returned from kernfs_to_rdtgroup() is NULL,
rdtgroup_mutex is not held and calling rdt_last_cmd_xxx() will result
in a lockdep warning.

Remove rdt_last_cmd_xxx() in these two paths. Just returning error
should be sufficient to report to the user that the entry doesn't exist
any more.

Fixes: 94457b36e8a5 ("x86/intel_rdt: Add diagnostics when writing the cpus file")
Fixes: cfd0f34e4cd5 ("x86/intel_rdt: Add diagnostics when making directories")
Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index a46dee8e78db..2e3b06d6bbc6 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -461,10 +461,8 @@ static ssize_t rdtgroup_cpus_write(struct kernfs_open_file *of,
 	}
 
 	rdtgrp = rdtgroup_kn_lock_live(of->kn);
-	rdt_last_cmd_clear();
 	if (!rdtgrp) {
 		ret = -ENOENT;
-		rdt_last_cmd_puts("Directory was removed\n");
 		goto unlock;
 	}
 
@@ -2648,10 +2646,8 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 	int ret;
 
 	prdtgrp = rdtgroup_kn_lock_live(prgrp_kn);
-	rdt_last_cmd_clear();
 	if (!prdtgrp) {
 		ret = -ENODEV;
-		rdt_last_cmd_puts("Directory was removed\n");
 		goto out_unlock;
 	}
 
-- 
1.8.3.1

