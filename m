Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CA8C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F92206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfDCKmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:42:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39109 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbfDCKmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 06:42:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x33AfTj91812320
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Apr 2019 03:41:29 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x33AfS1x1812314;
        Wed, 3 Apr 2019 03:41:28 -0700
Date:   Wed, 3 Apr 2019 03:41:28 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Lendacky, Thomas" <tipbot@zytor.com>
Message-ID: <tip-914123fa39042e651d79eaf86bbf63a1b938dddf@git.kernel.org>
Cc:     thomas.lendacky@amd.com, eranian@google.com, hpa@zytor.com,
        tglx@linutronix.de, acme@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        Thomas.Lendacky@amd.com, bp@alien8.de,
        torvalds@linux-foundation.org, mingo@kernel.org,
        vincent.weaver@maine.edu, acme@kernel.org
Reply-To: namhyung@kernel.org, peterz@infradead.org,
          alexander.shishkin@linux.intel.com, jolsa@redhat.com,
          hpa@zytor.com, eranian@google.com, thomas.lendacky@amd.com,
          linux-kernel@vger.kernel.org, acme@redhat.com,
          tglx@linutronix.de, acme@kernel.org, bp@alien8.de,
          Thomas.Lendacky@amd.com, vincent.weaver@maine.edu,
          torvalds@linux-foundation.org, mingo@kernel.org
In-Reply-To: <Message-ID:>
References: <Message-ID:>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] x86/perf/amd: Resolve race condition when
 disabling PMC
Git-Commit-ID: 914123fa39042e651d79eaf86bbf63a1b938dddf
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

Commit-ID:  914123fa39042e651d79eaf86bbf63a1b938dddf
Gitweb:     https://git.kernel.org/tip/914123fa39042e651d79eaf86bbf63a1b938dddf
Author:     Lendacky, Thomas <Thomas.Lendacky@amd.com>
AuthorDate: Tue, 2 Apr 2019 15:21:14 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 3 Apr 2019 11:40:32 +0200

x86/perf/amd: Resolve race condition when disabling PMC

On AMD processors, the detection of an overflowed counter in the NMI
handler relies on the current value of the counter. So, for example, to
check for overflow on a 48 bit counter, bit 47 is checked to see if it
is 1 (not overflowed) or 0 (overflowed).

There is currently a race condition present when disabling and then
updating the PMC. Increased NMI latency in newer AMD processors makes this
race condition more pronounced. If the counter value has overflowed, it is
possible to update the PMC value before the NMI handler can run. The
updated PMC value is not an overflowed value, so when the perf NMI handler
does run, it will not find an overflowed counter. This may appear as an
unknown NMI resulting in either a panic or a series of messages, depending
on how the kernel is configured.

To eliminate this race condition, the PMC value must be checked after
disabling the counter. Add an AMD function, amd_pmu_disable_all(), that
will wait for the NMI handler to reset any active and overflowed counter
after calling x86_pmu_disable_all().

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
 arch/x86/events/amd/core.c | 65 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 7d2d7c801dba..c09ee88b0eed 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -3,6 +3,7 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
 #include <asm/apicdef.h>
 
 #include "../perf_event.h"
@@ -429,6 +430,64 @@ static void amd_pmu_cpu_dead(int cpu)
 	}
 }
 
+/*
+ * When a PMC counter overflows, an NMI is used to process the event and
+ * reset the counter. NMI latency can result in the counter being updated
+ * before the NMI can run, which can result in what appear to be spurious
+ * NMIs. This function is intended to wait for the NMI to run and reset
+ * the counter to avoid possible unhandled NMI messages.
+ */
+#define OVERFLOW_WAIT_COUNT	50
+
+static void amd_pmu_wait_on_overflow(int idx)
+{
+	unsigned int i;
+	u64 counter;
+
+	/*
+	 * Wait for the counter to be reset if it has overflowed. This loop
+	 * should exit very, very quickly, but just in case, don't wait
+	 * forever...
+	 */
+	for (i = 0; i < OVERFLOW_WAIT_COUNT; i++) {
+		rdmsrl(x86_pmu_event_addr(idx), counter);
+		if (counter & (1ULL << (x86_pmu.cntval_bits - 1)))
+			break;
+
+		/* Might be in IRQ context, so can't sleep */
+		udelay(1);
+	}
+}
+
+static void amd_pmu_disable_all(void)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	int idx;
+
+	x86_pmu_disable_all();
+
+	/*
+	 * This shouldn't be called from NMI context, but add a safeguard here
+	 * to return, since if we're in NMI context we can't wait for an NMI
+	 * to reset an overflowed counter value.
+	 */
+	if (in_nmi())
+		return;
+
+	/*
+	 * Check each counter for overflow and wait for it to be reset by the
+	 * NMI if it has overflowed. This relies on the fact that all active
+	 * counters are always enabled when this function is caled and
+	 * ARCH_PERFMON_EVENTSEL_INT is always set.
+	 */
+	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
+		if (!test_bit(idx, cpuc->active_mask))
+			continue;
+
+		amd_pmu_wait_on_overflow(idx);
+	}
+}
+
 static struct event_constraint *
 amd_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 			  struct perf_event *event)
@@ -622,7 +681,7 @@ static ssize_t amd_event_sysfs_show(char *page, u64 config)
 static __initconst const struct x86_pmu amd_pmu = {
 	.name			= "AMD",
 	.handle_irq		= x86_pmu_handle_irq,
-	.disable_all		= x86_pmu_disable_all,
+	.disable_all		= amd_pmu_disable_all,
 	.enable_all		= x86_pmu_enable_all,
 	.enable			= x86_pmu_enable_event,
 	.disable		= x86_pmu_disable_event,
@@ -732,7 +791,7 @@ void amd_pmu_enable_virt(void)
 	cpuc->perf_ctr_virt_mask = 0;
 
 	/* Reload all events */
-	x86_pmu_disable_all();
+	amd_pmu_disable_all();
 	x86_pmu_enable_all(0);
 }
 EXPORT_SYMBOL_GPL(amd_pmu_enable_virt);
@@ -750,7 +809,7 @@ void amd_pmu_disable_virt(void)
 	cpuc->perf_ctr_virt_mask = AMD64_EVENTSEL_HOSTONLY;
 
 	/* Reload all events */
-	x86_pmu_disable_all();
+	amd_pmu_disable_all();
 	x86_pmu_enable_all(0);
 }
 EXPORT_SYMBOL_GPL(amd_pmu_disable_virt);
