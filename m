Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2814C742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 11:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6225D2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 11:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="NI8GEERx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfGMLBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 07:01:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44107 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfGMLBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 07:01:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6DB147B3838699
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Jul 2019 04:01:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6DB147B3838699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563015664;
        bh=tV298H1foBAveVgX93CRI24y9csDvfDaSapIqtk9hxY=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=NI8GEERxid+uSfYSbCtVSMXTQc59Ni46J66m5EempXS2cOlLDuWzPeub+CE/oq07M
         e1POCoO+hWydOZ5j/PC6JN1rjn/bWPGm/H//Ndnoma6kK9HpcZ5R3y6EqFlj+N1yD+
         ZqaTbAYBKUUGNe7O6XrzGT+o/IhhD5a+eTLJNR/FQKV/3P75l5TZJw+41h2roYhrh1
         2oAilbEDddwMY1W09fSqEStWLTnSKXUWIpHWN89Wy+q0UUO1mpM3MXQcvIboy/Yuws
         qWgeIP2HaSnl5JSWMpges5Z1G2X3qtiJtcn64bUNcvOH8Sqo1i6q6n3oa2jQ+eJ4nA
         GKyi+DDWtiTkw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6DB13Sp3838696;
        Sat, 13 Jul 2019 04:01:03 -0700
Date:   Sat, 13 Jul 2019 04:01:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-natazosyn9rwjka25tvcnyi0@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, namhyung@kernel.org,
        hpa@zytor.com, acme@redhat.com, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, jolsa@kernel.org
Reply-To: adrian.hunter@intel.com, jolsa@kernel.org, acme@redhat.com,
          hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
          namhyung@kernel.org, tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools lib: Adopt zalloc()/zfree() from tools/perf
Git-Commit-ID: 7f7c536f23e6afaa5d5d4b0e0958b0be8922491f
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

Commit-ID:  7f7c536f23e6afaa5d5d4b0e0958b0be8922491f
Gitweb:     https://git.kernel.org/tip/7f7c536f23e6afaa5d5d4b0e0958b0be8922491f
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 4 Jul 2019 11:32:27 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 9 Jul 2019 10:13:26 -0300

tools lib: Adopt zalloc()/zfree() from tools/perf

Eroding a bit more the tools/perf/util/util.h hodpodge header.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-natazosyn9rwjka25tvcnyi0@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/zalloc.h                        | 12 ++++++++++++
 tools/lib/zalloc.c                                  | 15 +++++++++++++++
 tools/perf/MANIFEST                                 |  1 +
 tools/perf/arch/arm/annotate/instructions.c         |  1 +
 tools/perf/arch/arm/util/auxtrace.c                 |  1 +
 tools/perf/arch/arm/util/cs-etm.c                   |  1 +
 tools/perf/arch/arm64/util/arm-spe.c                |  1 +
 tools/perf/arch/common.c                            |  2 +-
 tools/perf/arch/powerpc/util/perf_regs.c            |  2 +-
 tools/perf/arch/s390/util/auxtrace.c                |  1 +
 tools/perf/arch/s390/util/header.c                  |  2 +-
 tools/perf/arch/x86/util/event.c                    |  2 +-
 tools/perf/arch/x86/util/intel-bts.c                |  2 +-
 tools/perf/arch/x86/util/intel-pt.c                 |  2 +-
 tools/perf/arch/x86/util/perf_regs.c                |  2 +-
 tools/perf/bench/mem-functions.c                    |  2 +-
 tools/perf/bench/numa.c                             |  2 +-
 tools/perf/builtin-annotate.c                       |  2 +-
 tools/perf/builtin-bench.c                          |  2 +-
 tools/perf/builtin-c2c.c                            |  2 +-
 tools/perf/builtin-diff.c                           |  2 +-
 tools/perf/builtin-help.c                           |  1 +
 tools/perf/builtin-kmem.c                           |  2 +-
 tools/perf/builtin-kvm.c                            |  2 +-
 tools/perf/builtin-lock.c                           |  2 +-
 tools/perf/builtin-probe.c                          |  2 +-
 tools/perf/builtin-report.c                         |  2 +-
 tools/perf/builtin-sched.c                          |  2 +-
 tools/perf/builtin-script.c                         |  2 +-
 tools/perf/builtin-stat.c                           |  2 +-
 tools/perf/builtin-timechart.c                      |  4 +---
 tools/perf/builtin-trace.c                          |  1 +
 tools/perf/perf.c                                   |  2 +-
 tools/perf/tests/switch-tracking.c                  |  1 +
 tools/perf/ui/browser.c                             |  2 +-
 tools/perf/ui/browsers/annotate.c                   |  2 +-
 tools/perf/ui/browsers/hists.c                      |  2 +-
 tools/perf/ui/gtk/util.c                            |  3 +--
 tools/perf/ui/stdio/hist.c                          |  2 +-
 tools/perf/util/Build                               |  5 +++++
 tools/perf/util/arm-spe.c                           |  2 +-
 tools/perf/util/auxtrace.c                          |  2 +-
 tools/perf/util/bpf-loader.c                        |  1 +
 tools/perf/util/build-id.c                          |  1 +
 tools/perf/util/call-path.c                         |  3 ++-
 tools/perf/util/callchain.c                         |  2 +-
 tools/perf/util/cgroup.c                            |  2 +-
 tools/perf/util/comm.c                              |  2 +-
 tools/perf/util/config.c                            |  3 +--
 tools/perf/util/counts.c                            |  2 +-
 tools/perf/util/cpumap.c                            |  2 +-
 tools/perf/util/cputopo.c                           |  2 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c     |  1 +
 tools/perf/util/cs-etm.c                            |  1 +
 tools/perf/util/data-convert-bt.c                   |  2 +-
 tools/perf/util/data.c                              |  1 +
 tools/perf/util/db-export.c                         |  2 +-
 tools/perf/util/dso.c                               |  3 ++-
 tools/perf/util/env.c                               |  2 +-
 tools/perf/util/event.c                             |  1 +
 tools/perf/util/evlist.c                            |  2 +-
 tools/perf/util/evsel.c                             |  2 +-
 tools/perf/util/header.c                            |  2 +-
 tools/perf/util/help-unknown-cmd.c                  |  2 ++
 tools/perf/util/hist.c                              |  2 +-
 tools/perf/util/intel-bts.c                         |  2 +-
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c |  2 +-
 tools/perf/util/intel-pt.c                          |  2 +-
 tools/perf/util/llvm-utils.c                        |  1 +
 tools/perf/util/machine.c                           |  2 +-
 tools/perf/util/map.c                               |  2 +-
 tools/perf/util/mem2node.c                          |  2 +-
 tools/perf/util/mmap.c                              |  1 +
 tools/perf/util/namespaces.c                        |  2 +-
 tools/perf/util/parse-events.c                      |  1 +
 tools/perf/util/pmu.c                               |  2 +-
 tools/perf/util/probe-event.c                       |  2 +-
 tools/perf/util/probe-file.c                        |  2 +-
 tools/perf/util/probe-finder.c                      |  2 +-
 tools/perf/util/pstack.c                            |  2 +-
 tools/perf/util/python-ext-sources                  |  1 +
 tools/perf/util/s390-cpumsf.c                       |  2 +-
 tools/perf/util/session.c                           |  2 +-
 tools/perf/util/srcline.c                           |  2 +-
 tools/perf/util/stat.c                              |  1 +
 tools/perf/util/strbuf.c                            |  2 +-
 tools/perf/util/strfilter.c                         |  3 ++-
 tools/perf/util/strlist.c                           |  2 +-
 tools/perf/util/svghelper.c                         |  2 +-
 tools/perf/util/symbol-elf.c                        |  1 +
 tools/perf/util/symbol-minimal.c                    |  2 +-
 tools/perf/util/symbol.c                            |  1 +
 tools/perf/util/syscalltbl.c                        |  2 +-
 tools/perf/util/thread-stack.c                      |  2 +-
 tools/perf/util/thread.c                            |  2 +-
 tools/perf/util/thread_map.c                        |  2 +-
 tools/perf/util/trace-event-info.c                  |  1 +
 tools/perf/util/trace-event-scripting.c             |  2 +-
 tools/perf/util/unwind-libdw.c                      |  1 +
 tools/perf/util/util.h                              |  9 ---------
 tools/perf/util/values.c                            |  2 +-
 tools/perf/util/vdso.c                              |  1 +
 tools/perf/util/xyarray.c                           |  2 +-
 103 files changed, 135 insertions(+), 86 deletions(-)

diff --git a/tools/include/linux/zalloc.h b/tools/include/linux/zalloc.h
new file mode 100644
index 000000000000..81099c84043f
--- /dev/null
+++ b/tools/include/linux/zalloc.h
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: LGPL-2.1
+#ifndef __TOOLS_LINUX_ZALLOC_H
+#define __TOOLS_LINUX_ZALLOC_H
+
+#include <stddef.h>
+
+void *zalloc(size_t size);
+void __zfree(void **ptr);
+
+#define zfree(ptr) __zfree((void **)(ptr))
+
+#endif // __TOOLS_LINUX_ZALLOC_H
diff --git a/tools/lib/zalloc.c b/tools/lib/zalloc.c
new file mode 100644
index 000000000000..9c856d59f56e
--- /dev/null
+++ b/tools/lib/zalloc.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: LGPL-2.1
+
+#include <stdlib.h>
+#include <linux/zalloc.h>
+
+void *zalloc(size_t size)
+{
+	return calloc(1, size);
+}
+
+void __zfree(void **ptr)
+{
+	free(*ptr);
+	*ptr = NULL;
+}
diff --git a/tools/perf/MANIFEST b/tools/perf/MANIFEST
index 6a5de44b2de9..70f1ff4e2eb4 100644
--- a/tools/perf/MANIFEST
+++ b/tools/perf/MANIFEST
@@ -18,3 +18,4 @@ tools/lib/find_bit.c
 tools/lib/bitmap.c
 tools/lib/str_error_r.c
 tools/lib/vsprintf.c
+tools/lib/zalloc.c
diff --git a/tools/perf/arch/arm/annotate/instructions.c b/tools/perf/arch/arm/annotate/instructions.c
index f64516d5b23e..c7d1a69b894f 100644
--- a/tools/perf/arch/arm/annotate/instructions.c
+++ b/tools/perf/arch/arm/annotate/instructions.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/compiler.h>
+#include <linux/zalloc.h>
 #include <sys/types.h>
 #include <regex.h>
 
diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
index 1ce6bdbda561..02014740a1aa 100644
--- a/tools/perf/arch/arm/util/auxtrace.c
+++ b/tools/perf/arch/arm/util/auxtrace.c
@@ -6,6 +6,7 @@
 
 #include <stdbool.h>
 #include <linux/coresight-pmu.h>
+#include <linux/zalloc.h>
 
 #include "../../util/auxtrace.h"
 #include "../../util/evlist.h"
diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 2b83cc8e4796..4208974c24f8 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/log2.h>
 #include <linux/types.h>
+#include <linux/zalloc.h>
 
 #include "cs-etm.h"
 #include "../../perf.h"
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 5ccfce87e693..2c009aa74633 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -8,6 +8,7 @@
 #include <linux/types.h>
 #include <linux/bitops.h>
 #include <linux/log2.h>
+#include <linux/zalloc.h>
 #include <time.h>
 
 #include "../../util/cpumap.h"
diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
index 1bc329412bcf..1a9e22f78c22 100644
--- a/tools/perf/arch/common.c
+++ b/tools/perf/arch/common.c
@@ -3,8 +3,8 @@
 #include <stdlib.h>
 #include "common.h"
 #include "../util/env.h"
-#include "../util/util.h"
 #include "../util/debug.h"
+#include <linux/zalloc.h>
 
 const char *const arc_triplets[] = {
 	"arc-linux-",
diff --git a/tools/perf/arch/powerpc/util/perf_regs.c b/tools/perf/arch/powerpc/util/perf_regs.c
index 64f65c296d3e..f14102b85509 100644
--- a/tools/perf/arch/powerpc/util/perf_regs.c
+++ b/tools/perf/arch/powerpc/util/perf_regs.c
@@ -2,9 +2,9 @@
 #include <errno.h>
 #include <string.h>
 #include <regex.h>
+#include <linux/zalloc.h>
 
 #include "../../perf.h"
-#include "../../util/util.h"
 #include "../../util/perf_regs.h"
 #include "../../util/debug.h"
 
diff --git a/tools/perf/arch/s390/util/auxtrace.c b/tools/perf/arch/s390/util/auxtrace.c
index 44c857388897..0fe1be93f375 100644
--- a/tools/perf/arch/s390/util/auxtrace.c
+++ b/tools/perf/arch/s390/util/auxtrace.c
@@ -3,6 +3,7 @@
 #include <linux/types.h>
 #include <linux/bitops.h>
 #include <linux/log2.h>
+#include <linux/zalloc.h>
 
 #include "../../util/evlist.h"
 #include "../../util/auxtrace.h"
diff --git a/tools/perf/arch/s390/util/header.c b/tools/perf/arch/s390/util/header.c
index 165c51435e72..8b0b018d896a 100644
--- a/tools/perf/arch/s390/util/header.c
+++ b/tools/perf/arch/s390/util/header.c
@@ -13,9 +13,9 @@
 #include <string.h>
 #include <linux/ctype.h>
 #include <linux/kernel.h>
+#include <linux/zalloc.h>
 
 #include "../../util/header.h"
-#include "../../util/util.h"
 
 #define SYSINFO_MANU	"Manufacturer:"
 #define SYSINFO_TYPE	"Type:"
diff --git a/tools/perf/arch/x86/util/event.c b/tools/perf/arch/x86/util/event.c
index 675a0213044d..a3a0b6884779 100644
--- a/tools/perf/arch/x86/util/event.c
+++ b/tools/perf/arch/x86/util/event.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/types.h>
 #include <linux/string.h>
+#include <linux/zalloc.h>
 
 #include "../../util/machine.h"
 #include "../../util/tool.h"
 #include "../../util/map.h"
-#include "../../util/util.h"
 #include "../../util/debug.h"
 
 #if defined(__x86_64__)
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index e6d4d9591c79..ec5c1bb84095 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -9,12 +9,12 @@
 #include <linux/types.h>
 #include <linux/bitops.h>
 #include <linux/log2.h>
+#include <linux/zalloc.h>
 
 #include "../../util/cpumap.h"
 #include "../../util/evsel.h"
 #include "../../util/evlist.h"
 #include "../../util/session.h"
-#include "../../util/util.h"
 #include "../../util/pmu.h"
 #include "../../util/debug.h"
 #include "../../util/tsc.h"
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 9804098dcefb..609088c01e3a 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -10,6 +10,7 @@
 #include <linux/types.h>
 #include <linux/bitops.h>
 #include <linux/log2.h>
+#include <linux/zalloc.h>
 #include <cpuid.h>
 
 #include "../../perf.h"
@@ -25,7 +26,6 @@
 #include "../../util/auxtrace.h"
 #include "../../util/tsc.h"
 #include "../../util/intel-pt.h"
-#include "../../util/util.h"
 
 #define KiB(x) ((x) * 1024)
 #define MiB(x) ((x) * 1024 * 1024)
diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
index 3666c0076df9..0d7b77ff0ae6 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -2,9 +2,9 @@
 #include <errno.h>
 #include <string.h>
 #include <regex.h>
+#include <linux/zalloc.h>
 
 #include "../../perf.h"
-#include "../../util/util.h"
 #include "../../util/perf_regs.h"
 #include "../../util/debug.h"
 
diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
index 0251dd348124..64dc994c72ea 100644
--- a/tools/perf/bench/mem-functions.c
+++ b/tools/perf/bench/mem-functions.c
@@ -9,7 +9,6 @@
 
 #include "debug.h"
 #include "../perf.h"
-#include "../util/util.h"
 #include <subcmd/parse-options.h>
 #include "../util/header.h"
 #include "../util/cloexec.h"
@@ -24,6 +23,7 @@
 #include <sys/time.h>
 #include <errno.h>
 #include <linux/time64.h>
+#include <linux/zalloc.h>
 
 #define K 1024
 
diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index a7784554a80d..a640ca7aaada 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -11,7 +11,6 @@
 
 #include "../perf.h"
 #include "../builtin.h"
-#include "../util/util.h"
 #include <subcmd/parse-options.h>
 #include "../util/cloexec.h"
 
@@ -35,6 +34,7 @@
 #include <linux/kernel.h>
 #include <linux/time64.h>
 #include <linux/numa.h>
+#include <linux/zalloc.h>
 
 #include <numa.h>
 #include <numaif.h>
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 77deb3a40596..e0aa14faf2b5 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -8,11 +8,11 @@
  */
 #include "builtin.h"
 
-#include "util/util.h"
 #include "util/color.h"
 #include <linux/list.h>
 #include "util/cache.h"
 #include <linux/rbtree.h>
+#include <linux/zalloc.h>
 #include "util/symbol.h"
 
 #include "perf.h"
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index 334c77ffc1d9..b8e7c38ef221 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -17,7 +17,6 @@
  *  epoll ... Event poll performance
  */
 #include "perf.h"
-#include "util/util.h"
 #include <subcmd/parse-options.h>
 #include "builtin.h"
 #include "bench/bench.h"
@@ -26,6 +25,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/prctl.h>
+#include <linux/zalloc.h>
 
 typedef int (*bench_fn_t)(int argc, const char **argv);
 
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 9e6cc868bdb4..e3776f5c2e01 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -15,9 +15,9 @@
 #include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/stringify.h>
+#include <linux/zalloc.h>
 #include <asm/bug.h>
 #include <sys/param.h>
-#include "util.h"
 #include "debug.h"
 #include "builtin.h"
 #include <subcmd/parse-options.h>
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index f924b46910b5..f6f5dd15bea7 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -16,12 +16,12 @@
 #include "util/tool.h"
 #include "util/sort.h"
 #include "util/symbol.h"
-#include "util/util.h"
 #include "util/data.h"
 #include "util/config.h"
 #include "util/time-utils.h"
 #include "util/annotate.h"
 #include "util/map.h"
+#include <linux/zalloc.h>
 
 #include <errno.h>
 #include <inttypes.h>
diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
index 6a1cab547043..a83af92fb0d1 100644
--- a/tools/perf/builtin-help.c
+++ b/tools/perf/builtin-help.c
@@ -14,6 +14,7 @@
 #include <subcmd/help.h>
 #include "util/debug.h"
 #include <linux/kernel.h>
+#include <linux/zalloc.h>
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 9bd3829de76d..9e5e60898083 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -4,7 +4,6 @@
 
 #include "util/evlist.h"
 #include "util/evsel.h"
-#include "util/util.h"
 #include "util/config.h"
 #include "util/map.h"
 #include "util/symbol.h"
@@ -26,6 +25,7 @@
 #include <linux/kernel.h>
 #include <linux/rbtree.h>
 #include <linux/string.h>
+#include <linux/zalloc.h>
 #include <errno.h>
 #include <inttypes.h>
 #include <locale.h>
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index dbb6f737a3e2..b33c83489120 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -5,7 +5,6 @@
 #include "util/evsel.h"
 #include "util/evlist.h"
 #include "util/term.h"
-#include "util/util.h"
 #include "util/cache.h"
 #include "util/symbol.h"
 #include "util/thread.h"
@@ -32,6 +31,7 @@
 
 #include <linux/kernel.h>
 #include <linux/time64.h>
+#include <linux/zalloc.h>
 #include <errno.h>
 #include <inttypes.h>
 #include <poll.h>
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index b9810a8d350a..c0be44e65e9d 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -6,7 +6,6 @@
 
 #include "util/evlist.h"
 #include "util/evsel.h"
-#include "util/util.h"
 #include "util/cache.h"
 #include "util/symbol.h"
 #include "util/thread.h"
@@ -30,6 +29,7 @@
 #include <linux/list.h>
 #include <linux/hash.h>
 #include <linux/kernel.h>
+#include <linux/zalloc.h>
 
 static struct perf_session *session;
 
diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index 8bb124e55c6d..6418782951a4 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -19,7 +19,6 @@
 #include "perf.h"
 #include "builtin.h"
 #include "namespaces.h"
-#include "util/util.h"
 #include "util/strlist.h"
 #include "util/strfilter.h"
 #include "util/symbol.h"
@@ -28,6 +27,7 @@
 #include "util/probe-finder.h"
 #include "util/probe-event.h"
 #include "util/probe-file.h"
+#include <linux/zalloc.h>
 
 #define DEFAULT_VAR_FILTER "!__k???tab_* & !__crc_*"
 #define DEFAULT_FUNC_FILTER "!_*"
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 93d4b12e248e..abf0b9b8f566 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -8,7 +8,6 @@
  */
 #include "builtin.h"
 
-#include "util/util.h"
 #include "util/config.h"
 
 #include "util/annotate.h"
@@ -16,6 +15,7 @@
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include <linux/err.h>
+#include <linux/zalloc.h>
 #include "util/map.h"
 #include "util/symbol.h"
 #include "util/callchain.h"
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 1519989961ff..56d1907b1215 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2,7 +2,6 @@
 #include "builtin.h"
 #include "perf.h"
 
-#include "util/util.h"
 #include "util/evlist.h"
 #include "util/cache.h"
 #include "util/evsel.h"
@@ -26,6 +25,7 @@
 
 #include <linux/kernel.h>
 #include <linux/log2.h>
+#include <linux/zalloc.h>
 #include <sys/prctl.h>
 #include <sys/resource.h>
 #include <inttypes.h>
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 2f6232f1bfdc..b3536820f9a8 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -14,7 +14,6 @@
 #include "util/symbol.h"
 #include "util/thread.h"
 #include "util/trace-event.h"
-#include "util/util.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/sort.h"
@@ -34,6 +33,7 @@
 #include <linux/kernel.h>
 #include <linux/stringify.h>
 #include <linux/time64.h>
+#include <linux/zalloc.h>
 #include <sys/utsname.h>
 #include "asm/bug.h"
 #include "util/mem-events.h"
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index b81f7b197d24..c72f4a0831a8 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -43,7 +43,6 @@
 #include "perf.h"
 #include "builtin.h"
 #include "util/cgroup.h"
-#include "util/util.h"
 #include <subcmd/parse-options.h>
 #include "util/parse-events.h"
 #include "util/pmu.h"
@@ -67,6 +66,7 @@
 #include "asm/bug.h"
 
 #include <linux/time64.h>
+#include <linux/zalloc.h>
 #include <api/fs/fs.h>
 #include <errno.h>
 #include <signal.h>
diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 145a19668114..4bde3fa245d1 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -13,9 +13,6 @@
 #include <traceevent/event-parse.h>
 
 #include "builtin.h"
-
-#include "util/util.h"
-
 #include "util/color.h"
 #include <linux/list.h>
 #include "util/cache.h"
@@ -24,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/rbtree.h>
 #include <linux/time64.h>
+#include <linux/zalloc.h>
 #include "util/symbol.h"
 #include "util/thread.h"
 #include "util/callchain.h"
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e3fc9062f136..1aa2ed096f65 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -61,6 +61,7 @@
 #include <linux/random.h>
 #include <linux/stringify.h>
 #include <linux/time64.h>
+#include <linux/zalloc.h>
 #include <fcntl.h>
 #include <sys/sysmacros.h>
 
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 2123b3cc4dcf..97e2628ea5dd 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -18,7 +18,6 @@
 #include "util/bpf-loader.h"
 #include "util/debug.h"
 #include "util/event.h"
-#include "util/util.h"
 #include <api/fs/fs.h>
 #include <api/fs/tracing_path.h>
 #include <errno.h>
@@ -30,6 +29,7 @@
 #include <sys/stat.h>
 #include <unistd.h>
 #include <linux/kernel.h>
+#include <linux/zalloc.h>
 
 const char perf_usage_string[] =
 	"perf [--version] [--help] [OPTIONS] COMMAND [ARGS]";
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 9b5be51e5e7b..744409dce65f 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -4,6 +4,7 @@
 #include <errno.h>
 #include <time.h>
 #include <stdlib.h>
+#include <linux/zalloc.h>
 
 #include "parse-events.h"
 #include "evlist.h"
diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index 55ff05a46e0b..f80c51d53565 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "../util.h"
 #include "../string2.h"
 #include "../config.h"
 #include "../../perf.h"
@@ -17,6 +16,7 @@
 #include "keysyms.h"
 #include "../color.h"
 #include <linux/ctype.h>
+#include <linux/zalloc.h>
 
 static int ui_browser__percent_color(struct ui_browser *browser,
 				     double percent, bool current)
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index b0d089a95dac..e67880bf1efe 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "../../util/util.h"
 #include "../browser.h"
 #include "../helpline.h"
 #include "../ui.h"
@@ -15,6 +14,7 @@
 #include <pthread.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
+#include <linux/zalloc.h>
 #include <sys/ttydefaults.h>
 #include <asm/bug.h>
 
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 33e67aa91347..85581cfb9112 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -9,6 +9,7 @@
 #include <linux/string.h>
 #include <sys/ttydefaults.h>
 #include <linux/time64.h>
+#include <linux/zalloc.h>
 
 #include "../../util/callchain.h"
 #include "../../util/evsel.h"
@@ -18,7 +19,6 @@
 #include "../../util/symbol.h"
 #include "../../util/pstack.h"
 #include "../../util/sort.h"
-#include "../../util/util.h"
 #include "../../util/top.h"
 #include "../../util/thread.h"
 #include "../../arch/common.h"
diff --git a/tools/perf/ui/gtk/util.c b/tools/perf/ui/gtk/util.c
index 7250d8101c8f..c28bdb7517ac 100644
--- a/tools/perf/ui/gtk/util.c
+++ b/tools/perf/ui/gtk/util.c
@@ -1,11 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "../util.h"
-#include "../../util/util.h"
 #include "../../util/debug.h"
 #include "gtk.h"
 
 #include <string.h>
-
+#include <linux/zalloc.h>
 
 struct perf_gtk_context *pgctx;
 
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 89393c79d870..ee7ea6deed21 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -3,7 +3,6 @@
 #include <linux/string.h>
 
 #include "../../util/callchain.h"
-#include "../../util/util.h"
 #include "../../util/hist.h"
 #include "../../util/map.h"
 #include "../../util/map_groups.h"
@@ -14,6 +13,7 @@
 #include "../../util/string2.h"
 #include "../../util/thread.h"
 #include <linux/ctype.h>
+#include <linux/zalloc.h>
 
 static size_t callchain__fprintf_left_margin(FILE *fp, int left_margin)
 {
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index d3408a463060..d7e3b008a613 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -25,6 +25,7 @@ perf-y += rbtree.o
 perf-y += libstring.o
 perf-y += bitmap.o
 perf-y += hweight.o
+perf-y += zalloc.o
 perf-y += smt.o
 perf-y += strbuf.o
 perf-y += string.o
@@ -241,3 +242,7 @@ $(OUTPUT)util/hweight.o: ../lib/hweight.c FORCE
 $(OUTPUT)util/vsprintf.o: ../lib/vsprintf.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
+
+$(OUTPUT)util/zalloc.o: ../lib/zalloc.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 6067267cc76c..a314e5b26e9d 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <linux/bitops.h>
 #include <linux/log2.h>
+#include <linux/zalloc.h>
 
 #include "cpumap.h"
 #include "color.h"
@@ -19,7 +20,6 @@
 #include "evlist.h"
 #include "machine.h"
 #include "session.h"
-#include "util.h"
 #include "thread.h"
 #include "debug.h"
 #include "auxtrace.h"
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index bc215fe0b4b4..0812a11a0dbe 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -24,9 +24,9 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <linux/list.h>
+#include <linux/zalloc.h>
 
 #include "../perf.h"
-#include "util.h"
 #include "evlist.h"
 #include "dso.h"
 #include "map.h"
diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 251d9ea6252f..93d0f239ad4f 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -12,6 +12,7 @@
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
+#include <linux/zalloc.h>
 #include <errno.h>
 #include "perf.h"
 #include "debug.h"
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 89c6913dfc25..f1abfab7aa8c 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -30,6 +30,7 @@
 #include "strlist.h"
 
 #include <linux/ctype.h>
+#include <linux/zalloc.h>
 
 static bool no_buildid_cache;
 
diff --git a/tools/perf/util/call-path.c b/tools/perf/util/call-path.c
index c5b90300304d..e8a80c41cba3 100644
--- a/tools/perf/util/call-path.c
+++ b/tools/perf/util/call-path.c
@@ -6,8 +6,9 @@
 
 #include <linux/rbtree.h>
 #include <linux/list.h>
+#include <linux/zalloc.h>
+#include <stdlib.h>
 
-#include "util.h"
 #include "call-path.h"
 
 static void call_path__init(struct call_path *cp, struct call_path *parent,
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index abb608b09269..b4af25dca5eb 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -16,11 +16,11 @@
 #include <stdbool.h>
 #include <errno.h>
 #include <math.h>
+#include <linux/zalloc.h>
 
 #include "asm/bug.h"
 
 #include "hist.h"
-#include "util.h"
 #include "sort.h"
 #include "machine.h"
 #include "map.h"
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index ccd02634a616..f505d78f059b 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "util.h"
 #include "../perf.h"
 #include <subcmd/parse-options.h>
 #include "evsel.h"
 #include "cgroup.h"
 #include "evlist.h"
 #include <linux/stringify.h>
+#include <linux/zalloc.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
index 1066de92af12..afb8d4fd2644 100644
--- a/tools/perf/util/comm.c
+++ b/tools/perf/util/comm.c
@@ -1,12 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "comm.h"
-#include "util.h"
 #include <errno.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
 #include <linux/refcount.h>
 #include <linux/rbtree.h>
+#include <linux/zalloc.h>
 #include "rwsem.h"
 
 struct comm_str {
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 752cce853e51..042ffbc8c53f 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -11,7 +11,6 @@
  */
 #include <errno.h>
 #include <sys/param.h>
-#include "util.h"
 #include "cache.h"
 #include "callchain.h"
 #include <subcmd/exec-cmd.h>
@@ -23,7 +22,7 @@
 #include <sys/stat.h>
 #include <unistd.h>
 #include <linux/string.h>
-
+#include <linux/zalloc.h>
 #include <linux/ctype.h>
 
 #define MAXNAME (256)
diff --git a/tools/perf/util/counts.c b/tools/perf/util/counts.c
index 03032b410c29..88be9c4365e0 100644
--- a/tools/perf/util/counts.c
+++ b/tools/perf/util/counts.c
@@ -3,7 +3,7 @@
 #include <stdlib.h>
 #include "evsel.h"
 #include "counts.h"
-#include "util.h"
+#include <linux/zalloc.h>
 
 struct perf_counts *perf_counts__new(int ncpus, int nthreads)
 {
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 0d8fbedf7bd5..3acfbe34ebaf 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "util.h"
 #include <api/fs/fs.h>
 #include "../perf.h"
 #include "cpumap.h"
@@ -11,6 +10,7 @@
 #include "asm/bug.h"
 
 #include <linux/ctype.h>
+#include <linux/zalloc.h>
 
 static int max_cpu_num;
 static int max_present_cpu_num;
diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index d3b2bd258b9e..fa1778aee5d6 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -4,10 +4,10 @@
 #include <inttypes.h>
 #include <stdlib.h>
 #include <api/fs/fs.h>
+#include <linux/zalloc.h>
 
 #include "cputopo.h"
 #include "cpumap.h"
-#include "util.h"
 #include "env.h"
 
 #define CORE_SIB_FMT \
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index bb45e23018ee..37d7c492b155 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -8,6 +8,7 @@
 
 #include <linux/err.h>
 #include <linux/list.h>
+#include <linux/zalloc.h>
 #include <stdlib.h>
 #include <opencsd/c_api/opencsd_c_api.h>
 #include <opencsd/etmv4/trc_pkt_types_etmv4.h>
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 0c7776b51045..d92516edbead 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/log2.h>
 #include <linux/types.h>
+#include <linux/zalloc.h>
 
 #include <opencsd/ocsd_if_types.h>
 #include <stdlib.h>
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index 7b06e7373b9e..1e93f2e94c40 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -10,6 +10,7 @@
 #include <inttypes.h>
 #include <linux/compiler.h>
 #include <linux/kernel.h>
+#include <linux/zalloc.h>
 #include <babeltrace/ctf-writer/writer.h>
 #include <babeltrace/ctf-writer/clock.h>
 #include <babeltrace/ctf-writer/stream.h>
@@ -22,7 +23,6 @@
 #include "asm/bug.h"
 #include "data-convert-bt.h"
 #include "session.h"
-#include "util.h"
 #include "debug.h"
 #include "tool.h"
 #include "evlist.h"
diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 6a64f713710d..df7e000e19ea 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/compiler.h>
 #include <linux/kernel.h>
+#include <linux/zalloc.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <errno.h>
diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 4cdd1f579156..3f2694ccfac7 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -14,11 +14,11 @@
 #include "symbol.h"
 #include "map.h"
 #include "event.h"
-#include "util.h"
 #include "thread-stack.h"
 #include "callchain.h"
 #include "call-path.h"
 #include "db-export.h"
+#include <linux/zalloc.h>
 
 struct deferred_export {
 	struct list_head node;
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index c7fde04400f7..ebacf07fc9ee 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -2,6 +2,7 @@
 #include <asm/bug.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
+#include <linux/zalloc.h>
 #include <sys/time.h>
 #include <sys/resource.h>
 #include <sys/types.h>
@@ -21,7 +22,7 @@
 #include "dso.h"
 #include "machine.h"
 #include "auxtrace.h"
-#include "util.h"
+#include "util.h" /* O_CLOEXEC for older systems */
 #include "debug.h"
 #include "string2.h"
 #include "vdso.h"
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 7d317d49d207..f92d992bd2db 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -2,7 +2,7 @@
 #include "cpumap.h"
 #include "env.h"
 #include <linux/ctype.h>
-#include "util.h"
+#include <linux/zalloc.h>
 #include "bpf-event.h"
 #include <errno.h>
 #include <sys/utsname.h>
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index e1d0c5ba1f92..7524bda5140b 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -11,6 +11,7 @@
 #include <uapi/linux/mman.h> /* To get things like MAP_HUGETLB even on older libc headers */
 #include <api/fs/fs.h>
 #include <linux/perf_event.h>
+#include <linux/zalloc.h>
 #include "event.h"
 #include "debug.h"
 #include "hist.h"
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index a474ede17cd6..b0364d923f76 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -5,7 +5,6 @@
  * Parts came from builtin-{top,stat,record}.c, see those files for further
  * copyright notes.
  */
-#include "util.h"
 #include <api/fs/fs.h>
 #include <errno.h>
 #include <inttypes.h>
@@ -33,6 +32,7 @@
 #include <linux/hash.h>
 #include <linux/log2.h>
 #include <linux/err.h>
+#include <linux/zalloc.h>
 
 #ifdef LACKS_SIGQUEUE_PROTOTYPE
 int sigqueue(pid_t pid, int sig, const union sigval value);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 7fb4ae82f34c..7ede674edf07 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -17,6 +17,7 @@
 #include <linux/perf_event.h>
 #include <linux/compiler.h>
 #include <linux/err.h>
+#include <linux/zalloc.h>
 #include <sys/ioctl.h>
 #include <sys/resource.h>
 #include <sys/types.h>
@@ -27,7 +28,6 @@
 #include "event.h"
 #include "evsel.h"
 #include "evlist.h"
-#include "util.h"
 #include "cpumap.h"
 #include "thread_map.h"
 #include "target.h"
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 6a93ff5d8db5..4e2efaa50c2f 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
 #include <inttypes.h>
-#include "util.h"
 #include "string2.h"
 #include <sys/param.h>
 #include <sys/types.h>
@@ -15,6 +14,7 @@
 #include <linux/bitops.h>
 #include <linux/string.h>
 #include <linux/stringify.h>
+#include <linux/zalloc.h>
 #include <sys/stat.h>
 #include <sys/utsname.h>
 #include <linux/time64.h>
diff --git a/tools/perf/util/help-unknown-cmd.c b/tools/perf/util/help-unknown-cmd.c
index 4f07a5ba5030..ab9e16123626 100644
--- a/tools/perf/util/help-unknown-cmd.c
+++ b/tools/perf/util/help-unknown-cmd.c
@@ -3,9 +3,11 @@
 #include "config.h"
 #include <poll.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <subcmd/help.h>
 #include "../builtin.h"
 #include "levenshtein.h"
+#include <linux/zalloc.h>
 
 static int autocorrect;
 
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 27cecb59f866..bb1d77331add 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "callchain.h"
-#include "util.h"
 #include "build-id.h"
 #include "hist.h"
 #include "map.h"
@@ -20,6 +19,7 @@
 #include <inttypes.h>
 #include <sys/param.h>
 #include <linux/time64.h>
+#include <linux/zalloc.h>
 
 static bool hists__filter_entry_by_dso(struct hists *hists,
 				       struct hist_entry *he);
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index e32dbffebb2f..5a21bcdb8ef7 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <linux/bitops.h>
 #include <linux/log2.h>
+#include <linux/zalloc.h>
 
 #include "cpumap.h"
 #include "color.h"
@@ -21,7 +22,6 @@
 #include "map.h"
 #include "symbol.h"
 #include "session.h"
-#include "util.h"
 #include "thread.h"
 #include "thread-stack.h"
 #include "debug.h"
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 4d14e78c5927..3bfdf2b7a96a 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -14,9 +14,9 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <linux/compiler.h>
+#include <linux/zalloc.h>
 
 #include "../cache.h"
-#include "../util.h"
 #include "../auxtrace.h"
 
 #include "intel-pt-insn-decoder.h"
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 470aaae9d930..c76a96f777fb 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -10,6 +10,7 @@
 #include <errno.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
+#include <linux/zalloc.h>
 
 #include "../perf.h"
 #include "session.h"
@@ -22,7 +23,6 @@
 #include "evsel.h"
 #include "map.h"
 #include "color.h"
-#include "util.h"
 #include "thread.h"
 #include "thread-stack.h"
 #include "symbol.h"
diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index 5b0b60f00275..b9fddb809d58 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -9,6 +9,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <linux/err.h>
+#include <linux/zalloc.h>
 #include "debug.h"
 #include "llvm-utils.h"
 #include "config.h"
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 147ed85ea2bc..f523da3009e4 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -15,7 +15,6 @@
 #include "strlist.h"
 #include "thread.h"
 #include "vdso.h"
-#include "util.h"
 #include <stdbool.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -28,6 +27,7 @@
 #include <linux/ctype.h>
 #include <symbol/kallsyms.h>
 #include <linux/mman.h>
+#include <linux/zalloc.h>
 
 static void __machine__remove_thread(struct machine *machine, struct thread *th, bool lock);
 
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 5f87975d2562..668410b1d426 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -12,10 +12,10 @@
 #include "thread.h"
 #include "vdso.h"
 #include "build-id.h"
-#include "util.h"
 #include "debug.h"
 #include "machine.h"
 #include <linux/string.h>
+#include <linux/zalloc.h>
 #include "srcline.h"
 #include "namespaces.h"
 #include "unwind.h"
diff --git a/tools/perf/util/mem2node.c b/tools/perf/util/mem2node.c
index c6fd81c02586..cacc2fc4dcbd 100644
--- a/tools/perf/util/mem2node.c
+++ b/tools/perf/util/mem2node.c
@@ -1,8 +1,8 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <linux/bitmap.h>
+#include <linux/zalloc.h>
 #include "mem2node.h"
-#include "util.h"
 
 struct phys_entry {
 	struct rb_node	rb_node;
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 768c632b0d82..9f0b6391af33 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -9,6 +9,7 @@
 #include <sys/mman.h>
 #include <inttypes.h>
 #include <asm/bug.h>
+#include <linux/zalloc.h>
 #ifdef HAVE_LIBNUMA_SUPPORT
 #include <numaif.h>
 #endif
diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index fda2fa1e8819..46d3a7754897 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -5,7 +5,6 @@
  */
 
 #include "namespaces.h"
-#include "util.h"
 #include "event.h"
 #include "get_current_dir_name.h"
 #include <sys/types.h>
@@ -18,6 +17,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <asm/bug.h>
+#include <linux/zalloc.h>
 
 struct namespaces *namespaces__new(struct namespaces_event *event)
 {
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index cf0b9b81c5aa..aa439853f20a 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/hw_breakpoint.h>
 #include <linux/err.h>
+#include <linux/zalloc.h>
 #include <dirent.h>
 #include <errno.h>
 #include <sys/ioctl.h>
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 55f4de6442e3..12b677902fbc 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2,6 +2,7 @@
 #include <linux/list.h>
 #include <linux/compiler.h>
 #include <linux/string.h>
+#include <linux/zalloc.h>
 #include <sys/types.h>
 #include <errno.h>
 #include <fcntl.h>
@@ -14,7 +15,6 @@
 #include <api/fs/fs.h>
 #include <locale.h>
 #include <regex.h>
-#include "util.h"
 #include "pmu.h"
 #include "parse-events.h"
 #include "cpumap.h"
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 6f24eaf6e504..80c0eca0f1ee 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -19,7 +19,6 @@
 #include <limits.h>
 #include <elf.h>
 
-#include "util.h"
 #include "event.h"
 #include "namespaces.h"
 #include "strlist.h"
@@ -40,6 +39,7 @@
 #include "string2.h"
 
 #include <linux/ctype.h>
+#include <linux/zalloc.h>
 
 #define PERFPROBE_GROUP "probe"
 
diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index 0ed1900454eb..c2998f90b23c 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -10,8 +10,8 @@
 #include <sys/types.h>
 #include <sys/uio.h>
 #include <unistd.h>
+#include <linux/zalloc.h>
 #include "namespaces.h"
-#include "util.h"
 #include "event.h"
 #include "strlist.h"
 #include "strfilter.h"
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 6b40cc691a2d..7d8c99734928 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -19,11 +19,11 @@
 #include <dwarf-regs.h>
 
 #include <linux/bitops.h>
+#include <linux/zalloc.h>
 #include "event.h"
 #include "dso.h"
 #include "debug.h"
 #include "intlist.h"
-#include "util.h"
 #include "strlist.h"
 #include "symbol.h"
 #include "probe-finder.h"
diff --git a/tools/perf/util/pstack.c b/tools/perf/util/pstack.c
index 797fe1ae2d2e..28de8a4c2ce8 100644
--- a/tools/perf/util/pstack.c
+++ b/tools/perf/util/pstack.c
@@ -5,10 +5,10 @@
  * (c) 2010 Arnaldo Carvalho de Melo <acme@redhat.com>
  */
 
-#include "util.h"
 #include "pstack.h"
 #include "debug.h"
 #include <linux/kernel.h>
+#include <linux/zalloc.h>
 #include <stdlib.h>
 
 struct pstack {
diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
index 2237bac9fadb..ceb8afdf9a89 100644
--- a/tools/perf/util/python-ext-sources
+++ b/tools/perf/util/python-ext-sources
@@ -18,6 +18,7 @@ util/namespaces.c
 ../lib/hweight.c
 ../lib/string.c
 ../lib/vsprintf.c
+../lib/zalloc.c
 util/thread_map.c
 util/util.c
 util/xyarray.c
diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index 10d36d9b7909..ea669702825d 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -146,6 +146,7 @@
 #include <linux/types.h>
 #include <linux/bitops.h>
 #include <linux/log2.h>
+#include <linux/zalloc.h>
 
 #include <sys/stat.h>
 #include <sys/types.h>
@@ -156,7 +157,6 @@
 #include "evlist.h"
 #include "machine.h"
 #include "session.h"
-#include "util.h"
 #include "thread.h"
 #include "debug.h"
 #include "auxtrace.h"
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index e3463df18493..d0fd6c614e68 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2,6 +2,7 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <linux/kernel.h>
+#include <linux/zalloc.h>
 #include <traceevent/event-parse.h>
 #include <api/fs/fs.h>
 
@@ -18,7 +19,6 @@
 #include "session.h"
 #include "tool.h"
 #include "sort.h"
-#include "util.h"
 #include "cpumap.h"
 #include "perf_regs.h"
 #include "asm/bug.h"
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index dcad75daf5e4..6ccf6f6d09df 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -6,9 +6,9 @@
 
 #include <linux/kernel.h>
 #include <linux/string.h>
+#include <linux/zalloc.h>
 
 #include "util/dso.h"
-#include "util/util.h"
 #include "util/debug.h"
 #include "util/callchain.h"
 #include "util/symbol_conf.h"
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index d91fe754b6d2..c967715c1d4c 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -6,6 +6,7 @@
 #include "evlist.h"
 #include "evsel.h"
 #include "thread_map.h"
+#include <linux/zalloc.h>
 
 void update_stats(struct stats *stats, u64 val)
 {
diff --git a/tools/perf/util/strbuf.c b/tools/perf/util/strbuf.c
index 54336df089df..2ce0dc887364 100644
--- a/tools/perf/util/strbuf.c
+++ b/tools/perf/util/strbuf.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "debug.h"
-#include "util.h"
 #include <linux/kernel.h>
+#include <linux/zalloc.h>
 #include <errno.h>
 #include <stdlib.h>
 
diff --git a/tools/perf/util/strfilter.c b/tools/perf/util/strfilter.c
index 90ea2b209cbb..78aa4c3b990d 100644
--- a/tools/perf/util/strfilter.c
+++ b/tools/perf/util/strfilter.c
@@ -1,11 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "util.h"
 #include "string2.h"
 #include "strfilter.h"
 
 #include <errno.h>
+#include <stdlib.h>
 #include <linux/ctype.h>
 #include <linux/string.h>
+#include <linux/zalloc.h>
 
 /* Operators */
 static const char *OP_and	= "&";	/* Logical AND */
diff --git a/tools/perf/util/strlist.c b/tools/perf/util/strlist.c
index af45c6fd97db..8a868cbeffae 100644
--- a/tools/perf/util/strlist.c
+++ b/tools/perf/util/strlist.c
@@ -4,12 +4,12 @@
  */
 
 #include "strlist.h"
-#include "util.h"
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <linux/zalloc.h>
 
 static
 struct rb_node *strlist__node_new(struct rblist *rblist, const void *entry)
diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
index fab8a048d31b..76cc54000483 100644
--- a/tools/perf/util/svghelper.c
+++ b/tools/perf/util/svghelper.c
@@ -15,10 +15,10 @@
 #include <string.h>
 #include <linux/bitmap.h>
 #include <linux/time64.h>
+#include <linux/zalloc.h>
 
 #include "perf.h"
 #include "svghelper.h"
-#include "util.h"
 #include "cpumap.h"
 
 static u64 first_time, last_time;
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 429920978cb0..ad683fbe9678 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -17,6 +17,7 @@
 #include "debug.h"
 #include "util.h"
 #include <linux/ctype.h>
+#include <linux/zalloc.h>
 #include <symbol/kallsyms.h>
 
 #ifndef EM_AARCH64
diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index c8b7cadbc9c4..3bc8b7e3300e 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -10,7 +10,7 @@
 #include <stdlib.h>
 #include <byteswap.h>
 #include <sys/stat.h>
-
+#include <linux/zalloc.h>
 
 static bool check_need_swap(int file_endian)
 {
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index ae2ce255e848..173f3378aaa0 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -26,6 +26,7 @@
 #include "header.h"
 #include "path.h"
 #include <linux/ctype.h>
+#include <linux/zalloc.h>
 
 #include <elf.h>
 #include <limits.h>
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index c2037ac533f3..022a9c670338 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -10,9 +10,9 @@
 #include <linux/compiler.h>
 
 #ifdef HAVE_SYSCALL_TABLE_SUPPORT
+#include <linux/zalloc.h>
 #include <string.h>
 #include "string2.h"
-#include "util.h"
 
 #if defined(__x86_64__)
 #include <asm/syscalls_64.c>
diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 48d585a0175c..15134ac9b8f1 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -7,13 +7,13 @@
 #include <linux/rbtree.h>
 #include <linux/list.h>
 #include <linux/log2.h>
+#include <linux/zalloc.h>
 #include <errno.h>
 #include <stdlib.h>
 #include "thread.h"
 #include "event.h"
 #include "machine.h"
 #include "env.h"
-#include "util.h"
 #include "debug.h"
 #include "symbol.h"
 #include "comm.h"
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 3e29a4e8b5e6..bbfb9c767f5f 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -5,10 +5,10 @@
 #include <stdio.h>
 #include <string.h>
 #include <linux/kernel.h>
+#include <linux/zalloc.h>
 #include "session.h"
 #include "thread.h"
 #include "thread-stack.h"
-#include "util.h"
 #include "debug.h"
 #include "namespaces.h"
 #include "comm.h"
diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
index 281bf06f10f2..c291874352cf 100644
--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -13,9 +13,9 @@
 #include <string.h>
 #include <api/fs/fs.h>
 #include <linux/string.h>
+#include <linux/zalloc.h>
 #include "asm/bug.h"
 #include "thread_map.h"
-#include "util.h"
 #include "debug.h"
 #include "event.h"
 
diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-event-info.c
index 806a11b334d3..4550015b9d5d 100644
--- a/tools/perf/util/trace-event-info.c
+++ b/tools/perf/util/trace-event-info.c
@@ -18,6 +18,7 @@
 #include <stdbool.h>
 #include <linux/list.h>
 #include <linux/kernel.h>
+#include <linux/zalloc.h>
 
 #include "../perf.h"
 #include "trace-event.h"
diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
index b023db136ef3..ba58f69777a1 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -12,8 +12,8 @@
 
 #include "../perf.h"
 #include "debug.h"
-#include "util.h"
 #include "trace-event.h"
+#include <linux/zalloc.h>
 
 struct scripting_context *scripting_context;
 
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 407d0167b942..28f71ca6ce1c 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -12,6 +12,7 @@
 #include "symbol.h"
 #include "thread.h"
 #include <linux/types.h>
+#include <linux/zalloc.h>
 #include "event.h"
 #include "perf_regs.h"
 #include "callchain.h"
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index cfc4d85bbd42..dc7a469921e9 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -9,8 +9,6 @@
 #include <fcntl.h>
 #include <stdbool.h>
 #include <stddef.h>
-#include <stdlib.h>
-#include <stdarg.h>
 #include <linux/compiler.h>
 #include <sys/types.h>
 
@@ -18,13 +16,6 @@
 void usage(const char *err) __noreturn;
 void die(const char *err, ...) __noreturn __printf(1, 2);
 
-static inline void *zalloc(size_t size)
-{
-	return calloc(1, size);
-}
-
-#define zfree(ptr) ({ free(*ptr); *ptr = NULL; })
-
 struct dirent;
 struct nsinfo;
 struct strlist;
diff --git a/tools/perf/util/values.c b/tools/perf/util/values.c
index 4b7a303e4ba8..c59154e2d124 100644
--- a/tools/perf/util/values.c
+++ b/tools/perf/util/values.c
@@ -3,8 +3,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <errno.h>
+#include <linux/zalloc.h>
 
-#include "util.h"
 #include "values.h"
 #include "debug.h"
 
diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
index 5031b7b22bbd..7f427bab6c12 100644
--- a/tools/perf/util/vdso.c
+++ b/tools/perf/util/vdso.c
@@ -16,6 +16,7 @@
 #include "machine.h"
 #include "thread.h"
 #include "linux/string.h"
+#include <linux/zalloc.h>
 #include "debug.h"
 
 /*
diff --git a/tools/perf/util/xyarray.c b/tools/perf/util/xyarray.c
index dc95154f5646..86889ebc3514 100644
--- a/tools/perf/util/xyarray.c
+++ b/tools/perf/util/xyarray.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "xyarray.h"
-#include "util.h"
 #include <stdlib.h>
 #include <string.h>
+#include <linux/zalloc.h>
 
 struct xyarray *xyarray__new(int xlen, int ylen, size_t entry_size)
 {
