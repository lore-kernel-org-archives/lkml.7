Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D3BC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA1A23401
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566507767;
	bh=jxu+70qrv7nSKdnj+cyMiGPUdEsbzQXchm9JH2HDaB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fd3N0YKjgvuZAHB04tNZRZy4shVUlccfgk+lX0IrKZVp8G1ilGMPDWT8Y3krr/F/8
	 XakWhiUObpmeDAd9oJbTck/zcK6Yo8bfCsL3Hg2cpFLM36FNftbCugsOxdoifGPagf
	 Nrsh+6zUT4kTyLISIAyC98BbPV7w916Cok8NcE18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390152AbfHVVCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 17:02:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388493AbfHVVCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:02:44 -0400
Received: from quaco.ghostprotocols.net (unknown [177.158.141.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93122233FC;
        Thu, 22 Aug 2019 21:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566507762;
        bh=jxu+70qrv7nSKdnj+cyMiGPUdEsbzQXchm9JH2HDaB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JZfxm0DeJtqVg5RcbltWKIo7hOfeI3fFxvco3vlzQla5cZIRO00t1nHPBMKdWHlnR
         mKRvx8JktKwf8yba82XsW1rHNMZssDqFV7HUiSLtn4MmGagLPDuBECEzjrxSUBXglM
         S3rczb4W+0lYzJzJD8J6+/+iA5Fs2ilHZKi5HxwA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 22/25] perf cpumap: Remove needless includes from cpumap.h
Date:   Thu, 22 Aug 2019 18:00:57 -0300
Message-Id: <20190822210100.3461-23-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822210100.3461-1-acme@kernel.org>
References: <20190822210100.3461-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The util/cpumap.h file doesn't use anything in refcount.h not in
debug.h, it needs just a forward reference to 'struct cpu_map_data',
that is defined in util/event.h and cpumap.h was getting indirectly via,
of all things, debug.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-mtjww98yptt4ppo6g2blavg5@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/util/header.c | 1 +
 tools/perf/tests/mem2node.c       | 1 +
 tools/perf/util/cpumap.c          | 2 ++
 tools/perf/util/cpumap.h          | 4 ++--
 tools/perf/util/cputopo.c         | 2 ++
 tools/perf/util/env.c             | 1 +
 tools/perf/util/mem2node.c        | 1 +
 tools/perf/util/pmu.c             | 1 +
 tools/perf/util/svghelper.c       | 1 +
 9 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/util/header.c b/tools/perf/arch/x86/util/header.c
index af9a9f2600be..662ecf84a421 100644
--- a/tools/perf/arch/x86/util/header.c
+++ b/tools/perf/arch/x86/util/header.c
@@ -6,6 +6,7 @@
 #include <string.h>
 #include <regex.h>
 
+#include "../../util/debug.h"
 #include "../../util/header.h"
 
 static inline void
diff --git a/tools/perf/tests/mem2node.c b/tools/perf/tests/mem2node.c
index 5ec193f7968d..73b2855acaf4 100644
--- a/tools/perf/tests/mem2node.c
+++ b/tools/perf/tests/mem2node.c
@@ -4,6 +4,7 @@
 #include <linux/zalloc.h>
 #include <perf/cpumap.h>
 #include "cpumap.h"
+#include "debug.h"
 #include "mem2node.h"
 #include "tests.h"
 
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 8e6c2cbffedc..f5c21184e1fc 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -2,6 +2,8 @@
 #include <api/fs/fs.h>
 #include "../perf.h"
 #include "cpumap.h"
+#include "debug.h"
+#include "event.h"
 #include <assert.h>
 #include <dirent.h>
 #include <stdio.h>
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 8dbedda7af45..d0c5bbfd91af 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -4,12 +4,12 @@
 
 #include <stdio.h>
 #include <stdbool.h>
-#include <linux/refcount.h>
 #include <internal/cpumap.h>
 #include <perf/cpumap.h>
 
 #include "perf.h"
-#include "util/debug.h"
+
+struct cpu_map_data;
 
 struct perf_cpu_map *perf_cpu_map__empty_new(int nr);
 struct perf_cpu_map *cpu_map__new_data(struct cpu_map_data *data);
diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index 4f70155eaf83..1b52402a8923 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -3,12 +3,14 @@
 #include <sys/utsname.h>
 #include <inttypes.h>
 #include <stdlib.h>
+#include <string.h>
 #include <api/fs/fs.h>
 #include <linux/zalloc.h>
 #include <perf/cpumap.h>
 
 #include "cputopo.h"
 #include "cpumap.h"
+#include "debug.h"
 #include "env.h"
 
 #define CORE_SIB_FMT \
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index d77912b2b5e7..571efb4f0351 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "cpumap.h"
+#include "debug.h"
 #include "env.h"
 #include <linux/ctype.h>
 #include <linux/zalloc.h>
diff --git a/tools/perf/util/mem2node.c b/tools/perf/util/mem2node.c
index cacc2fc4dcbd..14fb9e72aeeb 100644
--- a/tools/perf/util/mem2node.c
+++ b/tools/perf/util/mem2node.c
@@ -2,6 +2,7 @@
 #include <inttypes.h>
 #include <linux/bitmap.h>
 #include <linux/zalloc.h>
+#include "debug.h"
 #include "mem2node.h"
 
 struct phys_entry {
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index b7da21a7d627..9807be6f09bb 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -16,6 +16,7 @@
 #include <locale.h>
 #include <regex.h>
 #include <perf/cpumap.h>
+#include "debug.h"
 #include "pmu.h"
 #include "parse-events.h"
 #include "cpumap.h"
diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
index ae6a534a7a80..bbdd87163285 100644
--- a/tools/perf/util/svghelper.c
+++ b/tools/perf/util/svghelper.c
@@ -14,6 +14,7 @@
 #include <unistd.h>
 #include <string.h>
 #include <linux/bitmap.h>
+#include <linux/string.h>
 #include <linux/time64.h>
 #include <linux/zalloc.h>
 #include <perf/cpumap.h>
-- 
2.21.0

