Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AD9C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B0F20856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731450AbfDBTsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:48:35 -0400
Received: from mga05.intel.com ([192.55.52.43]:54561 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731217AbfDBTrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:47:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Apr 2019 12:47:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,301,1549958400"; 
   d="scan'208";a="130892978"
Received: from otc-icl-cdi187.jf.intel.com ([10.54.55.103])
  by orsmga008.jf.intel.com with ESMTP; 02 Apr 2019 12:47:47 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V5 06/12] perf/x86/lbr: Avoid reading the LBRs when adaptive PEBS handles them
Date:   Tue,  2 Apr 2019 12:45:03 -0700
Message-Id: <20190402194509.2832-7-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190402194509.2832-1-kan.liang@linux.intel.com>
References: <20190402194509.2832-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

With adaptive PEBS the CPU can directly supply the LBR information,
so we don't need to read it again. But the LBRs still need to be
enabled. Add a special count to the cpuc that distinguishes these
two cases, and avoid reading the LBRs unnecessarily when PEBS is
active.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V4.

 arch/x86/events/intel/lbr.c  | 13 ++++++++++++-
 arch/x86/events/perf_event.h |  1 +
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 07b7175fc378..6f814a27416b 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -488,6 +488,8 @@ void intel_pmu_lbr_add(struct perf_event *event)
 	 * be 'new'. Conversely, a new event can get installed through the
 	 * context switch path for the first time.
 	 */
+	if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip > 0)
+		cpuc->lbr_pebs_users++;
 	perf_sched_cb_inc(event->ctx->pmu);
 	if (!cpuc->lbr_users++ && !event->total_time_running)
 		intel_pmu_lbr_reset();
@@ -507,8 +509,11 @@ void intel_pmu_lbr_del(struct perf_event *event)
 		task_ctx->lbr_callstack_users--;
 	}
 
+	if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip > 0)
+		cpuc->lbr_pebs_users--;
 	cpuc->lbr_users--;
 	WARN_ON_ONCE(cpuc->lbr_users < 0);
+	WARN_ON_ONCE(cpuc->lbr_pebs_users < 0);
 	perf_sched_cb_dec(event->ctx->pmu);
 }
 
@@ -658,7 +663,13 @@ void intel_pmu_lbr_read(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	if (!cpuc->lbr_users)
+	/*
+	 * Don't read when all LBRs users are using adaptive PEBS.
+	 *
+	 * This could be smarter and actually check the event,
+	 * but this simple approach seems to work for now.
+	 */
+	if (!cpuc->lbr_users || cpuc->lbr_users == cpuc->lbr_pebs_users)
 		return;
 
 	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_32)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index d95014f88ef7..089c38e3d2bf 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -234,6 +234,7 @@ struct cpu_hw_events {
 	 * Intel LBR bits
 	 */
 	int				lbr_users;
+	int				lbr_pebs_users;
 	struct perf_branch_stack	lbr_stack;
 	struct perf_branch_entry	lbr_entries[MAX_LBR_ENTRIES];
 	struct er_account		*lbr_sel;
-- 
2.17.1

