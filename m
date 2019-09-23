Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883CFC4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F312168B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733202AbfIWS7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 14:59:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:39237 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733155AbfIWS7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:59:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Sep 2019 11:59:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,541,1559545200"; 
   d="scan'208";a="203187149"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga001.fm.intel.com with ESMTP; 23 Sep 2019 11:59:07 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@intel.com
Cc:     prarit@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/3] tools/power/x86/intel-speed-select: Turbo-freq feature auto mode
Date:   Mon, 23 Sep 2019 11:59:05 -0700
Message-Id: <20190923185906.76032-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190923185906.76032-1-srinivas.pandruvada@linux.intel.com>
References: <20190923185906.76032-1-srinivas.pandruvada@linux.intel.com>
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
 .../x86/intel-speed-select/isst-config.c      | 79 ++++++++++++++++---
 1 file changed, 69 insertions(+), 10 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 5da59ff47306..edc4c50853bd 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -1163,19 +1163,24 @@ static void set_fact_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 			isst_set_trl_from_current_tdp(cpu, fact_trl);
 			isst_display_result(cpu, outf, "turbo-freq", "disable",
 					    ret);
+			if (auto_mode)
+				isst_pm_qos_config(cpu, 0, 0);
 		}
 	}
 }
 
 static void set_fact_enable(void)
 {
-	int status = 1;
+	int status = 1, i, j, ret;
 
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
 
@@ -1187,6 +1192,59 @@ static void set_fact_enable(void)
 		for_each_online_package_in_set(set_fact_for_cpu, NULL, NULL,
 					       NULL, &status);
 	isst_ctdp_display_information_end(outf);
+
+	if (auto_mode) {
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
+			ret = isst_pm_qos_config(i, 1, 1);
+			if (ret)
+				goto error_disable;
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
+error_disable:
+	for (j = 0; j < i; ++j) {
+		if (!CPU_ISSET_S(j, present_cpumask_size, present_cpumask))
+				continue;
+
+		isst_pm_qos_config(j, 0, 0);
+	}
+error_disp:
+	isst_display_result(i, outf, "turbo-freq --auto", "enable", ret);
+
 }
 
 static void set_fact_disable(void)
@@ -1198,6 +1256,8 @@ static void set_fact_disable(void)
 			"Disable Intel Speed Select Technology turbo frequency feature\n");
 		fprintf(stderr,
 			"Optional: -t|--trl : Specify turbo ratio limit\n");
+		fprintf(stderr,
+			"\tOptional Arguments: -a|--auto : Also disable core-power associations\n");
 		exit(0);
 	}
 
@@ -1218,16 +1278,15 @@ static void enable_clos_qos_config(int cpu, void *arg1, void *arg2, void *arg3,
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

