Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20C8C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895FA20578
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455765;
	bh=ntdGkBOO43YdSvII+K0PCoOAFz3dJZOE6szTDEiDFiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CA1u3vWMiMvYw+fc5ck9dUWWYfNgVgnjExWERrnIHO915zcnOWAlDdHhdCJFjceyW
	 khTw/yADQNi38EXg/4yl/CQKbf6NeaiUG0qZDPtvkBkWtUPu4V5p/2VTKEBQ3hvHyc
	 ML0OK6/Xy3su+u1xpYkJwd2XctNSaHUaNLOYkRVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbfG3DCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 23:02:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732730AbfG3DCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:02:03 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04A2C206BA;
        Tue, 30 Jul 2019 03:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455722;
        bh=ntdGkBOO43YdSvII+K0PCoOAFz3dJZOE6szTDEiDFiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZnhsSV6esjJzeH14sVJlXmgju3usj1Ih5cYirF17NoNFH3i20k01QgaOUD65ZTDOa
         3IBux0N2lPTFtGWwme+v3pNdKUErcM3WOZyVOLmeC4WkcUB2a/EsvUR+SVgFvc+tW6
         +jnedkJtqCt5xLoMbfNwxJp/sOFs8G4beQBdh7bY=
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
Subject: [PATCH 100/107] libperf: Add perf_cpu_map test
Date:   Mon, 29 Jul 2019 23:56:03 -0300
Message-Id: <20190730025610.22603-101-acme@kernel.org>
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
 create mode 100644 tools/perf/lib/tests/test-cpumap.c

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
-- 
2.21.0

