Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD03C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D5F218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbfC2VoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:44:02 -0400
Received: from mga07.intel.com ([134.134.136.100]:47273 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729939AbfC2VoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 17:44:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2019 14:44:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,286,1549958400"; 
   d="scan'208";a="129880532"
Received: from unknown (HELO xshen14-linux.bj.intel.com) ([10.238.155.105])
  by orsmga008.jf.intel.com with ESMTP; 29 Mar 2019 14:43:59 -0700
From:   Xiaochen Shen <xiaochen.shen@intel.com>
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        tony.luck@intel.com, fenghua.yu@intel.com,
        reinette.chatre@intel.com
Cc:     dhowells@redhat.com, pei.p.jia@intel.com, xiaochen.shen@intel.com
Subject: [PATCH] x86/resctrl: Fix typos in mba_sc mount option
Date:   Sat, 30 Mar 2019 05:50:38 +0800
Message-Id: <1553896238-22130-1-git-send-email-xiaochen.shen@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With mount option "mba_MBps", we could enable MBA Software Controller
(mba_sc) to specify MBA memory bandwidth in unit MBps (Mega Bytes per
second). See details in Documentation/x86/resctrl_ui.txt.

Commit 23bf1b6be9c2 ("kernfs, sysfs, cgroup, intel_rdt: Support
fs_context") changes the mount option from "mba_MBps" to "mba_mpbs" by
mistake.

Change back from "mba_mpbs" to "mba_MBps", and rename Opt_mba_mpbs to
Opt_mba_mbps.

Fixes: 23bf1b6be9c2 ("kernfs, sysfs, cgroup, intel_rdt: Support fs_context")
Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 399601e..54b9eef 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2039,14 +2039,14 @@ static int rdt_get_tree(struct fs_context *fc)
 enum rdt_param {
 	Opt_cdp,
 	Opt_cdpl2,
-	Opt_mba_mpbs,
+	Opt_mba_mbps,
 	nr__rdt_params
 };
 
 static const struct fs_parameter_spec rdt_param_specs[] = {
 	fsparam_flag("cdp",		Opt_cdp),
 	fsparam_flag("cdpl2",		Opt_cdpl2),
-	fsparam_flag("mba_mpbs",	Opt_mba_mpbs),
+	fsparam_flag("mba_MBps",	Opt_mba_mbps),
 	{}
 };
 
@@ -2072,7 +2072,7 @@ static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	case Opt_cdpl2:
 		ctx->enable_cdpl2 = true;
 		return 0;
-	case Opt_mba_mpbs:
+	case Opt_mba_mbps:
 		if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 			return -EINVAL;
 		ctx->enable_mba_mbps = true;
-- 
1.8.3.1

