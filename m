Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239EBC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 02:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E725C20878
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 02:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574304293;
	bh=dFaoUL/kjZQEWQ6Iam/kl52aRoyIpykAOKG/LDr/kZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gLTUAQ9Pjglcc0jzxsaJegxMrGCzuHPCEx5J5sxbylNvrRV6nhx7dWOT0P56t2KYT
	 ps6AlPOJObFQ1B5wGdpfhkKxiKuVnO2Z42JDH9aFlF4c2ZgKw+bkxERgWCzbgroOUx
	 xCSHDbiPJHBh2yEWVR5Zil3acvVeaVLTShjQkI1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfKUCow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 21:44:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:54384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbfKUCot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 21:44:49 -0500
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93E09208A3;
        Thu, 21 Nov 2019 02:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574304288;
        bh=dFaoUL/kjZQEWQ6Iam/kl52aRoyIpykAOKG/LDr/kZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oFjAcHXiE4gPg9y6z3F+zaBAHpmR2cqOUAzK6GlyTf2M0/RtNu3KstyT+0fT3zq1A
         /DpdBnFr0tR+xtECXtRzkEln3oVPGagFYXiarq8xVWKGTGP0rGQCHmhtR0shWkONae
         x5AbZuvW0KCnzrYU9F3HwVehqltUKF+HB+XYOmSo=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 4/6] cpufreq: Use vtime aware kcpustat accessors for user time
Date:   Thu, 21 Nov 2019 03:44:28 +0100
Message-Id: <20191121024430.19938-5-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191121024430.19938-1-frederic@kernel.org>
References: <20191121024430.19938-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can now safely read user and guest kcpustat fields on nohz_full CPUs.
Use the appropriate accessors.

Reported-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
---
 drivers/cpufreq/cpufreq.c          | 17 ++++++++++-------
 drivers/cpufreq/cpufreq_governor.c |  6 +++---
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 527fd068dc12..ee23eaf20f35 100644
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
index 4bb054d0cb43..f99ae45efaea 100644
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
-- 
2.23.0

