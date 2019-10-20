Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1C3CA9EA0
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 17:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C89E521897
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 17:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfJTRwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 13:52:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:3315 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbfJTRwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 13:52:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Oct 2019 10:52:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,320,1566889200"; 
   d="scan'208";a="190893275"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga008.jf.intel.com with ESMTP; 20 Oct 2019 10:52:30 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 1892B300393; Sun, 20 Oct 2019 10:52:30 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@kernel.org, eranian@google.com,
        kan.liang@linux.intel.com, peterz@infradead.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2 4/9] perf affinity: Add infrastructure to save/restore affinity
Date:   Sun, 20 Oct 2019 10:51:57 -0700
Message-Id: <20191020175202.32456-5-andi@firstfloor.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191020175202.32456-1-andi@firstfloor.org>
References: <20191020175202.32456-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The kernel perf subsystem has to IPI to the target CPU for many
operations. On systems with many CPUs and when managing many events the
overhead can be dominated by lots of IPIs.

An alternative is to set up CPU affinity in the perf tool, then set up
all the events for that CPU, and then move on to the next CPU.

Add some affinity management infrastructure to enable such a model.
Used in followon patches.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/Build      |  1 +
 tools/perf/util/affinity.c | 71 ++++++++++++++++++++++++++++++++++++++
 tools/perf/util/affinity.h | 15 ++++++++
 3 files changed, 87 insertions(+)
 create mode 100644 tools/perf/util/affinity.c
 create mode 100644 tools/perf/util/affinity.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 2c1504fe924c..c7d4eab017e5 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -76,6 +76,7 @@ perf-y += sort.o
 perf-y += hist.o
 perf-y += util.o
 perf-y += cpumap.o
+perf-y += affinity.o
 perf-y += cputopo.o
 perf-y += cgroup.o
 perf-y += target.o
diff --git a/tools/perf/util/affinity.c b/tools/perf/util/affinity.c
new file mode 100644
index 000000000000..c42a6b9d63f0
--- /dev/null
+++ b/tools/perf/util/affinity.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Manage affinity to optimize IPIs inside the kernel perf API. */
+#define _GNU_SOURCE 1
+#include <sched.h>
+#include <stdlib.h>
+#include <linux/zalloc.h>
+#include "perf.h"
+#include "cpumap.h"
+#include "affinity.h"
+
+static int get_cpu_set_size(void)
+{
+	int sz = (cpu__max_cpu() + 64 - 1) / 64;
+	/*
+	 * sched_getaffinity doesn't like masks smaller than the kernel.
+	 * Hopefully that's big enough.
+	 */
+	if (sz < 4096/8)
+		sz = 4096/8;
+	return sz;
+}
+
+int affinity__setup(struct affinity *a)
+{
+	int cpu_set_size = get_cpu_set_size();
+
+	a->orig_cpus = malloc(cpu_set_size);
+	if (!a->orig_cpus)
+		return -1;
+	sched_getaffinity(0, cpu_set_size, (cpu_set_t *)a->orig_cpus);
+	a->sched_cpus = zalloc(cpu_set_size);
+	if (!a->sched_cpus) {
+		free(a->orig_cpus);
+		return -1;
+	}
+	a->changed = false;
+	return 0;
+}
+
+/*
+ * perf_event_open does an IPI internally to the target CPU.
+ * It is more efficient to change perf's affinity to the target
+ * CPU and then set up all events on that CPU, so we amortize
+ * CPU communication.
+ */
+void affinity__set(struct affinity *a, int cpu)
+{
+	int cpu_set_size = get_cpu_set_size();
+
+	if (cpu == -1)
+		return;
+	a->changed = true;
+	a->sched_cpus[cpu / 8] |= 1 << (cpu % 8);
+	/*
+	 * We ignore errors because affinity is just an optimization.
+	 * This could happen for example with isolated CPUs or cpusets.
+	 * In this case the IPIs inside the kernel's perf API still work.
+	 */
+	sched_setaffinity(0, cpu_set_size, (cpu_set_t *)a->sched_cpus);
+	a->sched_cpus[cpu / 8] ^= 1 << (cpu % 8);
+}
+
+void affinity__cleanup(struct affinity *a)
+{
+	int cpu_set_size = get_cpu_set_size();
+
+	if (a->changed)
+		sched_setaffinity(0, cpu_set_size, (cpu_set_t *)a->orig_cpus);
+	free(a->sched_cpus);
+	free(a->orig_cpus);
+}
diff --git a/tools/perf/util/affinity.h b/tools/perf/util/affinity.h
new file mode 100644
index 000000000000..e56148607e33
--- /dev/null
+++ b/tools/perf/util/affinity.h
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef AFFINITY_H
+#define AFFINITY_H 1
+
+struct affinity {
+	unsigned char *orig_cpus;
+	unsigned char *sched_cpus;
+	bool changed;
+};
+
+void affinity__cleanup(struct affinity *a);
+void affinity__set(struct affinity *a, int cpu);
+int affinity__setup(struct affinity *a);
+
+#endif
-- 
2.21.0

