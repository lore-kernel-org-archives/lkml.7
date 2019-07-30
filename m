Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96C7C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B628A20659
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="vpipt3mY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388544AbfG3TDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 15:03:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60613 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387996AbfG3TDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:03:25 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UJ3BkF3338056
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 12:03:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UJ3BkF3338056
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564513392;
        bh=DkVz3JEV4HhSkGv/d6d2QD7yrI9FOo1OLyBFOGuJhe8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=vpipt3mYgcnV8f3iwYdhvhr2tESD8GP1cpSRdAvCPxsBZHRlHBQQ15ApsIuJT1LVG
         MPUESaWa9b26un3iLkulnrmH6BunauBoYNg9horOGFgAu8DvYvAs8MoMR27nEYCdHl
         m2j2I1qWs7e5u1YyrsAc1GCZDfa89mEf1DOhK6A9qkfXDc4PFatj5UIOcsL3vikXbH
         8g9BM39rK70lLlWN7U+MhEezl3+5JOMjValKbwLQ+yRDczCVwdc/7P5ovxkcgJPo5P
         hU3iASyZOrIT/sU4P/jj1jz88b/L90xDlKvLOtYlCXEq+ytzOCV5VO+yl7Cc9mVKGX
         LCsHjjrx2JsuA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UJ3Ajf3338049;
        Tue, 30 Jul 2019 12:03:10 -0700
Date:   Tue, 30 Jul 2019 12:03:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-43d6976365d5f90de487e8f9f49ab21775ae84f4@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, mpetlan@redhat.com,
        acme@redhat.com, alexey.budankov@linux.intel.com,
        tglx@linutronix.de, peterz@infradead.org,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, jolsa@kernel.org, ak@linux.intel.com
Reply-To: ak@linux.intel.com, namhyung@kernel.org, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          tglx@linutronix.de, acme@redhat.com, mpetlan@redhat.com,
          hpa@zytor.com, mingo@kernel.org,
          alexander.shishkin@linux.intel.com,
          alexey.budankov@linux.intel.com
In-Reply-To: <20190721112506.12306-75-jolsa@kernel.org>
References: <20190721112506.12306-75-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Add perf_thread_map test
Git-Commit-ID: 43d6976365d5f90de487e8f9f49ab21775ae84f4
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

Commit-ID:  43d6976365d5f90de487e8f9f49ab21775ae84f4
Gitweb:     https://git.kernel.org/tip/43d6976365d5f90de487e8f9f49ab21775ae84f4
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:25:01 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:46 -0300

libperf: Add perf_thread_map test

Add simple perf_thread_map tests.

Committer testing:

  $ make O=/tmp/build/perf -C tools/perf/lib tests
  make: Entering directory '/home/acme/git/perf/tools/perf/lib'
    LINK     test-cpumap-a
    LINK     test-threadmap-a
    LINK     test-cpumap-so
    LINK     test-threadmap-so
  running static:
  - running test-cpumap.c...OK
  - running test-threadmap.c...OK
  running dynamic:
  - running test-cpumap.c...OK
  - running test-threadmap.c...OK
  make: Leaving directory '/home/acme/git/perf/tools/perf/lib'
  $

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-75-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/tests/Makefile         |  2 +-
 tools/perf/lib/tests/test-threadmap.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/perf/lib/tests/Makefile b/tools/perf/lib/tests/Makefile
index b72c8c47df61..5dc84003e3a7 100644
--- a/tools/perf/lib/tests/Makefile
+++ b/tools/perf/lib/tests/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 
-TESTS = test-cpumap
+TESTS = test-cpumap test-threadmap
 
 TESTS_SO := $(addsuffix -so,$(TESTS))
 TESTS_A  := $(addsuffix -a,$(TESTS))
diff --git a/tools/perf/lib/tests/test-threadmap.c b/tools/perf/lib/tests/test-threadmap.c
new file mode 100644
index 000000000000..10a4f4cbbdd5
--- /dev/null
+++ b/tools/perf/lib/tests/test-threadmap.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <perf/threadmap.h>
+#include <internal/tests.h>
+
+int main(int argc, char **argv)
+{
+	struct perf_thread_map *threads;
+
+	__T_START;
+
+	threads = perf_thread_map__new_dummy();
+	if (!threads)
+		return -1;
+
+	perf_thread_map__get(threads);
+	perf_thread_map__put(threads);
+	perf_thread_map__put(threads);
+
+	__T_OK;
+	return 0;
+}
