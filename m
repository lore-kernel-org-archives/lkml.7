Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9539C28CC1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B94C324188
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="Wi/MRGO6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfE2UhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 16:37:17 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54063 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfE2UhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 16:37:08 -0400
Received: by mail-it1-f194.google.com with SMTP id m141so6266146ita.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 13:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=lwET0beq5pl4oSbeOvuaaIgrZTWI8s2oR42jUjpKplA=;
        b=Wi/MRGO6nV2pF57kSsdOc7FTMA7tCxeJzXtcyXoeJjg5/gcLgPdyjE6zUgnlCmCaFE
         PKrlXJ3t8WlTpM8xFkJ9m2bRbkw3aOhUVSC0Ve3WAQgEovHoCljVdNB2exbVICRftNKA
         Ec4/j8N07RvjT8VegxuBG8hvcTt3c9fiwO7hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=lwET0beq5pl4oSbeOvuaaIgrZTWI8s2oR42jUjpKplA=;
        b=MVaz87YjE8UC4aJgbB9VnvfMtbEx/CnWdvnlhY4ZpAzaGGE5e+j/Exk9gJbC/uZe8P
         4aJz1RCuFTj8W0dx3N4ppPooN1p4RXdL42+BOiWzlxPkmNr4LRZSSVYzyKfgi7IgsJVh
         rnwVFxn5WY5vvG4f8NBY5m5VPZFy0RtcNH/kyrmQb+1imxNZ/jN1RlUhSDGuDP7MlAtT
         ISnF65MifeJO26rmbykc/XrEzW2ICTd98TWLPBL62vRpP1BjMnZG+EhSl0nrRvDvFM9d
         dqewyiWETEY6fRGBjJsdVMrGaCZ9V3j0fpPdmNC0cBh/qe/VE5LxN/y6LP9nMknreQIV
         Jzzg==
X-Gm-Message-State: APjAAAW8XDGqcR/+3enHWcNIyhU8m/DT/64My1iiUzrj5Rc0FChGIkd4
        xaQvnD+unCxo8GfPT2WjElz93g==
X-Google-Smtp-Source: APXvYqybJqRRayy7BCRuOGu3xm1V8vGvFMSc/eHpx9MTWUS4dWxX+0Y0/uoVW3NeyPHHKZsGhIolVw==
X-Received: by 2002:a24:ed03:: with SMTP id r3mr169682ith.47.1559162227113;
        Wed, 29 May 2019 13:37:07 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id o192sm191958itb.0.2019.05.29.13.37.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 13:37:06 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>
Subject: [RFC PATCH v3 10/16] sched: Core-wide rq->lock
Date:   Wed, 29 May 2019 20:36:46 +0000
Message-Id: <a03795e66ed45469ac5b3c1b1d01c8ed33be299f.1559129225.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1559129225.git.vpillai@digitalocean.com>
References: <cover.1559129225.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1559129225.git.vpillai@digitalocean.com>
References: <cover.1559129225.git.vpillai@digitalocean.com>
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

Changes in v3
-------------
- Fixes a crash during cpu offline/offline with coresched enabled
  - Vineeth Pillai

 kernel/Kconfig.preempt |   7 ++-
 kernel/sched/core.c    | 113 ++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h   |  31 +++++++++++
 3 files changed, 148 insertions(+), 3 deletions(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 0fee5fe6c899..02fe0bf26676 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -57,4 +57,9 @@ config PREEMPT
 endchoice
 
 config PREEMPT_COUNT
-       bool
+	bool
+
+config SCHED_CORE
+	bool
+	default y
+	depends on SCHED_SMT
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b883c70674ba..b1ce33f9b106 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -60,6 +60,70 @@ __read_mostly int scheduler_running;
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
@@ -5790,8 +5854,15 @@ int sched_cpu_activate(unsigned int cpu)
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
 
@@ -5839,8 +5910,16 @@ int sched_cpu_deactivate(unsigned int cpu)
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
@@ -5865,6 +5944,28 @@ static void sched_rq_cpu_starting(unsigned int cpu)
 
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
@@ -5893,6 +5994,9 @@ int sched_cpu_dying(unsigned int cpu)
 	update_max_interval();
 	nohz_balance_exit_idle(rq);
 	hrtick_clear(rq);
+#ifdef CONFIG_SCHED_CORE
+	rq->core = NULL;
+#endif
 	return 0;
 }
 #endif
@@ -6091,6 +6195,11 @@ void __init sched_init(void)
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
index a024dd80eeb3..eb38063221d0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -952,6 +952,12 @@ struct rq {
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
@@ -979,11 +985,36 @@ static inline int cpu_of(struct rq *rq)
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

