Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A26C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1816206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfDCKmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:42:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42221 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDCKml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 06:42:41 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x33AgAO71812704
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Apr 2019 03:42:10 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x33Ag9NH1812698;
        Wed, 3 Apr 2019 03:42:09 -0700
Date:   Wed, 3 Apr 2019 03:42:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Lendacky, Thomas" <tipbot@zytor.com>
Message-ID: <tip-6d3edaae16c6c7d238360f2841212c2b26774d5e@git.kernel.org>
Cc:     bp@alien8.de, hpa@zytor.com, acme@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, eranian@google.com,
        Thomas.Lendacky@amd.com, thomas.lendacky@amd.com, mingo@kernel.org,
        vincent.weaver@maine.edu, namhyung@kernel.org,
        torvalds@linux-foundation.org, peterz@infradead.org,
        acme@kernel.org, jolsa@redhat.com
Reply-To: acme@kernel.org, jolsa@redhat.com, peterz@infradead.org,
          torvalds@linux-foundation.org, namhyung@kernel.org,
          mingo@kernel.org, vincent.weaver@maine.edu,
          thomas.lendacky@amd.com, Thomas.Lendacky@amd.com,
          eranian@google.com, alexander.shishkin@linux.intel.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          acme@redhat.com, hpa@zytor.com, bp@alien8.de
In-Reply-To: <Message-ID:>
References: <Message-ID:>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] x86/perf/amd: Resolve NMI latency issues for
 active PMCs
Git-Commit-ID: 6d3edaae16c6c7d238360f2841212c2b26774d5e
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

Commit-ID:  6d3edaae16c6c7d238360f2841212c2b26774d5e
Gitweb:     https://git.kernel.org/tip/6d3edaae16c6c7d238360f2841212c2b26774d5e
Author:     Lendacky, Thomas <Thomas.Lendacky@amd.com>
AuthorDate: Tue, 2 Apr 2019 15:21:16 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 3 Apr 2019 11:40:32 +0200

x86/perf/amd: Resolve NMI latency issues for active PMCs

On AMD processors, the detection of an overflowed PMC counter in the NMI
handler relies on the current value of the PMC. So, for example, to check
for overflow on a 48-bit counter, bit 47 is checked to see if it is 1 (not
overflowed) or 0 (overflowed).

When the perf NMI handler executes it does not know in advance which PMC
counters have overflowed. As such, the NMI handler will process all active
PMC counters that have overflowed. NMI latency in newer AMD processors can
result in multiple overflowed PMC counters being processed in one NMI and
then a subsequent NMI, that does not appear to be a back-to-back NMI, not
finding any PMC counters that have overflowed. This may appear to be an
unhandled NMI resulting in either a panic or a series of messages,
depending on how the kernel was configured.

To mitigate this issue, add an AMD handle_irq callback function,
amd_pmu_handle_irq(), that will invoke the common x86_pmu_handle_irq()
function and upon return perform some additional processing that will
indicate if the NMI has been handled or would have been handled had an
earlier NMI not handled the overflowed PMC. Using a per-CPU variable, a
minimum value of the number of active PMCs or 2 will be set whenever a
PMC is active. This is used to indicate the possible number of NMIs that
can still occur. The value of 2 is used for when an NMI does not arrive
at the LAPIC in time to be collapsed into an already pending NMI. Each
time the function is called without having handled an overflowed counter,
the per-CPU value is checked. If the value is non-zero, it is decremented
and the NMI indicates that it handled the NMI. If the value is zero, then
the NMI indicates that it did not handle the NMI.

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
 arch/x86/events/amd/core.c | 56 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index c09ee88b0eed..34c191453ce3 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -4,10 +4,13 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/nmi.h>
 #include <asm/apicdef.h>
 
 #include "../perf_event.h"
 
+static DEFINE_PER_CPU(unsigned int, perf_nmi_counter);
+
 static __initconst const u64 amd_hw_cache_event_ids
 				[PERF_COUNT_HW_CACHE_MAX]
 				[PERF_COUNT_HW_CACHE_OP_MAX]
@@ -488,6 +491,57 @@ static void amd_pmu_disable_all(void)
 	}
 }
 
+/*
+ * Because of NMI latency, if multiple PMC counters are active or other sources
+ * of NMIs are received, the perf NMI handler can handle one or more overflowed
+ * PMC counters outside of the NMI associated with the PMC overflow. If the NMI
+ * doesn't arrive at the LAPIC in time to become a pending NMI, then the kernel
+ * back-to-back NMI support won't be active. This PMC handler needs to take into
+ * account that this can occur, otherwise this could result in unknown NMI
+ * messages being issued. Examples of this is PMC overflow while in the NMI
+ * handler when multiple PMCs are active or PMC overflow while handling some
+ * other source of an NMI.
+ *
+ * Attempt to mitigate this by using the number of active PMCs to determine
+ * whether to return NMI_HANDLED if the perf NMI handler did not handle/reset
+ * any PMCs. The per-CPU perf_nmi_counter variable is set to a minimum of the
+ * number of active PMCs or 2. The value of 2 is used in case an NMI does not
+ * arrive at the LAPIC in time to be collapsed into an already pending NMI.
+ */
+static int amd_pmu_handle_irq(struct pt_regs *regs)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	int active, handled;
+
+	/*
+	 * Obtain the active count before calling x86_pmu_handle_irq() since
+	 * it is possible that x86_pmu_handle_irq() may make a counter
+	 * inactive (through x86_pmu_stop).
+	 */
+	active = __bitmap_weight(cpuc->active_mask, X86_PMC_IDX_MAX);
+
+	/* Process any counter overflows */
+	handled = x86_pmu_handle_irq(regs);
+
+	/*
+	 * If a counter was handled, record the number of possible remaining
+	 * NMIs that can occur.
+	 */
+	if (handled) {
+		this_cpu_write(perf_nmi_counter,
+			       min_t(unsigned int, 2, active));
+
+		return handled;
+	}
+
+	if (!this_cpu_read(perf_nmi_counter))
+		return NMI_DONE;
+
+	this_cpu_dec(perf_nmi_counter);
+
+	return NMI_HANDLED;
+}
+
 static struct event_constraint *
 amd_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 			  struct perf_event *event)
@@ -680,7 +734,7 @@ static ssize_t amd_event_sysfs_show(char *page, u64 config)
 
 static __initconst const struct x86_pmu amd_pmu = {
 	.name			= "AMD",
-	.handle_irq		= x86_pmu_handle_irq,
+	.handle_irq		= amd_pmu_handle_irq,
 	.disable_all		= amd_pmu_disable_all,
 	.enable_all		= x86_pmu_enable_all,
 	.enable			= x86_pmu_enable_event,
