Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0978DC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF85F223AE
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbfKSOfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:35:20 -0500
Received: from mga04.intel.com ([192.55.52.120]:64767 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728293AbfKSOfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:35:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 06:35:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,324,1569308400"; 
   d="scan'208";a="215552411"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.50])
  by fmsmga001.fm.intel.com with ESMTP; 19 Nov 2019 06:35:15 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, ak@linux.intel.com, eranian@google.com,
        mpe@ellerman.id.au, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 09/13] perf report: Add option to enable the LBR stitching approach
Date:   Tue, 19 Nov 2019 06:34:07 -0800
Message-Id: <20191119143411.3482-10-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191119143411.3482-1-kan.liang@linux.intel.com>
References: <20191119143411.3482-1-kan.liang@linux.intel.com>
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

  # To display the perf.data header info, please use
  # --header/--header-only options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 6K of event 'cycles'
  # Event count (approx.): 6492797701
  #
  # Children      Self  Command          Shared Object       Symbol
  # ........  ........  ...............  ..................
  # .................................
  #
    99.99%    99.99%  tchain_edit      tchain_edit        [.] f43
            |
            ---main
               f1
               f2
               f3
               f4
               f5
               f6
               f7
               f8
               f9
               f10
               f11
               f12
               f13
               f14
               f15
               f16
               f17
               f18
               f19
               f20
               f21
               f22
               f23
               f24
               f25
               f26
               f27
               f28
               f29
               f30
               f31
               |
                --99.65%--f32
                          f33
                          f34
                          f35
                          f36
                          f37
                          f38
                          f39
                          f40
                          f41
                          f42
                          f43

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/Documentation/perf-report.txt | 11 +++++++++++
 tools/perf/builtin-report.c              |  6 ++++++
 2 files changed, 17 insertions(+)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 8dbe2119686a..b42bd38e5790 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -476,6 +476,17 @@ include::itrace.txt[]
 	This option extends the perf report to show reference callgraphs,
 	which collected by reference event, in no callgraph event.
 
+--stitch-lbr::
+	Show callgraph with stitched LBRs, which may have more complete
+	callgraph. The perf.data file must have been obtained using
+	perf record --call-graph lbr.
+	Disabled by default. In common cases with call stack overflows,
+	it can recreate better call stacks than the default lbr call stack
+	output. But this approach is not full proof. There can be cases
+	where it creates incorrect call stacks from incorrect matches.
+	The known limitations include exception handing such as
+	setjmp/longjmp will have calls/returns not match.
+
 --socket-filter::
 	Only report the samples on the processor socket that match with this filter
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 585805f51f15..00c1d8a47b18 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -84,6 +84,7 @@ struct report {
 	bool			header_only;
 	bool			nonany_branch_mode;
 	bool			group_set;
+	bool			stitch_lbr;
 	int			max_stack;
 	struct perf_read_values	show_threads_values;
 	struct annotation_options annotation_opts;
@@ -267,6 +268,9 @@ static int process_sample_event(struct perf_tool *tool,
 		return -1;
 	}
 
+	if (rep->stitch_lbr)
+		al.thread->lbr_stitch_enable = true;
+
 	if (symbol_conf.hide_unresolved && al.sym == NULL)
 		goto out_put;
 
@@ -1229,6 +1233,8 @@ int cmd_report(int argc, const char **argv)
 			"Show full source file name path for source lines"),
 	OPT_BOOLEAN(0, "show-ref-call-graph", &symbol_conf.show_ref_callgraph,
 		    "Show callgraph from reference event"),
+	OPT_BOOLEAN(0, "stitch-lbr", &report.stitch_lbr,
+		    "Enable LBR callgraph stitching approach"),
 	OPT_INTEGER(0, "socket-filter", &report.socket_filter,
 		    "only show processor socket that match with this filter"),
 	OPT_BOOLEAN(0, "raw-trace", &symbol_conf.raw_trace,
-- 
2.17.1

