Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE1DC5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 18:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00ECA217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 18:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QdXBSTW3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390807AbfKEStx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 13:49:53 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34774 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390777AbfKEStw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 13:49:52 -0500
Received: by mail-qk1-f196.google.com with SMTP id 205so20804092qkk.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 10:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MuKIljDj+9SX43fxK+S80WZiAzsSjNwIox+BZEd7J9Y=;
        b=QdXBSTW3Kw+04AzcbpElRt6qPXZK2jBWi9b0TUpFBvqZ0jmUJOZZHqzE+mRkRFKjAB
         LIgnHG3qWbcnUjh3S4Fh3Lrek+Gg/zooK+jHZpo8dThwVz2dIyrHzNA3V+aIoar16Mh7
         pGBz8VLs516af0LQJLcX0y2e7OqEldy7wlSMhox6c94zO8ORMNjmlSm5Yg63kmN2m/ZC
         WOfuCz8LtqhCnicyW7RZf3CId1Mey1UkdOOiYLXbk/TDL0ry/+X71a1a34S+g7L10xaL
         Hl3dVbgvaJf19263O+gF06VVYMUvmKzK/Rr2I5IFnU0AVkSdrZerFRHPaB3AHsaI36Ed
         nnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MuKIljDj+9SX43fxK+S80WZiAzsSjNwIox+BZEd7J9Y=;
        b=MqJ9L4K/l/EvAaFajwhxaLFPv40EKxfBrm4xzvsQaFnKTcJ4Kq1t8u24PEKnBDIT4E
         BwsEAbImxwHC6zs/h72lY9q9CtGfXX05vf3qD4bMZ/rlPaBKdK6cF800byON3Ok7AbY6
         UnuMJ6jMpBLuxzTS/bxt3J3uABIIc+XkNUOniBjj1SFeMkzon/eaCTnkfqJ2C9ZyuD0n
         Y2Sltt1JDyH6SsAk+caXnX3FRmVSCr6hqBDx8UkPxw1UyVf2wctc9g8Gp2MV1ESWjgy2
         u81T+Srg/Ww9ADyMpmU9LFkavCh6//xa0ziQr5i6+3ctRDzcAiCxpWAPJLDU4WW5jJnH
         YOkw==
X-Gm-Message-State: APjAAAUhFrg3k/FsV+dYrocJ8WZCNBHDWZUQtWl6sbSJz06eUEHBixjk
        HV2b10RuGFO7UtFoa+YZOqmshQ==
X-Google-Smtp-Source: APXvYqwBKaw/+c0WOMmgqfEgWBQ1IrGvhqsixWQU4Eyy2c0kmcJWhMf73iqORztqp1E1Bk+gRpcbYA==
X-Received: by 2002:a37:6c47:: with SMTP id h68mr12942464qkc.30.1572979790881;
        Tue, 05 Nov 2019 10:49:50 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id j7sm6832565qkd.46.2019.11.05.10.49.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Nov 2019 10:49:50 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, qperret@google.com
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
Subject: [Patch v5 2/6] sched/fair: Add infrastructure to store and update  instantaneous thermal pressure
Date:   Tue,  5 Nov 2019 13:49:42 -0500
Message-Id: <1572979786-20361-3-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org>
References: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interface APIs to initialize, update/average, track, accumulate
and decay thermal pressure per cpu basis. A per cpu variable
thermal_pressure is introduced to keep track of instantaneous per
cpu thermal pressure. Thermal pressure is the delta between maximum
capacity and capped capacity due to a thermal event.
API trigger_thermal_pressure_average is called for periodic accumulate
and decay of the thermal pressure.This API passes on the instantaneous
thermal pressure of a cpu to update_thermal_load_avg to do the necessary
accumulate, decay and average.
API update_thermal_pressure is for the system to update the thermal
pressure by providing a capped maximum capacity.
Considering, trigger_thermal_pressure_average reads thermal_pressure and
update_thermal_pressure writes into thermal_pressure, one can argue for
some sort of locking mechanism to avoid a stale value.
But considering trigger_thermal_pressure_average can be called from a
system critical path like scheduler tick function, a locking mechanism
is not ideal. This means that it is possible the thermal_pressure value
used to calculate average thermal pressure for a cpu can be
stale for upto 1 tick period.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---

v3->v4:
        - Dropped per cpu max_capacity_info struct and instead added a per
          delta_capacity variable to store the delta between maximum
          capacity and capped capacity. The delta is now calculated when
          thermal pressure is updated and not every tick.
        - Dropped populate_max_capacity_info api as only per cpu delta
          capacity is stored.
        - Renamed update_periodic_maxcap to
          trigger_thermal_pressure_average and update_maxcap_capacity to
          update_thermal_pressure.
v4->v5:
	- As per Peter's review comments folded thermal.c into fair.c.
	- As per Ionela's review comments revamped update_thermal_pressure
	  to take maximum available capacity as input instead of maximum
	  capped frequency ration.

---
 include/linux/sched.h |  9 +++++++++
 kernel/sched/fair.c   | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 263cf08..3c31084 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1993,6 +1993,15 @@ static inline void rseq_syscall(struct pt_regs *regs)
 
 #endif
 
+#ifdef CONFIG_SMP
+void update_thermal_pressure(int cpu, unsigned long capped_capacity);
+#else
+static inline void
+update_thermal_pressure(int cpu, unsigned long capped_capacity)
+{
+}
+#endif
+
 const struct sched_avg *sched_trace_cfs_rq_avg(struct cfs_rq *cfs_rq);
 char *sched_trace_cfs_rq_path(struct cfs_rq *cfs_rq, char *str, int len);
 int sched_trace_cfs_rq_cpu(struct cfs_rq *cfs_rq);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 682a754..2e907cc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -86,6 +86,12 @@ static unsigned int normalized_sysctl_sched_wakeup_granularity	= 1000000UL;
 
 const_debug unsigned int sysctl_sched_migration_cost	= 500000UL;
 
+/*
+ * Per-cpu instantaneous delta between maximum capacity
+ * and maximum available capacity due to thermal events.
+ */
+static DEFINE_PER_CPU(unsigned long, thermal_pressure);
+
 #ifdef CONFIG_SMP
 /*
  * For asym packing, by default the lower numbered CPU has higher priority.
@@ -10401,6 +10407,37 @@ static unsigned int get_rr_interval_fair(struct rq *rq, struct task_struct *task
 	return rr_interval;
 }
 
+#ifdef CONFIG_SMP
+/**
+ * update_thermal_pressure: Update thermal pressure
+ * @cpu: the cpu for which thermal pressure is to be updated for
+ * @capped_capacity: maximum capacity of the cpu after the capping
+ *		     due to thermal event.
+ *
+ * Delta between the arch_scale_cpu_capacity and capped max capacity is
+ * stored in per cpu thermal_pressure variable.
+ */
+void update_thermal_pressure(int cpu, unsigned long capped_capacity)
+{
+	unsigned long delta;
+
+	delta = arch_scale_cpu_capacity(cpu) - capped_capacity;
+	per_cpu(thermal_pressure, cpu) = delta;
+}
+#endif
+
+/**
+ * trigger_thermal_pressure_average: Trigger the thermal pressure accumulate
+ *				     and average algorithm
+ */
+static void trigger_thermal_pressure_average(struct rq *rq)
+{
+#ifdef CONFIG_SMP
+	update_thermal_load_avg(rq_clock_task(rq), rq,
+				per_cpu(thermal_pressure, cpu_of(rq)));
+#endif
+}
+
 /*
  * All the scheduling class methods:
  */
-- 
2.1.4

