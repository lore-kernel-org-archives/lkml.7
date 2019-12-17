Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439F1C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9A82082E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfLQLcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:32:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55052 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbfLQLcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 06:32:06 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ihB50-0007MV-Eh; Tue, 17 Dec 2019 12:31:54 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 266681C2A35;
        Tue, 17 Dec 2019 12:31:54 +0100 (CET)
Date:   Tue, 17 Dec 2019 11:31:54 -0000
From:   "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/pmu-events: Fix Kernel_Utilization metric
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191204162121.29998-1-ravi.bangoria@linux.ibm.com>
References: <20191204162121.29998-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <157658231402.30329.2351840591993349073.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     0dd674efaf63bc6bfd89909814db618abe1e7039
Gitweb:        https://git.kernel.org/tip/0dd674efaf63bc6bfd89909814db618abe1e7039
Author:        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
AuthorDate:    Wed, 04 Dec 2019 21:51:21 +05:30
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 11 Dec 2019 12:28:14 -03:00

perf/x86/pmu-events: Fix Kernel_Utilization metric

Kernel Utilization should divide ref cycles spent in kernel with total
ref cycles.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Haiyan Song <haiyanx.song@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/20191204162121.29998-1-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json     | 2 +-
 tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json | 2 +-
 tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json    | 2 +-
 tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json  | 2 +-
 tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json       | 2 +-
 tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json      | 2 +-
 tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json     | 2 +-
 tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json       | 2 +-
 tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json      | 2 +-
 tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json   | 2 +-
 tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json       | 2 +-
 tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json      | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json b/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
index bc7151d..45a34ce 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
@@ -297,7 +297,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
index 49c5f12..961fe43 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
@@ -115,7 +115,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json b/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
index 113d19e..746734c 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
@@ -297,7 +297,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
index 2ba32af..f946532 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
@@ -315,7 +315,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json b/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
index c80f16f..5402cd3 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
@@ -267,7 +267,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json b/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
index e501729..832f3cb 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
@@ -267,7 +267,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json b/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
index e244696..d69b2a8 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
@@ -285,7 +285,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json b/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
index 9294769..5f465fd 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
@@ -285,7 +285,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json b/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
index 603ff9c..3e909b3 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
@@ -171,7 +171,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
index c6b485b..50c0532 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
@@ -171,7 +171,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
index 0ca539b..e7feb60 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
@@ -303,7 +303,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
index 047d7e1..21d7a0c 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
@@ -315,7 +315,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
