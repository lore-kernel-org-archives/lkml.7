Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5C7C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 805DD217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="WeY8rFlJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388937AbfDRMTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:19:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46057 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfDRMTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:19:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3ICJCmT183163
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Apr 2019 05:19:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3ICJCmT183163
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555589953;
        bh=3nFvfzTAZ9q3v/P4XXGPZDGpXZFloR1KUw+rxneJ+Oc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=WeY8rFlJ4qvzmvqSKw7M5VyfEXq/HdTmvYhv2puf6GnPEQJlXo5e2PUkxsthWI7Hf
         7g4rawjZC7nl1tEGSH15rN5W8Wz5AKI2gx5ZwidZgQDfim1rbogKSckVpXyOr+F3iV
         Ew38YQRrrpq/ZXjjSo4h9a2Bx0Zo04PQWbkMgv1YD7rF6zwABIBt4SIZ1NKh25BxpD
         d1yabi8xiqsFWnbqEF49jAygQIQ0scCJwG/xwMNTmPgbABDlDJHwrZNz1GfyLnzvum
         IX/W0b1Qz/JcleMZGR7CTawZJXqc8vneMqlFeLKjYuzk6WRImhVjkgHsnyJ/Hf8Cv0
         jJggLXfrN7wWw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3ICJ87h183157;
        Thu, 18 Apr 2019 05:19:08 -0700
Date:   Thu, 18 Apr 2019 05:19:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Chang-An Chen <tipbot@zytor.com>
Message-ID: <tip-fe4a9a665de982b9eeb4a5e61f9c1c1abe80fb51@git.kernel.org>
Cc:     freddy.hsin@mediatek.com, kuohong.wang@mediatek.com,
        chang-an.chen@mediatek.com, hpa@zytor.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        matthias.bgg@gmail.com, tglx@linutronix.de, cminyard@mvista.com,
        john.stultz@linaro.org, linux-mediatek@lists.infradead.org,
        stanley.chu@mediatek.com, linux-arm-kernel@lists.infradead.org,
        fweisbec@gmail.com
Reply-To: matthias.bgg@gmail.com, tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          keescook@chromium.org, kuohong.wang@mediatek.com,
          freddy.hsin@mediatek.com, chang-an.chen@mediatek.com,
          fweisbec@gmail.com, stanley.chu@mediatek.com,
          linux-arm-kernel@lists.infradead.org,
          linux-mediatek@lists.infradead.org, cminyard@mvista.com,
          john.stultz@linaro.org
In-Reply-To: <1553828349-8914-1-git-send-email-chang-an.chen@mediatek.com>
References: <1553828349-8914-1-git-send-email-chang-an.chen@mediatek.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] tiemrs/sched_clock: Prevent generic sched_clock
 wrap caused by tick_freeze()
Git-Commit-ID: fe4a9a665de982b9eeb4a5e61f9c1c1abe80fb51
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  fe4a9a665de982b9eeb4a5e61f9c1c1abe80fb51
Gitweb:     https://git.kernel.org/tip/fe4a9a665de982b9eeb4a5e61f9c1c1abe80fb51
Author:     Chang-An Chen <chang-an.chen@mediatek.com>
AuthorDate: Fri, 29 Mar 2019 10:59:09 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 18 Apr 2019 14:16:31 +0200

tiemrs/sched_clock: Prevent generic sched_clock wrap caused by tick_freeze()

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

---
 kernel/time/sched_clock.c | 4 ++--
 kernel/time/tick-common.c | 2 ++
 kernel/time/timekeeping.h | 7 +++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

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
