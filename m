Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7008EC3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 13:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5128020673
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 13:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439589AbfIWNQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 09:16:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57076 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405137AbfIWNQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 09:16:48 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7D209356DC;
        Mon, 23 Sep 2019 13:16:47 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE68460C63;
        Mon, 23 Sep 2019 13:16:44 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/2] intel-speed-select: Display turbo-ratio-limits as a table
Date:   Mon, 23 Sep 2019 09:16:37 -0400
Message-Id: <20190923131638.6668-2-prarit@redhat.com>
In-Reply-To: <20190923131638.6668-1-prarit@redhat.com>
References: <20190923131638.6668-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 23 Sep 2019 13:16:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The output of the Turbo Ratio Limits is 75 lines long (each bucket has
3 lines and the headers).  This can be shrunk down into a table that is
easier to consume for both scripts and humans.

Display Turbo Ratio Limits in a table.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel-speed-select/isst-display.c     | 86 ++++++++-----------
 1 file changed, 34 insertions(+), 52 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-display.c b/tools/power/x86/intel-speed-select/isst-display.c
index df4aa99c4e92..9b0ae0831a60 100644
--- a/tools/power/x86/intel-speed-select/isst-display.c
+++ b/tools/power/x86/intel-speed-select/isst-display.c
@@ -287,6 +287,28 @@ static void _isst_fact_display_information(int cpu, FILE *outf, int level,
 	format_and_print(outf, base_level + 2, header, value);
 }
 
+static void isst_turbo_ratio_limits(FILE *outf, char *header_name,
+				    int *active_cores,
+				    unsigned long long buckets_info,
+				    int base_level)
+{
+	char header[256];
+	int i;
+
+	snprintf(header, sizeof(header), header_name);
+	format_and_print(outf, base_level, header, NULL);
+	snprintf(header, sizeof(header),"%11s %8s %8s",
+		 "" , "core-count", "max_freq(MHz)");
+	format_and_print(outf, base_level + 1, header, NULL);
+
+	for (i = 0; i < 8; ++i) {
+		snprintf(header, sizeof (header), "bucket-%d %8lld %12d", i,
+			 (buckets_info >> (i * 8)) & 0xff,
+			 active_cores[i] * DISP_FREQ_MULTIPLIER);
+		format_and_print(outf, base_level + 1, header, NULL);
+	}
+}
+
 void isst_ctdp_display_information(int cpu, FILE *outf, int tdp_level,
 				   struct isst_pkg_ctdp *pkg_dev)
 {
@@ -365,58 +387,18 @@ void isst_ctdp_display_information(int cpu, FILE *outf, int tdp_level,
 		snprintf(value, sizeof(value), "%d", ctdp_level->t_proc_hot);
 		format_and_print(outf, base_level + 4, header, value);
 
-		snprintf(header, sizeof(header), "turbo-ratio-limits-sse");
-		format_and_print(outf, base_level + 4, header, NULL);
-		for (j = 0; j < 8; ++j) {
-			snprintf(header, sizeof(header), "bucket-%d", j);
-			format_and_print(outf, base_level + 5, header, NULL);
-
-			snprintf(header, sizeof(header), "core-count");
-			snprintf(value, sizeof(value), "%llu", (ctdp_level->buckets_info >> (j * 8)) & 0xff);
-			format_and_print(outf, base_level + 6, header, value);
-
-			snprintf(header, sizeof(header),
-				"max-turbo-frequency(MHz)");
-			snprintf(value, sizeof(value), "%d",
-				 ctdp_level->trl_sse_active_cores[j] *
-				  DISP_FREQ_MULTIPLIER);
-			format_and_print(outf, base_level + 6, header, value);
-		}
-		snprintf(header, sizeof(header), "turbo-ratio-limits-avx");
-		format_and_print(outf, base_level + 4, header, NULL);
-		for (j = 0; j < 8; ++j) {
-			snprintf(header, sizeof(header), "bucket-%d", j);
-			format_and_print(outf, base_level + 5, header, NULL);
-
-			snprintf(header, sizeof(header), "core-count");
-			snprintf(value, sizeof(value), "%llu", (ctdp_level->buckets_info >> (j * 8)) & 0xff);
-			format_and_print(outf, base_level + 6, header, value);
-
-			snprintf(header, sizeof(header),
-				"max-turbo-frequency(MHz)");
-			snprintf(value, sizeof(value), "%d",
-				 ctdp_level->trl_avx_active_cores[j] *
-				  DISP_FREQ_MULTIPLIER);
-			format_and_print(outf, base_level + 6, header, value);
-		}
-
-		snprintf(header, sizeof(header), "turbo-ratio-limits-avx512");
-		format_and_print(outf, base_level + 4, header, NULL);
-		for (j = 0; j < 8; ++j) {
-			snprintf(header, sizeof(header), "bucket-%d", j);
-			format_and_print(outf, base_level + 5, header, NULL);
-
-			snprintf(header, sizeof(header), "core-count");
-			snprintf(value, sizeof(value), "%llu", (ctdp_level->buckets_info >> (j * 8)) & 0xff);
-			format_and_print(outf, base_level + 6, header, value);
-
-			snprintf(header, sizeof(header),
-				"max-turbo-frequency(MHz)");
-			snprintf(value, sizeof(value), "%d",
-				 ctdp_level->trl_avx_512_active_cores[j] *
-				  DISP_FREQ_MULTIPLIER);
-			format_and_print(outf, base_level + 6, header, value);
-		}
+		isst_turbo_ratio_limits(outf, "turbo-ratio-limits-sse",
+					ctdp_level->trl_sse_active_cores,
+					ctdp_level->buckets_info,
+					base_level + 4);
+		isst_turbo_ratio_limits(outf, "turbo-ratio-limits-avx",
+					ctdp_level->trl_avx_active_cores,
+					ctdp_level->buckets_info,
+					base_level + 4);
+		isst_turbo_ratio_limits(outf, "turbo-ratio-limits-avx512",
+					ctdp_level->trl_avx_512_active_cores,
+					ctdp_level->buckets_info,
+					base_level + 4);
 		if (ctdp_level->pbf_support)
 			_isst_pbf_display_information(cpu, outf, i,
 						      &ctdp_level->pbf_info,
-- 
2.21.0

