Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FBAC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851C521726
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455729;
	bh=msg2zRUHRtQpPDaDEDuFOJP28cJLnJEQzSKjlhFvb7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YdBe4DPZw0ufYKgdFypg+kGAfC0RnIyc9FE72Xq9Mv9qcWBxU6WahKBPXOAFrL+6k
	 RWL8SCh6+fZMiMuDZF2MBeZ08oZTAFXxADZEJFckBq/74fD/CFkUoUfDpPr6L7Y89h
	 +l5S3EaBdaWz1N2Lm8c1NrK2v6nnvaGrMOCe9fiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732755AbfG3DCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 23:02:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732723AbfG3DCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:02:06 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AA13216C8;
        Tue, 30 Jul 2019 03:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455725;
        bh=msg2zRUHRtQpPDaDEDuFOJP28cJLnJEQzSKjlhFvb7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OMby4ckaSLAC5zvc5Bk6JEYePQYMxFaME18iyLcFeO0GRnf1OBr4bWSiotlbm2yte
         6JZGiVcE+06d5fLDmExBQGbiZwAod9PdQ7puwzgKdd4nrVzBE8bGnlOj/o2f6eP4Lq
         ocH5DzrUv/JSPFNdBHCYIP7ZKDlT72Om/Ryj5j+o=
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
Subject: [PATCH 101/107] libperf: Add perf_thread_map test
Date:   Mon, 29 Jul 2019 23:56:04 -0300
Message-Id: <20190730025610.22603-102-acme@kernel.org>
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
 create mode 100644 tools/perf/lib/tests/test-threadmap.c

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
-- 
2.21.0

