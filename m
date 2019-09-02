Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F06C3A5A8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33243215EA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbfIBIRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:17:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56329 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730318AbfIBIQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:16:56 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i4hW2-0008CE-29; Mon, 02 Sep 2019 10:16:46 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0614D1C0DFA;
        Mon,  2 Sep 2019 10:16:40 +0200 (CEST)
Date:   Mon, 02 Sep 2019 08:16:39 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf auxtrace: Uninline functions that touch perf_session
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-d2d83aovpgri2z75wlitquni@git.kernel.org>
References: <tip-d2d83aovpgri2z75wlitquni@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156741219976.17372.1975584309526201984.tip-bot2@tip-bot2>
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

Commit-ID:     f2a39fe84901df2b3d1bec3459b65cee3e8db57c
Gitweb:        https://git.kernel.org/tip/f2a39fe84901df2b3d1bec3459b65cee3e8db57c
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 30 Aug 2019 14:45:20 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 31 Aug 2019 22:24:10 -03:00

perf auxtrace: Uninline functions that touch perf_session

So that we don't carry the session.h include directive in auxtrace.h,
which in turn opens a can of worms of files that were getting all sorts
of things via that include, fix them all.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-d2d83aovpgri2z75wlitquni@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/annotate/instructions.c   |  1 +-
 tools/perf/arch/arm/util/cs-etm.c             |  1 +-
 tools/perf/arch/arm64/annotate/instructions.c |  1 +-
 tools/perf/arch/x86/tests/perf-time-to-tsc.c  |  1 +-
 tools/perf/builtin-ftrace.c                   |  1 +-
 tools/perf/tests/backward-ring-buffer.c       |  1 +-
 tools/perf/tests/bpf.c                        |  1 +-
 tools/perf/tests/builtin-test.c               |  1 +-
 tools/perf/tests/code-reading.c               |  6 +++-
 tools/perf/tests/event-times.c                |  1 +-
 tools/perf/tests/event_update.c               |  2 +-
 tools/perf/tests/keep-tracking.c              |  1 +-
 tools/perf/tests/mmap-basic.c                 |  1 +-
 tools/perf/tests/parse-events.c               |  1 +-
 tools/perf/tests/switch-tracking.c            |  1 +-
 tools/perf/ui/browsers/hists.c                |  1 +-
 tools/perf/ui/browsers/res_sample.c           |  2 +-
 tools/perf/ui/browsers/scripts.c              |  1 +-
 tools/perf/ui/hist.c                          |  2 +-
 tools/perf/ui/stdio/hist.c                    |  1 +-
 tools/perf/util/annotate.c                    |  3 +-
 tools/perf/util/auxtrace.c                    | 33 ++++++++++++++-
 tools/perf/util/auxtrace.h                    | 43 ++----------------
 tools/perf/util/bpf-loader.c                  |  1 +-
 tools/perf/util/cgroup.c                      |  2 +-
 tools/perf/util/config.c                      |  1 +-
 tools/perf/util/cs-etm.c                      |  1 +-
 tools/perf/util/cs-etm.h                      |  3 +-
 tools/perf/util/dso.c                         |  2 +-
 tools/perf/util/evlist.c                      |  1 +-
 tools/perf/util/evsel.c                       |  1 +-
 tools/perf/util/machine.c                     |  2 +-
 tools/perf/util/mmap.c                        |  3 +-
 tools/perf/util/mmap.h                        |  1 +-
 tools/perf/util/python.c                      |  2 +-
 tools/perf/util/record.c                      |  2 +-
 tools/perf/util/s390-sample-raw.c             |  1 +-
 tools/perf/util/sort.c                        |  1 +-
 tools/perf/util/stat-display.c                |  1 +-
 tools/perf/util/stat.c                        |  3 +-
 tools/perf/util/top.h                         |  1 +-
 41 files changed, 98 insertions(+), 38 deletions(-)

diff --git a/tools/perf/arch/arm/annotate/instructions.c b/tools/perf/arch/arm/annotate/instructions.c
index c7d1a69..e1d4b48 100644
--- a/tools/perf/arch/arm/annotate/instructions.c
+++ b/tools/perf/arch/arm/annotate/instructions.c
@@ -3,6 +3,7 @@
 #include <linux/zalloc.h>
 #include <sys/types.h>
 #include <regex.h>
+#include <stdlib.h>
 
 struct arm_annotate {
 	regex_t call_insn,
diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 59e44f9..c32db09 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -26,6 +26,7 @@
 #include "../../util/pmu.h"
 #include "../../util/cs-etm.h"
 #include "../../util/util.h"
+#include "../../util/session.h"
 
 #include <errno.h>
 #include <stdlib.h>
diff --git a/tools/perf/arch/arm64/annotate/instructions.c b/tools/perf/arch/arm64/annotate/instructions.c
index 8f70a1b..43aa93e 100644
--- a/tools/perf/arch/arm64/annotate/instructions.c
+++ b/tools/perf/arch/arm64/annotate/instructions.c
@@ -2,6 +2,7 @@
 #include <linux/compiler.h>
 #include <sys/types.h>
 #include <regex.h>
+#include <stdlib.h>
 
 struct arm64_annotate {
 	regex_t call_insn,
diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index 2d1f471..eb36359 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
 #include <inttypes.h>
+#include <limits.h>
 #include <stdbool.h>
 #include <stdio.h>
 #include <unistd.h>
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 2f8ea44..d5adc41 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -10,6 +10,7 @@
 #include <errno.h>
 #include <unistd.h>
 #include <signal.h>
+#include <stdlib.h>
 #include <fcntl.h>
 #include <poll.h>
 #include <linux/capability.h>
diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index 512288e..a637a4a 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -9,6 +9,7 @@
 #include "record.h"
 #include "tests.h"
 #include "debug.h"
+#include "parse-events.h"
 #include <errno.h>
 #include <linux/string.h>
 
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 9fc163b..fc102e4 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -18,6 +18,7 @@
 #include "tests.h"
 #include "llvm.h"
 #include "debug.h"
+#include "parse-events.h"
 #define NR_ITERS       111
 #define PERF_TEST_BPF_PATH "/sys/fs/bpf/perf_test"
 
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index c3bec9d..55774ba 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -8,6 +8,7 @@
 #include <errno.h>
 #include <unistd.h>
 #include <string.h>
+#include <stdlib.h>
 #include <sys/types.h>
 #include <dirent.h>
 #include <sys/wait.h>
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 7b2b89f..c1c29e0 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -13,7 +13,9 @@
 
 #include "debug.h"
 #include "dso.h"
+#include "env.h"
 #include "parse-events.h"
+#include "trace-event.h"
 #include "evlist.h"
 #include "evsel.h"
 #include "thread_map.h"
@@ -496,6 +498,10 @@ static void fs_something(void)
 	}
 }
 
+#ifdef __s390x__
+#include "header.h" // for get_cpuid()
+#endif
+
 static const char *do_determine_event(bool excl_kernel)
 {
 	const char *event = excl_kernel ? "cycles:u" : "cycles";
diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
index 228d161..d824a72 100644
--- a/tools/perf/tests/event-times.c
+++ b/tools/perf/tests/event-times.c
@@ -11,6 +11,7 @@
 #include "evsel.h"
 #include "util.h"
 #include "debug.h"
+#include "parse-events.h"
 #include "thread_map.h"
 #include "target.h"
 
diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
index 4b68ec3..cac4290 100644
--- a/tools/perf/tests/event_update.c
+++ b/tools/perf/tests/event_update.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/compiler.h>
 #include <perf/cpumap.h>
+#include <string.h>
 #include "evlist.h"
 #include "evsel.h"
+#include "header.h"
 #include "machine.h"
 #include "tool.h"
 #include "tests.h"
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index c758798..9f0762d 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/types.h>
+#include <limits.h>
 #include <unistd.h>
 #include <sys/prctl.h>
 #include <perf/cpumap.h>
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index bdf77bf..85e1d73 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -3,6 +3,7 @@
 #include <inttypes.h>
 /* For the CLR_() macros */
 #include <pthread.h>
+#include <stdlib.h>
 #include <perf/cpumap.h>
 
 #include "debug.h"
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 49f52e4..02ba696 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -5,6 +5,7 @@
 #include <api/fs/fs.h>
 #include "tests.h"
 #include "debug.h"
+#include "pmu.h"
 #include "util.h"
 #include <dirent.h>
 #include <errno.h>
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 4bed15a..1a60fa1 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -2,6 +2,7 @@
 #include <sys/time.h>
 #include <sys/prctl.h>
 #include <errno.h>
+#include <limits.h>
 #include <time.h>
 #include <stdlib.h>
 #include <linux/zalloc.h>
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index cf88574..f7e54c1 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -16,6 +16,7 @@
 #include "../../util/callchain.h"
 #include "../../util/evsel.h"
 #include "../../util/evlist.h"
+#include "../../util/header.h"
 #include "../../util/hist.h"
 #include "../../util/map.h"
 #include "../../util/symbol.h"
diff --git a/tools/perf/ui/browsers/res_sample.c b/tools/perf/ui/browsers/res_sample.c
index db3954f..f16a38f 100644
--- a/tools/perf/ui/browsers/res_sample.c
+++ b/tools/perf/ui/browsers/res_sample.c
@@ -9,6 +9,8 @@
 #include "../util.h"
 #include "../../util/util.h"
 #include "../../perf.h"
+#include <stdlib.h>
+#include <string.h>
 #include <linux/time64.h>
 #include <linux/zalloc.h>
 
diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index bf1d9f9..586a21a 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -10,6 +10,7 @@
 #include "config.h"
 #include <linux/string.h>
 #include <linux/zalloc.h>
+#include <stdlib.h>
 
 #define SCRIPT_NAMELEN	128
 #define SCRIPT_MAX_NO	64
diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index bf90ce5..3e533de 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <inttypes.h>
 #include <math.h>
+#include <stdlib.h>
+#include <string.h>
 #include <linux/compiler.h>
 
 #include "../util/callchain.h"
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 51ed675..832ca6c 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
+#include <stdlib.h>
 #include <linux/string.h>
 
 #include "../../util/callchain.h"
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index eb3c50d..1748f52 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -9,6 +9,7 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <libgen.h>
+#include <stdlib.h>
 #include <bpf/bpf.h>
 #include <bpf/btf.h>
 #include <bpf/libbpf.h>
@@ -20,7 +21,9 @@
 #include "color.h"
 #include "config.h"
 #include "dso.h"
+#include "env.h"
 #include "map.h"
+#include "map_groups.h"
 #include "symbol.h"
 #include "srcline.h"
 #include "units.h"
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 10c7077..6f25224 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -2196,3 +2196,36 @@ int auxtrace_parse_filters(struct evlist *evlist)
 
 	return 0;
 }
+
+int auxtrace__process_event(struct perf_session *session, union perf_event *event,
+			    struct perf_sample *sample, struct perf_tool *tool)
+{
+	if (!session->auxtrace)
+		return 0;
+
+	return session->auxtrace->process_event(session, event, sample, tool);
+}
+
+int auxtrace__flush_events(struct perf_session *session, struct perf_tool *tool)
+{
+	if (!session->auxtrace)
+		return 0;
+
+	return session->auxtrace->flush_events(session, tool);
+}
+
+void auxtrace__free_events(struct perf_session *session)
+{
+	if (!session->auxtrace)
+		return;
+
+	return session->auxtrace->free_events(session);
+}
+
+void auxtrace__free(struct perf_session *session)
+{
+	if (!session->auxtrace)
+		return;
+
+	return session->auxtrace->free(session);
+}
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index c539e7b..37e70dc 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -18,7 +18,6 @@
 #include <asm/barrier.h>
 
 #include "event.h"
-#include "session.h"
 
 union perf_event;
 struct perf_session;
@@ -380,6 +379,8 @@ struct addr_filters {
 	int			cnt;
 };
 
+struct auxtrace_cache;
+
 #ifdef HAVE_AUXTRACE_SUPPORT
 
 /*
@@ -549,41 +550,11 @@ int addr_filters__parse_bare_filter(struct addr_filters *filts,
 				    const char *filter);
 int auxtrace_parse_filters(struct evlist *evlist);
 
-static inline int auxtrace__process_event(struct perf_session *session,
-					  union perf_event *event,
-					  struct perf_sample *sample,
-					  struct perf_tool *tool)
-{
-	if (!session->auxtrace)
-		return 0;
-
-	return session->auxtrace->process_event(session, event, sample, tool);
-}
-
-static inline int auxtrace__flush_events(struct perf_session *session,
-					 struct perf_tool *tool)
-{
-	if (!session->auxtrace)
-		return 0;
-
-	return session->auxtrace->flush_events(session, tool);
-}
-
-static inline void auxtrace__free_events(struct perf_session *session)
-{
-	if (!session->auxtrace)
-		return;
-
-	return session->auxtrace->free_events(session);
-}
-
-static inline void auxtrace__free(struct perf_session *session)
-{
-	if (!session->auxtrace)
-		return;
-
-	return session->auxtrace->free(session);
-}
+int auxtrace__process_event(struct perf_session *session, union perf_event *event,
+			    struct perf_sample *sample, struct perf_tool *tool);
+int auxtrace__flush_events(struct perf_session *session, struct perf_tool *tool);
+void auxtrace__free_events(struct perf_session *session);
+void auxtrace__free(struct perf_session *session);
 
 #define ITRACE_HELP \
 "				i:	    		synthesize instructions events\n"		\
diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index c1a5732..37283e8 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -14,6 +14,7 @@
 #include <linux/string.h>
 #include <linux/zalloc.h>
 #include <errno.h>
+#include <stdlib.h>
 #include "debug.h"
 #include "evlist.h"
 #include "bpf-loader.h"
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 96a931c..4881d4a 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -8,6 +8,8 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
+#include <stdlib.h>
+#include <string.h>
 
 int nr_cgroups;
 
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 7ebf9e3..0bc9c4d 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -23,6 +23,7 @@
 #include "debug.h"
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <stdlib.h>
 #include <unistd.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 30c2048..0174ecf 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -27,6 +27,7 @@
 #include "machine.h"
 #include "map.h"
 #include "perf.h"
+#include "session.h"
 #include "symbol.h"
 #include "tool.h"
 #include "thread.h"
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index bc848fd..650ecc2 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -8,9 +8,10 @@
 #define INCLUDE__UTIL_PERF_CS_ETM_H__
 
 #include "util/event.h"
-#include "util/session.h"
 #include <linux/bits.h>
 
+struct perf_session;
+
 /* Versionning header in case things need tro change in the future.  That way
  * decoding of old snapshot is still possible.
  */
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index ece9720..e11ddf8 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -10,9 +10,11 @@
 #include <unistd.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <stdlib.h>
 #include <bpf/libbpf.h>
 #include "bpf-event.h"
 #include "compress.h"
+#include "env.h"
 #include "namespaces.h"
 #include "path.h"
 #include "map.h"
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index b5d6d6e..095924a 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -23,6 +23,7 @@
 #include <signal.h>
 #include <unistd.h>
 #include <sched.h>
+#include <stdlib.h>
 
 #include "parse-events.h"
 #include <subcmd/parse-options.h>
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index b6b406a..8582538 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -22,6 +22,7 @@
 #include <sys/resource.h>
 #include <sys/types.h>
 #include <dirent.h>
+#include <stdlib.h>
 #include <perf/evsel.h>
 #include "asm/bug.h"
 #include "callchain.h"
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 0030254..6a77aef 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -3,9 +3,11 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <regex.h>
+#include <stdlib.h>
 #include "callchain.h"
 #include "debug.h"
 #include "dso.h"
+#include "env.h"
 #include "event.h"
 #include "evsel.h"
 #include "hist.h"
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 28477ff..33c5b54 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -10,9 +10,12 @@
 #include <inttypes.h>
 #include <asm/bug.h>
 #include <linux/zalloc.h>
+#include <stdlib.h>
+#include <string.h>
 #ifdef HAVE_LIBNUMA_SUPPORT
 #include <numaif.h>
 #endif
+#include "cpumap.h"
 #include "debug.h"
 #include "event.h"
 #include "mmap.h"
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 274ce38..3857a49 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 #include <linux/ring_buffer.h>
 #include <stdbool.h>
+#include <pthread.h> // for cpu_set_t
 #ifdef HAVE_AIO_SUPPORT
 #include <aio.h>
 #endif
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 9b35048..07ca453 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -5,6 +5,7 @@
 #include <poll.h>
 #include <linux/err.h>
 #include <perf/cpumap.h>
+#include <traceevent/event-parse.h>
 #include "debug.h"
 #include "evlist.h"
 #include "callchain.h"
@@ -13,6 +14,7 @@
 #include "cpumap.h"
 #include "print_binary.h"
 #include "thread_map.h"
+#include "trace-event.h"
 #include "mmap.h"
 #include "util.h"
 #include "../perf-sys.h"
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index ccad796..286fe81 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -5,6 +5,8 @@
 #include "cpumap.h"
 #include "parse-events.h"
 #include <errno.h>
+#include <limits.h>
+#include <stdlib.h>
 #include <api/fs/fs.h>
 #include <subcmd/parse-options.h>
 #include <perf/cpumap.h>
diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
index d311c81..0ddfa7b 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -23,7 +23,6 @@
 
 #include "debug.h"
 #include "util.h"
-#include "auxtrace.h"
 #include "session.h"
 #include "evlist.h"
 #include "config.h"
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 32ade5a..b974a2c 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2,6 +2,7 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <regex.h>
+#include <stdlib.h>
 #include <linux/mman.h>
 #include <linux/time64.h>
 #include "debug.h"
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 1461dac..ed3b0ac 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1,3 +1,4 @@
+#include <stdlib.h>
 #include <stdio.h>
 #include <inttypes.h>
 #include <linux/string.h>
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index f4a1edc..8f1ea27 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -2,9 +2,12 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <math.h>
+#include <string.h>
 #include "counts.h"
 #include "debug.h"
+#include "header.h"
 #include "stat.h"
+#include "session.h"
 #include "target.h"
 #include "evlist.h"
 #include "evsel.h"
diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
index 7367433..f117d4f 100644
--- a/tools/perf/util/top.h
+++ b/tools/perf/util/top.h
@@ -5,6 +5,7 @@
 #include "tool.h"
 #include "evswitch.h"
 #include "annotate.h"
+#include "ordered-events.h"
 #include "record.h"
 #include <linux/types.h>
 #include <stddef.h>
