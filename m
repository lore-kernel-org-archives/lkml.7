Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D45C282CE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E977A20818
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555079004;
	bh=Fc/J0DaiXJ6eKFZsqOTqPq+h1GGAjej4uodIivPt32o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nEsC4WgJkIQrA60Eb8Bae0Ae/Rxc9WqUpMS0UQQIfMxW56US9Orz6LB/E5p7jY/vV
	 uUWyxZAORhTMl4Tuoc6sYmj+gV46+h9JWelF20fzuJWJ5CehtDJCDhIUS8XnbY2qAZ
	 LFe45rfILaN5ZOUPNwe7kE8qmA3IoOw4nE15l6Ls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfDLOXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:23:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbfDLOXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:23:20 -0400
Received: from quaco.ghostprotocols.net (177-58-174-75.3g.claro.net.br [177.58.174.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0003221904;
        Fri, 12 Apr 2019 14:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555078999;
        bh=Fc/J0DaiXJ6eKFZsqOTqPq+h1GGAjej4uodIivPt32o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kWfu9+osAC1bem2YdHLHLCzLv4FepkXgoTev/HzbIhwXvsskQS+x5G0KJWn3MG6Yw
         EqnVkF51YHKNBorizwgprgBRn0mBDrByVPZsN4ZxEWWIf4DTYSMIiHAh5wL7Dt/8Qm
         Wgidw4zw5pZSXVC/cWE3OkMm4v6o0fn1t4LMOlAs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Peter Zijlstra <peterz@infradead.org>, stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Vince Weaver <vincent.weaver@maine.edu>
Subject: [PATCH 1/7] x86/perf/amd: Remove need to check "running" bit in NMI handler
Date:   Fri, 12 Apr 2019 11:22:44 -0300
Message-Id: <20190412142250.20595-2-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190412142250.20595-1-acme@kernel.org>
References: <20190412142250.20595-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>

Spurious interrupt support was adding to perf in:
commit 63e6be6d98e1 ("perf, x86: Catch spurious interrupts after disabling counters")

The two previous patches (resolving the race condition when disabling a
PMC and NMI latency mitigation) allow for the removal of this older
spurious interrupt support.

Currently in x86_pmu_stop(), the bit for the PMC in the active_mask bitmap
is cleared before disabling the PMC, which sets up a race condition. This
race condition was mitigated by introducing the running bitmap. That race
condition can be eliminated by first disabling the PMC, waiting for PMC
reset on overflow and then clearing the bit for the PMC in the active_mask
bitmap. The NMI handler will not re-enable a disabled counter.

If x86_pmu_stop() is called from the perf NMI handler, the NMI latency
mitigation support will guard against any unhandled NMI messages.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <stable@vger.kernel.org> # 4.14.x-
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: https://lkml.kernel.org/r/Message-ID:
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 arch/x86/events/amd/core.c | 19 ++++++++++++++++++-
 arch/x86/events/core.c     | 13 +++----------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 34c191453ce3..5d423653f744 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -491,6 +491,23 @@ static void amd_pmu_disable_all(void)
 	}
 }
 
+static void amd_pmu_disable_event(struct perf_event *event)
+{
+	x86_pmu_disable_event(event);
+
+	/*
+	 * This can be called from NMI context (via x86_pmu_stop). The counter
+	 * may have overflowed, but either way, we'll never see it get reset
+	 * by the NMI if we're already in the NMI. And the NMI latency support
+	 * below will take care of any pending NMI that might have been
+	 * generated by the overflow.
+	 */
+	if (in_nmi())
+		return;
+
+	amd_pmu_wait_on_overflow(event->hw.idx);
+}
+
 /*
  * Because of NMI latency, if multiple PMC counters are active or other sources
  * of NMIs are received, the perf NMI handler can handle one or more overflowed
@@ -738,7 +755,7 @@ static __initconst const struct x86_pmu amd_pmu = {
 	.disable_all		= amd_pmu_disable_all,
 	.enable_all		= x86_pmu_enable_all,
 	.enable			= x86_pmu_enable_event,
-	.disable		= x86_pmu_disable_event,
+	.disable		= amd_pmu_disable_event,
 	.hw_config		= amd_pmu_hw_config,
 	.schedule_events	= x86_schedule_events,
 	.eventsel		= MSR_K7_EVNTSEL0,
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index e2b1447192a8..81911e11a15d 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1349,8 +1349,9 @@ void x86_pmu_stop(struct perf_event *event, int flags)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct hw_perf_event *hwc = &event->hw;
 
-	if (__test_and_clear_bit(hwc->idx, cpuc->active_mask)) {
+	if (test_bit(hwc->idx, cpuc->active_mask)) {
 		x86_pmu.disable(event);
+		__clear_bit(hwc->idx, cpuc->active_mask);
 		cpuc->events[hwc->idx] = NULL;
 		WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
 		hwc->state |= PERF_HES_STOPPED;
@@ -1447,16 +1448,8 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 
 	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
-		if (!test_bit(idx, cpuc->active_mask)) {
-			/*
-			 * Though we deactivated the counter some cpus
-			 * might still deliver spurious interrupts still
-			 * in flight. Catch them:
-			 */
-			if (__test_and_clear_bit(idx, cpuc->running))
-				handled++;
+		if (!test_bit(idx, cpuc->active_mask))
 			continue;
-		}
 
 		event = cpuc->events[idx];
 
-- 
2.20.1

