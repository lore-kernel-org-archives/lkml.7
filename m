Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644BBC73C50
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 14:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4055F20844
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 14:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfGIOXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 10:23:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45365 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfGIOXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 10:23:47 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hkr1w-0008Fa-NE; Tue, 09 Jul 2019 16:23:40 +0200
Date:   Tue, 9 Jul 2019 16:23:40 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH V3] cpu/hotplug: Cache number of online CPUs
In-Reply-To: <alpine.DEB.2.21.1907081618270.4709@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1907091622590.1634@nanos.tec.linutronix.de>
References: <1987107359.5048.1562273987626.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.1907042302570.1802@nanos.tec.linutronix.de> <1623929363.5480.1562277655641.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.1907050024270.1802@nanos.tec.linutronix.de>
 <611100399.5550.1562283294601.JavaMail.zimbra@efficios.com> <20190705084910.GA6592@gmail.com> <824482130.8027.1562341133252.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.1907052246220.3648@nanos.tec.linutronix.de> <alpine.DEB.2.21.1907052256490.3648@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907081531560.4709@nanos.tec.linutronix.de> <20190708140732.GI26519@linux.ibm.com> <alpine.DEB.2.21.1907081618270.4709@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
V3: Make __num_online_cpus an atomic_t because the kexec and reboot code
    (ab)use set_cpu_online() in their 'shutdown' handlers.

V2: Use READ/WRITE_ONCE() and add comment what it actually achieves. Remove
    the bogus lockdep assert in the write path as the caller cannot hold the
    lock. It's a task on the plugged CPU which is not the controlling task.
---
 include/linux/cpumask.h |   25 ++++++++++++++++---------
 kernel/cpu.c            |   24 ++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 9 deletions(-)

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
@@ -805,14 +819,7 @@ set_cpu_present(unsigned int cpu, bool p
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
@@ -2295,6 +2295,9 @@ EXPORT_SYMBOL(__cpu_present_mask);
 struct cpumask __cpu_active_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_active_mask);
 
+atomic_t __num_online_cpus __read_mostly;
+EXPORT_SYMBOL(__num_online_cpus);
+
 void init_cpu_present(const struct cpumask *src)
 {
 	cpumask_copy(&__cpu_present_mask, src);
@@ -2310,6 +2313,27 @@ void init_cpu_online(const struct cpumas
 	cpumask_copy(&__cpu_online_mask, src);
 }
 
+void set_cpu_online(unsigned int cpu, bool online)
+{
+	/*
+	 * atomic_inc/dec() is required to handle the horrid abuse of this
+	 * function by the reboot and kexec code which invokes it from
+	 * IPI/NMI broadcasts when shutting down CPUs. Inocation from
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
