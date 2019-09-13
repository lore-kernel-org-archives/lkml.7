Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F02C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C94720640
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381214;
	bh=Ya20pn7KOeUJrL7teyU3YnOYjroUT63a7ttYbIaAOww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VeNzx+MZ9UtpkIEbvR7h4jhB4jZV/pg4h8vgHvVave+lzimTDcfN8MQNZuVdiNhzY
	 DJETO2gRHF+bXXwXZexP5iunJCPliHI9suaY5aO01y1B8fKVgbojJtQc9OLHSQgMyV
	 ZP5ispr+dLE+Aig6Dr45Z9FR2PlU3w0ZmG1w7mc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403876AbfIMN0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:26:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42896 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403858AbfIMN0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:26:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1A4ED89AC7;
        Fri, 13 Sep 2019 13:26:47 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 768FD5C1D4;
        Fri, 13 Sep 2019 13:26:45 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 71/73] libperf: Keep count of failed tests
Date:   Fri, 13 Sep 2019 15:23:53 +0200
Message-Id: <20190913132355.21634-72-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 13 Sep 2019 13:26:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keeping the count of failed tests, so we
get better output with failures, like:

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

Link: http://lkml.kernel.org/n/tip-wi78jndi8ymzw7dq11mwxsld@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
index 4224d6f213f8..d28306710104 100644
--- a/tools/perf/lib/tests/test-cpumap.c
+++ b/tools/perf/lib/tests/test-cpumap.c
@@ -24,6 +24,6 @@ int main(int argc, char **argv)
 	perf_cpu_map__put(cpus);
 	perf_cpu_map__put(cpus);
 
-	__T_OK;
+	__T_END;
 	return 0;
 }
diff --git a/tools/perf/lib/tests/test-evlist.c b/tools/perf/lib/tests/test-evlist.c
index 2b7271130223..80906e04ab0c 100644
--- a/tools/perf/lib/tests/test-evlist.c
+++ b/tools/perf/lib/tests/test-evlist.c
@@ -407,6 +407,6 @@ int main(int argc, char **argv)
 	test_mmap_thread();
 	test_mmap_cpus();
 
-	__T_OK;
+	__T_END;
 	return 0;
 }
diff --git a/tools/perf/lib/tests/test-evsel.c b/tools/perf/lib/tests/test-evsel.c
index 64d2257a93cb..1c9c4ec94e59 100644
--- a/tools/perf/lib/tests/test-evsel.c
+++ b/tools/perf/lib/tests/test-evsel.c
@@ -128,6 +128,6 @@ int main(int argc, char **argv)
 	test_stat_thread();
 	test_stat_thread_enable();
 
-	__T_OK;
+	__T_END;
 	return 0;
 }
diff --git a/tools/perf/lib/tests/test-threadmap.c b/tools/perf/lib/tests/test-threadmap.c
index 9b72c43c8c59..7366bdbf4adf 100644
--- a/tools/perf/lib/tests/test-threadmap.c
+++ b/tools/perf/lib/tests/test-threadmap.c
@@ -24,6 +24,6 @@ int main(int argc, char **argv)
 	perf_thread_map__put(threads);
 	perf_thread_map__put(threads);
 
-	__T_OK;
+	__T_END;
 	return 0;
 }
-- 
2.21.0

