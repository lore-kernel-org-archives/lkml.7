Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B375DC5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8991521848
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562034449;
	bh=kgy3SpHroadiAPl/0cm8+ztIAnV3ww+y3wkrQIhutDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KvsWPCnae8emtlIafXibLuv5Y9Dque6YMdjGXWvrFZyNj6rVqRAme/hZmUFz07Eg/
	 +W3nh4CC9Ngk1X/KUMo7hETMSpNhLdW5Thjg7zr7IG9w2x1ubM7jB+Pxm17bu/ldgo
	 W/s/ENOabwoIcfCnwH4kexfxbQ17Y5mKwvFdR+s0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfGBC12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 22:27:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727388AbfGBC10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:27:26 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0936A21841;
        Tue,  2 Jul 2019 02:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562034445;
        bh=kgy3SpHroadiAPl/0cm8+ztIAnV3ww+y3wkrQIhutDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j4Wf16/B/oP4Q+v2fyTwLIJHEL9ZrjepQPBcozq/yAv+7WfRfR9RivF/zgeWFjYGx
         pgoNuqQQZjlsX6+Sk07yy/qj2+XdkL0L3d2avW09HbIMgom12oBDQTf86IA+nke/zw
         XTxrY+xGK4E9He1eOsTWnvngJZvnsA7I4q51o0Cc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 20/43] perf tools: Add missing util.h to pick up 'page_size' variable
Date:   Mon,  1 Jul 2019 23:25:53 -0300
Message-Id: <20190702022616.1259-21-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.20.1

