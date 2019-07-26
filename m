Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D67CC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B23218EA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aRUSKrqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbfGZQUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 12:20:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57068 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728602AbfGZQUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 12:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UrJfcZgXofwgL1dif08mG2dJOnGZUTf3aYEtHTl9aJ4=; b=aRUSKrqG/QdAEOpCrN11a9Mgkf
        P3EYu4ymg991EiupLAt7zd/6h0OEgJEdjxTFX/fF/l0XWDO3yB0aXFIf5VcmAQUbjJKaa+HPhOJdo
        TvSL2bXTG//qCAvdFTgTTM+YgezOKgYJDcPqi+io7xfkpp4ykmy9dBoLcKr4tMK7YcTZWJZ+U5qPR
        okJBWhtVLy0hnCWnFqFyLUAUbTR9iwE/VDgyDUCnkvdZ8zoUrB0ZPrApmFaY4ST3q5z2CwSMjrAt5
        1WwhGQKhB2/kYHAARUQtgtKiMUD6QmjoVjhLyV5ZHm/Fa/V35rVwCw9HVALQkdyacfXvBVlym2IQE
        dd4IFCmw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hr2wy-00066R-3M; Fri, 26 Jul 2019 16:20:08 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3FDB32022974A; Fri, 26 Jul 2019 18:20:05 +0200 (CEST)
Message-Id: <20190726161357.397880775@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 26 Jul 2019 16:54:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, juri.lelli@redhat.com
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        luca.abeni@santannapisa.it, bristot@redhat.com,
        balsini@android.com, dvyukov@google.com, tglx@linutronix.de,
        vpillai@digitalocean.com, rostedt@goodmis.org, peterz@infradead.org
Subject: [RFC][PATCH 01/13] sched/deadline: Impose global limits on sched_attr::sched_period
References: <20190726145409.947503076@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Luca Abeni <luca.abeni@santannapisa.it>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched/sysctl.h |    3 +++
 kernel/sched/deadline.c      |   23 +++++++++++++++++++++--
 kernel/sysctl.c              |   14 ++++++++++++++
 3 files changed, 38 insertions(+), 2 deletions(-)

--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -56,6 +56,9 @@ int sched_proc_update_handler(struct ctl
 extern unsigned int sysctl_sched_rt_period;
 extern int sysctl_sched_rt_runtime;
 
+extern unsigned int sysctl_sched_dl_period_max;
+extern unsigned int sysctl_sched_dl_period_min;
+
 #ifdef CONFIG_UCLAMP_TASK
 extern unsigned int sysctl_sched_uclamp_util_min;
 extern unsigned int sysctl_sched_uclamp_util_max;
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2597,6 +2597,14 @@ void __getparam_dl(struct task_struct *p
 }
 
 /*
+ * Default limits for DL period; on the top end we guard against small util
+ * tasks still getting rediculous long effective runtimes, on the bottom end we
+ * guard against timer DoS.
+ */
+unsigned int sysctl_sched_dl_period_max = 1 << 22; /* ~4 seconds */
+unsigned int sysctl_sched_dl_period_min = 100;     /* 100 us */
+
+/*
  * This function validates the new parameters of a -deadline task.
  * We ask for the deadline not being zero, and greater or equal
  * than the runtime, as well as the period of being zero or
@@ -2608,6 +2616,8 @@ void __getparam_dl(struct task_struct *p
  */
 bool __checkparam_dl(const struct sched_attr *attr)
 {
+	u64 period, max, min;
+
 	/* special dl tasks don't actually use any parameter */
 	if (attr->sched_flags & SCHED_FLAG_SUGOV)
 		return true;
@@ -2631,12 +2641,21 @@ bool __checkparam_dl(const struct sched_
 	    attr->sched_period & (1ULL << 63))
 		return false;
 
+	period = attr->sched_period;
+	if (!period)
+		period = attr->sched_deadline;
+
 	/* runtime <= deadline <= period (if period != 0) */
-	if ((attr->sched_period != 0 &&
-	     attr->sched_period < attr->sched_deadline) ||
+	if (period < attr->sched_deadline ||
 	    attr->sched_deadline < attr->sched_runtime)
 		return false;
 
+	max = (u64)READ_ONCE(sysctl_sched_dl_period_max) * NSEC_PER_USEC;
+	min = (u64)READ_ONCE(sysctl_sched_dl_period_min) * NSEC_PER_USEC;
+
+	if (period < min || period > max)
+		return false;
+
 	return true;
 }
 
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -443,6 +443,20 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= sched_rt_handler,
 	},
 	{
+		.procname	= "sched_deadline_period_max_us",
+		.data		= &sysctl_sched_dl_period_max,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.procname	= "sched_deadline_period_min_us",
+		.data		= &sysctl_sched_dl_period_min,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+	{
 		.procname	= "sched_rr_timeslice_ms",
 		.data		= &sysctl_sched_rr_timeslice,
 		.maxlen		= sizeof(int),


