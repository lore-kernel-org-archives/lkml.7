Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE1DC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B52206C2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbfJGR75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 13:59:57 -0400
Received: from mga11.intel.com ([192.55.52.93]:33635 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729356AbfJGR74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 13:59:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 10:59:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="193161263"
Received: from unknown (HELO labuser-Ice-Lake-Client-Platform.jf.intel.com) ([10.54.55.65])
  by fmsmga007.fm.intel.com with ESMTP; 07 Oct 2019 10:59:55 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org, ak@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 02/10] perf tools: Support PERF_SAMPLE_LBR_TOS
Date:   Mon,  7 Oct 2019 10:59:02 -0700
Message-Id: <20191007175910.2805-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191007175910.2805-1-kan.liang@linux.intel.com>
References: <20191007175910.2805-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Support new sample type PERF_SAMPLE_LBR_TOS.

Enable LBR_TOS by default in LBR call stack mode.
If kernel doesn't support the sample type, switching it off.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/include/uapi/linux/perf_event.h     |  4 +++-
 tools/perf/util/event.h                   |  1 +
 tools/perf/util/evsel.c                   | 16 +++++++++++++++-
 tools/perf/util/evsel.h                   |  1 +
 tools/perf/util/perf_event_attr_fprintf.c |  2 +-
 tools/perf/util/synthetic-events.c        |  8 ++++++++
 6 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index bb7b271397a6..fe36ebb7dc2e 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -141,8 +141,9 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_TRANSACTION			= 1U << 17,
 	PERF_SAMPLE_REGS_INTR			= 1U << 18,
 	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
+	PERF_SAMPLE_LBR_TOS			= 1U << 20,
 
-	PERF_SAMPLE_MAX = 1U << 20,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 21,		/* non-ABI */
 
 	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
@@ -864,6 +865,7 @@ enum perf_event_type {
 	 *	{ u64			abi; # enum perf_sample_regs_abi
 	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_INTR
 	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
+	 *	{ u64			tos;} && PERF_SAMPLE_LBR_TOS
 	 * };
 	 */
 	PERF_RECORD_SAMPLE			= 9,
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index a0a0c91cde4a..268c1715e032 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -130,6 +130,7 @@ struct perf_sample {
 	u32 raw_size;
 	u64 data_src;
 	u64 phys_addr;
+	u64 tos;
 	u32 flags;
 	u16 insn_len;
 	u8  cpumode;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index abc7fda4a0fe..0752417bbc45 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -709,6 +709,7 @@ static void __perf_evsel__config_callchain(struct evsel *evsel,
 					   "Falling back to framepointers.\n");
 			} else {
 				perf_evsel__set_sample_bit(evsel, BRANCH_STACK);
+				perf_evsel__set_sample_bit(evsel, LBR_TOS);
 				attr->branch_sample_type = PERF_SAMPLE_BRANCH_USER |
 							PERF_SAMPLE_BRANCH_CALL_STACK |
 							PERF_SAMPLE_BRANCH_NO_CYCLES |
@@ -762,6 +763,7 @@ perf_evsel__reset_callgraph(struct evsel *evsel,
 	perf_evsel__reset_sample_bit(evsel, CALLCHAIN);
 	if (param->record_mode == CALLCHAIN_LBR) {
 		perf_evsel__reset_sample_bit(evsel, BRANCH_STACK);
+		perf_evsel__reset_sample_bit(evsel, LBR_TOS);
 		attr->branch_sample_type &= ~(PERF_SAMPLE_BRANCH_USER |
 					      PERF_SAMPLE_BRANCH_CALL_STACK);
 	}
@@ -1641,6 +1643,8 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		evsel->core.attr.ksymbol = 0;
 	if (perf_missing_features.bpf)
 		evsel->core.attr.bpf_event = 0;
+	if (perf_missing_features.lbr_tos)
+		perf_evsel__reset_sample_bit(evsel, LBR_TOS);
 retry_sample_id:
 	if (perf_missing_features.sample_id_all)
 		evsel->core.attr.sample_id_all = 0;
@@ -1752,7 +1756,11 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 	 * Must probe features in the order they were added to the
 	 * perf_event_attr interface.
 	 */
-	if (!perf_missing_features.aux_output && evsel->core.attr.aux_output) {
+	if (!perf_missing_features.lbr_tos && (evsel->core.attr.sample_type & PERF_SAMPLE_LBR_TOS)) {
+		perf_missing_features.lbr_tos = true;
+		pr_debug2("switching off LBR TOS support\n");
+		goto fallback_missing_features;
+	} else if (!perf_missing_features.aux_output && evsel->core.attr.aux_output) {
 		perf_missing_features.aux_output = true;
 		pr_debug2("Kernel has no attr.aux_output support, bailing out\n");
 		goto out_close;
@@ -2206,6 +2214,12 @@ int perf_evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		array++;
 	}
 
+	data->tos = -1ULL;
+	if (type & PERF_SAMPLE_LBR_TOS) {
+		data->tos = *array;
+		array++;
+	}
+
 	return 0;
 }
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index ddc5ee6f6592..e4768c60da93 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -115,6 +115,7 @@ struct perf_missing_features {
 	bool ksymbol;
 	bool bpf;
 	bool aux_output;
+	bool lbr_tos;
 };
 
 extern struct perf_missing_features perf_missing_features;
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index d4ad3f04923a..254f1bf8dcae 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -34,7 +34,7 @@ static void __p_sample_type(char *buf, size_t size, u64 value)
 		bit_name(PERIOD), bit_name(STREAM_ID), bit_name(RAW),
 		bit_name(BRANCH_STACK), bit_name(REGS_USER), bit_name(STACK_USER),
 		bit_name(IDENTIFIER), bit_name(REGS_INTR), bit_name(DATA_SRC),
-		bit_name(WEIGHT), bit_name(PHYS_ADDR),
+		bit_name(WEIGHT), bit_name(PHYS_ADDR), bit_name(LBR_TOS),
 		{ .name = NULL, }
 	};
 #undef bit_name
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 807cbca403a7..a7d02e81defe 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1228,6 +1228,9 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 	if (type & PERF_SAMPLE_PHYS_ADDR)
 		result += sizeof(u64);
 
+	if (type & PERF_SAMPLE_LBR_TOS)
+		result += sizeof(u64);
+
 	return result;
 }
 
@@ -1396,6 +1399,11 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
 		array++;
 	}
 
+	if (type & PERF_SAMPLE_LBR_TOS) {
+		*array = sample->tos;
+		array++;
+	}
+
 	return 0;
 }
 
-- 
2.17.1

