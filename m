Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A68C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 06:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C0E21887
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 06:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfK2GDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 01:03:00 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47999 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfK2GC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 01:02:59 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iaZMg-0008Hg-KR; Fri, 29 Nov 2019 07:02:50 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 49F741C2101;
        Fri, 29 Nov 2019 07:02:50 +0100 (CET)
Date:   Fri, 29 Nov 2019 06:02:50 -0000
From:   "tip-bot2 for Andi Kleen" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf affinity: Add infrastructure to save/restore affinity
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191121001522.180827-3-andi@firstfloor.org>
References: <20191121001522.180827-3-andi@firstfloor.org>
MIME-Version: 1.0
Message-ID: <157500737022.21853.11846076998782240627.tip-bot2@tip-bot2>
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

Commit-ID:     267ed5d8593cedd6146eabe00d270629c9cff771
Gitweb:        https://git.kernel.org/tip/267ed5d8593cedd6146eabe00d270629c9cff771
Author:        Andi Kleen <ak@linux.intel.com>
AuthorDate:    Wed, 20 Nov 2019 16:15:12 -08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 28 Nov 2019 08:08:38 -03:00

perf affinity: Add infrastructure to save/restore affinity

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
 tools/perf/util/Build              |  1 +-
 tools/perf/util/affinity.c         | 73 +++++++++++++++++++++++++++++-
 tools/perf/util/affinity.h         | 17 +++++++-
 tools/perf/util/python-ext-sources |  1 +-
 4 files changed, 92 insertions(+)
 create mode 100644 tools/perf/util/affinity.c
 create mode 100644 tools/perf/util/affinity.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index aab05e2..07da6c7 100644
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
index 0000000..a5e31f8
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
index 0000000..0ad6a18
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
index 9af1838..e7279ea 100644
--- a/tools/perf/util/python-ext-sources
+++ b/tools/perf/util/python-ext-sources
@@ -33,3 +33,4 @@ util/trace-event.c
 util/string.c
 util/symbol_fprintf.c
 util/units.c
+util/affinity.c
