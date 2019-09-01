Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F19C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9795C2343A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567340725;
	bh=SoXvi9Sapdv20QoX9LpNszqy6/Ez41nY6XCNJUGP5w0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pvsaSNsPu5efS57MC6LSWIvBT4G8L6E1i7UibF0onpMNcICDUp0UQMUYfHxvLeaH5
	 +q2r9YIZa6DdJefjKKV5q0u/owWkJyEERdAmWO88KIKkDMFTeuavyypqEi8Km2qjkT
	 PVe+mZsfoNwu2YvlmEEijpk/35+NAWDz0i3ulrGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbfIAMZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 08:25:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729273AbfIAMZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:25:22 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9918A21897;
        Sun,  1 Sep 2019 12:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567340721;
        bh=SoXvi9Sapdv20QoX9LpNszqy6/Ez41nY6XCNJUGP5w0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dJv9obhShUHRwu2E2eLMOSvZmmjtE+87uM/6OhxCMZq9ADz/HmjzxQk+CQRcSvooz
         UzYK6Voxza92AHO6RxU6I1RGM9XuGuMBspG6tXqiVo4jYsHN+cWoz41G0RxvBrhhr3
         RyYnLBEPY4R53lUCNPNos36C/aRtZAuOXp3/hR+E=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 37/47] perf symbols: Move mem_info and branch_info out of symbol.h
Date:   Sun,  1 Sep 2019 09:23:16 -0300
Message-Id: <20190901122326.5793-38-acme@kernel.org>
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
index d08311f04e95..07fb5e049488 100644
--- a/tools/perf/arch/powerpc/util/mem-events.c
+++ b/tools/perf/arch/powerpc/util/mem-events.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "map_symbol.h"
 #include "mem-events.h"
 
 /* PowerPC does not support 'ldlat' parameter. */
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 7135b77a18e7..4e4d2e76232e 100644
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
index 0d76b2cb8c0a..b09b12e0976b 100644
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
index c5f3b9e9509d..27d2bde943a8 100644
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
index d7a345667945..b18fab94d38d 100644
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
index bf114ca9ca87..05cf2af9e2c2 100644
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
index efe3397824d2..673a11a6cd1b 100644
--- a/tools/perf/tests/mem.c
+++ b/tools/perf/tests/mem.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "util/map_symbol.h"
 #include "util/mem-events.h"
 #include "util/symbol.h"
 #include "linux/perf_event.h"
diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 0c09dc15a059..5fcc06817076 100644
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
index f7e54c16e594..589168ca9f62 100644
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
index 30642e1f2b1b..9d1e090084a2 100644
--- a/tools/perf/util/branch.c
+++ b/tools/perf/util/branch.c
@@ -1,5 +1,6 @@
 #include "util/util.h"
 #include "util/debug.h"
+#include "util/map_symbol.h"
 #include "util/branch.h"
 #include <linux/kernel.h>
 
diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
index 64f96b79f1d7..06f66dad0b79 100644
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
index 0174ecf757d7..707afdbd9529 100644
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
index 0978dc4a33db..679a1d75090c 100644
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
index 6a77aefbe319..b4749d3eed08 100644
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
index 623a63cd1eec..5b83ed1ebbd6 100644
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
index 3a8d38ce3b54..3d391583f2ae 100644
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
index a889ec2fa9f5..f1389bdae7bf 100644
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
index 0ddfa7b3e4f2..4d9593e331ea 100644
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
index e5ac5f3c94d4..e9e4a04f15db 100644
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
index b974a2c3a3c5..a2308eb77681 100644
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
index e5ffe61ad66b..765c75df2904 100644
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
index 5a58407c2945..0b0c6b5b1899 100644
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
-- 
2.21.0

