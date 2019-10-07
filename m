Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70912ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534AD206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbfJGTbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 15:31:20 -0400
Received: from mga09.intel.com ([134.134.136.24]:26156 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729056AbfJGTbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:31:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 12:31:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="192372884"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga008.fm.intel.com with ESMTP; 07 Oct 2019 12:31:08 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        prarit@redhat.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 4/6] tools/power/x86/intel-speed-select: Implement CascadeLake-N help and command functions structures
Date:   Mon,  7 Oct 2019 12:30:58 -0700
Message-Id: <20191007193100.36934-5-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191007193100.36934-1-srinivas.pandruvada@linux.intel.com>
References: <20191007193100.36934-1-srinivas.pandruvada@linux.intel.com>
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

