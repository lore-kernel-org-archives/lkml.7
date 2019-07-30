Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C016C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA3F20659
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="lFbBceMk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388549AbfG3TEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 15:04:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50511 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387996AbfG3TEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:04:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UJ40qv3338136
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 12:04:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UJ40qv3338136
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564513441;
        bh=NysPV5H3+JjhF7PPhzJwRKA9CQHyezvPMWI9cxdbxDk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=lFbBceMk4e0cgWNGmhIPB08vxfMary0DQyUS5C4AN4V0w71uwgHRzxuJCSl9RM9eL
         +79U/MB0kMUePRQbKShpHDsaV9aRc4KK5leuSf2Z5tp6aaJZeXx6E4+ipE2AcLs2X8
         ld2kWHHvQgl2422PscE3cv6pFhD39HwcCd701O+tVknT+L0lL6FKFQ7i1U7DVrFN4c
         GeeT7KvGQNHMvL0a8qk5N4mbmjVaKmnJMc16Vl8VB/XA7oLxW2ptsmObRpLJ2CLxzW
         Tr2OoOIPXKYslCOTgdJU2eS52EW5U1PinHIr0PW3RFzQJa8EvNLrM/L3Oe0mJfznZQ
         ++ZoIuwJ6LRKQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UJ40eH3338133;
        Tue, 30 Jul 2019 12:04:00 -0700
Date:   Tue, 30 Jul 2019 12:04:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-8ded5425fa71e2f7f60eb59d64ecdba80582b641@git.kernel.org>
Cc:     peterz@infradead.org, alexander.shishkin@linux.intel.com,
        ak@linux.intel.com, mpetlan@redhat.com, acme@redhat.com,
        mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, alexey.budankov@linux.intel.com,
        namhyung@kernel.org, tglx@linutronix.de
Reply-To: acme@redhat.com, mingo@kernel.org, ak@linux.intel.com,
          alexander.shishkin@linux.intel.com, peterz@infradead.org,
          mpetlan@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
          hpa@zytor.com, jolsa@kernel.org, alexey.budankov@linux.intel.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190721112506.12306-76-jolsa@kernel.org>
References: <20190721112506.12306-76-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Add perf_evlist test
Git-Commit-ID: 8ded5425fa71e2f7f60eb59d64ecdba80582b641
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  8ded5425fa71e2f7f60eb59d64ecdba80582b641
Gitweb:     https://git.kernel.org/tip/8ded5425fa71e2f7f60eb59d64ecdba80582b641
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:25:02 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:47 -0300

libperf: Add perf_evlist test

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
 tools/perf/lib/tests/test-evlist.c | 123 +++++++++++++++++++++++++++++++++++++
 2 files changed, 124 insertions(+), 1 deletion(-)

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
