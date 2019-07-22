Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B24C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257DF21951
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbfGVKdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 06:33:51 -0400
Received: from foss.arm.com ([217.140.110.172]:35458 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729679AbfGVKdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 06:33:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 926C11596;
        Mon, 22 Jul 2019 03:33:45 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.197.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 236233F71A;
        Mon, 22 Jul 2019 03:33:44 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: Allow early time stamping
Date:   Mon, 22 Jul 2019 11:33:30 +0100
Message-Id: <20190722103330.255312-4-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722103330.255312-1-marc.zyngier@arm.com>
References: <20190722103330.255312-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to provide early timestamping on arm64 systems, we provide
a timestamp_clock() function that is available as early as possible.
This function simply returns the current counter value scales in
nanoseconds, and 0-based.

In order to deal with the idiosyncrasies of some broken platforms,
we condition this on the frequency being set in the CNTFRQ_EL0
register, and revert back to using local_clock() as soon as it starts
returning non-zero values.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/Kconfig        |  3 +++
 arch/arm64/kernel/setup.c | 44 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3adcec05b1f6..ac3882ddc1c2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -911,6 +911,9 @@ config ARCH_WANT_HUGE_PMD_SHARE
 config ARCH_HAS_CACHE_LINE_SIZE
 	def_bool y
 
+config ARCH_HAS_TIMESTAMP_CLOCK
+	def_bool y
+
 config ARCH_ENABLE_SPLIT_PMD_PTLOCK
 	def_bool y if PGTABLE_LEVELS > 2
 
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 9c4bad7d7131..cf21e3df7165 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -15,6 +15,7 @@
 #include <linux/initrd.h>
 #include <linux/console.h>
 #include <linux/cache.h>
+#include <linux/clocksource.h>
 #include <linux/screen_info.h>
 #include <linux/init.h>
 #include <linux/kexec.h>
@@ -28,10 +29,12 @@
 #include <linux/of_fdt.h>
 #include <linux/efi.h>
 #include <linux/psci.h>
+#include <linux/sched/clock.h>
 #include <linux/sched/task.h>
 #include <linux/mm.h>
 
 #include <asm/acpi.h>
+#include <asm/arch_timer.h>
 #include <asm/fixmap.h>
 #include <asm/cpu.h>
 #include <asm/cputype.h>
@@ -269,8 +272,49 @@ arch_initcall(reserve_memblock_reserved_regions);
 
 u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
 
+static u64 notrace ts_counter_read_cc(const struct cyclecounter *cc)
+{
+	return __arch_counter_get_cntvct();
+}
+
+static struct cyclecounter ts_cc __ro_after_init = {
+	.read	= ts_counter_read_cc,
+	.mask	= CLOCKSOURCE_MASK(56),
+};
+
+static struct timecounter ts_tc;
+
+static bool ts_cc_valid __ro_after_init = false;
+
+static __init void timestamp_clock_init(void)
+{
+	u64 frq = arch_timer_get_cntfrq();
+
+	if (!frq)
+		return;
+
+	clocks_calc_mult_shift(&ts_cc.mult, &ts_cc.shift,
+			       frq, NSEC_PER_SEC, 3600);
+	/* timestamp starts at 0 (local_clock is a good enough approximation) */
+	timecounter_init(&ts_tc, &ts_cc, local_clock());
+	ts_cc_valid = true;
+	pr_info("Using timestamp clock @%lluMHz\n", frq / 1000 / 1000);
+}
+
+u64 timestamp_clock(void)
+{
+	u64 ns = local_clock();
+
+	if (likely(ns || !ts_cc_valid))
+		return ns;
+
+	return timecounter_read(&ts_tc);
+}
+
 void __init setup_arch(char **cmdline_p)
 {
+	timestamp_clock_init();
+
 	init_mm.start_code = (unsigned long) _text;
 	init_mm.end_code   = (unsigned long) _etext;
 	init_mm.end_data   = (unsigned long) _edata;
-- 
2.20.1

