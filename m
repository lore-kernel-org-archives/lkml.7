Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB000C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 20:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C775520732
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 20:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfKOUfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 15:35:25 -0500
Received: from mga12.intel.com ([192.55.52.136]:52619 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbfKOUfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 15:35:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 12:35:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,309,1569308400"; 
   d="scan'208";a="406784562"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga006.fm.intel.com with ESMTP; 15 Nov 2019 12:35:24 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        prarit@redhat.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] tools/power/x86/intel-speed-select: Ignore missing config level
Date:   Fri, 15 Nov 2019 12:35:22 -0800
Message-Id: <20191115203522.54170-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible that certain config levels are not available, even
if the max level includes the level. There can be missing levels in
some platforms. So ignore the level when called for information dump
for all levels and fail if specifically ask for the missing level.

Here the changes is to continue reading information about other levels
even if we fail to get information for the current level. But use the
"processed" flag to indicate the failure. When the "processed" flag is
not set, don't dump information about that level.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 tools/power/x86/intel-speed-select/isst-core.c    | 8 ++++----
 tools/power/x86/intel-speed-select/isst-display.c | 3 ++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-core.c b/tools/power/x86/intel-speed-select/isst-core.c
index 52698553de92..aa19c9998e6c 100644
--- a/tools/power/x86/intel-speed-select/isst-core.c
+++ b/tools/power/x86/intel-speed-select/isst-core.c
@@ -646,7 +646,6 @@ int isst_get_process_ctdp(int cpu, int tdp_level, struct isst_pkg_ctdp *pkg_dev)
 			     i);
 		ctdp_level = &pkg_dev->ctdp_level[i];
 
-		ctdp_level->processed = 1;
 		ctdp_level->level = i;
 		ctdp_level->control_cpu = cpu;
 		ctdp_level->pkg_id = get_physical_package_id(cpu);
@@ -654,7 +653,10 @@ int isst_get_process_ctdp(int cpu, int tdp_level, struct isst_pkg_ctdp *pkg_dev)
 
 		ret = isst_get_ctdp_control(cpu, i, ctdp_level);
 		if (ret)
-			return ret;
+			continue;
+
+		pkg_dev->processed = 1;
+		ctdp_level->processed = 1;
 
 		if (ctdp_level->pbf_support) {
 			ret = isst_get_pbf_info(cpu, i, &ctdp_level->pbf_info);
@@ -724,8 +726,6 @@ int isst_get_process_ctdp(int cpu, int tdp_level, struct isst_pkg_ctdp *pkg_dev)
 		isst_get_uncore_mem_freq(cpu, i, ctdp_level);
 	}
 
-	pkg_dev->processed = 1;
-
 	return 0;
 }
 
diff --git a/tools/power/x86/intel-speed-select/isst-display.c b/tools/power/x86/intel-speed-select/isst-display.c
index c976bfe9b503..040dd09d5eee 100644
--- a/tools/power/x86/intel-speed-select/isst-display.c
+++ b/tools/power/x86/intel-speed-select/isst-display.c
@@ -315,7 +315,8 @@ void isst_ctdp_display_information(int cpu, FILE *outf, int tdp_level,
 	char value[256];
 	int i, base_level = 1;
 
-	print_package_info(cpu, outf);
+	if (pkg_dev->processed)
+		print_package_info(cpu, outf);
 
 	for (i = 0; i <= pkg_dev->levels; ++i) {
 		struct isst_pkg_ctdp_level_info *ctdp_level;
-- 
2.17.2

