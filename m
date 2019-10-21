Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B11CA9EB0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2822173B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387564AbfJVAFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 20:05:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38895 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387548AbfJVAFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 20:05:06 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMgws-0003qu-CE; Tue, 22 Oct 2019 01:18:50 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AD15D1C047B;
        Tue, 22 Oct 2019 01:18:49 +0200 (CEST)
Date:   Mon, 21 Oct 2019 23:18:49 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Keep count of failed tests
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191017105918.20873-9-jolsa@kernel.org>
References: <20191017105918.20873-9-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <157169992933.29376.15176117865199883044.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     301a89f8cf628316eea6c768787a836b63a83439
Gitweb:        https://git.kernel.org/tip/301a89f8cf628316eea6c768787a836b63a83439
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Thu, 17 Oct 2019 12:59:16 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 19 Oct 2019 15:35:01 -03:00

libperf: Keep count of failed tests

Keep the count of failed tests, so we get better output with failures,
like:

  # make tests
  ...
  running static:
  - running test-cpumap.c...OK
  - running test-threadmap.c...OK
  - running test-evlist.c...FAILED test-evlist.c:53 failed to create evsel2
  FAILED test-evlist.c:163 failed to create evsel2
  FAILED test-evlist.c:287 failed count
    FAILED (3)
  - running test-evsel.c...OK
  running dynamic:
  - running test-cpumap.c...OK
  - running test-threadmap.c...OK
  - running test-evlist.c...FAILED test-evlist.c:53 failed to create evsel2
  FAILED test-evlist.c:163 failed to create evsel2
  FAILED test-evlist.c:287 failed count
    FAILED (3)
  - running test-evsel.c...OK
 ...

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20191017105918.20873-9-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/internal/tests.h | 20 +++++++++++++++++---
 tools/perf/lib/tests/test-cpumap.c      |  2 +-
 tools/perf/lib/tests/test-evlist.c      |  2 +-
 tools/perf/lib/tests/test-evsel.c       |  2 +-
 tools/perf/lib/tests/test-threadmap.c   |  2 +-
 5 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/tools/perf/lib/include/internal/tests.h b/tools/perf/lib/include/internal/tests.h
index b7a20cd..2093e88 100644
--- a/tools/perf/lib/include/internal/tests.h
+++ b/tools/perf/lib/include/internal/tests.h
@@ -4,14 +4,28 @@
 
 #include <stdio.h>
 
-#define __T_START fprintf(stdout, "- running %s...", __FILE__)
-#define __T_OK    fprintf(stdout, "OK\n")
-#define __T_FAIL  fprintf(stdout, "FAIL\n")
+int tests_failed;
+
+#define __T_START					\
+do {							\
+	fprintf(stdout, "- running %s...", __FILE__);	\
+	fflush(NULL);					\
+	tests_failed = 0;				\
+} while (0)
+
+#define __T_END								\
+do {									\
+	if (tests_failed)						\
+		fprintf(stdout, "  FAILED (%d)\n", tests_failed);	\
+	else								\
+		fprintf(stdout, "OK\n");				\
+} while (0)
 
 #define __T(text, cond)                                                          \
 do {                                                                             \
 	if (!(cond)) {                                                           \
 		fprintf(stderr, "FAILED %s:%d %s\n", __FILE__, __LINE__, text);  \
+		tests_failed++;                                                  \
 		return -1;                                                       \
 	}                                                                        \
 } while (0)
diff --git a/tools/perf/lib/tests/test-cpumap.c b/tools/perf/lib/tests/test-cpumap.c
index aa34c20..c8d4509 100644
--- a/tools/perf/lib/tests/test-cpumap.c
+++ b/tools/perf/lib/tests/test-cpumap.c
@@ -26,6 +26,6 @@ int main(int argc, char **argv)
 	perf_cpu_map__put(cpus);
 	perf_cpu_map__put(cpus);
 
-	__T_OK;
+	__T_END;
 	return 0;
 }
diff --git a/tools/perf/lib/tests/test-evlist.c b/tools/perf/lib/tests/test-evlist.c
index 741bc1b..6d8ebe0 100644
--- a/tools/perf/lib/tests/test-evlist.c
+++ b/tools/perf/lib/tests/test-evlist.c
@@ -408,6 +408,6 @@ int main(int argc, char **argv)
 	test_mmap_thread();
 	test_mmap_cpus();
 
-	__T_OK;
+	__T_END;
 	return 0;
 }
diff --git a/tools/perf/lib/tests/test-evsel.c b/tools/perf/lib/tests/test-evsel.c
index 1b6c428..135722a 100644
--- a/tools/perf/lib/tests/test-evsel.c
+++ b/tools/perf/lib/tests/test-evsel.c
@@ -130,6 +130,6 @@ int main(int argc, char **argv)
 	test_stat_thread();
 	test_stat_thread_enable();
 
-	__T_OK;
+	__T_END;
 	return 0;
 }
diff --git a/tools/perf/lib/tests/test-threadmap.c b/tools/perf/lib/tests/test-threadmap.c
index 8c5f472..7dc4d6f 100644
--- a/tools/perf/lib/tests/test-threadmap.c
+++ b/tools/perf/lib/tests/test-threadmap.c
@@ -26,6 +26,6 @@ int main(int argc, char **argv)
 	perf_thread_map__put(threads);
 	perf_thread_map__put(threads);
 
-	__T_OK;
+	__T_END;
 	return 0;
 }
