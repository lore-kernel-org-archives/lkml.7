Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3E0C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A502064A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907972;
	bh=87+GCCcWB/VaEalSOy+QNtnhzKqxmH9lpQyyDGH1vbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CBJ6Xr0HqMiQ28NkoyhpjtemgdgpOzsCAHVdaoJka8Zwz3cZ7HESV2etipo1yqPIx
	 p3TnvZJN1uJudAOiXykVgsyUB+qsgBmnvX1MIkYA2pveXf3ANywVx9T4tG6Jjy2I+H
	 tyc3hQ/+jZUPKqNwmWlN2Py+rdF5qWiljX7PM2RU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731345AbfC3Axp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:53:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731309AbfC3Axn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:53:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 280C2218AC;
        Sat, 30 Mar 2019 00:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907221;
        bh=87+GCCcWB/VaEalSOy+QNtnhzKqxmH9lpQyyDGH1vbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AeWMTOyplu87CHgtLGz4lpwYU/F7nGX71Afa7XIoXOo9Kovp8I4QAK9TLdME1FVWW
         fqxgEgQ5NV6dVrZchpnZ+U44uAd3FWFoIV7sa55OGj06e0MxsIdwXiI8d0kzxroiZ8
         RYl/0e3yRGBNG62a4YZ1yTymevoKb+A9yVAq0qOU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Quentin Perret <quentin.perret@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 24/52] sched/cpufreq: Fix 32-bit math overflow
Date:   Fri, 29 Mar 2019 20:52:31 -0400
Message-Id: <20190330005301.26868-24-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005301.26868-1-sashal@kernel.org>
References: <20190330005301.26868-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

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
index 3fffad3bc8a8..217f81ecae17 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -50,10 +50,10 @@ struct sugov_cpu {
 
 	bool			iowait_boost_pending;
 	unsigned int		iowait_boost;
-	unsigned int		iowait_boost_max;
 	u64			last_update;
 
 	unsigned long		bw_dl;
+	unsigned long		min;
 	unsigned long		max;
 
 	/* The field below is for single-CPU policies only: */
@@ -283,8 +283,7 @@ static bool sugov_iowait_reset(struct sugov_cpu *sg_cpu, u64 time,
 	if (delta_ns <= TICK_NSEC)
 		return false;
 
-	sg_cpu->iowait_boost = set_iowait_boost
-		? sg_cpu->sg_policy->policy->min : 0;
+	sg_cpu->iowait_boost = set_iowait_boost ? sg_cpu->min : 0;
 	sg_cpu->iowait_boost_pending = set_iowait_boost;
 
 	return true;
@@ -324,14 +323,13 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
 
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
@@ -353,47 +351,38 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
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
@@ -440,7 +429,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 
 	util = sugov_get_util(sg_cpu);
 	max = sg_cpu->max;
-	sugov_iowait_apply(sg_cpu, time, &util, &max);
+	util = sugov_iowait_apply(sg_cpu, time, util, max);
 	next_f = get_next_freq(sg_policy, util, max);
 	/*
 	 * Do not reduce the frequency if the CPU has not been idle
@@ -480,7 +469,7 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 
 		j_util = sugov_get_util(j_sg_cpu);
 		j_max = j_sg_cpu->max;
-		sugov_iowait_apply(j_sg_cpu, time, &j_util, &j_max);
+		j_util = sugov_iowait_apply(j_sg_cpu, time, j_util, j_max);
 
 		if (j_util * max > j_max * util) {
 			util = j_util;
@@ -817,7 +806,9 @@ static int sugov_start(struct cpufreq_policy *policy)
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

