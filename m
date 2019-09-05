Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70038C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510AA21883
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389110AbfIEMD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 08:03:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60162 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389086AbfIEMD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:03:26 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AA60A7FDF4;
        Thu,  5 Sep 2019 12:03:25 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0269A1001284;
        Thu,  5 Sep 2019 12:03:24 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     andriy.shevchenko@intel.com, Prarit Bhargava <prarit@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Arcari <darcari@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/9] tools/power/x86/intel-speed-select: Output human readable CPU list
Date:   Thu,  5 Sep 2019 08:03:09 -0400
Message-Id: <20190905120311.15286-8-prarit@redhat.com>
In-Reply-To: <20190905120311.15286-1-prarit@redhat.com>
References: <20190905120311.15286-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 05 Sep 2019 12:03:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intel-speed-select tool currently only outputs a hexidecimal CPU mask,
which requires translation for use with kernel parameters such as
isolcpus.

Along with the CPU mask, output a human readable CPU list.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: David Arcari <darcari@redhat.com>
Cc: linux-kernel@vger.kernel.org
---
 .../x86/intel-speed-select/isst-display.c     | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/power/x86/intel-speed-select/isst-display.c b/tools/power/x86/intel-speed-select/isst-display.c
index cfeee0beb78d..890a01bfee4b 100644
--- a/tools/power/x86/intel-speed-select/isst-display.c
+++ b/tools/power/x86/intel-speed-select/isst-display.c
@@ -8,6 +8,33 @@
 
 #define DISP_FREQ_MULTIPLIER 100
 
+static void printcpulist(int str_len, char *str, int mask_size,
+			 cpu_set_t *cpu_mask)
+{
+	int i, first, curr_index, index;
+
+	if (!CPU_COUNT_S(mask_size, cpu_mask)) {
+		snprintf(str, str_len, "none");
+		return;
+	}
+
+	curr_index = 0;
+	first = 1;
+	for (i = 0; i < get_topo_max_cpus(); ++i) {
+		if (!CPU_ISSET_S(i, mask_size, cpu_mask))
+			continue;
+		if (!first) {
+			index = snprintf(&str[curr_index],
+					 str_len - curr_index, ",");
+			curr_index += index;
+		}
+		index = snprintf(&str[curr_index], str_len - curr_index, "%d",
+				 i);
+		curr_index += index;
+		first = 0;
+	}
+}
+
 static void printcpumask(int str_len, char *str, int mask_size,
 			 cpu_set_t *cpu_mask)
 {
@@ -166,6 +193,12 @@ static void _isst_pbf_display_information(int cpu, FILE *outf, int level,
 		     pbf_info->core_cpumask);
 	format_and_print(outf, disp_level + 1, header, value);
 
+	snprintf(header, sizeof(header), "high-priority-cpu-list");
+	printcpulist(sizeof(value), value,
+		     pbf_info->core_cpumask_size,
+		     pbf_info->core_cpumask);
+	format_and_print(outf, disp_level + 1, header, value);
+
 	snprintf(header, sizeof(header), "low-priority-base-frequency(MHz)");
 	snprintf(value, sizeof(value), "%d",
 		 pbf_info->p1_low * DISP_FREQ_MULTIPLIER);
@@ -287,6 +320,12 @@ void isst_ctdp_display_information(int cpu, FILE *outf, int tdp_level,
 			     ctdp_level->core_cpumask);
 		format_and_print(outf, base_level + 4, header, value);
 
+		snprintf(header, sizeof(header), "enable-cpu-list");
+		printcpulist(sizeof(value), value,
+			     ctdp_level->core_cpumask_size,
+			     ctdp_level->core_cpumask);
+		format_and_print(outf, base_level + 4, header, value);
+
 		snprintf(header, sizeof(header), "thermal-design-power-ratio");
 		snprintf(value, sizeof(value), "%d", ctdp_level->tdp_ratio);
 		format_and_print(outf, base_level + 4, header, value);
-- 
2.21.0

