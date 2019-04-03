Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1721C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEEAB2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfDCKnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:43:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47247 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfDCKnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 06:43:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x33Agph91812992
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Apr 2019 03:42:51 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x33AgooD1812985;
        Wed, 3 Apr 2019 03:42:50 -0700
Date:   Wed, 3 Apr 2019 03:42:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Lendacky, Thomas" <tipbot@zytor.com>
Message-ID: <tip-60f52ab61c7dc0a991125903ae06a35d1812698c@git.kernel.org>
Cc:     acme@redhat.com, hpa@zytor.com, tglx@linutronix.de,
        jolsa@redhat.com, Thomas.Lendacky@amd.com, acme@kernel.org,
        eranian@google.com, vincent.weaver@maine.edu, bp@alien8.de,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, namhyung@kernel.org, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, peterz@infradead.org
Reply-To: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          thomas.lendacky@amd.com, eranian@google.com,
          vincent.weaver@maine.edu, bp@alien8.de, peterz@infradead.org,
          namhyung@kernel.org, alexander.shishkin@linux.intel.com,
          mingo@kernel.org, jolsa@redhat.com, Thomas.Lendacky@amd.com,
          acme@redhat.com, hpa@zytor.com, tglx@linutronix.de,
          acme@kernel.org
In-Reply-To: <Message-ID:>
References: <Message-ID:>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] x86/perf/amd: Remove need to check "running" bit
 in NMI handler
Git-Commit-ID: 60f52ab61c7dc0a991125903ae06a35d1812698c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  60f52ab61c7dc0a991125903ae06a35d1812698c
Gitweb:     https://git.kernel.org/tip/60f52ab61c7dc0a991125903ae06a35d1812698c
Author:     Lendacky, Thomas <Thomas.Lendacky@amd.com>
AuthorDate: Tue, 2 Apr 2019 15:21:18 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 3 Apr 2019 11:40:32 +0200

x86/perf/amd: Remove need to check "running" bit in NMI handler

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
 
