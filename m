Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16810C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 12:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8918222C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 12:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfIZMzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 08:55:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43988 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbfIZMzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 08:55:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AEC0A316D76D;
        Thu, 26 Sep 2019 12:55:17 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 32BC760933;
        Thu, 26 Sep 2019 12:55:17 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 6/7] intel-speed-select: Implement 'perf-profile info' on CascadeLake-N
Date:   Thu, 26 Sep 2019 08:55:00 -0400
Message-Id: <20190926125501.1616-7-prarit@redhat.com>
In-Reply-To: <20190926125501.1616-1-prarit@redhat.com>
References: <20190926125501.1616-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 26 Sep 2019 12:55:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add functionality for perf-profile info on CascadeLake-N.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel-speed-select/isst-config.c      | 24 +++++++++++++++----
 .../x86/intel-speed-select/isst-display.c     | 22 +++++++++++++----
 tools/power/x86/intel-speed-select/isst.h     |  3 ++-
 3 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index a82005825990..0c66012fc5a1 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -823,6 +823,13 @@ static void cascadelaken_config(void)
 	ctdp_level->fact_enabled = 0;
 }
 
+static void dump_cn_config_for_cpu(int cpu, void *arg1, void *arg2,
+				   void *arg3, void *arg4)
+{
+	isst_ctdp_display_information(cpu, outf, tdp_level, &cn_pkg_dev,
+				      cpu_model);
+}
+
 static void dump_isst_config_for_cpu(int cpu, void *arg1, void *arg2,
 				     void *arg3, void *arg4)
 {
@@ -834,13 +841,16 @@ static void dump_isst_config_for_cpu(int cpu, void *arg1, void *arg2,
 	if (ret) {
 		perror("isst_get_process_ctdp");
 	} else {
-		isst_ctdp_display_information(cpu, outf, tdp_level, &pkg_dev);
+		isst_ctdp_display_information(cpu, outf, tdp_level, &pkg_dev,
+					      cpu_model);
 		isst_get_process_ctdp_complete(cpu, &pkg_dev);
 	}
 }
 
 static void dump_isst_config(int arg)
 {
+	void *fn;
+
 	if (cmd_help) {
 		fprintf(stderr,
 			"Print Intel(R) Speed Select Technology Performance profile configuration\n");
@@ -852,14 +862,17 @@ static void dump_isst_config(int arg)
 		exit(0);
 	}
 
+	if (cpu_model != 0x55)
+		fn = dump_isst_config_for_cpu;
+	else
+		fn = dump_cn_config_for_cpu;
+
 	isst_ctdp_display_information_start(outf);
 
 	if (max_target_cpus)
-		for_each_online_target_cpu_in_set(dump_isst_config_for_cpu,
-						  NULL, NULL, NULL, NULL);
+		for_each_online_target_cpu_in_set(fn, NULL, NULL, NULL, NULL);
 	else
-		for_each_online_package_in_set(dump_isst_config_for_cpu, NULL,
-					       NULL, NULL, NULL);
+		for_each_online_package_in_set(fn, NULL, NULL, NULL, NULL);
 
 	isst_ctdp_display_information_end(outf);
 }
@@ -1374,6 +1387,7 @@ static void get_clos_assoc(int arg)
 }
 
 static struct process_cmd_struct cn_cmds[] = {
+	{ "perf-profile", "info", dump_isst_config, 0 },
 	{ NULL, NULL, NULL, 0 }
 };
 
diff --git a/tools/power/x86/intel-speed-select/isst-display.c b/tools/power/x86/intel-speed-select/isst-display.c
index 1caa7ae25245..7d91a5de1b85 100644
--- a/tools/power/x86/intel-speed-select/isst-display.c
+++ b/tools/power/x86/intel-speed-select/isst-display.c
@@ -173,7 +173,7 @@ static void print_package_info(int cpu, FILE *outf)
 
 static void _isst_pbf_display_information(int cpu, FILE *outf, int level,
 					  struct isst_pbf_info *pbf_info,
-					  int disp_level)
+					  int disp_level, int cpu_model)
 {
 	char header[256];
 	char value[256];
@@ -202,6 +202,9 @@ static void _isst_pbf_display_information(int cpu, FILE *outf, int level,
 		 pbf_info->p1_low * DISP_FREQ_MULTIPLIER);
 	format_and_print(outf, disp_level + 1, header, value);
 
+	if (cpu_model == 0x55)
+		return;
+
 	snprintf(header, sizeof(header), "tjunction-temperature(C)");
 	snprintf(value, sizeof(value), "%d", pbf_info->t_prochot);
 	format_and_print(outf, disp_level + 1, header, value);
@@ -306,7 +309,7 @@ void isst_ctdp_display_core_info(int cpu, FILE *outf, char *prefix,
 }
 
 void isst_ctdp_display_information(int cpu, FILE *outf, int tdp_level,
-				   struct isst_pkg_ctdp *pkg_dev)
+				   struct isst_pkg_ctdp *pkg_dev, int cpu_model)
 {
 	char header[256];
 	char value[256];
@@ -375,6 +378,16 @@ void isst_ctdp_display_information(int cpu, FILE *outf, int tdp_level,
 			snprintf(value, sizeof(value), "unsupported");
 		format_and_print(outf, base_level + 4, header, value);
 
+		if (cpu_model == 0x55) {
+			if (ctdp_level->pbf_support)
+				_isst_pbf_display_information(cpu, outf,
+							      tdp_level,
+							  &ctdp_level->pbf_info,
+							      base_level + 4,
+							      cpu_model);
+			continue;
+		}
+
 		snprintf(header, sizeof(header), "thermal-design-power(W)");
 		snprintf(value, sizeof(value), "%d", ctdp_level->pkg_tdp);
 		format_and_print(outf, base_level + 4, header, value);
@@ -438,7 +451,8 @@ void isst_ctdp_display_information(int cpu, FILE *outf, int tdp_level,
 		if (ctdp_level->pbf_support)
 			_isst_pbf_display_information(cpu, outf, i,
 						      &ctdp_level->pbf_info,
-						      base_level + 4);
+						      base_level + 4,
+						      cpu_model);
 		if (ctdp_level->fact_support)
 			_isst_fact_display_information(cpu, outf, i, 0xff, 0xff,
 						       &ctdp_level->fact_info,
@@ -463,7 +477,7 @@ void isst_pbf_display_information(int cpu, FILE *outf, int level,
 				  struct isst_pbf_info *pbf_info)
 {
 	print_package_info(cpu, outf);
-	_isst_pbf_display_information(cpu, outf, level, pbf_info, 4);
+	_isst_pbf_display_information(cpu, outf, level, pbf_info, 4, 0);
 	format_and_print(outf, 1, NULL, NULL);
 }
 
diff --git a/tools/power/x86/intel-speed-select/isst.h b/tools/power/x86/intel-speed-select/isst.h
index 0dcae17b3945..35b0fec44d35 100644
--- a/tools/power/x86/intel-speed-select/isst.h
+++ b/tools/power/x86/intel-speed-select/isst.h
@@ -196,7 +196,8 @@ extern int isst_get_process_ctdp(int cpu, int tdp_level,
 extern void isst_get_process_ctdp_complete(int cpu,
 					   struct isst_pkg_ctdp *pkg_dev);
 extern void isst_ctdp_display_information(int cpu, FILE *outf, int tdp_level,
-					  struct isst_pkg_ctdp *pkg_dev);
+					  struct isst_pkg_ctdp *pkg_dev,
+					  int cpu_model);
 extern void isst_ctdp_display_core_info(int cpu, FILE *outf, char *prefix,
 					unsigned int val);
 extern void isst_ctdp_display_information_start(FILE *outf);
-- 
2.21.0

