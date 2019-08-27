Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DBFC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F27C21883
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="MEgtzQOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730979AbfH0TCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 15:02:15 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42507 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730952AbfH0TCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:02:13 -0400
Received: by mail-pl1-f195.google.com with SMTP id y1so12183618plp.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 12:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=message-id:from:to:cc:subject:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l2HH3yqh4YMHE66TVCHzTA40REQhZPyQRZi45oHqbXM=;
        b=MEgtzQOR8WZjAd8dvedW95fHI+nuEZ1Revzch1/+Q8e+X07S+qOWfJeZp4e8wjhkTm
         /1ghw4Lui3PBIFsa7q9TN59gAlpnz8DDOxPvxrcG4YqVOytphe9rnTRGEPAqiVoXdky7
         y+r7yf3AJlA2MI4wcb12Ycwlk5CBhDjbAE+Rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:to:cc:subject:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l2HH3yqh4YMHE66TVCHzTA40REQhZPyQRZi45oHqbXM=;
        b=gSUeAGFhtl+KWc709i/XEenaVhvJfClSmKf1jj1/EFSNweAQU45s03q1xSVZ5SXPwh
         cO5uIm7t7DAf52gEfVZRo5hK3/11ZJtNNQUzYoA9orkW1pDzRpVq3DUPa7xdmnMTSraL
         Gcp7/OuAX1JvIFguq/9xlMANooMCWVHF2m/stImBPKe9yubdZHEeX5+VHL+J+0e80rQ6
         naIv5/hJ03eOn+KHEHZW/7LeRqY+zRbU0Q2duzZ+ZAzlBlb6gjLeeW3+2aBWuRQauCN5
         GA7kSgNhXGUMOq6X4E9y+C2J07hC2YNhYf6p/RlgDtPFdALaZRZ8nPdZkhbihI/5a0RI
         HKKw==
X-Gm-Message-State: APjAAAX0NVCawjZ+AGwaRylRiG3/Zz8f5PI0mqSfIbZx/kWYqw+fpF89
        NCXYlluWwTf/7EAnnL5e0+cepStzzFs=
X-Google-Smtp-Source: APXvYqw5bY9tROJp6Y2sQtr0bctZoWkXWVWrgeAaateOcNrvfNBJH/AKxRiGB/Wukqmjxo5XBdmv7g==
X-Received: by 2002:a17:902:6a:: with SMTP id 97mr383930pla.5.1566932531829;
        Tue, 27 Aug 2019 12:02:11 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id k14sm33196pfi.98.2019.08.27.12.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 12:02:11 -0700 (PDT)
Message-ID: <5d657e33.1c69fb81.54250.01dd@mx.google.com>
X-Google-Original-Message-ID: 1566932472151157@cam.corp.google.com
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        byungchul.park@lge.com, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, kernel-team@android.com
Subject: [PATCH 1/5] rcu/rcuperf: Add kfree_rcu() performance Tests
Date:   Tue, 27 Aug 2019 15:01:55 -0400
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: 156693247224727@cam.corp.google.com
References: 156693247224727@cam.corp.google.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This test runs kfree_rcu() in a loop to measure performance of the new
kfree_rcu() batching functionality.

The following table shows results when booting with arguments:
rcuperf.kfree_loops=20000 rcuperf.kfree_alloc_num=8000 rcuperf.kfree_rcu_test=1

In addition, rcuperf.kfree_no_batch is used to toggle the batching of
kfree_rcu()s for a test run.

patch applied		GPs	time (seconds)
 yes			1732	14.5
 no			9133 	11.5

On a 16 CPU system with the above boot parameters, we see that the total
number of grace periods that elapse during the test drops from 9133 when
not batching to 1732 when batching (a 5X improvement). The kfree_rcu()
flood itself slows down a bit when batching, though, as shown.

Note that the active memory consumption during the kfree_rcu() flood
does increase to around 200-250MB due to the batching (from around 50MB
without batching). However, this memory consumption is relatively
constant. In other words, the system is able to keep up with the
kfree_rcu() load. The memory consumption comes down considerably if
KFREE_DRAIN_JIFFIES is increased from HZ/50 to HZ/80.

Also, when running the test, please disable CONFIG_DEBUG_PREEMPT and
CONFIG_PROVE_RCU for realistic comparisons with/without batching.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 .../admin-guide/kernel-parameters.txt         |  17 ++
 kernel/rcu/rcuperf.c                          | 181 +++++++++++++++++-
 2 files changed, 190 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 79b983bedcaa..24fe8aefb12c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3896,6 +3896,23 @@
 			test until boot completes in order to avoid
 			interference.
 
+	rcuperf.kfree_rcu_test= [KNL]
+			Set to measure performance of kfree_rcu() flooding.
+
+	rcuperf.kfree_nthreads= [KNL]
+			The number of threads running loops of kfree_rcu().
+
+	rcuperf.kfree_alloc_num= [KNL]
+			Number of allocations and frees done in an iteration.
+
+	rcuperf.kfree_loops= [KNL]
+			Number of loops doing rcuperf.kfree_alloc_num number
+			of allocations and frees.
+
+	rcuperf.kfree_no_batch= [KNL]
+			Use the non-batching (less efficient) version of kfree_rcu().
+			This is useful for comparing with the batched version.
+
 	rcuperf.nreaders= [KNL]
 			Set number of RCU readers.  The value -1 selects
 			N, where N is the number of CPUs.  A value
diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index 5f884d560384..c1e25fd10f2a 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -86,6 +86,7 @@ torture_param(bool, shutdown, RCUPERF_SHUTDOWN,
 	      "Shutdown at end of performance tests.");
 torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
 torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
+torture_param(int, kfree_rcu_test, 0, "Do we run a kfree_rcu() perf test?");
 
 static char *perf_type = "rcu";
 module_param(perf_type, charp, 0444);
@@ -105,8 +106,8 @@ static atomic_t n_rcu_perf_writer_finished;
 static wait_queue_head_t shutdown_wq;
 static u64 t_rcu_perf_writer_started;
 static u64 t_rcu_perf_writer_finished;
-static unsigned long b_rcu_perf_writer_started;
-static unsigned long b_rcu_perf_writer_finished;
+static unsigned long b_rcu_gp_test_started;
+static unsigned long b_rcu_gp_test_finished;
 static DEFINE_PER_CPU(atomic_t, n_async_inflight);
 
 #define MAX_MEAS 10000
@@ -378,10 +379,10 @@ rcu_perf_writer(void *arg)
 	if (atomic_inc_return(&n_rcu_perf_writer_started) >= nrealwriters) {
 		t_rcu_perf_writer_started = t;
 		if (gp_exp) {
-			b_rcu_perf_writer_started =
+			b_rcu_gp_test_started =
 				cur_ops->exp_completed() / 2;
 		} else {
-			b_rcu_perf_writer_started = cur_ops->get_gp_seq();
+			b_rcu_gp_test_started = cur_ops->get_gp_seq();
 		}
 	}
 
@@ -429,10 +430,10 @@ rcu_perf_writer(void *arg)
 				PERFOUT_STRING("Test complete");
 				t_rcu_perf_writer_finished = t;
 				if (gp_exp) {
-					b_rcu_perf_writer_finished =
+					b_rcu_gp_test_finished =
 						cur_ops->exp_completed() / 2;
 				} else {
-					b_rcu_perf_writer_finished =
+					b_rcu_gp_test_finished =
 						cur_ops->get_gp_seq();
 				}
 				if (shutdown) {
@@ -515,8 +516,8 @@ rcu_perf_cleanup(void)
 			 t_rcu_perf_writer_finished -
 			 t_rcu_perf_writer_started,
 			 ngps,
-			 rcuperf_seq_diff(b_rcu_perf_writer_finished,
-					  b_rcu_perf_writer_started));
+			 rcuperf_seq_diff(b_rcu_gp_test_finished,
+					  b_rcu_gp_test_started));
 		for (i = 0; i < nrealwriters; i++) {
 			if (!writer_durations)
 				break;
@@ -584,6 +585,167 @@ rcu_perf_shutdown(void *arg)
 	return -EINVAL;
 }
 
+/*
+ * kfree_rcu() performance tests: Start a kfree_rcu() loop on all CPUs for number
+ * of iterations and measure total time and number of GP for all iterations to complete.
+ */
+
+torture_param(int, kfree_nthreads, -1, "Number of threads running loops of kfree_rcu().");
+torture_param(int, kfree_alloc_num, 8000, "Number of allocations and frees done in an iteration.");
+torture_param(int, kfree_loops, 10, "Number of loops doing kfree_alloc_num allocations and frees.");
+torture_param(int, kfree_no_batch, 0, "Use the non-batching (slower) version of kfree_rcu().");
+
+static struct task_struct **kfree_reader_tasks;
+static int kfree_nrealthreads;
+static atomic_t n_kfree_perf_thread_started;
+static atomic_t n_kfree_perf_thread_ended;
+
+struct kfree_obj {
+	char kfree_obj[8];
+	struct rcu_head rh;
+};
+
+static int
+kfree_perf_thread(void *arg)
+{
+	int i, loop = 0;
+	long me = (long)arg;
+	struct kfree_obj *alloc_ptr;
+	u64 start_time, end_time;
+
+	VERBOSE_PERFOUT_STRING("kfree_perf_thread task started");
+	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
+	set_user_nice(current, MAX_NICE);
+
+	start_time = ktime_get_mono_fast_ns();
+
+	if (atomic_inc_return(&n_kfree_perf_thread_started) >= kfree_nrealthreads) {
+		if (gp_exp)
+			b_rcu_gp_test_started = cur_ops->exp_completed() / 2;
+		else
+			b_rcu_gp_test_started = cur_ops->get_gp_seq();
+	}
+
+	do {
+		for (i = 0; i < kfree_alloc_num; i++) {
+			alloc_ptr = kmalloc(sizeof(struct kfree_obj), GFP_KERNEL);
+			if (!alloc_ptr)
+				return -ENOMEM;
+
+			if (!kfree_no_batch) {
+				kfree_rcu(alloc_ptr, rh);
+			} else {
+				rcu_callback_t cb;
+
+				cb = (rcu_callback_t)(unsigned long)offsetof(struct kfree_obj, rh);
+				kfree_call_rcu_nobatch(&(alloc_ptr->rh), cb);
+			}
+		}
+
+		cond_resched();
+	} while (!torture_must_stop() && ++loop < kfree_loops);
+
+	if (atomic_inc_return(&n_kfree_perf_thread_ended) >= kfree_nrealthreads) {
+		end_time = ktime_get_mono_fast_ns();
+
+		if (gp_exp)
+			b_rcu_gp_test_finished = cur_ops->exp_completed() / 2;
+		else
+			b_rcu_gp_test_finished = cur_ops->get_gp_seq();
+
+		pr_alert("Total time taken by all kfree'ers: %llu ns, loops: %d, batches: %ld\n",
+		       (unsigned long long)(end_time - start_time), kfree_loops,
+		       rcuperf_seq_diff(b_rcu_gp_test_finished, b_rcu_gp_test_started));
+		if (shutdown) {
+			smp_mb(); /* Assign before wake. */
+			wake_up(&shutdown_wq);
+		}
+	}
+
+	torture_kthread_stopping("kfree_perf_thread");
+	return 0;
+}
+
+static void
+kfree_perf_cleanup(void)
+{
+	int i;
+
+	if (torture_cleanup_begin())
+		return;
+
+	if (kfree_reader_tasks) {
+		for (i = 0; i < kfree_nrealthreads; i++)
+			torture_stop_kthread(kfree_perf_thread,
+					     kfree_reader_tasks[i]);
+		kfree(kfree_reader_tasks);
+	}
+
+	torture_cleanup_end();
+}
+
+/*
+ * shutdown kthread.  Just waits to be awakened, then shuts down system.
+ */
+static int
+kfree_perf_shutdown(void *arg)
+{
+	do {
+		wait_event(shutdown_wq,
+			   atomic_read(&n_kfree_perf_thread_ended) >=
+			   kfree_nrealthreads);
+	} while (atomic_read(&n_kfree_perf_thread_ended) < kfree_nrealthreads);
+
+	smp_mb(); /* Wake before output. */
+
+	kfree_perf_cleanup();
+	kernel_power_off();
+	return -EINVAL;
+}
+
+static int __init
+kfree_perf_init(void)
+{
+	long i;
+	int firsterr = 0;
+
+	kfree_nrealthreads = compute_real(kfree_nthreads);
+	/* Start up the kthreads. */
+	if (shutdown) {
+		init_waitqueue_head(&shutdown_wq);
+		firsterr = torture_create_kthread(kfree_perf_shutdown, NULL,
+						  shutdown_task);
+		if (firsterr)
+			goto unwind;
+		schedule_timeout_uninterruptible(1);
+	}
+
+	kfree_reader_tasks = kcalloc(kfree_nrealthreads, sizeof(kfree_reader_tasks[0]),
+			       GFP_KERNEL);
+	if (kfree_reader_tasks == NULL) {
+		firsterr = -ENOMEM;
+		goto unwind;
+	}
+
+	for (i = 0; i < kfree_nrealthreads; i++) {
+		firsterr = torture_create_kthread(kfree_perf_thread, (void *)i,
+						  kfree_reader_tasks[i]);
+		if (firsterr)
+			goto unwind;
+	}
+
+	while (atomic_read(&n_kfree_perf_thread_started) < kfree_nrealthreads)
+		schedule_timeout_uninterruptible(1);
+
+	torture_init_end();
+	return 0;
+
+unwind:
+	torture_init_end();
+	kfree_perf_cleanup();
+	return firsterr;
+}
+
 static int __init
 rcu_perf_init(void)
 {
@@ -616,6 +778,9 @@ rcu_perf_init(void)
 	if (cur_ops->init)
 		cur_ops->init();
 
+	if (kfree_rcu_test)
+		return kfree_perf_init();
+
 	nrealwriters = compute_real(nwriters);
 	nrealreaders = compute_real(nreaders);
 	atomic_set(&n_rcu_perf_reader_started, 0);
-- 
2.23.0.187.g17f5b7556c-goog

