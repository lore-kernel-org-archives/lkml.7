Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C0BC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065F421881
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="MtVzlxRl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfGCOPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:15:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48441 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCOPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:15:11 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63EEofp3322431
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:14:50 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63EEofp3322431
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562163291;
        bh=YhMb3HnppjnPcW38wxF30AgcG6B3xZ7brOcXWbR8RpY=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=MtVzlxRlutE+RQyt0edDPNcpX1gmZUdI3DgkvPENr1XLgootokQfBC9OwhkzRpXS0
         syhMmA4b2a6MBEdkRQAAglUVNV7CTGOe2IPCHICpYS3D0327yRk4m61O0gN2E+afEH
         kvaj3mninAqDgYl7OwaFmOQv4HzX4tzv4lt1U2ESTQ8Cn+KHTNglGuX8SI0Klq+mOE
         3Xonmq9zIaSNXQWYdoDdmr7DZ/5l0rlmTpmD8iIyweGhdjq3zgXF5eK9Z/hWyLt6B5
         Rx8XhcCzlv3R70mdym3z+mCvl2apkF+Hmr1tteshN0qfDZKX+dmIkGRKQypO4jydSd
         wQJ16VhnGpUzA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63EEnhI3322428;
        Wed, 3 Jul 2019 07:14:49 -0700
Date:   Wed, 3 Jul 2019 07:14:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-tirjsmvu4ektw0k7lm8k9lhu@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        mingo@kernel.org, namhyung@kernel.org, jolsa@kernel.org,
        acme@redhat.com, tglx@linutronix.de, hpa@zytor.com
Reply-To: tglx@linutronix.de, hpa@zytor.com, jolsa@kernel.org,
          acme@redhat.com, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
          mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Add missing util.h to pick up
 'page_size' variable
Git-Commit-ID: 1b2fc358ddfb1b0915922e441182cda7043f5116
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

Commit-ID:  1b2fc358ddfb1b0915922e441182cda7043f5116
Gitweb:     https://git.kernel.org/tip/1b2fc358ddfb1b0915922e441182cda7043f5116
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 25 Jun 2019 18:35:34 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 25 Jun 2019 18:35:34 -0300

perf tools: Add missing util.h to pick up 'page_size' variable

Not to depend of getting it indirectly.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-tirjsmvu4ektw0k7lm8k9lhu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c     | 1 +
 tools/perf/arch/x86/tests/intel-cqm.c | 1 +
 tools/perf/arch/x86/util/intel-pt.c   | 1 +
 tools/perf/perf.c                     | 1 +
 tools/perf/util/machine.c             | 1 +
 tools/perf/util/python.c              | 1 +
 6 files changed, 6 insertions(+)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index c6f1ab5499b5..2b83cc8e4796 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -22,6 +22,7 @@
 #include "../../util/pmu.h"
 #include "../../util/thread_map.h"
 #include "../../util/cs-etm.h"
+#include "../../util/util.h"
 
 #include <errno.h>
 #include <stdlib.h>
diff --git a/tools/perf/arch/x86/tests/intel-cqm.c b/tools/perf/arch/x86/tests/intel-cqm.c
index 90a4a8c58a62..94aa0b673b7f 100644
--- a/tools/perf/arch/x86/tests/intel-cqm.c
+++ b/tools/perf/arch/x86/tests/intel-cqm.c
@@ -6,6 +6,7 @@
 #include "evlist.h"
 #include "evsel.h"
 #include "arch-tests.h"
+#include "util.h"
 
 #include <signal.h>
 #include <sys/mman.h>
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 1869f62a10cd..9804098dcefb 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -25,6 +25,7 @@
 #include "../../util/auxtrace.h"
 #include "../../util/tsc.h"
 #include "../../util/intel-pt.h"
+#include "../../util/util.h"
 
 #define KiB(x) ((x) * 1024)
 #define MiB(x) ((x) * 1024 * 1024)
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 72df4b6fa36f..2123b3cc4dcf 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -18,6 +18,7 @@
 #include "util/bpf-loader.h"
 #include "util/debug.h"
 #include "util/event.h"
+#include "util/util.h"
 #include <api/fs/fs.h>
 #include <api/fs/tracing_path.h>
 #include <errno.h>
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 17eec39e775e..a0bb05dd008f 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -15,6 +15,7 @@
 #include "strlist.h"
 #include "thread.h"
 #include "vdso.h"
+#include "util.h"
 #include <stdbool.h>
 #include <sys/types.h>
 #include <sys/stat.h>
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 6aa7e2352e16..1e5b6718dcea 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -12,6 +12,7 @@
 #include "print_binary.h"
 #include "thread_map.h"
 #include "mmap.h"
+#include "util.h"
 
 #if PY_MAJOR_VERSION < 3
 #define _PyUnicode_FromString(arg) \
