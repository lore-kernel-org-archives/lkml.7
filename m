Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCB7C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE6FD206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfCEKo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 05:44:27 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:42331 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfCEKo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 05:44:27 -0500
Received: from 79.184.253.110.ipv4.supernova.orange.pl (79.184.253.110) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id f28a257d37f4d0ac; Tue, 5 Mar 2019 11:44:24 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH v2 2/3] cpufreq: Add cpufreq_cpu_acquire() and cpufreq_cpu_release()
Date:   Tue, 05 Mar 2019 11:37:18 +0100
Message-ID: <2924036.MijKVBYPyq@aspire.rjw.lan>
In-Reply-To: <1755407.S0oJirvq9V@aspire.rjw.lan>
References: <1755407.S0oJirvq9V@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It sometimes is necessary to find a cpufreq policy for a given CPU
and acquire its rwsem (for writing) immediately after that, so
introduce cpufreq_cpu_acquire() as a helper for that and the
complementary cpufreq_cpu_release().

Make cpufreq_update_policy() use the new functions.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2: New patch.

---
 drivers/cpufreq/cpufreq.c |   56 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 9 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -256,6 +256,51 @@ void cpufreq_cpu_put(struct cpufreq_poli
 }
 EXPORT_SYMBOL_GPL(cpufreq_cpu_put);
 
+/**
+ * cpufreq_cpu_release - Unlock a policy and decrement its usage counter.
+ * @policy: cpufreq policy returned by cpufreq_cpu_acquire().
+ */
+static void cpufreq_cpu_release(struct cpufreq_policy *policy)
+{
+	if (WARN_ON(!policy))
+		return;
+
+	lockdep_assert_held(&policy->rwsem);
+
+	up_write(&policy->rwsem);
+
+	cpufreq_cpu_put(policy);
+}
+
+/**
+ * cpufreq_cpu_acquire - Find policy for a CPU, mark it as busy and lock it.
+ * @cpu: CPU to find the policy for.
+ *
+ * Call cpufreq_cpu_get() to get a reference on the cpufreq policy for @cpu and
+ * if the policy returned by it is not NULL, acquire its rwsem for writing.
+ * Return the policy if it is active or release it and return NULL otherwise.
+ *
+ * The policy returned by this function has to be released with the help of
+ * cpufreq_cpu_release() in order to release its rwsem and balance its usage
+ * counter properly.
+ */
+static struct cpufreq_policy *cpufreq_cpu_acquire(unsigned int cpu)
+{
+	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+
+	if (!policy)
+		return NULL;
+
+	down_write(&policy->rwsem);
+
+	if (policy_is_inactive(policy)) {
+		cpufreq_cpu_release(policy);
+		return NULL;
+	}
+
+	return policy;
+}
+
 /*********************************************************************
  *            EXTERNALLY AFFECTING FREQUENCY CHANGES                 *
  *********************************************************************/
@@ -2343,17 +2388,12 @@ static int cpufreq_set_policy(struct cpu
  */
 void cpufreq_update_policy(unsigned int cpu)
 {
-	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	struct cpufreq_policy *policy = cpufreq_cpu_acquire(cpu);
 	struct cpufreq_policy new_policy;
 
 	if (!policy)
 		return;
 
-	down_write(&policy->rwsem);
-
-	if (policy_is_inactive(policy))
-		goto unlock;
-
 	/*
 	 * BIOS might change freq behind our back
 	 * -> ask driver for current freq and notify governors about a change
@@ -2370,9 +2410,7 @@ void cpufreq_update_policy(unsigned int
 	cpufreq_set_policy(policy, &new_policy);
 
 unlock:
-	up_write(&policy->rwsem);
-
-	cpufreq_cpu_put(policy);
+	cpufreq_cpu_release(policy);
 }
 EXPORT_SYMBOL(cpufreq_update_policy);
 

