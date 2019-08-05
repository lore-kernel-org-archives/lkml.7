Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A38C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1DB206A2
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2lc6U5MS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbfHELxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 07:53:35 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48786 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbfHELxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 07:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Msf2V2we4WXS20WMdFiMZ4D3iFIy0buao6uIC50MNEM=; b=2lc6U5MS0+V8U+XyrODAUQr8/
        CdcuDfc2HJzLfIrLWjo1cHIU13z7jI9RX+srG3MSgbBjXJ1XBXkGfYZA3cfB41HHdKAtQdmWcUrBx
        F+x6T/5e/Hw7kDXXZGPrJG1sbTTwshMUCXSC5zoK9OELCuEoXMOf1qWXMCajr7W9Y0/woknw5xiAj
        LQwN+BctbI7HgdPHspw0Ng45+wctKf4ncjlT5f01HpWqhVi5DCf8wL77mzgiO0ZlbZGaBFfQZ380o
        f0rs92irlijFE2DoF4JK3wu7qSA7wKLXjCr+V1HdvgOZrJgzIUbDEgh0WSYZDW12ItYuNSP9FLMx5
        2FMLXc5Kw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hubY7-0007xS-3r; Mon, 05 Aug 2019 11:53:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 38BB82022940D; Mon,  5 Aug 2019 13:53:09 +0200 (CEST)
Date:   Mon, 5 Aug 2019 13:53:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alessio Balsini <balsini@android.com>
Cc:     mingo@kernel.org, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        luca.abeni@santannapisa.it, bristot@redhat.com, dvyukov@google.com,
        tglx@linutronix.de, vpillai@digitalocean.com, rostedt@goodmis.org
Subject: Re: [RFC][PATCH 01/13] sched/deadline: Impose global limits on
 sched_attr::sched_period
Message-ID: <20190805115309.GJ2349@hirez.programming.kicks-ass.net>
References: <20190726145409.947503076@infradead.org>
 <20190726161357.397880775@infradead.org>
 <20190802172104.GA134279@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802172104.GA134279@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 06:21:04PM +0100, Alessio Balsini wrote:
> Hi Peter,
> 
> This is indeed an important missing piece.
> 
> I think it would be worth having some simple checks, e.g.:
> - period_min <= period_max;
> - period_min >= (1ULL << DL_SCALE).
> 
> To be even more picky, I'm wondering if it would be a good practice to
> fail the write operation if there are already dl-tasks in the system
> that violate the new constraint.  I'm afraid there is no cheap way of
> achieving such check, so, I think we can skip this last tricky thing for
> now.

Like so?

---
Subject: sched/deadline: Impose global limits on sched_attr::sched_period
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue Jul 23 16:01:29 CEST 2019

There are two DoS scenarios with SCHED_DEADLINE related to
sched_attr::sched_period:

 - since access-control only looks at utilization and density, a very
   large period can allow a very large runtime, which in turn can
   incur a very large latency to lower priority tasks.

 - for very short periods we can end up spending more time programming
   the hardware timer than actually running the task.

Mitigate these by imposing limits on the period.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Luca Abeni <luca.abeni@santannapisa.it>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
 include/linux/sched/sysctl.h |    7 ++++
 kernel/sched/deadline.c      |   61 +++++++++++++++++++++++++++++++++++++++++--
 kernel/sysctl.c              |   14 +++++++++
 3 files changed, 80 insertions(+), 2 deletions(-)

--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -56,6 +56,13 @@ int sched_proc_update_handler(struct ctl
 extern unsigned int sysctl_sched_rt_period;
 extern int sysctl_sched_rt_runtime;
 
+extern unsigned int sysctl_sched_dl_period_max;
+extern unsigned int sysctl_sched_dl_period_min;
+
+extern int sched_dl_period_handler(struct ctl_table *table, int write,
+		void __user *buffer, size_t *lenp,
+		loff_t *ppos);
+
 #ifdef CONFIG_UCLAMP_TASK
 extern unsigned int sysctl_sched_uclamp_util_min;
 extern unsigned int sysctl_sched_uclamp_util_max;
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2660,6 +2660,52 @@ void __getparam_dl(struct task_struct *p
 }
 
 /*
+ * Default limits for DL period; on the top end we guard against small util
+ * tasks still getting ridiculous long effective runtimes, on the bottom end we
+ * guard against timer DoS.
+ */
+unsigned int sysctl_sched_dl_period_max = 1 << 22; /* ~4 seconds */
+unsigned int sysctl_sched_dl_period_min = 100;     /* 100 us */
+
+int sched_dl_period_handler(struct ctl_table *table, int write,
+			    void __user *buffer, size_t *lenp,
+			    loff_t *ppos)
+{
+	unsigned int old_min, old_max;
+	static DEFINE_MUTEX(mutex);
+	int ret;
+
+	mutex_lock(&mutex);
+	old_min = sysctl_sched_dl_period_min;
+	old_max = sysctl_sched_dl_period_max;
+
+	ret = proc_dointvec(table, write, buffer, lenp, ppos);
+
+	if (!ret && write) {
+		u64 min = (u64)sysctl_sched_dl_period_min * NSEC_PER_USEC;
+		u64 max = (u64)sysctl_sched_dl_period_man * NSEC_PER_USEC;
+
+		ret = -EINVAL;
+		if (min < 1ULL << DL_SCALE)
+			goto undo;
+
+		if (max < min)
+			goto undo;
+
+		ret = 0;
+	}
+
+	if (0) {
+undo:
+		sysctl_sched_rt_period = old_period;
+		sysctl_sched_rt_runtime = old_runtime;
+	}
+	mutex_unlock(&mutex);
+
+	return ret;
+}
+
+/*
  * This function validates the new parameters of a -deadline task.
  * We ask for the deadline not being zero, and greater or equal
  * than the runtime, as well as the period of being zero or
@@ -2671,6 +2717,8 @@ void __getparam_dl(struct task_struct *p
  */
 bool __checkparam_dl(const struct sched_attr *attr)
 {
+	u64 period, max, min;
+
 	/* special dl tasks don't actually use any parameter */
 	if (attr->sched_flags & SCHED_FLAG_SUGOV)
 		return true;
@@ -2694,12 +2742,21 @@ bool __checkparam_dl(const struct sched_
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
+		.proc_handler	= sched_dl_period_handler,
+	},
+	{
+		.procname	= "sched_deadline_period_min_us",
+		.data		= &sysctl_sched_dl_period_min,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= sched_dl_period_handler,
+	},
+	{
 		.procname	= "sched_rr_timeslice_ms",
 		.data		= &sysctl_sched_rr_timeslice,
 		.maxlen		= sizeof(int),
