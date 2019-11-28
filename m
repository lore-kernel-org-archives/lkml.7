Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F43BC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF94C217BA
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574948503;
	bh=M2BJrnl1xfgf8djFaL6suuq4uC9MKxmqRG3OV/jAwek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y8UkkF553rpr/y8LH17xBFDQY9/WKlDzVa/nmWh2cJ62Ojhhuh7QrjbpqR2ttFCjG
	 Wch7QBm+gEZe7CRZilUmo/AETOm8epNS/1L7VulFvlp5gMYbfqjvDlpe5fZB15Se4Z
	 ngKL1FamLZ0/RgKMQ0paBPiIc0S5CxzUg+OTuk0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfK1Nlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 08:41:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:38134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbfK1Nlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:41:39 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 483FD217D6;
        Thu, 28 Nov 2019 13:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574948498;
        bh=M2BJrnl1xfgf8djFaL6suuq4uC9MKxmqRG3OV/jAwek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OIuaK8hQvUmOMhWd3ECqJbR5YcNGXFgKr3/Utt23LDodCZsrW25OOOy8pmOPbivHj
         oJ3pCPYi0pL6I2PE5lrtklt5nTtSNHocCMBj+BE+TF2gqclSB4jaFTxo0PxJyz71lW
         Ia5pCddFEvD+qF3GhItmnBZJZBQclDkY/TfAikwE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 20/22] perf affinity: Add infrastructure to save/restore affinity
Date:   Thu, 28 Nov 2019 10:40:25 -0300
Message-Id: <20191128134027.23726-21-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128134027.23726-1-acme@kernel.org>
References: <20191128134027.23726-1-acme@kernel.org>
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

Committer notes:

Use zfree() in some places, add missing stdbool.h header, some minor
coding style changes.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lore.kernel.org/lkml/20191121001522.180827-3-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/Build              |  1 +
 tools/perf/util/affinity.c         | 73 ++++++++++++++++++++++++++++++
 tools/perf/util/affinity.h         | 17 +++++++
 tools/perf/util/python-ext-sources |  1 +
 4 files changed, 92 insertions(+)
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
index 000000000000..a5e31f826828
--- /dev/null
+++ b/tools/perf/util/affinity.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Manage affinity to optimize IPIs inside the kernel perf API. */
+#define _GNU_SOURCE 1
+#include <sched.h>
+#include <stdlib.h>
+#include <linux/bitmap.h>
+#include <linux/zalloc.h>
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
+	return sz / 8;
+}
+
+int affinity__setup(struct affinity *a)
+{
+	int cpu_set_size = get_cpu_set_size();
+
+	a->orig_cpus = bitmap_alloc(cpu_set_size * 8);
+	if (!a->orig_cpus)
+		return -1;
+	sched_getaffinity(0, cpu_set_size, (cpu_set_t *)a->orig_cpus);
+	a->sched_cpus = bitmap_alloc(cpu_set_size * 8);
+	if (!a->sched_cpus) {
+		zfree(&a->orig_cpus);
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
+	zfree(&a->sched_cpus);
+	zfree(&a->orig_cpus);
+}
diff --git a/tools/perf/util/affinity.h b/tools/perf/util/affinity.h
new file mode 100644
index 000000000000..0ad6a18ef20c
--- /dev/null
+++ b/tools/perf/util/affinity.h
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef PERF_AFFINITY_H
+#define PERF_AFFINITY_H 1
+
+#include <stdbool.h>
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
+#endif // PERF_AFFINITY_H
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
2.21.0

