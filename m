Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66892CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC7121783
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571665289;
	bh=7/gUIJm+/IoIGxvP1+Gl4Sjo5zp3uxkuPDrsUZSXBXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Iefyey9/oPiC3YnKbCLwGwKdW7TJ54kX/aeS/25a6eKCIjUsfNP5jpaguE+6vINkc
	 cyErIlOLxlHc1K5uHanB670B+MTWv99qPWm8TcVOKOFJWknSW3ZZjBVKCb57aQimeM
	 YaXUOlbWLMGFoclitK6EFUD0YTqIZv4tgALMDq4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbfJUNl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:41:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729684AbfJUNlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:41:24 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1789214B2;
        Mon, 21 Oct 2019 13:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665283;
        bh=7/gUIJm+/IoIGxvP1+Gl4Sjo5zp3uxkuPDrsUZSXBXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nmUmViL9jBAVQ2ABakjxYZSRyR1x9B6AFOER5F988YGtVT1BhwQtEKGL4+z5yt1m1
         7d0w93OxqQsalOCORDw8UGV0Oswh6nnFq8StlboarKdYhtqs2f+aqjxQpLBbMT9R1t
         zVNHr50LY1Wpi1drewnzoAx90r47Xj8tVKCrrSyM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 49/57] libperf: Keep count of failed tests
Date:   Mon, 21 Oct 2019 10:38:26 -0300
Message-Id: <20191021133834.25998-50-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
index b7a20cd24ee1..2093e8868a67 100644
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
index aa34c20df07e..c8d45091e7c2 100644
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
index 741bc1bb4524..6d8ebe0c2504 100644
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
index 1b6c4285ac2b..135722ac965b 100644
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
index 8c5f47247d9e..7dc4d6fbedde 100644
--- a/tools/perf/lib/tests/test-threadmap.c
+++ b/tools/perf/lib/tests/test-threadmap.c
@@ -26,6 +26,6 @@ int main(int argc, char **argv)
 	perf_thread_map__put(threads);
 	perf_thread_map__put(threads);
 
-	__T_OK;
+	__T_END;
 	return 0;
 }
-- 
2.21.0

