Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8624EC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9342147A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbfDHPtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:49:47 -0400
Received: from foss.arm.com ([217.140.101.70]:50634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728905AbfDHPtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:49:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F03AE174E;
        Mon,  8 Apr 2019 08:49:44 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.196.92])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FDAD3F557;
        Mon,  8 Apr 2019 08:49:43 -0700 (PDT)
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
Subject: [PATCH 4/7] clocksource/arm_arch_timer: Direcly assign set_next_event workaround
Date:   Mon,  8 Apr 2019 16:49:04 +0100
Message-Id: <20190408154907.223536-5-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190408154907.223536-1-marc.zyngier@arm.com>
References: <20190408154907.223536-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a given timer is affected by an erratum and requires an
alternative implementation of set_next_event, we do a rather
complicated dance to detect and call the workaround on each
set_next_event call.

This is clearly idiotic, as we can perfectly detect whether
this CPU requires a workaround while setting up the clock event
device.

This only requires the CPU-specific detection to be done a bit
earlier, and we can then safely override the set_next_event pointer
if we have a workaround associated to that CPU.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/arch_timer.h    |  4 +++
 arch/arm64/include/asm/arch_timer.h  | 16 ++++++++++
 drivers/clocksource/arm_arch_timer.c | 46 +++++-----------------------
 3 files changed, 28 insertions(+), 38 deletions(-)

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index 0a8d7bba2cb0..3f0a0191f763 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -11,6 +11,10 @@
 #include <clocksource/arm_arch_timer.h>
 
 #ifdef CONFIG_ARM_ARCH_TIMER
+/* 32bit ARM doesn't know anything about timer errata... */
+#define has_erratum_handler(h)		(false)
+#define erratum_handler(h)		(arch_timer_##h)
+
 int arch_timer_arch_init(void);
 
 /*
diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index f2a234d6516c..c3762ffcc933 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -31,10 +31,26 @@
 #include <clocksource/arm_arch_timer.h>
 
 #if IS_ENABLED(CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND)
+#define has_erratum_handler(h)						\
+	({								\
+		const struct arch_timer_erratum_workaround *__wa;	\
+		__wa = __this_cpu_read(timer_unstable_counter_workaround); \
+		(__wa && __wa->h);					\
+	})
+
+#define erratum_handler(h)						\
+	({								\
+		const struct arch_timer_erratum_workaround *__wa;	\
+		__wa = __this_cpu_read(timer_unstable_counter_workaround); \
+		(__wa && __wa->h) ? __wa->h : arch_timer_##h;		\
+	})
+
 extern struct static_key_false arch_timer_read_ool_enabled;
 #define needs_unstable_timer_counter_workaround() \
 	static_branch_unlikely(&arch_timer_read_ool_enabled)
 #else
+#define has_erratum_handler(h)			   false
+#define erratum_handler(h)			   (arch_timer_##h)
 #define needs_unstable_timer_counter_workaround()  false
 #endif
 
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index aa4ec53281ce..c7f5b66d893c 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -613,36 +613,12 @@ static void arch_timer_check_ool_workaround(enum arch_timer_erratum_match_type t
 		local ? "local" : "global", wa->desc);
 }
 
-#define erratum_handler(fn, r, ...)					\
-({									\
-	bool __val;							\
-	if (needs_unstable_timer_counter_workaround()) {		\
-		const struct arch_timer_erratum_workaround *__wa;	\
-		__wa = __this_cpu_read(timer_unstable_counter_workaround); \
-		if (__wa && __wa->fn) {					\
-			r = __wa->fn(__VA_ARGS__);			\
-			__val = true;					\
-		} else {						\
-			__val = false;					\
-		}							\
-	} else {							\
-		__val = false;						\
-	}								\
-	__val;								\
-})
-
 static bool arch_timer_this_cpu_has_cntvct_wa(void)
 {
-	const struct arch_timer_erratum_workaround *wa;
-
-	wa = __this_cpu_read(timer_unstable_counter_workaround);
-	return wa && wa->read_cntvct_el0;
+	return has_erratum_handler(read_cntvct_el0);
 }
 #else
 #define arch_timer_check_ool_workaround(t,a)		do { } while(0)
-#define erratum_set_next_event_tval_virt(...)		({BUG(); 0;})
-#define erratum_set_next_event_tval_phys(...)		({BUG(); 0;})
-#define erratum_handler(fn, r, ...)			({false;})
 #define arch_timer_this_cpu_has_cntvct_wa()		({false;})
 #endif /* CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND */
 
@@ -736,11 +712,6 @@ static __always_inline void set_next_event(const int access, unsigned long evt,
 static int arch_timer_set_next_event_virt(unsigned long evt,
 					  struct clock_event_device *clk)
 {
-	int ret;
-
-	if (erratum_handler(set_next_event_virt, ret, evt, clk))
-		return ret;
-
 	set_next_event(ARCH_TIMER_VIRT_ACCESS, evt, clk);
 	return 0;
 }
@@ -748,11 +719,6 @@ static int arch_timer_set_next_event_virt(unsigned long evt,
 static int arch_timer_set_next_event_phys(unsigned long evt,
 					  struct clock_event_device *clk)
 {
-	int ret;
-
-	if (erratum_handler(set_next_event_phys, ret, evt, clk))
-		return ret;
-
 	set_next_event(ARCH_TIMER_PHYS_ACCESS, evt, clk);
 	return 0;
 }
@@ -777,6 +743,10 @@ static void __arch_timer_setup(unsigned type,
 	clk->features = CLOCK_EVT_FEAT_ONESHOT;
 
 	if (type == ARCH_TIMER_TYPE_CP15) {
+		typeof(clk->set_next_event) sne;
+
+		arch_timer_check_ool_workaround(ate_match_local_cap_id, NULL);
+
 		if (arch_timer_c3stop)
 			clk->features |= CLOCK_EVT_FEAT_C3STOP;
 		clk->name = "arch_sys_timer";
@@ -787,20 +757,20 @@ static void __arch_timer_setup(unsigned type,
 		case ARCH_TIMER_VIRT_PPI:
 			clk->set_state_shutdown = arch_timer_shutdown_virt;
 			clk->set_state_oneshot_stopped = arch_timer_shutdown_virt;
-			clk->set_next_event = arch_timer_set_next_event_virt;
+			sne = erratum_handler(set_next_event_virt);
 			break;
 		case ARCH_TIMER_PHYS_SECURE_PPI:
 		case ARCH_TIMER_PHYS_NONSECURE_PPI:
 		case ARCH_TIMER_HYP_PPI:
 			clk->set_state_shutdown = arch_timer_shutdown_phys;
 			clk->set_state_oneshot_stopped = arch_timer_shutdown_phys;
-			clk->set_next_event = arch_timer_set_next_event_phys;
+			sne = erratum_handler(set_next_event_phys);
 			break;
 		default:
 			BUG();
 		}
 
-		arch_timer_check_ool_workaround(ate_match_local_cap_id, NULL);
+		clk->set_next_event = sne;
 	} else {
 		clk->features |= CLOCK_EVT_FEAT_DYNIRQ;
 		clk->name = "arch_mem_timer";
-- 
2.20.1

