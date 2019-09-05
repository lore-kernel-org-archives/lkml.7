Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742DFC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D792070C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389098AbfIEMD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 08:03:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46588 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389081AbfIEMDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:03:25 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D5DBF18C427C;
        Thu,  5 Sep 2019 12:03:24 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E32F10002B8;
        Thu,  5 Sep 2019 12:03:24 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     andriy.shevchenko@intel.com, Prarit Bhargava <prarit@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Arcari <darcari@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/9] tools/power/x86/intel-speed-select: Change turbo ratio output to maximum turbo frequency
Date:   Thu,  5 Sep 2019 08:03:08 -0400
Message-Id: <20190905120311.15286-7-prarit@redhat.com>
In-Reply-To: <20190905120311.15286-1-prarit@redhat.com>
References: <20190905120311.15286-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Thu, 05 Sep 2019 12:03:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intel-speed-select tool currently outputs the turbo ratio for every
bucket.  Make the output more user-friendly by changing the output to the
maximum turbo frequency.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: David Arcari <darcari@redhat.com>
Cc: linux-kernel@vger.kernel.org
---
 .../x86/intel-speed-select/isst-display.c      | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-display.c b/tools/power/x86/intel-speed-select/isst-display.c
index 4ec1924ff7a9..cfeee0beb78d 100644
--- a/tools/power/x86/intel-speed-select/isst-display.c
+++ b/tools/power/x86/intel-speed-select/isst-display.c
@@ -336,9 +336,11 @@ void isst_ctdp_display_information(int cpu, FILE *outf, int tdp_level,
 			snprintf(value, sizeof(value), "%d", j);
 			format_and_print(outf, base_level + 6, header, value);
 
-			snprintf(header, sizeof(header), "turbo-ratio");
+			snprintf(header, sizeof(header),
+				"max-turbo-frequency(MHz)");
 			snprintf(value, sizeof(value), "%d",
-				 ctdp_level->trl_sse_active_cores[j]);
+				 ctdp_level->trl_sse_active_cores[j] *
+				  DISP_FREQ_MULTIPLIER);
 			format_and_print(outf, base_level + 6, header, value);
 		}
 		snprintf(header, sizeof(header), "turbo-ratio-limits-avx");
@@ -351,9 +353,11 @@ void isst_ctdp_display_information(int cpu, FILE *outf, int tdp_level,
 			snprintf(value, sizeof(value), "%d", j);
 			format_and_print(outf, base_level + 6, header, value);
 
-			snprintf(header, sizeof(header), "turbo-ratio");
+			snprintf(header, sizeof(header),
+				"max-turbo-frequency(MHz)");
 			snprintf(value, sizeof(value), "%d",
-				 ctdp_level->trl_avx_active_cores[j]);
+				 ctdp_level->trl_avx_active_cores[j] *
+				  DISP_FREQ_MULTIPLIER);
 			format_and_print(outf, base_level + 6, header, value);
 		}
 
@@ -367,9 +371,11 @@ void isst_ctdp_display_information(int cpu, FILE *outf, int tdp_level,
 			snprintf(value, sizeof(value), "%d", j);
 			format_and_print(outf, base_level + 6, header, value);
 
-			snprintf(header, sizeof(header), "turbo-ratio");
+			snprintf(header, sizeof(header),
+				"max-turbo-frequency(MHz)");
 			snprintf(value, sizeof(value), "%d",
-				 ctdp_level->trl_avx_512_active_cores[j]);
+				 ctdp_level->trl_avx_512_active_cores[j] *
+				  DISP_FREQ_MULTIPLIER);
 			format_and_print(outf, base_level + 6, header, value);
 		}
 		if (ctdp_level->pbf_support)
-- 
2.21.0

