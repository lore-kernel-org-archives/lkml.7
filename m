Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862F9ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F412133F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfJGRaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 13:30:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:16822 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728408AbfJGRaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 13:30:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 10:30:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,268,1566889200"; 
   d="scan'208";a="344795160"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga004.jf.intel.com with ESMTP; 07 Oct 2019 10:30:01 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        prarit@redhat.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 2/3] tools/power/x86/intel-speed-select: Turbo-freq feature auto mode
Date:   Mon,  7 Oct 2019 10:29:58 -0700
Message-Id: <20191007172959.25912-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191007172959.25912-1-srinivas.pandruvada@linux.intel.com>
References: <20191007172959.25912-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce --auto|-a option to turbo-freq enable feature, so that it
does in one step for users who are OK by setting all passed target cores
as high priority and set in CLOS 0 and remaining in CLOS 3. In this way,
users don't have to take multiple steps to enable turbo-freq feature. For
users who want more fine grain control, they can always use core-power
feature to set custom CLOS configuration and assignment.

While here also print the error to output when clos configuration fails.

For example
intel-speed-select -c 0-4 turbo-freq enable --auto

The above command will enable turbo-freq and core-power feature. Also
mark CPU 0 to CPU 4 as high priority.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel-speed-select/isst-config.c      | 152 ++++++++++++++----
 1 file changed, 124 insertions(+), 28 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 82502a38446e..e1ca7c5b8037 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -1173,40 +1173,58 @@ static void set_fact_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 	int ret;
 	int status = *(int *)arg4;
 
+	if (auto_mode) {
+		if (status) {
+			ret = isst_pm_qos_config(cpu, 1, 1);
+			if (ret)
+				goto disp_results;
+		} else {
+			isst_pm_qos_config(cpu, 0, 0);
+		}
+	}
+
 	ret = isst_set_pbf_fact_status(cpu, 0, status);
-	if (ret)
+	if (ret) {
 		perror("isst_set_fact");
-	else {
-		if (status) {
-			struct isst_pkg_ctdp pkg_dev;
+		if (auto_mode)
+			isst_pm_qos_config(cpu, 0, 0);
 
-			ret = isst_get_ctdp_levels(cpu, &pkg_dev);
-			if (ret) {
-				isst_display_result(cpu, outf, "turbo-freq",
-						    "enable", ret);
-				return;
-			}
+		goto disp_results;
+	}
+
+	/* Set TRL */
+	if (status) {
+		struct isst_pkg_ctdp pkg_dev;
+
+		ret = isst_get_ctdp_levels(cpu, &pkg_dev);
+		if (!ret)
 			ret = isst_set_trl(cpu, fact_trl);
-			isst_display_result(cpu, outf, "turbo-freq", "enable",
-					    ret);
-		} else {
-			/* Since we modified TRL during Fact enable, restore it */
-			isst_set_trl_from_current_tdp(cpu, fact_trl);
-			isst_display_result(cpu, outf, "turbo-freq", "disable",
-					    ret);
-		}
+		if (ret && auto_mode)
+			isst_pm_qos_config(cpu, 0, 0);
+	}
+
+disp_results:
+	if (status) {
+		isst_display_result(cpu, outf, "turbo-freq", "enable", ret);
+	} else {
+		/* Since we modified TRL during Fact enable, restore it */
+		isst_set_trl_from_current_tdp(cpu, fact_trl);
+		isst_display_result(cpu, outf, "turbo-freq", "disable", ret);
 	}
 }
 
 static void set_fact_enable(void)
 {
-	int status = 1;
+	int status = 1, i, ret;
 
 	if (cmd_help) {
 		fprintf(stderr,
 			"Enable Intel Speed Select Technology Turbo frequency feature\n");
 		fprintf(stderr,
 			"Optional: -t|--trl : Specify turbo ratio limit\n");
+		fprintf(stderr,
+			"\tOptional Arguments: -a|--auto : Designate specified target CPUs with");
+		fprintf(stderr, "-C|--cpu option as as high priority using core-power feature\n");
 		exit(0);
 	}
 
@@ -1218,6 +1236,83 @@ static void set_fact_enable(void)
 		for_each_online_package_in_set(set_fact_for_cpu, NULL, NULL,
 					       NULL, &status);
 	isst_ctdp_display_information_end(outf);
+
+	if (auto_mode) {
+		/*
+		 * When we adjust CLOS param, we have to set for siblings also.
+		 * So for the each user specified CPU, also add the sibling
+		 * in the present_cpu_mask.
+		 */
+		for (i = 0; i < get_topo_max_cpus(); ++i) {
+			char buffer[128], sibling_list[128], *cpu_str;
+			int fd, len;
+
+			if (!CPU_ISSET_S(i, target_cpumask_size, target_cpumask))
+				continue;
+
+			snprintf(buffer, sizeof(buffer),
+				 "/sys/devices/system/cpu/cpu%d/topology/thread_siblings_list", i);
+
+			fd = open(buffer, O_RDONLY);
+			if (fd < 0)
+				continue;
+
+			len = read(fd, sibling_list, sizeof(sibling_list));
+			close(fd);
+
+			if (len < 0)
+				continue;
+
+			cpu_str = strtok(sibling_list, ",");
+			while (cpu_str != NULL) {
+				int cpu;
+
+				sscanf(cpu_str, "%d", &cpu);
+				CPU_SET_S(cpu, target_cpumask_size, target_cpumask);
+				cpu_str = strtok(NULL, ",");
+			}
+		}
+
+		for (i = 0; i < get_topo_max_cpus(); ++i) {
+			int clos;
+
+			if (!CPU_ISSET_S(i, present_cpumask_size, present_cpumask))
+				continue;
+
+			ret = set_clos_param(i, 0, 0, 0, 0, 0xff);
+			if (ret)
+				goto error_disp;
+
+			ret = set_clos_param(i, 1, 15, 0, 0, 0xff);
+			if (ret)
+				goto error_disp;
+
+			ret = set_clos_param(i, 2, 15, 0, 0, 0xff);
+			if (ret)
+				goto error_disp;
+
+			ret = set_clos_param(i, 3, 15, 0, 0, 0xff);
+			if (ret)
+				goto error_disp;
+
+			if (CPU_ISSET_S(i, target_cpumask_size, target_cpumask))
+				clos = 0;
+			else
+				clos = 3;
+
+			debug_printf("Associate cpu: %d clos: %d\n", i, clos);
+			ret = isst_clos_associate(i, clos);
+			if (ret)
+				goto error_disp;
+		}
+		isst_display_result(i, outf, "turbo-freq --auto", "enable", 0);
+	}
+
+	return;
+
+error_disp:
+	isst_display_result(i, outf, "turbo-freq --auto", "enable", ret);
+
 }
 
 static void set_fact_disable(void)
@@ -1229,6 +1324,8 @@ static void set_fact_disable(void)
 			"Disable Intel Speed Select Technology turbo frequency feature\n");
 		fprintf(stderr,
 			"Optional: -t|--trl : Specify turbo ratio limit\n");
+		fprintf(stderr,
+			"\tOptional Arguments: -a|--auto : Also disable core-power associations\n");
 		exit(0);
 	}
 
@@ -1249,16 +1346,15 @@ static void enable_clos_qos_config(int cpu, void *arg1, void *arg2, void *arg3,
 	int status = *(int *)arg4;
 
 	ret = isst_pm_qos_config(cpu, status, clos_priority_type);
-	if (ret) {
+	if (ret)
 		perror("isst_pm_qos_config");
-	} else {
-		if (status)
-			isst_display_result(cpu, outf, "core-power", "enable",
-					    ret);
-		else
-			isst_display_result(cpu, outf, "core-power", "disable",
-					    ret);
-	}
+
+	if (status)
+		isst_display_result(cpu, outf, "core-power", "enable",
+				    ret);
+	else
+		isst_display_result(cpu, outf, "core-power", "disable",
+				    ret);
 }
 
 static void set_clos_enable(void)
-- 
2.17.2

