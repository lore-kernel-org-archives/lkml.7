Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0320BC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB7A2238E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732062AbfGVS5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:57:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38079 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731931AbfGVS5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:57:06 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hpdUe-0002Po-CY; Mon, 22 Jul 2019 20:57:04 +0200
Message-Id: <20190722105219.818822855@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 22 Jul 2019 20:47:16 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [patch V3 11/25] smp/hotplug: Track booted once CPUs in a cpumask
References: <20190722104705.550071814@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The booted once information which is required to deal with the MCE
broadcast issue on X86 correctly is stored in the per cpu hotplug state,
which is perfectly fine for the intended purpose.

X86 needs that information for supporting NMI broadcasting via shortcuts,
but retrieving it from per cpu data is cumbersome.

Move it to a cpumask so the information can be checked against the
cpu_present_mask quickly.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/cpumask.h |    2 ++
 kernel/cpu.c            |   11 +++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -115,6 +115,8 @@ extern struct cpumask __cpu_active_mask;
 #define cpu_active(cpu)		((cpu) == 0)
 #endif
 
+extern cpumask_t cpus_booted_once_mask;
+
 static inline void cpu_max_bits_warn(unsigned int cpu, unsigned int bits)
 {
 #ifdef CONFIG_DEBUG_PER_CPU_MAPS
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -62,7 +62,6 @@ struct cpuhp_cpu_state {
 	bool			rollback;
 	bool			single;
 	bool			bringup;
-	bool			booted_once;
 	struct hlist_node	*node;
 	struct hlist_node	*last;
 	enum cpuhp_state	cb_state;
@@ -76,6 +75,10 @@ static DEFINE_PER_CPU(struct cpuhp_cpu_s
 	.fail = CPUHP_INVALID,
 };
 
+#ifdef CONFIG_SMP
+cpumask_t cpus_booted_once_mask;
+#endif
+
 #if defined(CONFIG_LOCKDEP) && defined(CONFIG_SMP)
 static struct lockdep_map cpuhp_state_up_map =
 	STATIC_LOCKDEP_MAP_INIT("cpuhp_state-up", &cpuhp_state_up_map);
@@ -433,7 +436,7 @@ static inline bool cpu_smt_allowed(unsig
 	 * CPU. Otherwise, a broadacasted MCE observing CR4.MCE=0b on any
 	 * core will shutdown the machine.
 	 */
-	return !per_cpu(cpuhp_state, cpu).booted_once;
+	return !cpumask_test_cpu(cpu, &cpus_booted_once_mask);
 }
 #else
 static inline bool cpu_smt_allowed(unsigned int cpu) { return true; }
@@ -1066,7 +1069,7 @@ void notify_cpu_starting(unsigned int cp
 	int ret;
 
 	rcu_cpu_starting(cpu);	/* Enables RCU usage on this CPU. */
-	st->booted_once = true;
+	cpumask_set_cpu(cpu, &cpus_booted_once_mask);
 	while (st->state < target) {
 		st->state++;
 		ret = cpuhp_invoke_callback(cpu, st->state, true, NULL, NULL);
@@ -2334,7 +2337,7 @@ void __init boot_cpu_init(void)
 void __init boot_cpu_hotplug_init(void)
 {
 #ifdef CONFIG_SMP
-	this_cpu_write(cpuhp_state.booted_once, true);
+	cpumask_set_cpu(smp_processor_id(), &cpus_booted_once_mask);
 #endif
 	this_cpu_write(cpuhp_state.state, CPUHP_ONLINE);
 }


