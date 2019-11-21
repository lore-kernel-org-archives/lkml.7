Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6547C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B094F206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfKUQsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 11:48:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:32926 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfKUQsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:48:23 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXpcm-0000Yw-1p; Thu, 21 Nov 2019 17:48:08 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A807F1C1A3D;
        Thu, 21 Nov 2019 17:48:07 +0100 (CET)
Date:   Thu, 21 Nov 2019 16:48:07 -0000
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] leds: Use all-in-one vtime aware kcpustat accessor
Cc:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191121024430.19938-6-frederic@kernel.org>
References: <20191121024430.19938-6-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <157435488761.21853.4853862724156729541.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8688f2fb671b2ed59b1b16083136b6edc3750435
Gitweb:        https://git.kernel.org/tip/8688f2fb671b2ed59b1b16083136b6edc3750435
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Thu, 21 Nov 2019 03:44:29 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 21 Nov 2019 07:58:48 +01:00

leds: Use all-in-one vtime aware kcpustat accessor

We can now safely read user kcpustat fields on nohz_full CPUs.
Use the appropriate accessor.

[ mingo: Fixed build failure. ]

Reported-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com> (maintainer:LED SUBSYSTEM)
Cc: Pavel Machek <pavel@ucw.cz> (maintainer:LED SUBSYSTEM)
Cc: Dan Murphy <dmurphy@ti.com> (reviewer:LED SUBSYSTEM)
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Link: https://lkml.kernel.org/r/20191121024430.19938-6-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/leds/trigger/ledtrig-activity.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-activity.c b/drivers/leds/trigger/ledtrig-activity.c
index ddfc5ed..14ba7fa 100644
--- a/drivers/leds/trigger/ledtrig-activity.c
+++ b/drivers/leds/trigger/ledtrig-activity.c
@@ -57,11 +57,15 @@ static void led_activity_function(struct timer_list *t)
 	curr_used = 0;
 
 	for_each_possible_cpu(i) {
-		curr_used += kcpustat_cpu(i).cpustat[CPUTIME_USER]
-			  +  kcpustat_cpu(i).cpustat[CPUTIME_NICE]
-			  +  kcpustat_field(&kcpustat_cpu(i), CPUTIME_SYSTEM, i)
-			  +  kcpustat_cpu(i).cpustat[CPUTIME_SOFTIRQ]
-			  +  kcpustat_cpu(i).cpustat[CPUTIME_IRQ];
+		struct kernel_cpustat kcpustat;
+
+		kcpustat_cpu_fetch(&kcpustat, i);
+
+		curr_used += kcpustat.cpustat[CPUTIME_USER]
+			  +  kcpustat.cpustat[CPUTIME_NICE]
+			  +  kcpustat.cpustat[CPUTIME_SYSTEM]
+			  +  kcpustat.cpustat[CPUTIME_SOFTIRQ]
+			  +  kcpustat.cpustat[CPUTIME_IRQ];
 		cpus++;
 	}
 
