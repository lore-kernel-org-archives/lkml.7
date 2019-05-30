Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2CAC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8FC25BEA
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfE3Oyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 10:54:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:62323 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbfE3Oyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 10:54:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 May 2019 07:54:47 -0700
X-ExtLoop1: 1
Received: from otc-lr-04.jf.intel.com ([10.54.39.157])
  by orsmga006.jf.intel.com with ESMTP; 30 May 2019 07:54:47 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 5/5] perf tools: Apply new CPU topology sysfs attributes
Date:   Thu, 30 May 2019 07:53:49 -0700
Message-Id: <1559228029-5876-5-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559228029-5876-1-git-send-email-kan.liang@linux.intel.com>
References: <1559228029-5876-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The existing "thread_siblings" and "thread_siblings_list" attribute will
be deprecated.
Use the new CPU topology sysfs attributes, "core_cpus" and
"core_cpus_list", which are synonymous with the deprecated attributes.

Check the new name first. If not available, use the deprecated name to
be compatible with old kernel.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

New for V2

 tools/perf/util/cputopo.c | 8 +++++++-
 tools/perf/util/smt.c     | 8 ++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index 85fa87f..26e73a4b 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -15,6 +15,8 @@
 	"%s/devices/system/cpu/cpu%d/topology/die_cpus_list"
 #define THRD_SIB_FMT \
 	"%s/devices/system/cpu/cpu%d/topology/thread_siblings_list"
+#define THRD_SIB_FMT_NEW \
+	"%s/devices/system/cpu/cpu%d/topology/core_cpus_list"
 #define NODE_ONLINE_FMT \
 	"%s/devices/system/node/online"
 #define NODE_MEMINFO_FMT \
@@ -91,8 +93,12 @@ static int build_cpu_topology(struct cpu_topology *tp, int cpu)
 	ret = 0;
 
 try_threads:
-	scnprintf(filename, MAXPATHLEN, THRD_SIB_FMT,
+	scnprintf(filename, MAXPATHLEN, THRD_SIB_FMT_NEW,
 		  sysfs__mountpoint(), cpu);
+	if (access(filename, F_OK) == -1) {
+		scnprintf(filename, MAXPATHLEN, THRD_SIB_FMT,
+			  sysfs__mountpoint(), cpu);
+	}
 	fp = fopen(filename, "r");
 	if (!fp)
 		goto done;
diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
index 453f6f6..3b791ef 100644
--- a/tools/perf/util/smt.c
+++ b/tools/perf/util/smt.c
@@ -23,8 +23,12 @@ int smt_on(void)
 		char fn[256];
 
 		snprintf(fn, sizeof fn,
-			"devices/system/cpu/cpu%d/topology/thread_siblings",
-			cpu);
+			"devices/system/cpu/cpu%d/topology/core_cpus", cpu);
+		if (access(fn, F_OK) == -1) {
+			snprintf(fn, sizeof fn,
+				"devices/system/cpu/cpu%d/topology/thread_siblings",
+				cpu);
+		}
 		if (sysfs__read_str(fn, &str, &strlen) < 0)
 			continue;
 		/* Entry is hex, but does not have 0x, so need custom parser */
-- 
2.7.4

