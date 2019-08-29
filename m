Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AE5C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52BBE2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbfH2TEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:04:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51387 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728552AbfH2TCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:02:02 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i3Pg5-00054T-Ot; Thu, 29 Aug 2019 21:01:49 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 530941C0DE6;
        Thu, 29 Aug 2019 21:01:49 +0200 (CEST)
Date:   Thu, 29 Aug 2019 19:01:49 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evlist: Remove needless util.h from evlist.h
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-s9f7uve8wvykr5itcm7m7d8q@git.kernel.org>
References: <tip-s9f7uve8wvykr5itcm7m7d8q@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156710530925.10529.16458167234117281705.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2da39f1cc36bff4cc53dc32a4afb3def488cc766
Gitweb:        https://git.kernel.org/tip/2da39f1cc36bff4cc53dc32a4afb3def488cc766
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Tue, 27 Aug 2019 11:51:18 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 28 Aug 2019 17:19:35 -03:00

perf evlist: Remove needless util.h from evlist.h

There is no need for that util/util.h include there and, remove it,
pruning the include tree, fix the fallout by adding necessary headers to
places that were getting needed includes indirectly from evlist.h ->
util.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-s9f7uve8wvykr5itcm7m7d8q@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/util/intel-bts.c | 1 +
 tools/perf/arch/x86/util/intel-pt.c  | 1 +
 tools/perf/builtin-report.c          | 1 +
 tools/perf/builtin-script.c          | 1 +
 tools/perf/builtin-top.c             | 1 +
 tools/perf/builtin-trace.c           | 1 +
 tools/perf/tests/sdt.c               | 1 +
 tools/perf/util/auxtrace.c           | 1 +
 tools/perf/util/evlist.c             | 1 +
 tools/perf/util/evlist.h             | 1 -
 tools/perf/util/evsel.c              | 1 +
 tools/perf/util/header.c             | 1 +
 tools/perf/util/session.c            | 1 +
 13 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index 16d26ea..e4bb5df 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -22,6 +22,7 @@
 #include "../../util/tsc.h"
 #include "../../util/auxtrace.h"
 #include "../../util/intel-bts.h"
+#include "../../util/util.h"
 
 #define KiB(x) ((x) * 1024)
 #define MiB(x) ((x) * 1024 * 1024)
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 746981c..04b424a 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -26,6 +26,7 @@
 #include "../../util/record.h"
 #include "../../util/target.h"
 #include "../../util/tsc.h"
+#include "../../util/util.h"
 #include "../../util/intel-pt.h"
 
 #define KiB(x) ((x) * 1024)
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 318b0b9..0338916 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -44,6 +44,7 @@
 #include "util/auxtrace.h"
 #include "util/units.h"
 #include "util/branch.h"
+#include "util/util.h"
 
 #include <dlfcn.h>
 #include <errno.h>
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 51e7e6d..e005be0 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -52,6 +52,7 @@
 #include <subcmd/pager.h>
 #include <perf/evlist.h>
 #include "util/record.h"
+#include "util/util.h"
 
 #include <linux/ctype.h>
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 29e910f..42ba733 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -34,6 +34,7 @@
 #include "util/thread.h"
 #include "util/thread_map.h"
 #include "util/top.h"
+#include "util/util.h"
 #include <linux/rbtree.h>
 #include <subcmd/parse-options.h>
 #include "util/parse-events.h"
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 58a75dd..6d9805a 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -41,6 +41,7 @@
 #include "util/intlist.h"
 #include "util/thread_map.h"
 #include "util/stat.h"
+#include "util/util.h"
 #include "trace/beauty/beauty.h"
 #include "trace-event.h"
 #include "util/parse-events.h"
diff --git a/tools/perf/tests/sdt.c b/tools/perf/tests/sdt.c
index 8bfaa63..dbc35a8 100644
--- a/tools/perf/tests/sdt.c
+++ b/tools/perf/tests/sdt.c
@@ -9,6 +9,7 @@
 #include "debug.h"
 #include "probe-file.h"
 #include "build-id.h"
+#include "util.h"
 
 /* To test SDT event, we need libelf support to scan elf binary */
 #if defined(HAVE_SDT_EVENT) && defined(HAVE_LIBELF_SUPPORT)
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 12e9b7a..112c24a 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -50,6 +50,7 @@
 #include "intel-bts.h"
 #include "arm-spe.h"
 #include "s390-cpumsf.h"
+#include "util.h"
 
 #include <linux/ctype.h>
 #include "symbol/kallsyms.h"
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 47bc541..5ad92fa 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -16,6 +16,7 @@
 #include "evsel.h"
 #include "debug.h"
 #include "units.h"
+#include "util.h"
 #include "asm/bug.h"
 #include "bpf-event.h"
 #include <signal.h>
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index e31ddcc..16796de 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -13,7 +13,6 @@
 #include "event.h"
 #include "evsel.h"
 #include "mmap.h"
-#include "util.h"
 #include <signal.h>
 #include <unistd.h>
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d4540bf..dbc04e1 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -40,6 +40,7 @@
 #include "stat.h"
 #include "string2.h"
 #include "memswap.h"
+#include "util.h"
 #include "util/parse-branch-options.h"
 #include <internal/xyarray.h>
 
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 1f2965a..8e67faf 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -42,6 +42,7 @@
 #include "tool.h"
 #include "time-utils.h"
 #include "units.h"
+#include "util.h"
 #include "cputopo.h"
 #include "bpf-event.h"
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 5786e9c..a275f2e 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -29,6 +29,7 @@
 #include "thread-stack.h"
 #include "sample-raw.h"
 #include "stat.h"
+#include "util.h"
 #include "arch/common.h"
 
 #ifdef HAVE_ZSTD_SUPPORT
