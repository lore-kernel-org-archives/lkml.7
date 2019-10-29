Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9B0CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 04:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B922086A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 04:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731782AbfJ2Ews (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 00:52:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:11232 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728193AbfJ2Ewr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 00:52:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 21:52:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,242,1569308400"; 
   d="scan'208";a="224851624"
Received: from xshen14-linux.bj.intel.com ([10.238.155.181])
  by fmsmga004.fm.intel.com with ESMTP; 28 Oct 2019 21:52:45 -0700
From:   Xiaochen Shen <xiaochen.shen@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        tony.luck@intel.com, fenghua.yu@intel.com,
        reinette.chatre@intel.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, pei.p.jia@intel.com,
        xiaochen.shen@intel.com
Subject: [PATCH] x86/resctrl: Prevent NULL pointer dereference when reading mondata
Date:   Tue, 29 Oct 2019 13:25:02 +0800
Message-Id: <1572326702-27577-1-git-send-email-xiaochen.shen@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a mon group is being deleted, rdtgrp->flags is set to RDT_DELETED
in rdtgroup_rmdir_mon() firstly. The structure of rdtgrp will be freed
until rdtgrp->waitcount is dropped to 0 in rdtgroup_kn_unlock() later.

During the window of deleting a mon group, if an application calls
rdtgroup_mondata_show() to read mondata under this mon group,
'rdtgrp' returned from rdtgroup_kn_lock_live() is a NULL pointer when
rdtgrp->flags is RDT_DELETED. And then 'rdtgrp' is passed in this path:
rdtgroup_mondata_show() --> mon_event_read() --> mon_event_count().
Thus it results in NULL pointer dereference in mon_event_count().

Add checking of 'rdtgrp' in rdtgroup_mondata_show(), and return -ENOENT
immediately when reading mondata during the window of deleting a mon
group.

Fixes: d89b7379015f ("x86/intel_rdt/cqm: Add mon_data")
Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index efbd54cc4e69..055c8613b531 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -522,6 +522,10 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	int ret = 0;
 
 	rdtgrp = rdtgroup_kn_lock_live(of->kn);
+	if (!rdtgrp) {
+		ret = -ENOENT;
+		goto out;
+	}
 
 	md.priv = of->kn->priv;
 	resid = md.u.rid;
-- 
1.8.3.1

