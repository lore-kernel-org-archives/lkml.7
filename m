Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E177DC0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 20:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF16521852
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 20:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfGDUmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 16:42:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60105 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfGDUmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 16:42:21 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hj8Yb-0008Dh-Q3; Thu, 04 Jul 2019 22:42:17 +0200
Date:   Thu, 4 Jul 2019 22:42:17 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
cc:     x86@kernel.org, Nadav Amit <namit@vmware.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] cpu/hotplug: Cache number of online CPUs
Message-ID: <alpine.DEB.2.21.1907042237010.1802@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revaluating the bitmap wheight of the online cpus bitmap in every
invocation of num_online_cpus() over and over is a pretty useless
exercise. Especially when num_online_cpus() is used in code pathes like the
IPI delivery of x86 or the membarrier code.

Cache the number of online CPUs in the core and just return the cached
variable.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/cpumask.h |   16 +++++++---------
 kernel/cpu.c            |   16 ++++++++++++++++
 2 files changed, 23 insertions(+), 9 deletions(-)

--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -95,8 +95,13 @@ extern struct cpumask __cpu_active_mask;
 #define cpu_present_mask  ((const struct cpumask *)&__cpu_present_mask)
 #define cpu_active_mask   ((const struct cpumask *)&__cpu_active_mask)
 
+extern unsigned int __num_online_cpus;
+
 #if NR_CPUS > 1
-#define num_online_cpus()	cpumask_weight(cpu_online_mask)
+static inline unsigned int num_online_cpus(void)
+{
+	return __num_online_cpus;
+}
 #define num_possible_cpus()	cpumask_weight(cpu_possible_mask)
 #define num_present_cpus()	cpumask_weight(cpu_present_mask)
 #define num_active_cpus()	cpumask_weight(cpu_active_mask)
@@ -821,14 +826,7 @@ set_cpu_present(unsigned int cpu, bool p
 		cpumask_clear_cpu(cpu, &__cpu_present_mask);
 }
 
-static inline void
-set_cpu_online(unsigned int cpu, bool online)
-{
-	if (online)
-		cpumask_set_cpu(cpu, &__cpu_online_mask);
-	else
-		cpumask_clear_cpu(cpu, &__cpu_online_mask);
-}
+void set_cpu_online(unsigned int cpu, bool online);
 
 static inline void
 set_cpu_active(unsigned int cpu, bool active)
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2291,6 +2291,9 @@ EXPORT_SYMBOL(__cpu_present_mask);
 struct cpumask __cpu_active_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_active_mask);
 
+unsigned int __num_online_cpus __read_mostly;
+EXPORT_SYMBOL(__num_online_cpus);
+
 void init_cpu_present(const struct cpumask *src)
 {
 	cpumask_copy(&__cpu_present_mask, src);
@@ -2306,6 +2309,19 @@ void init_cpu_online(const struct cpumas
 	cpumask_copy(&__cpu_online_mask, src);
 }
 
+void set_cpu_online(unsigned int cpu, bool online)
+{
+	lockdep_assert_cpus_held();
+
+	if (online) {
+		if (!cpumask_test_and_set_cpu(cpu, &__cpu_online_mask))
+			__num_online_cpus++;
+	} else {
+		if (cpumask_test_and_clear_cpu(cpu, &__cpu_online_mask))
+			__num_online_cpus--;
+	}
+}
+
 /*
  * Activate the first processor.
  */
