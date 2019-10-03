Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE874C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996B520700
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbfJCML0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 08:11:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55444 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729191AbfJCMLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 08:11:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 873E33084025;
        Thu,  3 Oct 2019 12:11:23 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A3AB5C226;
        Thu,  3 Oct 2019 12:11:22 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH v2 3/7] intel-speed-select: Add check for CascadeLake-N models
Date:   Thu,  3 Oct 2019 08:11:08 -0400
Message-Id: <20191003121112.25870-4-prarit@redhat.com>
In-Reply-To: <20191003121112.25870-1-prarit@redhat.com>
References: <20191003121112.25870-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 03 Oct 2019 12:11:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three CascadeLake-N models (6252N, 6230N, and 5218N) have SST-PBF support.

Return an error if the CascadeLake processor is not one of these specific
models.

v2: Add is_clx_n_platform()

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 .../x86/intel-speed-select/isst-config.c      | 44 ++++++++++++++++++-
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index f4a23678416e..734a7960458c 100644
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
@@ -82,6 +92,34 @@ static void update_cpu_model(void)
 	cpu_model = (fms >> 4) & 0xf;
 	if (family == 6 || family == 0xf)
 		cpu_model += ((fms >> 16) & 0xf) << 4;
+
+	cpu_stepping = fms & 0xf;
+
+	/* only three CascadeLake-N models are supported */
+	if (is_clx_n_platform()) {
+		FILE *fp;
+		size_t n;
+		char *line;
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
@@ -1889,7 +1927,9 @@ static void cmdline(int argc, char **argv)
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
2.18.1

