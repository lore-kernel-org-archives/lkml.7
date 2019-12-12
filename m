Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6135C04E30
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 04:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D9A222C4
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 04:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JAVUepPx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfLLELy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 23:11:54 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46079 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbfLLELw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 23:11:52 -0500
Received: by mail-qt1-f196.google.com with SMTP id p5so1080808qtq.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 20:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VcDhvGQ0HFCMHix0zaC9dIQROZgnD8ueiSix94LexR8=;
        b=JAVUepPxlepyey7fO/Yk7azK9lSxzBSR7c3u7vSAx2oE3iFywg4J9CM/EPxx/y6e5V
         oiZCJUsTfNKre3YIFKQzHNRzJYlUffdwWd7ZU8FleF0YJnsUjCgHGhl/4rSkOFSSnC8m
         xKhBUSehQrbDz+7K7en81JebNyHEDC/yuUfV0eDMztZs/XCi3UtthcajE6NW5McdkDBf
         SpwOfc6lgJNAslSvr/7wQYIUtoYJQMXvWNXCseWP5LPHs24tPjylCTHoQIylYWlgRWjd
         3adETcMR2hNpgOJfIXy6gn2KLALTRZk4/zOtcKMDTkYe04fcvdJ69TZeiwk3alTQdSQe
         P/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VcDhvGQ0HFCMHix0zaC9dIQROZgnD8ueiSix94LexR8=;
        b=bFQ34WUlbS/GNqVZYWRZGULg9PsJjVwKje3B21h3+y9oMCrSxMNwB9Iaj5vc2cj/cM
         oAqvPHzcLa+I6ghwf8f0omqPu+k30h1Vlwb1XCmn4WVegneuhJ8p/MTLecpYFx1NHCqr
         FtRtKTVxYBokU7LWGf+U6wwQzZf2bSUEd2jfrh9EjMQu/PvZrgQz+037qzgh1BNzbaQ2
         Fp0dz5Pa9SvdrBfl2ju6tQosVifT2hJkocqljdE7efzauS4MqshB8BW3tUwhNzxdE8US
         qRNGqwAKnc8djzQxuFEWemyscJnoRC06ea5x/LWlTfZVLXDagsFv/BIUsSBx+rm18kFv
         V2Zw==
X-Gm-Message-State: APjAAAV7Iz7g0CzsoudT57y+GWk73COpVeEV185r3IO9pTWqK9tdv7fP
        cYNOII2N2+Krno/xSIhZqkzX7Q==
X-Google-Smtp-Source: APXvYqxPkAKaBOttdciL/h+kS8GDCzyaD4F3RpCQu1vc783em6YE+FaGz7an4gtVr3T5GLooroeGvA==
X-Received: by 2002:ac8:508:: with SMTP id u8mr5946084qtg.128.1576123911781;
        Wed, 11 Dec 2019 20:11:51 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id s11sm1364126qkg.99.2019.12.11.20.11.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Dec 2019 20:11:51 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v6 1/7] sched/pelt.c: Add support to track thermal pressure
Date:   Wed, 11 Dec 2019 23:11:42 -0500
Message-Id: <1576123908-12105-2-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1576123908-12105-1-git-send-email-thara.gopinath@linaro.org>
References: <1576123908-12105-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extrapolating on the existing framework to track rt/dl utilization using
pelt signals, add a similar mechanism to track thermal pressure. The
difference here from rt/dl utilization tracking is that, instead of
tracking time spent by a cpu running a rt/dl task through util_avg, the
average thermal pressure is tracked through load_avg. This is because
thermal pressure signal is weighted "delta" capacity and is not
binary(util_avg is binary). "delta capacity" here means delta between the
actual capacity of a cpu and the decreased capacity a cpu due to a thermal
event.

In order to track average thermal pressure, a new sched_avg variable
avg_thermal is introduced. Function update_thermal_load_avg can be called
to do the periodic bookkeeping (accumulate, decay and average) of the
thermal pressure.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
---

v5->v6:
	- added trace support for thermal pressure pelt signal.

 include/trace/events/sched.h |  4 ++++
 kernel/sched/pelt.c          | 22 ++++++++++++++++++++++
 kernel/sched/pelt.h          |  7 +++++++
 kernel/sched/sched.h         |  1 +
 4 files changed, 34 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 420e80e..a8fb667 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -613,6 +613,10 @@ DECLARE_TRACE(pelt_dl_tp,
 	TP_PROTO(struct rq *rq),
 	TP_ARGS(rq));
 
+DECLARE_TRACE(pelt_thermal_tp,
+	TP_PROTO(struct rq *rq),
+	TP_ARGS(rq));
+
 DECLARE_TRACE(pelt_irq_tp,
 	TP_PROTO(struct rq *rq),
 	TP_ARGS(rq));
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index a96db50..9aac3b7 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -353,6 +353,28 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 	return 0;
 }
 
+/*
+ * thermal:
+ *
+ *   load_sum = \Sum se->avg.load_sum
+ *
+ *   util_avg and runnable_load_avg are not supported and meaningless.
+ *
+ */
+int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
+{
+	if (___update_load_sum(now, &rq->avg_thermal,
+			       capacity,
+			       capacity,
+			       capacity)) {
+		___update_load_avg(&rq->avg_thermal, 1, 1);
+		trace_pelt_thermal_tp(rq);
+		return 1;
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 /*
  * irq:
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index afff644..c74226d 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -6,6 +6,7 @@ int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se
 int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq);
 int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
 int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
+int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity);
 
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 int update_irq_load_avg(struct rq *rq, u64 running);
@@ -159,6 +160,12 @@ update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 }
 
 static inline int
+update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
+{
+	return 0;
+}
+
+static inline int
 update_irq_load_avg(struct rq *rq, u64 running)
 {
 	return 0;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 280a3c7..37bd7ef 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -944,6 +944,7 @@ struct rq {
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 	struct sched_avg	avg_irq;
 #endif
+	struct sched_avg	avg_thermal;
 	u64			idle_stamp;
 	u64			avg_idle;
 
-- 
2.1.4

