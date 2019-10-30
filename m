Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DE2CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E62E20856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="LqEm6i8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfJ3SeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 14:34:25 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33349 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbfJ3SeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 14:34:19 -0400
Received: by mail-yw1-f66.google.com with SMTP id v5so1207019ywd.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 11:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=zHCANWKkTeb6Y1hhG8NL8+V3n0Ipmi5CGrrLZMsqGAc=;
        b=LqEm6i8izQhrhdxhwwHDbtbCqHcG3Kx9IsUHZHfsQvk+Bj5zbTnyqzRrsg8BFHkjQD
         hTPMSzidg/JeQyYHKmQAq+XlFv0hilB/ZuVTX6/qgvHzGDYUPQtBvsw1QRjKUrwFRn/A
         Ta1cSgQ8Pcna++kIypLKkFGXIjRqFbmUfBbsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=zHCANWKkTeb6Y1hhG8NL8+V3n0Ipmi5CGrrLZMsqGAc=;
        b=ip8QX0FbXdAXOU1Ku1+BWtTzjaQeoFvujo+fkdEyb6cdif9xXSE8+j3Ki/y7rQq51i
         bDwhVguXzLpg3xtbGnE7jxKiHogpmnZWCAR1PTqmIdtpTKUJiax3DYj9qQc69xf4Gpzl
         cDj0SlGbpK85IdJ8GbSm2IOZyktlR4T114hYh/qKMETIz+hSxju626DNoNK0FxvQah12
         Nz2KRx+paQ6MNGGEtALeU9nLZ0nePrdPZig2KL9efSutYAZT2rAScRIh8yiuamg9WTtY
         mnhyekPSXqNiCfjwbC/z1AKjx5SRf2nWT0G9pb80Z8CKnHLnWGvvjda+BNaJZi0Il5Fn
         SmhQ==
X-Gm-Message-State: APjAAAWK5VG8STkMVjEoqw7iRUCMrddJFHaF/N0DY/UN7TmMUZwR8u+0
        JR33sJM2YQw8CAUjgtI11nYtkw==
X-Google-Smtp-Source: APXvYqzAzcsBP73Nqem6xaQXmHiioI4rOvq1YQK9hjxoE6LnyzsgjJs04uKScutrEDvRT0U8Da1nEg==
X-Received: by 2002:a81:6288:: with SMTP id w130mr846602ywb.434.1572460458387;
        Wed, 30 Oct 2019 11:34:18 -0700 (PDT)
Received: from vpillai-dev.sfo2.internal.digitalocean.com ([138.68.32.68])
        by smtp.gmail.com with ESMTPSA id a141sm544846ywe.88.2019.10.30.11.34.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Oct 2019 11:34:18 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Dario Faggioli <dfaggioli@suse.com>,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>
Subject: [RFC PATCH v4 10/19] sched: Core-wide rq->lock
Date:   Wed, 30 Oct 2019 18:33:23 +0000
Message-Id: <d248a875aab737f867e04897f03372682fda384f.1572437285.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1572437285.git.vpillai@digitalocean.com>
References: <cover.1572437285.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1572437285.git.vpillai@digitalocean.com>
References: <cover.1572437285.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Introduce the basic infrastructure to have a core wide rq->lock.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
---
 kernel/Kconfig.preempt |   6 +++
 kernel/sched/core.c    | 113 ++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h   |  31 +++++++++++
 3 files changed, 148 insertions(+), 2 deletions(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index deff97217496..63493a1b9ff6 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -80,3 +80,9 @@ config PREEMPT_COUNT
 config PREEMPTION
        bool
        select PREEMPT_COUNT
+
+config SCHED_CORE
+	bool
+	default y
+	depends on SCHED_SMT
+
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1f40211ff29a..0427cf610d6a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -72,6 +72,70 @@ __read_mostly int scheduler_running;
  */
 int sysctl_sched_rt_runtime = 950000;
 
+#ifdef CONFIG_SCHED_CORE
+
+DEFINE_STATIC_KEY_FALSE(__sched_core_enabled);
+
+/*
+ * The static-key + stop-machine variable are needed such that:
+ *
+ *	spin_lock(rq_lockp(rq));
+ *	...
+ *	spin_unlock(rq_lockp(rq));
+ *
+ * ends up locking and unlocking the _same_ lock, and all CPUs
+ * always agree on what rq has what lock.
+ *
+ * XXX entirely possible to selectively enable cores, don't bother for now.
+ */
+static int __sched_core_stopper(void *data)
+{
+	bool enabled = !!(unsigned long)data;
+	int cpu;
+
+	for_each_online_cpu(cpu)
+		cpu_rq(cpu)->core_enabled = enabled;
+
+	return 0;
+}
+
+static DEFINE_MUTEX(sched_core_mutex);
+static int sched_core_count;
+
+static void __sched_core_enable(void)
+{
+	// XXX verify there are no cookie tasks (yet)
+
+	static_branch_enable(&__sched_core_enabled);
+	stop_machine(__sched_core_stopper, (void *)true, NULL);
+}
+
+static void __sched_core_disable(void)
+{
+	// XXX verify there are no cookie tasks (left)
+
+	stop_machine(__sched_core_stopper, (void *)false, NULL);
+	static_branch_disable(&__sched_core_enabled);
+}
+
+void sched_core_get(void)
+{
+	mutex_lock(&sched_core_mutex);
+	if (!sched_core_count++)
+		__sched_core_enable();
+	mutex_unlock(&sched_core_mutex);
+}
+
+void sched_core_put(void)
+{
+	mutex_lock(&sched_core_mutex);
+	if (!--sched_core_count)
+		__sched_core_disable();
+	mutex_unlock(&sched_core_mutex);
+}
+
+#endif /* CONFIG_SCHED_CORE */
+
 /*
  * __task_rq_lock - lock the rq @p resides on.
  */
@@ -6210,8 +6274,15 @@ int sched_cpu_activate(unsigned int cpu)
 	/*
 	 * When going up, increment the number of cores with SMT present.
 	 */
-	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
+	if (cpumask_weight(cpu_smt_mask(cpu)) == 2) {
 		static_branch_inc_cpuslocked(&sched_smt_present);
+#ifdef CONFIG_SCHED_CORE
+		if (static_branch_unlikely(&__sched_core_enabled)) {
+			rq->core_enabled = true;
+		}
+#endif
+	}
+
 #endif
 	set_cpu_active(cpu, true);
 
@@ -6259,8 +6330,16 @@ int sched_cpu_deactivate(unsigned int cpu)
 	/*
 	 * When going down, decrement the number of cores with SMT present.
 	 */
-	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
+	if (cpumask_weight(cpu_smt_mask(cpu)) == 2) {
+#ifdef CONFIG_SCHED_CORE
+		struct rq *rq = cpu_rq(cpu);
+		if (static_branch_unlikely(&__sched_core_enabled)) {
+			rq->core_enabled = false;
+		}
+#endif
 		static_branch_dec_cpuslocked(&sched_smt_present);
+
+	}
 #endif
 
 	if (!sched_smp_initialized)
@@ -6285,6 +6364,28 @@ static void sched_rq_cpu_starting(unsigned int cpu)
 
 int sched_cpu_starting(unsigned int cpu)
 {
+#ifdef CONFIG_SCHED_CORE
+	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
+	struct rq *rq, *core_rq = NULL;
+	int i;
+
+	for_each_cpu(i, smt_mask) {
+		rq = cpu_rq(i);
+		if (rq->core && rq->core == rq)
+			core_rq = rq;
+	}
+
+	if (!core_rq)
+		core_rq = cpu_rq(cpu);
+
+	for_each_cpu(i, smt_mask) {
+		rq = cpu_rq(i);
+
+		WARN_ON_ONCE(rq->core && rq->core != core_rq);
+		rq->core = core_rq;
+	}
+#endif /* CONFIG_SCHED_CORE */
+
 	sched_rq_cpu_starting(cpu);
 	sched_tick_start(cpu);
 	return 0;
@@ -6313,6 +6414,9 @@ int sched_cpu_dying(unsigned int cpu)
 	update_max_interval();
 	nohz_balance_exit_idle(rq);
 	hrtick_clear(rq);
+#ifdef CONFIG_SCHED_CORE
+	rq->core = NULL;
+#endif
 	return 0;
 }
 #endif
@@ -6507,6 +6611,11 @@ void __init sched_init(void)
 #endif /* CONFIG_SMP */
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
+
+#ifdef CONFIG_SCHED_CORE
+		rq->core = NULL;
+		rq->core_enabled = 0;
+#endif
 	}
 
 	set_load_weight(&init_task, false);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 44f45aad3f97..2ba68ab093ee 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -991,6 +991,12 @@ struct rq {
 	/* Must be inspected within a rcu lock section */
 	struct cpuidle_state	*idle_state;
 #endif
+
+#ifdef CONFIG_SCHED_CORE
+	/* per rq */
+	struct rq		*core;
+	unsigned int		core_enabled;
+#endif
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -1018,11 +1024,36 @@ static inline int cpu_of(struct rq *rq)
 #endif
 }
 
+#ifdef CONFIG_SCHED_CORE
+DECLARE_STATIC_KEY_FALSE(__sched_core_enabled);
+
+static inline bool sched_core_enabled(struct rq *rq)
+{
+	return static_branch_unlikely(&__sched_core_enabled) && rq->core_enabled;
+}
+
+static inline raw_spinlock_t *rq_lockp(struct rq *rq)
+{
+	if (sched_core_enabled(rq))
+		return &rq->core->__lock;
+
+	return &rq->__lock;
+}
+
+#else /* !CONFIG_SCHED_CORE */
+
+static inline bool sched_core_enabled(struct rq *rq)
+{
+	return false;
+}
+
 static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 {
 	return &rq->__lock;
 }
 
+#endif /* CONFIG_SCHED_CORE */
+
 #ifdef CONFIG_SCHED_SMT
 extern void __update_idle_core(struct rq *rq);
 
-- 
2.17.1

