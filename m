Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D998EC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 10:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9CF4207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 10:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfK0K2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 05:28:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44265 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfK0K2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 05:28:15 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iZuYE-0004Jb-EZ; Wed, 27 Nov 2019 11:28:02 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E5F2E1C1E75;
        Wed, 27 Nov 2019 11:28:01 +0100 (CET)
Date:   Wed, 27 Nov 2019 10:28:01 -0000
From:   "tip-bot2 for Anthony Steinhauser" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86: Implement immediate enforcement of
 /sys/devices/cpu/rdpmc value of 0
Cc:     Anthony Steinhauser <asteinhauser@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>, acme@kernel.org,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191125054838.137615-1-asteinhauser@google.com>
References: <20191125054838.137615-1-asteinhauser@google.com>
MIME-Version: 1.0
Message-ID: <157485048175.21853.7122458851283772555.tip-bot2@tip-bot2>
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

Commit-ID:     405b45376de90b3027aaf8c4de035c6bb721fa7e
Gitweb:        https://git.kernel.org/tip/405b45376de90b3027aaf8c4de035c6bb721fa7e
Author:        Anthony Steinhauser <asteinhauser@google.com>
AuthorDate:    Sun, 24 Nov 2019 21:48:38 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 27 Nov 2019 10:32:11 +01:00

perf/x86: Implement immediate enforcement of /sys/devices/cpu/rdpmc value of 0

When you successfully write 0 to /sys/devices/cpu/rdpmc, the RDPMC
instruction should be disabled unconditionally and immediately (after you
close the SYSFS file) by the documentation.

Instead, in the current implementation the PMU must be reloaded which
happens only eventually some time in the future. Only after that the RDPMC
instruction becomes disabled (on ring 3) on the respective core.

This change makes the treatment of the 0 value as blocking and as
unconditional as the current treatment of the 2 value, only the CR4.PCE
bit is naturally set to false instead of true.

Signed-off-by: Anthony Steinhauser <asteinhauser@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: acme@kernel.org
Link: https://lkml.kernel.org/r/20191125054838.137615-1-asteinhauser@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/core.c             | 18 ++++++++++++------
 arch/x86/include/asm/mmu_context.h |  4 +++-
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 6e3f0c1..9a89d98 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -49,6 +49,7 @@ DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events) = {
 	.enabled = 1,
 };
 
+DEFINE_STATIC_KEY_FALSE(rdpmc_never_available_key);
 DEFINE_STATIC_KEY_FALSE(rdpmc_always_available_key);
 
 u64 __read_mostly hw_cache_event_ids
@@ -2181,21 +2182,26 @@ static ssize_t set_attr_rdpmc(struct device *cdev,
 	if (x86_pmu.attr_rdpmc_broken)
 		return -ENOTSUPP;
 
-	if ((val == 2) != (x86_pmu.attr_rdpmc == 2)) {
+	if (val != x86_pmu.attr_rdpmc) {
 		/*
-		 * Changing into or out of always available, aka
-		 * perf-event-bypassing mode.  This path is extremely slow,
+		 * Changing into or out of never available or always available,
+		 * aka perf-event-bypassing mode. This path is extremely slow,
 		 * but only root can trigger it, so it's okay.
 		 */
+		if (val == 0)
+			static_branch_inc(&rdpmc_never_available_key);
+		else if (x86_pmu.attr_rdpmc == 0)
+			static_branch_dec(&rdpmc_never_available_key);
+
 		if (val == 2)
 			static_branch_inc(&rdpmc_always_available_key);
-		else
+		else if (x86_pmu.attr_rdpmc == 2)
 			static_branch_dec(&rdpmc_always_available_key);
+
 		on_each_cpu(refresh_pce, NULL, 1);
+		x86_pmu.attr_rdpmc = val;
 	}
 
-	x86_pmu.attr_rdpmc = val;
-
 	return count;
 }
 
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 16ae821..5f33924 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -26,12 +26,14 @@ static inline void paravirt_activate_mm(struct mm_struct *prev,
 
 #ifdef CONFIG_PERF_EVENTS
 
+DECLARE_STATIC_KEY_FALSE(rdpmc_never_available_key);
 DECLARE_STATIC_KEY_FALSE(rdpmc_always_available_key);
 
 static inline void load_mm_cr4_irqsoff(struct mm_struct *mm)
 {
 	if (static_branch_unlikely(&rdpmc_always_available_key) ||
-	    atomic_read(&mm->context.perf_rdpmc_allowed))
+	    (!static_branch_unlikely(&rdpmc_never_available_key) &&
+	     atomic_read(&mm->context.perf_rdpmc_allowed)))
 		cr4_set_bits_irqsoff(X86_CR4_PCE);
 	else
 		cr4_clear_bits_irqsoff(X86_CR4_PCE);
