Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFF6C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D611215EA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbfIBIRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:17:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56320 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730298AbfIBIQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:16:52 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i4hW3-0008D1-Lr; Mon, 02 Sep 2019 10:16:47 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7E1C71C0DFC;
        Mon,  2 Sep 2019 10:16:40 +0200 (CEST)
Date:   Mon, 02 Sep 2019 08:16:40 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf symbols: Move mem_info and branch_info out of symbol.h
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-aupw71xnravcsu2xoabfmhpc@git.kernel.org>
References: <tip-aupw71xnravcsu2xoabfmhpc@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156741220038.17375.10905002219513266868.tip-bot2@tip-bot2>
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

Commit-ID:     d3300a3c4e76ccecf4daa889327e340a870c550b
Gitweb:        https://git.kernel.org/tip/d3300a3c4e76ccecf4daa889327e340a870c550b
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 30 Aug 2019 15:09:54 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 31 Aug 2019 22:27:48 -03:00

perf symbols: Move mem_info and branch_info out of symbol.h

The mem_info struct goes to mem-events.h and branch_info goes to
branch.h, where they belong, this way we can remove several headers from
symbols.h and trim the include dependency tree more.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-aupw71xnravcsu2xoabfmhpc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/mem-events.c |  1 +
 tools/perf/builtin-annotate.c             |  2 ++
 tools/perf/builtin-c2c.c                  |  1 +
 tools/perf/builtin-mem.c                  |  1 +
 tools/perf/builtin-report.c               |  3 +++
 tools/perf/builtin-version.c              |  2 +-
 tools/perf/tests/mem.c                    |  1 +
 tools/perf/tests/sample-parsing.c         |  1 +
 tools/perf/ui/browsers/hists.c            |  2 ++
 tools/perf/util/branch.c                  |  1 +
 tools/perf/util/branch.h                  |  8 ++++++++
 tools/perf/util/cs-etm.c                  |  2 ++
 tools/perf/util/hist.c                    |  3 +++
 tools/perf/util/machine.c                 |  3 +++
 tools/perf/util/map.c                     |  1 +
 tools/perf/util/mem-events.c              |  1 +
 tools/perf/util/mem-events.h              |  9 +++++++++
 tools/perf/util/s390-sample-raw.c         |  1 -
 tools/perf/util/session.c                 |  2 ++
 tools/perf/util/sort.c                    |  2 ++
 tools/perf/util/symbol.c                  |  2 ++
 tools/perf/util/symbol.h                  | 17 -----------------
 22 files changed, 47 insertions(+), 19 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/mem-events.c b/tools/perf/arch/powerpc/util/mem-events.c
index d08311f..07fb5e0 100644
--- a/tools/perf/arch/powerpc/util/mem-events.c
+++ b/tools/perf/arch/powerpc/util/mem-events.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "map_symbol.h"
 #include "mem-events.h"
 
 /* PowerPC does not support 'ldlat' parameter. */
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 7135b77..4e4d2e7 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -33,6 +33,8 @@
 #include "util/data.h"
 #include "arch/common.h"
 #include "util/block-range.h"
+#include "util/map_symbol.h"
+#include "util/branch.h"
 
 #include <dlfcn.h>
 #include <errno.h>
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 0d76b2c..b09b12e 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -22,6 +22,7 @@
 #include "builtin.h"
 #include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
+#include "map_symbol.h"
 #include "mem-events.h"
 #include "session.h"
 #include "hist.h"
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index c5f3b9e..27d2bde 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -11,6 +11,7 @@
 #include "util/tool.h"
 #include "util/session.h"
 #include "util/data.h"
+#include "util/map_symbol.h"
 #include "util/mem-events.h"
 #include "util/debug.h"
 #include "util/dso.h"
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index d7a3456..b18fab9 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -19,6 +19,9 @@
 #include <linux/zalloc.h>
 #include "util/map.h"
 #include "util/symbol.h"
+#include "util/map_symbol.h"
+#include "util/mem-events.h"
+#include "util/branch.h"
 #include "util/callchain.h"
 #include "util/values.h"
 
diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
index bf114ca..05cf2af 100644
--- a/tools/perf/builtin-version.c
+++ b/tools/perf/builtin-version.c
@@ -2,8 +2,8 @@
 #include "builtin.h"
 #include "perf.h"
 #include "color.h"
-#include <linux/compiler.h>
 #include <tools/config.h>
+#include <stdbool.h>
 #include <stdio.h>
 #include <string.h>
 #include <subcmd/parse-options.h>
diff --git a/tools/perf/tests/mem.c b/tools/perf/tests/mem.c
index efe3397..673a11a 100644
--- a/tools/perf/tests/mem.c
+++ b/tools/perf/tests/mem.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "util/map_symbol.h"
 #include "util/mem-events.h"
 #include "util/symbol.h"
 #include "linux/perf_event.h"
diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 0c09dc1..5fcc068 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 
+#include "map_symbol.h"
 #include "branch.h"
 #include "util.h"
 #include "event.h"
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index f7e54c1..589168c 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -20,6 +20,8 @@
 #include "../../util/hist.h"
 #include "../../util/map.h"
 #include "../../util/symbol.h"
+#include "../../util/map_symbol.h"
+#include "../../util/branch.h"
 #include "../../util/pstack.h"
 #include "../../util/sort.h"
 #include "../../util/top.h"
diff --git a/tools/perf/util/branch.c b/tools/perf/util/branch.c
index 30642e1..9d1e090 100644
--- a/tools/perf/util/branch.c
+++ b/tools/perf/util/branch.c
@@ -1,5 +1,6 @@
 #include "util/util.h"
 #include "util/debug.h"
+#include "util/map_symbol.h"
 #include "util/branch.h"
 #include <linux/kernel.h>
 
diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
index 64f96b7..06f66da 100644
--- a/tools/perf/util/branch.h
+++ b/tools/perf/util/branch.h
@@ -16,6 +16,14 @@ struct branch_flags {
 	u64 reserved:40;
 };
 
+struct branch_info {
+	struct addr_map_symbol from;
+	struct addr_map_symbol to;
+	struct branch_flags    flags;
+	char		       *srcline_from;
+	char		       *srcline_to;
+};
+
 struct branch_entry {
 	u64			from;
 	u64			to;
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 0174ecf..707afdb 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -28,6 +28,8 @@
 #include "map.h"
 #include "perf.h"
 #include "session.h"
+#include "map_symbol.h"
+#include "branch.h"
 #include "symbol.h"
 #include "tool.h"
 #include "thread.h"
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 0978dc4..679a1d7 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -5,6 +5,9 @@
 #include "build-id.h"
 #include "hist.h"
 #include "map.h"
+#include "map_symbol.h"
+#include "branch.h"
+#include "mem-events.h"
 #include "session.h"
 #include "namespaces.h"
 #include "sort.h"
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 6a77aef..b4749d3 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -13,6 +13,9 @@
 #include "hist.h"
 #include "machine.h"
 #include "map.h"
+#include "map_symbol.h"
+#include "branch.h"
+#include "mem-events.h"
 #include "srcline.h"
 #include "symbol.h"
 #include "sort.h"
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 623a63c..5b83ed1 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -10,6 +10,7 @@
 #include <uapi/linux/mman.h> /* To get things like MAP_HUGETLB even on older libc headers */
 #include "dso.h"
 #include "map.h"
+#include "map_symbol.h"
 #include "thread.h"
 #include "vdso.h"
 #include "build-id.h"
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 3a8d38c..3d39158 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -8,6 +8,7 @@
 #include <unistd.h>
 #include <api/fs/fs.h>
 #include <linux/kernel.h>
+#include "map_symbol.h"
 #include "mem-events.h"
 #include "debug.h"
 #include "symbol.h"
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index a889ec2..f1389bd 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -6,6 +6,8 @@
 #include <stdint.h>
 #include <stdio.h>
 #include <linux/types.h>
+#include <linux/refcount.h>
+#include <linux/perf_event.h>
 #include "stat.h"
 
 struct perf_mem_event {
@@ -16,6 +18,13 @@ struct perf_mem_event {
 	const char	*sysfs_name;
 };
 
+struct mem_info {
+	struct addr_map_symbol	iaddr;
+	struct addr_map_symbol	daddr;
+	union perf_mem_data_src	data_src;
+	refcount_t		refcnt;
+};
+
 enum {
 	PERF_MEM_EVENTS__LOAD,
 	PERF_MEM_EVENTS__STORE,
diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
index 0ddfa7b..4d9593e 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -25,7 +25,6 @@
 #include "util.h"
 #include "session.h"
 #include "evlist.h"
-#include "config.h"
 #include "color.h"
 #include "sample-raw.h"
 #include "s390-cpumcf-kernel.h"
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index e5ac5f3..e9e4a04 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -12,6 +12,8 @@
 #include <sys/mman.h>
 #include <perf/cpumap.h>
 
+#include "map_symbol.h"
+#include "branch.h"
 #include "debug.h"
 #include "evlist.h"
 #include "evsel.h"
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index b974a2c..a2308eb 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -13,6 +13,8 @@
 #include "comm.h"
 #include "map.h"
 #include "symbol.h"
+#include "map_symbol.h"
+#include "branch.h"
 #include "thread.h"
 #include "evsel.h"
 #include "evlist.h"
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index e5ffe61..765c75d 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -25,6 +25,8 @@
 #include "machine.h"
 #include "map.h"
 #include "symbol.h"
+#include "map_symbol.h"
+#include "mem-events.h"
 #include "symsrc.h"
 #include "strlist.h"
 #include "intlist.h"
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 5a58407..0b0c6b5 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -9,8 +9,6 @@
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include <stdio.h>
-#include "map_symbol.h"
-#include "branch.h"
 #include "path.h"
 #include "symbol_conf.h"
 
@@ -107,21 +105,6 @@ struct ref_reloc_sym {
 	u64		unrelocated_addr;
 };
 
-struct branch_info {
-	struct addr_map_symbol from;
-	struct addr_map_symbol to;
-	struct branch_flags flags;
-	char			*srcline_from;
-	char			*srcline_to;
-};
-
-struct mem_info {
-	struct addr_map_symbol	iaddr;
-	struct addr_map_symbol	daddr;
-	union perf_mem_data_src	data_src;
-	refcount_t		refcnt;
-};
-
 struct block_info {
 	struct symbol		*sym;
 	u64			start;
