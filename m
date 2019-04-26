Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00695C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF089206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfDZMpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 08:45:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:27479 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbfDZMpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 08:45:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Apr 2019 05:45:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,397,1549958400"; 
   d="scan'208";a="137680155"
Received: from otc-lr-04.jf.intel.com ([10.54.39.156])
  by orsmga008.jf.intel.com with ESMTP; 26 Apr 2019 05:45:17 -0700
From:   kan.liang@linux.intel.com
To:     acme@redhat.com, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     jolsa@redhat.com, namhyung@gmail.com, lgoncalv@redhat.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2] perf stat: Add hint for SMI cost measurement
Date:   Fri, 26 Apr 2019 05:45:03 -0700
Message-Id: <1556282703-120695-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Entering/exiting a C-state deeper than C0 may cause slight difference in
counts between aperf and unhalted core cycles, which may impact the SMI
cost.

Add smi_env_check() to check if C-state is completely disabled during
the measurement. If not, give a hint to user.

Update the document as well.

Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V1:
- Update changelog, document, and user-visible message

 tools/perf/Documentation/perf-stat.txt |  5 +++++
 tools/perf/builtin-stat.c              | 25 +++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 39c05f8..19b7267 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -309,6 +309,11 @@ The output is SMI cycles%, equals to (aperf - unhalted core cycles) / aperf
 
 Users who wants to get the actual value can apply --no-metric-only.
 
+Entering/exiting a C-state deeper than C0 may cause slight difference in counts
+between aperf and unhalted core cycles, which may impact the SMI cost.
+Please completely disable C-state during the measurement,
+e.g. set idle=poll in grub.
+
 EXAMPLES
 --------
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index c3625ec..e437788 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -87,6 +87,7 @@
 
 #define DEFAULT_SEPARATOR	" "
 #define FREEZE_ON_SMI_PATH	"devices/cpu/freeze_on_smi"
+#define CPUIDLE_CUR_DRV		"devices/system/cpu/cpuidle/current_driver"
 
 static void print_counters(struct timespec *ts, int argc, const char **argv);
 
@@ -1024,6 +1025,27 @@ __weak void arch_topdown_group_warn(void)
 {
 }
 
+static void smi_env_check(void)
+{
+	char *name;
+	size_t len;
+	int err;
+
+	err = sysfs__read_str(CPUIDLE_CUR_DRV, &name, &len);
+	if (err) {
+		pr_warning("Failed to read %s, err %d. Ignoring C-state status check.\n",
+			   CPUIDLE_CUR_DRV, err);
+		return;
+	}
+
+	if (strncmp(name, "none", 4)) {
+		pr_warning("Entering/exiting a C-state deeper than C0 may result inaccurate SMI cost.\n"
+			   "Please completely disable C-state, e.g. set idle=poll in grub.\n");
+	}
+
+	free(name);
+}
+
 /*
  * Add default attributes, if there were no attributes specified or
  * if -d/--detailed, -d -d or -d -d -d is used:
@@ -1196,6 +1218,9 @@ static int add_default_attributes(void)
 
 		if (pmu_have_event("msr", "aperf") &&
 		    pmu_have_event("msr", "smi")) {
+
+			smi_env_check();
+
 			if (!force_metric_only)
 				stat_config.metric_only = true;
 			err = parse_events(evsel_list, smi_cost_attrs, &errinfo);
-- 
2.7.4

