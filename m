Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710E4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2D9218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbfCUMKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 08:10:18 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37914 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbfCUMKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 08:10:15 -0400
Received: from p200300d06f010d00c8d029af8ffc83b7.dip0.t-ipconnect.de ([2003:d0:6f01:d00:c8d0:29af:8ffc:83b7] helo=somnus.fritz.box)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <anna-maria@linutronix.de>)
        id 1h6wWR-00035a-Dn; Thu, 21 Mar 2019 13:10:11 +0100
From:   Anna-Maria Gleixner <anna-maria@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, fweisbec@gmail.com, peterz@infradead.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: [PATCH 1/4] tick-sched: Update tick_sched struct documentation
Date:   Thu, 21 Mar 2019 13:09:18 +0100
Message-Id: <20190321120921.16463-2-anna-maria@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321120921.16463-1-anna-maria@linutronix.de>
References: <20190321120921.16463-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adapt the documentation order of struct members to effective order of
struct members and add missing descriptions.

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
---
 kernel/time/tick-sched.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
index 6de959a854b2..4fb06527cf64 100644
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -24,12 +24,19 @@ enum tick_nohz_mode {
  * struct tick_sched - sched tick emulation and no idle tick control/stats
  * @sched_timer:	hrtimer to schedule the periodic tick in high
  *			resolution mode
+ * @check_clocks:	Notification mechanism about clocksource changes
+ * @nohz_mode:		Mode - one state of tick_nohz_mode
+ * @inidle:		Indicator that the CPU is in the tick idle mode
+ * @tick_stopped:	Indicator that the idle tick has been stopped
+ * @idle_active:	Indicator that the CPU is actively in the tick idle mode;
+ *			it is resetted during irq handling phases.
+ * @do_timer_lst:	CPU was the last one doing do_timer before going idle
+ * @got_idle_tick:	Tick timer function has run with @inidle set
  * @last_tick:		Store the last tick expiry time when the tick
  *			timer is modified for nohz sleeps. This is necessary
  *			to resume the tick timer operation in the timeline
  *			when the CPU returns from nohz sleep.
  * @next_tick:		Next tick to be fired when in dynticks mode.
- * @tick_stopped:	Indicator that the idle tick has been stopped
  * @idle_jiffies:	jiffies at the entry to idle for idle time accounting
  * @idle_calls:		Total number of idle calls
  * @idle_sleeps:	Number of idle calls, where the sched tick was stopped
@@ -40,8 +47,8 @@ enum tick_nohz_mode {
  * @iowait_sleeptime:	Sum of the time slept in idle with sched tick stopped, with IO outstanding
  * @timer_expires:	Anticipated timer expiration time (in case sched tick is stopped)
  * @timer_expires_base:	Base time clock monotonic for @timer_expires
- * @do_timer_lst:	CPU was the last one doing do_timer before going idle
- * @got_idle_tick:	Tick timer function has run with @inidle set
+ * @next_timer:		Expiry time of next expiring timer for debugging purpose only
+ * @tick_dep_mask:	Tick dependency mask - is set, if someone needs the tick
  */
 struct tick_sched {
 	struct hrtimer			sched_timer;
-- 
2.20.1

