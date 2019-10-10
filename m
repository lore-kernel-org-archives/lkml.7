Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0C2C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087E220650
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfJJUaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 16:30:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:30899 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726982AbfJJU37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 16:29:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2019 13:29:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,281,1566889200"; 
   d="scan'208";a="277902038"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga001.jf.intel.com with ESMTP; 10 Oct 2019 13:29:51 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@intel.com
Cc:     prarit@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RESEND][PATCH 08/10] tools/power/x86/intel-speed-select: Implement CascadeLake-N help and command functions structures
Date:   Thu, 10 Oct 2019 13:29:43 -0700
Message-Id: <20191010202945.73616-9-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191010202945.73616-1-srinivas.pandruvada@linux.intel.com>
References: <20191010202945.73616-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prarit Bhargava <prarit@redhat.com>

CascadeLake-N only supports SST-BF and needs some of the perf-profile
commands, and the base-freq commands.

Add help functions, and create an empty command structures (the functions
will be implemented later in this patchset).  Call these functions
when running on CascadeLake-N.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel-speed-select/isst-config.c      | 37 ++++++++++++++-----
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 67a866e2dac4..449025c6ea46 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -1610,6 +1610,10 @@ static void get_clos_assoc(int arg)
 	isst_ctdp_display_information_end(outf);
 }
 
+static struct process_cmd_struct clx_n_cmds[] = {
+	{ NULL, NULL, NULL, 0 }
+};
+
 static struct process_cmd_struct isst_cmds[] = {
 	{ "perf-profile", "get-lock-status", get_tdp_locked, 0 },
 	{ "perf-profile", "get-config-levels", get_tdp_levels, 0 },
@@ -1798,12 +1802,15 @@ static void isst_help(void)
 		TDP, etc.\n");
 	printf("\nCommands : For feature=perf-profile\n");
 	printf("\tinfo\n");
-	printf("\tget-lock-status\n");
-	printf("\tget-config-levels\n");
-	printf("\tget-config-version\n");
-	printf("\tget-config-enabled\n");
-	printf("\tget-config-current-level\n");
-	printf("\tset-config-level\n");
+
+	if (!is_clx_n_platform()) {
+		printf("\tget-lock-status\n");
+		printf("\tget-config-levels\n");
+		printf("\tget-config-version\n");
+		printf("\tget-config-enabled\n");
+		printf("\tget-config-current-level\n");
+		printf("\tset-config-level\n");
+	}
 }
 
 static void pbf_help(void)
@@ -1853,6 +1860,12 @@ static struct process_cmd_help_struct isst_help_cmds[] = {
 	{ NULL, NULL }
 };
 
+static struct process_cmd_help_struct clx_n_help_cmds[] = {
+	{ "perf-profile", isst_help },
+	{ "base-freq", pbf_help },
+	{ NULL, NULL }
+};
+
 void process_command(int argc, char **argv,
 		     struct process_cmd_help_struct *help_cmds,
 		     struct process_cmd_struct *cmds)
@@ -2001,11 +2014,15 @@ static void cmdline(int argc, char **argv)
 	set_max_cpu_num();
 	set_cpu_present_cpu_mask();
 	set_cpu_target_cpu_mask();
-	ret = isst_fill_platform_info();
-	if (ret)
-		goto out;
 
-	process_command(argc, argv, isst_help_cmds, isst_cmds);
+	if (!is_clx_n_platform()) {
+		ret = isst_fill_platform_info();
+		if (ret)
+			goto out;
+		process_command(argc, argv, isst_help_cmds, isst_cmds);
+	} else {
+		process_command(argc, argv, clx_n_help_cmds, clx_n_cmds);
+	}
 out:
 	free_cpu_set(present_cpumask);
 	free_cpu_set(target_cpumask);
-- 
2.17.2

