Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A19C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3332070C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389145AbfIEMDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 08:03:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:22287 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389072AbfIEMDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:03:24 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0DB447FDCD;
        Thu,  5 Sep 2019 12:03:24 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B065100194E;
        Thu,  5 Sep 2019 12:03:23 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     andriy.shevchenko@intel.com, Prarit Bhargava <prarit@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Arcari <darcari@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/9] tools/power/x86/intel-speed-select: Switch output to MHz
Date:   Thu,  5 Sep 2019 08:03:07 -0400
Message-Id: <20190905120311.15286-6-prarit@redhat.com>
In-Reply-To: <20190905120311.15286-1-prarit@redhat.com>
References: <20190905120311.15286-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 05 Sep 2019 12:03:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These features are introduced on new processors that will never operate
in the KHz range.

Save some zeros and switch the output to MHz.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: David Arcari <darcari@redhat.com>
Cc: linux-kernel@vger.kernel.org
---
 .../x86/intel-speed-select/isst-display.c     | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-display.c b/tools/power/x86/intel-speed-select/isst-display.c
index 3ae693efceaa..4ec1924ff7a9 100644
--- a/tools/power/x86/intel-speed-select/isst-display.c
+++ b/tools/power/x86/intel-speed-select/isst-display.c
@@ -6,7 +6,7 @@
 
 #include "isst.h"
 
-#define DISP_FREQ_MULTIPLIER 100000
+#define DISP_FREQ_MULTIPLIER 100
 
 static void printcpumask(int str_len, char *str, int mask_size,
 			 cpu_set_t *cpu_mask)
@@ -156,7 +156,7 @@ static void _isst_pbf_display_information(int cpu, FILE *outf, int level,
 	snprintf(header, sizeof(header), "speed-select-base-freq");
 	format_and_print(outf, disp_level, header, NULL);
 
-	snprintf(header, sizeof(header), "high-priority-base-frequency(KHz)");
+	snprintf(header, sizeof(header), "high-priority-base-frequency(MHz)");
 	snprintf(value, sizeof(value), "%d",
 		 pbf_info->p1_high * DISP_FREQ_MULTIPLIER);
 	format_and_print(outf, disp_level + 1, header, value);
@@ -166,7 +166,7 @@ static void _isst_pbf_display_information(int cpu, FILE *outf, int level,
 		     pbf_info->core_cpumask);
 	format_and_print(outf, disp_level + 1, header, value);
 
-	snprintf(header, sizeof(header), "low-priority-base-frequency(KHz)");
+	snprintf(header, sizeof(header), "low-priority-base-frequency(MHz)");
 	snprintf(value, sizeof(value), "%d",
 		 pbf_info->p1_low * DISP_FREQ_MULTIPLIER);
 	format_and_print(outf, disp_level + 1, header, value);
@@ -209,7 +209,7 @@ static void _isst_fact_display_information(int cpu, FILE *outf, int level,
 
 		if (fact_avx & 0x01) {
 			snprintf(header, sizeof(header),
-				 "high-priority-max-frequency(KHz)");
+				 "high-priority-max-frequency(MHz)");
 			snprintf(value, sizeof(value), "%d",
 				 bucket_info[j].sse_trl * DISP_FREQ_MULTIPLIER);
 			format_and_print(outf, base_level + 2, header, value);
@@ -217,7 +217,7 @@ static void _isst_fact_display_information(int cpu, FILE *outf, int level,
 
 		if (fact_avx & 0x02) {
 			snprintf(header, sizeof(header),
-				 "high-priority-max-avx2-frequency(KHz)");
+				 "high-priority-max-avx2-frequency(MHz)");
 			snprintf(value, sizeof(value), "%d",
 				 bucket_info[j].avx_trl * DISP_FREQ_MULTIPLIER);
 			format_and_print(outf, base_level + 2, header, value);
@@ -225,7 +225,7 @@ static void _isst_fact_display_information(int cpu, FILE *outf, int level,
 
 		if (fact_avx & 0x04) {
 			snprintf(header, sizeof(header),
-				 "high-priority-max-avx512-frequency(KHz)");
+				 "high-priority-max-avx512-frequency(MHz)");
 			snprintf(value, sizeof(value), "%d",
 				 bucket_info[j].avx512_trl *
 					 DISP_FREQ_MULTIPLIER);
@@ -235,19 +235,19 @@ static void _isst_fact_display_information(int cpu, FILE *outf, int level,
 	snprintf(header, sizeof(header),
 		 "speed-select-turbo-freq-clip-frequencies");
 	format_and_print(outf, base_level + 1, header, NULL);
-	snprintf(header, sizeof(header), "low-priority-max-frequency(KHz)");
+	snprintf(header, sizeof(header), "low-priority-max-frequency(MHz)");
 	snprintf(value, sizeof(value), "%d",
 		 fact_info->lp_clipping_ratio_license_sse *
 			 DISP_FREQ_MULTIPLIER);
 	format_and_print(outf, base_level + 2, header, value);
 	snprintf(header, sizeof(header),
-		 "low-priority-max-avx2-frequency(KHz)");
+		 "low-priority-max-avx2-frequency(MHz)");
 	snprintf(value, sizeof(value), "%d",
 		 fact_info->lp_clipping_ratio_license_avx2 *
 			 DISP_FREQ_MULTIPLIER);
 	format_and_print(outf, base_level + 2, header, value);
 	snprintf(header, sizeof(header),
-		 "low-priority-max-avx512-frequency(KHz)");
+		 "low-priority-max-avx512-frequency(MHz)");
 	snprintf(value, sizeof(value), "%d",
 		 fact_info->lp_clipping_ratio_license_avx512 *
 			 DISP_FREQ_MULTIPLIER);
@@ -291,7 +291,7 @@ void isst_ctdp_display_information(int cpu, FILE *outf, int tdp_level,
 		snprintf(value, sizeof(value), "%d", ctdp_level->tdp_ratio);
 		format_and_print(outf, base_level + 4, header, value);
 
-		snprintf(header, sizeof(header), "base-frequency(KHz)");
+		snprintf(header, sizeof(header), "base-frequency(MHz)");
 		snprintf(value, sizeof(value), "%d",
 			 ctdp_level->tdp_ratio * DISP_FREQ_MULTIPLIER);
 		format_and_print(outf, base_level + 4, header, value);
-- 
2.21.0

