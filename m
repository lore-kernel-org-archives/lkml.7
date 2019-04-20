Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FD4C282E2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 07:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C341021855
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 07:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555746356;
	bh=Rh2EhOBQ0paXzGopf/60f4UwE6tu0E7iXUeBKfJfp30=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ocFbhPH6jmV9V1zSAY7Q306VW/NfN7dS+aVxmPaQ1TPM6fmD4oqT19vOw6HeVA03F
	 Kne22WUDqShYa5XDjf9citLZVfaBGYgnik+BaUKiGZMakop5AXWHGmUJVnPDmqVNqQ
	 enroC5BaJIYhAikmbyZOFOtRjpeqcv4zLyygOBE4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfDTHpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 03:45:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50595 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfDTHpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 03:45:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id z11so8481806wmi.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 00:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=n6C5vr/58BujR0VNB9MgYqcNTMORP0YxGqzFlv8e0NE=;
        b=dlPT8DUpfKmzglUzbYX/aJhOKBlor3IoKoffy8RAZLhlxgO6UK2qD+GsR9es+oiewy
         jkcvhRtNpV1YgBXKpbZmCjjYhnCmtvWCp4d8vQ19xaKPYdwG/1FDBA4LNZAgpFNwEPVZ
         oGncFTZ/pBULh53igeLxTAxRK4ylTmns3wQOtUNi/ro2Drrdgs+dvOs/1a9OQrF1bUUd
         TLMpezMgCL+cUnn7IUWZWBWYaaTX/PZ96Jo4eJ/2zi7MUJKEboEZL5ZJCDOL/EH/U6Bo
         Ej9c+1aDXDcnTjRuaf4WupB8YOOzwTFqPHpyeirqul44YSSrCOwnIAmPWm6tmH3ColJP
         OOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=n6C5vr/58BujR0VNB9MgYqcNTMORP0YxGqzFlv8e0NE=;
        b=cTLC/lHS0oDpwtJt2zK1hAif/ZYovlo9uy6UzussI28GDgBdg7IN0Mw1+n/sPkQ25s
         kenvJTe9NOM2+MhQS4yyHmsdgAP1BpVNyg8qkT8NkNR/We64ju52MeROYxFzZ+CebeGq
         IkfFZ3u2OJ2GHOdcojGuWpegRveUFAX356XpWR0ohi8pQEI/3kEJXiQ2LQDx/N/72W5q
         uUPqFYHUbI23jdFrnIamMhSlYmuSznU7TL5F0LHJMqKHOs3MS1nGTNDSIvAOJxXdlm0g
         oAT75hDnwkP9a3Z9a1qVRT2aJ7xRMTeCtA3Qu9t5yU7jkLyNJRPujmESkEBUuWjRsDbC
         yVtg==
X-Gm-Message-State: APjAAAWneKUVQDr8JgK9lkP08hCHy09tsVBR8E2zxzX0pdVTdQVx0ZYi
        NE5ceiFIyt246tIVQOkYjfUGQQn3
X-Google-Smtp-Source: APXvYqz1iCOTqSt+zrFx4oJKafSf0QVCHHhDoLc5tptcIdALPzUCCVYVS0jyl6Re5MyeeOnHMBpgcg==
X-Received: by 2002:a1c:2394:: with SMTP id j142mr5185800wmj.111.1555746353199;
        Sat, 20 Apr 2019 00:45:53 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a4sm9493189wmf.45.2019.04.20.00.45.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Apr 2019 00:45:52 -0700 (PDT)
Date:   Sat, 20 Apr 2019 09:45:50 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] timer fixes
Message-ID: <20190420074550.GA24140@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest timers-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

   # HEAD: 3f2552f7e9c5abef2775c53f7af66532f8bf65bc timers/sched_clock: Prevent generic sched_clock wrap caused by tick_freeze()

Misc clocksource driver fixes, and a sched-clock wrapping fix.

 Thanks,

	Ingo

------------------>
Arnd Bergmann (1):
      clocksource/drivers/npcm: select TIMER_OF

Chang-An Chen (1):
      timers/sched_clock: Prevent generic sched_clock wrap caused by tick_freeze()

Nathan Chancellor (1):
      clocksource/drivers/timer-ti-dm: Remove omap_dm_timer_set_load_start

Neil Armstrong (1):
      clocksource/drivers/oxnas: Fix OX820 compatible

Yangtao Li (1):
      clocksource/drivers/arm_arch_timer: Remove unneeded pr_fmt macro


 drivers/clocksource/Kconfig           |  1 +
 drivers/clocksource/arm_arch_timer.c  |  5 +----
 drivers/clocksource/timer-oxnas-rps.c |  2 +-
 drivers/clocksource/timer-ti-dm.c     | 28 ----------------------------
 kernel/time/sched_clock.c             |  4 ++--
 kernel/time/tick-common.c             |  2 ++
 kernel/time/timekeeping.h             |  7 +++++++
 7 files changed, 14 insertions(+), 35 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 171502a356aa..4b3d143f0f8a 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -145,6 +145,7 @@ config VT8500_TIMER
 config NPCM7XX_TIMER
 	bool "NPCM7xx timer driver" if COMPILE_TEST
 	depends on HAS_IOMEM
+	select TIMER_OF
 	select CLKSRC_MMIO
 	help
 	  Enable 24-bit TIMER0 and TIMER1 counters in the NPCM7xx architecture,
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index aa4ec53281ce..ea373cfbcecb 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -9,7 +9,7 @@
  * published by the Free Software Foundation.
  */
 
-#define pr_fmt(fmt)	"arm_arch_timer: " fmt
+#define pr_fmt(fmt) 	"arch_timer: " fmt
 
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -33,9 +33,6 @@
 
 #include <clocksource/arm_arch_timer.h>
 
-#undef pr_fmt
-#define pr_fmt(fmt) "arch_timer: " fmt
-
 #define CNTTIDR		0x08
 #define CNTTIDR_VIRT(n)	(BIT(1) << ((n) * 4))
 
diff --git a/drivers/clocksource/timer-oxnas-rps.c b/drivers/clocksource/timer-oxnas-rps.c
index eed6feff8b5f..30c6f4ce672b 100644
--- a/drivers/clocksource/timer-oxnas-rps.c
+++ b/drivers/clocksource/timer-oxnas-rps.c
@@ -296,4 +296,4 @@ static int __init oxnas_rps_timer_init(struct device_node *np)
 TIMER_OF_DECLARE(ox810se_rps,
 		       "oxsemi,ox810se-rps-timer", oxnas_rps_timer_init);
 TIMER_OF_DECLARE(ox820_rps,
-		       "oxsemi,ox820se-rps-timer", oxnas_rps_timer_init);
+		       "oxsemi,ox820-rps-timer", oxnas_rps_timer_init);
diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 3352da6ed61f..ee8ec5a8cb16 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -585,34 +585,6 @@ static int omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
 	return 0;
 }
 
-/* Optimized set_load which removes costly spin wait in timer_start */
-static int omap_dm_timer_set_load_start(struct omap_dm_timer *timer,
-					int autoreload, unsigned int load)
-{
-	u32 l;
-
-	if (unlikely(!timer))
-		return -EINVAL;
-
-	omap_dm_timer_enable(timer);
-
-	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
-	if (autoreload) {
-		l |= OMAP_TIMER_CTRL_AR;
-		omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG, load);
-	} else {
-		l &= ~OMAP_TIMER_CTRL_AR;
-	}
-	l |= OMAP_TIMER_CTRL_ST;
-
-	__omap_dm_timer_load_start(timer, l, load, timer->posted);
-
-	/* Save the context */
-	timer->context.tclr = l;
-	timer->context.tldr = load;
-	timer->context.tcrr = load;
-	return 0;
-}
 static int omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
 				   unsigned int match)
 {
diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index 094b82ca95e5..930113b9799a 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -272,7 +272,7 @@ static u64 notrace suspended_sched_clock_read(void)
 	return cd.read_data[seq & 1].epoch_cyc;
 }
 
-static int sched_clock_suspend(void)
+int sched_clock_suspend(void)
 {
 	struct clock_read_data *rd = &cd.read_data[0];
 
@@ -283,7 +283,7 @@ static int sched_clock_suspend(void)
 	return 0;
 }
 
-static void sched_clock_resume(void)
+void sched_clock_resume(void)
 {
 	struct clock_read_data *rd = &cd.read_data[0];
 
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 529143b4c8d2..df401463a191 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -487,6 +487,7 @@ void tick_freeze(void)
 		trace_suspend_resume(TPS("timekeeping_freeze"),
 				     smp_processor_id(), true);
 		system_state = SYSTEM_SUSPEND;
+		sched_clock_suspend();
 		timekeeping_suspend();
 	} else {
 		tick_suspend_local();
@@ -510,6 +511,7 @@ void tick_unfreeze(void)
 
 	if (tick_freeze_depth == num_online_cpus()) {
 		timekeeping_resume();
+		sched_clock_resume();
 		system_state = SYSTEM_RUNNING;
 		trace_suspend_resume(TPS("timekeeping_freeze"),
 				     smp_processor_id(), false);
diff --git a/kernel/time/timekeeping.h b/kernel/time/timekeeping.h
index 7a9b4eb7a1d5..141ab3ab0354 100644
--- a/kernel/time/timekeeping.h
+++ b/kernel/time/timekeeping.h
@@ -14,6 +14,13 @@ extern u64 timekeeping_max_deferment(void);
 extern void timekeeping_warp_clock(void);
 extern int timekeeping_suspend(void);
 extern void timekeeping_resume(void);
+#ifdef CONFIG_GENERIC_SCHED_CLOCK
+extern int sched_clock_suspend(void);
+extern void sched_clock_resume(void);
+#else
+static inline int sched_clock_suspend(void) { return 0; }
+static inline void sched_clock_resume(void) { }
+#endif
 
 extern void do_timer(unsigned long ticks);
 extern void update_wall_time(void);
