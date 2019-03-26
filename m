Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8389EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5327B206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731172AbfCZLWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 07:22:08 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57936 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfCZLWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 07:22:07 -0400
Received: from 79.184.253.239.ipv4.supernova.orange.pl (79.184.253.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 42f8ab6b4ead0209; Tue, 26 Mar 2019 12:22:05 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH v3 3/4] cpufreq: schedutil: Simplify iowait boosting
Date:   Tue, 26 Mar 2019 12:18:00 +0100
Message-ID: <2864116.v8IU97Resm@aspire.rjw.lan>
In-Reply-To: <11953735.uMqeHy63Iu@aspire.rjw.lan>
References: <11953735.uMqeHy63Iu@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There is not reason for the minimum iowait boost value in the
schedutil cpufreq governor to depend on the available range of CPU
frequencies.  In fact, that dependency is generally confusing,
because it causes the iowait boost to behave somewhat differently
on CPUs with the same maximum frequency and different minimum
frequencies, for example.

For this reason, replace the min field in struct sugov_cpu
with a constant and choose its values to be 1/8 of
SCHED_CAPACITY_SCALE (for consistency with the intel_pstate
driver's internal governor).

[Note that policy->cpuinfo.max_freq will not be a constant any more
 after a subsequent change, so this change is depended on by it.]

Link: https://lore.kernel.org/lkml/20190305083202.GU32494@hirez.programming.kicks-ass.net/T/#ee20bdc98b7d89f6110c0d00e5c3ee8c2ced93c3d
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/sched/cpufreq_schedutil.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

Index: linux-pm/kernel/sched/cpufreq_schedutil.c
===================================================================
--- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
+++ linux-pm/kernel/sched/cpufreq_schedutil.c
@@ -13,6 +13,8 @@
 #include <linux/sched/cpufreq.h>
 #include <trace/events/power.h>
 
+#define IOWAIT_BOOST_MIN	(SCHED_CAPACITY_SCALE / 8)
+
 struct sugov_tunables {
 	struct gov_attr_set	attr_set;
 	unsigned int		rate_limit_us;
@@ -51,7 +53,6 @@ struct sugov_cpu {
 	u64			last_update;
 
 	unsigned long		bw_dl;
-	unsigned long		min;
 	unsigned long		max;
 
 	/* The field below is for single-CPU policies only: */
@@ -303,7 +304,7 @@ static bool sugov_iowait_reset(struct su
 	if (delta_ns <= TICK_NSEC)
 		return false;
 
-	sg_cpu->iowait_boost = set_iowait_boost ? sg_cpu->min : 0;
+	sg_cpu->iowait_boost = set_iowait_boost ? IOWAIT_BOOST_MIN : 0;
 	sg_cpu->iowait_boost_pending = set_iowait_boost;
 
 	return true;
@@ -349,7 +350,7 @@ static void sugov_iowait_boost(struct su
 	}
 
 	/* First wakeup after IO: start with minimum boost */
-	sg_cpu->iowait_boost = sg_cpu->min;
+	sg_cpu->iowait_boost = IOWAIT_BOOST_MIN;
 }
 
 /**
@@ -389,7 +390,7 @@ static unsigned long sugov_iowait_apply(
 		 * No boost pending; reduce the boost value.
 		 */
 		sg_cpu->iowait_boost >>= 1;
-		if (sg_cpu->iowait_boost < sg_cpu->min) {
+		if (sg_cpu->iowait_boost < IOWAIT_BOOST_MIN) {
 			sg_cpu->iowait_boost = 0;
 			return util;
 		}
@@ -826,9 +827,6 @@ static int sugov_start(struct cpufreq_po
 		memset(sg_cpu, 0, sizeof(*sg_cpu));
 		sg_cpu->cpu			= cpu;
 		sg_cpu->sg_policy		= sg_policy;
-		sg_cpu->min			=
-			(SCHED_CAPACITY_SCALE * policy->cpuinfo.min_freq) /
-			policy->cpuinfo.max_freq;
 	}
 
 	for_each_cpu(cpu, policy->cpus) {

