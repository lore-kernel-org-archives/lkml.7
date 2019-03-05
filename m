Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67530C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BCE620842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbfCEOsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 09:48:23 -0500
Received: from mga06.intel.com ([134.134.136.31]:41600 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728084AbfCEOsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 09:48:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2019 06:48:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,444,1544515200"; 
   d="scan'208";a="324384164"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga006.fm.intel.com with ESMTP; 05 Mar 2019 06:48:14 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 4B2C6301BC4; Tue,  5 Mar 2019 06:48:14 -0800 (PST)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v4 01/15] perf tools: Add utility function to fetch executable
Date:   Tue,  5 Mar 2019 06:47:44 -0800
Message-Id: <20190305144758.12397-2-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190305144758.12397-1-andi@firstfloor.org>
References: <20190305144758.12397-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Add a utility function to fetch executable code. Convert one
user over to it. There are more places doing that, but they
do significantly different actions, so they are not
easy to fit into a single library function.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/Build       |  1 +
 tools/perf/util/fetch.c     | 28 ++++++++++++++++++++++++++++
 tools/perf/util/fetch.h     |  7 +++++++
 tools/perf/util/intel-bts.c | 21 +++------------------
 4 files changed, 39 insertions(+), 18 deletions(-)
 create mode 100644 tools/perf/util/fetch.c
 create mode 100644 tools/perf/util/fetch.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 8dd3102301ea..649321fc3fb9 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -65,6 +65,7 @@ perf-y += trace-event-scripting.o
 perf-y += trace-event.o
 perf-y += svghelper.o
 perf-y += sort.o
+perf-y += fetch.o
 perf-y += hist.o
 perf-y += util.o
 perf-y += xyarray.o
diff --git a/tools/perf/util/fetch.c b/tools/perf/util/fetch.c
new file mode 100644
index 000000000000..1430083e7eca
--- /dev/null
+++ b/tools/perf/util/fetch.c
@@ -0,0 +1,28 @@
+#include "perf.h"
+#include "machine.h"
+#include "thread.h"
+#include "symbol.h"
+#include "map.h"
+#include "fetch.h"
+
+int fetch_exe(u64 ip, struct thread *thread, struct machine *machine,
+	      char *buf, int len, bool *is64bit)
+{
+	struct addr_location al;
+	u8 cpumode;
+	long offset;
+
+	if (machine__kernel_ip(machine, ip))
+		cpumode = PERF_RECORD_MISC_KERNEL;
+	else
+		cpumode = PERF_RECORD_MISC_USER;
+	if (!thread__find_map(thread, cpumode, ip, &al) || !al.map->dso)
+		return -1;
+	if (al.map->dso->data.status == DSO_DATA_STATUS_ERROR)
+		return -1;
+	map__load(al.map);
+	offset = al.map->map_ip(al.map, ip);
+	if (is64bit)
+		*is64bit = al.map->dso->is_64_bit;
+	return dso__data_read_offset(al.map->dso, machine, offset, (u8 *)buf, len);
+}
diff --git a/tools/perf/util/fetch.h b/tools/perf/util/fetch.h
new file mode 100644
index 000000000000..7b77b8cee55a
--- /dev/null
+++ b/tools/perf/util/fetch.h
@@ -0,0 +1,7 @@
+#ifndef FETCH_H
+#define FETCH_H 1
+
+int fetch_exe(u64 ip, struct thread *thread, struct machine *machine,
+	      char *buf, int len, bool *is64bit);
+
+#endif
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 0c0180c67574..915f4662e52e 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -38,6 +38,7 @@
 #include "auxtrace.h"
 #include "intel-pt-decoder/intel-pt-insn-decoder.h"
 #include "intel-bts.h"
+#include "fetch.h"
 
 #define MAX_TIMESTAMP (~0ULL)
 
@@ -328,35 +329,19 @@ static int intel_bts_get_next_insn(struct intel_bts_queue *btsq, u64 ip)
 {
 	struct machine *machine = btsq->bts->machine;
 	struct thread *thread;
-	struct addr_location al;
 	unsigned char buf[INTEL_PT_INSN_BUF_SZ];
 	ssize_t len;
-	int x86_64;
-	uint8_t cpumode;
+	bool x86_64;
 	int err = -1;
 
-	if (machine__kernel_ip(machine, ip))
-		cpumode = PERF_RECORD_MISC_KERNEL;
-	else
-		cpumode = PERF_RECORD_MISC_USER;
-
 	thread = machine__find_thread(machine, -1, btsq->tid);
 	if (!thread)
 		return -1;
 
-	if (!thread__find_map(thread, cpumode, ip, &al) || !al.map->dso)
-		goto out_put;
-
-	len = dso__data_read_addr(al.map->dso, al.map, machine, ip, buf,
-				  INTEL_PT_INSN_BUF_SZ);
+	len = fetch_exe(ip, thread, machine, (char*)buf, INTEL_PT_INSN_BUF_SZ, &x86_64);
 	if (len <= 0)
 		goto out_put;
 
-	/* Load maps to ensure dso->is_64_bit has been updated */
-	map__load(al.map);
-
-	x86_64 = al.map->dso->is_64_bit;
-
 	if (intel_pt_get_insn(buf, len, x86_64, &btsq->intel_pt_insn))
 		goto out_put;
 
-- 
2.20.1

