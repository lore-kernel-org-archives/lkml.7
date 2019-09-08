Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC002C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 14:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980BA20854
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 14:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbfIHOmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 10:42:51 -0400
Received: from mga06.intel.com ([134.134.136.31]:48794 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbfIHOmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 10:42:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Sep 2019 07:42:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,481,1559545200"; 
   d="scan'208";a="213661486"
Received: from spandruv-mobl.amr.corp.intel.com ([10.252.4.36])
  by fmsmga002.fm.intel.com with ESMTP; 08 Sep 2019 07:42:45 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andy.shevchenko@gmail.com
Cc:     andriy.shevchenko@intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [UPDATE][PATCH 2/2] tools/power/x86/intel-speed-select: Display core count for bucket
Date:   Sun,  8 Sep 2019 07:42:25 -0700
Message-Id: <20190908144225.14574-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read the bucket and core count relationship via MSR and display
when displaying turbo ratio limits.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
Change:
Rebased on top of
git://git.infradead.org/linux-platform-drivers-x86.git remotes/origin/review-andy

 .../power/x86/intel-speed-select/isst-core.c  | 22 +++++++++++++++++++
 .../x86/intel-speed-select/isst-display.c     |  6 ++---
 tools/power/x86/intel-speed-select/isst.h     |  1 +
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-core.c b/tools/power/x86/intel-speed-select/isst-core.c
index f724322856ed..0bf341ad9697 100644
--- a/tools/power/x86/intel-speed-select/isst-core.c
+++ b/tools/power/x86/intel-speed-select/isst-core.c
@@ -188,6 +188,24 @@ int isst_get_get_trl(int cpu, int level, int avx_level, int *trl)
 	return 0;
 }
 
+int isst_get_trl_bucket_info(int cpu, unsigned long long *buckets_info)
+{
+	int ret;
+
+	debug_printf("cpu:%d bucket info via MSR\n", cpu);
+
+	*buckets_info = 0;
+
+	ret = isst_send_msr_command(cpu, 0x1ae, 0, buckets_info);
+	if (ret)
+		return ret;
+
+	debug_printf("cpu:%d bucket info via MSR successful 0x%llx\n", cpu,
+		     *buckets_info);
+
+	return 0;
+}
+
 int isst_set_tdp_level_msr(int cpu, int tdp_level)
 {
 	unsigned long long level = tdp_level;
@@ -563,6 +581,10 @@ int isst_get_process_ctdp(int cpu, int tdp_level, struct isst_pkg_ctdp *pkg_dev)
 		if (ret)
 			return ret;
 
+		ret = isst_get_trl_bucket_info(cpu, &ctdp_level->buckets_info);
+		if (ret)
+			return ret;
+
 		ret = isst_get_get_trl(cpu, i, 0,
 				       ctdp_level->trl_sse_active_cores);
 		if (ret)
diff --git a/tools/power/x86/intel-speed-select/isst-display.c b/tools/power/x86/intel-speed-select/isst-display.c
index 8500cf2997a6..df4aa99c4e92 100644
--- a/tools/power/x86/intel-speed-select/isst-display.c
+++ b/tools/power/x86/intel-speed-select/isst-display.c
@@ -372,7 +372,7 @@ void isst_ctdp_display_information(int cpu, FILE *outf, int tdp_level,
 			format_and_print(outf, base_level + 5, header, NULL);
 
 			snprintf(header, sizeof(header), "core-count");
-			snprintf(value, sizeof(value), "%d", j);
+			snprintf(value, sizeof(value), "%llu", (ctdp_level->buckets_info >> (j * 8)) & 0xff);
 			format_and_print(outf, base_level + 6, header, value);
 
 			snprintf(header, sizeof(header),
@@ -389,7 +389,7 @@ void isst_ctdp_display_information(int cpu, FILE *outf, int tdp_level,
 			format_and_print(outf, base_level + 5, header, NULL);
 
 			snprintf(header, sizeof(header), "core-count");
-			snprintf(value, sizeof(value), "%d", j);
+			snprintf(value, sizeof(value), "%llu", (ctdp_level->buckets_info >> (j * 8)) & 0xff);
 			format_and_print(outf, base_level + 6, header, value);
 
 			snprintf(header, sizeof(header),
@@ -407,7 +407,7 @@ void isst_ctdp_display_information(int cpu, FILE *outf, int tdp_level,
 			format_and_print(outf, base_level + 5, header, NULL);
 
 			snprintf(header, sizeof(header), "core-count");
-			snprintf(value, sizeof(value), "%d", j);
+			snprintf(value, sizeof(value), "%llu", (ctdp_level->buckets_info >> (j * 8)) & 0xff);
 			format_and_print(outf, base_level + 6, header, value);
 
 			snprintf(header, sizeof(header),
diff --git a/tools/power/x86/intel-speed-select/isst.h b/tools/power/x86/intel-speed-select/isst.h
index 221881761609..2f7f62765eb6 100644
--- a/tools/power/x86/intel-speed-select/isst.h
+++ b/tools/power/x86/intel-speed-select/isst.h
@@ -134,6 +134,7 @@ struct isst_pkg_ctdp_level_info {
 	size_t core_cpumask_size;
 	cpu_set_t *core_cpumask;
 	int cpu_count;
+	unsigned long long buckets_info;
 	int trl_sse_active_cores[ISST_TRL_MAX_ACTIVE_CORES];
 	int trl_avx_active_cores[ISST_TRL_MAX_ACTIVE_CORES];
 	int trl_avx_512_active_cores[ISST_TRL_MAX_ACTIVE_CORES];
-- 
2.17.2

