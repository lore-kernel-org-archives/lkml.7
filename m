Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47020C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F94D2147A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbfDHPtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:49:51 -0400
Received: from foss.arm.com ([217.140.101.70]:50668 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728905AbfDHPtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:49:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 121BE19F6;
        Mon,  8 Apr 2019 08:49:49 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.196.92])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45C2E3F557;
        Mon,  8 Apr 2019 08:49:47 -0700 (PDT)
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
Subject: [PATCH 6/7] clocksource/arm_arch_timer: Remove use of workaround static key
Date:   Mon,  8 Apr 2019 16:49:06 +0100
Message-Id: <20190408154907.223536-7-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190408154907.223536-1-marc.zyngier@arm.com>
References: <20190408154907.223536-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of a static key in a hotplug path has proved to be a real
nightmare, and makes it impossible to have scream-free lockdep
kernel.

Let's remove the static key altogether, and focus on something saner.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/arch_timer.h  |  4 ----
 drivers/clocksource/arm_arch_timer.c | 25 +++++++------------------
 2 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index 4a06d46def7e..5502ea049b63 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -45,13 +45,9 @@
 		(__wa && __wa->h) ? __wa->h : arch_timer_##h;		\
 	})
 
-extern struct static_key_false arch_timer_read_ool_enabled;
-#define needs_unstable_timer_counter_workaround() \
-	static_branch_unlikely(&arch_timer_read_ool_enabled)
 #else
 #define has_erratum_handler(h)			   false
 #define erratum_handler(h)			   (arch_timer_##h)
-#define needs_unstable_timer_counter_workaround()  false
 #endif
 
 enum arch_timer_erratum_match_type {
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index c7f5b66d893c..da487fbfada3 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -372,8 +372,6 @@ static u32 notrace sun50i_a64_read_cntv_tval_el0(void)
 DEFINE_PER_CPU(const struct arch_timer_erratum_workaround *, timer_unstable_counter_workaround);
 EXPORT_SYMBOL_GPL(timer_unstable_counter_workaround);
 
-DEFINE_STATIC_KEY_FALSE(arch_timer_read_ool_enabled);
-EXPORT_SYMBOL_GPL(arch_timer_read_ool_enabled);
 
 static void erratum_set_next_event_tval_generic(const int access, unsigned long evt,
 						struct clock_event_device *clk)
@@ -552,12 +550,6 @@ void arch_timer_enable_workaround(const struct arch_timer_erratum_workaround *wa
 			per_cpu(timer_unstable_counter_workaround, i) = wa;
 	}
 
-	/*
-	 * Use the locked version, as we're called from the CPU
-	 * hotplug framework. Otherwise, we end-up in deadlock-land.
-	 */
-	static_branch_enable_cpuslocked(&arch_timer_read_ool_enabled);
-
 	/*
 	 * Don't use the vdso fastpath if errata require using the
 	 * out-of-line counter accessor. We may change our mind pretty
@@ -573,7 +565,7 @@ void arch_timer_enable_workaround(const struct arch_timer_erratum_workaround *wa
 static void arch_timer_check_ool_workaround(enum arch_timer_erratum_match_type type,
 					    void *arg)
 {
-	const struct arch_timer_erratum_workaround *wa;
+	const struct arch_timer_erratum_workaround *wa, *__wa;
 	ate_match_fn_t match_fn = NULL;
 	bool local = false;
 
@@ -597,16 +589,13 @@ static void arch_timer_check_ool_workaround(enum arch_timer_erratum_match_type t
 	if (!wa)
 		return;
 
-	if (needs_unstable_timer_counter_workaround()) {
-		const struct arch_timer_erratum_workaround *__wa;
-		__wa = __this_cpu_read(timer_unstable_counter_workaround);
-		if (__wa && wa != __wa)
-			pr_warn("Can't enable workaround for %s (clashes with %s\n)",
-				wa->desc, __wa->desc);
+	__wa = __this_cpu_read(timer_unstable_counter_workaround);
+	if (__wa && wa != __wa)
+		pr_warn("Can't enable workaround for %s (clashes with %s\n)",
+			wa->desc, __wa->desc);
 
-		if (__wa)
-			return;
-	}
+	if (__wa)
+		return;
 
 	arch_timer_enable_workaround(wa, local);
 	pr_info("Enabling %s workaround for %s\n",
-- 
2.20.1

