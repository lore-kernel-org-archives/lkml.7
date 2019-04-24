Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1371C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B11DC21904
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127466;
	bh=lc1/zObNnva57+7m9GouAyI2BVETz5hkSCCcNIqe52I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HVji1sfecUjEsYuOplh0zTRRvS/HXXwS6ZztQHOLHVw7xUuRe90C+6AuzVmyLI5tc
	 FR3a0XBCTMeiZjBXaMZQ7PNcZGG48SMrdzkTlfDyRp4cnNixSPiBkR2mdfqYd0m1CS
	 WmXX1kQrhVy0nCA6caYJuhHAvmpol12TqivWosFc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392262AbfDXRhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:37:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392243AbfDXRhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:37:42 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C4B421903;
        Wed, 24 Apr 2019 17:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127460;
        bh=lc1/zObNnva57+7m9GouAyI2BVETz5hkSCCcNIqe52I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jguL99SG5kHJZO8MJcsQAoyTbuSWHhaLitUVjGFSPEfmqlUTl9x8KeytL87y2czu1
         +m3wbWNqu1z3RyIHMp417+x6eLvtYY+10xPhx7N4/hvsExGfVrkWCgb/ChplY3HHGt
         WJWPjtg/EHbYvG4E16sKV4eh9T1i5vkpt5CwA6Zc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chang-An Chen <chang-an.chen@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Corey Minyard <cminyard@mvista.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Stanley Chu <stanley.chu@mediatek.com>,
        kuohong.wang@mediatek.com, freddy.hsin@mediatek.com
Subject: [PATCH 5.0 099/115] timers/sched_clock: Prevent generic sched_clock wrap caused by tick_freeze()
Date:   Wed, 24 Apr 2019 19:10:35 +0200
Message-Id: <20190424170930.567577364@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chang-An Chen <chang-an.chen@mediatek.com>

commit 3f2552f7e9c5abef2775c53f7af66532f8bf65bc upstream.

tick_freeze() introduced by suspend-to-idle in commit 124cf9117c5f ("PM /
sleep: Make it possible to quiesce timers during suspend-to-idle") uses
timekeeping_suspend() instead of syscore_suspend() during
suspend-to-idle. As a consequence generic sched_clock will keep going
because sched_clock_suspend() and sched_clock_resume() are not invoked
during suspend-to-idle which can result in a generic sched_clock wrap.

On a ARM system with suspend-to-idle enabled, sched_clock is registered
as "56 bits at 13MHz, resolution 76ns, wraps every 4398046511101ns", which
means the real wrapping duration is 8796093022202ns.

[  134.551779] suspend-to-idle suspend (timekeeping_suspend())
[ 1204.912239] suspend-to-idle resume (timekeeping_resume())
......
[ 1206.912239] suspend-to-idle suspend (timekeeping_suspend())
[ 5880.502807] suspend-to-idle resume (timekeeping_resume())
......
[ 6000.403724] suspend-to-idle suspend (timekeeping_suspend())
[ 8035.753167] suspend-to-idle resume  (timekeeping_resume())
......
[ 8795.786684] (2)[321:charger_thread]......
[ 8795.788387] (2)[321:charger_thread]......
[    0.057226] (0)[0:swapper/0]......
[    0.061447] (2)[0:swapper/2]......

sched_clock was not stopped during suspend-to-idle, and sched_clock_poll
hrtimer was not expired because timekeeping_suspend() was invoked during
suspend-to-idle. It makes sched_clock wrap at kernel time 8796s.

To prevent this, invoke sched_clock_suspend() and sched_clock_resume() in
tick_freeze() together with timekeeping_suspend() and timekeeping_resume().

Fixes: 124cf9117c5f (PM / sleep: Make it possible to quiesce timers during suspend-to-idle)
Signed-off-by: Chang-An Chen <chang-an.chen@mediatek.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Corey Minyard <cminyard@mvista.com>
Cc: <linux-mediatek@lists.infradead.org>
Cc: <linux-arm-kernel@lists.infradead.org>
Cc: Stanley Chu <stanley.chu@mediatek.com>
Cc: <kuohong.wang@mediatek.com>
Cc: <freddy.hsin@mediatek.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/1553828349-8914-1-git-send-email-chang-an.chen@mediatek.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/time/sched_clock.c |    4 ++--
 kernel/time/tick-common.c |    2 ++
 kernel/time/timekeeping.h |    7 +++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -272,7 +272,7 @@ static u64 notrace suspended_sched_clock
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
--- a/kernel/time/timekeeping.h
+++ b/kernel/time/timekeeping.h
@@ -14,6 +14,13 @@ extern u64 timekeeping_max_deferment(voi
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


