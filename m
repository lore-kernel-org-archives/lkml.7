Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2F2C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99302342C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567340775;
	bh=irElSeW6JXhFNF/ornX58kAPqxuqn0wSdnDTyDdhgkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zRHOuUrwjCom12r3DI1rEB77tNJKYlvXAaY5f6VC5ph/WK4lzY5a7DIR+OOjLkseb
	 wXuOojebz8vPmm/HZGi0qSG/i673q5Cf1x1RdTzeqzyAKVvNbplezPgXlHuQAzeW5x
	 Htrpo9AhIUX6pl0v2GGDGph56JRQwj1K++ih6FqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbfIAMZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 08:25:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:42640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729250AbfIAMZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:25:18 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 703CD23431;
        Sun,  1 Sep 2019 12:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567340716;
        bh=irElSeW6JXhFNF/ornX58kAPqxuqn0wSdnDTyDdhgkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qDnHxk1JK8dJh3+o5i5AwlLjxlO0N4pa0BNYv+7x0Iqf9EDyfOcdUB5L664f8+nhW
         MqIzBtJWjeDQVjzscQ5GzXh0S8su69RJbb/G4Bl5EoYAPIb+j48QQ0yHEXpewsl5xB
         PKDp442tlmBVL8LbePuFjIHWXkat0/vKv9lZw7VY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 35/47] perf tools: Remove needless evlist.h include directives
Date:   Sun,  1 Sep 2019 09:23:14 -0300
Message-Id: <20190901122326.5793-36-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Remove the last unneeded use of cache.h in a header, we can check where
it is really needed, i.e. we can remove it and be sure that it isn't
being obtained indirectly.

This is an old file, used by now incorrectly in many places, so it was
providing includes needed indirectly, fixup this fallout.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-3x3l8gihoaeh7714os861ia7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-buildid-cache.c                  | 3 ++-
 tools/perf/builtin-buildid-list.c                   | 2 +-
 tools/perf/builtin-kvm.c                            | 4 +++-
 tools/perf/builtin-list.c                           | 2 +-
 tools/perf/builtin-lock.c                           | 2 +-
 tools/perf/builtin-sched.c                          | 2 +-
 tools/perf/builtin-script.c                         | 2 +-
 tools/perf/builtin-timechart.c                      | 2 +-
 tools/perf/perf.c                                   | 2 +-
 tools/perf/tests/llvm.c                             | 2 +-
 tools/perf/ui/browsers/header.c                     | 1 -
 tools/perf/ui/gtk/browser.c                         | 1 -
 tools/perf/ui/gtk/hists.c                           | 1 -
 tools/perf/ui/gtk/setup.c                           | 1 -
 tools/perf/ui/helpline.h                            | 2 --
 tools/perf/ui/progress.c                            | 1 -
 tools/perf/ui/setup.c                               | 3 ++-
 tools/perf/ui/tui/helpline.c                        | 1 +
 tools/perf/ui/tui/progress.c                        | 1 -
 tools/perf/ui/tui/setup.c                           | 2 --
 tools/perf/ui/tui/util.c                            | 1 -
 tools/perf/util/annotate.c                          | 1 -
 tools/perf/util/color.c                             | 3 ++-
 tools/perf/util/color_config.c                      | 3 ++-
 tools/perf/util/debug.c                             | 2 +-
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 2 +-
 tools/perf/util/parse-events.c                      | 2 +-
 tools/perf/util/path.c                              | 3 ++-
 tools/perf/util/path.h                              | 3 +++
 tools/perf/util/pmu.c                               | 3 ++-
 tools/perf/util/probe-event.c                       | 3 ++-
 tools/perf/util/probe-file.c                        | 2 +-
 32 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index b035911969b8..1a69eb565dc0 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -15,9 +15,9 @@
 #include <unistd.h>
 #include "builtin.h"
 #include "namespaces.h"
-#include "util/cache.h"
 #include "util/debug.h"
 #include "util/header.h"
+#include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
 #include "util/strlist.h"
 #include "util/build-id.h"
@@ -27,6 +27,7 @@
 #include "util/time-utils.h"
 #include "util/util.h"
 #include "util/probe-file.h"
+#include <linux/string.h>
 
 static int build_id_cache__kcore_buildid(const char *proc_dir, char *sbuildid)
 {
diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
index 38b2ec61c021..5a0d8b378cb5 100644
--- a/tools/perf/builtin-buildid-list.c
+++ b/tools/perf/builtin-buildid-list.c
@@ -10,9 +10,9 @@
 #include "builtin.h"
 #include "perf.h"
 #include "util/build-id.h"
-#include "util/cache.h"
 #include "util/debug.h"
 #include "util/dso.h"
+#include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
 #include "util/session.h"
 #include "util/symbol.h"
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 474c4799d29d..0a4fcbe32bf6 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -6,12 +6,12 @@
 #include "util/evsel.h"
 #include "util/evlist.h"
 #include "util/term.h"
-#include "util/cache.h"
 #include "util/symbol.h"
 #include "util/thread.h"
 #include "util/header.h"
 #include "util/session.h"
 #include "util/intlist.h"
+#include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
 #include "util/trace-event.h"
 #include "util/debug.h"
@@ -20,6 +20,7 @@
 #include "util/top.h"
 #include "util/data.h"
 #include "util/ordered-events.h"
+#include "ui/ui.h"
 
 #include <sys/prctl.h>
 #ifdef HAVE_TIMERFD_SUPPORT
@@ -31,6 +32,7 @@
 #include <fcntl.h>
 
 #include <linux/kernel.h>
+#include <linux/string.h>
 #include <linux/time64.h>
 #include <linux/zalloc.h>
 #include <errno.h>
diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 11afb760616b..e290f6b348d8 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -11,10 +11,10 @@
 #include "builtin.h"
 
 #include "util/parse-events.h"
-#include "util/cache.h"
 #include "util/pmu.h"
 #include "util/debug.h"
 #include "util/metricgroup.h"
+#include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
 #include <stdio.h>
 
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index b0ff952be9db..4c2b7f437cdf 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -6,11 +6,11 @@
 
 #include "util/evlist.h" // for struct evsel_str_handler
 #include "util/evsel.h"
-#include "util/cache.h"
 #include "util/symbol.h"
 #include "util/thread.h"
 #include "util/header.h"
 
+#include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
 #include "util/trace-event.h"
 
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 91d0a9b10581..ec96d64aec69 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -4,7 +4,6 @@
 #include "perf-sys.h"
 
 #include "util/evlist.h"
-#include "util/cache.h"
 #include "util/evsel.h"
 #include "util/symbol.h"
 #include "util/thread.h"
@@ -19,6 +18,7 @@
 #include "util/callchain.h"
 #include "util/time-utils.h"
 
+#include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
 #include "util/trace-event.h"
 
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 1ff04b00a561..e079b34201f2 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "builtin.h"
 
-#include "util/cache.h"
 #include "util/counts.h"
 #include "util/debug.h"
 #include "util/dso.h"
@@ -30,6 +29,7 @@
 #include "util/thread-stack.h"
 #include "util/time-utils.h"
 #include "util/path.h"
+#include "ui/ui.h"
 #include "print_binary.h"
 #include "archinsn.h"
 #include <linux/bitmap.h>
diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 65560a86f643..e0e822695a29 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -14,7 +14,6 @@
 #include "builtin.h"
 #include "util/color.h"
 #include <linux/list.h>
-#include "util/cache.h"
 #include "util/evlist.h" // for struct evsel_str_handler
 #include "util/evsel.h"
 #include <linux/kernel.h>
@@ -27,6 +26,7 @@
 
 #include "perf.h"
 #include "util/header.h"
+#include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
 #include "util/parse-events.h"
 #include "util/event.h"
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 8763b2c0fbfd..1193b923e801 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -1,4 +1,3 @@
-// SPDX-License-Identifier: GPL-2.0
 /*
  * perf.c
  *
@@ -22,6 +21,7 @@
 #include "util/debug.h"
 #include "util/event.h"
 #include "util/util.h"
+#include "ui/ui.h"
 #include "perf-sys.h"
 #include <api/fs/fs.h>
 #include <api/fs/tracing_path.h>
diff --git a/tools/perf/tests/llvm.c b/tools/perf/tests/llvm.c
index ca5a5f94ce79..022e4c9cf092 100644
--- a/tools/perf/tests/llvm.c
+++ b/tools/perf/tests/llvm.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <bpf/libbpf.h>
 #include <util/llvm-utils.h>
-#include <util/cache.h>
 #include "llvm.h"
 #include "tests.h"
 #include "debug.h"
diff --git a/tools/perf/ui/browsers/header.c b/tools/perf/ui/browsers/header.c
index 5aeb663dd184..0f59a7001479 100644
--- a/tools/perf/ui/browsers/header.c
+++ b/tools/perf/ui/browsers/header.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "util/cache.h"
 #include "util/debug.h"
 #include "ui/browser.h"
 #include "ui/keysyms.h"
diff --git a/tools/perf/ui/gtk/browser.c b/tools/perf/ui/gtk/browser.c
index 06a6a1ebaef0..8f3e43d148a8 100644
--- a/tools/perf/ui/gtk/browser.c
+++ b/tools/perf/ui/gtk/browser.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "../cache.h"
 #include "../evsel.h"
 #include "../sort.h"
 #include "../hist.h"
diff --git a/tools/perf/ui/gtk/hists.c b/tools/perf/ui/gtk/hists.c
index 0efdb226d1a7..6c2efc10bf5c 100644
--- a/tools/perf/ui/gtk/hists.c
+++ b/tools/perf/ui/gtk/hists.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "../evlist.h"
-#include "../cache.h"
 #include "../callchain.h"
 #include "../evsel.h"
 #include "../sort.h"
diff --git a/tools/perf/ui/gtk/setup.c b/tools/perf/ui/gtk/setup.c
index 506e73b3834c..1a2616b97b5c 100644
--- a/tools/perf/ui/gtk/setup.c
+++ b/tools/perf/ui/gtk/setup.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "gtk.h"
-#include "../../util/cache.h"
 #include "../../util/debug.h"
 
 extern struct perf_error_ops perf_gtk_eops;
diff --git a/tools/perf/ui/helpline.h b/tools/perf/ui/helpline.h
index 8f775a053ca3..2165a098dee8 100644
--- a/tools/perf/ui/helpline.h
+++ b/tools/perf/ui/helpline.h
@@ -5,8 +5,6 @@
 #include <stdio.h>
 #include <stdarg.h>
 
-#include "../util/cache.h"
-
 struct ui_helpline {
 	void (*pop)(void);
 	void (*push)(const char *msg);
diff --git a/tools/perf/ui/progress.c b/tools/perf/ui/progress.c
index 8cd3b64c6893..99d60223c74b 100644
--- a/tools/perf/ui/progress.c
+++ b/tools/perf/ui/progress.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/kernel.h>
-#include "../util/cache.h"
 #include "progress.h"
 
 static void null_progress__update(struct ui_progress *p __maybe_unused)
diff --git a/tools/perf/ui/setup.c b/tools/perf/ui/setup.c
index 3bc7c9a6fae9..c7a86b4be9f5 100644
--- a/tools/perf/ui/setup.c
+++ b/tools/perf/ui/setup.c
@@ -2,10 +2,11 @@
 #include <pthread.h>
 #include <dlfcn.h>
 
-#include "../util/cache.h"
+#include <subcmd/pager.h>
 #include "../util/debug.h"
 #include "../util/hist.h"
 #include "../util/util.h"
+#include "ui.h"
 
 pthread_mutex_t ui__lock = PTHREAD_MUTEX_INITIALIZER;
 void *perf_gtk_handle;
diff --git a/tools/perf/ui/tui/helpline.c b/tools/perf/ui/tui/helpline.c
index 1793c98653a5..5f188f678c55 100644
--- a/tools/perf/ui/tui/helpline.c
+++ b/tools/perf/ui/tui/helpline.c
@@ -4,6 +4,7 @@
 #include <string.h>
 #include <pthread.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
 
 #include "../../util/debug.h"
 #include "../helpline.h"
diff --git a/tools/perf/ui/tui/progress.c b/tools/perf/ui/tui/progress.c
index 5a24dd3ce4db..3d74af5a7ece 100644
--- a/tools/perf/ui/tui/progress.c
+++ b/tools/perf/ui/tui/progress.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/kernel.h>
-#include "../../util/cache.h"
 #include "../progress.h"
 #include "../libslang.h"
 #include "../ui.h"
diff --git a/tools/perf/ui/tui/setup.c b/tools/perf/ui/tui/setup.c
index 2881982b483c..56651a4f5aa0 100644
--- a/tools/perf/ui/tui/setup.c
+++ b/tools/perf/ui/tui/setup.c
@@ -1,4 +1,3 @@
-// SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
 #include <signal.h>
 #include <stdbool.h>
@@ -8,7 +7,6 @@
 #include <execinfo.h>
 #endif
 
-#include "../../util/cache.h"
 #include "../../util/debug.h"
 #include "../../util/util.h"
 #include "../../perf.h"
diff --git a/tools/perf/ui/tui/util.c b/tools/perf/ui/tui/util.c
index 1163df8b6f06..087d9ab054c8 100644
--- a/tools/perf/ui/tui/util.c
+++ b/tools/perf/ui/tui/util.c
@@ -5,7 +5,6 @@
 #include <stdlib.h>
 #include <sys/ttydefaults.h>
 
-#include "../../util/cache.h"
 #include "../../util/debug.h"
 #include "../browser.h"
 #include "../keysyms.h"
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 67a7513077d0..eb3c50de831d 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -19,7 +19,6 @@
 #include "build-id.h"
 #include "color.h"
 #include "config.h"
-#include "cache.h"
 #include "dso.h"
 #include "map.h"
 #include "symbol.h"
diff --git a/tools/perf/util/color.c b/tools/perf/util/color.c
index 39b8c4ec4e2e..bffbdd216a6a 100644
--- a/tools/perf/util/color.c
+++ b/tools/perf/util/color.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/kernel.h>
-#include "cache.h"
+#include <subcmd/pager.h>
 #include <stdlib.h>
 #include <stdio.h>
+#include <string.h>
 #include "color.h"
 #include <math.h>
 #include <unistd.h>
diff --git a/tools/perf/util/color_config.c b/tools/perf/util/color_config.c
index 817dc56e7e95..dc09ba7cb31e 100644
--- a/tools/perf/util/color_config.c
+++ b/tools/perf/util/color_config.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/kernel.h>
-#include "cache.h"
+#include <subcmd/pager.h>
+#include <string.h>
 #include "config.h"
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index 143d379d4608..a1b59bd35519 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -13,7 +13,6 @@
 #ifdef HAVE_BACKTRACE_SUPPORT
 #include <execinfo.h>
 #endif
-#include "cache.h"
 #include "color.h"
 #include "event.h"
 #include "debug.h"
@@ -21,6 +20,7 @@
 #include "util.h"
 #include "target.h"
 #include "ui/helpline.h"
+#include "ui/ui.h"
 
 #include <linux/ctype.h>
 
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 3bfdf2b7a96a..f8ccfd6be0ee 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -14,9 +14,9 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <linux/compiler.h>
+#include <linux/string.h>
 #include <linux/zalloc.h>
 
-#include "../cache.h"
 #include "../auxtrace.h"
 
 #include "intel-pt-insn-decoder.h"
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 523af1bd82e6..5ec21d21113c 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -13,13 +13,13 @@
 #include "build-id.h"
 #include "evlist.h"
 #include "evsel.h"
+#include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
 #include "parse-events.h"
 #include <subcmd/exec-cmd.h>
 #include "string2.h"
 #include "strlist.h"
 #include "symbol.h"
-#include "cache.h"
 #include "header.h"
 #include "bpf-loader.h"
 #include "debug.h"
diff --git a/tools/perf/util/path.c b/tools/perf/util/path.c
index ca56ba2dd3da..caed0336429f 100644
--- a/tools/perf/util/path.c
+++ b/tools/perf/util/path.c
@@ -11,11 +11,12 @@
  *
  * which is what it's designed for.
  */
-#include "cache.h"
 #include "path.h"
+#include "cache.h"
 #include <linux/kernel.h>
 #include <limits.h>
 #include <stdio.h>
+#include <string.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <dirent.h>
diff --git a/tools/perf/util/path.h b/tools/perf/util/path.h
index f014f905df50..083429b7efa3 100644
--- a/tools/perf/util/path.h
+++ b/tools/perf/util/path.h
@@ -2,6 +2,9 @@
 #ifndef _PERF_PATH_H
 #define _PERF_PATH_H
 
+#include <stddef.h>
+#include <stdbool.h>
+
 struct dirent;
 
 int path__join(char *bf, size_t size, const char *path1, const char *path2);
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 9807be6f09bb..6b3448f6eb94 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -3,6 +3,7 @@
 #include <linux/compiler.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
+#include <subcmd/pager.h>
 #include <sys/types.h>
 #include <errno.h>
 #include <fcntl.h>
@@ -22,8 +23,8 @@
 #include "cpumap.h"
 #include "header.h"
 #include "pmu-events/pmu-events.h"
-#include "cache.h"
 #include "string2.h"
+#include "strbuf.h"
 
 struct perf_pmu_format {
 	char *name;
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index e90faa6bb5aa..b8e0967c5c21 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -26,7 +26,6 @@
 #include "strfilter.h"
 #include "debug.h"
 #include "dso.h"
-#include "cache.h"
 #include "color.h"
 #include "map.h"
 #include "map_groups.h"
@@ -38,7 +37,9 @@
 #include "probe-file.h"
 #include "session.h"
 #include "string2.h"
+#include "strbuf.h"
 
+#include <subcmd/pager.h>
 #include <linux/ctype.h>
 #include <linux/zalloc.h>
 
diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index adc949e8314f..d13db55a2feb 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -17,9 +17,9 @@
 #include "strfilter.h"
 #include "debug.h"
 #include "dso.h"
-#include "cache.h"
 #include "color.h"
 #include "symbol.h"
+#include "strbuf.h"
 #include <api/fs/tracing_path.h>
 #include "probe-event.h"
 #include "probe-file.h"
-- 
2.21.0

