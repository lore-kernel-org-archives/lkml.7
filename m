Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700A1ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536F520684
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbfJGR76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 13:59:58 -0400
Received: from mga11.intel.com ([192.55.52.93]:33632 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728079AbfJGR7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 13:59:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 10:59:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="193161257"
Received: from unknown (HELO labuser-Ice-Lake-Client-Platform.jf.intel.com) ([10.54.55.65])
  by fmsmga007.fm.intel.com with ESMTP; 07 Oct 2019 10:59:54 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org, ak@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 01/10] perf/core, x86: Add PERF_SAMPLE_LBR_TOS
Date:   Mon,  7 Oct 2019 10:59:01 -0700
Message-Id: <20191007175910.2805-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191007175910.2805-1-kan.liang@linux.intel.com>
References: <20191007175910.2805-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

In LBR call stack mode, the depth of reconstructed LBR call stack limits
to the number of LBR registers. With LBR Top-of-Stack (TOS) information,
perf tool may stitch the stacks of two samples. The reconstructed LBR
call stack can break the HW limitation.

Add a new sample type for LBR TOS.

PEBS record doesn't store TOS information. For single PEBS, TOS can be
directly read from MSR, because the PMI is triggered immediately after
PEBS is written. TOS MSR is still unchanged.
For large PEBS, TOS MSR has stale value. Set -1ULL to indicate that the
TOS information is not available.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/lbr.c     |  9 +++++++++
 include/linux/perf_event.h      |  1 +
 include/uapi/linux/perf_event.h |  4 +++-
 kernel/events/core.c            | 12 ++++++++++++
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index ea54634eabf3..4640ff1c9ecb 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -562,6 +562,7 @@ static void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
 		cpuc->lbr_entries[i].reserved	= 0;
 	}
 	cpuc->lbr_stack.nr = i;
+	cpuc->lbr_stack.tos = tos;
 }
 
 /*
@@ -657,6 +658,7 @@ static void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 		out++;
 	}
 	cpuc->lbr_stack.nr = out;
+	cpuc->lbr_stack.tos = tos;
 }
 
 void intel_pmu_lbr_read(void)
@@ -1097,6 +1099,13 @@ void intel_pmu_store_pebs_lbrs(struct pebs_lbr *lbr)
 	int i;
 
 	cpuc->lbr_stack.nr = x86_pmu.lbr_nr;
+
+	/* Cannot get TOS for large PEBS */
+	if (cpuc->n_pebs == cpuc->n_large_pebs)
+		cpuc->lbr_stack.tos = -1ULL;
+	else
+		cpuc->lbr_stack.tos = intel_pmu_lbr_tos();
+
 	for (i = 0; i < x86_pmu.lbr_nr; i++) {
 		u64 info = lbr->lbr[i].info;
 		struct perf_branch_entry *e = &cpuc->lbr_entries[i];
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 61448c19a132..ee9ef0c4cb08 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -100,6 +100,7 @@ struct perf_raw_record {
  */
 struct perf_branch_stack {
 	__u64				nr;
+	__u64				tos;
 	struct perf_branch_entry	entries[0];
 };
 
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index bb7b271397a6..fe36ebb7dc2e 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
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
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 275eae05af20..6ab0913c7b36 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6468,6 +6468,15 @@ void perf_output_sample(struct perf_output_handle *handle,
 	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
 		perf_output_put(handle, data->phys_addr);
 
+	if (sample_type & PERF_SAMPLE_LBR_TOS) {
+		u64 tos = -1ULL;
+
+		if (data->br_stack)
+			tos = data->br_stack->tos;
+
+		perf_output_put(handle, tos);
+	}
+
 	if (!event->attr.watermark) {
 		int wakeup_events = event->attr.wakeup_events;
 
@@ -6656,6 +6665,9 @@ void perf_prepare_sample(struct perf_event_header *header,
 
 	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
 		data->phys_addr = perf_virt_to_phys(data->addr);
+
+	if (sample_type & PERF_SAMPLE_LBR_TOS)
+		header->size += sizeof(u64);
 }
 
 static __always_inline int
-- 
2.17.1

