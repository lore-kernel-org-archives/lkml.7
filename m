Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969E1C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 22:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F9624682
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 22:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfLPWPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:15:39 -0500
Received: from mga01.intel.com ([192.55.52.88]:54731 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727630AbfLPWP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 17:15:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 14:15:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,323,1571727600"; 
   d="scan'208";a="212362103"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga008.fm.intel.com with ESMTP; 16 Dec 2019 14:15:23 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "James Morse" <james.morse@arm.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Sai Praneeth Prakhya" <sai.praneeth.prakhya@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v9 10/13] selftests/resctrl: Add vendor detection mechanism
Date:   Mon, 16 Dec 2019 14:26:44 -0800
Message-Id: <1576535207-2417-11-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1576535207-2417-1-git-send-email-fenghua.yu@intel.com>
References: <1576535207-2417-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Babu Moger <babu.moger@amd.com>

RESCTRL feature is supported both on Intel and AMD now. Some features
are implemented differently. Add vendor detection mechanism. Use the vendor
check where there are differences.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/resctrl.h     |  1 +
 .../testing/selftests/resctrl/resctrl_tests.c | 24 +++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 99659639e580..cd2ea1d2cad9 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -66,6 +66,7 @@ pid_t bm_pid, ppid;
 int tests_run;
 
 char llc_occup_path[1024];
+bool is_amd;
 
 bool check_resctrlfs_support(void);
 int filter_dmesg(void);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 7f75b0b01bb5..884e918b1e97 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -13,6 +13,27 @@
 #define BENCHMARK_ARGS		64
 #define BENCHMARK_ARG_SIZE	64
 
+bool is_amd;
+
+void detect_amd(void)
+{
+	FILE *inf = fopen("/proc/cpuinfo", "r");
+	char *res;
+
+	if (!inf)
+		return;
+
+	res = fgrep(inf, "vendor_id");
+
+	if (res) {
+		char *s = strchr(res, ':');
+
+		is_amd = s && !strcmp(s, ": AuthenticAMD\n");
+		free(res);
+	}
+	fclose(inf);
+}
+
 static void cmd_help(void)
 {
 	printf("usage: resctrl_tests [-h] [-b \"benchmark_cmd [options]\"] [-t test list] [-n no_of_bits]\n");
@@ -107,6 +128,9 @@ int main(int argc, char **argv)
 	if (geteuid() != 0)
 		printf("# WARNING: not running as root, tests may fail.\n");
 
+	/* Detect AMD vendor */
+	detect_amd();
+
 	if (has_ben) {
 		/* Extract benchmark command from command line. */
 		for (i = ben_ind; i < argc; i++) {
-- 
2.19.1

