Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23ECC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97DB208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfJJU3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 16:29:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:42451 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbfJJU3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 16:29:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2019 13:29:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,281,1566889200"; 
   d="scan'208";a="277902035"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga001.jf.intel.com with ESMTP; 10 Oct 2019 13:29:51 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@intel.com
Cc:     prarit@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RESEND][PATCH 07/10] tools/power/x86/intel-speed-select: Add check for CascadeLake-N models
Date:   Thu, 10 Oct 2019 13:29:42 -0700
Message-Id: <20191010202945.73616-8-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191010202945.73616-1-srinivas.pandruvada@linux.intel.com>
References: <20191010202945.73616-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prarit Bhargava <prarit@redhat.com>

Three CascadeLake-N models (6252N, 6230N, and 5218N) have SST-PBF support.

Return an error if the CascadeLake processor is not one of these specific
models.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel-speed-select/isst-config.c      | 43 ++++++++++++++++++-
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 907b79e16c68..67a866e2dac4 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -23,6 +23,7 @@ static int debug_flag;
 static FILE *outf;
 
 static int cpu_model;
+static int cpu_stepping;
 
 #define MAX_CPUS_IN_ONE_REQ 64
 static short max_target_cpus;
@@ -72,7 +73,16 @@ void debug_printf(const char *format, ...)
 	va_end(args);
 }
 
-static void update_cpu_model(void)
+
+int is_clx_n_platform(void)
+{
+	if (cpu_model == 0x55)
+		if (cpu_stepping == 0x6 || cpu_stepping == 0x7)
+			return 1;
+	return 0;
+}
+
+static int update_cpu_model(void)
 {
 	unsigned int ebx, ecx, edx;
 	unsigned int fms, family;
@@ -82,6 +92,33 @@ static void update_cpu_model(void)
 	cpu_model = (fms >> 4) & 0xf;
 	if (family == 6 || family == 0xf)
 		cpu_model += ((fms >> 16) & 0xf) << 4;
+
+	cpu_stepping = fms & 0xf;
+	/* only three CascadeLake-N models are supported */
+	if (is_clx_n_platform()) {
+		FILE *fp;
+		size_t n = 0;
+		char *line = NULL;
+		int ret = 1;
+
+		fp = fopen("/proc/cpuinfo", "r");
+		if (!fp)
+			err(-1, "cannot open /proc/cpuinfo\n");
+
+		while (getline(&line, &n, fp) > 0) {
+			if (strstr(line, "model name")) {
+				if (strstr(line, "6252N") ||
+				    strstr(line, "6230N") ||
+				    strstr(line, "5218N"))
+					ret = 0;
+				break;
+			}
+		}
+		free(line);
+		fclose(fp);
+		return ret;
+	}
+	return 0;
 }
 
 /* Open a file, and exit on failure */
@@ -1956,7 +1993,9 @@ static void cmdline(int argc, char **argv)
 		fprintf(stderr, "Feature name and|or command not specified\n");
 		exit(0);
 	}
-	update_cpu_model();
+	ret = update_cpu_model();
+	if (ret)
+		err(-1, "Invalid CPU model (%d)\n", cpu_model);
 	printf("Intel(R) Speed Select Technology\n");
 	printf("Executing on CPU model:%d[0x%x]\n", cpu_model, cpu_model);
 	set_max_cpu_num();
-- 
2.17.2

