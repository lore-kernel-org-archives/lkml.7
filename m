Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB62C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 04:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA00222C4
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 04:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lEzOn69h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfLLEMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 23:12:01 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45321 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbfLLEL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 23:11:56 -0500
Received: by mail-qk1-f194.google.com with SMTP id x1so500482qkl.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 20:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gp6DVIMwVoklcyjDkqg4ILNDJLNp+8FQvrp1u97hUfE=;
        b=lEzOn69h/8U6OZo0Ylkp+ZDqv3WQYnl2Rz1FCJbfSsBWYxPEW8OYeIjjl5mKle9K2H
         +EY9aUHhVK84JduAxF0LdxrQ6aj0dvIxhxHUEjmeLLPOi2uMwnoyjusbqSwUdfCA3Hkl
         geObQvsPEtfnqcm9dmPFdLgfJdj/peIpg3lpEsjNJHfW9KvxoFdZkpv3udkcbywhzuxK
         ZtAHbNq1q9Wq72K/QV84rZf+x7hWYw+NFivL+tAz4kc1mfu2jHduamdDhjx+aoSiZf63
         NaMt1tbhDmXxbkiofYn90Cke/XRISuN4eyoI7SOtB3jNX+rKUT1MVa8u8urgpYVRE53l
         x60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gp6DVIMwVoklcyjDkqg4ILNDJLNp+8FQvrp1u97hUfE=;
        b=HgiKAtE2fOcQ/Mr1PFoSlBLvLcHL5a+mdo8FYp7EIxAu7OYG4fgC1OeNc1ks8SWwO2
         YkACvnzwZtLryoIgE8hFFejzOd1DIFR9tMKXM9uWb9UgeG62GDSmc3SlT1n/MpKgyBPZ
         17j/F7kZWt6kJgW7YJFxdamaXl48ZFPHoCuZTsFgmZLpnP/6KnimaNMOME2xLIGhMhkk
         aGEipW1yAuWQyfizJQVXmqJXArwy5MTU/y1zkSZtAo5FoFNoV40fyeCqnnvhLOBdsbEA
         kLJj0tGY3ymQ1YM/jqq6uIhtNVy3WgWe6DY/APf9NLCRWO1eh/Gu8h/hRe+OQMe/f7Ki
         DZBg==
X-Gm-Message-State: APjAAAWllmL0U6bu7S4f9XDenoTBu6D40g10Xzk7SDolj8auKkY+wsCQ
        ncXTL5pT/kMRDtImDdObWoS7DQ==
X-Google-Smtp-Source: APXvYqzsFRN1xGDPhUCBELwXZF+FevgU/e+FcnxPPSnQIZBMGe06Z/r9g7cJGkPlsSglMEefYlazkA==
X-Received: by 2002:a37:a70b:: with SMTP id q11mr6171161qke.393.1576123915314;
        Wed, 11 Dec 2019 20:11:55 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id s11sm1364126qkg.99.2019.12.11.20.11.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Dec 2019 20:11:54 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v6 4/7] sched/fair: Enable periodic update of average thermal pressure
Date:   Wed, 11 Dec 2019 23:11:45 -0500
Message-Id: <1576123908-12105-5-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1576123908-12105-1-git-send-email-thara.gopinath@linaro.org>
References: <1576123908-12105-1-git-send-email-thara.gopinath@linaro.org>
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
 kernel/sched/fair.c | 8 ++++++++
 1 file changed, 8 insertions(+)

v4->v5:
	- Updated both versions of update_blocked_averages to trigger the
	  process of computing average thermal pressure.
	- Updated others_have_blocked to considerd avg_thermal.load_avg.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 08a233e..e12a375 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7462,6 +7462,9 @@ static inline bool others_have_blocked(struct rq *rq)
 	if (READ_ONCE(rq->avg_dl.util_avg))
 		return true;
 
+	if (READ_ONCE(rq->avg_thermal.load_avg))
+		return true;
+
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 	if (READ_ONCE(rq->avg_irq.util_avg))
 		return true;
@@ -7487,6 +7490,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 {
 	const struct sched_class *curr_class;
 	u64 now = rq_clock_pelt(rq);
+	unsigned long thermal_pressure = arch_scale_thermal_capacity(cpu_of(rq));
 	bool decayed;
 
 	/*
@@ -7497,6 +7501,8 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 
 	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
 		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
+		  update_thermal_load_avg(rq_clock_task(rq), rq,
+					  thermal_pressure) 			|
 		  update_irq_load_avg(rq, 0);
 
 	if (others_have_blocked(rq))
@@ -10263,6 +10269,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 {
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &curr->se;
+	unsigned long thermal_pressure = arch_scale_thermal_capacity(cpu_of(rq));
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
@@ -10274,6 +10281,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 
 	update_misfit_status(curr, rq);
 	update_overutilized_status(task_rq(curr));
+	update_thermal_load_avg(rq_clock_task(rq), rq, thermal_pressure);
 }
 
 /*
-- 
2.1.4

