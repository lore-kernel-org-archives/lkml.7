Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2497DC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001EA2173B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbfJHHGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 03:06:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:64439 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730026AbfJHHGO (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:06:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 00:06:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="196522439"
Received: from kbl.sh.intel.com ([10.239.159.163])
  by orsmga003.jf.intel.com with ESMTP; 08 Oct 2019 00:06:12 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 1/5] perf util: Create new block.h/block.c for block related functions
Date:   Tue,  8 Oct 2019 15:04:58 +0800
Message-Id: <20191008070502.22551-2-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191008070502.22551-1-yao.jin@linux.intel.com>
References: <20191008070502.22551-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have already implemented some block related functions. Now it's
time to do some cleanup, and move the functions and structures to
the new block.h/block.c.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-diff.c | 38 ++---------------------
 tools/perf/util/Build     |  1 +
 tools/perf/util/block.c   | 63 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/block.h   | 36 ++++++++++++++++++++++
 tools/perf/util/hist.c    |  1 +
 tools/perf/util/symbol.c  | 22 --------------
 tools/perf/util/symbol.h  | 23 --------------
 7 files changed, 103 insertions(+), 81 deletions(-)
 create mode 100644 tools/perf/util/block.c
 create mode 100644 tools/perf/util/block.h

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index c37a78677955..c5242737a6df 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -23,6 +23,7 @@
 #include "util/time-utils.h"
 #include "util/annotate.h"
 #include "util/map.h"
+#include "util/block.h"
 #include <linux/err.h>
 #include <linux/zalloc.h>
 #include <subcmd/pager.h>
@@ -530,41 +531,6 @@ static void hists__baseline_only(struct hists *hists)
 	}
 }
 
-static int64_t block_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
-			 struct hist_entry *left, struct hist_entry *right)
-{
-	struct block_info *bi_l = left->block_info;
-	struct block_info *bi_r = right->block_info;
-	int cmp;
-
-	if (!bi_l->sym || !bi_r->sym) {
-		if (!bi_l->sym && !bi_r->sym)
-			return 0;
-		else if (!bi_l->sym)
-			return -1;
-		else
-			return 1;
-	}
-
-	if (bi_l->sym == bi_r->sym) {
-		if (bi_l->start == bi_r->start) {
-			if (bi_l->end == bi_r->end)
-				return 0;
-			else
-				return (int64_t)(bi_r->end - bi_l->end);
-		} else
-			return (int64_t)(bi_r->start - bi_l->start);
-	} else {
-		cmp = strcmp(bi_l->sym->name, bi_r->sym->name);
-		return cmp;
-	}
-
-	if (bi_l->sym->start != bi_r->sym->start)
-		return (int64_t)(bi_r->sym->start - bi_l->sym->start);
-
-	return (int64_t)(bi_r->sym->end - bi_l->sym->end);
-}
-
 static int64_t block_cycles_diff_cmp(struct hist_entry *left,
 				     struct hist_entry *right)
 {
@@ -593,7 +559,7 @@ static void init_block_hist(struct block_hist *bh)
 
 	INIT_LIST_HEAD(&bh->block_fmt.list);
 	INIT_LIST_HEAD(&bh->block_fmt.sort_list);
-	bh->block_fmt.cmp = block_cmp;
+	bh->block_fmt.cmp = block_info__cmp;
 	bh->block_fmt.sort = block_sort;
 	perf_hpp_list__register_sort_field(&bh->block_list,
 					   &bh->block_fmt);
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 8dcfca1a882f..af46facb6d08 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -1,4 +1,5 @@
 perf-y += annotate.o
+perf-y += block.o
 perf-y += block-range.o
 perf-y += build-id.o
 perf-y += cacheline.o
diff --git a/tools/perf/util/block.c b/tools/perf/util/block.c
new file mode 100644
index 000000000000..e5e6f941f040
--- /dev/null
+++ b/tools/perf/util/block.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdlib.h>
+#include <string.h>
+#include <linux/zalloc.h>
+#include "block.h"
+#include "sort.h"
+
+struct block_info *block_info__get(struct block_info *bi)
+{
+	if (bi)
+		refcount_inc(&bi->refcnt);
+	return bi;
+}
+
+void block_info__put(struct block_info *bi)
+{
+	if (bi && refcount_dec_and_test(&bi->refcnt))
+		free(bi);
+}
+
+struct block_info *block_info__new(void)
+{
+	struct block_info *bi = zalloc(sizeof(*bi));
+
+	if (bi)
+		refcount_set(&bi->refcnt, 1);
+	return bi;
+}
+
+int64_t block_info__cmp(struct perf_hpp_fmt *fmt __maybe_unused,
+			struct hist_entry *left, struct hist_entry *right)
+{
+	struct block_info *bi_l = left->block_info;
+	struct block_info *bi_r = right->block_info;
+	int cmp;
+
+	if (!bi_l->sym || !bi_r->sym) {
+		if (!bi_l->sym && !bi_r->sym)
+			return 0;
+		else if (!bi_l->sym)
+			return -1;
+		else
+			return 1;
+	}
+
+	if (bi_l->sym == bi_r->sym) {
+		if (bi_l->start == bi_r->start) {
+			if (bi_l->end == bi_r->end)
+				return 0;
+			else
+				return (int64_t)(bi_r->end - bi_l->end);
+		} else
+			return (int64_t)(bi_r->start - bi_l->start);
+	} else {
+		cmp = strcmp(bi_l->sym->name, bi_r->sym->name);
+		return cmp;
+	}
+
+	if (bi_l->sym->start != bi_r->sym->start)
+		return (int64_t)(bi_r->sym->start - bi_l->sym->start);
+
+	return (int64_t)(bi_r->sym->end - bi_l->sym->end);
+}
diff --git a/tools/perf/util/block.h b/tools/perf/util/block.h
new file mode 100644
index 000000000000..1aeef6dd2bf3
--- /dev/null
+++ b/tools/perf/util/block.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_BLOCK_H
+#define __PERF_BLOCK_H
+
+#include <linux/types.h>
+#include <linux/refcount.h>
+#include "util/hist.h"
+#include "util/symbol.h"
+
+struct block_info {
+	struct symbol		*sym;
+	u64			start;
+	u64			end;
+	u64			cycles;
+	u64			cycles_aggr;
+	int			num;
+	int			num_aggr;
+	refcount_t		refcnt;
+};
+
+struct block_info *block_info__new(void);
+struct block_info *block_info__get(struct block_info *bi);
+void   block_info__put(struct block_info *bi);
+
+static inline void __block_info__zput(struct block_info **bi)
+{
+	block_info__put(*bi);
+	*bi = NULL;
+}
+
+#define block_info__zput(bi) __block_info__zput(&bi)
+
+int64_t block_info__cmp(struct perf_hpp_fmt *fmt __maybe_unused,
+			struct hist_entry *left, struct hist_entry *right);
+
+#endif /* __PERF_BLOCK_H */
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 679a1d75090c..26ee45a3e5d0 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -18,6 +18,7 @@
 #include "srcline.h"
 #include "symbol.h"
 #include "thread.h"
+#include "block.h"
 #include "ui/progress.h"
 #include <errno.h>
 #include <math.h>
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a8f80e427674..fac8887a6759 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2371,25 +2371,3 @@ struct mem_info *mem_info__new(void)
 		refcount_set(&mi->refcnt, 1);
 	return mi;
 }
-
-struct block_info *block_info__get(struct block_info *bi)
-{
-	if (bi)
-		refcount_inc(&bi->refcnt);
-	return bi;
-}
-
-void block_info__put(struct block_info *bi)
-{
-	if (bi && refcount_dec_and_test(&bi->refcnt))
-		free(bi);
-}
-
-struct block_info *block_info__new(void)
-{
-	struct block_info *bi = zalloc(sizeof(*bi));
-
-	if (bi)
-		refcount_set(&bi->refcnt, 1);
-	return bi;
-}
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 0b0c6b5b1899..6015541e145b 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -105,17 +105,6 @@ struct ref_reloc_sym {
 	u64		unrelocated_addr;
 };
 
-struct block_info {
-	struct symbol		*sym;
-	u64			start;
-	u64			end;
-	u64			cycles;
-	u64			cycles_aggr;
-	int			num;
-	int			num_aggr;
-	refcount_t		refcnt;
-};
-
 struct addr_location {
 	struct machine *machine;
 	struct thread *thread;
@@ -289,16 +278,4 @@ static inline void __mem_info__zput(struct mem_info **mi)
 
 #define mem_info__zput(mi) __mem_info__zput(&mi)
 
-struct block_info *block_info__new(void);
-struct block_info *block_info__get(struct block_info *bi);
-void   block_info__put(struct block_info *bi);
-
-static inline void __block_info__zput(struct block_info **bi)
-{
-	block_info__put(*bi);
-	*bi = NULL;
-}
-
-#define block_info__zput(bi) __block_info__zput(&bi)
-
 #endif /* __PERF_SYMBOL */
-- 
2.17.1

