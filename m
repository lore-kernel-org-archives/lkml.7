Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5939FC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 22:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33BF821874
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 22:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfE1WJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 18:09:17 -0400
Received: from mga01.intel.com ([192.55.52.88]:11133 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbfE1WJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 18:09:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 15:09:15 -0700
X-ExtLoop1: 1
Received: from otc-lr-04.jf.intel.com ([10.54.39.157])
  by orsmga002.jf.intel.com with ESMTP; 28 May 2019 15:09:15 -0700
From:   kan.liang@linux.intel.com
To:     mingo@kernel.org, acme@redhat.com, peterz@infradead.org,
        vincent.weaver@maine.edu, linux-kernel@vger.kernel.org
Cc:     alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        jolsa@redhat.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 4/5] perf/x86: Clean up pebs_no_xmm_regs
Date:   Tue, 28 May 2019 15:08:33 -0700
Message-Id: <1559081314-9714-4-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559081314-9714-1-git-send-email-kan.liang@linux.intel.com>
References: <1559081314-9714-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Don't need pebs_no_xmm_regs anymore. The capabilities
PERF_PMU_CAP_EXTENDED_REGS can be used to check if XMM registers
collection is supported.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

New for V3

 arch/x86/events/core.c       | 2 +-
 arch/x86/events/intel/ds.c   | 6 ++----
 arch/x86/events/perf_event.h | 3 +--
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 7708a6f..52a9746 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -568,7 +568,7 @@ int x86_pmu_hw_config(struct perf_event *event)
 	 * be collected in PEBS on some platforms, e.g. Icelake
 	 */
 	if (unlikely(event->attr.sample_regs_intr & PERF_REG_EXTENDED_MASK)) {
-		if (x86_pmu.pebs_no_xmm_regs)
+		if (!(event->pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS))
 			return -EINVAL;
 
 		if (!event->attr.precise_ip)
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index e6a0fa9..53f9dc5 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1964,10 +1964,9 @@ void __init intel_ds_init(void)
 	x86_pmu.bts  = boot_cpu_has(X86_FEATURE_BTS);
 	x86_pmu.pebs = boot_cpu_has(X86_FEATURE_PEBS);
 	x86_pmu.pebs_buffer_size = PEBS_BUFFER_SIZE;
-	if (x86_pmu.version <= 4) {
+	if (x86_pmu.version <= 4)
 		x86_pmu.pebs_no_isolation = 1;
-		x86_pmu.pebs_no_xmm_regs = 1;
-	}
+
 	if (x86_pmu.pebs) {
 		char pebs_type = x86_pmu.intel_cap.pebs_trap ?  '+' : '-';
 		char *pebs_qual = "";
@@ -2023,7 +2022,6 @@ void __init intel_ds_init(void)
 				x86_get_pmu()->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
 			} else {
 				/* Only basic record supported */
-				x86_pmu.pebs_no_xmm_regs = 1;
 				x86_pmu.large_pebs_flags &=
 					~(PERF_SAMPLE_ADDR |
 					  PERF_SAMPLE_TIME |
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index d3b6e90..4e34685 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -650,8 +650,7 @@ struct x86_pmu {
 			pebs_broken		:1,
 			pebs_prec_dist		:1,
 			pebs_no_tlb		:1,
-			pebs_no_isolation	:1,
-			pebs_no_xmm_regs	:1;
+			pebs_no_isolation	:1;
 	int		pebs_record_size;
 	int		pebs_buffer_size;
 	int		max_pebs_events;
-- 
2.7.4

