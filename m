Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01636C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 14:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F2621874
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 14:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="GBltx3vb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbfHaOlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 10:41:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42271 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfHaOlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 10:41:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id b16so9669262wrq.9
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2019 07:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XvP3avCKD/0pomCvXzeFb/Yzk02vyYPs6NlY1LyrvP0=;
        b=GBltx3vbqnpkT1YI1j2Kn9RW8rcUeMfCSxfFuAEU+xh6C7Ql4b8nF0Jb3QpyVxwwAh
         xGrjxxL0rmkaVa1TgttFyNkN2Uax/qybQIy88N0WvQmsjarZL5mcj2VLsvNIfGbDk7HO
         DAUJS04re9P+qQqfKM5jAR24bqPUAYRG2sOTO9pLeVFtYx9n+/8hOjC1LwYdV0XaIETF
         rz3JnvNio7Le2aZyENumzrP/GisuqUiv9yRR87uqrSz4NsHLMoajhrFXf9ayGgH2AApD
         isZo85fwIJA9A1KKpneQodBJ/aqEyuTSfkoCQ7mWrEkxa/FCEWi0z70qnOkf4wfN2FDa
         KHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XvP3avCKD/0pomCvXzeFb/Yzk02vyYPs6NlY1LyrvP0=;
        b=r3KgBw1w8SAVC16esWKGzbDkxPYRWVKAcoKwvzZ8l2sK82dgb2OFxzIpo/6t1W9w9G
         yUZEeRBlsc0pCiq0QiUa12S4fQBHW3ckf8bYjQ+dtKg8u+N9I2Upv/V6pkvfND/c5X2z
         vM/iI7U6S228uIkP6JFRAFf0+G9eaxVRLcLQ3AYd1+G87tx6foH7QXjtivtVWKCNDJtY
         hSNlOwnuh/4BYnmDDrYSEYj799cEXxfNsrAuWJSy6bapgf/hTOv1nJWUtGAkZwJQXQYn
         h6KPFVR7gVucEBqO2N57Qhd/0JbO5+NjqiMFwwKHUEQyKOeI2oWSekqw2rIvzyWYQqos
         c9bg==
X-Gm-Message-State: APjAAAW1ChSEGnTxYO+hb5i9q9lMRxODjLqWlfE+uq8QDsUu/58AcfxU
        0WD/FKVjaSYXzEfAIv+Iymtt9A==
X-Google-Smtp-Source: APXvYqzjjhlJvYlhpGpjXv5DabX1x9rETVN5oTG4WzR02nhILzLb2PrVuc4Rt2Waysp2Tjrw+bS/wA==
X-Received: by 2002:a5d:4bc1:: with SMTP id l1mr6792176wrt.259.1567262480222;
        Sat, 31 Aug 2019 07:41:20 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e751:37a0:1e95:e65d])
        by smtp.gmail.com with ESMTPSA id i93sm13722438wri.57.2019.08.31.07.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 07:41:19 -0700 (PDT)
Date:   Sat, 31 Aug 2019 15:41:17 +0100
From:   Alessio Balsini <balsini@android.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        luca.abeni@santannapisa.it, bristot@redhat.com, dvyukov@google.com,
        tglx@linutronix.de, vpillai@digitalocean.com, rostedt@goodmis.org,
        kernel-team@android.com
Subject: Re: [RFC][PATCH 01/13] sched/deadline: Impose global limits on
 sched_attr::sched_period
Message-ID: <20190831144117.GA133727@google.com>
References: <20190726145409.947503076@infradead.org>
 <20190726161357.397880775@infradead.org>
 <20190802172104.GA134279@google.com>
 <20190805115309.GJ2349@hirez.programming.kicks-ass.net>
 <20190822122949.GA245353@google.com>
 <20190822165125.GW2369@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822165125.GW2369@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right!

Verified that sysctl_sched_dl_period_max and sysctl_sched_dl_period_min values
are now always consistent.

I spent some time in trying to figure out if not having any mutex in
__checkparam_dl() is safe. There can surely happen that "max < min", e.g.:

          |              |               periods
User1     | User2        | checkparam_dl()  | sysctl_sched_dl_*
----------|--------------|------------------|-------------------
          |              |                  | [x, x]
p_min = 5 |              |                  |
          |              |                  | [5, x]
p_max = 5 |              |                  |
          |              |                  | [5, 5]
          | setattr(p=8) |                  |
          |              | p = 8            |
          |              | [x, 5]           |
p_max = 9 |              |                  |
          |              |                  | [5, 9]
p_min = 6 |              |                  |
          |              |                  | [6, 9]
          |              | [6, 5]           |
----------|--------------|------------------|-------------------

Sharing my thoughts, a "BUG_ON(max < min)" in __checkparam_dl() is then a
guaranteed source of explosions, but the good news is that "if (period < min ||
period > max" in __checkparam_dl() surely fails if "max < min".  Also the fact
that, when we are writing the new sysctl_sched_dl_* values, only one is
actually changed at a time, that surely helps to preserve the consistency.

But is that enough?

Well, I couldn't find any counterexample to make __checkparam_dl() pass with
wrong parameters. And the tests I made are happy.

On Thu, Aug 22, 2019 at 06:51:25PM +0200, Peter Zijlstra wrote:
>  include/linux/sched/sysctl.h |    7 +++++
>  kernel/sched/deadline.c      |   58 +++++++++++++++++++++++++++++++++++++++++--
>  kernel/sysctl.c              |   14 ++++++++++
>  3 files changed, 77 insertions(+), 2 deletions(-)
> 
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> +int sched_dl_period_handler(struct ctl_table *table, int write,
> +			    void __user *buffer, size_t *lenp,
> +			    loff_t *ppos)
> +{
> +		if (min > 1ULL << DL_SCALE && max > min) {

s/>/>=/

> +			WRITE_ONCE(sysctl_sched_dl_period_max, new_max);
> +			WRITE_ONCE(sysctl_sched_dl_period_min, new_min);

Besides the inline comment above, this is my ack to your patch.

Otherwise, here follows a slightly more convoluted version of your patch with a
couple of changes to sched_dl_period_handler(), summarized as:
 - handle new_table only if writing;
 - directly compare the us min and max (saves one multiplication);
 - atomic-writes only the sysctl_sched_dl_period_XXX which changed.

M2c.

Thanks!
-Alessio

---
From cb4481233b57e42ff9dd315811f7919168a28162 Mon Sep 17 00:00:00 2001
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 22 Aug 2019 18:51:25 +0200
Subject: [PATCH] sched/deadline: Impose global limits on
 sched_attr::sched_period

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
 include/linux/sched/sysctl.h |  7 ++++
 kernel/sched/deadline.c      | 68 ++++++++++++++++++++++++++++++++++--
 kernel/sysctl.c              | 14 ++++++++
 3 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index d4f6215ee03f7..7c8ef07e52133 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -56,6 +56,13 @@ int sched_proc_update_handler(struct ctl_table *table, int write,
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
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 0b9cbfb2b1d4f..c4a6107e055c7 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2640,6 +2640,59 @@ void __getparam_dl(struct task_struct *p, struct sched_attr *attr)
 	attr->sched_flags = dl_se->flags;
 }
 
+/*
+ * Default limits for DL period: on the top end we guard against small util
+ * tasks still getting ridiculous long effective runtimes, on the bottom end we
+ * guard against timer DoS.
+ */
+unsigned int sysctl_sched_dl_period_max = 1 << 22; /* ~4.2 seconds */
+unsigned int sysctl_sched_dl_period_min = 100;     /* 100 us */
+
+int sched_dl_period_handler(struct ctl_table *table, int write,
+			    void __user *buffer, size_t *lenp,
+			    loff_t *ppos)
+{
+	static DEFINE_MUTEX(mutex);
+	int ret;
+
+	mutex_lock(&mutex);
+	if (write) {
+		/*
+		 * Use a temporary data structure to store the value read from
+		 * userspace. The sysctl_sched_dl_period_{max,min} value will
+		 * be updated only if the data is consistent.
+		 */
+		struct ctl_table new_table = *table;
+		unsigned int max, min;
+
+		if (new_table.data == &sysctl_sched_dl_period_max) {
+			new_table.data = &max;
+			min = sysctl_sched_dl_period_min;
+		} else {
+			new_table.data = &min;
+			max = sysctl_sched_dl_period_max;
+		}
+
+		ret = proc_douintvec(&new_table, write, buffer, lenp, ppos);
+		if (!ret) {
+			if (min > max ||
+			    (u64)min * NSEC_PER_USEC < 1ULL << DL_SCALE) {
+				ret = -EINVAL;
+			} else {
+				unsigned int *src = new_table.data;
+				unsigned int *dst = table->data;
+
+				WRITE_ONCE(*dst, *src);
+			}
+		}
+	} else {
+		ret = proc_douintvec(table, write, buffer, lenp, ppos);
+	}
+	mutex_unlock(&mutex);
+
+	return ret;
+}
+
 /*
  * This function validates the new parameters of a -deadline task.
  * We ask for the deadline not being zero, and greater or equal
@@ -2652,6 +2705,8 @@ void __getparam_dl(struct task_struct *p, struct sched_attr *attr)
  */
 bool __checkparam_dl(const struct sched_attr *attr)
 {
+	u64 period, max, min;
+
 	/* special dl tasks don't actually use any parameter */
 	if (attr->sched_flags & SCHED_FLAG_SUGOV)
 		return true;
@@ -2675,12 +2730,21 @@ bool __checkparam_dl(const struct sched_attr *attr)
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
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 078950d9605ba..0d07e4707e9d2 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -442,6 +442,20 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= sched_rt_handler,
 	},
+	{
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
 	{
 		.procname	= "sched_rr_timeslice_ms",
 		.data		= &sysctl_sched_rr_timeslice,
-- 
2.23.0.187.g17f5b7556c-goog


