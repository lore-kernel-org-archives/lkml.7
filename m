Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D87CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4124221479
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731304AbfJ2Jwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:52:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47759 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfJ2Jwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:52:35 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iPOAl-0004MG-A2; Tue, 29 Oct 2019 10:52:19 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DC3AB1C0073;
        Tue, 29 Oct 2019 10:52:18 +0100 (CET)
Date:   Tue, 29 Oct 2019 09:52:18 -0000
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpufreq: Use vtime aware kcpustat accessor to fetch
 CPUTIME_SYSTEM
Cc:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wanpeng Li <wanpengli@tencent.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191016025700.31277-14-frederic@kernel.org>
References: <20191016025700.31277-14-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <157234273861.29376.7297572510244687373.tip-bot2@tip-bot2>
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

Commit-ID:     49bb001e246d3a44692f8418c8e38d9ef4aa405f
Gitweb:        https://git.kernel.org/tip/49bb001e246d3a44692f8418c8e38d9ef4aa405f
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 16 Oct 2019 04:56:59 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 29 Oct 2019 10:01:18 +01:00

cpufreq: Use vtime aware kcpustat accessor to fetch CPUTIME_SYSTEM

Now that we have a vtime safe kcpustat accessor for CPUTIME_SYSTEM, use
it to start fixing frozen kcpustat values on nohz_full CPUs.

Reported-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J . Wysocki <rjw@rjwysocki.net>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wanpeng Li <wanpengli@tencent.com>
Link: https://lkml.kernel.org/r/20191016025700.31277-14-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index c52d6fa..a37ebfd 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -120,7 +120,7 @@ static inline u64 get_cpu_idle_time_jiffy(unsigned int cpu, u64 *wall)
 	cur_wall_time = jiffies64_to_nsecs(get_jiffies_64());
 
 	busy_time = kcpustat_cpu(cpu).cpustat[CPUTIME_USER];
-	busy_time += kcpustat_cpu(cpu).cpustat[CPUTIME_SYSTEM];
+	busy_time += kcpustat_field(&kcpustat_cpu(cpu), CPUTIME_SYSTEM, cpu);
 	busy_time += kcpustat_cpu(cpu).cpustat[CPUTIME_IRQ];
 	busy_time += kcpustat_cpu(cpu).cpustat[CPUTIME_SOFTIRQ];
 	busy_time += kcpustat_cpu(cpu).cpustat[CPUTIME_STEAL];
