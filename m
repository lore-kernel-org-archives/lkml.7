Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76A9C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 19:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3CE62173E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 19:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbfFSTW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 15:22:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:30133 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbfFSTW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 15:22:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 12:22:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,394,1557212400"; 
   d="scan'208";a="358707797"
Received: from otc-icl-cdi-210.jf.intel.com ([10.54.55.28])
  by fmsmga006.fm.intel.com with ESMTP; 19 Jun 2019 12:22:26 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 1/8] perf/x86/intel: Set correct mask for TOPDOWN.SLOTS
Date:   Wed, 19 Jun 2019 12:21:56 -0700
Message-Id: <20190619192203.3885-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190619192203.3885-1-kan.liang@linux.intel.com>
References: <20190619192203.3885-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

TOPDOWN.SLOTS(0x0400) is not a generic event. It is only available on
fixed counter3.

Don't extend its mask to generic counters.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

New for V2

 arch/x86/events/intel/core.c      | 6 ++++--
 arch/x86/include/asm/perf_event.h | 5 +++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 4377bf6a6f82..f30d02830921 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5066,12 +5066,14 @@ __init int intel_pmu_init(void)
 
 	if (x86_pmu.event_constraints) {
 		/*
-		 * event on fixed counter2 (REF_CYCLES) only works on this
+		 * event on fixed counter2 (REF_CYCLES) and
+		 * fixed counter3 (TOPDOWN.SLOTS) only work on this
 		 * counter, so do not extend mask to generic counters
 		 */
 		for_each_event_constraint(c, x86_pmu.event_constraints) {
 			if (c->cmask == FIXED_EVENT_FLAGS
-			    && c->idxmsk64 != INTEL_PMC_MSK_FIXED_REF_CYCLES) {
+			    && c->idxmsk64 != INTEL_PMC_MSK_FIXED_REF_CYCLES
+			    && c->idxmsk64 != INTEL_PMC_MSK_FIXED_SLOTS) {
 				c->idxmsk64 |= (1ULL << x86_pmu.num_counters) - 1;
 			}
 			c->idxmsk64 &=
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 1392d5e6e8d6..457d35a75ad3 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -167,6 +167,11 @@ struct x86_pmu_capability {
 #define INTEL_PMC_IDX_FIXED_REF_CYCLES	(INTEL_PMC_IDX_FIXED + 2)
 #define INTEL_PMC_MSK_FIXED_REF_CYCLES	(1ULL << INTEL_PMC_IDX_FIXED_REF_CYCLES)
 
+/* TOPDOWN.SLOTS: */
+#define MSR_ARCH_PERFMON_FIXED_CTR3	0x30c
+#define INTEL_PMC_IDX_FIXED_SLOTS	(INTEL_PMC_IDX_FIXED + 3)
+#define INTEL_PMC_MSK_FIXED_SLOTS	(1ULL << INTEL_PMC_IDX_FIXED_SLOTS)
+
 /*
  * We model BTS tracing as another fixed-mode PMC.
  *
-- 
2.14.5

