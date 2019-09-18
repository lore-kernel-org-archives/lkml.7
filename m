Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907C8C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 00:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F8A21848
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 00:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfIRAwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 20:52:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:7725 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728383AbfIRAwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 20:52:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2019 17:52:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,518,1559545200"; 
   d="scan'208";a="386722934"
Received: from spandruv-mobl.amr.corp.intel.com ([10.254.43.68])
  by fmsmga005.fm.intel.com with ESMTP; 17 Sep 2019 17:52:40 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andy.shevchenko@gmail.com, andriy.shevchenko@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        prarit@redhat.com, darcari@redhat.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] tools/power/x86/intel-speed-select: Fix perf-profile command output
Date:   Tue, 17 Sep 2019 17:52:37 -0700
Message-Id: <20190918005237.32337-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit "c016ae8f9fa04d361efc8629de49ad3af12b5262
"tools/power/x86/intel-speed-select: Output success/failed for command
output" introduced a regression in perf-profile outputs. With this
the result field is changed to string interpreting every non zero
value as errors. But these commands display on zero (>0) result.
For example before this commit the display was:

package-1
  die-0
    cpu-14
        get-config-levels:4

Here the get-config-levels is interpreted as error and displayed
as error with the above commit:

package-1
  die-0
    cpu-14
        get-config-levels:failed(error 4)

Fix this issue by not using isst_display_result() to display such results,
but define a new function which formats this data and prints.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel-speed-select/isst-config.c      |  4 ++--
 .../x86/intel-speed-select/isst-display.c     | 20 +++++++++++++++++++
 tools/power/x86/intel-speed-select/isst.h     |  3 ++-
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 6a54e165672d..2a9890c8395a 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -673,8 +673,8 @@ static void exec_on_get_ctdp_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 	if (ret)
 		perror("get_tdp_*");
 	else
-		isst_display_result(cpu, outf, "perf-profile", (char *)arg3,
-				    *(unsigned int *)arg4);
+		isst_ctdp_display_core_info(cpu, outf, arg3,
+					    *(unsigned int *)arg4);
 }
 
 #define _get_tdp_level(desc, suffix, object, help)                                \
diff --git a/tools/power/x86/intel-speed-select/isst-display.c b/tools/power/x86/intel-speed-select/isst-display.c
index 2e6e5fcdbd7c..40346d534f78 100644
--- a/tools/power/x86/intel-speed-select/isst-display.c
+++ b/tools/power/x86/intel-speed-select/isst-display.c
@@ -287,6 +287,26 @@ static void _isst_fact_display_information(int cpu, FILE *outf, int level,
 	format_and_print(outf, base_level + 2, header, value);
 }
 
+void isst_ctdp_display_core_info(int cpu, FILE *outf, char *prefix,
+				 unsigned int val)
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
+	snprintf(value, sizeof(value), "%u", val);
+	format_and_print(outf, 4, prefix, value);
+
+	format_and_print(outf, 1, NULL, NULL);
+}
+
 void isst_ctdp_display_information(int cpu, FILE *outf, int tdp_level,
 				   struct isst_pkg_ctdp *pkg_dev)
 {
diff --git a/tools/power/x86/intel-speed-select/isst.h b/tools/power/x86/intel-speed-select/isst.h
index 09e16a41b57c..d280b27d600d 100644
--- a/tools/power/x86/intel-speed-select/isst.h
+++ b/tools/power/x86/intel-speed-select/isst.h
@@ -195,6 +195,8 @@ extern void isst_get_process_ctdp_complete(int cpu,
 					   struct isst_pkg_ctdp *pkg_dev);
 extern void isst_ctdp_display_information(int cpu, FILE *outf, int tdp_level,
 					  struct isst_pkg_ctdp *pkg_dev);
+extern void isst_ctdp_display_core_info(int cpu, FILE *outf, char *prefix,
+					unsigned int val);
 extern void isst_ctdp_display_information_start(FILE *outf);
 extern void isst_ctdp_display_information_end(FILE *outf);
 extern void isst_pbf_display_information(int cpu, FILE *outf, int level,
@@ -235,5 +237,4 @@ extern void isst_display_result(int cpu, FILE *outf, char *feature, char *cmd,
 extern int isst_clos_get_clos_information(int cpu, int *enable, int *type);
 extern void isst_clos_display_clos_information(int cpu, FILE *outf,
 					       int clos_enable, int type);
-
 #endif
-- 
2.17.2

