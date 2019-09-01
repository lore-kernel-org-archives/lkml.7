Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D46C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 06:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B712190F
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 06:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbfIAGNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 02:13:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55188 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbfIAGNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 02:13:41 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i4J7K-0007Lq-2V; Sun, 01 Sep 2019 08:13:38 +0200
Date:   Sun, 01 Sep 2019 06:07:33 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] perf/urgent for 5.3-rc7
Message-ID: <156731805398.16551.16721065723173566021.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

up to:  0f4cd769c410: perf/x86/amd/ibs: Fix sample bias for dispatched micro-ops

Two fixes for perf x86 hardware implementations:

    - Restrict the period on Nehalem machines to prevent perf from hogging
      the CPU

    - Prevent the AMD IBS driver from overwriting the hardwre controlled
      and preseeded reserved bits (0-6) in the count register which caused
      a sample bias for dispatched micro-ops.

Thanks,

	tglx

------------------>
Josh Hunt (1):
      perf/x86/intel: Restrict period on Nehalem

Kim Phillips (1):
      perf/x86/amd/ibs: Fix sample bias for dispatched micro-ops


 arch/x86/events/amd/ibs.c         | 13 ++++++++++---
 arch/x86/events/intel/core.c      |  6 ++++++
 arch/x86/include/asm/perf_event.h | 12 ++++++++----
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 62f317c9113a..5b35b7ea5d72 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -661,10 +661,17 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 
 	throttle = perf_event_overflow(event, &data, &regs);
 out:
-	if (throttle)
+	if (throttle) {
 		perf_ibs_stop(event, 0);
-	else
-		perf_ibs_enable_event(perf_ibs, hwc, period >> 4);
+	} else {
+		period >>= 4;
+
+		if ((ibs_caps & IBS_CAPS_RDWROPCNT) &&
+		    (*config & IBS_OP_CNT_CTL))
+			period |= *config & IBS_OP_CUR_CNT_RAND;
+
+		perf_ibs_enable_event(perf_ibs, hwc, period);
+	}
 
 	perf_event_update_userpage(event);
 
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 648260b5f367..e4c2cb65ea50 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3572,6 +3572,11 @@ static u64 bdw_limit_period(struct perf_event *event, u64 left)
 	return left;
 }
 
+static u64 nhm_limit_period(struct perf_event *event, u64 left)
+{
+	return max(left, 32ULL);
+}
+
 PMU_FORMAT_ATTR(event,	"config:0-7"	);
 PMU_FORMAT_ATTR(umask,	"config:8-15"	);
 PMU_FORMAT_ATTR(edge,	"config:18"	);
@@ -4606,6 +4611,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.pebs_constraints = intel_nehalem_pebs_event_constraints;
 		x86_pmu.enable_all = intel_pmu_nhm_enable_all;
 		x86_pmu.extra_regs = intel_nehalem_extra_regs;
+		x86_pmu.limit_period = nhm_limit_period;
 
 		mem_attr = nhm_mem_events_attrs;
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 1392d5e6e8d6..ee26e9215f18 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -252,16 +252,20 @@ struct pebs_lbr {
 #define IBSCTL_LVT_OFFSET_VALID		(1ULL<<8)
 #define IBSCTL_LVT_OFFSET_MASK		0x0F
 
-/* ibs fetch bits/masks */
+/* IBS fetch bits/masks */
 #define IBS_FETCH_RAND_EN	(1ULL<<57)
 #define IBS_FETCH_VAL		(1ULL<<49)
 #define IBS_FETCH_ENABLE	(1ULL<<48)
 #define IBS_FETCH_CNT		0xFFFF0000ULL
 #define IBS_FETCH_MAX_CNT	0x0000FFFFULL
 
-/* ibs op bits/masks */
-/* lower 4 bits of the current count are ignored: */
-#define IBS_OP_CUR_CNT		(0xFFFF0ULL<<32)
+/*
+ * IBS op bits/masks
+ * The lower 7 bits of the current count are random bits
+ * preloaded by hardware and ignored in software
+ */
+#define IBS_OP_CUR_CNT		(0xFFF80ULL<<32)
+#define IBS_OP_CUR_CNT_RAND	(0x0007FULL<<32)
 #define IBS_OP_CNT_CTL		(1ULL<<19)
 #define IBS_OP_VAL		(1ULL<<18)
 #define IBS_OP_ENABLE		(1ULL<<17)


