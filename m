Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C8FC282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2CB2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="QX2xvNH/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbfDWQSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:18:55 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:51757 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728693AbfDWQSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:18:51 -0400
Received: by mail-it1-f196.google.com with SMTP id s3so1150193itk.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=sDUlfF2aFbfqRV/YF6TsJqdnyD8zAGR0wCugT3x+Vbw=;
        b=QX2xvNH/Jiap8kkj9x6M6ghRDE82lM0K9cWquTeGQJLia38tUEu914Cb4JSAeyvmBS
         yi08lfi9D3dF31TKkdaNJ4zcxzEwRJXrmyxDuHmWM6HRQygPGZRTH7Rq8h0mfgLhk3Bw
         w/eZUcqGocwZurgDyY1yKhrwFNEKb/OJE0tco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=sDUlfF2aFbfqRV/YF6TsJqdnyD8zAGR0wCugT3x+Vbw=;
        b=O6ftO0n/UaVq6Q3HhT74nlYrrePquf2DiD3MV/cAmFTk8OARi81WNmfSPbFGr5kAbk
         dbbTAlJxI0PTTO/NRNiO/Pub+yreNnW4JMRiUcCYLeI7dvwgetH4NJTHeSnHXqj9bC6K
         2zgfR7NQEEUr/6ngNE2LGYqhtszCSJsNzapqVN9zYFXVo00DCPWevfbLSOcIhYdOQmOL
         shgOYLgd3SBEsvF/JaWnfJmBW8IuGLZqbQ8Pt0OC4rZ0dGyZXQKcmV1u6dgruTKII1rG
         GrKyJuad3dFp60IHiMiEQDV427sPiIeHGrkl5M6Qa1FZb8ySXBLt7PEQvICQLZbiRcH+
         w2xA==
X-Gm-Message-State: APjAAAXy7ZDSe/dytw7GfJgoqCa3/uDRPzOZiUmdO/Pgp9FOheWOqtkR
        z7e1rSvZ5dBo/J3G6QFwYZaA6w==
X-Google-Smtp-Source: APXvYqyr3Kcn7DSlv0CtcXUntwiIw+t5L83xkgh2vaZtP/0BmZJW3TIVL9uf0TBwbHWZCPrvdZtSpw==
X-Received: by 2002:a24:3682:: with SMTP id l124mr2583959itl.86.1556036330974;
        Tue, 23 Apr 2019 09:18:50 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id i70sm2886933ioa.14.2019.04.23.09.18.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 09:18:50 -0700 (PDT)
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
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v2 10/17] sched: Core-wide rq->lock
Date:   Tue, 23 Apr 2019 16:18:15 +0000
Message-Id: <5ecde9c230993481c45fd690e0cd896382fe953e.1556025155.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1556025155.git.vpillai@digitalocean.com>
References: <cover.1556025155.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1556025155.git.vpillai@digitalocean.com>
References: <cover.1556025155.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra (Intel) <peterz@infradead.org>

Introduce the basic infrastructure to have a core wide rq->lock.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/Kconfig.preempt |  7 +++-
 kernel/sched/core.c    | 91 ++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h   | 31 ++++++++++++++
 3 files changed, 128 insertions(+), 1 deletion(-)

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
index b883c70674ba..2f559d706b8e 100644
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
+	for_each_possible_cpu(cpu)
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
@@ -5865,6 +5929,28 @@ static void sched_rq_cpu_starting(unsigned int cpu)
 
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
@@ -6091,6 +6177,11 @@ void __init sched_init(void)
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

