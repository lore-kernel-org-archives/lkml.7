Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD68CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 105392089C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbfJUUEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 16:04:33 -0400
Received: from mga12.intel.com ([192.55.52.136]:57225 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730289AbfJUUE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 16:04:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 13:04:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,324,1566889200"; 
   d="scan'208";a="201467420"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.125])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2019 13:04:27 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 11/13] perf top: Add option to enable the LBR stitching approach
Date:   Mon, 21 Oct 2019 13:03:12 -0700
Message-Id: <20191021200314.1613-12-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021200314.1613-1-kan.liang@linux.intel.com>
References: <20191021200314.1613-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

With the LBR stitching approach, the reconstructed LBR call stack
can break the HW limitation. However, it may reconstruct invalid call
stacks in some cases, e.g. exception handing such as setjmp/longjmp.
Also, it may impact the processing time especially when the number of
samples with stitched LBRs are huge.

Add an option to enable the approach.
The option must be used with --call-graph lbr.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/Documentation/perf-top.txt |  9 +++++++++
 tools/perf/builtin-top.c              | 11 +++++++++++
 tools/perf/util/top.h                 |  1 +
 3 files changed, 21 insertions(+)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index 5596129a71cf..80b57f942a86 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -304,6 +304,15 @@ Default is to monitor all CPUS.
 	go straight to the histogram browser, just like 'perf top' with no events
 	explicitely specified does.
 
+--stitch-lbr::
+	Show callgraph with stitched LBRs, which may have more complete
+	callgraph. The option must be used with --call-graph lbr recording.
+	Disabled by default. In common cases with call stack overflows,
+	it can recreate better call stacks than the default lbr call stack
+	output. But this approach is not full proof. There can be cases
+	where it creates incorrect call stacks from incorrect matches.
+	The known limitations include exception handing such as
+	setjmp/longjmp will have calls/returns not match.
 
 INTERACTIVE PROMPTING KEYS
 --------------------------
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 611d03030abc..539670377e0f 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -33,6 +33,7 @@
 #include "util/map.h"
 #include "util/mmap.h"
 #include "util/session.h"
+#include "util/thread.h"
 #include "util/symbol.h"
 #include "util/synthetic-events.h"
 #include "util/top.h"
@@ -764,6 +765,9 @@ static void perf_event__process_sample(struct perf_tool *tool,
 	if (machine__resolve(machine, &al, sample) < 0)
 		return;
 
+	if (top->stitch_lbr)
+		al.thread->lbr_stitch_enable = true;
+
 	if (!machine->kptr_restrict_warned &&
 	    symbol_conf.kptr_restrict &&
 	    al.cpumode == PERF_RECORD_MISC_KERNEL) {
@@ -1537,6 +1541,8 @@ int cmd_top(int argc, const char **argv)
 			"number of thread to run event synthesize"),
 	OPT_BOOLEAN(0, "namespaces", &opts->record_namespaces,
 		    "Record namespaces events"),
+	OPT_BOOLEAN(0, "stitch-lbr", &top.stitch_lbr,
+		    "Enable LBR callgraph stitching approach"),
 	OPTS_EVSWITCH(&top.evswitch),
 	OPT_END()
 	};
@@ -1599,6 +1605,11 @@ int cmd_top(int argc, const char **argv)
 		}
 	}
 
+	if (top.stitch_lbr && !(callchain_param.record_mode == CALLCHAIN_LBR)) {
+		pr_err("Error: --stitch-lbr must be used with --call-graph lbr\n");
+		goto out_delete_evlist;
+	}
+
 	if (opts->branch_stack && callchain_param.enabled)
 		symbol_conf.show_branchflag_count = true;
 
diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
index f117d4f4821e..45dc84ddff37 100644
--- a/tools/perf/util/top.h
+++ b/tools/perf/util/top.h
@@ -36,6 +36,7 @@ struct perf_top {
 	bool		   use_tui, use_stdio;
 	bool		   vmlinux_warned;
 	bool		   dump_symtab;
+	bool		   stitch_lbr;
 	struct hist_entry  *sym_filter_entry;
 	struct evsel 	   *sym_evsel;
 	struct perf_session *session;
-- 
2.17.1

