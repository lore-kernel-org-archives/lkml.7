Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247B5C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD33D206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611503;
	bh=wOz438wfGRJ0y8eOASyS7ZjEoL1gxH/yMtbNGHV09zU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZdpXgDdT9Ux/G7ElGld0g+CyRfJNRW2CVvwE9X0mqfE2YnrKIpL0iNWgrV9dvC4CW
	 egyWlZaBAc+bmcr0/lXOhe8absXmvpbWBPxjQImCqsuOgVirTacZ71COIGiFtZI9gV
	 2EdRkH6Ed8jrjLTeJkttC5WzEu379Cd5nAIiiDkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404152AbfDRSKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:10:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391608AbfDRSKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:10:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1713A20675;
        Thu, 18 Apr 2019 18:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611036;
        bh=wOz438wfGRJ0y8eOASyS7ZjEoL1gxH/yMtbNGHV09zU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SlU87ZUjjfxr1cwCV6kvwx1rqGEid1zWjt9E6giaDNl5lWAPpD0+iBq4TZ7WVBf7i
         51M4ybsgVbksbgR1fPlrGDkiVl5bJmQzckiERfC5TUa53Jxv4ysysCBodV5lFOUQS+
         sjFkOn2l/HDg5wVe8ZTFWmHrudggy0JFgNuTzrBk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vincent Wang <vincent.wang@unisoc.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Quentin Perret <quentin.perret@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 27/93] sched/cpufreq: Fix 32-bit math overflow
Date:   Thu, 18 Apr 2019 19:57:05 +0200
Message-Id: <20190418160439.639670384@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit a23314e9d88d89d49e69db08f60b7caa470f04e1 ]

Vincent Wang reported that get_next_freq() has a mult overflow bug on
32-bit platforms in the IOWAIT boost case, since in that case {util,max}
are in freq units instead of capacity units.

Solve this by moving the IOWAIT boost to capacity units. And since this
means @max is constant; simplify the code.

Reported-by: Vincent Wang <vincent.wang@unisoc.com>
Tested-by: Vincent Wang <vincent.wang@unisoc.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Perret <quentin.perret@arm.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190305083202.GU32494@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/cpufreq_schedutil.c | 59 ++++++++++++++------------------
 1 file changed, 25 insertions(+), 34 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 033ec7c45f13..1ccf77f6d346 100644
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
@@ -344,14 +343,13 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
 
 	/* Double the boost at each request */
 	if (sg_cpu->iowait_boost) {
-		sg_cpu->iowait_boost <<= 1;
-		if (sg_cpu->iowait_boost > sg_cpu->iowait_boost_max)
-			sg_cpu->iowait_boost = sg_cpu->iowait_boost_max;
+		sg_cpu->iowait_boost =
+			min_t(unsigned int, sg_cpu->iowait_boost << 1, SCHED_CAPACITY_SCALE);
 		return;
 	}
 
 	/* First wakeup after IO: start with minimum boost */
-	sg_cpu->iowait_boost = sg_cpu->sg_policy->policy->min;
+	sg_cpu->iowait_boost = sg_cpu->min;
 }
 
 /**
@@ -373,47 +371,38 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
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
@@ -460,7 +449,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 
 	util = sugov_get_util(sg_cpu);
 	max = sg_cpu->max;
-	sugov_iowait_apply(sg_cpu, time, &util, &max);
+	util = sugov_iowait_apply(sg_cpu, time, util, max);
 	next_f = get_next_freq(sg_policy, util, max);
 	/*
 	 * Do not reduce the frequency if the CPU has not been idle
@@ -500,7 +489,7 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 
 		j_util = sugov_get_util(j_sg_cpu);
 		j_max = j_sg_cpu->max;
-		sugov_iowait_apply(j_sg_cpu, time, &j_util, &j_max);
+		j_util = sugov_iowait_apply(j_sg_cpu, time, j_util, j_max);
 
 		if (j_util * max > j_max * util) {
 			util = j_util;
@@ -837,7 +826,9 @@ static int sugov_start(struct cpufreq_policy *policy)
 		memset(sg_cpu, 0, sizeof(*sg_cpu));
 		sg_cpu->cpu			= cpu;
 		sg_cpu->sg_policy		= sg_policy;
-		sg_cpu->iowait_boost_max	= policy->cpuinfo.max_freq;
+		sg_cpu->min			=
+			(SCHED_CAPACITY_SCALE * policy->cpuinfo.min_freq) /
+			policy->cpuinfo.max_freq;
 	}
 
 	for_each_cpu(cpu, policy->cpus) {
-- 
2.19.1



