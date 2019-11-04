Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBF0CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33A721D7F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbfKDLDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 06:03:10 -0500
Received: from mga04.intel.com ([192.55.52.120]:13206 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbfKDLDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 06:03:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 03:03:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,267,1569308400"; 
   d="scan'208";a="232021211"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga002.fm.intel.com with ESMTP; 04 Nov 2019 03:03:07 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        prarit@redhat.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 01/10] tools/power/x86/intel-speed-select: Extend command set for perf-profile
Date:   Mon,  4 Nov 2019 03:02:37 -0800
Message-Id: <20191104110246.70465-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191104110246.70465-1-srinivas.pandruvada@linux.intel.com>
References: <20191104110246.70465-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for uncore P0, uncore P1, P1 for base and AVX levels and
memory frequency. These commands are optional, so continue on
failure.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../power/x86/intel-speed-select/isst-core.c  | 67 +++++++++++++++++++
 .../x86/intel-speed-select/isst-display.c     | 39 ++++++++++-
 2 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/intel-speed-select/isst-core.c b/tools/power/x86/intel-speed-select/isst-core.c
index 67d32f2b9bea..ca3bd5b2cf45 100644
--- a/tools/power/x86/intel-speed-select/isst-core.c
+++ b/tools/power/x86/intel-speed-select/isst-core.c
@@ -95,6 +95,69 @@ int isst_get_pwr_info(int cpu, int config_index,
 	return 0;
 }
 
+void isst_get_uncore_p0_p1_info(int cpu, int config_index,
+				struct isst_pkg_ctdp_level_info *ctdp_level)
+{
+	unsigned int resp;
+	int ret;
+	ret = isst_send_mbox_command(cpu, CONFIG_TDP,
+				     CONFIG_TDP_GET_UNCORE_P0_P1_INFO, 0,
+				     config_index, &resp);
+	if (ret) {
+		ctdp_level->uncore_p0 = 0;
+		ctdp_level->uncore_p1 = 0;
+		return;
+	}
+
+	ctdp_level->uncore_p0 = resp & GENMASK(7, 0);
+	ctdp_level->uncore_p1 = (resp & GENMASK(15, 8)) >> 8;
+	debug_printf(
+		"cpu:%d ctdp:%d CONFIG_TDP_GET_UNCORE_P0_P1_INFO resp:%x uncore p0:%d uncore p1:%d\n",
+		cpu, config_index, resp, ctdp_level->uncore_p0,
+		ctdp_level->uncore_p1);
+}
+
+void isst_get_p1_info(int cpu, int config_index,
+		      struct isst_pkg_ctdp_level_info *ctdp_level)
+{
+	unsigned int resp;
+	int ret;
+	ret = isst_send_mbox_command(cpu, CONFIG_TDP, CONFIG_TDP_GET_P1_INFO, 0,
+				     config_index, &resp);
+	if (ret) {
+		ctdp_level->sse_p1 = 0;
+		ctdp_level->avx2_p1 = 0;
+		ctdp_level->avx512_p1 = 0;
+		return;
+	}
+
+	ctdp_level->sse_p1 = resp & GENMASK(7, 0);
+	ctdp_level->avx2_p1 = (resp & GENMASK(15, 8)) >> 8;
+	ctdp_level->avx512_p1 = (resp & GENMASK(23, 16)) >> 16;
+	debug_printf(
+		"cpu:%d ctdp:%d CONFIG_TDP_GET_P1_INFO resp:%x sse_p1:%d avx2_p1:%d avx512_p1:%d\n",
+		cpu, config_index, resp, ctdp_level->sse_p1,
+		ctdp_level->avx2_p1, ctdp_level->avx512_p1);
+}
+
+void isst_get_uncore_mem_freq(int cpu, int config_index,
+			      struct isst_pkg_ctdp_level_info *ctdp_level)
+{
+	unsigned int resp;
+	int ret;
+	ret = isst_send_mbox_command(cpu, CONFIG_TDP, CONFIG_TDP_GET_MEM_FREQ,
+				     0, config_index, &resp);
+	if (ret) {
+		ctdp_level->mem_freq = 0;
+		return;
+	}
+
+	ctdp_level->mem_freq = resp & GENMASK(7, 0);
+	debug_printf(
+		"cpu:%d ctdp:%d CONFIG_TDP_GET_MEM_FREQ resp:%x uncore mem_freq:%d\n",
+		cpu, config_index, resp, ctdp_level->mem_freq);
+}
+
 int isst_get_tjmax_info(int cpu, int config_index,
 			struct isst_pkg_ctdp_level_info *ctdp_level)
 {
@@ -600,6 +663,10 @@ int isst_get_process_ctdp(int cpu, int tdp_level, struct isst_pkg_ctdp *pkg_dev)
 		if (ret)
 			return ret;
 
+		isst_get_uncore_p0_p1_info(cpu, i, ctdp_level);
+		isst_get_p1_info(cpu, i, ctdp_level);
+		isst_get_uncore_mem_freq(cpu, i, ctdp_level);
+
 		if (ctdp_level->pbf_support) {
 			ret = isst_get_pbf_info(cpu, i, &ctdp_level->pbf_info);
 			if (!ret)
diff --git a/tools/power/x86/intel-speed-select/isst-display.c b/tools/power/x86/intel-speed-select/isst-display.c
index 8309810e7425..d330f7a90c76 100644
--- a/tools/power/x86/intel-speed-select/isst-display.c
+++ b/tools/power/x86/intel-speed-select/isst-display.c
@@ -352,10 +352,47 @@ void isst_ctdp_display_information(int cpu, FILE *outf, int tdp_level,
 		format_and_print(outf, base_level + 4, header, value);
 
 		snprintf(header, sizeof(header), "base-frequency(MHz)");
+		if (!ctdp_level->sse_p1)
+			ctdp_level->sse_p1 = ctdp_level->tdp_ratio;
 		snprintf(value, sizeof(value), "%d",
-			 ctdp_level->tdp_ratio * DISP_FREQ_MULTIPLIER);
+			  ctdp_level->sse_p1 * DISP_FREQ_MULTIPLIER);
 		format_and_print(outf, base_level + 4, header, value);
 
+		if (ctdp_level->avx2_p1) {
+			snprintf(header, sizeof(header), "base-frequency-avx2(MHz)");
+			snprintf(value, sizeof(value), "%d",
+				 ctdp_level->avx2_p1 * DISP_FREQ_MULTIPLIER);
+			format_and_print(outf, base_level + 4, header, value);
+		}
+
+		if (ctdp_level->avx512_p1) {
+			snprintf(header, sizeof(header), "base-frequency-avx512(MHz)");
+			snprintf(value, sizeof(value), "%d",
+				 ctdp_level->avx512_p1 * DISP_FREQ_MULTIPLIER);
+			format_and_print(outf, base_level + 4, header, value);
+		}
+
+		if (ctdp_level->uncore_p1) {
+			snprintf(header, sizeof(header), "uncore-frequency-min(MHz)");
+			snprintf(value, sizeof(value), "%d",
+				 ctdp_level->uncore_p1 * DISP_FREQ_MULTIPLIER);
+			format_and_print(outf, base_level + 4, header, value);
+		}
+
+		if (ctdp_level->uncore_p0) {
+			snprintf(header, sizeof(header), "uncore-frequency-max(MHz)");
+			snprintf(value, sizeof(value), "%d",
+				 ctdp_level->uncore_p0 * DISP_FREQ_MULTIPLIER);
+			format_and_print(outf, base_level + 4, header, value);
+		}
+
+		if (ctdp_level->mem_freq) {
+			snprintf(header, sizeof(header), "mem-frequency(MHz)");
+			snprintf(value, sizeof(value), "%d",
+				 ctdp_level->mem_freq * DISP_FREQ_MULTIPLIER);
+			format_and_print(outf, base_level + 4, header, value);
+		}
+
 		snprintf(header, sizeof(header),
 			 "speed-select-turbo-freq");
 		if (ctdp_level->fact_support) {
-- 
2.17.2

