Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEF5C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE7E21473
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732091AbfFMPU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:20:56 -0400
Received: from foss.arm.com ([217.140.110.172]:39440 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732009AbfFMMvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 08:51:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BF2C2B;
        Thu, 13 Jun 2019 05:51:12 -0700 (PDT)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 432713F694;
        Thu, 13 Jun 2019 05:51:11 -0700 (PDT)
From:   Andrew Murray <andrew.murray@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] clocksource/arm_arch_timer: extract elf_hwcap use to arch-helper
Date:   Thu, 13 Jun 2019 13:51:02 +0100
Message-Id: <20190613125102.23879-1-andrew.murray@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Different mechanisms are used to test and set elf_hwcaps between ARM
and ARM64, this results in the use of ifdeferry in this file when
setting/testing for the EVTSTRM hwcap.

Let's improve readability by extracting this to an arch helper.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/arch_timer.h    | 10 ++++++++++
 arch/arm64/include/asm/arch_timer.h  | 13 +++++++++++++
 drivers/clocksource/arm_arch_timer.c | 15 ++-------------
 3 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index 4b66ecd6be99..ae533caec1e9 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -4,6 +4,7 @@
 
 #include <asm/barrier.h>
 #include <asm/errno.h>
+#include <asm/hwcap.h>
 #include <linux/clocksource.h>
 #include <linux/init.h>
 #include <linux/types.h>
@@ -124,6 +125,15 @@ static inline void arch_timer_set_cntkctl(u32 cntkctl)
 	isb();
 }
 
+static inline bool arch_timer_set_evtstrm_feature(void)
+{
+	elf_hwcap |= HWCAP_EVTSTRM;
+}
+
+static inline bool arch_timer_have_evtstrm_feature(void)
+{
+	return elf_hwcap & HWCAP_EVTSTRM;
+}
 #endif
 
 #endif
diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index 50b3ab7ded4f..a847a3ee6cab 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -20,6 +20,7 @@
 #define __ASM_ARCH_TIMER_H
 
 #include <asm/barrier.h>
+#include <asm/hwcap.h>
 #include <asm/sysreg.h>
 
 #include <linux/bug.h>
@@ -240,4 +241,16 @@ static inline int arch_timer_arch_init(void)
 	return 0;
 }
 
+static inline void arch_timer_set_evtstrm_feature(void)
+{
+	cpu_set_named_feature(EVTSTRM);
+#ifdef CONFIG_COMPAT
+	compat_elf_hwcap |= COMPAT_HWCAP_EVTSTRM;
+#endif
+}
+
+static inline bool arch_timer_have_evtstrm_feature(void)
+{
+	return cpu_have_named_feature(EVTSTRM);
+}
 #endif
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index b2a951a798e2..3583a92ad960 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -804,14 +804,7 @@ static void arch_timer_evtstrm_enable(int divider)
 	cntkctl |= (divider << ARCH_TIMER_EVT_TRIGGER_SHIFT)
 			| ARCH_TIMER_VIRT_EVT_EN;
 	arch_timer_set_cntkctl(cntkctl);
-#ifdef CONFIG_ARM64
-	cpu_set_named_feature(EVTSTRM);
-#else
-	elf_hwcap |= HWCAP_EVTSTRM;
-#endif
-#ifdef CONFIG_COMPAT
-	compat_elf_hwcap |= COMPAT_HWCAP_EVTSTRM;
-#endif
+	arch_timer_set_evtstrm_feature();
 	cpumask_set_cpu(smp_processor_id(), &evtstrm_available);
 }
 
@@ -1040,11 +1033,7 @@ static int arch_timer_cpu_pm_notify(struct notifier_block *self,
 	} else if (action == CPU_PM_ENTER_FAILED || action == CPU_PM_EXIT) {
 		arch_timer_set_cntkctl(__this_cpu_read(saved_cntkctl));
 
-#ifdef CONFIG_ARM64
-		if (cpu_have_named_feature(EVTSTRM))
-#else
-		if (elf_hwcap & HWCAP_EVTSTRM)
-#endif
+		if (arch_timer_have_evtstrm_feature())
 			cpumask_set_cpu(smp_processor_id(), &evtstrm_available);
 	}
 	return NOTIFY_OK;
-- 
2.21.0

