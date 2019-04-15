Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B536C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B3220651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555356130;
	bh=rxnzBwlkhUzrI6abMQJu/V3EOLM6jm7aXGSvuvpuN+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xqWttLy2Ead1LhFQzTEM0j5wrWsLq3xymCOi0IoFe3mt9zJdY9RXqtsfd9or8nkrS
	 oiQnnkYC/+mpx5AkG3VSKB28aunXe+VrXso8NXnqJaAYOMqr98SCnuRU1pj/e3dL2Q
	 8s8HoCFERMTFfWh5sfI4MOxDnfFhaLoRABw8O3Tk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbfDOTIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:08:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:43944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730479AbfDOTIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:08:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B837218D3;
        Mon, 15 Apr 2019 19:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355309;
        bh=rxnzBwlkhUzrI6abMQJu/V3EOLM6jm7aXGSvuvpuN+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g3BElPWDlVyZ8G6l4GTQ8xNnhMtslJjGrAjHOLTH6is7ve7IJVNK9ZJi0XY23RJiQ
         gsqc+K20V62YlrfMODraCAkKvitXaLqL25A7VUw2bfHHFxIWsDFTbpWNjUJK4XpXP4
         YaFnUuFhSQ2rKrmjYGJdUR/FXVccOyY+6bkq6hL4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.19 090/101] x86/perf/amd: Remove need to check "running" bit in NMI handler
Date:   Mon, 15 Apr 2019 20:59:28 +0200
Message-Id: <20190415183745.134153781@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lendacky, Thomas <Thomas.Lendacky@amd.com>

commit 3966c3feca3fd10b2935caa0b4a08c7dd59469e5 upstream.

Spurious interrupt support was added to perf in the following commit, almost
a decade ago:

  63e6be6d98e1 ("perf, x86: Catch spurious interrupts after disabling counters")

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/events/amd/core.c |   21 +++++++++++++++++++--
 arch/x86/events/core.c     |   13 +++----------
 2 files changed, 22 insertions(+), 12 deletions(-)

--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -4,8 +4,8 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
-#include <linux/nmi.h>
 #include <asm/apicdef.h>
+#include <asm/nmi.h>
 
 #include "../perf_event.h"
 
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
@@ -738,7 +755,7 @@ static __initconst const struct x86_pmu
 	.disable_all		= amd_pmu_disable_all,
 	.enable_all		= x86_pmu_enable_all,
 	.enable			= x86_pmu_enable_event,
-	.disable		= x86_pmu_disable_event,
+	.disable		= amd_pmu_disable_event,
 	.hw_config		= amd_pmu_hw_config,
 	.schedule_events	= x86_schedule_events,
 	.eventsel		= MSR_K7_EVNTSEL0,
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1328,8 +1328,9 @@ void x86_pmu_stop(struct perf_event *eve
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct hw_perf_event *hwc = &event->hw;
 
-	if (__test_and_clear_bit(hwc->idx, cpuc->active_mask)) {
+	if (test_bit(hwc->idx, cpuc->active_mask)) {
 		x86_pmu.disable(event);
+		__clear_bit(hwc->idx, cpuc->active_mask);
 		cpuc->events[hwc->idx] = NULL;
 		WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
 		hwc->state |= PERF_HES_STOPPED;
@@ -1426,16 +1427,8 @@ int x86_pmu_handle_irq(struct pt_regs *r
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
 


