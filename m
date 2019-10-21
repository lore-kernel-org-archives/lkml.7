Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29FFCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1EC42084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbfJUUEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 16:04:36 -0400
Received: from mga12.intel.com ([192.55.52.136]:57226 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730191AbfJUUEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 16:04:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 13:04:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,324,1566889200"; 
   d="scan'208";a="201467441"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.125])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2019 13:04:30 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [RFC PATCH V2 13/13] perf hist: Add fast path for duplicate entries check
Date:   Mon, 21 Oct 2019 13:03:14 -0700
Message-Id: <20191021200314.1613-14-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021200314.1613-1-kan.liang@linux.intel.com>
References: <20191021200314.1613-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Perf checks the duplicate entries in a callchain before adding an entry.
However the check is very slow especially with deeper call stack.
Almost ~50% elapsed time of perf report is spent on the check when the
call stack is always depth of 32.

The hist_entry__cmp() is used to compare the new entry with the old
entries. It will go through all the available sorts in the sort_list,
and call the specific cmp of each sort, which is very slow.
Actually, for most cases, there are no duplicate entries in callchain.
The symbols are usually different. It's much faster to do a quick check
for symbols first. Only do the full cmp when the symbols are exactly the
same.
The quick check is only to check symbols, not dso. Export
_sort__sym_cmp.

 $perf record --call-graph lbr ./tchain_edit_64

 Without the patch
 $time perf report --stdio
 real    0m21.142s
 user    0m21.110s
 sys     0m0.033s

 With the patch
 $time perf report --stdio
 real    0m10.977s
 user    0m10.948s
 sys     0m0.027s

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
---

Other solution:
I'm not sure if the full check, hist_entry__cmp(), is ever needed here.
Can we just check the sym and dso for duplicate entries?
Using sort__sym_cmp() to replace hist_entry__cmp() may be an alternative
solution.

 tools/perf/util/hist.c | 23 +++++++++++++++++++++++
 tools/perf/util/sort.c |  2 +-
 tools/perf/util/sort.h |  2 ++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 679a1d75090c..94044b8f1b61 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1047,6 +1047,20 @@ iter_next_cumulative_entry(struct hist_entry_iter *iter,
 	return fill_callchain_info(al, node, iter->hide_unresolved);
 }
 
+static bool
+hist_entry__fast__sym_diff(struct hist_entry *left,
+			   struct hist_entry *right)
+{
+	struct symbol *sym_l = left->ms.sym;
+	struct symbol *sym_r = right->ms.sym;
+
+	if (!sym_l && !sym_r)
+		return left->ip != right->ip;
+
+	return !!_sort__sym_cmp(sym_l, sym_r);
+}
+
+
 static int
 iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
 			       struct addr_location *al)
@@ -1072,6 +1086,7 @@ iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
 	};
 	int i;
 	struct callchain_cursor cursor;
+	bool fast = hists__has(he_tmp.hists, sym);
 
 	callchain_cursor_snapshot(&cursor, &callchain_cursor);
 
@@ -1082,6 +1097,14 @@ iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
 	 * It's possible that it has cycles or recursive calls.
 	 */
 	for (i = 0; i < iter->curr; i++) {
+		/*
+		 * For most cases, there are no duplicate entries in callchain.
+		 * The symbols are usually different. Do a quick check for
+		 * symbols first.
+		 */
+		if (fast && hist_entry__fast__sym_diff(he_cache[i], &he_tmp))
+			continue;
+
 		if (hist_entry__cmp(he_cache[i], &he_tmp) == 0) {
 			/* to avoid calling callback function */
 			iter->he = NULL;
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 43d1d410854a..8ccf4e44aa90 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -234,7 +234,7 @@ static int64_t _sort__addr_cmp(u64 left_ip, u64 right_ip)
 	return (int64_t)(right_ip - left_ip);
 }
 
-static int64_t _sort__sym_cmp(struct symbol *sym_l, struct symbol *sym_r)
+int64_t _sort__sym_cmp(struct symbol *sym_l, struct symbol *sym_r)
 {
 	if (!sym_l || !sym_r)
 		return cmp_null(sym_l, sym_r);
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 5aff9542d9b7..d608b8a28a92 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -307,5 +307,7 @@ int64_t
 sort__daddr_cmp(struct hist_entry *left, struct hist_entry *right);
 int64_t
 sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right);
+int64_t
+_sort__sym_cmp(struct symbol *sym_l, struct symbol *sym_r);
 char *hist_entry__srcline(struct hist_entry *he);
 #endif	/* __PERF_SORT_H */
-- 
2.17.1

