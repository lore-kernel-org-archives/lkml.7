Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58845C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 338342087B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfHSKrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 06:47:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:57720 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726477AbfHSKrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 06:47:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A3571B649;
        Mon, 19 Aug 2019 10:47:41 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Laurence Oberman <loberman@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH 3/3] Test softlockup
Date:   Mon, 19 Aug 2019 12:47:32 +0200
Message-Id: <20190819104732.20966-4-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190819104732.20966-1-pmladek@suse.com>
References: <20190819104732.20966-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trigger busy loop by:
$> cat /proc/version

Stop the busy loop by:
$> cat /proc/consoles

The code also shows the first touch*watchdog() function that hides
softlockup on a "well known" location.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 fs/proc/consoles.c |  5 +++++
 fs/proc/version.c  |  7 +++++++
 kernel/watchdog.c  | 25 ++++++++++++++++++++++++-
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/fs/proc/consoles.c b/fs/proc/consoles.c
index dfe6ce3505ce..213c0a209a7c 100644
--- a/fs/proc/consoles.c
+++ b/fs/proc/consoles.c
@@ -9,6 +9,8 @@
 #include <linux/seq_file.h>
 #include <linux/tty_driver.h>
 
+extern volatile bool proc_version_wait;
+
 /*
  * This is handler for /proc/consoles
  */
@@ -30,6 +32,9 @@ static int show_console_dev(struct seq_file *m, void *v)
 	unsigned int a;
 	dev_t dev = 0;
 
+	printk("%s: Going to break /proc/version infinite loop\n", __func__);
+	proc_version_wait = false;
+
 	if (con->device) {
 		const struct tty_driver *driver;
 		int index;
diff --git a/fs/proc/version.c b/fs/proc/version.c
index b449f186577f..15ec6a502589 100644
--- a/fs/proc/version.c
+++ b/fs/proc/version.c
@@ -6,8 +6,15 @@
 #include <linux/seq_file.h>
 #include <linux/utsname.h>
 
+volatile bool proc_version_wait;
+
 static int version_proc_show(struct seq_file *m, void *v)
 {
+	printk("%s: Going to wait until stopped\n", __func__);
+	proc_version_wait = true;
+	while (proc_version_wait)
+		cpu_relax();
+
 	seq_printf(m, linux_proc_banner,
 		utsname()->sysname,
 		utsname()->release,
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 2058229ed398..3bfe6fbc468b 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -172,6 +172,7 @@ static DEFINE_PER_CPU(unsigned long, watchdog_touch_ts);
 static DEFINE_PER_CPU(unsigned long, watchdog_period_ts);
 static DEFINE_PER_CPU(struct hrtimer, watchdog_hrtimer);
 static DEFINE_PER_CPU(bool, watchdog_restart_period);
+static DEFINE_PER_CPU(bool, watchdog_report_restart_period);
 static DEFINE_PER_CPU(bool, softlockup_touch_sync);
 static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts);
 static DEFINE_PER_CPU(unsigned long, soft_lockup_hrtimer_cnt);
@@ -259,6 +260,7 @@ static void __restart_watchdog_period(void)
 {
 	__this_cpu_write(watchdog_period_ts, get_timestamp());
 	__this_cpu_write(watchdog_restart_period, false);
+	__this_cpu_write(watchdog_report_restart_period, false);
 }
 
 /* Commands for resetting the watchdog */
@@ -283,6 +285,13 @@ notrace void touch_softlockup_watchdog_sched(void)
 	 * period gets restarted here, so use the raw_ operation.
 	 */
 	raw_cpu_write(watchdog_restart_period, true);
+
+	if (raw_cpu_read(watchdog_report_restart_period)) {
+		printk_deferred("Softlockup watchdog need reset from %s\n",
+			__func__);
+		trace_dump_stack(0);
+		raw_cpu_write(watchdog_report_restart_period, false);
+	}
 }
 
 notrace void touch_softlockup_watchdog(void)
@@ -305,8 +314,15 @@ void touch_all_softlockup_watchdogs(void)
 	 * update as well, the only side effect might be a cycle delay for
 	 * the softlockup check.
 	 */
-	for_each_cpu(cpu, &watchdog_allowed_mask)
+	for_each_cpu(cpu, &watchdog_allowed_mask) {
 		per_cpu(watchdog_restart_period, cpu) = true;
+
+		if (per_cpu(watchdog_report_restart_period, cpu) == true) {
+			WARN(1, "Softlockup watchdog need reset\n");
+			per_cpu(watchdog_report_restart_period, cpu) = false;
+		}
+	}
+
 	wq_watchdog_touch(-1);
 }
 
@@ -314,6 +330,11 @@ void touch_softlockup_watchdog_sync(void)
 {
 	__this_cpu_write(softlockup_touch_sync, true);
 	__this_cpu_write(watchdog_restart_period, true);
+
+	if (raw_cpu_read(watchdog_report_restart_period)) {
+		WARN(1, "Softlockup watchdog need reset\n");
+		raw_cpu_write(watchdog_report_restart_period, false);
+	}
 }
 
 static int is_softlockup(unsigned long touch_ts, unsigned long period_ts)
@@ -461,6 +482,8 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);
 		if (softlockup_panic)
 			panic("softlockup: hung tasks");
+
+		__this_cpu_write(watchdog_report_restart_period, true);
 	}
 
 	return HRTIMER_RESTART;
-- 
2.16.4

