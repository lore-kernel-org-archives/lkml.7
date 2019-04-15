Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34537C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8073218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355760;
	bh=KPYYhPZqSI/FP4Dxd7uiGmGTlPzzp5DZCgYuGDd8qOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eJa2FO1I8EgcZg3n8JOq9CzfAcVlA66hkIiZd4YfH1nemMKHyxu1ij7WQZCiRI7Rt
	 E2J2/6K0kIkOnyy2QIF50L9gDmOhM81V7ZdNq8RP8HYsMl/y2NU3xWt61pEHs9Hl3X
	 pjU55h+YcHSmynO++eBS++9zF3d9ugbaxCP+oPY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731534AbfDOTP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:15:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731602AbfDOTNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:13:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 157C62073F;
        Mon, 15 Apr 2019 19:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355619;
        bh=KPYYhPZqSI/FP4Dxd7uiGmGTlPzzp5DZCgYuGDd8qOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=05YymcI8CEzjfal8PuoByjk0vRWueI0pIm75zTzF3h90cEzsOb1VkFRcdQ/Gl/wR7
         OIuOTSHit+DhklulGnlyE52fkhCY4KhMkOfh/h8O82PIQE/7UJD0ifunjvoaNw/UCK
         8j1X6Ad/UwrNEp5P16ohQ/GN8eDrbmnLl0uqS1oc=
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
Subject: [PATCH 5.0 104/117] x86/perf/amd: Resolve NMI latency issues for active PMCs
Date:   Mon, 15 Apr 2019 21:01:14 +0200
Message-Id: <20190415183750.053850462@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lendacky, Thomas <Thomas.Lendacky@amd.com>

commit 6d3edaae16c6c7d238360f2841212c2b26774d5e upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/events/amd/core.c |   56 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

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
@@ -680,7 +734,7 @@ static ssize_t amd_event_sysfs_show(char
 
 static __initconst const struct x86_pmu amd_pmu = {
 	.name			= "AMD",
-	.handle_irq		= x86_pmu_handle_irq,
+	.handle_irq		= amd_pmu_handle_irq,
 	.disable_all		= amd_pmu_disable_all,
 	.enable_all		= x86_pmu_enable_all,
 	.enable			= x86_pmu_enable_event,


