Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D19C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3328C206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbfJGTbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 15:31:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:26154 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728079AbfJGTbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:31:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 12:31:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="192372880"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga008.fm.intel.com with ESMTP; 07 Oct 2019 12:31:08 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        prarit@redhat.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 3/6] tools/power/x86/intel-speed-select: Add check for CascadeLake-N models
Date:   Mon,  7 Oct 2019 12:30:57 -0700
Message-Id: <20191007193100.36934-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191007193100.36934-1-srinivas.pandruvada@linux.intel.com>
References: <20191007193100.36934-1-srinivas.pandruvada@linux.intel.com>
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

