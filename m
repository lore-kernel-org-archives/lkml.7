Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD06C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2CD222C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573009771;
	bh=sRM8DR0YqS/lZ1PMnOVfKMIDZkvxrSpwhL41FZyOjhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jxWgSLsnp3dkc3RoLJjnladksJ0CaYWmu7NdkjnF/VZVveYCcQwbqR1cl2lMmBE6W
	 e0fARXD1i41iGtbhVM7qf6U0wwj4f0dLQQWV/cOPJQic49FFWhM9sRCtJvQsJjVBpk
	 M9WiQGQN6w53brIRQ4Ol9pfJDnZFJQqnmH8NFPaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388452AbfKFDIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:08:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:44524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388362AbfKFDIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:08:38 -0500
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E1AC222C2;
        Wed,  6 Nov 2019 03:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573009716;
        bh=sRM8DR0YqS/lZ1PMnOVfKMIDZkvxrSpwhL41FZyOjhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=peyebjBPV0PF9E++n6sRanwlVHiPktUPJnPwXxOBJtU2KKmav7VacK3yApQgOVEno
         hFglw0/PROLHektJLpbPM1mC6C9pF0wg6sF9UQfivmurLDQwnqxm7UmsN6DAP8T5cz
         8ol41NwGrfHD/JUAgAS//4561YOLewoxXqQTvVWw=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Pavel Machek <pavel@ucw.cz>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 7/9] cpufreq: Use vtime aware kcpustat accessors for user time
Date:   Wed,  6 Nov 2019 04:08:05 +0100
Message-Id: <20191106030807.31091-8-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106030807.31091-1-frederic@kernel.org>
References: <20191106030807.31091-1-frederic@kernel.org>
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
 drivers/cpufreq/cpufreq.c          | 13 +++++++++----
 drivers/cpufreq/cpufreq_governor.c |  6 +++---
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a37ebfd7e0e8..cdc44a854ae1 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -113,18 +113,23 @@ EXPORT_SYMBOL_GPL(get_governor_parent_kobj);
 
 static inline u64 get_cpu_idle_time_jiffy(unsigned int cpu, u64 *wall)
 {
-	u64 idle_time;
+	struct kernel_cpustat *kcpustat = &kcpustat_cpu(cpu);
+	u64 user, nice, sys, guest, guest_nice;
 	u64 cur_wall_time;
+	u64 idle_time;
 	u64 busy_time;
 
 	cur_wall_time = jiffies64_to_nsecs(get_jiffies_64());
 
-	busy_time = kcpustat_cpu(cpu).cpustat[CPUTIME_USER];
-	busy_time += kcpustat_field(&kcpustat_cpu(cpu), CPUTIME_SYSTEM, cpu);
+	kcpustat_cputime(kcpustat, cpu, &user, &nice, &sys,
+			 &guest, &guest_nice);
+
+	busy_time = user;
+	busy_time += sys;
 	busy_time += kcpustat_cpu(cpu).cpustat[CPUTIME_IRQ];
 	busy_time += kcpustat_cpu(cpu).cpustat[CPUTIME_SOFTIRQ];
 	busy_time += kcpustat_cpu(cpu).cpustat[CPUTIME_STEAL];
-	busy_time += kcpustat_cpu(cpu).cpustat[CPUTIME_NICE];
+	busy_time += nice;
 
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

