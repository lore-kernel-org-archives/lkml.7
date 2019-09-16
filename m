Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D70C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C852171F
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388033AbfIPNnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 09:43:35 -0400
Received: from mga04.intel.com ([192.55.52.120]:53831 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387856AbfIPNnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 09:43:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 06:43:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,512,1559545200"; 
   d="scan'208";a="387209045"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.84])
  by fmsmga006.fm.intel.com with ESMTP; 16 Sep 2019 06:43:10 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 11/14] perf/x86/intel: Name global status bit in NMI handler
Date:   Mon, 16 Sep 2019 06:41:25 -0700
Message-Id: <20190916134128.18120-12-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190916134128.18120-1-kan.liang@linux.intel.com>
References: <20190916134128.18120-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The bit index number of global status is directly used in current NMI
handler. Using a meaningful name to replace the number to improve the
readability of code.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

New patch for V4

 arch/x86/events/intel/core.c      | 6 +++---
 arch/x86/include/asm/perf_event.h | 7 +++++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index b4b02bd24737..db1337ea0634 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2638,7 +2638,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 	/*
 	 * PEBS overflow sets bit 62 in the global status register
 	 */
-	if (__test_and_clear_bit(62, (unsigned long *)&status)) {
+	if (__test_and_clear_bit(GLOBAL_STATUS_BUFFER_OVF_BIT, (unsigned long *)&status)) {
 		handled++;
 		x86_pmu.drain_pebs(regs);
 		status &= x86_pmu.intel_ctrl | GLOBAL_STATUS_TRACE_TOPAPMI;
@@ -2647,7 +2647,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 	/*
 	 * Intel PT
 	 */
-	if (__test_and_clear_bit(55, (unsigned long *)&status)) {
+	if (__test_and_clear_bit(GLOBAL_STATUS_TRACE_TOPAPMI_BIT, (unsigned long *)&status)) {
 		handled++;
 		if (unlikely(perf_guest_cbs && perf_guest_cbs->is_in_guest() &&
 			perf_guest_cbs->handle_intel_pt_intr))
@@ -2659,7 +2659,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 	/*
 	 * Intel Perf mertrics
 	 */
-	if (__test_and_clear_bit(48, (unsigned long *)&status)) {
+	if (__test_and_clear_bit(GLOBAL_STATUS_PERF_METRICS_OVF_BIT, (unsigned long *)&status)) {
 		handled++;
 		if (x86_pmu.update_topdown_event)
 			x86_pmu.update_topdown_event(NULL);
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 31b96e14935b..d7d3a7caba41 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -210,12 +210,15 @@ static inline bool is_topdown_idx(int idx)
 #define INTEL_PMC_OTHER_TOPDOWN_BITS(bit)	(~(0x1ull << bit) & INTEL_PMC_MSK_TOPDOWN)
 
 #define GLOBAL_STATUS_COND_CHG				BIT_ULL(63)
-#define GLOBAL_STATUS_BUFFER_OVF			BIT_ULL(62)
+#define GLOBAL_STATUS_BUFFER_OVF_BIT			62
+#define GLOBAL_STATUS_BUFFER_OVF			BIT_ULL(GLOBAL_STATUS_BUFFER_OVF_BIT)
 #define GLOBAL_STATUS_UNC_OVF				BIT_ULL(61)
 #define GLOBAL_STATUS_ASIF				BIT_ULL(60)
 #define GLOBAL_STATUS_COUNTERS_FROZEN			BIT_ULL(59)
 #define GLOBAL_STATUS_LBRS_FROZEN			BIT_ULL(58)
-#define GLOBAL_STATUS_TRACE_TOPAPMI			BIT_ULL(55)
+#define GLOBAL_STATUS_TRACE_TOPAPMI_BIT			55
+#define GLOBAL_STATUS_TRACE_TOPAPMI			BIT_ULL(GLOBAL_STATUS_TRACE_TOPAPMI_BIT)
+#define GLOBAL_STATUS_PERF_METRICS_OVF_BIT		48
 
 /*
  * Adaptive PEBS v4
-- 
2.17.1

