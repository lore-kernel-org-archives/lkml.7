Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D47C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 16:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39DA9233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 16:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rE3mh1Kh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390179AbfHVQv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 12:51:58 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58768 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730719AbfHVQv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 12:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pTQuSaZ0y064hBW3JcT9xVAG9FaJRln7HthFHLIaxKw=; b=rE3mh1KhRD5albGjLJLcHMxXz
        uQNpAHKi9fUnp//XhXuJoL1qG+Jm/bqYzByuMFhMko+u1R4QDlgY0r+Ywvs2wPJz0BKm2xaJp8blp
        2qGz6+QHP1KNkeJR9hOvymZfHbQ8lfGAD6rR5OW39+chPUKnsFI6NuQ8aRoxzAarhX9QfxphtsaWS
        FHn73cIlD3SxBrvcCOw7SqjQPZL6yMt/5FzvKbAn96rwlAV8FDUTU62D+fzyZm969qbbsRI5xmV67
        T7xCftbICv7arb4obbaajCzBga5+sgNfPJ9x5B29qcwCY3iALom+N7kFNDJhaRhjnagrs6/pcmF9E
        DAtVXFinA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i0qJ7-0006C3-3W; Thu, 22 Aug 2019 16:51:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6AA87307145;
        Thu, 22 Aug 2019 18:50:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7EA2720B74844; Thu, 22 Aug 2019 18:51:25 +0200 (CEST)
Date:   Thu, 22 Aug 2019 18:51:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alessio Balsini <balsini@android.com>
Cc:     mingo@kernel.org, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        luca.abeni@santannapisa.it, bristot@redhat.com, dvyukov@google.com,
        tglx@linutronix.de, vpillai@digitalocean.com, rostedt@goodmis.org,
        kernel-team@android.com
Subject: Re: [RFC][PATCH 01/13] sched/deadline: Impose global limits on
 sched_attr::sched_period
Message-ID: <20190822165125.GW2369@hirez.programming.kicks-ass.net>
References: <20190726145409.947503076@infradead.org>
 <20190726161357.397880775@infradead.org>
 <20190802172104.GA134279@google.com>
 <20190805115309.GJ2349@hirez.programming.kicks-ass.net>
 <20190822122949.GA245353@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822122949.GA245353@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 01:29:49PM +0100, Alessio Balsini wrote:
> Yes, that's exactly what I meant!
> What about this refactoring?

Makes sense; and now I spot a race (and sched_rt_handler() from which I
copied this is susceptible too):

> +int sched_dl_period_handler(struct ctl_table *table, int write,
> +			    void __user *buffer, size_t *lenp,
> +			    loff_t *ppos)
> +{
> +	unsigned int old_max, old_min;
> +	static DEFINE_MUTEX(mutex);
> +	int ret;
> +
> +	mutex_lock(&mutex);
> +	old_max = sysctl_sched_dl_period_max;
> +	old_min = sysctl_sched_dl_period_min;
> +
> +	ret = proc_douintvec(table, write, buffer, lenp, ppos);

Here the sysctl_* values have been changed, interleave with:

> +	if (!ret && write) {
> +		u64 max = (u64)sysctl_sched_dl_period_max * NSEC_PER_USEC;
> +		u64 min = (u64)sysctl_sched_dl_period_min * NSEC_PER_USEC;
> +
> +		if (min < 1ULL << DL_SCALE || max < min) {
> +			sysctl_sched_dl_period_max = old_max;
> +			sysctl_sched_dl_period_min = old_min;
> +			ret = -EINVAL;
> +		}
> +	}
> +	mutex_unlock(&mutex);
> +
> +	return ret;
> +}

> @@ -2675,12 +2713,21 @@ bool __checkparam_dl(const struct sched_attr *attr)
>  	    attr->sched_period & (1ULL << 63))
>  		return false;
>  
> +	period = attr->sched_period;
> +	if (!period)
> +		period = attr->sched_deadline;
> +
>  	/* runtime <= deadline <= period (if period != 0) */
> -	if ((attr->sched_period != 0 &&
> -	     attr->sched_period < attr->sched_deadline) ||
> +	if (period < attr->sched_deadline ||
>  	    attr->sched_deadline < attr->sched_runtime)
>  		return false;
>  
> +	max = (u64)READ_ONCE(sysctl_sched_dl_period_max) * NSEC_PER_USEC;
> +	min = (u64)READ_ONCE(sysctl_sched_dl_period_min) * NSEC_PER_USEC;

this, and we're using unvalidated numbers.

> +	if (period < min || period > max)
> +		return false;
> +
>  	return true;
>  }

Something like the completely untested (again, sorry) below ought to
cure that I think; the same needs doing to sched_rt_handler() I'm
thinking.

---
Subject: sched/deadline: Impose global limits on sched_attr::sched_period
From: Alessio Balsini <balsini@android.com>
Date: Thu, 22 Aug 2019 13:29:49 +0100

There are two DoS scenarios with SCHED_DEADLINE related to
sched_attr::sched_period:

 - since access-control only looks at utilization and density, a very
   large period can allow a very large runtime, which in turn can
   incur a very large latency to lower priority tasks.

 - for very short periods we can end up spending more time programming
   the hardware timer than actually running the task.

Mitigate these by imposing limits on the period.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Alessio Balsini <balsini@android.com>
Cc: rostedt@goodmis.org
Cc: mingo@kernel.org
Cc: luca.abeni@santannapisa.it
Cc: bristot@redhat.com
Cc: vpillai@digitalocean.com
Cc: kernel-team@android.com
Cc: juri.lelli@redhat.com
Cc: dietmar.eggemann@arm.com
Cc: dvyukov@google.com
Cc: tglx@linutronix.de
---
 include/linux/sched/sysctl.h |    7 +++++
 kernel/sched/deadline.c      |   58 +++++++++++++++++++++++++++++++++++++++++--
 kernel/sysctl.c              |   14 ++++++++++
 3 files changed, 77 insertions(+), 2 deletions(-)

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
@@ -2633,6 +2633,49 @@ void __getparam_dl(struct task_struct *p
 }
 
 /*
+ * Default limits for DL period: on the top end we guard against small util
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
+	unsigned int new_max, new_min;
+	struct ctl_table new_table;
+	static DEFINE_MUTEX(mutex);
+	int ret;
+
+	mutex_lock(&mutex);
+	new_max = sysctl_sched_dl_period_max;
+	new_min = sysctl_sched_dl_period_min;
+	new_table = *table;
+	if (new_table.data == &sysctl_sched_dl_period_max)
+		new_table.data = &new_max;
+	else
+		new_table.data = &new_min;
+
+	ret = proc_douintvec(&new_table, write, buffer, lenp, ppos);
+	if (!ret && write) {
+		u64 max = (u64)new_max * NSEC_PER_USEC;
+		u64 min = (u64)new_min * NSEC_PER_USEC;
+
+		if (min > 1ULL << DL_SCALE && max > min) {
+			WRITE_ONCE(sysctl_sched_dl_period_max, new_max);
+			WRITE_ONCE(sysctl_sched_dl_period_min, new_min);
+		} else {
+			ret = -EINVAL;
+		}
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
@@ -2644,6 +2687,8 @@ void __getparam_dl(struct task_struct *p
  */
 bool __checkparam_dl(const struct sched_attr *attr)
 {
+	u64 period, max, min;
+
 	/* special dl tasks don't actually use any parameter */
 	if (attr->sched_flags & SCHED_FLAG_SUGOV)
 		return true;
@@ -2667,12 +2712,21 @@ bool __checkparam_dl(const struct sched_
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
