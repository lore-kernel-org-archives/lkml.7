Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8D9C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D66A120672
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfKUQsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 11:48:16 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:32908 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfKUQsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:48:16 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXpcm-0000Yx-64; Thu, 21 Nov 2019 17:48:08 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C971B1C1A3E;
        Thu, 21 Nov 2019 17:48:07 +0100 (CET)
Date:   Thu, 21 Nov 2019 16:48:07 -0000
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpufreq: Use vtime aware kcpustat accessors for user time
Cc:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191121024430.19938-5-frederic@kernel.org>
References: <20191121024430.19938-5-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <157435488775.21853.13702570973874298046.tip-bot2@tip-bot2>
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

Commit-ID:     5720821ba1d845f0b91a9278137e9005c5f6931d
Gitweb:        https://git.kernel.org/tip/5720821ba1d845f0b91a9278137e9005c5f6931d
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Thu, 21 Nov 2019 03:44:28 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 21 Nov 2019 07:33:25 +01:00

cpufreq: Use vtime aware kcpustat accessors for user time

We can now safely read user and guest kcpustat fields on nohz_full CPUs.
Use the appropriate accessors.

Reported-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Link: https://lkml.kernel.org/r/20191121024430.19938-5-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/cpufreq/cpufreq.c          | 17 ++++++++++-------
 drivers/cpufreq/cpufreq_governor.c |  6 +++---
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 527fd06..ee23eaf 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -113,18 +113,21 @@ EXPORT_SYMBOL_GPL(get_governor_parent_kobj);
 
 static inline u64 get_cpu_idle_time_jiffy(unsigned int cpu, u64 *wall)
 {
-	u64 idle_time;
+	struct kernel_cpustat kcpustat;
 	u64 cur_wall_time;
+	u64 idle_time;
 	u64 busy_time;
 
 	cur_wall_time = jiffies64_to_nsecs(get_jiffies_64());
 
-	busy_time = kcpustat_cpu(cpu).cpustat[CPUTIME_USER];
-	busy_time += kcpustat_field(&kcpustat_cpu(cpu), CPUTIME_SYSTEM, cpu);
-	busy_time += kcpustat_cpu(cpu).cpustat[CPUTIME_IRQ];
-	busy_time += kcpustat_cpu(cpu).cpustat[CPUTIME_SOFTIRQ];
-	busy_time += kcpustat_cpu(cpu).cpustat[CPUTIME_STEAL];
-	busy_time += kcpustat_cpu(cpu).cpustat[CPUTIME_NICE];
+	kcpustat_cpu_fetch(&kcpustat, cpu);
+
+	busy_time = kcpustat.cpustat[CPUTIME_USER];
+	busy_time += kcpustat.cpustat[CPUTIME_SYSTEM];
+	busy_time += kcpustat.cpustat[CPUTIME_IRQ];
+	busy_time += kcpustat.cpustat[CPUTIME_SOFTIRQ];
+	busy_time += kcpustat.cpustat[CPUTIME_STEAL];
+	busy_time += kcpustat.cpustat[CPUTIME_NICE];
 
 	idle_time = cur_wall_time - busy_time;
 	if (wall)
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 4bb054d..f99ae45 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -105,7 +105,7 @@ void gov_update_cpu_data(struct dbs_data *dbs_data)
 			j_cdbs->prev_cpu_idle = get_cpu_idle_time(j, &j_cdbs->prev_update_time,
 								  dbs_data->io_is_busy);
 			if (dbs_data->ignore_nice_load)
-				j_cdbs->prev_cpu_nice = kcpustat_cpu(j).cpustat[CPUTIME_NICE];
+				j_cdbs->prev_cpu_nice = kcpustat_field(&kcpustat_cpu(j), CPUTIME_NICE, j);
 		}
 	}
 }
@@ -149,7 +149,7 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
 		j_cdbs->prev_cpu_idle = cur_idle_time;
 
 		if (ignore_nice) {
-			u64 cur_nice = kcpustat_cpu(j).cpustat[CPUTIME_NICE];
+			u64 cur_nice = kcpustat_field(&kcpustat_cpu(j), CPUTIME_NICE, j);
 
 			idle_time += div_u64(cur_nice - j_cdbs->prev_cpu_nice, NSEC_PER_USEC);
 			j_cdbs->prev_cpu_nice = cur_nice;
@@ -530,7 +530,7 @@ int cpufreq_dbs_governor_start(struct cpufreq_policy *policy)
 		j_cdbs->prev_load = 0;
 
 		if (ignore_nice)
-			j_cdbs->prev_cpu_nice = kcpustat_cpu(j).cpustat[CPUTIME_NICE];
+			j_cdbs->prev_cpu_nice = kcpustat_field(&kcpustat_cpu(j), CPUTIME_NICE, j);
 	}
 
 	gov->start(policy);
