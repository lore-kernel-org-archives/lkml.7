Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD91C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227D72173B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570452910;
	bh=avDvV06GeNVfkTqzcuIkU4j8QnVKFVCAaWPDX3Yk5Ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EcMj9OzHnPFw0XfaowASUVMXIJs3yoVkD4W9ZSOZgHNjnh32E3l4kiGSEvnHOJFwQ
	 5PSddV0/B+NC6KXGNMgUQTqlkSAVcUx7XhcgP/gddn5Ut5L9BJN/HTMIBl7FMzjLJd
	 WNXONK4D2clQkGkIfMtGh5DPa+N0fRxeZYjucc4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbfJGMzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:55:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56054 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728506AbfJGMzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:55:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 07ED2806A50;
        Mon,  7 Oct 2019 12:55:07 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 523C15D9CC;
        Mon,  7 Oct 2019 12:55:05 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 34/36] libperf: Keep count of failed tests
Date:   Mon,  7 Oct 2019 14:53:42 +0200
Message-Id: <20191007125344.14268-35-jolsa@kernel.org>
In-Reply-To: <20191007125344.14268-1-jolsa@kernel.org>
References: <20191007125344.14268-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Mon, 07 Oct 2019 12:55:07 +0000 (UTC)
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
index d8c52ebfa53a..9a80c310ac0f 100644
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

