Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25ED8C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC7021726
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455733;
	bh=ALFRpPuVL2QacJ1MfZzsptziUr4yBWiEZip9gmO+tXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZcFUQwNbD6B1m5wFhnK23VCWaK5ccKNv7K5nBJPpiXns997q6IWbyQkQDllh5Z3a7
	 +2aBt18kvoE51cJRAJLIQ4BF4adhx0lXUyd/INZVH2FttROv+j9g9ZKC3M6TB2FDCp
	 ZGYyV7vhCxv9LKJR2BeFxapHr3hjRzcn95HR/x90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732768AbfG3DCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 23:02:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732723AbfG3DCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:02:10 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D18B206DD;
        Tue, 30 Jul 2019 03:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455729;
        bh=ALFRpPuVL2QacJ1MfZzsptziUr4yBWiEZip9gmO+tXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qu2I3zNlG7SIDIXWxv/+2Gi7v/d/PZvh+3AFuZct3691bvGasT15DoWcF177ruj7R
         WdveFKkR8EUg89VukhybL1gCtU1L3dx7dGynqHhY4jmGyxL3kW6643hOYIQ1AE7oJN
         MHR7RlEecVSG5SeBVmcMMbCP+szmAGbOg4OuPqVY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 102/107] libperf: Add perf_evlist test
Date:   Mon, 29 Jul 2019 23:56:05 -0300
Message-Id: <20190730025610.22603-103-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add 2 simple perf_evlist tests to test counters reading interface
through the struct evlist object.

Committer testing:

  # make -C tools/perf/lib tests
  make: Entering directory '/home/acme/git/perf/tools/perf/lib'
    LINK     test-cpumap-a
    LINK     test-threadmap-a
    LINK     test-evlist-a
    LINK     test-cpumap-so
    LINK     test-threadmap-so
    LINK     test-evlist-so
  running static:
  - running test-cpumap.c...OK
  - running test-threadmap.c...OK
  - running test-evlist.c...OK
  running dynamic:
  - running test-cpumap.c...OK
  - running test-threadmap.c...OK
  - running test-evlist.c...OK
  make: Leaving directory '/home/acme/git/perf/tools/perf/lib'
  #

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-76-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/tests/Makefile      |   2 +-
 tools/perf/lib/tests/test-evlist.c | 123 +++++++++++++++++++++++++++++
 2 files changed, 124 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/lib/tests/test-evlist.c

diff --git a/tools/perf/lib/tests/Makefile b/tools/perf/lib/tests/Makefile
index 5dc84003e3a7..e66ed090f08e 100644
--- a/tools/perf/lib/tests/Makefile
+++ b/tools/perf/lib/tests/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 
-TESTS = test-cpumap test-threadmap
+TESTS = test-cpumap test-threadmap test-evlist
 
 TESTS_SO := $(addsuffix -so,$(TESTS))
 TESTS_A  := $(addsuffix -a,$(TESTS))
diff --git a/tools/perf/lib/tests/test-evlist.c b/tools/perf/lib/tests/test-evlist.c
new file mode 100644
index 000000000000..f24c531afcb6
--- /dev/null
+++ b/tools/perf/lib/tests/test-evlist.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/perf_event.h>
+#include <perf/cpumap.h>
+#include <perf/threadmap.h>
+#include <perf/evlist.h>
+#include <perf/evsel.h>
+#include <internal/tests.h>
+
+static int test_stat_cpu(void)
+{
+	struct perf_cpu_map *cpus;
+	struct perf_evlist *evlist;
+	struct perf_evsel *evsel;
+	struct perf_event_attr attr1 = {
+		.type	= PERF_TYPE_SOFTWARE,
+		.config	= PERF_COUNT_SW_CPU_CLOCK,
+	};
+	struct perf_event_attr attr2 = {
+		.type	= PERF_TYPE_SOFTWARE,
+		.config	= PERF_COUNT_SW_TASK_CLOCK,
+	};
+	int err, cpu, tmp;
+
+	cpus = perf_cpu_map__new(NULL);
+	__T("failed to create cpus", cpus);
+
+	evlist = perf_evlist__new();
+	__T("failed to create evlist", evlist);
+
+	evsel = perf_evsel__new(&attr1);
+	__T("failed to create evsel1", evsel);
+
+	perf_evlist__add(evlist, evsel);
+
+	evsel = perf_evsel__new(&attr2);
+	__T("failed to create evsel2", evsel);
+
+	perf_evlist__add(evlist, evsel);
+
+	perf_evlist__set_maps(evlist, cpus, NULL);
+
+	err = perf_evlist__open(evlist);
+	__T("failed to open evsel", err == 0);
+
+	perf_evlist__for_each_evsel(evlist, evsel) {
+		cpus = perf_evsel__cpus(evsel);
+
+		perf_cpu_map__for_each_cpu(cpu, tmp, cpus) {
+			struct perf_counts_values counts = { .val = 0 };
+
+			perf_evsel__read(evsel, cpu, 0, &counts);
+			__T("failed to read value for evsel", counts.val != 0);
+		}
+	}
+
+	perf_evlist__close(evlist);
+	perf_evlist__delete(evlist);
+
+	perf_cpu_map__put(cpus);
+	return 0;
+}
+
+static int test_stat_thread(void)
+{
+	struct perf_counts_values counts = { .val = 0 };
+	struct perf_thread_map *threads;
+	struct perf_evlist *evlist;
+	struct perf_evsel *evsel;
+	struct perf_event_attr attr1 = {
+		.type	= PERF_TYPE_SOFTWARE,
+		.config	= PERF_COUNT_SW_CPU_CLOCK,
+	};
+	struct perf_event_attr attr2 = {
+		.type	= PERF_TYPE_SOFTWARE,
+		.config	= PERF_COUNT_SW_TASK_CLOCK,
+	};
+	int err;
+
+	threads = perf_thread_map__new_dummy();
+	__T("failed to create threads", threads);
+
+	perf_thread_map__set_pid(threads, 0, 0);
+
+	evlist = perf_evlist__new();
+	__T("failed to create evlist", evlist);
+
+	evsel = perf_evsel__new(&attr1);
+	__T("failed to create evsel1", evsel);
+
+	perf_evlist__add(evlist, evsel);
+
+	evsel = perf_evsel__new(&attr2);
+	__T("failed to create evsel2", evsel);
+
+	perf_evlist__add(evlist, evsel);
+
+	perf_evlist__set_maps(evlist, NULL, threads);
+
+	err = perf_evlist__open(evlist);
+	__T("failed to open evsel", err == 0);
+
+	perf_evlist__for_each_evsel(evlist, evsel) {
+		perf_evsel__read(evsel, 0, 0, &counts);
+		__T("failed to read value for evsel", counts.val != 0);
+	}
+
+	perf_evlist__close(evlist);
+	perf_evlist__delete(evlist);
+
+	perf_thread_map__put(threads);
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	__T_START;
+
+	test_stat_cpu();
+	test_stat_thread();
+
+	__T_OK;
+	return 0;
+}
-- 
2.21.0

