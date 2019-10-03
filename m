Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7960C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E50D20700
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbfJCMLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 08:11:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39072 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbfJCMLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 08:11:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3DCBD307D978;
        Thu,  3 Oct 2019 12:11:22 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F95E5C226;
        Thu,  3 Oct 2019 12:11:21 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH v2 1/7] intel-speed-select: Add int argument to command functions
Date:   Thu,  3 Oct 2019 08:11:06 -0400
Message-Id: <20191003121112.25870-2-prarit@redhat.com>
In-Reply-To: <20191003121112.25870-1-prarit@redhat.com>
References: <20191003121112.25870-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 03 Oct 2019 12:11:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code structure has similar but separate command functions for
the enable and disable operations.  This can be improved by adding an int
argument to the command function structure, and interpreting 1 as enable
and 0 as disable.  This change results in the removal of the disable
command functions.

Add int argument to the command function structure.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 .../x86/intel-speed-select/isst-config.c      | 216 +++++++-----------
 1 file changed, 88 insertions(+), 128 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index edc4c50853bd..1b2899706857 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -11,7 +11,8 @@
 struct process_cmd_struct {
 	char *feature;
 	char *command;
-	void (*process_fn)(void);
+	void (*process_fn)(int arg);
+	int arg;
 };
 
 static const char *version_str = "v1.0";
@@ -679,7 +680,7 @@ static void exec_on_get_ctdp_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 }
 
 #define _get_tdp_level(desc, suffix, object, help)                                \
-	static void get_tdp_##object(void)                                        \
+	static void get_tdp_##object(int arg)                                    \
 	{                                                                         \
 		struct isst_pkg_ctdp ctdp;                                        \
 \
@@ -725,7 +726,7 @@ static void dump_isst_config_for_cpu(int cpu, void *arg1, void *arg2,
 	}
 }
 
-static void dump_isst_config(void)
+static void dump_isst_config(int arg)
 {
 	if (cmd_help) {
 		fprintf(stderr,
@@ -788,7 +789,7 @@ static void set_tdp_level_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 	}
 }
 
-static void set_tdp_level(void)
+static void set_tdp_level(int arg)
 {
 	if (cmd_help) {
 		fprintf(stderr, "Set Config TDP level\n");
@@ -828,7 +829,7 @@ static void dump_pbf_config_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 	}
 }
 
-static void dump_pbf_config(void)
+static void dump_pbf_config(int arg)
 {
 	if (cmd_help) {
 		fprintf(stderr,
@@ -1045,51 +1046,36 @@ static void set_pbf_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 	}
 }
 
-static void set_pbf_enable(void)
+static void set_pbf_enable(int arg)
 {
-	int status = 1;
+	int enable = arg;
 
 	if (cmd_help) {
-		fprintf(stderr,
-			"Enable Intel Speed Select Technology base frequency feature\n");
-		fprintf(stderr,
-			"\tOptional Arguments: -a|--auto : Use priority of cores to set core-power associations\n");
-
-		exit(0);
-	}
-
-	isst_ctdp_display_information_start(outf);
-	if (max_target_cpus)
-		for_each_online_target_cpu_in_set(set_pbf_for_cpu, NULL, NULL,
-						  NULL, &status);
-	else
-		for_each_online_package_in_set(set_pbf_for_cpu, NULL, NULL,
-					       NULL, &status);
-	isst_ctdp_display_information_end(outf);
-}
-
-static void set_pbf_disable(void)
-{
-	int status = 0;
+		if (enable) {
+			fprintf(stderr,
+				"Enable Intel Speed Select Technology base frequency feature\n");
+			fprintf(stderr,
+				"\tOptional Arguments: -a|--auto : Use priority of cores to set core-power associations\n");
+		} else {
 
-	if (cmd_help) {
-		fprintf(stderr,
-			"Disable Intel Speed Select Technology base frequency feature\n");
-		fprintf(stderr,
-			"\tOptional Arguments: -a|--auto : Also disable core-power associations\n");
+			fprintf(stderr,
+				"Disable Intel Speed Select Technology base frequency feature\n");
+			fprintf(stderr,
+				"\tOptional Arguments: -a|--auto : Also disable core-power associations\n");
+		}
 		exit(0);
 	}
 
 	isst_ctdp_display_information_start(outf);
 	if (max_target_cpus)
 		for_each_online_target_cpu_in_set(set_pbf_for_cpu, NULL, NULL,
-						  NULL, &status);
+						  NULL, &enable);
 	else
 		for_each_online_package_in_set(set_pbf_for_cpu, NULL, NULL,
-					       NULL, &status);
+					       NULL, &enable);
 	isst_ctdp_display_information_end(outf);
 
-	if (auto_mode)
+	if (!enable && auto_mode)
 		reset_cpufreq_scaling_min();
 }
 
@@ -1107,7 +1093,7 @@ static void dump_fact_config_for_cpu(int cpu, void *arg1, void *arg2,
 					      fact_avx, &fact_info);
 }
 
-static void dump_fact_config(void)
+static void dump_fact_config(int arg)
 {
 	if (cmd_help) {
 		fprintf(stderr,
@@ -1169,31 +1155,42 @@ static void set_fact_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 	}
 }
 
-static void set_fact_enable(void)
+static void set_fact_enable(int arg)
 {
-	int status = 1, i, j, ret;
+	int i, j, ret;
+	int enable = arg;
 
 	if (cmd_help) {
-		fprintf(stderr,
-			"Enable Intel Speed Select Technology Turbo frequency feature\n");
-		fprintf(stderr,
-			"Optional: -t|--trl : Specify turbo ratio limit\n");
-		fprintf(stderr,
-			"\tOptional Arguments: -a|--auto : Designate specified target CPUs with");
-		fprintf(stderr, "-C|--cpu option as as high priority using core-power feature\n");
+		if (enable) {
+			fprintf(stderr,
+				"Enable Intel Speed Select Technology Turbo frequency feature\n");
+			fprintf(stderr,
+				"Optional: -t|--trl : Specify turbo ratio limit\n");
+			fprintf(stderr,
+				"\tOptional Arguments: -a|--auto : Designate specified target CPUs with");
+			fprintf(stderr,
+				"-C|--cpu option as as high priority using core-power feature\n");
+		} else {
+			fprintf(stderr,
+				"Disable Intel Speed Select Technology turbo frequency feature\n");
+			fprintf(stderr,
+				"Optional: -t|--trl : Specify turbo ratio limit\n");
+			fprintf(stderr,
+				"\tOptional Arguments: -a|--auto : Also disable core-power associations\n");
+		}
 		exit(0);
 	}
 
 	isst_ctdp_display_information_start(outf);
 	if (max_target_cpus)
 		for_each_online_target_cpu_in_set(set_fact_for_cpu, NULL, NULL,
-						  NULL, &status);
+						  NULL, &enable);
 	else
 		for_each_online_package_in_set(set_fact_for_cpu, NULL, NULL,
-					       NULL, &status);
+					       NULL, &enable);
 	isst_ctdp_display_information_end(outf);
 
-	if (auto_mode) {
+	if (enable && auto_mode) {
 		for (i = 0; i < get_topo_max_cpus(); ++i) {
 			int clos;
 
@@ -1247,30 +1244,6 @@ static void set_fact_enable(void)
 
 }
 
-static void set_fact_disable(void)
-{
-	int status = 0;
-
-	if (cmd_help) {
-		fprintf(stderr,
-			"Disable Intel Speed Select Technology turbo frequency feature\n");
-		fprintf(stderr,
-			"Optional: -t|--trl : Specify turbo ratio limit\n");
-		fprintf(stderr,
-			"\tOptional Arguments: -a|--auto : Also disable core-power associations\n");
-		exit(0);
-	}
-
-	isst_ctdp_display_information_start(outf);
-	if (max_target_cpus)
-		for_each_online_target_cpu_in_set(set_fact_for_cpu, NULL, NULL,
-						  NULL, &status);
-	else
-		for_each_online_package_in_set(set_fact_for_cpu, NULL, NULL,
-					       NULL, &status);
-	isst_ctdp_display_information_end(outf);
-}
-
 static void enable_clos_qos_config(int cpu, void *arg1, void *arg2, void *arg3,
 				   void *arg4)
 {
@@ -1289,19 +1262,25 @@ static void enable_clos_qos_config(int cpu, void *arg1, void *arg2, void *arg3,
 				    ret);
 }
 
-static void set_clos_enable(void)
+static void set_clos_enable(int arg)
 {
-	int status = 1;
+	int enable = arg;
 
 	if (cmd_help) {
-		fprintf(stderr, "Enable core-power for a package/die\n");
-		fprintf(stderr,
-			"\tClos Enable: Specify priority type with [--priority|-p]\n");
-		fprintf(stderr, "\t\t 0: Proportional, 1: Ordered\n");
+		if (enable) {
+			fprintf(stderr,
+				"Enable core-power for a package/die\n");
+			fprintf(stderr,
+				"\tClos Enable: Specify priority type with [--priority|-p]\n");
+			fprintf(stderr, "\t\t 0: Proportional, 1: Ordered\n");
+		} else {
+			fprintf(stderr,
+				"Disable core-power: [No command arguments are required]\n");
+		}
 		exit(0);
 	}
 
-	if (cpufreq_sysfs_present()) {
+	if (enable && cpufreq_sysfs_present()) {
 		fprintf(stderr,
 			"cpufreq subsystem and core-power enable will interfere with each other!\n");
 	}
@@ -1309,30 +1288,10 @@ static void set_clos_enable(void)
 	isst_ctdp_display_information_start(outf);
 	if (max_target_cpus)
 		for_each_online_target_cpu_in_set(enable_clos_qos_config, NULL,
-						  NULL, NULL, &status);
-	else
-		for_each_online_package_in_set(enable_clos_qos_config, NULL,
-					       NULL, NULL, &status);
-	isst_ctdp_display_information_end(outf);
-}
-
-static void set_clos_disable(void)
-{
-	int status = 0;
-
-	if (cmd_help) {
-		fprintf(stderr,
-			"Disable core-power: [No command arguments are required]\n");
-		exit(0);
-	}
-
-	isst_ctdp_display_information_start(outf);
-	if (max_target_cpus)
-		for_each_online_target_cpu_in_set(enable_clos_qos_config, NULL,
-						  NULL, NULL, &status);
+						  NULL, NULL, &enable);
 	else
 		for_each_online_package_in_set(enable_clos_qos_config, NULL,
-					       NULL, NULL, &status);
+					       NULL, NULL, &enable);
 	isst_ctdp_display_information_end(outf);
 }
 
@@ -1350,7 +1309,7 @@ static void dump_clos_config_for_cpu(int cpu, void *arg1, void *arg2,
 					      &clos_config);
 }
 
-static void dump_clos_config(void)
+static void dump_clos_config(int arg)
 {
 	if (cmd_help) {
 		fprintf(stderr,
@@ -1386,7 +1345,7 @@ static void get_clos_info_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 		isst_clos_display_clos_information(cpu, outf, enable, prio_type);
 }
 
-static void dump_clos_info(void)
+static void dump_clos_info(int arg)
 {
 	if (cmd_help) {
 		fprintf(stderr,
@@ -1429,7 +1388,7 @@ static void set_clos_config_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 		isst_display_result(cpu, outf, "core-power", "config", ret);
 }
 
-static void set_clos_config(void)
+static void set_clos_config(int arg)
 {
 	if (cmd_help) {
 		fprintf(stderr,
@@ -1493,7 +1452,7 @@ static void set_clos_assoc_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 		isst_display_result(cpu, outf, "core-power", "assoc", ret);
 }
 
-static void set_clos_assoc(void)
+static void set_clos_assoc(int arg)
 {
 	if (cmd_help) {
 		fprintf(stderr, "Associate a clos id to a CPU\n");
@@ -1527,7 +1486,7 @@ static void get_clos_assoc_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 		isst_clos_display_assoc_information(cpu, outf, clos);
 }
 
-static void get_clos_assoc(void)
+static void get_clos_assoc(int arg)
 {
 	if (cmd_help) {
 		fprintf(stderr, "Get associate clos id to a CPU\n");
@@ -1548,26 +1507,27 @@ static void get_clos_assoc(void)
 }
 
 static struct process_cmd_struct isst_cmds[] = {
-	{ "perf-profile", "get-lock-status", get_tdp_locked },
-	{ "perf-profile", "get-config-levels", get_tdp_levels },
-	{ "perf-profile", "get-config-version", get_tdp_version },
-	{ "perf-profile", "get-config-enabled", get_tdp_enabled },
-	{ "perf-profile", "get-config-current-level", get_tdp_current_level },
-	{ "perf-profile", "set-config-level", set_tdp_level },
-	{ "perf-profile", "info", dump_isst_config },
-	{ "base-freq", "info", dump_pbf_config },
-	{ "base-freq", "enable", set_pbf_enable },
-	{ "base-freq", "disable", set_pbf_disable },
-	{ "turbo-freq", "info", dump_fact_config },
-	{ "turbo-freq", "enable", set_fact_enable },
-	{ "turbo-freq", "disable", set_fact_disable },
-	{ "core-power", "info", dump_clos_info },
-	{ "core-power", "enable", set_clos_enable },
-	{ "core-power", "disable", set_clos_disable },
-	{ "core-power", "config", set_clos_config },
-	{ "core-power", "get-config", dump_clos_config },
-	{ "core-power", "assoc", set_clos_assoc },
-	{ "core-power", "get-assoc", get_clos_assoc },
+	{ "perf-profile", "get-lock-status", get_tdp_locked, 0 },
+	{ "perf-profile", "get-config-levels", get_tdp_levels, 0 },
+	{ "perf-profile", "get-config-version", get_tdp_version, 0 },
+	{ "perf-profile", "get-config-enabled", get_tdp_enabled, 0 },
+	{ "perf-profile", "get-config-current-level", get_tdp_current_level,
+	 0 },
+	{ "perf-profile", "set-config-level", set_tdp_level, 0 },
+	{ "perf-profile", "info", dump_isst_config, 0 },
+	{ "base-freq", "info", dump_pbf_config, 0 },
+	{ "base-freq", "enable", set_pbf_enable, 1 },
+	{ "base-freq", "disable", set_pbf_enable, 0 },
+	{ "turbo-freq", "info", dump_fact_config, 0 },
+	{ "turbo-freq", "enable", set_fact_enable, 1 },
+	{ "turbo-freq", "disable", set_fact_enable, 0 },
+	{ "core-power", "info", dump_clos_info, 0 },
+	{ "core-power", "enable", set_clos_enable, 1 },
+	{ "core-power", "disable", set_clos_enable, 0 },
+	{ "core-power", "config", set_clos_config, 0 },
+	{ "core-power", "get-config", dump_clos_config, 0 },
+	{ "core-power", "assoc", set_clos_assoc, 0 },
+	{ "core-power", "get-assoc", get_clos_assoc, 0 },
 	{ NULL, NULL, NULL }
 };
 
@@ -1816,7 +1776,7 @@ void process_command(int argc, char **argv)
 		if (!strcmp(isst_cmds[i].feature, feature) &&
 		    !strcmp(isst_cmds[i].command, cmd)) {
 			parse_cmd_args(argc, optind + 1, argv);
-			isst_cmds[i].process_fn();
+			isst_cmds[i].process_fn(isst_cmds[i].arg);
 			matched = 1;
 			break;
 		}
-- 
2.18.1

