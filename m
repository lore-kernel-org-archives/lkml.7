Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8852BC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686C120842
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbfJCML2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 08:11:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51876 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729462AbfJCML0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 08:11:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2D95818C7780;
        Thu,  3 Oct 2019 12:11:26 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A30355C226;
        Thu,  3 Oct 2019 12:11:25 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH v2 7/7] intel-speed-select: Implement base-freq commands on CascadeLake-N
Date:   Thu,  3 Oct 2019 08:11:12 -0400
Message-Id: <20191003121112.25870-8-prarit@redhat.com>
In-Reply-To: <20191003121112.25870-1-prarit@redhat.com>
References: <20191003121112.25870-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Thu, 03 Oct 2019 12:11:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add functionality for base-freq info|enable|disable info on CascadeLake-N.

The enable command always returns success, and the disable command always
returns failed because SST-BF cannot be enabled or disabled from the OS on
CascadeLake-N.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 .../x86/intel-speed-select/isst-config.c      | 68 +++++++++++++------
 1 file changed, 48 insertions(+), 20 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index d9b580139a07..7c7f0551eda1 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -836,7 +836,7 @@ static void clx_n_config(void)
 	ctdp_level->fact_enabled = 0;
 }
 
-static void dump_cn_config_for_cpu(int cpu, void *arg1, void *arg2,
+static void dump_clx_n_config_for_cpu(int cpu, void *arg1, void *arg2,
 				   void *arg3, void *arg4)
 {
 	isst_ctdp_display_information(cpu, outf, tdp_level, &clx_n_pkg_dev);
@@ -876,7 +876,7 @@ static void dump_isst_config(int arg)
 	if (!is_clx_n_platform())
 		fn = dump_isst_config_for_cpu;
 	else
-		fn = dump_cn_config_for_cpu;
+		fn = dump_clx_n_config_for_cpu;
 
 	isst_ctdp_display_information_start(outf);
 
@@ -951,6 +951,18 @@ static void set_tdp_level(int arg)
 	isst_ctdp_display_information_end(outf);
 }
 
+static void clx_n_dump_pbf_config_for_cpu(int cpu, void *arg1, void *arg2,
+				       void *arg3, void *arg4)
+{
+	struct isst_pbf_info *pbf_info;
+	struct isst_pkg_ctdp_level_info *ctdp_level;
+
+	ctdp_level = &clx_n_pkg_dev.ctdp_level[0];
+	pbf_info = &ctdp_level->pbf_info;
+
+	isst_pbf_display_information(cpu, outf, tdp_level, pbf_info);
+}
+
 static void dump_pbf_config_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 				    void *arg4)
 {
@@ -968,6 +980,8 @@ static void dump_pbf_config_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 
 static void dump_pbf_config(int arg)
 {
+	void *fn;
+
 	if (cmd_help) {
 		fprintf(stderr,
 			"Print Intel(R) Speed Select Technology base frequency configuration for a TDP level\n");
@@ -981,13 +995,18 @@ static void dump_pbf_config(int arg)
 		exit(1);
 	}
 
+	if (!is_clx_n_platform())
+		fn = dump_pbf_config_for_cpu;
+	else
+		fn = clx_n_dump_pbf_config_for_cpu;
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
 
@@ -1165,21 +1184,27 @@ static void set_pbf_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 	int ret;
 	int status = *(int *)arg4;
 
-	ret = isst_set_pbf_fact_status(cpu, 1, status);
-	if (ret) {
-		perror("isst_set_pbf");
-	} else {
-		if (status) {
-			if (auto_mode)
-				ret = set_pbf_core_power(cpu);
-			isst_display_result(cpu, outf, "base-freq", "enable",
-					    ret);
-		} else {
-			if (auto_mode)
-				isst_pm_qos_config(cpu, 0, 0);
-			isst_display_result(cpu, outf, "base-freq", "disable",
-					    ret);
+	if (!is_clx_n_platform()) {
+		ret = isst_set_pbf_fact_status(cpu, 1, status);
+		if (ret) {
+			perror("isst_set_pbf");
+			return;
 		}
+	} else {
+		if (status == 0)
+			ret = -1;
+		else
+			ret = 0;
+	}
+
+	if (status) {
+		if (auto_mode)
+			ret = set_pbf_core_power(cpu);
+		isst_display_result(cpu, outf, "base-freq", "enable", ret);
+	} else {
+		if (auto_mode)
+			isst_pm_qos_config(cpu, 0, 0);
+		isst_display_result(cpu, outf, "base-freq", "disable", ret);
 	}
 }
 
@@ -1645,6 +1670,9 @@ static void get_clos_assoc(int arg)
 
 static struct process_cmd_struct clx_n_cmds[] = {
 	{ "perf-profile", "info", dump_isst_config, 0 },
+	{ "base-freq", "info", dump_pbf_config, 0 },
+	{ "base-freq", "enable", set_pbf_enable, 1 },
+	{ "base-freq", "disable", set_pbf_enable, 0 },
 	{ NULL, NULL, NULL, 0 }
 };
 
-- 
2.18.1

