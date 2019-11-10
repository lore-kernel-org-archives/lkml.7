Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA07C17442
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 10:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B752085B
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 10:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfKJKYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 05:24:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54413 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbfKJKYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 05:24:08 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iTkO4-0004Xs-VE; Sun, 10 Nov 2019 11:24:05 +0100
Date:   Sun, 10 Nov 2019 10:21:53 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/urgent for v5.4-rc7
References: <157338131323.14789.2179255265964358886.tglx@nanos.tec.linutronix.de>
Message-ID: <157338131324.14789.9347520189915553665.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

up to:  52338415cf4d: timekeeping/vsyscall: Update VDSO data unconditionally

A small set of fixes for timekeepoing and clocksource drivers:

  - VDSO data was updated conditional on the availability of a VDSO capable
    clocksource. This causes the VDSO functions which do not depend on a
    VDSO capable clocksource to operate on stale data. Always update
    unconditionally.

  - Prevent a double free in the mediatek driver

  - Use the proper helper in the sh_mtu2 driver so it won't attempt to
    initialize non-existing interrupts.

Thanks,

	tglx

------------------>
Fabien Parent (1):
      clocksource/drivers/mediatek: Fix error handling

Geert Uytterhoeven (1):
      clocksource/drivers/sh_mtu2: Do not loop using platform_get_irq_by_name()

Huacai Chen (1):
      timekeeping/vsyscall: Update VDSO data unconditionally


 arch/arm64/include/asm/vdso/vsyscall.h |  7 -------
 arch/mips/include/asm/vdso/vsyscall.h  |  7 -------
 drivers/clocksource/sh_mtu2.c          | 16 +++++++++++-----
 drivers/clocksource/timer-mediatek.c   | 10 ++--------
 include/asm-generic/vdso/vsyscall.h    |  7 -------
 kernel/time/vsyscall.c                 |  9 +++------
 6 files changed, 16 insertions(+), 40 deletions(-)

diff --git a/arch/arm64/include/asm/vdso/vsyscall.h b/arch/arm64/include/asm/vdso/vsyscall.h
index 0c731bfc7c8c..0c20a7c1bee5 100644
--- a/arch/arm64/include/asm/vdso/vsyscall.h
+++ b/arch/arm64/include/asm/vdso/vsyscall.h
@@ -30,13 +30,6 @@ int __arm64_get_clock_mode(struct timekeeper *tk)
 }
 #define __arch_get_clock_mode __arm64_get_clock_mode
 
-static __always_inline
-int __arm64_use_vsyscall(struct vdso_data *vdata)
-{
-	return !vdata[CS_HRES_COARSE].clock_mode;
-}
-#define __arch_use_vsyscall __arm64_use_vsyscall
-
 static __always_inline
 void __arm64_update_vsyscall(struct vdso_data *vdata, struct timekeeper *tk)
 {
diff --git a/arch/mips/include/asm/vdso/vsyscall.h b/arch/mips/include/asm/vdso/vsyscall.h
index 195314732233..00d41b94ba31 100644
--- a/arch/mips/include/asm/vdso/vsyscall.h
+++ b/arch/mips/include/asm/vdso/vsyscall.h
@@ -28,13 +28,6 @@ int __mips_get_clock_mode(struct timekeeper *tk)
 }
 #define __arch_get_clock_mode __mips_get_clock_mode
 
-static __always_inline
-int __mips_use_vsyscall(struct vdso_data *vdata)
-{
-	return (vdata[CS_HRES_COARSE].clock_mode != VDSO_CLOCK_NONE);
-}
-#define __arch_use_vsyscall __mips_use_vsyscall
-
 /* The asm-generic header needs to be included after the definitions above */
 #include <asm-generic/vdso/vsyscall.h>
 
diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
index 354b27d14a19..62812f80b5cc 100644
--- a/drivers/clocksource/sh_mtu2.c
+++ b/drivers/clocksource/sh_mtu2.c
@@ -328,12 +328,13 @@ static int sh_mtu2_register(struct sh_mtu2_channel *ch, const char *name)
 	return 0;
 }
 
+static const unsigned int sh_mtu2_channel_offsets[] = {
+	0x300, 0x380, 0x000,
+};
+
 static int sh_mtu2_setup_channel(struct sh_mtu2_channel *ch, unsigned int index,
 				 struct sh_mtu2_device *mtu)
 {
-	static const unsigned int channel_offsets[] = {
-		0x300, 0x380, 0x000,
-	};
 	char name[6];
 	int irq;
 	int ret;
@@ -356,7 +357,7 @@ static int sh_mtu2_setup_channel(struct sh_mtu2_channel *ch, unsigned int index,
 		return ret;
 	}
 
-	ch->base = mtu->mapbase + channel_offsets[index];
+	ch->base = mtu->mapbase + sh_mtu2_channel_offsets[index];
 	ch->index = index;
 
 	return sh_mtu2_register(ch, dev_name(&mtu->pdev->dev));
@@ -408,7 +409,12 @@ static int sh_mtu2_setup(struct sh_mtu2_device *mtu,
 	}
 
 	/* Allocate and setup the channels. */
-	mtu->num_channels = 3;
+	ret = platform_irq_count(pdev);
+	if (ret < 0)
+		goto err_unmap;
+
+	mtu->num_channels = min_t(unsigned int, ret,
+				  ARRAY_SIZE(sh_mtu2_channel_offsets));
 
 	mtu->channels = kcalloc(mtu->num_channels, sizeof(*mtu->channels),
 				GFP_KERNEL);
diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
index a562f491b0f8..9318edcd8963 100644
--- a/drivers/clocksource/timer-mediatek.c
+++ b/drivers/clocksource/timer-mediatek.c
@@ -268,15 +268,12 @@ static int __init mtk_syst_init(struct device_node *node)
 
 	ret = timer_of_init(node, &to);
 	if (ret)
-		goto err;
+		return ret;
 
 	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to),
 					TIMER_SYNC_TICKS, 0xffffffff);
 
 	return 0;
-err:
-	timer_of_cleanup(&to);
-	return ret;
 }
 
 static int __init mtk_gpt_init(struct device_node *node)
@@ -293,7 +290,7 @@ static int __init mtk_gpt_init(struct device_node *node)
 
 	ret = timer_of_init(node, &to);
 	if (ret)
-		goto err;
+		return ret;
 
 	/* Configure clock source */
 	mtk_gpt_setup(&to, TIMER_CLK_SRC, GPT_CTRL_OP_FREERUN);
@@ -311,9 +308,6 @@ static int __init mtk_gpt_init(struct device_node *node)
 	mtk_gpt_enable_irq(&to, TIMER_CLK_EVT);
 
 	return 0;
-err:
-	timer_of_cleanup(&to);
-	return ret;
 }
 TIMER_OF_DECLARE(mtk_mt6577, "mediatek,mt6577-timer", mtk_gpt_init);
 TIMER_OF_DECLARE(mtk_mt6765, "mediatek,mt6765-timer", mtk_syst_init);
diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vdso/vsyscall.h
index e94b19782c92..ce4103208619 100644
--- a/include/asm-generic/vdso/vsyscall.h
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -25,13 +25,6 @@ static __always_inline int __arch_get_clock_mode(struct timekeeper *tk)
 }
 #endif /* __arch_get_clock_mode */
 
-#ifndef __arch_use_vsyscall
-static __always_inline int __arch_use_vsyscall(struct vdso_data *vdata)
-{
-	return 1;
-}
-#endif /* __arch_use_vsyscall */
-
 #ifndef __arch_update_vsyscall
 static __always_inline void __arch_update_vsyscall(struct vdso_data *vdata,
 						   struct timekeeper *tk)
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index 4bc37ac3bb05..5ee0f7709410 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -110,8 +110,7 @@ void update_vsyscall(struct timekeeper *tk)
 	nsec		= nsec + tk->wall_to_monotonic.tv_nsec;
 	vdso_ts->sec	+= __iter_div_u64_rem(nsec, NSEC_PER_SEC, &vdso_ts->nsec);
 
-	if (__arch_use_vsyscall(vdata))
-		update_vdso_data(vdata, tk);
+	update_vdso_data(vdata, tk);
 
 	__arch_update_vsyscall(vdata, tk);
 
@@ -124,10 +123,8 @@ void update_vsyscall_tz(void)
 {
 	struct vdso_data *vdata = __arch_get_k_vdso_data();
 
-	if (__arch_use_vsyscall(vdata)) {
-		vdata[CS_HRES_COARSE].tz_minuteswest = sys_tz.tz_minuteswest;
-		vdata[CS_HRES_COARSE].tz_dsttime = sys_tz.tz_dsttime;
-	}
+	vdata[CS_HRES_COARSE].tz_minuteswest = sys_tz.tz_minuteswest;
+	vdata[CS_HRES_COARSE].tz_dsttime = sys_tz.tz_dsttime;
 
 	__arch_sync_vdso_data(vdata);
 }


