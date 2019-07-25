Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EDAC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0CBC22BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="N6D12IZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387946AbfGYOLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:11:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59779 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfGYOLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:11:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PEBbs91034597
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 07:11:37 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PEBbs91034597
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564063897;
        bh=7JGseR0bVy0xVqa8LExCGvzMWU7h3l1m9/yU+BJljzU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=N6D12IZ87yjAA/ysG59sFH1qRyt7qphxB+MSQC23K6XfLB9IG0cr60XrjyDoxJx98
         O1thNIetZtrzFkvIDYw48h8ITWkJDHdzXUZrlbMBHKR1H+W0Zi8EWPoiL8UJU4MJ6U
         lhOCuG/e1sCE9HchRJznKeWICt1Mn+4VOya2HSPAYolFwDEgPpJU/bTpM6rrgTp1Zv
         ARuG3VJisnCZMSlxdIevyrM4D2ij7bTR12pKIpoXI2Ng67MgymkMnozKi/9PJ1IDDE
         fuG7o7tzvnYSyE4Qojg43A0IywxqvZr6nH+gGW61kpnMG2pDi/emE2yaKTCiVIXOnO
         qdSCgVu/1njAQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PEBaAC1034594;
        Thu, 25 Jul 2019 07:11:36 -0700
Date:   Thu, 25 Jul 2019 07:11:36 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-0c09ab96fc820109d63097a2adcbbd20836b655f@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, mathieu.desnoyers@efficios.com
Reply-To: mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
          mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.1907091622590.1634@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1907091622590.1634@nanos.tec.linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:smp/hotplug] cpu/hotplug: Cache number of online CPUs
Git-Commit-ID: 0c09ab96fc820109d63097a2adcbbd20836b655f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0c09ab96fc820109d63097a2adcbbd20836b655f
Gitweb:     https://git.kernel.org/tip/0c09ab96fc820109d63097a2adcbbd20836b655f
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Tue, 9 Jul 2019 16:23:40 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Jul 2019 15:48:01 +0200

cpu/hotplug: Cache number of online CPUs

Re-evaluating the bitmap wheight of the online cpus bitmap in every
invocation of num_online_cpus() over and over is a pretty useless
exercise. Especially when num_online_cpus() is used in code paths
like the IPI delivery of x86 or the membarrier code.

Cache the number of online CPUs in the core and just return the cached
variable. The accessor function provides only a snapshot when used without
protection against concurrent CPU hotplug.

The storage needs to use an atomic_t because the kexec and reboot code
(ab)use set_cpu_online() in their 'shutdown' handlers without any form of
serialization as pointed out by Mathieu. Regular CPU hotplug usage is
properly serialized.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1907091622590.1634@nanos.tec.linutronix.de

---
 include/linux/cpumask.h | 25 ++++++++++++++++---------
 kernel/cpu.c            | 24 ++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 0c7db5efe66c..b5a5a1ed9efd 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/threads.h>
 #include <linux/bitmap.h>
+#include <linux/atomic.h>
 #include <linux/bug.h>
 
 /* Don't assign or return these: may not be this big! */
@@ -95,8 +96,21 @@ extern struct cpumask __cpu_active_mask;
 #define cpu_present_mask  ((const struct cpumask *)&__cpu_present_mask)
 #define cpu_active_mask   ((const struct cpumask *)&__cpu_active_mask)
 
+extern atomic_t __num_online_cpus;
+
 #if NR_CPUS > 1
-#define num_online_cpus()	cpumask_weight(cpu_online_mask)
+/**
+ * num_online_cpus() - Read the number of online CPUs
+ *
+ * Despite the fact that __num_online_cpus is of type atomic_t, this
+ * interface gives only a momentary snapshot and is not protected against
+ * concurrent CPU hotplug operations unless invoked from a cpuhp_lock held
+ * region.
+ */
+static inline unsigned int num_online_cpus(void)
+{
+	return atomic_read(&__num_online_cpus);
+}
 #define num_possible_cpus()	cpumask_weight(cpu_possible_mask)
 #define num_present_cpus()	cpumask_weight(cpu_present_mask)
 #define num_active_cpus()	cpumask_weight(cpu_active_mask)
@@ -821,14 +835,7 @@ set_cpu_present(unsigned int cpu, bool present)
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
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 05778e32674a..e1967e9eddc2 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2298,6 +2298,9 @@ EXPORT_SYMBOL(__cpu_present_mask);
 struct cpumask __cpu_active_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_active_mask);
 
+atomic_t __num_online_cpus __read_mostly;
+EXPORT_SYMBOL(__num_online_cpus);
+
 void init_cpu_present(const struct cpumask *src)
 {
 	cpumask_copy(&__cpu_present_mask, src);
@@ -2313,6 +2316,27 @@ void init_cpu_online(const struct cpumask *src)
 	cpumask_copy(&__cpu_online_mask, src);
 }
 
+void set_cpu_online(unsigned int cpu, bool online)
+{
+	/*
+	 * atomic_inc/dec() is required to handle the horrid abuse of this
+	 * function by the reboot and kexec code which invoke it from
+	 * IPI/NMI broadcasts when shutting down CPUs. Invocation from
+	 * regular CPU hotplug is properly serialized.
+	 *
+	 * Note, that the fact that __num_online_cpus is of type atomic_t
+	 * does not protect readers which are not serialized against
+	 * concurrent hotplug operations.
+	 */
+	if (online) {
+		if (!cpumask_test_and_set_cpu(cpu, &__cpu_online_mask))
+			atomic_inc(&__num_online_cpus);
+	} else {
+		if (cpumask_test_and_clear_cpu(cpu, &__cpu_online_mask))
+			atomic_dec(&__num_online_cpus);
+	}
+}
+
 /*
  * Activate the first processor.
  */
