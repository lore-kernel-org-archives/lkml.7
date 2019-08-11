Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DF6C32757
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 02:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A065208C3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 02:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="EOJ18uyb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfHKCuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 22:50:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42266 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfHKCuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 22:50:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id t132so47776741pgb.9
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 19:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8D+1uC6iV4FvAozNO4xfgRi1TLdDOLAuZ9417tGHLoc=;
        b=EOJ18uybt3m6XUA/RuQJbxipMByxo7q7rerdCWiFz0s0A9H6QBL3bLtJBJprB1z5Zq
         R+Dqjv2bf2R/pbv8gR/ymZ3lv4ufMfmgNS8SCtmmSnERKv2RpunzgQC3mMXLdDO86ng9
         aTu5X7CXIo42O39uIzYlGfw1m4ez2RaESrssA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8D+1uC6iV4FvAozNO4xfgRi1TLdDOLAuZ9417tGHLoc=;
        b=kFxMYuob2GQ9RXgbO24Vs0A6kyEi+eW3RfYXXqKuquwYIUyy+eo8ptVkiaIw3/32Ci
         x3SBIkzi+t6tTeOJJPfMO7A9LfpQIQByE+P5FoC74/k+IhpKBZLpA6HmKUHgIENZ4y+Z
         QleNtVuXQHZRDeeF4PV5Cik4Aq8Y45cRlO2Z2pGcxrI7CxZtzddZsT6GFcTqHWAn8mz9
         62ULUKI6L0o2l5/Y9h8nQvWFjb88bWgMySQfWqk3IlMh5W7khwG+z9TdmLHP+8iGVXn0
         puv4Qh/iL2SfmLRWUGp79p7K5Gilg2obErpM6JAW0StIoGZ8akukTVo51rDjqABJ9M2k
         cRIw==
X-Gm-Message-State: APjAAAWqSM1atqiGmxP73PmtfAb1jDJEgUhx/2VTk5mBdbaJ0smAtRkp
        FR/lnLQv5JwiQoi5uZ2APnyityZIt4c=
X-Google-Smtp-Source: APXvYqy2BxDwAn9Z7BDiecLxg46DjiGUGpS6vHOZoHPiPMcIGrS6QQdNLVjFJQkb/epYpK4fFWelAw==
X-Received: by 2002:a63:9245:: with SMTP id s5mr24962333pgn.123.1565491820361;
        Sat, 10 Aug 2019 19:50:20 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id u69sm124113008pgu.77.2019.08.10.19.50.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 10 Aug 2019 19:50:19 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        byungchul.park@lge.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        kernel-team@lge.com, Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        max.byungchul.park@gmail.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Rao Shoaib <rao.shoaib@oracle.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 2/2] rcuperf: Add kfree_rcu performance Tests
Date:   Sat, 10 Aug 2019 22:49:56 -0400
Message-Id: <20190811024957.233650-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
In-Reply-To: <20190811024957.233650-1-joel@joelfernandes.org>
References: <20190811024957.233650-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This test runs kfree_rcu in a loop to measure performance of the new
kfree_rcu batching functionality.

The following table shows results when booting with arguments:
rcuperf.kfree_loops=200000 rcuperf.kfree_alloc_num=1000 rcuperf.kfree_rcu_test=1

In addition, rcuperf.kfree_no_batch is used to toggle the batching of
kfree_rcu()s for a test run.

rcuperf.kfree_no_batch	GPs	time (seconds)
 0 (default)		1732	15.9
 1			9133 	14.5

Note that the results are the same for the case:
1. Patch is not applied and rcuperf.kfree_no_batch=0
2. Patch is applied     and rcuperf.kfree_no_batch=1

On a 16 CPU system with the above boot parameters, we see that the total
number of grace periods that elapse during the test drops from 9133 when
not batching to 1732 when batching (a ~427% improvement). The
kfree_rcu() flood itself slows down a bit when batching, though, as
shown. This is likely due to rcuperf threads contending with the
additional worker threads that are now running both before (the monitor)
and after (the work done to kfree()) the grace period.

Note that the active memory consumption during the kfree_rcu() flood
does increase to around 300-400MB due to the batching (from around 50MB
without batching). However, this memory consumption is relatively
constant and is just an effect of the buffering. In other words, the
system is able to keep up with the kfree_rcu() load.

Also, when running the test, please disable CONFIG_DEBUG_PREEMPT and
CONFIG_PROVE_RCU for realistic comparisons with/without batching.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcuperf.c | 189 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 181 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index 7a6890b23c5f..70d6ac19cbff 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -86,6 +86,7 @@ torture_param(bool, shutdown, RCUPERF_SHUTDOWN,
 	      "Shutdown at end of performance tests.");
 torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
 torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
+torture_param(int, kfree_rcu_test, 0, "Do we run a kfree_rcu perf test?");
 
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
 
 static int rcu_perf_writer_state;
@@ -379,10 +380,10 @@ rcu_perf_writer(void *arg)
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
 
@@ -435,10 +436,10 @@ rcu_perf_writer(void *arg)
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
@@ -523,8 +524,8 @@ rcu_perf_cleanup(void)
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
@@ -592,6 +593,175 @@ rcu_perf_shutdown(void *arg)
 	return -EINVAL;
 }
 
+/*
+ * kfree_rcu performance tests: Start a kfree_rcu loop on all CPUs for number
+ * of iterations and measure total time and number of GP for all iterations to complete.
+ */
+
+torture_param(int, kfree_nthreads, -1, "Number of threads running loops of kfree_rcu().");
+torture_param(int, kfree_alloc_num, 8000, "Number of allocations and frees done in an iteration.");
+torture_param(int, kfree_loops, 10, "Number of loops doing kfree_alloc_num allocations and frees.");
+torture_param(int, kfree_no_batch, 0, "Use the non-batching (slower) version of kfree_rcu.");
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
+	struct kfree_obj **alloc_ptrs;
+	u64 start_time, end_time;
+
+	VERBOSE_PERFOUT_STRING("kfree_perf_thread task started");
+	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
+	set_user_nice(current, MAX_NICE);
+
+	alloc_ptrs = (struct kfree_obj **)kmalloc(sizeof(struct kfree_obj *) * kfree_alloc_num,
+						  GFP_KERNEL);
+	if (!alloc_ptrs)
+		return -ENOMEM;
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
+			alloc_ptrs[i] = kmalloc(sizeof(struct kfree_obj), GFP_KERNEL);
+			if (!alloc_ptrs[i])
+				return -ENOMEM;
+		}
+
+		for (i = 0; i < kfree_alloc_num; i++) {
+			if (!kfree_no_batch) {
+				kfree_rcu(alloc_ptrs[i], rh);
+			} else {
+				rcu_callback_t cb;
+
+				cb = (rcu_callback_t)(unsigned long)offsetof(struct kfree_obj, rh);
+				kfree_call_rcu_nobatch(&(alloc_ptrs[i]->rh), cb);
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
+	kfree(alloc_ptrs);
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
@@ -624,6 +794,9 @@ rcu_perf_init(void)
 	if (cur_ops->init)
 		cur_ops->init();
 
+	if (kfree_rcu_test)
+		return kfree_perf_init();
+
 	nrealwriters = compute_real(nwriters);
 	nrealreaders = compute_real(nreaders);
 	atomic_set(&n_rcu_perf_reader_started, 0);
-- 
2.23.0.rc1.153.gdeed80330f-goog

