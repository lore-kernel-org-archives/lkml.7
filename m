Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1D1C742A1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 20:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7EC21537
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 20:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbfGKUFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 16:05:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50858 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbfGKUFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 16:05:17 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hlfJb-0005Ri-9e; Thu, 11 Jul 2019 22:05:15 +0200
Date:   Thu, 11 Jul 2019 20:02:36 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/urgent for 5.3-rc1
References: <156287535656.8320.16630272660351040656.tglx@nanos.tec.linutronix.de>
Message-ID: <156287535656.8320.9605793923078784342.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

up to:  0df1c9868c3a: timekeeping/vsyscall: Use __iter_div_u64_rem()

Two small fixes from the timer departement:

 - Prevent the compiler from converting the nanoseconds adjustment loop in
   the VDSO update function to a division (__udivdi3) by using the
   __iter_div_u64_rem() inline function which exists to prevent exactly
   that problem.

 - Fix the wrong argument order of the GENMASK macro in the NPCM timer driver

Thanks,

	tglx

------------------>
Arnd Bergmann (1):
      timekeeping/vsyscall: Use __iter_div_u64_rem()

Joe Perches (1):
      clocksource/drivers/npcm: Fix misuse of GENMASK macro


 drivers/clocksource/timer-npcm7xx.c | 2 +-
 kernel/time/vsyscall.c              | 6 +-----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/timer-npcm7xx.c b/drivers/clocksource/timer-npcm7xx.c
index 7a9bb5532d99..8a30da7f083b 100644
--- a/drivers/clocksource/timer-npcm7xx.c
+++ b/drivers/clocksource/timer-npcm7xx.c
@@ -32,7 +32,7 @@
 #define NPCM7XX_Tx_INTEN		BIT(29)
 #define NPCM7XX_Tx_COUNTEN		BIT(30)
 #define NPCM7XX_Tx_ONESHOT		0x0
-#define NPCM7XX_Tx_OPER			GENMASK(3, 27)
+#define NPCM7XX_Tx_OPER			GENMASK(27, 3)
 #define NPCM7XX_Tx_MIN_PRESCALE		0x1
 #define NPCM7XX_Tx_TDR_MASK_BITS	24
 #define NPCM7XX_Tx_MAX_CNT		0xFFFFFF
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index a80893180826..8cf3596a4ce6 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -104,11 +104,7 @@ void update_vsyscall(struct timekeeper *tk)
 	vdso_ts->sec	= tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
 	nsec		= tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
 	nsec		= nsec + tk->wall_to_monotonic.tv_nsec;
-	while (nsec >= NSEC_PER_SEC) {
-		nsec = nsec - NSEC_PER_SEC;
-		vdso_ts->sec++;
-	}
-	vdso_ts->nsec	= nsec;
+	vdso_ts->sec	+= __iter_div_u64_rem(nsec, NSEC_PER_SEC, &vdso_ts->nsec);
 
 	if (__arch_use_vsyscall(vdata))
 		update_vdso_data(vdata, tk);

