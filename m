Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42158C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 05:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248D420830
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 05:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfKPFxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 00:53:15 -0500
Received: from mga14.intel.com ([192.55.52.115]:32565 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbfKPFwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 00:52:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 21:52:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,311,1569308400"; 
   d="scan'208";a="208612461"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga006.jf.intel.com with ESMTP; 15 Nov 2019 21:52:43 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id D9215300FDE; Fri, 15 Nov 2019 21:52:43 -0800 (PST)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v7 02/12] perf affinity: Add infrastructure to save/restore affinity
Date:   Fri, 15 Nov 2019 21:52:19 -0800
Message-Id: <20191116055229.62002-3-andi@firstfloor.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191116055229.62002-1-andi@firstfloor.org>
References: <20191116055229.62002-1-andi@firstfloor.org>
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

v2: Use linux/bitmap.h functions.
v3: Add affinity.c to the python-ext-sources to fix the python
interface.  Thanks 0day!
---
 tools/perf/util/Build              |  1 +
 tools/perf/util/affinity.c         | 72 ++++++++++++++++++++++++++++++
 tools/perf/util/affinity.h         | 15 +++++++
 tools/perf/util/python-ext-sources |  1 +
 4 files changed, 89 insertions(+)
 create mode 100644 tools/perf/util/affinity.c
 create mode 100644 tools/perf/util/affinity.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index aab05e2c01a5..07da6c790b63 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -77,6 +77,7 @@ perf-y += sort.o
 perf-y += hist.o
 perf-y += util.o
 perf-y += cpumap.o
+perf-y += affinity.o
 perf-y += cputopo.o
 perf-y += cgroup.o
 perf-y += target.o
diff --git a/tools/perf/util/affinity.c b/tools/perf/util/affinity.c
new file mode 100644
index 000000000000..e197b0416f56
--- /dev/null
+++ b/tools/perf/util/affinity.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Manage affinity to optimize IPIs inside the kernel perf API. */
+#define _GNU_SOURCE 1
+#include <sched.h>
+#include <stdlib.h>
+#include <linux/bitmap.h>
+#include "perf.h"
+#include "cpumap.h"
+#include "affinity.h"
+
+static int get_cpu_set_size(void)
+{
+	int sz = cpu__max_cpu() + 8 - 1;
+	/*
+	 * sched_getaffinity doesn't like masks smaller than the kernel.
+	 * Hopefully that's big enough.
+	 */
+	if (sz < 4096)
+		sz = 4096;
+	return sz/8;
+}
+
+int affinity__setup(struct affinity *a)
+{
+	int cpu_set_size = get_cpu_set_size();
+
+	a->orig_cpus = bitmap_alloc(cpu_set_size*8);
+	if (!a->orig_cpus)
+		return -1;
+	sched_getaffinity(0, cpu_set_size, (cpu_set_t *)a->orig_cpus);
+	a->sched_cpus = bitmap_alloc(cpu_set_size*8);
+	if (!a->sched_cpus) {
+		free(a->orig_cpus);
+		return -1;
+	}
+	bitmap_zero((unsigned long *)a->sched_cpus, cpu_set_size);
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
+	set_bit(cpu, a->sched_cpus);
+	/*
+	 * We ignore errors because affinity is just an optimization.
+	 * This could happen for example with isolated CPUs or cpusets.
+	 * In this case the IPIs inside the kernel's perf API still work.
+	 */
+	sched_setaffinity(0, cpu_set_size, (cpu_set_t *)a->sched_cpus);
+	clear_bit(cpu, a->sched_cpus);
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
index 000000000000..008e2c3995b9
--- /dev/null
+++ b/tools/perf/util/affinity.h
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef AFFINITY_H
+#define AFFINITY_H 1
+
+struct affinity {
+	unsigned long *orig_cpus;
+	unsigned long *sched_cpus;
+	bool changed;
+};
+
+void affinity__cleanup(struct affinity *a);
+void affinity__set(struct affinity *a, int cpu);
+int affinity__setup(struct affinity *a);
+
+#endif
diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
index 9af183860fbd..e7279ea6043a 100644
--- a/tools/perf/util/python-ext-sources
+++ b/tools/perf/util/python-ext-sources
@@ -33,3 +33,4 @@ util/trace-event.c
 util/string.c
 util/symbol_fprintf.c
 util/units.c
+util/affinity.c
-- 
2.23.0

