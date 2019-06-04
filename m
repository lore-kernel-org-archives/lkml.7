Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC13EC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A036E24DB4
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cgSw4BkY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfFDHB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 03:01:59 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39886 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbfFDHB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:01:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id j2so12099031pfe.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 00:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LitjvBr4bQliAtyzrQ3myX1ZLOUmkF/pxyOjBUuK5wI=;
        b=cgSw4BkYceLudx3qOurpScu2yKys2klZc/YFTk0GmoCddDhw6tOPdNwdDuzpizVmow
         ulPVFKjwur1S6ghfyYcF6EkKFXwFfbPHFxOJG0TP6S4dLIyOrvPES1hZpgqWIaWQUlUE
         J8Tl9kUXODEpMtYgiWyG5ntFqhUwDBXqA7SssqczE082P2RojzxjLZb7ARTBKg+jKnwm
         l6gI4ymR8SisEqbrU8eEW2F2m5KuJ7SvT0FJdmW3YeFeeS7vG4B94tggLkp5XKccloga
         De68CUivRr3EalYUSnHSXFxJNEzA5CH8hT8TWqgFi1NOCy2OcuRvS/wWiAjJ0PlB+l0J
         q2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LitjvBr4bQliAtyzrQ3myX1ZLOUmkF/pxyOjBUuK5wI=;
        b=tficY7qNQsfAE1Isy9zLil85AczMsRo5nbeKig+yHHyMqukW7QBZKVYznclq2yr8El
         hgmY+oPu410guZBJTqI29qRciThQgJ2547Y00oJ1n3OqBgMQXpWAAe6Sc3mK6hhTzLw3
         S794oVHWjnWnvHW0kjCSZUI5QbN3wbIMUgz7c0B3Pe032cCBJer6rrgb3lZB7v9B9CMv
         iYhulZ0FxH0HVGRwHbHw2XVw7rAz1eHCM9lDVsvjUQqXjejfBe6tJr/0Be0A8D+G84m8
         VZNIZWNCZ8yx6+G5h3JFBfaXxhdd/PXLge+kzDhqDjtCTqhCdIyl8lcTlsEcB9TMXyfE
         WHqg==
X-Gm-Message-State: APjAAAXJLfsErfICXR6cVkdSf+a7FPIOpkhZk3m9cAkAAeLCTcfuhPyb
        2BFqG61FuhT0B0LxJCRjXgtlzA==
X-Google-Smtp-Source: APXvYqyfT6zbyWhetjWpj8Uf27dOsluS9TMwvJIH4RqSf5LpM/UoWBdN7dK4F96ERPVaRxF6IaQzgg==
X-Received: by 2002:a63:144e:: with SMTP id 14mr33175907pgu.304.1559631718309;
        Tue, 04 Jun 2019 00:01:58 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id h12sm8007109pfr.38.2019.06.04.00.01.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 00:01:57 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair: Introduce fits_capacity()
Date:   Tue,  4 Jun 2019 12:31:52 +0530
Message-Id: <b477ac75a2b163048bdaeb37f57b4c3f04f75a31.1559631700.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same formula to check utilization against capacity (after
considering capacity_margin) is already used at 5 different locations.

This patch creates a new macro, fits_capacity(), which can be used from
all these locations without exposing the details of it and hence
simplify code.

All the 5 code locations are updated as well to use it..

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/fair.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7f8d477f90fe..db3a218b7928 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -102,6 +102,8 @@ int __weak arch_asym_cpu_priority(int cpu)
  * (default: ~20%)
  */
 static unsigned int capacity_margin			= 1280;
+
+#define fits_capacity(cap, max)	((cap) * capacity_margin < (max) * 1024)
 #endif
 
 #ifdef CONFIG_CFS_BANDWIDTH
@@ -3727,7 +3729,7 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
 
 static inline int task_fits_capacity(struct task_struct *p, long capacity)
 {
-	return capacity * 1024 > task_util_est(p) * capacity_margin;
+	return fits_capacity(task_util_est(p), capacity);
 }
 
 static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
@@ -5143,7 +5145,7 @@ static inline unsigned long cpu_util(int cpu);
 
 static inline bool cpu_overutilized(int cpu)
 {
-	return (capacity_of(cpu) * 1024) < (cpu_util(cpu) * capacity_margin);
+	return !fits_capacity(cpu_util(cpu), capacity_of(cpu));
 }
 
 static inline void update_overutilized_status(struct rq *rq)
@@ -6304,7 +6306,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			/* Skip CPUs that will be overutilized. */
 			util = cpu_util_next(cpu, p, cpu);
 			cpu_cap = capacity_of(cpu);
-			if (cpu_cap * 1024 < util * capacity_margin)
+			if (!fits_capacity(util, cpu_cap))
 				continue;
 
 			/* Always use prev_cpu as a candidate. */
@@ -7853,8 +7855,7 @@ group_is_overloaded(struct lb_env *env, struct sg_lb_stats *sgs)
 static inline bool
 group_smaller_min_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
 {
-	return sg->sgc->min_capacity * capacity_margin <
-						ref->sgc->min_capacity * 1024;
+	return fits_capacity(sg->sgc->min_capacity, ref->sgc->min_capacity);
 }
 
 /*
@@ -7864,8 +7865,7 @@ group_smaller_min_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
 static inline bool
 group_smaller_max_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
 {
-	return sg->sgc->max_capacity * capacity_margin <
-						ref->sgc->max_capacity * 1024;
+	return fits_capacity(sg->sgc->max_capacity, ref->sgc->max_capacity);
 }
 
 static inline enum
-- 
2.21.0.rc0.269.g1a574e7a288b

