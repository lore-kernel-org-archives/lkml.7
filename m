Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80116C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5571F206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfCEKpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 05:45:44 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:47600 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfCEKpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 05:45:44 -0500
Received: from 79.184.253.110.ipv4.supernova.orange.pl (79.184.253.110) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 09cbfd6f39819c6b; Tue, 5 Mar 2019 11:45:41 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: Improve kerneldoc comments for cpufreq_cpu_get/put()
Date:   Tue, 05 Mar 2019 11:44:04 +0100
Message-ID: <1633242.5muNhsBLsY@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Fix the formatting of the cpufreq_cpu_get() and cpufreq_cpu_put()
kerneldoc comments and rework them to be somewhat easier to follow.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -201,17 +201,15 @@ unsigned int cpufreq_generic_get(unsigne
 EXPORT_SYMBOL_GPL(cpufreq_generic_get);
 
 /**
- * cpufreq_cpu_get: returns policy for a cpu and marks it busy.
+ * cpufreq_cpu_get - Return policy for a CPU and mark it as busy.
+ * @cpu: CPU to find the policy for.
  *
- * @cpu: cpu to find policy for.
+ * Call cpufreq_cpu_get_raw() to obtain a cpufreq policy for @cpu and increment
+ * the kobject reference counter of that policy.  Return a valid policy on
+ * success or NULL on failure.
  *
- * This returns policy for 'cpu', returns NULL if it doesn't exist.
- * It also increments the kobject reference count to mark it busy and so would
- * require a corresponding call to cpufreq_cpu_put() to decrement it back.
- * If corresponding call cpufreq_cpu_put() isn't made, the policy wouldn't be
- * freed as that depends on the kobj count.
- *
- * Return: A valid policy on success, otherwise NULL on failure.
+ * The policy returned by this function has to be released with the help of
+ * cpufreq_cpu_put() to balance its kobject reference counter properly.
  */
 struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
 {
@@ -238,12 +236,8 @@ struct cpufreq_policy *cpufreq_cpu_get(u
 EXPORT_SYMBOL_GPL(cpufreq_cpu_get);
 
 /**
- * cpufreq_cpu_put: Decrements the usage count of a policy
- *
- * @policy: policy earlier returned by cpufreq_cpu_get().
- *
- * This decrements the kobject reference count incremented earlier by calling
- * cpufreq_cpu_get().
+ * cpufreq_cpu_put - Decrement kobject usage counter for cpufreq policy.
+ * @policy: cpufreq policy returned by cpufreq_cpu_get().
  */
 void cpufreq_cpu_put(struct cpufreq_policy *policy)
 {

