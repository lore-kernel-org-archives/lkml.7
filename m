Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFAEC4CEC5
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 07:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F222081B
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 07:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfINHFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 03:05:42 -0400
Received: from mga18.intel.com ([134.134.136.126]:2410 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbfINHFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 03:05:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2019 00:05:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,503,1559545200"; 
   d="scan'208";a="210615635"
Received: from spandruv-mobl.amr.corp.intel.com ([10.251.128.120])
  by fmsmga004.fm.intel.com with ESMTP; 14 Sep 2019 00:05:35 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andy.shevchenko@gmail.com, andriy.shevchenko@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        prarit@redhat.com, darcari@redhat.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/5] tools/power/x86/intel-speed-select: Format get-assoc information
Date:   Sat, 14 Sep 2019 00:05:11 -0700
Message-Id: <20190914070513.19807-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190914070513.19807-1-srinivas.pandruvada@linux.intel.com>
References: <20190914070513.19807-1-srinivas.pandruvada@linux.intel.com>
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
index b44f5b822348..4da7ffca2484 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -1245,7 +1245,7 @@ static void get_clos_assoc_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 	if (ret)
 		perror("isst_clos_get_assoc_status");
 	else
-		isst_display_result(cpu, outf, "core-power", "get-assoc", clos);
+		isst_clos_display_assoc_information(cpu, outf, clos);
 }
 
 static void get_clos_assoc(void)
@@ -1255,13 +1255,17 @@ static void get_clos_assoc(void)
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

