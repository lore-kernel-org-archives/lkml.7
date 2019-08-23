Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7515C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C340C21848
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394745AbfHWM32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 08:29:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35343 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732962AbfHWM32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 08:29:28 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i18h1-00023h-5R; Fri, 23 Aug 2019 14:29:23 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C99341C089A;
        Fri, 23 Aug 2019 14:29:22 +0200 (CEST)
Date:   Fri, 23 Aug 2019 12:29:22 -0000
From:   tip-bot2 for Arnaldo Carvalho de Melo <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf cpumap: Remove needless includes from cpumap.h
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <tip-mtjww98yptt4ppo6g2blavg5@git.kernel.org>
References: <tip-mtjww98yptt4ppo6g2blavg5@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156656336267.32664.13873332713303135890.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from
 these emails
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     5e51b0bb245d963f5ce750256c504be95201e38c
Gitweb:        https://git.kernel.org/tip/5e51b0bb245d963f5ce750256c504be95201e38c
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 22 Aug 2019 10:48:31 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 22 Aug 2019 17:16:57 -03:00

perf cpumap: Remove needless includes from cpumap.h

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
index af9a9f2..662ecf8 100644
--- a/tools/perf/arch/x86/util/header.c
+++ b/tools/perf/arch/x86/util/header.c
@@ -6,6 +6,7 @@
 #include <string.h>
 #include <regex.h>
 
+#include "../../util/debug.h"
 #include "../../util/header.h"
 
 static inline void
diff --git a/tools/perf/tests/mem2node.c b/tools/perf/tests/mem2node.c
index 5ec193f..73b2855 100644
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
index 8e6c2cb..f5c2118 100644
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
index 8dbedda..d0c5bbf 100644
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
index 4f70155..1b52402 100644
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
index d77912b..571efb4 100644
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
index cacc2fc..14fb9e7 100644
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
index b7da21a..9807be6 100644
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
index ae6a534..bbdd871 100644
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
