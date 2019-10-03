Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B64C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7352020700
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbfJCMLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 08:11:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50058 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729378AbfJCML0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 08:11:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7F953302246D;
        Thu,  3 Oct 2019 12:11:25 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01E855C226;
        Thu,  3 Oct 2019 12:11:24 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH v2 6/7] intel-speed-select: Implement 'perf-profile info' on CascadeLake-N
Date:   Thu,  3 Oct 2019 08:11:11 -0400
Message-Id: <20191003121112.25870-7-prarit@redhat.com>
In-Reply-To: <20191003121112.25870-1-prarit@redhat.com>
References: <20191003121112.25870-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 03 Oct 2019 12:11:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add functionality for perf-profile info on CascadeLake-N.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 .../x86/intel-speed-select/isst-config.c      | 20 +++++++++++++++----
 .../x86/intel-speed-select/isst-display.c     | 12 +++++++++++
 tools/power/x86/intel-speed-select/isst.h     |  1 +
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 3ab0edade5ec..d9b580139a07 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -836,6 +836,12 @@ static void clx_n_config(void)
 	ctdp_level->fact_enabled = 0;
 }
 
+static void dump_cn_config_for_cpu(int cpu, void *arg1, void *arg2,
+				   void *arg3, void *arg4)
+{
+	isst_ctdp_display_information(cpu, outf, tdp_level, &clx_n_pkg_dev);
+}
+
 static void dump_isst_config_for_cpu(int cpu, void *arg1, void *arg2,
 				     void *arg3, void *arg4)
 {
@@ -854,6 +860,8 @@ static void dump_isst_config_for_cpu(int cpu, void *arg1, void *arg2,
 
 static void dump_isst_config(int arg)
 {
+	void *fn;
+
 	if (cmd_help) {
 		fprintf(stderr,
 			"Print Intel(R) Speed Select Technology Performance profile configuration\n");
@@ -865,14 +873,17 @@ static void dump_isst_config(int arg)
 		exit(0);
 	}
 
+	if (!is_clx_n_platform())
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
@@ -1633,6 +1644,7 @@ static void get_clos_assoc(int arg)
 }
 
 static struct process_cmd_struct clx_n_cmds[] = {
+	{ "perf-profile", "info", dump_isst_config, 0 },
 	{ NULL, NULL, NULL, 0 }
 };
 
diff --git a/tools/power/x86/intel-speed-select/isst-display.c b/tools/power/x86/intel-speed-select/isst-display.c
index 1caa7ae25245..8309810e7425 100644
--- a/tools/power/x86/intel-speed-select/isst-display.c
+++ b/tools/power/x86/intel-speed-select/isst-display.c
@@ -202,6 +202,9 @@ static void _isst_pbf_display_information(int cpu, FILE *outf, int level,
 		 pbf_info->p1_low * DISP_FREQ_MULTIPLIER);
 	format_and_print(outf, disp_level + 1, header, value);
 
+	if (is_clx_n_platform())
+		return;
+
 	snprintf(header, sizeof(header), "tjunction-temperature(C)");
 	snprintf(value, sizeof(value), "%d", pbf_info->t_prochot);
 	format_and_print(outf, disp_level + 1, header, value);
@@ -375,6 +378,15 @@ void isst_ctdp_display_information(int cpu, FILE *outf, int tdp_level,
 			snprintf(value, sizeof(value), "unsupported");
 		format_and_print(outf, base_level + 4, header, value);
 
+		if (is_clx_n_platform()) {
+			if (ctdp_level->pbf_support)
+				_isst_pbf_display_information(cpu, outf,
+							      tdp_level,
+							  &ctdp_level->pbf_info,
+							      base_level + 4);
+			continue;
+		}
+
 		snprintf(header, sizeof(header), "thermal-design-power(W)");
 		snprintf(value, sizeof(value), "%d", ctdp_level->pkg_tdp);
 		format_and_print(outf, base_level + 4, header, value);
diff --git a/tools/power/x86/intel-speed-select/isst.h b/tools/power/x86/intel-speed-select/isst.h
index 0dcae17b3945..bef27bd6138e 100644
--- a/tools/power/x86/intel-speed-select/isst.h
+++ b/tools/power/x86/intel-speed-select/isst.h
@@ -239,4 +239,5 @@ extern void isst_display_result(int cpu, FILE *outf, char *feature, char *cmd,
 extern int isst_clos_get_clos_information(int cpu, int *enable, int *type);
 extern void isst_clos_display_clos_information(int cpu, FILE *outf,
 					       int clos_enable, int type);
+extern int is_clx_n_platform(void);
 #endif
-- 
2.18.1

