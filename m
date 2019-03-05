Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC464C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 08:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 812902082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 08:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bHjeTqBy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfCEIcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 03:32:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54832 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbfCEIcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 03:32:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=77jwDy4RuX2sI8qieFmBtvqB/BzJSMkzZw/neayWxy0=; b=bHjeTqByDqHyijEnFKftHLRUX
        VPbvv3J4GDCvHDbmFeano0OzK+UFjfiC7c9vH0E6uzqZMbBHbxk6+XwZICRIUDIz3H5yEsJCJb6Qn
        oXkSZa1pNS8Ui6vBa8ifMjWYHb4bIfStFx7DYfIj4PHSEebFBbi2wEQ0ITUur6zjbW4m+Ik7/1oIA
        ctWeU5CCzFQMTCA+ylEcxILPbp4Mgjp+lIizWNQmj6QJwGuspTB1YhGXmfK8AVpxRz80e6g8v1qBD
        t542w2Ma0inS8+c2IdQ5QlDkVot9hqdYBiOSvurCN2DK2Gvazb9HZXhF/QUmtOdshZskBo1fHlq0h
        9Hq12EDQA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h15Ub-0007wN-02; Tue, 05 Mar 2019 08:32:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8A6832007278A; Tue,  5 Mar 2019 09:32:02 +0100 (CET)
Date:   Tue, 5 Mar 2019 09:32:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     =?utf-8?B?V2FuZywgVmluY2VudCAo546L5LqJKQ==?= 
        <Vincent.Wang@unisoc.com>,
        =?utf-8?B?WmhhbmcsIENodW55YW4gKOW8oOaYpeiJsyk=?= 
        <Chunyan.Zhang@unisoc.com>, Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] sched/cpufreq: Fix 32bit math overflow
Message-ID: <20190305083202.GU32494@hirez.programming.kicks-ass.net>
References: <1550831866-32749-1-git-send-email-chunyan.zhang@unisoc.com>
 <20190222105957.wxhlcmoag5f3i4fi@queper01-lin>
 <9099990618e242e1bab77ce3f9d9b1e3@BJMBX02.spreadtrum.com>
 <20190304135810.rq2ojnbn5vezrab3@queper01-lin>
 <20190304152616.GM32494@hirez.programming.kicks-ass.net>
 <20190304164816.4fnxxesjwzdoqria@queper01-lin>
 <20190304174028.GO32494@hirez.programming.kicks-ass.net>
 <20190304175030.4slf247y2eftkmu4@queper01-lin>
 <20190304184708.GQ32494@hirez.programming.kicks-ass.net>
 <20190304191059.mzwid3udqwtzejww@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304191059.mzwid3udqwtzejww@queper01-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 07:11:01PM +0000, Quentin Perret wrote:

> So yeah, that works for me.

Chunyan, Vincent; can you verify the below cures your ill?

---
Subject: sched/cpufreq: Fix 32bit math overflow

Vincent Wang reported that get_next_freq() has a mult overflow issue on
32bit platforms in the IOWAIT boost case, since in that case {util,max}
are in freq units instead of capacity units.

Solve this by moving the IOWAIT boost to capacity units. And since this
means @max is constant; simplify the code.

Cc: Chunyan Zhang <chunyan.zhang@unisoc.com>
Reported-by: Vincent Wang <vincent.wang@unisoc.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/cpufreq_schedutil.c | 58 +++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 34 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 2efe629425be..72b62ac1c7c2 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -48,10 +48,10 @@ struct sugov_cpu {
 
 	bool			iowait_boost_pending;
 	unsigned int		iowait_boost;
-	unsigned int		iowait_boost_max;
 	u64			last_update;
 
 	unsigned long		bw_dl;
+	unsigned long		min;
 	unsigned long		max;
 
 	/* The field below is for single-CPU policies only: */
@@ -303,8 +303,7 @@ static bool sugov_iowait_reset(struct sugov_cpu *sg_cpu, u64 time,
 	if (delta_ns <= TICK_NSEC)
 		return false;
 
-	sg_cpu->iowait_boost = set_iowait_boost
-		? sg_cpu->sg_policy->policy->min : 0;
+	sg_cpu->iowait_boost = set_iowait_boost ? sg_cpu->min : 0;
 	sg_cpu->iowait_boost_pending = set_iowait_boost;
 
 	return true;
@@ -344,14 +343,12 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
 
 	/* Double the boost at each request */
 	if (sg_cpu->iowait_boost) {
-		sg_cpu->iowait_boost <<= 1;
-		if (sg_cpu->iowait_boost > sg_cpu->iowait_boost_max)
-			sg_cpu->iowait_boost = sg_cpu->iowait_boost_max;
+		sg_cpu->iowait_boost = min(sg_cpu->iowait_boost << 1, SCHED_CAPACITY_SCALE);
 		return;
 	}
 
 	/* First wakeup after IO: start with minimum boost */
-	sg_cpu->iowait_boost = sg_cpu->sg_policy->policy->min;
+	sg_cpu->iowait_boost = sg_cpu->min;
 }
 
 /**
@@ -373,47 +370,38 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
  * This mechanism is designed to boost high frequently IO waiting tasks, while
  * being more conservative on tasks which does sporadic IO operations.
  */
-static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
-			       unsigned long *util, unsigned long *max)
+static unsigned long sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
+					unsigned long util, unsigned long max)
 {
-	unsigned int boost_util, boost_max;
+	unsigned long boost;
 
 	/* No boost currently required */
 	if (!sg_cpu->iowait_boost)
-		return;
+		return util;
 
 	/* Reset boost if the CPU appears to have been idle enough */
 	if (sugov_iowait_reset(sg_cpu, time, false))
-		return;
+		return util;
 
-	/*
-	 * An IO waiting task has just woken up:
-	 * allow to further double the boost value
-	 */
-	if (sg_cpu->iowait_boost_pending) {
-		sg_cpu->iowait_boost_pending = false;
-	} else {
+	if (!sg_cpu->iowait_boost_pending) {
 		/*
-		 * Otherwise: reduce the boost value and disable it when we
-		 * reach the minimum.
+		 * No boost pending; reduce the boost value.
 		 */
 		sg_cpu->iowait_boost >>= 1;
-		if (sg_cpu->iowait_boost < sg_cpu->sg_policy->policy->min) {
+		if (sg_cpu->iowait_boost < sg_cpu->min) {
 			sg_cpu->iowait_boost = 0;
-			return;
+			return util;
 		}
 	}
 
+	sg_cpu->iowait_boost_pending = false;
+
 	/*
-	 * Apply the current boost value: a CPU is boosted only if its current
-	 * utilization is smaller then the current IO boost level.
+	 * @util is already in capacity scale; convert iowait_boost
+	 * into the same scale so we can compare.
 	 */
-	boost_util = sg_cpu->iowait_boost;
-	boost_max = sg_cpu->iowait_boost_max;
-	if (*util * boost_max < *max * boost_util) {
-		*util = boost_util;
-		*max = boost_max;
-	}
+	boost = (sg_cpu->iowait_boost * max) >> SCHED_CAPACITY_SHIFT;
+	return max(boost, util);
 }
 
 #ifdef CONFIG_NO_HZ_COMMON
@@ -460,7 +448,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 
 	util = sugov_get_util(sg_cpu);
 	max = sg_cpu->max;
-	sugov_iowait_apply(sg_cpu, time, &util, &max);
+	util = sugov_iowait_apply(sg_cpu, time, util, max);
 	next_f = get_next_freq(sg_policy, util, max);
 	/*
 	 * Do not reduce the frequency if the CPU has not been idle
@@ -500,7 +488,7 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 
 		j_util = sugov_get_util(j_sg_cpu);
 		j_max = j_sg_cpu->max;
-		sugov_iowait_apply(j_sg_cpu, time, &j_util, &j_max);
+		j_util = sugov_iowait_apply(j_sg_cpu, time, j_util, j_max);
 
 		if (j_util * max > j_max * util) {
 			util = j_util;
@@ -837,7 +825,9 @@ static int sugov_start(struct cpufreq_policy *policy)
 		memset(sg_cpu, 0, sizeof(*sg_cpu));
 		sg_cpu->cpu			= cpu;
 		sg_cpu->sg_policy		= sg_policy;
-		sg_cpu->iowait_boost_max	= policy->cpuinfo.max_freq;
+		sg_cpu->min			=
+			(SCHED_CAPACITY_SCALE * policy->cpuinfo.min_freq) /
+			policy->cpuinfo.max_freq;
 	}
 
 	for_each_cpu(cpu, policy->cpus) {
