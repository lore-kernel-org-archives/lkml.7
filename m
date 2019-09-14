Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5F7C4CECA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 19:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D172D20828
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 19:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731392AbfINTp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 15:45:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:27815 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730373AbfINTpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 15:45:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2019 12:45:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,506,1559545200"; 
   d="scan'208";a="201286930"
Received: from spandruv-mobl.amr.corp.intel.com ([10.251.128.136])
  by fmsmga001.fm.intel.com with ESMTP; 14 Sep 2019 12:45:50 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andy.shevchenko@gmail.com, andriy.shevchenko@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        prarit@redhat.com, darcari@redhat.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 3/5] tools/power/x86/intel-speed-select: Format get-assoc information
Date:   Sat, 14 Sep 2019 12:45:45 -0700
Message-Id: <20190914194547.24271-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190914194547.24271-1-srinivas.pandruvada@linux.intel.com>
References: <20190914194547.24271-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Format the get-assoc command output consistant with other commands.
For example:

Intel(R) Speed Select Technology
Executing on CPU model:142[0x8e]
 package-0
  die-0
    cpu-0
      get-assoc
        clos:0

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel-speed-select/isst-config.c      | 14 +++++++----
 .../x86/intel-speed-select/isst-display.c     | 23 +++++++++++++++++++
 tools/power/x86/intel-speed-select/isst.h     |  2 +-
 3 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index e505aaf2beef..c2892d86be36 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -1249,7 +1249,7 @@ static void get_clos_assoc_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 	if (ret)
 		perror("isst_clos_get_assoc_status");
 	else
-		isst_display_result(cpu, outf, "core-power", "get-assoc", clos);
+		isst_clos_display_assoc_information(cpu, outf, clos);
 }
 
 static void get_clos_assoc(void)
@@ -1259,13 +1259,17 @@ static void get_clos_assoc(void)
 		fprintf(stderr, "\tSpecify targeted cpu id with [--cpu|-c]\n");
 		exit(0);
 	}
-	if (max_target_cpus)
-		for_each_online_target_cpu_in_set(get_clos_assoc_for_cpu, NULL,
-						  NULL, NULL, NULL);
-	else {
+
+	if (!max_target_cpus) {
 		fprintf(stderr,
 			"Invalid target cpu. Specify with [-c|--cpu]\n");
+		exit(0);
 	}
+
+	isst_ctdp_display_information_start(outf);
+	for_each_online_target_cpu_in_set(get_clos_assoc_for_cpu, NULL,
+					  NULL, NULL, NULL);
+	isst_ctdp_display_information_end(outf);
 }
 
 static struct process_cmd_struct isst_cmds[] = {
diff --git a/tools/power/x86/intel-speed-select/isst-display.c b/tools/power/x86/intel-speed-select/isst-display.c
index df4aa99c4e92..bd7aaf27e4de 100644
--- a/tools/power/x86/intel-speed-select/isst-display.c
+++ b/tools/power/x86/intel-speed-select/isst-display.c
@@ -503,6 +503,29 @@ void isst_clos_display_information(int cpu, FILE *outf, int clos,
 	format_and_print(outf, 1, NULL, NULL);
 }
 
+void isst_clos_display_assoc_information(int cpu, FILE *outf, int clos)
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
+	snprintf(header, sizeof(header), "get-assoc");
+	format_and_print(outf, 4, header, NULL);
+
+	snprintf(header, sizeof(header), "clos");
+	snprintf(value, sizeof(value), "%d", clos);
+	format_and_print(outf, 5, header, value);
+
+	format_and_print(outf, 1, NULL, NULL);
+}
+
 void isst_display_result(int cpu, FILE *outf, char *feature, char *cmd,
 			 int result)
 {
diff --git a/tools/power/x86/intel-speed-select/isst.h b/tools/power/x86/intel-speed-select/isst.h
index 668f914d077f..48655d0dee2d 100644
--- a/tools/power/x86/intel-speed-select/isst.h
+++ b/tools/power/x86/intel-speed-select/isst.h
@@ -225,7 +225,7 @@ extern int isst_clos_associate(int cpu, int clos);
 extern int isst_clos_get_assoc_status(int cpu, int *clos_id);
 extern void isst_clos_display_information(int cpu, FILE *outf, int clos,
 					  struct isst_clos_config *clos_config);
-
+extern void isst_clos_display_assoc_information(int cpu, FILE *outf, int clos);
 extern int isst_read_reg(unsigned short reg, unsigned int *val);
 extern int isst_write_reg(int reg, unsigned int val);
 
-- 
2.17.2

