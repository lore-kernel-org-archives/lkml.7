Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E56EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 12:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3F6206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 12:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="jo6+B+Np"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732778AbfHVM3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 08:29:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36064 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729212AbfHVM3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 08:29:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id g67so5591958wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 05:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gzVL8rDH4XSsN4Vadk8YEc7OcsBJCS9WRckj0x2C9Ng=;
        b=jo6+B+NpeyoMYop+k8YaZLPGyu9ng5kpuG+vz4e+uEg0XA4IL9M3+BxBzgSZRtGwL+
         s+10j+X6pNtZhI76jyPX3eIodKSoF+pfFAW2rPFu29tImIAmnJJTCYkDEyCUOABrqpyM
         LRugCuLZzp3iC8q2r2yipyqL64I8DWruZ2rzGbWuRFG6MVxqgJ2zlv6HTMQ7bhiCFtza
         I1c1yW8oYEjln+Plulp2reEQMKP2rxVhajR/qoFVbfx8/UHcFcTPR99sOFk2DRuy81aC
         cW4T38dhHMttNZAzKzIJ22KOliC5ONTAih0rRMsp0TRXbE3RT9X/5r3dA4XdOOFG75aH
         ypAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gzVL8rDH4XSsN4Vadk8YEc7OcsBJCS9WRckj0x2C9Ng=;
        b=iFvQMgQEkXE6gepitqtV21RDqaeshGCht40WwRviBZ6EWvuupxW+zmPmLhTyqTIDoB
         LXXJeovCMe457V8mMA4czHIbeSlIJQyub+yDzybzgDAc8PBjwbi7vyrsqs1oBi+jtvYL
         JWs+tVaCDmHZnEZxubzmdRRJzFJ5FkTwAc5WxLIZ+++i6CEa3aFc3HSrhn+Cnh5zRWv/
         AwmXwAkRiYyHz84AZjx8TurZgY+gQ9S71KwKO0563iWP8pH4fcztRdu1LuXHmKZxxGCY
         9WZpiZPDU1fJnDFG06LgVHLyxi3SQq0Uroovrvd9kMZxOIrVr7bWH3ahHN0/ksv7Tlfl
         yNgw==
X-Gm-Message-State: APjAAAXRC2FWEhPysRCFlP/l+lqAU5tRc/P3F+y3iq9CSoe9vtAWn9wH
        Ba1DOBs8k3dahgCnVUUSgwIdXQ==
X-Google-Smtp-Source: APXvYqx4LnQ+mAcp8cDDK0S1ahpLGmUy9KpuKp1HNeHAho8YzwnoyQ3sHFxGNGxJWABsAzxcpmujPg==
X-Received: by 2002:a1c:9950:: with SMTP id b77mr6301928wme.46.1566476991805;
        Thu, 22 Aug 2019 05:29:51 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e751:37a0:1e95:e65d])
        by smtp.gmail.com with ESMTPSA id f6sm54981340wrh.30.2019.08.22.05.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 05:29:51 -0700 (PDT)
Date:   Thu, 22 Aug 2019 13:29:49 +0100
From:   Alessio Balsini <balsini@android.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        luca.abeni@santannapisa.it, bristot@redhat.com, dvyukov@google.com,
        tglx@linutronix.de, vpillai@digitalocean.com, rostedt@goodmis.org,
        kernel-team@android.com
Subject: Re: [RFC][PATCH 01/13] sched/deadline: Impose global limits on
 sched_attr::sched_period
Message-ID: <20190822122949.GA245353@google.com>
References: <20190726145409.947503076@infradead.org>
 <20190726161357.397880775@infradead.org>
 <20190802172104.GA134279@google.com>
 <20190805115309.GJ2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805115309.GJ2349@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 01:53:09PM +0200, Peter Zijlstra wrote:
> 
> Like so?
> 

Yes, that's exactly what I meant!
What about this refactoring?

Thanks,
Alessio

---
From 459d5488acb3fac938b0f35f480a81a6e401ef92 Mon Sep 17 00:00:00 2001
From: Alessio Balsini <balsini@android.com>
Date: Thu, 22 Aug 2019 12:55:55 +0100
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
---
 include/linux/sched/sysctl.h |  7 +++++
 kernel/sched/deadline.c      | 51 ++++++++++++++++++++++++++++++++++--
 kernel/sysctl.c              | 14 ++++++++++
 3 files changed, 70 insertions(+), 2 deletions(-)

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
index 0b9cbfb2b1d4f..fcdf70d9c0516 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2640,6 +2640,42 @@ void __getparam_dl(struct task_struct *p, struct sched_attr *attr)
 	attr->sched_flags = dl_se->flags;
 }
 
+/*
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
+	unsigned int old_max, old_min;
+	static DEFINE_MUTEX(mutex);
+	int ret;
+
+	mutex_lock(&mutex);
+	old_max = sysctl_sched_dl_period_max;
+	old_min = sysctl_sched_dl_period_min;
+
+	ret = proc_douintvec(table, write, buffer, lenp, ppos);
+	if (!ret && write) {
+		u64 max = (u64)sysctl_sched_dl_period_max * NSEC_PER_USEC;
+		u64 min = (u64)sysctl_sched_dl_period_min * NSEC_PER_USEC;
+
+		if (min < 1ULL << DL_SCALE || max < min) {
+			sysctl_sched_dl_period_max = old_max;
+			sysctl_sched_dl_period_min = old_min;
+			ret = -EINVAL;
+		}
+	}
+	mutex_unlock(&mutex);
+
+	return ret;
+}
+
 /*
  * This function validates the new parameters of a -deadline task.
  * We ask for the deadline not being zero, and greater or equal
@@ -2652,6 +2688,8 @@ void __getparam_dl(struct task_struct *p, struct sched_attr *attr)
  */
 bool __checkparam_dl(const struct sched_attr *attr)
 {
+	u64 period, max, min;
+
 	/* special dl tasks don't actually use any parameter */
 	if (attr->sched_flags & SCHED_FLAG_SUGOV)
 		return true;
@@ -2675,12 +2713,21 @@ bool __checkparam_dl(const struct sched_attr *attr)
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


