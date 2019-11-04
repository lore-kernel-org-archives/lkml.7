Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5591CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD8F21D81
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbfKDLDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 06:03:38 -0500
Received: from mga04.intel.com ([192.55.52.120]:13206 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbfKDLDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 06:03:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 03:03:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,267,1569308400"; 
   d="scan'208";a="232021225"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga002.fm.intel.com with ESMTP; 04 Nov 2019 03:03:08 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        prarit@redhat.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 04/10] tools/power/x86/intel-speed-select: Auto mode for CLX
Date:   Mon,  4 Nov 2019 03:02:40 -0800
Message-Id: <20191104110246.70465-5-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191104110246.70465-1-srinivas.pandruvada@linux.intel.com>
References: <20191104110246.70465-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an expectation in the CLX platform for SST base-freq feature that
Scaling min frequency be different for high and low priority cores.
This is the way the firmware will understand the priority.

So this change will look at high priority and low priority cores, and set
scaling_min_freq to P1High for high priority cores and P1Low to low
priority cores.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel-speed-select/isst-config.c      | 112 ++++++++++++++++--
 1 file changed, 100 insertions(+), 12 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index bfa42fc6c4d2..c563ecaf44e1 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -1095,7 +1095,73 @@ static int set_clos_param(int cpu, int clos, int epp, int wt, int min, int max)
 	return 0;
 }
 
-static int set_cpufreq_cpuinfo_scaling_min(int cpu, int max)
+static int set_cpufreq_scaling_min_max(int cpu, int max, int freq)
+{
+	char buffer[128], freq_str[16];
+	int fd, ret, len;
+
+	if (max)
+		snprintf(buffer, sizeof(buffer),
+			 "/sys/devices/system/cpu/cpu%d/cpufreq/scaling_max_freq", cpu);
+	else
+		snprintf(buffer, sizeof(buffer),
+			 "/sys/devices/system/cpu/cpu%d/cpufreq/scaling_min_freq", cpu);
+
+	fd = open(buffer, O_WRONLY);
+	if (fd < 0)
+		return fd;
+
+	snprintf(freq_str, sizeof(freq_str), "%d", freq);
+	len = strlen(freq_str);
+	ret = write(fd, freq_str, len);
+	if (ret == -1) {
+		close(fd);
+		return ret;
+	}
+	close(fd);
+
+	return 0;
+}
+
+static int set_clx_pbf_cpufreq_scaling_min_max(int cpu)
+{
+	struct isst_pkg_ctdp_level_info *ctdp_level;
+	struct isst_pbf_info *pbf_info;
+	int i, pkg_id, die_id, freq, freq_high, freq_low;
+	int ret;
+
+	ret = clx_n_config(cpu);
+	if (ret) {
+		perror("set_clx_pbf_cpufreq_scaling_min_max");
+		return ret;
+	}
+
+	ctdp_level = &clx_n_pkg_dev.ctdp_level[0];
+	pbf_info = &ctdp_level->pbf_info;
+	freq_high = pbf_info->p1_high * 100000;
+	freq_low = pbf_info->p1_low * 100000;
+
+	pkg_id = get_physical_package_id(cpu);
+	die_id = get_physical_die_id(cpu);
+	for (i = 0; i < get_topo_max_cpus(); ++i) {
+		if (pkg_id != get_physical_package_id(i) ||
+		    die_id != get_physical_die_id(i))
+			continue;
+
+		if (CPU_ISSET_S(i, pbf_info->core_cpumask_size,
+				  pbf_info->core_cpumask))
+			freq = freq_high;
+		else
+			freq = freq_low;
+
+		set_cpufreq_scaling_min_max(i, 1, freq);
+		set_cpufreq_scaling_min_max(i, 0, freq);
+	}
+
+	return 0;
+}
+
+static int set_cpufreq_scaling_min_max_from_cpuinfo(int cpu, int cpuinfo_max, int scaling_max)
 {
 	char buffer[128], min_freq[16];
 	int fd, ret, len;
@@ -1103,7 +1169,7 @@ static int set_cpufreq_cpuinfo_scaling_min(int cpu, int max)
 	if (!CPU_ISSET_S(cpu, present_cpumask_size, present_cpumask))
 		return -1;
 
-	if (max)
+	if (cpuinfo_max)
 		snprintf(buffer, sizeof(buffer),
 			 "/sys/devices/system/cpu/cpu%d/cpufreq/cpuinfo_max_freq", cpu);
 	else
@@ -1120,8 +1186,12 @@ static int set_cpufreq_cpuinfo_scaling_min(int cpu, int max)
 	if (len < 0)
 		return len;
 
-	snprintf(buffer, sizeof(buffer),
-		 "/sys/devices/system/cpu/cpu%d/cpufreq/scaling_min_freq", cpu);
+	if (scaling_max)
+		snprintf(buffer, sizeof(buffer),
+			 "/sys/devices/system/cpu/cpu%d/cpufreq/scaling_max_freq", cpu);
+	else
+		snprintf(buffer, sizeof(buffer),
+			 "/sys/devices/system/cpu/cpu%d/cpufreq/scaling_min_freq", cpu);
 
 	fd = open(buffer, O_WRONLY);
 	if (fd < 0)
@@ -1149,7 +1219,7 @@ static void set_scaling_min_to_cpuinfo_max(int cpu)
 		    die_id != get_physical_die_id(i))
 			continue;
 
-		set_cpufreq_cpuinfo_scaling_min(i, 1);
+		set_cpufreq_scaling_min_max_from_cpuinfo(i, 1, 0);
 	}
 }
 
@@ -1164,7 +1234,22 @@ static void set_scaling_min_to_cpuinfo_min(int cpu)
 		    die_id != get_physical_die_id(i))
 			continue;
 
-		set_cpufreq_cpuinfo_scaling_min(i, 0);
+		set_cpufreq_scaling_min_max_from_cpuinfo(i, 0, 0);
+	}
+}
+
+static void set_scaling_max_to_cpuinfo_max(int cpu)
+{
+	int i, pkg_id, die_id;
+
+	pkg_id = get_physical_package_id(cpu);
+	die_id = get_physical_die_id(cpu);
+	for (i = 0; i < get_topo_max_cpus(); ++i) {
+		if (pkg_id != get_physical_package_id(i) ||
+		    die_id != get_physical_die_id(i))
+			continue;
+
+		set_cpufreq_scaling_min_max_from_cpuinfo(i, 1, 1);
 	}
 }
 
@@ -1263,14 +1348,17 @@ static void set_pbf_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 	int status = *(int *)arg4;
 
 	if (is_clx_n_platform()) {
-		if (status == 0) {
-			ret = -1;
-			if (auto_mode)
-				set_scaling_min_to_cpuinfo_min(cpu);
-		} else {
+		if (status) {
 			ret = 0;
 			if (auto_mode)
-				set_scaling_min_to_cpuinfo_max(cpu);
+				set_clx_pbf_cpufreq_scaling_min_max(cpu);
+
+		} else {
+			ret = -1;
+			if (auto_mode) {
+				set_scaling_max_to_cpuinfo_max(cpu);
+				set_scaling_min_to_cpuinfo_min(cpu);
+			}
 		}
 		goto disp_result;
 	}
-- 
2.17.2

