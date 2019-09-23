Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3ECEC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 13:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A700205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 13:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439748AbfIWNQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 09:16:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37086 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407227AbfIWNQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 09:16:49 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2C6C210C093E;
        Mon, 23 Sep 2019 13:16:48 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F5DA60BFB;
        Mon, 23 Sep 2019 13:16:47 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/2] intel-speed-select: Display turbo frequencies in a table
Date:   Mon, 23 Sep 2019 09:16:38 -0400
Message-Id: <20190923131638.6668-3-prarit@redhat.com>
In-Reply-To: <20190923131638.6668-1-prarit@redhat.com>
References: <20190923131638.6668-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Mon, 23 Sep 2019 13:16:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The output of turbo frequencies is also long (each bucket has
3 lines and the headers).  This can be shrunk down into a table that is
easier to consume for both scripts and humans.

Display the turbo and clip frequencies in a table.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel-speed-select/isst-display.c     | 116 ++++++++++--------
 1 file changed, 63 insertions(+), 53 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-display.c b/tools/power/x86/intel-speed-select/isst-display.c
index 9b0ae0831a60..16843e0f78f0 100644
--- a/tools/power/x86/intel-speed-select/isst-display.c
+++ b/tools/power/x86/intel-speed-select/isst-display.c
@@ -213,6 +213,52 @@ static void _isst_pbf_display_information(int cpu, FILE *outf, int level,
 	format_and_print(outf, disp_level + 1, header, value);
 }
 
+static void _isst_fact_display_frequencies(FILE *outf, int fact_avx, int level,
+					   char *description, int bucket,
+					   int core_count, int sse,
+					   int avx, int avx512)
+{
+	char header[256];
+	int ret;
+	void *header_ptr;
+	int header_size;
+
+	header_ptr = header;
+	if (core_count > 0)
+		ret = snprintf(header_ptr, sizeof(header), "%s%d %6d ",
+			       description, bucket, core_count);
+	else
+		ret = snprintf(header_ptr, sizeof(header), "%s%6s ",
+			       description, "-");
+
+
+	header_ptr += ret;
+	header_size = header_ptr - (void *) header;
+	if (fact_avx & 0x01)
+		ret = snprintf(header_ptr, header_size, "%12d ",
+			       sse * DISP_FREQ_MULTIPLIER);
+	else
+		ret = snprintf(header_ptr, header_size, "%12s ", "- ");
+
+	header_ptr += ret;
+	header_size = header_ptr - (void *) header;
+	if (fact_avx & 0x02)
+		ret = snprintf(header_ptr, header_size, "%12d ",
+			       avx * DISP_FREQ_MULTIPLIER);
+	else
+		ret = snprintf(header_ptr, header_size, "%12s ", "- ");
+
+	header_ptr += ret;
+	header_size = header_ptr - (void *) header;
+	if (fact_avx & 0x04)
+		ret = snprintf(header_ptr, header_size, "%12d",
+			       avx512 * DISP_FREQ_MULTIPLIER);
+	else
+		ret = snprintf(header_ptr, header_size, "%12s", "-");
+
+	format_and_print(outf, level + 1, header, NULL);
+}
+
 static void _isst_fact_display_information(int cpu, FILE *outf, int level,
 					   int fact_bucket, int fact_avx,
 					   struct isst_fact_info *fact_info,
@@ -220,11 +266,14 @@ static void _isst_fact_display_information(int cpu, FILE *outf, int level,
 {
 	struct isst_fact_bucket_info *bucket_info = fact_info->bucket_info;
 	char header[256];
-	char value[256];
 	int j;
 
 	snprintf(header, sizeof(header), "speed-select-turbo-freq");
 	format_and_print(outf, base_level, header, NULL);
+	snprintf(header, sizeof(header),"%11s %s %s %s %s",
+		 "", "core-count", "max-sse(MHz)" , "max-avx2(MHz)", "max-avx512(MHz)");
+	format_and_print(outf, base_level + 1, header, NULL);
+
 	for (j = 0; j < ISST_FACT_MAX_BUCKETS; ++j) {
 		if (fact_bucket != 0xff && fact_bucket != j)
 			continue;
@@ -232,59 +281,20 @@ static void _isst_fact_display_information(int cpu, FILE *outf, int level,
 		if (!bucket_info[j].high_priority_cores_count)
 			break;
 
-		snprintf(header, sizeof(header), "bucket-%d", j);
-		format_and_print(outf, base_level + 1, header, NULL);
-
-		snprintf(header, sizeof(header), "high-priority-cores-count");
-		snprintf(value, sizeof(value), "%d",
-			 bucket_info[j].high_priority_cores_count);
-		format_and_print(outf, base_level + 2, header, value);
-
-		if (fact_avx & 0x01) {
-			snprintf(header, sizeof(header),
-				 "high-priority-max-frequency(MHz)");
-			snprintf(value, sizeof(value), "%d",
-				 bucket_info[j].sse_trl * DISP_FREQ_MULTIPLIER);
-			format_and_print(outf, base_level + 2, header, value);
-		}
-
-		if (fact_avx & 0x02) {
-			snprintf(header, sizeof(header),
-				 "high-priority-max-avx2-frequency(MHz)");
-			snprintf(value, sizeof(value), "%d",
-				 bucket_info[j].avx_trl * DISP_FREQ_MULTIPLIER);
-			format_and_print(outf, base_level + 2, header, value);
-		}
-
-		if (fact_avx & 0x04) {
-			snprintf(header, sizeof(header),
-				 "high-priority-max-avx512-frequency(MHz)");
-			snprintf(value, sizeof(value), "%d",
-				 bucket_info[j].avx512_trl *
-					 DISP_FREQ_MULTIPLIER);
-			format_and_print(outf, base_level + 2, header, value);
-		}
+		_isst_fact_display_frequencies(
+			outf, fact_avx, base_level + 1, "bucket-", j,
+			bucket_info[j].high_priority_cores_count,
+			bucket_info[j].sse_trl,
+			bucket_info[j].avx_trl,
+			bucket_info[j].avx512_trl);
 	}
-	snprintf(header, sizeof(header),
-		 "speed-select-turbo-freq-clip-frequencies");
-	format_and_print(outf, base_level + 1, header, NULL);
-	snprintf(header, sizeof(header), "low-priority-max-frequency(MHz)");
-	snprintf(value, sizeof(value), "%d",
-		 fact_info->lp_clipping_ratio_license_sse *
-			 DISP_FREQ_MULTIPLIER);
-	format_and_print(outf, base_level + 2, header, value);
-	snprintf(header, sizeof(header),
-		 "low-priority-max-avx2-frequency(MHz)");
-	snprintf(value, sizeof(value), "%d",
-		 fact_info->lp_clipping_ratio_license_avx2 *
-			 DISP_FREQ_MULTIPLIER);
-	format_and_print(outf, base_level + 2, header, value);
-	snprintf(header, sizeof(header),
-		 "low-priority-max-avx512-frequency(MHz)");
-	snprintf(value, sizeof(value), "%d",
-		 fact_info->lp_clipping_ratio_license_avx512 *
-			 DISP_FREQ_MULTIPLIER);
-	format_and_print(outf, base_level + 2, header, value);
+
+	_isst_fact_display_frequencies(
+			outf, fact_avx, base_level + 1, "clip-freq", 1,
+			-1, /* no core-count */
+			fact_info->lp_clipping_ratio_license_sse,
+			fact_info->lp_clipping_ratio_license_avx2,
+			fact_info->lp_clipping_ratio_license_avx512);
 }
 
 static void isst_turbo_ratio_limits(FILE *outf, char *header_name,
-- 
2.21.0

