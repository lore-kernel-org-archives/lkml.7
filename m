Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509FEC31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 14:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A3B2147A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 14:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560693870;
	bh=NZ5LZzmV23HmldRkC0rr77iJYMy34boMmdBzx2x+EIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OrGdmY5K1bScGsRsPsC9d42xVTHaTM+9YTssvLM/7s2r/63bjsjLMLsyiIGVczGKJ
	 Zy7ReMEtywRooagQHuVAwjY2sdCUIbJTcJTAH508oJrg9cNBMTFEszT9fsEtTQkNhW
	 2kfw8/b/qD+iZFLmA0nqGbwGwpc4kqBMW+lajpUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfFPOE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 10:04:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727301AbfFPOEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 10:04:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BC811307FBCB;
        Sun, 16 Jun 2019 14:04:24 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-53.brq.redhat.com [10.40.204.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF9958CF9E;
        Sun, 16 Jun 2019 14:04:21 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6/8] perf/x86/rapl: Get msr values from new probe framework
Date:   Sun, 16 Jun 2019 16:03:56 +0200
Message-Id: <20190616140358.27799-7-jolsa@kernel.org>
In-Reply-To: <20190616140358.27799-1-jolsa@kernel.org>
References: <20190616140358.27799-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Sun, 16 Jun 2019 14:04:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to have special code for getting
the bit and msr value for given event. We can
now easily get it from rapl_msrs array.

Also getting rid of RAPL_IDX_*, which is no longer
needed and replacing INTEL_RAPL* with PERF_RAPL*
enums.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/events/intel/rapl.c | 53 ++++++++----------------------------
 1 file changed, 11 insertions(+), 42 deletions(-)

diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index 417de3fdde61..709a749a4ada 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -55,6 +55,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/perf_event.h>
+#include <linux/nospec.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include "../perf_event.h"
@@ -65,19 +66,6 @@ MODULE_LICENSE("GPL");
 /*
  * RAPL energy status counters
  */
-#define RAPL_IDX_PP0_NRG_STAT	0	/* all cores */
-#define INTEL_RAPL_PP0		0x1	/* pseudo-encoding */
-#define RAPL_IDX_PKG_NRG_STAT	1	/* entire package */
-#define INTEL_RAPL_PKG		0x2	/* pseudo-encoding */
-#define RAPL_IDX_RAM_NRG_STAT	2	/* DRAM */
-#define INTEL_RAPL_RAM		0x3	/* pseudo-encoding */
-#define RAPL_IDX_PP1_NRG_STAT	3	/* gpu */
-#define INTEL_RAPL_PP1		0x4	/* pseudo-encoding */
-#define RAPL_IDX_PSYS_NRG_STAT	4	/* psys */
-#define INTEL_RAPL_PSYS		0x5	/* pseudo-encoding */
-
-#define NR_RAPL_DOMAINS         0x5
-
 enum perf_rapl_events {
 	PERF_RAPL_PP0 = 0,		/* all cores */
 	PERF_RAPL_PKG,			/* entire package */
@@ -86,6 +74,7 @@ enum perf_rapl_events {
 	PERF_RAPL_PSYS,			/* psys */
 
 	PERF_RAPL_MAX,
+	NR_RAPL_DOMAINS = PERF_RAPL_MAX,
 };
 
 static const char *const rapl_domain_names[NR_RAPL_DOMAINS] __initconst = {
@@ -149,6 +138,7 @@ static struct rapl_pmus *rapl_pmus;
 static cpumask_t rapl_cpu_mask;
 static unsigned int rapl_cntr_mask;
 static u64 rapl_timer_ms;
+static struct perf_msr rapl_msrs[];
 
 static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
 {
@@ -340,7 +330,7 @@ static void rapl_pmu_event_del(struct perf_event *event, int flags)
 static int rapl_pmu_event_init(struct perf_event *event)
 {
 	u64 cfg = event->attr.config & RAPL_EVENT_MASK;
-	int bit, msr, ret = 0;
+	int bit, ret = 0;
 	struct rapl_pmu *pmu;
 
 	/* only look at RAPL events */
@@ -356,33 +346,12 @@ static int rapl_pmu_event_init(struct perf_event *event)
 
 	event->event_caps |= PERF_EV_CAP_READ_ACTIVE_PKG;
 
-	/*
-	 * check event is known (determines counter)
-	 */
-	switch (cfg) {
-	case INTEL_RAPL_PP0:
-		bit = RAPL_IDX_PP0_NRG_STAT;
-		msr = MSR_PP0_ENERGY_STATUS;
-		break;
-	case INTEL_RAPL_PKG:
-		bit = RAPL_IDX_PKG_NRG_STAT;
-		msr = MSR_PKG_ENERGY_STATUS;
-		break;
-	case INTEL_RAPL_RAM:
-		bit = RAPL_IDX_RAM_NRG_STAT;
-		msr = MSR_DRAM_ENERGY_STATUS;
-		break;
-	case INTEL_RAPL_PP1:
-		bit = RAPL_IDX_PP1_NRG_STAT;
-		msr = MSR_PP1_ENERGY_STATUS;
-		break;
-	case INTEL_RAPL_PSYS:
-		bit = RAPL_IDX_PSYS_NRG_STAT;
-		msr = MSR_PLATFORM_ENERGY_STATUS;
-		break;
-	default:
+	if (!cfg || cfg >= NR_RAPL_DOMAINS + 1)
 		return -EINVAL;
-	}
+
+	cfg = array_index_nospec(cfg, NR_RAPL_DOMAINS + 1);
+	bit = cfg - 1;
+
 	/* check event supported */
 	if (!(rapl_cntr_mask & (1 << bit)))
 		return -EINVAL;
@@ -397,7 +366,7 @@ static int rapl_pmu_event_init(struct perf_event *event)
 		return -EINVAL;
 	event->cpu = pmu->cpu;
 	event->pmu_private = pmu;
-	event->hw.event_base = msr;
+	event->hw.event_base = rapl_msrs[bit].msr;
 	event->hw.config = cfg;
 	event->hw.idx = bit;
 
@@ -705,7 +674,7 @@ static int rapl_check_hw_unit(bool apply_quirk)
 	 * of 2. Datasheet, September 2014, Reference Number: 330784-001 "
 	 */
 	if (apply_quirk)
-		rapl_hw_unit[RAPL_IDX_RAM_NRG_STAT] = 16;
+		rapl_hw_unit[PERF_RAPL_RAM] = 16;
 
 	/*
 	 * Calculate the timer rate:
-- 
2.21.0

