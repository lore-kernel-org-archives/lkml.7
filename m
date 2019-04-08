Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EDEC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E172147A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbfDHPuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:50:00 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50680 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728965AbfDHPtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:49:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C86A1B4B;
        Mon,  8 Apr 2019 08:49:51 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.196.92])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 506AD3F557;
        Mon,  8 Apr 2019 08:49:49 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Russell King <linux@arm.linux.org.uk>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH 7/7] clocksource/arm_arch_timer: Use arch_timer_read_counter to access stable counters
Date:   Mon,  8 Apr 2019 16:49:07 +0100
Message-Id: <20190408154907.223536-8-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190408154907.223536-1-marc.zyngier@arm.com>
References: <20190408154907.223536-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of always going via arch_counter_get_cntvct_stable to
access the counter workaround, let's have arch_timer_read_counter
to point to the right method.

For that, we need to track whether any CPU in the system has a
workaround for the counter. This is done by having an atomic
variable tracking this.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/arch_timer.h    | 14 ++++++--
 arch/arm64/include/asm/arch_timer.h  | 16 ++++++++--
 drivers/clocksource/arm_arch_timer.c | 48 +++++++++++++++++++++++++---
 3 files changed, 70 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index 3f0a0191f763..4b66ecd6be99 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -83,7 +83,7 @@ static inline u32 arch_timer_get_cntfrq(void)
 	return val;
 }
 
-static inline u64 arch_counter_get_cntpct(void)
+static inline u64 __arch_counter_get_cntpct(void)
 {
 	u64 cval;
 
@@ -92,7 +92,12 @@ static inline u64 arch_counter_get_cntpct(void)
 	return cval;
 }
 
-static inline u64 arch_counter_get_cntvct(void)
+static inline u64 __arch_counter_get_cntpct_stable(void)
+{
+	return __arch_counter_get_cntpct();
+}
+
+static inline u64 __arch_counter_get_cntvct(void)
 {
 	u64 cval;
 
@@ -101,6 +106,11 @@ static inline u64 arch_counter_get_cntvct(void)
 	return cval;
 }
 
+static inline u64 __arch_counter_get_cntvct_stable(void)
+{
+	return __arch_counter_get_cntvct();
+}
+
 static inline u32 arch_timer_get_cntkctl(void)
 {
 	u32 cntkctl;
diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index 5502ea049b63..48b2100f4aaa 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -174,18 +174,30 @@ static inline void arch_timer_set_cntkctl(u32 cntkctl)
 	isb();
 }
 
-static inline u64 arch_counter_get_cntpct(void)
+static inline u64 __arch_counter_get_cntpct_stable(void)
 {
 	isb();
 	return arch_timer_reg_read_stable(cntpct_el0);
 }
 
-static inline u64 arch_counter_get_cntvct(void)
+static inline u64 __arch_counter_get_cntpct(void)
+{
+	isb();
+	return read_sysreg(cntpct_el0);
+}
+
+static inline u64 __arch_counter_get_cntvct_stable(void)
 {
 	isb();
 	return arch_timer_reg_read_stable(cntvct_el0);
 }
 
+static inline u64 __arch_counter_get_cntvct(void)
+{
+	isb();
+	return read_sysreg(cntvct_el0);
+}
+
 static inline int arch_timer_arch_init(void)
 {
 	return 0;
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index da487fbfada3..5fcccc467868 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -152,6 +152,26 @@ u32 arch_timer_reg_read(int access, enum arch_timer_reg reg,
 	return val;
 }
 
+static u64 arch_counter_get_cntpct_stable(void)
+{
+	return __arch_counter_get_cntpct_stable();
+}
+
+static u64 arch_counter_get_cntpct(void)
+{
+	return __arch_counter_get_cntpct();
+}
+
+static u64 arch_counter_get_cntvct_stable(void)
+{
+	return __arch_counter_get_cntvct_stable();
+}
+
+static u64 arch_counter_get_cntvct(void)
+{
+	return __arch_counter_get_cntvct();
+}
+
 /*
  * Default to cp15 based access because arm64 uses this function for
  * sched_clock() before DT is probed and the cp15 method is guaranteed
@@ -372,6 +392,7 @@ static u32 notrace sun50i_a64_read_cntv_tval_el0(void)
 DEFINE_PER_CPU(const struct arch_timer_erratum_workaround *, timer_unstable_counter_workaround);
 EXPORT_SYMBOL_GPL(timer_unstable_counter_workaround);
 
+static atomic_t timer_unstable_counter_workaround_in_use = ATOMIC_INIT(0);
 
 static void erratum_set_next_event_tval_generic(const int access, unsigned long evt,
 						struct clock_event_device *clk)
@@ -550,6 +571,9 @@ void arch_timer_enable_workaround(const struct arch_timer_erratum_workaround *wa
 			per_cpu(timer_unstable_counter_workaround, i) = wa;
 	}
 
+	if (wa->read_cntvct_el0 || wa->read_cntpct_el0)
+		atomic_set(&timer_unstable_counter_workaround_in_use, 1);
+
 	/*
 	 * Don't use the vdso fastpath if errata require using the
 	 * out-of-line counter accessor. We may change our mind pretty
@@ -606,9 +630,15 @@ static bool arch_timer_this_cpu_has_cntvct_wa(void)
 {
 	return has_erratum_handler(read_cntvct_el0);
 }
+
+static bool arch_timer_counter_has_wa(void)
+{
+	return atomic_read(&timer_unstable_counter_workaround_in_use);
+}
 #else
 #define arch_timer_check_ool_workaround(t,a)		do { } while(0)
 #define arch_timer_this_cpu_has_cntvct_wa()		({false;})
+#define arch_timer_counter_has_wa()			({false;})
 #endif /* CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND */
 
 static __always_inline irqreturn_t timer_handler(const int access,
@@ -957,12 +987,22 @@ static void __init arch_counter_register(unsigned type)
 
 	/* Register the CP15 based counter if we have one */
 	if (type & ARCH_TIMER_TYPE_CP15) {
+		u64 (*rd)(void);
+
 		if ((IS_ENABLED(CONFIG_ARM64) && !is_hyp_mode_available()) ||
-		    arch_timer_uses_ppi == ARCH_TIMER_VIRT_PPI)
-			arch_timer_read_counter = arch_counter_get_cntvct;
-		else
-			arch_timer_read_counter = arch_counter_get_cntpct;
+		    arch_timer_uses_ppi == ARCH_TIMER_VIRT_PPI) {
+			if (arch_timer_counter_has_wa())
+				rd = arch_counter_get_cntvct_stable;
+			else
+				rd = arch_counter_get_cntvct;
+		} else {
+			if (arch_timer_counter_has_wa())
+				rd = arch_counter_get_cntpct_stable;
+			else
+				rd = arch_counter_get_cntpct;
+		}
 
+		arch_timer_read_counter = rd;
 		clocksource_counter.archdata.vdso_direct = vdso_default;
 	} else {
 		arch_timer_read_counter = arch_counter_get_cntvct_mem;
-- 
2.20.1

