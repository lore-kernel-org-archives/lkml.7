Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C02C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 15:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5ED32133F
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 15:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395568AbfHWPEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 11:04:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35899 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394180AbfHWPEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 11:04:08 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i1B6h-0004lN-NE; Fri, 23 Aug 2019 17:04:03 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5BB781C04F3;
        Fri, 23 Aug 2019 17:04:03 +0200 (CEST)
Date:   Fri, 23 Aug 2019 15:04:03 -0000
From:   tip-bot2 for Vitaly Kuznetsov <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/hyperv: Enable TSC page
 clocksource on 32bit
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20190822083630.17059-1-vkuznets@redhat.com>
References: <20190822083630.17059-1-vkuznets@redhat.com>
MIME-Version: 1.0
Message-ID: <156657264330.8408.14103404893660006409.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     3e2d94535adb2df15f3907e4b4c7cd8a5a4c2b5a
Gitweb:        https://git.kernel.org/tip/3e2d94535adb2df15f3907e4b4c7cd8a5a4c2b5a
Author:        Vitaly Kuznetsov <vkuznets@redhat.com>
AuthorDate:    Thu, 22 Aug 2019 10:36:30 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 23 Aug 2019 16:59:54 +02:00

clocksource/drivers/hyperv: Enable TSC page clocksource on 32bit

There is no particular reason to not enable TSC page clocksource on
32-bit. mul_u64_u64_shr() is available and despite the increased
computational complexity (compared to 64bit) TSC page is still a huge win
compared to MSR-based clocksource.

In-kernel reads:
  MSR based clocksource: 3361 cycles
  TSC page clocksource: 49 cycles

Reads from userspace (utilizing vDSO in case of TSC page):
  MSR based clocksource: 5664 cycles
  TSC page clocksource: 131 cycles

Enabling TSC page on 32bits allows to get rid of CONFIG_HYPERV_TSCPAGE as
it is now not any different from CONFIG_HYPERV_TIMER.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Link: https://lkml.kernel.org/r/20190822083630.17059-1-vkuznets@redhat.com

---
 arch/x86/include/asm/vdso/gettimeofday.h |  6 +++---
 drivers/clocksource/hyperv_timer.c       | 11 -----------
 drivers/hv/Kconfig                       |  3 ---
 include/clocksource/hyperv_timer.h       |  8 +++-----
 4 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index ae91429..bcbf901 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -51,7 +51,7 @@ extern struct pvclock_vsyscall_time_info pvclock_page
 	__attribute__((visibility("hidden")));
 #endif
 
-#ifdef CONFIG_HYPERV_TSCPAGE
+#ifdef CONFIG_HYPERV_TIMER
 extern struct ms_hyperv_tsc_page hvclock_page
 	__attribute__((visibility("hidden")));
 #endif
@@ -192,7 +192,7 @@ static u64 vread_pvclock(void)
 }
 #endif
 
-#ifdef CONFIG_HYPERV_TSCPAGE
+#ifdef CONFIG_HYPERV_TIMER
 static u64 vread_hvclock(void)
 {
 	return hv_read_tsc_page(&hvclock_page);
@@ -215,7 +215,7 @@ static inline u64 __arch_get_hw_counter(s32 clock_mode)
 		return vread_pvclock();
 	}
 #endif
-#ifdef CONFIG_HYPERV_TSCPAGE
+#ifdef CONFIG_HYPERV_TIMER
 	if (clock_mode == VCLOCK_HVCLOCK) {
 		barrier();
 		return vread_hvclock();
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index c322ab4..2317d4e 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -213,8 +213,6 @@ EXPORT_SYMBOL_GPL(hv_stimer_global_cleanup);
 struct clocksource *hyperv_cs;
 EXPORT_SYMBOL_GPL(hyperv_cs);
 
-#ifdef CONFIG_HYPERV_TSCPAGE
-
 static struct ms_hyperv_tsc_page tsc_pg __aligned(PAGE_SIZE);
 
 struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
@@ -245,7 +243,6 @@ static struct clocksource hyperv_cs_tsc = {
 	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
-#endif
 
 static u64 notrace read_hv_clock_msr(struct clocksource *arg)
 {
@@ -272,7 +269,6 @@ static struct clocksource hyperv_cs_msr = {
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-#ifdef CONFIG_HYPERV_TSCPAGE
 static bool __init hv_init_tsc_clocksource(void)
 {
 	u64		tsc_msr;
@@ -304,13 +300,6 @@ static bool __init hv_init_tsc_clocksource(void)
 
 	return true;
 }
-#else
-static bool __init hv_init_tsc_clocksource(void)
-{
-	return false;
-}
-#endif
-
 
 void __init hv_init_clocksource(void)
 {
diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 9a59957..79e5356 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -14,9 +14,6 @@ config HYPERV
 config HYPERV_TIMER
 	def_bool HYPERV
 
-config HYPERV_TSCPAGE
-       def_bool HYPERV && X86_64
-
 config HYPERV_UTILS
 	tristate "Microsoft Hyper-V Utilities driver"
 	depends on HYPERV && CONNECTOR && NLS
diff --git a/include/clocksource/hyperv_timer.h b/include/clocksource/hyperv_timer.h
index a821deb..422f5e5 100644
--- a/include/clocksource/hyperv_timer.h
+++ b/include/clocksource/hyperv_timer.h
@@ -28,12 +28,10 @@ extern void hv_stimer_cleanup(unsigned int cpu);
 extern void hv_stimer_global_cleanup(void);
 extern void hv_stimer0_isr(void);
 
-#if IS_ENABLED(CONFIG_HYPERV)
+#ifdef CONFIG_HYPERV_TIMER
 extern struct clocksource *hyperv_cs;
 extern void hv_init_clocksource(void);
-#endif /* CONFIG_HYPERV */
 
-#ifdef CONFIG_HYPERV_TSCPAGE
 extern struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
 
 static inline notrace u64
@@ -91,7 +89,7 @@ hv_read_tsc_page(const struct ms_hyperv_tsc_page *tsc_pg)
 	return hv_read_tsc_page_tsc(tsc_pg, &cur_tsc);
 }
 
-#else /* CONFIG_HYPERV_TSC_PAGE */
+#else /* CONFIG_HYPERV_TIMER */
 static inline struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
 {
 	return NULL;
@@ -102,6 +100,6 @@ static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
 {
 	return U64_MAX;
 }
-#endif /* CONFIG_HYPERV_TSCPAGE */
+#endif /* CONFIG_HYPERV_TIMER */
 
 #endif
