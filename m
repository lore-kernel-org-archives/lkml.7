Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398C7C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137AF2071C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfKUOhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 09:37:53 -0500
Received: from mga04.intel.com ([192.55.52.120]:32456 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfKUOhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 09:37:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2019 06:37:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,226,1571727600"; 
   d="scan'208";a="209922606"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.50])
  by orsmga003.jf.intel.com with ESMTP; 21 Nov 2019 06:37:50 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@redhat.com, mingo@kernel.org,
        eranian@google.com, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V5 1/2] perf/core: Add new branch sample type for HW index of raw branch records
Date:   Thu, 21 Nov 2019 06:36:45 -0800
Message-Id: <20191121143646.8687-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191121143646.8687-1-kan.liang@linux.intel.com>
References: <20191121143646.8687-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The low level index of raw branch records is very useful for
reconstructing the call stack. For example, in Intel LBR call stack mode,
the depth of reconstructed LBR call stack limits to the number of LBR
registers. With the HW index information, perf tool may stitch the
stacks of two samples. The reconstructed LBR call stack can break the HW
limitation.

Add a new branch sample type to retrieve the low level index of raw
branch records. Only need to save the index for the most recent branch
aka entries[0]. Others can be calculated by the max number of HW
supported branch records later in perf tool.

If we don't know the order of raw branch records, the hw_idx should be
-1ULL. This patch sets -1ULL for all architectures for now. It can be
changed later if needed.

Only when the new branch sample type is set, the HW index information is
dumped into the PERF_SAMPLE_BRANCH_STACK output.
Perf tool should check the attr.branch_sample_type, and apply the
corresponding format for PERF_SAMPLE_BRANCH_STACK samples.
Otherwise, some user case may be broken. For example, users may parse a
perf.data, which include the new branch sample type, with an old version
perf tool (without the check). Users probably get incorrect information
without any warning.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/powerpc/perf/core-book3s.c |  1 +
 arch/x86/events/intel/lbr.c     |  3 +++
 include/linux/perf_event.h      | 12 ++++++++++++
 include/uapi/linux/perf_event.h | 10 +++++++++-
 kernel/events/core.c            | 11 +++++++++++
 5 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 48604625ab31..fe7de222229a 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -524,6 +524,7 @@ static void power_pmu_bhrb_read(struct perf_event *event, struct cpu_hw_events *
 		}
 	}
 	cpuhw->bhrb_stack.nr = u_index;
+	cpuhw->bhrb_stack.hw_idx = -1ULL;
 	return;
 }
 
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 534c76606049..7639e2097101 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -585,6 +585,7 @@ static void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
 		cpuc->lbr_entries[i].reserved	= 0;
 	}
 	cpuc->lbr_stack.nr = i;
+	cpuc->lbr_stack.hw_idx = -1ULL;
 }
 
 /*
@@ -680,6 +681,7 @@ static void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 		out++;
 	}
 	cpuc->lbr_stack.nr = out;
+	cpuc->lbr_stack.hw_idx = -1ULL;
 }
 
 void intel_pmu_lbr_read(void)
@@ -1120,6 +1122,7 @@ void intel_pmu_store_pebs_lbrs(struct pebs_lbr *lbr)
 	int i;
 
 	cpuc->lbr_stack.nr = x86_pmu.lbr_nr;
+	cpuc->lbr_stack.hw_idx = -1ULL;
 	for (i = 0; i < x86_pmu.lbr_nr; i++) {
 		u64 info = lbr->lbr[i].info;
 		struct perf_branch_entry *e = &cpuc->lbr_entries[i];
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 011dcbdbccc2..554621d99864 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -93,14 +93,26 @@ struct perf_raw_record {
 /*
  * branch stack layout:
  *  nr: number of taken branches stored in entries[]
+ *  hw_idx: The low level index of raw branch records
+ *          for the most recent branch.
+ *          -1ULL means invalid.
  *
  * Note that nr can vary from sample to sample
  * branches (to, from) are stored from most recent
  * to least recent, i.e., entries[0] contains the most
  * recent branch.
+ * The entries[] is an abstraction of raw branch records,
+ * which may not be stored in age order in HW, e.g. Intel LBR.
+ * The hw_idx is to expose the low level index of raw
+ * branch record for the most recent branch aka entries[0].
+ * For the architectures whose raw branch records are
+ * already stored in age order, the hw_idx should be 0.
+ * If we don't know the order of raw branch records,
+ * the hw_idx should be -1ULL.
  */
 struct perf_branch_stack {
 	__u64				nr;
+	__u64				hw_idx;
 	struct perf_branch_entry	entries[0];
 };
 
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index bb7b271397a6..14110837b130 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -180,6 +180,8 @@ enum perf_branch_sample_type_shift {
 
 	PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT	= 16, /* save branch type */
 
+	PERF_SAMPLE_BRANCH_HW_INDEX_SHIFT	= 17, /* save low level index of raw branch records */
+
 	PERF_SAMPLE_BRANCH_MAX_SHIFT		/* non-ABI */
 };
 
@@ -207,6 +209,8 @@ enum perf_branch_sample_type {
 	PERF_SAMPLE_BRANCH_TYPE_SAVE	=
 		1U << PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT,
 
+	PERF_SAMPLE_BRANCH_HW_INDEX	= 1U << PERF_SAMPLE_BRANCH_HW_INDEX_SHIFT,
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
+	 *        # only available if PERF_SAMPLE_BRANCH_HW_INDEX is set
+	 *        u64			hw_idx;
+	 *      } && PERF_SAMPLE_BRANCH_STACK
 	 *
 	 * 	{ u64			abi; # enum perf_sample_regs_abi
 	 * 	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_USER
diff --git a/kernel/events/core.c b/kernel/events/core.c
index cfd89b4a02d8..4be3ba12333f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6391,6 +6391,11 @@ static void perf_output_read(struct perf_output_handle *handle,
 		perf_output_read_one(handle, event, enabled, running);
 }
 
+static inline bool perf_sample_save_hw_index(struct perf_event *event)
+{
+	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX;
+}
+
 void perf_output_sample(struct perf_output_handle *handle,
 			struct perf_event_header *header,
 			struct perf_sample_data *data,
@@ -6480,6 +6485,8 @@ void perf_output_sample(struct perf_output_handle *handle,
 
 			perf_output_put(handle, data->br_stack->nr);
 			perf_output_copy(handle, data->br_stack->entries, size);
+			if (perf_sample_save_hw_index(event))
+				perf_output_put(handle, data->br_stack->hw_idx);
 		} else {
 			/*
 			 * we always store at least the value of nr
@@ -6667,7 +6674,11 @@ void perf_prepare_sample(struct perf_event_header *header,
 		if (data->br_stack) {
 			size += data->br_stack->nr
 			      * sizeof(struct perf_branch_entry);
+
+			if (perf_sample_save_hw_index(event))
+				size += sizeof(u64);
 		}
+
 		header->size += size;
 	}
 
-- 
2.17.1

