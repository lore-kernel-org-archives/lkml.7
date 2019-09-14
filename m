Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1ECAC4CECA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 19:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F4920828
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 19:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731466AbfINTqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 15:46:08 -0400
Received: from mga12.intel.com ([192.55.52.136]:27815 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728618AbfINTpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 15:45:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2019 12:45:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,506,1559545200"; 
   d="scan'208";a="201286921"
Received: from spandruv-mobl.amr.corp.intel.com ([10.251.128.136])
  by fmsmga001.fm.intel.com with ESMTP; 14 Sep 2019 12:45:50 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andy.shevchenko@gmail.com, andriy.shevchenko@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        prarit@redhat.com, darcari@redhat.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 2/5] tools/power/x86/intel-speed-select: Allow online/offline based on tdp
Date:   Sat, 14 Sep 2019 12:45:44 -0700
Message-Id: <20190914194547.24271-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190914194547.24271-1-srinivas.pandruvada@linux.intel.com>
References: <20190914194547.24271-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using enable core mask, do online offline CPUs. There is a new option
--online|-o for set-config-level.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel-speed-select/isst-config.c      | 60 +++++++++++++++++--
 tools/power/x86/intel-speed-select/isst.h     |  2 +
 2 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 83ac72902b36..e505aaf2beef 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -38,6 +38,7 @@ static int fact_avx = 0xFF;
 static unsigned long long fact_trl;
 static int out_format_json;
 static int cmd_help;
+static int force_online_offline;
 
 /* clos related */
 static int current_clos = -1;
@@ -138,14 +139,14 @@ int out_format_is_json(void)
 int get_physical_package_id(int cpu)
 {
 	return parse_int_file(
-		1, "/sys/devices/system/cpu/cpu%d/topology/physical_package_id",
+		0, "/sys/devices/system/cpu/cpu%d/topology/physical_package_id",
 		cpu);
 }
 
 int get_physical_core_id(int cpu)
 {
 	return parse_int_file(
-		1, "/sys/devices/system/cpu/cpu%d/topology/core_id", cpu);
+		0, "/sys/devices/system/cpu/cpu%d/topology/core_id", cpu);
 }
 
 int get_physical_die_id(int cpu)
@@ -165,6 +166,26 @@ int get_topo_max_cpus(void)
 	return topo_max_cpus;
 }
 
+static void set_cpu_online_offline(int cpu, int state)
+{
+	char buffer[128];
+	int fd;
+
+	snprintf(buffer, sizeof(buffer),
+		 "/sys/devices/system/cpu/cpu%d/online", cpu);
+
+	fd = open(buffer, O_WRONLY);
+	if (fd < 0)
+		err(-1, "%s open failed", buffer);
+
+	if (state)
+		write(fd, "1\n", 2);
+	else
+		write(fd, "0\n", 2);
+
+	close(fd);
+}
+
 #define MAX_PACKAGE_COUNT 8
 #define MAX_DIE_PER_PACKAGE 2
 static void for_each_online_package_in_set(void (*callback)(int, void *, void *,
@@ -736,9 +757,34 @@ static void set_tdp_level_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 	ret = isst_set_tdp_level(cpu, tdp_level);
 	if (ret)
 		perror("set_tdp_level_for_cpu");
-	else
+	else {
 		isst_display_result(cpu, outf, "perf-profile", "set_tdp_level",
 				    ret);
+		if (force_online_offline) {
+			struct isst_pkg_ctdp_level_info ctdp_level;
+			int pkg_id = get_physical_package_id(cpu);
+			int die_id = get_physical_die_id(cpu);
+
+			fprintf(stderr, "Option is set to online/offline\n");
+			ctdp_level.core_cpumask_size =
+				alloc_cpu_set(&ctdp_level.core_cpumask);
+			isst_get_coremask_info(cpu, tdp_level, &ctdp_level);
+			if (ctdp_level.cpu_count) {
+				int i, max_cpus = get_topo_max_cpus();
+				for (i = 0; i < max_cpus; ++i) {
+					if (pkg_id != get_physical_package_id(i) || die_id != get_physical_die_id(i))
+						continue;
+					if (CPU_ISSET_S(i, ctdp_level.core_cpumask_size, ctdp_level.core_cpumask)) {
+						fprintf(stderr, "online cpu %d\n", i);
+						set_cpu_online_offline(i, 1);
+					} else {
+						fprintf(stderr, "offline cpu %d\n", i);
+						set_cpu_online_offline(i, 0);
+					}
+				}
+			}
+		}
+	}
 }
 
 static void set_tdp_level(void)
@@ -747,6 +793,8 @@ static void set_tdp_level(void)
 		fprintf(stderr, "Set Config TDP level\n");
 		fprintf(stderr,
 			"\t Arguments: -l|--level : Specify tdp level\n");
+		fprintf(stderr,
+			"\t Optional Arguments: -o | online : online/offline for the tdp level\n");
 		exit(0);
 	}
 
@@ -1319,6 +1367,7 @@ static void parse_cmd_args(int argc, int start, char **argv)
 	static struct option long_options[] = {
 		{ "bucket", required_argument, 0, 'b' },
 		{ "level", required_argument, 0, 'l' },
+		{ "online", required_argument, 0, 'o' },
 		{ "trl-type", required_argument, 0, 'r' },
 		{ "trl", required_argument, 0, 't' },
 		{ "help", no_argument, 0, 'h' },
@@ -1335,7 +1384,7 @@ static void parse_cmd_args(int argc, int start, char **argv)
 	option_index = start;
 
 	optind = start + 1;
-	while ((opt = getopt_long(argc, argv, "b:l:t:c:d:e:n:m:p:w:h",
+	while ((opt = getopt_long(argc, argv, "b:l:t:c:d:e:n:m:p:w:ho",
 				  long_options, &option_index)) != -1) {
 		switch (opt) {
 		case 'b':
@@ -1347,6 +1396,9 @@ static void parse_cmd_args(int argc, int start, char **argv)
 		case 'l':
 			tdp_level = atoi(optarg);
 			break;
+		case 'o':
+			force_online_offline = 1;
+			break;
 		case 't':
 			sscanf(optarg, "0x%llx", &fact_trl);
 			break;
diff --git a/tools/power/x86/intel-speed-select/isst.h b/tools/power/x86/intel-speed-select/isst.h
index 2f7f62765eb6..668f914d077f 100644
--- a/tools/power/x86/intel-speed-select/isst.h
+++ b/tools/power/x86/intel-speed-select/isst.h
@@ -187,6 +187,8 @@ extern int isst_send_msr_command(unsigned int cpu, unsigned int command,
 				 int write, unsigned long long *req_resp);
 
 extern int isst_get_ctdp_levels(int cpu, struct isst_pkg_ctdp *pkg_dev);
+extern int isst_get_coremask_info(int cpu, int config_index,
+			   struct isst_pkg_ctdp_level_info *ctdp_level);
 extern int isst_get_process_ctdp(int cpu, int tdp_level,
 				 struct isst_pkg_ctdp *pkg_dev);
 extern void isst_get_process_ctdp_complete(int cpu,
-- 
2.17.2

