Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEB3C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 12:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDAC222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 12:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfIZMzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 08:55:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726857AbfIZMzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 08:55:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0F83C7FDEC;
        Thu, 26 Sep 2019 12:55:17 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 84E2860A97;
        Thu, 26 Sep 2019 12:55:16 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 5/7] intel-speed-select: Implement CascadeLake-N help and command functions structures
Date:   Thu, 26 Sep 2019 08:54:59 -0400
Message-Id: <20190926125501.1616-6-prarit@redhat.com>
In-Reply-To: <20190926125501.1616-1-prarit@redhat.com>
References: <20190926125501.1616-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 26 Sep 2019 12:55:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CascadeLake-N only supports SST-BF and needs some of the perf-profile
commands, and the base-freq commands.

Add help functions, and create an empty command structures (the functions
will be implemented later in this patchset).  Call these functions
when running on CascadeLake-N.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel-speed-select/isst-config.c      | 37 ++++++++++++++-----
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 33f328d971d3..a82005825990 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -1373,6 +1373,10 @@ static void get_clos_assoc(int arg)
 	isst_ctdp_display_information_end(outf);
 }
 
+static struct process_cmd_struct cn_cmds[] = {
+	{ NULL, NULL, NULL, 0 }
+};
+
 static struct process_cmd_struct isst_cmds[] = {
 	{ "perf-profile", "get-lock-status", get_tdp_locked, 0 },
 	{ "perf-profile", "get-config-levels", get_tdp_levels, 0 },
@@ -1557,12 +1561,15 @@ static void isst_help(void)
 		TDP, etc.\n");
 	printf("\nCommands : For feature=perf-profile\n");
 	printf("\tinfo\n");
-	printf("\tget-lock-status\n");
-	printf("\tget-config-levels\n");
-	printf("\tget-config-version\n");
-	printf("\tget-config-enabled\n");
-	printf("\tget-config-current-level\n");
-	printf("\tset-config-level\n");
+
+	if (cpu_model != 0x55) {
+		printf("\tget-lock-status\n");
+		printf("\tget-config-levels\n");
+		printf("\tget-config-version\n");
+		printf("\tget-config-enabled\n");
+		printf("\tget-config-current-level\n");
+		printf("\tset-config-level\n");
+	}
 }
 
 static void pbf_help(void)
@@ -1612,6 +1619,12 @@ static struct process_cmd_help_struct isst_help_cmds[] = {
 	{ NULL, NULL }
 };
 
+static struct process_cmd_help_struct cn_help_cmds[] = {
+	{ "perf-profile", isst_help },
+	{ "base-freq", pbf_help },
+	{ NULL, NULL }
+};
+
 void process_command(int argc, char **argv,
 		     struct process_cmd_help_struct *help_cmds,
 		     struct process_cmd_struct *cmds)
@@ -1768,11 +1781,15 @@ static void cmdline(int argc, char **argv)
 	set_max_cpu_num();
 	set_cpu_present_cpu_mask();
 	set_cpu_target_cpu_mask();
-	ret = isst_fill_platform_info();
-	if (ret)
-		goto out;
 
-	process_command(argc, argv, isst_help_cmds, isst_cmds);
+	if (cpu_model != 0x55) {
+		ret = isst_fill_platform_info();
+		if (ret)
+			goto out;
+		process_command(argc, argv, isst_help_cmds, isst_cmds);
+	} else {
+		process_command(argc, argv, cn_help_cmds, cn_cmds);
+	}
 out:
 	free_cpu_set(present_cpumask);
 	free_cpu_set(target_cpumask);
-- 
2.21.0

