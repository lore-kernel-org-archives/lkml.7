Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678D9CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3D12084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbfJUUE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 16:04:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:57214 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730236AbfJUUEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 16:04:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 13:04:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,324,1566889200"; 
   d="scan'208";a="201467371"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.125])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2019 13:04:21 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 03/13] perf tools: Support new branch sample type for LBR TOS
Date:   Mon, 21 Oct 2019 13:03:04 -0700
Message-Id: <20191021200314.1613-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021200314.1613-1-kan.liang@linux.intel.com>
References: <20191021200314.1613-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Support new branch sample type for LBR TOS.

Enable LBR_TOS by default in LBR call stack mode.
If kernel doesn't support the sample type, switching it off.

Add a new branch options "tos" for the new branch sample type.

Set tos to -1ULL if the LBR TOS information is unavailable.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/include/uapi/linux/perf_event.h     | 10 +++++++++-
 tools/perf/util/event.h                   |  1 +
 tools/perf/util/evsel.c                   | 20 +++++++++++++++++---
 tools/perf/util/evsel.h                   |  6 ++++++
 tools/perf/util/parse-branch-options.c    |  1 +
 tools/perf/util/perf_event_attr_fprintf.c |  1 +
 6 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index bb7b271397a6..b1f022190571 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -180,6 +180,8 @@ enum perf_branch_sample_type_shift {
 
 	PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT	= 16, /* save branch type */
 
+	PERF_SAMPLE_BRANCH_LBR_TOS_SHIFT	= 17, /* save LBR TOS */
+
 	PERF_SAMPLE_BRANCH_MAX_SHIFT		/* non-ABI */
 };
 
@@ -207,6 +209,8 @@ enum perf_branch_sample_type {
 	PERF_SAMPLE_BRANCH_TYPE_SAVE	=
 		1U << PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT,
 
+	PERF_SAMPLE_BRANCH_LBR_TOS	= 1U << PERF_SAMPLE_BRANCH_LBR_TOS_SHIFT,
+
 	PERF_SAMPLE_BRANCH_MAX		= 1U << PERF_SAMPLE_BRANCH_MAX_SHIFT,
 };
 
@@ -849,7 +853,11 @@ enum perf_event_type {
 	 *	  char                  data[size];}&& PERF_SAMPLE_RAW
 	 *
 	 *	{ u64                   nr;
-	 *        { u64 from, to, flags } lbr[nr];} && PERF_SAMPLE_BRANCH_STACK
+	 *        { u64 from, to, flags } lbr[nr];
+	 *
+	 *        # only available if PERF_SAMPLE_BRANCH_LBR_TOS is set
+	 *        u64			tos;
+	 *      } && PERF_SAMPLE_BRANCH_STACK
 	 *
 	 * 	{ u64			abi; # enum perf_sample_regs_abi
 	 * 	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_USER
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index a0a0c91cde4a..98794758546b 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -130,6 +130,7 @@ struct perf_sample {
 	u32 raw_size;
 	u64 data_src;
 	u64 phys_addr;
+	u64 lbr_tos;
 	u32 flags;
 	u16 insn_len;
 	u8  cpumode;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index abc7fda4a0fe..6b91897e4ca2 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -712,7 +712,8 @@ static void __perf_evsel__config_callchain(struct evsel *evsel,
 				attr->branch_sample_type = PERF_SAMPLE_BRANCH_USER |
 							PERF_SAMPLE_BRANCH_CALL_STACK |
 							PERF_SAMPLE_BRANCH_NO_CYCLES |
-							PERF_SAMPLE_BRANCH_NO_FLAGS;
+							PERF_SAMPLE_BRANCH_NO_FLAGS |
+							PERF_SAMPLE_BRANCH_LBR_TOS;
 			}
 		} else
 			 pr_warning("Cannot use LBR callstack with branch stack. "
@@ -763,7 +764,8 @@ perf_evsel__reset_callgraph(struct evsel *evsel,
 	if (param->record_mode == CALLCHAIN_LBR) {
 		perf_evsel__reset_sample_bit(evsel, BRANCH_STACK);
 		attr->branch_sample_type &= ~(PERF_SAMPLE_BRANCH_USER |
-					      PERF_SAMPLE_BRANCH_CALL_STACK);
+					      PERF_SAMPLE_BRANCH_CALL_STACK |
+					      PERF_SAMPLE_BRANCH_LBR_TOS);
 	}
 	if (param->record_mode == CALLCHAIN_DWARF) {
 		perf_evsel__reset_sample_bit(evsel, REGS_USER);
@@ -1641,6 +1643,8 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		evsel->core.attr.ksymbol = 0;
 	if (perf_missing_features.bpf)
 		evsel->core.attr.bpf_event = 0;
+	if (perf_missing_features.lbr_tos)
+		evsel->core.attr.branch_sample_type &= ~PERF_SAMPLE_BRANCH_LBR_TOS;
 retry_sample_id:
 	if (perf_missing_features.sample_id_all)
 		evsel->core.attr.sample_id_all = 0;
@@ -1752,7 +1756,12 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 	 * Must probe features in the order they were added to the
 	 * perf_event_attr interface.
 	 */
-	if (!perf_missing_features.aux_output && evsel->core.attr.aux_output) {
+	if (!perf_missing_features.lbr_tos &&
+	    (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_LBR_TOS)) {
+		perf_missing_features.lbr_tos = true;
+		pr_debug2("switching off LBR TOS support\n");
+		goto fallback_missing_features;
+	} else if (!perf_missing_features.aux_output && evsel->core.attr.aux_output) {
 		perf_missing_features.aux_output = true;
 		pr_debug2("Kernel has no attr.aux_output support, bailing out\n");
 		goto out_close;
@@ -2126,6 +2135,11 @@ int perf_evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		sz = data->branch_stack->nr * sizeof(struct branch_entry);
 		OVERFLOW_CHECK(array, sz, max_size);
 		array = (void *)array + sz;
+
+		if (perf_evsel__has_lbr_tos(evsel))
+			data->lbr_tos = *array++;
+		else
+			data->lbr_tos = -1ULL;
 	}
 
 	if (type & PERF_SAMPLE_REGS_USER) {
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index ddc5ee6f6592..52f8a5401361 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -115,6 +115,7 @@ struct perf_missing_features {
 	bool ksymbol;
 	bool bpf;
 	bool aux_output;
+	bool lbr_tos;
 };
 
 extern struct perf_missing_features perf_missing_features;
@@ -377,6 +378,11 @@ for ((_evsel) = _leader; 							\
      (_evsel) && (_evsel)->leader == (_leader);					\
      (_evsel) = list_entry((_evsel)->core.node.next, struct evsel, core.node))
 
+static inline bool perf_evsel__has_lbr_tos(const struct evsel *evsel)
+{
+	return evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_LBR_TOS;
+}
+
 static inline bool perf_evsel__has_branch_callstack(const struct evsel *evsel)
 {
 	return evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_CALL_STACK;
diff --git a/tools/perf/util/parse-branch-options.c b/tools/perf/util/parse-branch-options.c
index bb4aa88c50a8..1425c3525f17 100644
--- a/tools/perf/util/parse-branch-options.c
+++ b/tools/perf/util/parse-branch-options.c
@@ -32,6 +32,7 @@ static const struct branch_mode branch_modes[] = {
 	BRANCH_OPT("call", PERF_SAMPLE_BRANCH_CALL),
 	BRANCH_OPT("save_type", PERF_SAMPLE_BRANCH_TYPE_SAVE),
 	BRANCH_OPT("stack", PERF_SAMPLE_BRANCH_CALL_STACK),
+	BRANCH_OPT("tos", PERF_SAMPLE_BRANCH_LBR_TOS),
 	BRANCH_END
 };
 
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index d4ad3f04923a..5c4047e7cc8d 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -50,6 +50,7 @@ static void __p_branch_sample_type(char *buf, size_t size, u64 value)
 		bit_name(ABORT_TX), bit_name(IN_TX), bit_name(NO_TX),
 		bit_name(COND), bit_name(CALL_STACK), bit_name(IND_JUMP),
 		bit_name(CALL), bit_name(NO_FLAGS), bit_name(NO_CYCLES),
+		bit_name(LBR_TOS),
 		{ .name = NULL, }
 	};
 #undef bit_name
-- 
2.17.1

