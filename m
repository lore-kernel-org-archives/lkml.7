Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35804C18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8CBA204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="cZE7mPJd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbfEVJJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 05:09:03 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36795 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfEVJJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 05:09:02 -0400
Received: by mail-pf1-f194.google.com with SMTP id v80so998488pfa.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 02:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=77VWXjnj0J97wSyDWwRJhsJZaq/DQDIPWjSs9tQqrDc=;
        b=cZE7mPJdiYHkEJt0ZeYDpctVeEVRzXK7dh1HLrav6uXS7j2YVwEb3KiRegPUVuF6rC
         al5/Qgt5GKGHsZh0VzDr+aJjxyp7ns6xOoCMNFxNA4dJmwBcUnD+5MTbgiNuWhcCXOLG
         rc9AMq1TuFgbhoJcZVQQ8sqGbts55toiqHR+RyPyJYXe/XXQx4Q2E8aZPycSBpO/W2yg
         51QjGiFstomNo88c5E2ZARkocTvhjiIT2wWol5JrZwGmyAKbzPNZlPPeeJF4fMZYx8jU
         g0tClu7yAG8QB8vtqR0NHdZdAx+/hyaE2RiU3OlgMzFgOn75qfViNsY/PbV3H1zwxbA7
         Afnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=77VWXjnj0J97wSyDWwRJhsJZaq/DQDIPWjSs9tQqrDc=;
        b=WUHLc+idQfy/0tFaNlWxkiLUrMAyLGWsf1Dnm3yi5QNRVFY1quKZmefgeBis5rYeGZ
         eNqH1cePjQdiHT7mYN99atoebP2H8a8nrmlWtHGSmr4jr9+J/Efwn5M3i7Yp+MwSkAj6
         W0E5gWIJSFUc4055lynwx/fNnnH2ruZUixIzIkdeWX1s27S0CU7dAGTfis/ZhZbRaJSU
         Jj1vN6tSREUpO5FIO4H5jKd+dd/d3GB0Ko9QJpDX6lto3bggG+BNPFgur9hLXs8RS+fN
         QzWOg2yvpHxIFYQUnS3gCYd73uS1Yj9SC5ODoVYBfHxXQFe6H4cqooou/8AXgrocVXef
         bstQ==
X-Gm-Message-State: APjAAAXdxowAwBz7NX9M06ms7UlTb/OU4NaLrgQuBxPqOH3Mu5G1eqAL
        ex9gylWoRJ9uDogUByqbgEaW9g==
X-Google-Smtp-Source: APXvYqynLczwVGfNprMN09ZwuPsza9FqdQpdLnOFcSHOQj4j1rUKb/RcGt686nvYsT99YeSr5jXaJw==
X-Received: by 2002:a62:128a:: with SMTP id 10mr93717838pfs.225.1558516142213;
        Wed, 22 May 2019 02:09:02 -0700 (PDT)
Received: from always-ThinkPad-T480.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id a64sm24131408pgc.53.2019.05.22.02.08.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 May 2019 02:09:01 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, pizhenwei@bytedance.com
Subject: [PATCH] sched: idle: Support nohlt_list kernel parameter
Date:   Wed, 22 May 2019 17:08:56 +0800
Message-Id: <1558516136-17601-1-git-send-email-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently kernel only supports hlt&nohlt kernel parameters, all the
CPUs would poll or not in idle. Guest OS can't control power in KVM
virtualization, so we can only choose high performance by nohlt or
CPU overcommit by hlt.
nohlt_list kernel parameter allows the specified CPU(s) to poll,
and other CPUs still halt in idle.

We can config boot parameter in guest(Ex, 16vCPUs on x86) like this:
    linux ... irqaffinity=0,2,4,6 nohlt_list=0,2,4,6
it means that 25% of CPUs can always run in vm-mode and benefit
from posted-interrupt.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 kernel/sched/idle.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 80940939b733..5a0c3498258b 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -50,6 +50,37 @@ static int __init cpu_idle_nopoll_setup(char *__unused)
 	return 1;
 }
 __setup("hlt", cpu_idle_nopoll_setup);
+
+static cpumask_var_t cpu_nohlt_cpumask __cpumask_var_read_mostly;
+static int __init cpu_idle_poll_list_setup(char *str)
+{
+	alloc_bootmem_cpumask_var(&cpu_nohlt_cpumask);
+	if (cpulist_parse(str, cpu_nohlt_cpumask)) {
+		pr_warn("idle: nohlt_list= incorrect CPU range\n");
+		cpumask_clear(cpu_nohlt_cpumask);
+	} else
+		pr_info("idle: nohlt_list=%s\n", str);
+
+	return 1;
+}
+__setup("nohlt_list=", cpu_idle_poll_list_setup);
+
+static inline bool cpu_idle_should_poll(void)
+{
+	int cpu;
+
+	if (cpu_idle_force_poll)
+		return !!cpu_idle_force_poll;
+
+	cpu = smp_processor_id();
+	return (cpumask_available(cpu_nohlt_cpumask) &&
+			!!cpumask_test_cpu(cpu, cpu_nohlt_cpumask));
+}
+#else
+static inline bool cpu_idle_should_poll(void)
+{
+	return !!cpu_idle_force_poll;
+}
 #endif
 
 static noinline int __cpuidle cpu_idle_poll(void)
@@ -60,7 +91,7 @@ static noinline int __cpuidle cpu_idle_poll(void)
 	stop_critical_timings();
 
 	while (!tif_need_resched() &&
-		(cpu_idle_force_poll || tick_check_broadcast_expired()))
+		(cpu_idle_should_poll() || tick_check_broadcast_expired()))
 		cpu_relax();
 	start_critical_timings();
 	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
@@ -256,7 +287,7 @@ static void do_idle(void)
 		 * broadcast device expired for us, we don't want to go deep
 		 * idle as we know that the IPI is going to arrive right away.
 		 */
-		if (cpu_idle_force_poll || tick_check_broadcast_expired()) {
+		if (cpu_idle_should_poll() || tick_check_broadcast_expired()) {
 			tick_nohz_idle_restart_tick();
 			cpu_idle_poll();
 		} else {
-- 
2.11.0

