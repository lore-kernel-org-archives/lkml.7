Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4FBC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED95621835
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbfLQMkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:40:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55241 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbfLQMj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:39:58 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ihC8n-0001pd-8A; Tue, 17 Dec 2019 13:39:53 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 057C41C2A3E;
        Tue, 17 Dec 2019 13:39:52 +0100 (CET)
Date:   Tue, 17 Dec 2019 12:39:51 -0000
From:   "tip-bot2 for Yangtao Li" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] stop_machine: remove try_stop_cpus helper
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191214195107.26480-1-tiny.windzz@gmail.com>
References: <20191214195107.26480-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Message-ID: <157658639188.30329.17994429919156860695.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     a5e37de90e67ac1072a9a44bd0cec9f5e98ded08
Gitweb:        https://git.kernel.org/tip/a5e37de90e67ac1072a9a44bd0cec9f5e98ded08
Author:        Yangtao Li <tiny.windzz@gmail.com>
AuthorDate:    Sat, 14 Dec 2019 19:51:07 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 17 Dec 2019 13:32:51 +01:00

stop_machine: remove try_stop_cpus helper

try_stop_cpus is not used after this:

commit c190c3b16c0f ("rcu: Switch synchronize_sched_expedited() to
stop_one_cpu()")

So remove it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20191214195107.26480-1-tiny.windzz@gmail.com
---
 include/linux/stop_machine.h |  7 -------
 kernel/stop_machine.c        | 30 ------------------------------
 2 files changed, 37 deletions(-)

diff --git a/include/linux/stop_machine.h b/include/linux/stop_machine.h
index f9a0c61..648298f 100644
--- a/include/linux/stop_machine.h
+++ b/include/linux/stop_machine.h
@@ -33,7 +33,6 @@ int stop_two_cpus(unsigned int cpu1, unsigned int cpu2, cpu_stop_fn_t fn, void *
 bool stop_one_cpu_nowait(unsigned int cpu, cpu_stop_fn_t fn, void *arg,
 			 struct cpu_stop_work *work_buf);
 int stop_cpus(const struct cpumask *cpumask, cpu_stop_fn_t fn, void *arg);
-int try_stop_cpus(const struct cpumask *cpumask, cpu_stop_fn_t fn, void *arg);
 void stop_machine_park(int cpu);
 void stop_machine_unpark(int cpu);
 void stop_machine_yield(const struct cpumask *cpumask);
@@ -90,12 +89,6 @@ static inline int stop_cpus(const struct cpumask *cpumask,
 	return -ENOENT;
 }
 
-static inline int try_stop_cpus(const struct cpumask *cpumask,
-				cpu_stop_fn_t fn, void *arg)
-{
-	return stop_cpus(cpumask, fn, arg);
-}
-
 #endif	/* CONFIG_SMP */
 
 /*
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 1fe34a9..5d68ec4 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -453,36 +453,6 @@ int stop_cpus(const struct cpumask *cpumask, cpu_stop_fn_t fn, void *arg)
 	return ret;
 }
 
-/**
- * try_stop_cpus - try to stop multiple cpus
- * @cpumask: cpus to stop
- * @fn: function to execute
- * @arg: argument to @fn
- *
- * Identical to stop_cpus() except that it fails with -EAGAIN if
- * someone else is already using the facility.
- *
- * CONTEXT:
- * Might sleep.
- *
- * RETURNS:
- * -EAGAIN if someone else is already stopping cpus, -ENOENT if
- * @fn(@arg) was not executed at all because all cpus in @cpumask were
- * offline; otherwise, 0 if all executions of @fn returned 0, any non
- * zero return value if any returned non zero.
- */
-int try_stop_cpus(const struct cpumask *cpumask, cpu_stop_fn_t fn, void *arg)
-{
-	int ret;
-
-	/* static works are used, process one request at a time */
-	if (!mutex_trylock(&stop_cpus_mutex))
-		return -EAGAIN;
-	ret = __stop_cpus(cpumask, fn, arg);
-	mutex_unlock(&stop_cpus_mutex);
-	return ret;
-}
-
 static int cpu_stop_should_run(unsigned int cpu)
 {
 	struct cpu_stopper *stopper = &per_cpu(cpu_stopper, cpu);
