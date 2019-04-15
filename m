Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12902C282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF2ED20651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555356139;
	bh=UKLIMG4WBw3HBVghBcftB39EWuojo1+j/6tovH03OeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tjdmQBhy5qaKj6skncf0DkF0D8olr+GrsN/f0oDrL2Snep0FJv5xZaei8RyYRjt3h
	 Npeka8KRscHDEMXorauM9oAt1eAcKhrwKC7lyPb19Qf6RAcKvST/1sEngKfflw7l2z
	 BJd1WWVJMgSKYX+BXT5dTwsdWvkzBHCZyWjgy4e0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730867AbfDOTWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:22:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:43802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730459AbfDOTI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:08:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B0AB218A1;
        Mon, 15 Apr 2019 19:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355304;
        bh=UKLIMG4WBw3HBVghBcftB39EWuojo1+j/6tovH03OeE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q5XjYiHEelivAVQHmisLeJMOivB0owP9TjCJ+rBIO4rFbRniNJ0ijviTXhUbIDkaT
         TQoj4/4pVuyWbSmN7hyudfK0/aeMqw2RLce2ByqX22FK2Lv65QRqrVF6ziPVShsB3E
         Rip1euCdJuEx54gOEY8IosyUNCqazHNvob/r3FUA=
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
Subject: [PATCH 4.19 088/101] x86/perf/amd: Resolve race condition when disabling PMC
Date:   Mon, 15 Apr 2019 20:59:26 +0200
Message-Id: <20190415183745.039229139@linuxfoundation.org>
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

commit 914123fa39042e651d79eaf86bbf63a1b938dddf upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/events/amd/core.c |   65 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 3 deletions(-)

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
@@ -622,7 +681,7 @@ static ssize_t amd_event_sysfs_show(char
 static __initconst const struct x86_pmu amd_pmu = {
 	.name			= "AMD",
 	.handle_irq		= x86_pmu_handle_irq,
-	.disable_all		= x86_pmu_disable_all,
+	.disable_all		= amd_pmu_disable_all,
 	.enable_all		= x86_pmu_enable_all,
 	.enable			= x86_pmu_enable_event,
 	.disable		= x86_pmu_disable_event,
@@ -728,7 +787,7 @@ void amd_pmu_enable_virt(void)
 	cpuc->perf_ctr_virt_mask = 0;
 
 	/* Reload all events */
-	x86_pmu_disable_all();
+	amd_pmu_disable_all();
 	x86_pmu_enable_all(0);
 }
 EXPORT_SYMBOL_GPL(amd_pmu_enable_virt);
@@ -746,7 +805,7 @@ void amd_pmu_disable_virt(void)
 	cpuc->perf_ctr_virt_mask = AMD64_EVENTSEL_HOSTONLY;
 
 	/* Reload all events */
-	x86_pmu_disable_all();
+	amd_pmu_disable_all();
 	x86_pmu_enable_all(0);
 }
 EXPORT_SYMBOL_GPL(amd_pmu_disable_virt);


