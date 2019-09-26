Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A11C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 12:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40780222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 12:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfIZMzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 08:55:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41222 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbfIZMzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 08:55:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 62B8B10C0929;
        Thu, 26 Sep 2019 12:55:16 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA29E60933;
        Thu, 26 Sep 2019 12:55:15 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 4/7] intel-speed-select: Add configuration for CascadeLake-N
Date:   Thu, 26 Sep 2019 08:54:58 -0400
Message-Id: <20190926125501.1616-5-prarit@redhat.com>
In-Reply-To: <20190926125501.1616-1-prarit@redhat.com>
References: <20190926125501.1616-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Thu, 26 Sep 2019 12:55:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a 'dummy' pkg_dev struct for use by CascadeLake-N processors.  This
struct will be used in later patches to implement info and status calls
for CascadeLake-N SST-BF.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel-speed-select/isst-config.c      | 98 ++++++++++++++++++-
 .../x86/intel-speed-select/isst-display.c     |  2 -
 tools/power/x86/intel-speed-select/isst.h     |  2 +
 3 files changed, 99 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index ae8e3b5153ad..33f328d971d3 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -735,6 +735,94 @@ _get_tdp_level("get-config-current_level", levels, current_level,
 	       "Current TDP Level");
 _get_tdp_level("get-lock-status", levels, locked, "TDP lock status");
 
+struct isst_pkg_ctdp cn_pkg_dev;
+
+static int cn_get_base_ratio(void)
+{
+	FILE *fp;
+	char *begin, *end, *line;
+	char number[5];
+	float value = 0;
+	size_t n;
+
+	fp = fopen("/proc/cpuinfo", "r");
+	if (!fp)
+		err(-1, "cannot open /proc/cpuinfo\n");
+
+	while (getline(&line, &n, fp) > 0) {
+		if (strstr(line, "model name")) {
+			/* this is true for CascadeLake-N */
+			begin = strstr(line, "@ ") + 2;
+			end = strstr(line, "GHz");
+			strncpy(number, begin, end - begin);
+			value = atof(number) * 10;
+			break;
+		}
+	}
+	free(line);
+	fclose(fp);
+
+	return (int)(value);
+}
+
+static void cascadelaken_config(void)
+{
+	int i;
+	unsigned long cpu_bf;
+	struct isst_pkg_ctdp_level_info *ctdp_level;
+	struct isst_pbf_info *pbf_info;
+
+	ctdp_level = &cn_pkg_dev.ctdp_level[0];
+	pbf_info = &ctdp_level->pbf_info;
+
+	/* find the frequency base ratio */
+	ctdp_level->tdp_ratio = cn_get_base_ratio();
+	if (ctdp_level->tdp_ratio == 0)
+		err(-1, "cn base ratio is zero\n");
+
+	/* find the high and low priority frequencies */
+	pbf_info->p1_high = 0;
+	pbf_info->p1_low = ~0;
+	for (i = 0; i < topo_max_cpus; i++) {
+		cpu_bf = parse_int_file(1,
+			"/sys/devices/system/cpu/cpu%d/cpufreq/base_frequency",
+					i);
+		if (cpu_bf > pbf_info->p1_high)
+			pbf_info->p1_high = cpu_bf;
+		if (cpu_bf < pbf_info->p1_low)
+			pbf_info->p1_low = cpu_bf;
+	}
+
+	if (pbf_info->p1_high == ~0UL)
+		err(-1, "maximum base frequency not set\n");
+
+	if (pbf_info->p1_low == 0)
+		err(-1, "minimum base frequency not set\n");
+
+	/* convert frequencies back to ratios */
+	pbf_info->p1_high = pbf_info->p1_high / DISP_FREQ_MULTIPLIER;
+	pbf_info->p1_low = pbf_info->p1_low / DISP_FREQ_MULTIPLIER;
+
+	/* create high priority cpu mask */
+	pbf_info->core_cpumask_size = alloc_cpu_set(&pbf_info->core_cpumask);
+	for (i = 0; i < topo_max_cpus; i++) {
+		cpu_bf = parse_int_file(1,
+			"/sys/devices/system/cpu/cpu%d/cpufreq/base_frequency",
+					i);
+		cpu_bf = cpu_bf / DISP_FREQ_MULTIPLIER;
+		if (cpu_bf == pbf_info->p1_high)
+			CPU_SET_S(i, pbf_info->core_cpumask_size,
+				  pbf_info->core_cpumask);
+	}
+
+	/* extra ctdp & pbf struct parameters */
+	ctdp_level->processed = 1;
+	ctdp_level->pbf_support = 1; /* PBF is always supported and enabled */
+	ctdp_level->pbf_enabled = 1;
+	ctdp_level->fact_support = 0; /* FACT is never supported */
+	ctdp_level->fact_enabled = 0;
+}
+
 static void dump_isst_config_for_cpu(int cpu, void *arg1, void *arg2,
 				     void *arg3, void *arg4)
 {
@@ -1546,7 +1634,10 @@ void process_command(int argc, char **argv,
 		}
 	}
 
-	create_cpu_map();
+	if (cpu_model != 0x55)
+		create_cpu_map();
+	else
+		cascadelaken_config();
 
 	i = 0;
 	while (cmds[i].feature) {
@@ -1562,6 +1653,11 @@ void process_command(int argc, char **argv,
 
 	if (!matched)
 		fprintf(stderr, "Invalid command\n");
+
+	if (cpu_model != 0x55) {
+		/* this was allocated in cascadelaken_config() */
+		free_cpu_set(cn_pkg_dev.ctdp_level[0].pbf_info.core_cpumask);
+	}
 }
 
 static void usage(void)
diff --git a/tools/power/x86/intel-speed-select/isst-display.c b/tools/power/x86/intel-speed-select/isst-display.c
index 40346d534f78..1caa7ae25245 100644
--- a/tools/power/x86/intel-speed-select/isst-display.c
+++ b/tools/power/x86/intel-speed-select/isst-display.c
@@ -6,8 +6,6 @@
 
 #include "isst.h"
 
-#define DISP_FREQ_MULTIPLIER 100
-
 static void printcpulist(int str_len, char *str, int mask_size,
 			 cpu_set_t *cpu_mask)
 {
diff --git a/tools/power/x86/intel-speed-select/isst.h b/tools/power/x86/intel-speed-select/isst.h
index d280b27d600d..0dcae17b3945 100644
--- a/tools/power/x86/intel-speed-select/isst.h
+++ b/tools/power/x86/intel-speed-select/isst.h
@@ -69,6 +69,8 @@
 #define PM_CLOS_OFFSET				0x08
 #define PQR_ASSOC_OFFSET			0x20
 
+#define DISP_FREQ_MULTIPLIER 100
+
 struct isst_clos_config {
 	int pkg_id;
 	int die_id;
-- 
2.21.0

