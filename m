Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E559CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9C021D81
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbfKDLDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 06:03:32 -0500
Received: from mga04.intel.com ([192.55.52.120]:13206 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728496AbfKDLDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 06:03:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 03:03:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,267,1569308400"; 
   d="scan'208";a="232021232"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga002.fm.intel.com with ESMTP; 04 Nov 2019 03:03:09 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        prarit@redhat.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 06/10] tools/power/x86/intel-speed-select: Make CLOS frequency in MHz
Date:   Mon,  4 Nov 2019 03:02:42 -0800
Message-Id: <20191104110246.70465-7-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191104110246.70465-1-srinivas.pandruvada@linux.intel.com>
References: <20191104110246.70465-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be consistant with the other frequency units, change the CLOS
unit to MHz instead of ratios.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 tools/power/x86/intel-speed-select/isst-config.c  | 11 +++++++----
 tools/power/x86/intel-speed-select/isst-display.c |  6 +++---
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 2a3650f025b9..a8ada9a4f020 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -1775,9 +1775,9 @@ static void set_clos_config(int arg)
 		fprintf(stderr, "\tSpecify clos EPP with [--epp|-e]\n");
 		fprintf(stderr,
 			"\tSpecify clos Proportional Priority [--weight|-w]\n");
-		fprintf(stderr, "\tSpecify clos min with [--min|-n]\n");
-		fprintf(stderr, "\tSpecify clos max with [--max|-m]\n");
-		fprintf(stderr, "\tSpecify clos desired with [--desired|-d]\n");
+		fprintf(stderr, "\tSpecify clos min in MHz with [--min|-n]\n");
+		fprintf(stderr, "\tSpecify clos max in MHz with [--max|-m]\n");
+		fprintf(stderr, "\tSpecify clos desired in MHz with [--desired|-d]\n");
 		exit(0);
 	}
 
@@ -1799,7 +1799,7 @@ static void set_clos_config(int arg)
 		clos_min = 0;
 	}
 	if (clos_max < 0) {
-		fprintf(stderr, "clos max is not specified, default: 0xff\n");
+		fprintf(stderr, "clos max is not specified, default: 25500 MHz\n");
 		clos_max = 0xff;
 	}
 	if (clos_desired < 0) {
@@ -2049,15 +2049,18 @@ static void parse_cmd_args(int argc, int start, char **argv)
 			break;
 		case 'd':
 			clos_desired = atoi(optarg);
+			clos_desired /= DISP_FREQ_MULTIPLIER;
 			break;
 		case 'e':
 			clos_epp = atoi(optarg);
 			break;
 		case 'n':
 			clos_min = atoi(optarg);
+			clos_min /= DISP_FREQ_MULTIPLIER;
 			break;
 		case 'm':
 			clos_max = atoi(optarg);
+			clos_max /= DISP_FREQ_MULTIPLIER;
 			break;
 		case 'p':
 			clos_priority_type = atoi(optarg);
diff --git a/tools/power/x86/intel-speed-select/isst-display.c b/tools/power/x86/intel-speed-select/isst-display.c
index b7d58f7c5b3e..b8f04347ad3f 100644
--- a/tools/power/x86/intel-speed-select/isst-display.c
+++ b/tools/power/x86/intel-speed-select/isst-display.c
@@ -556,15 +556,15 @@ void isst_clos_display_information(int cpu, FILE *outf, int clos,
 	format_and_print(outf, 5, header, value);
 
 	snprintf(header, sizeof(header), "clos-min");
-	snprintf(value, sizeof(value), "%d", clos_config->clos_min);
+	snprintf(value, sizeof(value), "%d MHz", clos_config->clos_min * DISP_FREQ_MULTIPLIER);
 	format_and_print(outf, 5, header, value);
 
 	snprintf(header, sizeof(header), "clos-max");
-	snprintf(value, sizeof(value), "%d", clos_config->clos_max);
+	snprintf(value, sizeof(value), "%d MHz", clos_config->clos_max * DISP_FREQ_MULTIPLIER);
 	format_and_print(outf, 5, header, value);
 
 	snprintf(header, sizeof(header), "clos-desired");
-	snprintf(value, sizeof(value), "%d", clos_config->clos_desired);
+	snprintf(value, sizeof(value), "%d MHz", clos_config->clos_desired * DISP_FREQ_MULTIPLIER);
 	format_and_print(outf, 5, header, value);
 
 	format_and_print(outf, 1, NULL, NULL);
-- 
2.17.2

