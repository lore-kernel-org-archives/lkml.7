Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C1BC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA75C21848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731446AbfJINAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 09:00:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50929 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731335AbfJIM7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 08:59:35 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iIBYo-0002oe-PV; Wed, 09 Oct 2019 14:59:22 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5DEB81C026C;
        Wed,  9 Oct 2019 14:59:19 +0200 (CEST)
Date:   Wed, 09 Oct 2019 12:59:19 -0000
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/amd: Change/fix NMI latency mitigation to
 use a timestamp
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157062595932.9978.12198303438251229144.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     df4d29732fdad43a51284f826bec3e6ded177540
Gitweb:        https://git.kernel.org/tip/df4d29732fdad43a51284f826bec3e6ded177540
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Thu, 01 Aug 2019 18:57:41 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 09 Oct 2019 12:44:14 +02:00

perf/x86/amd: Change/fix NMI latency mitigation to use a timestamp

It turns out that the NMI latency workaround from commit:

  6d3edaae16c6 ("x86/perf/amd: Resolve NMI latency issues for active PMCs")

ends up being too conservative and results in the perf NMI handler claiming
NMIs too easily on AMD hardware when the NMI watchdog is active.

This has an impact, for example, on the hpwdt (HPE watchdog timer) module.
This module can produce an NMI that is used to reset the system. It
registers an NMI handler for the NMI_UNKNOWN type and relies on the fact
that nothing has claimed an NMI so that its handler will be invoked when
the watchdog device produces an NMI. After the referenced commit, the
hpwdt module is unable to process its generated NMI if the NMI watchdog is
active, because the current NMI latency mitigation results in the NMI
being claimed by the perf NMI handler.

Update the AMD perf NMI latency mitigation workaround to, instead, use a
window of time. Whenever a PMC is handled in the perf NMI handler, set a
timestamp which will act as a perf NMI window. Any NMIs arriving within
that window will be claimed by perf. Anything outside that window will
not be claimed by perf. The value for the NMI window is set to 100 msecs.
This is a conservative value that easily covers any NMI latency in the
hardware. While this still results in a window in which the hpwdt module
will not receive its NMI, the window is now much, much smaller.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 6d3edaae16c6 ("x86/perf/amd: Resolve NMI latency issues for active PMCs")
Link: https://lkml.kernel.org/r/Message-ID:
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/amd/core.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index e7d35f6..64c3e70 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -5,12 +5,14 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/jiffies.h>
 #include <asm/apicdef.h>
 #include <asm/nmi.h>
 
 #include "../perf_event.h"
 
-static DEFINE_PER_CPU(unsigned int, perf_nmi_counter);
+static DEFINE_PER_CPU(unsigned long, perf_nmi_tstamp);
+static unsigned long perf_nmi_window;
 
 static __initconst const u64 amd_hw_cache_event_ids
 				[PERF_COUNT_HW_CACHE_MAX]
@@ -641,11 +643,12 @@ static void amd_pmu_disable_event(struct perf_event *event)
  * handler when multiple PMCs are active or PMC overflow while handling some
  * other source of an NMI.
  *
- * Attempt to mitigate this by using the number of active PMCs to determine
- * whether to return NMI_HANDLED if the perf NMI handler did not handle/reset
- * any PMCs. The per-CPU perf_nmi_counter variable is set to a minimum of the
- * number of active PMCs or 2. The value of 2 is used in case an NMI does not
- * arrive at the LAPIC in time to be collapsed into an already pending NMI.
+ * Attempt to mitigate this by creating an NMI window in which un-handled NMIs
+ * received during this window will be claimed. This prevents extending the
+ * window past when it is possible that latent NMIs should be received. The
+ * per-CPU perf_nmi_tstamp will be set to the window end time whenever perf has
+ * handled a counter. When an un-handled NMI is received, it will be claimed
+ * only if arriving within that window.
  */
 static int amd_pmu_handle_irq(struct pt_regs *regs)
 {
@@ -663,21 +666,19 @@ static int amd_pmu_handle_irq(struct pt_regs *regs)
 	handled = x86_pmu_handle_irq(regs);
 
 	/*
-	 * If a counter was handled, record the number of possible remaining
-	 * NMIs that can occur.
+	 * If a counter was handled, record a timestamp such that un-handled
+	 * NMIs will be claimed if arriving within that window.
 	 */
 	if (handled) {
-		this_cpu_write(perf_nmi_counter,
-			       min_t(unsigned int, 2, active));
+		this_cpu_write(perf_nmi_tstamp,
+			       jiffies + perf_nmi_window);
 
 		return handled;
 	}
 
-	if (!this_cpu_read(perf_nmi_counter))
+	if (time_after(jiffies, this_cpu_read(perf_nmi_tstamp)))
 		return NMI_DONE;
 
-	this_cpu_dec(perf_nmi_counter);
-
 	return NMI_HANDLED;
 }
 
@@ -909,6 +910,9 @@ static int __init amd_core_pmu_init(void)
 	if (!boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
 		return 0;
 
+	/* Avoid calulating the value each time in the NMI handler */
+	perf_nmi_window = msecs_to_jiffies(100);
+
 	switch (boot_cpu_data.x86) {
 	case 0x15:
 		pr_cont("Fam15h ");
