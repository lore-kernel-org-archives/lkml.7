Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47D7C5DF61
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 18:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1D421882
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 18:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="umHITE8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390817AbfKESty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 13:49:54 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39611 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390804AbfKEStx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 13:49:53 -0500
Received: by mail-qk1-f195.google.com with SMTP id 15so22135530qkh.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 10:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=006+GihIsoSJvx8BvSuuRbmJ7qmM9mq/EsT1uZpB9E8=;
        b=umHITE8Rim3P3C0vmPd1bi4DZRx1zdTbqjCJvqS24wBoTsh8ON4lbclj7QoYR/LAXt
         v81irwxh0cnz10y3uLwQ1f59uei8i1cknodeK+rMgBjswpicXC3nz77LMLSB14C0iObr
         q7NBo8rxaVDqt3gi9FAeWlL8mZu2A1c19m9C3yDhNftBac5oeJNUf0Skpfg9Y0MO5iP1
         f/NkI59MrPdaqfE193YlsGkC9NXaF0e7zO7YGBzhEI1UI3HqErcbcca8k2TjS9WkJRNp
         Osy4rOGNuTSa8CqqR0cF1OkuCJfbgYtDwS6rdcp24yQjN6W+Lx29FHqqDNJcg4Xe/crU
         MkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=006+GihIsoSJvx8BvSuuRbmJ7qmM9mq/EsT1uZpB9E8=;
        b=scZ8O3heyI0TvstdZh+b8rLESMaG5m6YJxkZNJJalbmPnQih4XJawKt386PHU/HVNW
         4ka9kBCEdOKzj7Vhz3skO4CvTegFegwf8O+oABUXuxvWGn/UmsMq476NziLUqv6n/aIL
         bZr08/4NuFQrZGN2263BHlIp3ueiUystTI8W+qV3BIhCFi2I8/8sKIP2fh9DTtJnVgXd
         MSgMR4cUGxeeiOQVsJ93Cq3fS+PWvTATd3Gs2FSqZCs8W1P9RwjFGG0dcPL9/mwjcWEQ
         04nvnpLtfkM4WpwfyWnw//rWq6iSRjV3ysr1STUZ6hkEx8n9yB7Yy+DDEBhiym90GXGQ
         snKQ==
X-Gm-Message-State: APjAAAWoWDsCb9PkjYJNSUjTbqfqa6b1W7Nt5I8x3FJT8Eor1IqPUajq
        I6MmNN8fJmN3ziUvH+549cVZ/g==
X-Google-Smtp-Source: APXvYqzy7tSL4rE/XGvucih6zgnW//zxAm/Rm85JT3+KbCerAvlztDB2kJZAlHSjLhhBbdfE4XDumg==
X-Received: by 2002:ae9:e109:: with SMTP id g9mr6485852qkm.50.1572979792141;
        Tue, 05 Nov 2019 10:49:52 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id j7sm6832565qkd.46.2019.11.05.10.49.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Nov 2019 10:49:51 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, qperret@google.com
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
Subject: [Patch v5 3/6] sched/fair: Enable periodic update of average thermal pressure
Date:   Tue,  5 Nov 2019 13:49:43 -0500
Message-Id: <1572979786-20361-4-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org>
References: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce support in CFS periodic tick and other bookkeeping apis
to trigger the process of computing average thermal pressure for a
cpu. Also consider avg_thermal.load_avg in others_have_blocked
which allows for decay of pelt signals.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---

v4->v5:
	- Updated both versions of update_blocked_averages to trigger the
	  process of computing average thermal pressure.
	- Updated others_have_blocked to considerd avg_thermal.load_avg.

 kernel/sched/fair.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2e907cc..9fb0494 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -92,6 +92,8 @@ const_debug unsigned int sysctl_sched_migration_cost	= 500000UL;
  */
 static DEFINE_PER_CPU(unsigned long, thermal_pressure);
 
+static void trigger_thermal_pressure_average(struct rq *rq);
+
 #ifdef CONFIG_SMP
 /*
  * For asym packing, by default the lower numbered CPU has higher priority.
@@ -7493,6 +7495,9 @@ static inline bool others_have_blocked(struct rq *rq)
 	if (READ_ONCE(rq->avg_dl.util_avg))
 		return true;
 
+	if (READ_ONCE(rq->avg_thermal.load_avg))
+		return true;
+
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 	if (READ_ONCE(rq->avg_irq.util_avg))
 		return true;
@@ -7580,6 +7585,8 @@ static void update_blocked_averages(int cpu)
 		done = false;
 
 	update_blocked_load_status(rq, !done);
+
+	trigger_thermal_pressure_average(rq);
 	rq_unlock_irqrestore(rq, &rf);
 }
 
@@ -7646,6 +7653,7 @@ static inline void update_blocked_averages(int cpu)
 	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
 	update_irq_load_avg(rq, 0);
 	update_blocked_load_status(rq, cfs_rq_has_blocked(cfs_rq) || others_have_blocked(rq));
+	trigger_thermal_pressure_average(rq);
 	rq_unlock_irqrestore(rq, &rf);
 }
 
@@ -9939,6 +9947,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 
 	update_misfit_status(curr, rq);
 	update_overutilized_status(task_rq(curr));
+
+	trigger_thermal_pressure_average(rq);
 }
 
 /*
-- 
2.1.4

