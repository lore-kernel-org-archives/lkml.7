Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F23DC10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28BEF21473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbfDHPtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:49:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50656 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728935AbfDHPtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:49:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 075C719BF;
        Mon,  8 Apr 2019 08:49:47 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.196.92])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B68F3F557;
        Mon,  8 Apr 2019 08:49:45 -0700 (PDT)
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
Subject: [PATCH 5/7] clocksource/arm_arch_timer: Drop use of static key in arch_timer_reg_read_stable
Date:   Mon,  8 Apr 2019 16:49:05 +0100
Message-Id: <20190408154907.223536-6-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190408154907.223536-1-marc.zyngier@arm.com>
References: <20190408154907.223536-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's start with the removal of the arch_timer_read_ool_enabled
static key in arch_timer_reg_read_stable. IT is not a fast path,
and we can simplify things a bit.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/arch_timer.h | 42 +++++++++++++++++++----------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index c3762ffcc933..4a06d46def7e 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -77,23 +77,37 @@ struct arch_timer_erratum_workaround {
 DECLARE_PER_CPU(const struct arch_timer_erratum_workaround *,
 		timer_unstable_counter_workaround);
 
+/* inline sysreg accessors that make erratum_handler() work */
+static inline notrace u32 arch_timer_read_cntp_tval_el0(void)
+{
+	return read_sysreg(cntp_tval_el0);
+}
+
+static inline notrace u32 arch_timer_read_cntv_tval_el0(void)
+{
+	return read_sysreg(cntv_tval_el0);
+}
+
+static inline notrace u64 arch_timer_read_cntpct_el0(void)
+{
+	return read_sysreg(cntpct_el0);
+}
+
+static inline notrace u64 arch_timer_read_cntvct_el0(void)
+{
+	return read_sysreg(cntvct_el0);
+}
+
 #define arch_timer_reg_read_stable(reg)					\
-({									\
-	u64 _val;							\
-	if (needs_unstable_timer_counter_workaround()) {		\
-		const struct arch_timer_erratum_workaround *wa;		\
+	({								\
+		u64 _val;						\
+									\
 		preempt_disable_notrace();				\
-		wa = __this_cpu_read(timer_unstable_counter_workaround); \
-		if (wa && wa->read_##reg)				\
-			_val = wa->read_##reg();			\
-		else							\
-			_val = read_sysreg(reg);			\
+		_val = erratum_handler(read_ ## reg)();			\
 		preempt_enable_notrace();				\
-	} else {							\
-		_val = read_sysreg(reg);				\
-	}								\
-	_val;								\
-})
+									\
+		_val;							\
+	})
 
 /*
  * These register accessors are marked inline so the compiler can
-- 
2.20.1

