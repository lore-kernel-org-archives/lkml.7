Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7A7C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 23:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0327E2067B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 23:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389240AbfIEXhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 19:37:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:5012 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732468AbfIEXhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 19:37:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2019 16:37:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,471,1559545200"; 
   d="scan'208";a="190650480"
Received: from spandruv-mobl.amr.corp.intel.com ([10.251.155.245])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Sep 2019 16:37:51 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@intel.com
Cc:     prarit@redhat.com, darcari@redhat.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/2] tools/power/x86/intel-speed-select: Display core count for bucket
Date:   Thu,  5 Sep 2019 16:37:48 -0700
Message-Id: <20190905233748.6822-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190905233748.6822-1-srinivas.pandruvada@linux.intel.com>
References: <20190905233748.6822-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read the bucket and core count relationship via MSR and display
when displaying turbo ratio limits.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../power/x86/intel-speed-select/isst-core.c  | 22 +++++++++++++++++++
 .../x86/intel-speed-select/isst-display.c     |  6 ++---
 tools/power/x86/intel-speed-select/isst.h     |  1 +
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-core.c b/tools/power/x86/intel-speed-select/isst-core.c
index 8de4ac39a008..2f864c4b994d 100644
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
 	int ret;
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

