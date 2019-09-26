Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B634FC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 12:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911B9222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 12:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfIZMz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 08:55:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44570 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726888AbfIZMzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 08:55:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A1BA30BC58E;
        Thu, 26 Sep 2019 12:55:18 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D2063608C2;
        Thu, 26 Sep 2019 12:55:17 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 7/7] intel-speed-select: Implement base-freq commands on CascadeLake-N
Date:   Thu, 26 Sep 2019 08:55:01 -0400
Message-Id: <20190926125501.1616-8-prarit@redhat.com>
In-Reply-To: <20190926125501.1616-1-prarit@redhat.com>
References: <20190926125501.1616-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 26 Sep 2019 12:55:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add functionality for base-freq info|enable|disable info on CascadeLake-N.

The enable command always returns success, and the disable command always
returns failed because SST-BF cannot be enabled or disabled from the OS on
CascadeLake-N.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel-speed-select/isst-config.c      | 56 ++++++++++++++-----
 .../x86/intel-speed-select/isst-display.c     |  6 +-
 tools/power/x86/intel-speed-select/isst.h     |  3 +-
 3 files changed, 49 insertions(+), 16 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 0c66012fc5a1..24e6084a36b4 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -940,6 +940,18 @@ static void set_tdp_level(int arg)
 	isst_ctdp_display_information_end(outf);
 }
 
+static void cn_dump_pbf_config_for_cpu(int cpu, void *arg1, void *arg2,
+				       void *arg3, void *arg4)
+{
+	struct isst_pbf_info *pbf_info;
+	struct isst_pkg_ctdp_level_info *ctdp_level;
+
+	ctdp_level = &cn_pkg_dev.ctdp_level[0];
+	pbf_info = &ctdp_level->pbf_info;
+
+	isst_pbf_display_information(cpu, outf, tdp_level, pbf_info, cpu_model);
+}
+
 static void dump_pbf_config_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 				    void *arg4)
 {
@@ -950,13 +962,16 @@ static void dump_pbf_config_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 	if (ret) {
 		perror("isst_get_pbf_info");
 	} else {
-		isst_pbf_display_information(cpu, outf, tdp_level, &pbf_info);
+		isst_pbf_display_information(cpu, outf, tdp_level, &pbf_info,
+					     cpu_model);
 		isst_get_pbf_info_complete(&pbf_info);
 	}
 }
 
 static void dump_pbf_config(int arg)
 {
+	void *fn;
+
 	if (cmd_help) {
 		fprintf(stderr,
 			"Print Intel(R) Speed Select Technology base frequency configuration for a TDP level\n");
@@ -970,13 +985,18 @@ static void dump_pbf_config(int arg)
 		exit(1);
 	}
 
+	if (cpu_model != 0x55)
+		fn = dump_pbf_config_for_cpu;
+	else
+		fn = cn_dump_pbf_config_for_cpu;
+
 	isst_ctdp_display_information_start(outf);
+
 	if (max_target_cpus)
-		for_each_online_target_cpu_in_set(dump_pbf_config_for_cpu, NULL,
-						  NULL, NULL, NULL);
+		for_each_online_target_cpu_in_set(fn, NULL, NULL, NULL, NULL);
 	else
-		for_each_online_package_in_set(dump_pbf_config_for_cpu, NULL,
-					       NULL, NULL, NULL);
+		for_each_online_package_in_set(fn, NULL, NULL, NULL, NULL);
+
 	isst_ctdp_display_information_end(outf);
 }
 
@@ -986,17 +1006,24 @@ static void set_pbf_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 	int ret;
 	int status = *(int *)arg4;
 
-	ret = isst_set_pbf_fact_status(cpu, 1, status);
-	if (ret) {
-		perror("isst_set_pbf");
+	if (cpu_model != 0x55) {
+		ret = isst_set_pbf_fact_status(cpu, 1, status);
+		if (ret) {
+			perror("isst_set_pbf");
+			return;
+		}
+
 	} else {
-		if (status)
-			isst_display_result(cpu, outf, "base-freq", "enable",
-					    ret);
+		if (status == 0)
+			ret = -1;
 		else
-			isst_display_result(cpu, outf, "base-freq", "disable",
-					    ret);
+			ret = 0;
 	}
+
+	if (status)
+		isst_display_result(cpu, outf, "base-freq", "enable", ret);
+	else
+		isst_display_result(cpu, outf, "base-freq", "disable", ret);
 }
 
 static void set_pbf_enable(int arg)
@@ -1388,6 +1415,9 @@ static void get_clos_assoc(int arg)
 
 static struct process_cmd_struct cn_cmds[] = {
 	{ "perf-profile", "info", dump_isst_config, 0 },
+	{ "base-freq", "info", dump_pbf_config, 0 },
+	{ "base-freq", "enable", set_pbf_enable, 1 },
+	{ "base-freq", "disable", set_pbf_enable, 0 },
 	{ NULL, NULL, NULL, 0 }
 };
 
diff --git a/tools/power/x86/intel-speed-select/isst-display.c b/tools/power/x86/intel-speed-select/isst-display.c
index 7d91a5de1b85..8cc8d963a55e 100644
--- a/tools/power/x86/intel-speed-select/isst-display.c
+++ b/tools/power/x86/intel-speed-select/isst-display.c
@@ -474,10 +474,12 @@ void isst_ctdp_display_information_end(FILE *outf)
 }
 
 void isst_pbf_display_information(int cpu, FILE *outf, int level,
-				  struct isst_pbf_info *pbf_info)
+				  struct isst_pbf_info *pbf_info,
+				  int cpu_model)
 {
 	print_package_info(cpu, outf);
-	_isst_pbf_display_information(cpu, outf, level, pbf_info, 4, 0);
+	_isst_pbf_display_information(cpu, outf, level, pbf_info, 4,
+				      cpu_model);
 	format_and_print(outf, 1, NULL, NULL);
 }
 
diff --git a/tools/power/x86/intel-speed-select/isst.h b/tools/power/x86/intel-speed-select/isst.h
index 35b0fec44d35..d94b46272ce2 100644
--- a/tools/power/x86/intel-speed-select/isst.h
+++ b/tools/power/x86/intel-speed-select/isst.h
@@ -203,7 +203,8 @@ extern void isst_ctdp_display_core_info(int cpu, FILE *outf, char *prefix,
 extern void isst_ctdp_display_information_start(FILE *outf);
 extern void isst_ctdp_display_information_end(FILE *outf);
 extern void isst_pbf_display_information(int cpu, FILE *outf, int level,
-					 struct isst_pbf_info *info);
+					 struct isst_pbf_info *info,
+					 int cpu_model);
 extern int isst_set_tdp_level(int cpu, int tdp_level);
 extern int isst_set_tdp_level_msr(int cpu, int tdp_level);
 extern int isst_set_pbf_fact_status(int cpu, int pbf, int enable);
-- 
2.21.0

