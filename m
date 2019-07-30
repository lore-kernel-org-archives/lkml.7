Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8F7C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DE120659
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cEaorFrW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388538AbfG3TCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 15:02:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47993 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387996AbfG3TCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:02:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UJ2NGn3337754
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 12:02:23 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UJ2NGn3337754
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564513343;
        bh=HvpK5cgus/BdB/lvMfbu1aMhlLhmMOeuVbCe+VqWMps=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=cEaorFrW7y1AkuilQYs+9dOA3IOWUoV2CtKXklTFGbMhCMV0Qm4qX4LZ8/BlZ/V3l
         e6c2qhVTuh/hOAQTojkC418a2BocSrpfrGrvIKGHsQ6fsE68ik/WBR43+ULQNFGGZn
         t5YQ4K5tK7ynOdg158OCUPzra13BJycplPiKkWiDKWP63psvNkQClf6kC4V0iSemwv
         aRj3K9tOKJdPIDJoCmERKQns569kNDoyEEYDfsjzDyYE1PdWQRfoNGajc2bMCMifvc
         KNKkopacEWzQu4CaEHZIkgpXUaRaCvXgaApaK8XwwJg8QfiGT34J0rkydBkW4u64bj
         h4njCEwVtkWkg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UJ2Lw73337745;
        Tue, 30 Jul 2019 12:02:21 -0700
Date:   Tue, 30 Jul 2019 12:02:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-c0e730456ae8a864701f5ca4f6c2e23010e4b04a@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, jolsa@kernel.org,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        mpetlan@redhat.com, peterz@infradead.org,
        alexey.budankov@linux.intel.com, mingo@kernel.org,
        namhyung@kernel.org, acme@redhat.com, ak@linux.intel.com,
        hpa@zytor.com
Reply-To: alexander.shishkin@linux.intel.com, acme@redhat.com,
          jolsa@kernel.org, linux-kernel@vger.kernel.org,
          peterz@infradead.org, ak@linux.intel.com, tglx@linutronix.de,
          mpetlan@redhat.com, mingo@kernel.org,
          alexey.budankov@linux.intel.com, namhyung@kernel.org,
          hpa@zytor.com
In-Reply-To: <20190721112506.12306-74-jolsa@kernel.org>
References: <20190721112506.12306-74-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Add perf_cpu_map test
Git-Commit-ID: c0e730456ae8a864701f5ca4f6c2e23010e4b04a
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

Commit-ID:  c0e730456ae8a864701f5ca4f6c2e23010e4b04a
Gitweb:     https://git.kernel.org/tip/c0e730456ae8a864701f5ca4f6c2e23010e4b04a
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:25:00 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:46 -0300

libperf: Add perf_cpu_map test

Add simple perf_cpu_map tests.

Committer testing:

One has to build it in the source tree, a limitation that should be
fixed in followup patches:

  $ make O=/tmp/build/perf -C tools/perf/lib
  make: Entering directory '/home/acme/git/perf/tools/perf/lib'
    LINK     /tmp/build/perf/libperf.so.0.0.1
    GEN      /tmp/build/perf/libperf.pc
  make: Leaving directory '/home/acme/git/perf/tools/perf/lib'
  $ make O=/tmp/build/perf -C tools/perf/lib  tests
  make: Entering directory '/home/acme/git/perf/tools/perf/lib'
    LINK     test-cpumap-a
  gcc: error: ../libperf.a: No such file or directory
  make[1]: *** [Makefile:22: test-cpumap-a] Error 1
  make: *** [Makefile:115: tests] Error 2
  make: Leaving directory '/home/acme/git/perf/tools/perf/lib'
  [acme@quaco perf]$ make -C tools/perf/lib
  make: Entering directory '/home/acme/git/perf/tools/perf/lib'
    HOSTCC   fixdep.o
    HOSTLD   fixdep-in.o
    LINK     fixdep
    CC       core.o
    CC       cpumap.o
    CC       threadmap.o
    CC       evsel.o
    CC       evlist.o
    CC       zalloc.o
    CC       xyarray.o
    CC       lib.o
    LD       libperf-in.o
    AR       libperf.a
    LINK     libperf.so.0.0.1
    GEN      libperf.pc
  make: Leaving directory '/home/acme/git/perf/tools/perf/lib'
  $ make O=/tmp/build/perf -C tools/perf/lib  tests
  make: Entering directory '/home/acme/git/perf/tools/perf/lib'
    LINK     test-cpumap-a
    LINK     test-cpumap-so
  running static:
  - running test-cpumap.c...OK
  running dynamic:
  - running test-cpumap.c...OK
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
Link: http://lkml.kernel.org/r/20190721112506.12306-74-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/tests/Makefile      |  2 +-
 tools/perf/lib/tests/test-cpumap.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/perf/lib/tests/Makefile b/tools/perf/lib/tests/Makefile
index de951ae38dea..b72c8c47df61 100644
--- a/tools/perf/lib/tests/Makefile
+++ b/tools/perf/lib/tests/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 
-TESTS =
+TESTS = test-cpumap
 
 TESTS_SO := $(addsuffix -so,$(TESTS))
 TESTS_A  := $(addsuffix -a,$(TESTS))
diff --git a/tools/perf/lib/tests/test-cpumap.c b/tools/perf/lib/tests/test-cpumap.c
new file mode 100644
index 000000000000..76a43cfb83a1
--- /dev/null
+++ b/tools/perf/lib/tests/test-cpumap.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <perf/cpumap.h>
+#include <internal/tests.h>
+
+int main(int argc, char **argv)
+{
+	struct perf_cpu_map *cpus;
+
+	__T_START;
+
+	cpus = perf_cpu_map__dummy_new();
+	if (!cpus)
+		return -1;
+
+	perf_cpu_map__get(cpus);
+	perf_cpu_map__put(cpus);
+	perf_cpu_map__put(cpus);
+
+	__T_OK;
+	return 0;
+}
