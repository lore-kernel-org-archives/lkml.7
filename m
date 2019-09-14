Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA469C4CEC7
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 07:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0BD2084F
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 07:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfINHFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 03:05:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:2408 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbfINHFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 03:05:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2019 00:05:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,503,1559545200"; 
   d="scan'208";a="210615646"
Received: from spandruv-mobl.amr.corp.intel.com ([10.251.128.120])
  by fmsmga004.fm.intel.com with ESMTP; 14 Sep 2019 00:05:36 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andy.shevchenko@gmail.com, andriy.shevchenko@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        prarit@redhat.com, darcari@redhat.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 5/5] tools/power/x86/intel-speed-select: Extend core-power command set
Date:   Sat, 14 Sep 2019 00:05:13 -0700
Message-Id: <20190914070513.19807-6-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190914070513.19807-1-srinivas.pandruvada@linux.intel.com>
References: <20190914070513.19807-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add additional command to get the clos enable and priority type. The
current info option is actually dumping per clos QOS config, so name
the command appropriately to get-config.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel-speed-select/isst-config.c      | 36 ++++++++++++++++++-
 .../power/x86/intel-speed-select/isst-core.c  | 25 +++++++++++++
 .../x86/intel-speed-select/isst-display.c     | 28 +++++++++++++++
 tools/power/x86/intel-speed-select/isst.h     |  5 +++
 4 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 15c098e3a512..671239333f98 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -1129,6 +1129,38 @@ static void dump_clos_config(void)
 	isst_ctdp_display_information_end(outf);
 }
 
+static void get_clos_info_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
+				  void *arg4)
+{
+	int enable, ret, prio_type;
+
+	ret = isst_clos_get_clos_information(cpu, &enable, &prio_type);
+	if (ret)
+		perror("isst_clos_get_info");
+	else
+		isst_clos_display_clos_information(cpu, outf, enable, prio_type);
+}
+
+static void dump_clos_info(void)
+{
+	if (cmd_help) {
+		fprintf(stderr,
+			"Print Intel Speed Select Technology core power information\n");
+		fprintf(stderr, "\tSpecify targeted cpu id with [--cpu|-c]\n");
+		exit(0);
+	}
+
+	if (!max_target_cpus)
+		fprintf(stderr,
+			"Invalid target cpu. Specify with [-c|--cpu]\n");
+
+	isst_ctdp_display_information_start(outf);
+	for_each_online_target_cpu_in_set(get_clos_info_for_cpu, NULL,
+					  NULL, NULL, NULL);
+	isst_ctdp_display_information_end(outf);
+
+}
+
 static void set_clos_config_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 				    void *arg4)
 {
@@ -1282,10 +1314,11 @@ static struct process_cmd_struct isst_cmds[] = {
 	{ "turbo-freq", "info", dump_fact_config },
 	{ "turbo-freq", "enable", set_fact_enable },
 	{ "turbo-freq", "disable", set_fact_disable },
-	{ "core-power", "info", dump_clos_config },
+	{ "core-power", "info", dump_clos_info },
 	{ "core-power", "enable", set_clos_enable },
 	{ "core-power", "disable", set_clos_disable },
 	{ "core-power", "config", set_clos_config },
+	{ "core-power", "get-config", dump_clos_config },
 	{ "core-power", "assoc", set_clos_assoc },
 	{ "core-power", "get-assoc", get_clos_assoc },
 	{ NULL, NULL, NULL }
@@ -1487,6 +1520,7 @@ static void core_power_help(void)
 	printf("\tenable\n");
 	printf("\tdisable\n");
 	printf("\tconfig\n");
+	printf("\tget-config\n");
 	printf("\tassoc\n");
 	printf("\tget-assoc\n");
 }
diff --git a/tools/power/x86/intel-speed-select/isst-core.c b/tools/power/x86/intel-speed-select/isst-core.c
index 0bf341ad9697..6dee5332c9d3 100644
--- a/tools/power/x86/intel-speed-select/isst-core.c
+++ b/tools/power/x86/intel-speed-select/isst-core.c
@@ -619,6 +619,31 @@ int isst_get_process_ctdp(int cpu, int tdp_level, struct isst_pkg_ctdp *pkg_dev)
 	return 0;
 }
 
+int isst_clos_get_clos_information(int cpu, int *enable, int *type)
+{
+	unsigned int resp;
+	int ret;
+
+	ret = isst_send_mbox_command(cpu, CONFIG_CLOS, CLOS_PM_QOS_CONFIG, 0, 0,
+				     &resp);
+	if (ret)
+		return ret;
+
+	debug_printf("cpu:%d CLOS_PM_QOS_CONFIG resp:%x\n", cpu, resp);
+
+	if (resp & BIT(1))
+		*enable = 1;
+	else
+		*enable = 0;
+
+	if (resp & BIT(2))
+		*type = 1;
+	else
+		*type = 0;
+
+	return 0;
+}
+
 int isst_pm_qos_config(int cpu, int enable_clos, int priority_type)
 {
 	unsigned int req, resp;
diff --git a/tools/power/x86/intel-speed-select/isst-display.c b/tools/power/x86/intel-speed-select/isst-display.c
index bd7aaf27e4de..2e6e5fcdbd7c 100644
--- a/tools/power/x86/intel-speed-select/isst-display.c
+++ b/tools/power/x86/intel-speed-select/isst-display.c
@@ -503,6 +503,34 @@ void isst_clos_display_information(int cpu, FILE *outf, int clos,
 	format_and_print(outf, 1, NULL, NULL);
 }
 
+void isst_clos_display_clos_information(int cpu, FILE *outf,
+					int clos_enable, int type)
+{
+	char header[256];
+	char value[256];
+
+	snprintf(header, sizeof(header), "package-%d",
+		 get_physical_package_id(cpu));
+	format_and_print(outf, 1, header, NULL);
+	snprintf(header, sizeof(header), "die-%d", get_physical_die_id(cpu));
+	format_and_print(outf, 2, header, NULL);
+	snprintf(header, sizeof(header), "cpu-%d", cpu);
+	format_and_print(outf, 3, header, NULL);
+
+	snprintf(header, sizeof(header), "core-power");
+	format_and_print(outf, 4, header, NULL);
+
+	snprintf(header, sizeof(header), "enable-status");
+	snprintf(value, sizeof(value), "%d", clos_enable);
+	format_and_print(outf, 5, header, value);
+
+	snprintf(header, sizeof(header), "priority-type");
+	snprintf(value, sizeof(value), "%d", type);
+	format_and_print(outf, 5, header, value);
+
+	format_and_print(outf, 1, NULL, NULL);
+}
+
 void isst_clos_display_assoc_information(int cpu, FILE *outf, int clos)
 {
 	char header[256];
diff --git a/tools/power/x86/intel-speed-select/isst.h b/tools/power/x86/intel-speed-select/isst.h
index 48655d0dee2d..09e16a41b57c 100644
--- a/tools/power/x86/intel-speed-select/isst.h
+++ b/tools/power/x86/intel-speed-select/isst.h
@@ -231,4 +231,9 @@ extern int isst_write_reg(int reg, unsigned int val);
 
 extern void isst_display_result(int cpu, FILE *outf, char *feature, char *cmd,
 				int result);
+
+extern int isst_clos_get_clos_information(int cpu, int *enable, int *type);
+extern void isst_clos_display_clos_information(int cpu, FILE *outf,
+					       int clos_enable, int type);
+
 #endif
-- 
2.17.2

