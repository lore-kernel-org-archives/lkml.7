Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908D0C76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7592054F
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708783;
	bh=bh2EZHD2EhiNj66f9RaPIh8aTI0Yrw3fWUQcUs1bxVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fvsH/+c6Psf8SlWMKtQuXajI90bfyiDLOUZzv14OMLcaCPB7em6Vfv18MTkKaodI0
	 GMcaB+4UjxUgBOGYEZpLRvWQq8xcHvgPV7PKgoeyt8eAegWEST0j8CwCIcEt1PJ7gV
	 pi5FF8PfPmgwYDMUnfOIkhD7XXwNA/aOBO1+0Ans=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfGULdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:33:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38372 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbfGULdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:33:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A2CE9883D7;
        Sun, 21 Jul 2019 11:32:59 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E532D5D9D3;
        Sun, 21 Jul 2019 11:32:55 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 76/79] libperf: Add perf_evsel tests
Date:   Sun, 21 Jul 2019 13:25:03 +0200
Message-Id: <20190721112506.12306-77-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Sun, 21 Jul 2019 11:32:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 2 simple perf_evsel tests to test counters reading
interface through the struct evsel object.

Link: http://lkml.kernel.org/n/tip-0u2226ojf8zpb4jbvdz108yh@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/tests/Makefile     |  2 +-
 tools/perf/lib/tests/test-evsel.c | 82 +++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/lib/tests/test-evsel.c

diff --git a/tools/perf/lib/tests/Makefile b/tools/perf/lib/tests/Makefile
index e66ed090f08e..1ee4e9ba848b 100644
--- a/tools/perf/lib/tests/Makefile
+++ b/tools/perf/lib/tests/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 
-TESTS = test-cpumap test-threadmap test-evlist
+TESTS = test-cpumap test-threadmap test-evlist test-evsel
 
 TESTS_SO := $(addsuffix -so,$(TESTS))
 TESTS_A  := $(addsuffix -a,$(TESTS))
diff --git a/tools/perf/lib/tests/test-evsel.c b/tools/perf/lib/tests/test-evsel.c
new file mode 100644
index 000000000000..268712292f60
--- /dev/null
+++ b/tools/perf/lib/tests/test-evsel.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/perf_event.h>
+#include <perf/cpumap.h>
+#include <perf/threadmap.h>
+#include <perf/evsel.h>
+#include <internal/tests.h>
+
+static int test_stat_cpu(void)
+{
+	struct perf_cpu_map *cpus;
+	struct perf_evsel *evsel;
+	struct perf_event_attr attr = {
+		.type	= PERF_TYPE_SOFTWARE,
+		.config	= PERF_COUNT_SW_CPU_CLOCK,
+	};
+	int err, cpu, tmp;
+
+	cpus = perf_cpu_map__new(NULL);
+	__T("failed to create cpus", cpus);
+
+	evsel = perf_evsel__new(&attr);
+	__T("failed to create evsel", evsel);
+
+	err = perf_evsel__open(evsel, cpus, NULL);
+	__T("failed to open evsel", err == 0);
+
+	perf_cpu_map__for_each_cpu(cpu, tmp, cpus) {
+		struct perf_counts_values counts = { .val = 0 };
+
+		perf_evsel__read(evsel, cpu, 0, &counts);
+		__T("failed to read value for evsel", counts.val != 0);
+	}
+
+	perf_evsel__close(evsel);
+	perf_evsel__delete(evsel);
+
+	perf_cpu_map__put(cpus);
+	return 0;
+}
+
+static int test_stat_thread(void)
+{
+	struct perf_counts_values counts = { .val = 0 };
+	struct perf_thread_map *threads;
+	struct perf_evsel *evsel;
+	struct perf_event_attr attr = {
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
+	evsel = perf_evsel__new(&attr);
+	__T("failed to create evsel", evsel);
+
+	err = perf_evsel__open(evsel, NULL, threads);
+	__T("failed to open evsel", err == 0);
+
+	perf_evsel__read(evsel, 0, 0, &counts);
+	__T("failed to read value for evsel", counts.val != 0);
+
+	perf_evsel__close(evsel);
+	perf_evsel__delete(evsel);
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

