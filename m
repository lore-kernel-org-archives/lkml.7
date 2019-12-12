Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48551C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 04:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1377F24653
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 04:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V8Nbw7mU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbfLLEMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 23:12:12 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37093 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbfLLEMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 23:12:01 -0500
Received: by mail-qk1-f195.google.com with SMTP id m188so538887qkc.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 20:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6+qiJLEvyuiYORpTYpkszMQhGViiRl65Hb8NmS+Suao=;
        b=V8Nbw7mUeIrHldWS5nFNKfJdGB4qHiNdNTYjY1qvbgaYlBmG0UP0hXKMukl7iJK62b
         fjfc1gJpy19etdQ/JZT3fyGAtsxUbU0XX0mPd/nk9va0kJQYeKKb00xzx97uR1hVIpV9
         9bgn7w19rtWoFDB0X31dshrVh4CoKiCAKpv2O36os/lhfzlT/cItx7TooXcr1s2D/LjQ
         ncDctb1dKp/bbB6hOPS0IWVuu7qzRRuBZTUedwFL9MaeyYSloYHKI/5yZtWjYfPOKDYg
         UtcTVIAdFUUeXcZqudRTw4C1g0a1y0vzzpmgd+a6Zs8/mOeP0jYgm8o23/8esdUvxxvP
         jACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6+qiJLEvyuiYORpTYpkszMQhGViiRl65Hb8NmS+Suao=;
        b=hsR6XwvS0FuS2EjtY1Wtg+W90AXaaUxgsW/ZdfdoEqD6Drh/bnitNZi/v215ZBD2PY
         UgjD/BynBhImD8jE8aZLaKFgFgpQaC26zL6g+AI0n9wKHwQjp2dUuNK85lDSO4ZWNRpD
         vZXDn5P0hZxHVpRmdLurplOSbNfUc1DmImdVvBkwao9HJPtsYR/w87uNL0qwtfO8SU0C
         yc9BpEKd/2L8ho2QTStyR+M8dZiyxfXZ7OSj+CnkZQkRXIoLxL64mWWNkOvVaeRuOOgK
         OVcmYRzkUEVdlD7IKWpmOjFUZVq/V7XunJPeP4N0xBcQKSachfynxY4gcZa2qc6k/mEF
         SJpg==
X-Gm-Message-State: APjAAAWNg1CE9oEiPXO0K5zXYQqBPPs9fgviq9qnBdzRcIXMNhGiAnf3
        pnugJwaKkZsKOjlhLKMGe2jmeQ==
X-Google-Smtp-Source: APXvYqwNVgNQm2jR8zDbsOYILXkHxD5vxXDTEHmCNGFHepaXQj3yxAGuYq9Hgg7gAdfVwr5eJtYRWQ==
X-Received: by 2002:a37:a5d7:: with SMTP id o206mr6231110qke.227.1576123920124;
        Wed, 11 Dec 2019 20:12:00 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id s11sm1364126qkg.99.2019.12.11.20.11.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Dec 2019 20:11:59 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v6 7/7] sched/fair: Enable tuning of decay period
Date:   Wed, 11 Dec 2019 23:11:48 -0500
Message-Id: <1576123908-12105-8-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1576123908-12105-1-git-send-email-thara.gopinath@linaro.org>
References: <1576123908-12105-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thermal pressure follows pelt signas which means the decay period for
thermal pressure is the default pelt decay period. Depending on soc
charecteristics and thermal activity, it might be beneficial to decay
thermal pressure slower, but still in-tune with the pelt signals.  One way
to achieve this is to provide a command line parameter to set a decay
shift parameter to an integer between 0 and 10.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---

v4->v5:
	- Changed _coeff to _shift as per review comments on the list.
v5->v6:
	- as per review comments introduced rq_clock_thermal to return
	  clock shifted by the decay_shift.

 Documentation/admin-guide/kernel-parameters.txt |  5 ++++
 kernel/sched/fair.c                             | 34 +++++++++++++++++++++++--
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ade4e6e..ffe456d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4330,6 +4330,11 @@
 			incurs a small amount of overhead in the scheduler
 			but is useful for debugging and performance tuning.
 
+	sched_thermal_decay_shift=
+			[KNL, SMP] Set decay shift for thermal pressure signal.
+			Format: integer between 0 and 10
+			Default is 0.
+
 	skew_tick=	[KNL] Offset the periodic timer tick per cpu to mitigate
 			xtime_lock contention on larger systems, and/or RCU lock
 			contention on all systems with CONFIG_MAXSMP set.
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4840655..9154cf8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -86,6 +86,36 @@ static unsigned int normalized_sysctl_sched_wakeup_granularity	= 1000000UL;
 
 const_debug unsigned int sysctl_sched_migration_cost	= 500000UL;
 
+/**
+ * By default the decay is the default pelt decay period.
+ * The decay shift can change the decay period in
+ * multiples of 32.
+ *  Decay shift		Decay period(ms)
+ *	0			32
+ *	1			64
+ *	2			128
+ *	3			256
+ *	4			512
+ */
+static int sched_thermal_decay_shift;
+
+static inline u64 rq_clock_thermal(struct rq *rq)
+{
+	return rq_clock_task(rq) >> sched_thermal_decay_shift;
+}
+
+static int __init setup_sched_thermal_decay_shift(char *str)
+{
+	int _shift;
+
+	if (kstrtoint(str, 0, &_shift))
+		pr_warn("Unable to set scheduler thermal pressure decay shift parameter\n");
+
+	sched_thermal_decay_shift = clamp(_shift, 0, 10);
+	return 1;
+}
+__setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
+
 #ifdef CONFIG_SMP
 /*
  * For asym packing, by default the lower numbered CPU has higher priority.
@@ -7501,7 +7531,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 
 	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
 		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
-		  update_thermal_load_avg(rq_clock_task(rq), rq,
+		  update_thermal_load_avg(rq_clock_thermal(rq), rq,
 					  thermal_pressure) 			|
 		  update_irq_load_avg(rq, 0);
 
@@ -10288,7 +10318,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 
 	update_misfit_status(curr, rq);
 	update_overutilized_status(task_rq(curr));
-	update_thermal_load_avg(rq_clock_task(rq), rq, thermal_pressure);
+	update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure);
 }
 
 /*
-- 
2.1.4

