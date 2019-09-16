Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0E3C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C9B21670
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387542AbfIPNiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 09:38:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39245 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbfIPNh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 09:37:58 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i9rCV-0006vM-80; Mon, 16 Sep 2019 15:37:55 +0200
Date:   Mon, 16 Sep 2019 13:30:20 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] smp/hotplug for 5.4-rc1
References: <156864062018.3407.16580572772546914005.tglx@nanos.tec.linutronix.de>
Message-ID: <156864062018.3407.12735658875708933630.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest smp-hotplug-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-hotplug-for-linus

up to:  0c09ab96fc82: cpu/hotplug: Cache number of online CPUs

A small update for the SMP hotplug code code:

  - Track bootet once CPUs in a cpumask so the x86 APIC code has an easy
    way to decide whether broadcast IPIs are safe to use or not.

  - Implement a cpumask_or_equal() helper for the IPI broadcast evaluation.

    The above two changes have been also pulled into the x86/apic branch
    for implementing the conditional IPI broadcast feature.

  - Cache the number of online CPUs instead of reevaluating it over and
    over. num_online_cpus() is an unreliable snapshot anyway except when it
    is used outside a cpu hotplug locked region. The cached access is not
    changing this, but it's definitely faster than calculating the bitmap
    wheight especially in hot pathes.

Thanks,

	tglx

------------------>
Thomas Gleixner (3):
      smp/hotplug: Track booted once CPUs in a cpumask
      cpumask: Implement cpumask_or_equal()
      cpu/hotplug: Cache number of online CPUs


 include/linux/bitmap.h  | 23 +++++++++++++++++++++++
 include/linux/cpumask.h | 41 ++++++++++++++++++++++++++++++++---------
 kernel/cpu.c            | 35 +++++++++++++++++++++++++++++++----
 lib/bitmap.c            | 20 ++++++++++++++++++++
 4 files changed, 106 insertions(+), 13 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index f58e97446abc..90528f12bdfa 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -120,6 +120,10 @@ extern int __bitmap_empty(const unsigned long *bitmap, unsigned int nbits);
 extern int __bitmap_full(const unsigned long *bitmap, unsigned int nbits);
 extern int __bitmap_equal(const unsigned long *bitmap1,
 			  const unsigned long *bitmap2, unsigned int nbits);
+extern bool __pure __bitmap_or_equal(const unsigned long *src1,
+				     const unsigned long *src2,
+				     const unsigned long *src3,
+				     unsigned int nbits);
 extern void __bitmap_complement(unsigned long *dst, const unsigned long *src,
 			unsigned int nbits);
 extern void __bitmap_shift_right(unsigned long *dst, const unsigned long *src,
@@ -321,6 +325,25 @@ static inline int bitmap_equal(const unsigned long *src1,
 	return __bitmap_equal(src1, src2, nbits);
 }
 
+/**
+ * bitmap_or_equal - Check whether the or of two bitnaps is equal to a third
+ * @src1:	Pointer to bitmap 1
+ * @src2:	Pointer to bitmap 2 will be or'ed with bitmap 1
+ * @src3:	Pointer to bitmap 3. Compare to the result of *@src1 | *@src2
+ *
+ * Returns: True if (*@src1 | *@src2) == *@src3, false otherwise
+ */
+static inline bool bitmap_or_equal(const unsigned long *src1,
+				   const unsigned long *src2,
+				   const unsigned long *src3,
+				   unsigned int nbits)
+{
+	if (!small_const_nbits(nbits))
+		return __bitmap_or_equal(src1, src2, src3, nbits);
+
+	return !(((*src1 | *src2) ^ *src3) & BITMAP_LAST_WORD_MASK(nbits));
+}
+
 static inline int bitmap_intersects(const unsigned long *src1,
 			const unsigned long *src2, unsigned int nbits)
 {
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 21755471b1c3..b5a5a1ed9efd 100644
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
@@ -115,6 +129,8 @@ extern struct cpumask __cpu_active_mask;
 #define cpu_active(cpu)		((cpu) == 0)
 #endif
 
+extern cpumask_t cpus_booted_once_mask;
+
 static inline void cpu_max_bits_warn(unsigned int cpu, unsigned int bits)
 {
 #ifdef CONFIG_DEBUG_PER_CPU_MAPS
@@ -473,6 +489,20 @@ static inline bool cpumask_equal(const struct cpumask *src1p,
 						 nr_cpumask_bits);
 }
 
+/**
+ * cpumask_or_equal - *src1p | *src2p == *src3p
+ * @src1p: the first input
+ * @src2p: the second input
+ * @src3p: the third input
+ */
+static inline bool cpumask_or_equal(const struct cpumask *src1p,
+				    const struct cpumask *src2p,
+				    const struct cpumask *src3p)
+{
+	return bitmap_or_equal(cpumask_bits(src1p), cpumask_bits(src2p),
+			       cpumask_bits(src3p), nr_cpumask_bits);
+}
+
 /**
  * cpumask_intersects - (*src1p & *src2p) != 0
  * @src1p: the first input
@@ -805,14 +835,7 @@ set_cpu_present(unsigned int cpu, bool present)
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
index e84c0873559e..e1967e9eddc2 100644
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
@@ -76,6 +75,10 @@ static DEFINE_PER_CPU(struct cpuhp_cpu_state, cpuhp_state) = {
 	.fail = CPUHP_INVALID,
 };
 
+#ifdef CONFIG_SMP
+cpumask_t cpus_booted_once_mask;
+#endif
+
 #if defined(CONFIG_LOCKDEP) && defined(CONFIG_SMP)
 static struct lockdep_map cpuhp_state_up_map =
 	STATIC_LOCKDEP_MAP_INIT("cpuhp_state-up", &cpuhp_state_up_map);
@@ -433,7 +436,7 @@ static inline bool cpu_smt_allowed(unsigned int cpu)
 	 * CPU. Otherwise, a broadacasted MCE observing CR4.MCE=0b on any
 	 * core will shutdown the machine.
 	 */
-	return !per_cpu(cpuhp_state, cpu).booted_once;
+	return !cpumask_test_cpu(cpu, &cpus_booted_once_mask);
 }
 #else
 static inline bool cpu_smt_allowed(unsigned int cpu) { return true; }
@@ -1066,7 +1069,7 @@ void notify_cpu_starting(unsigned int cpu)
 	int ret;
 
 	rcu_cpu_starting(cpu);	/* Enables RCU usage on this CPU. */
-	st->booted_once = true;
+	cpumask_set_cpu(cpu, &cpus_booted_once_mask);
 	while (st->state < target) {
 		st->state++;
 		ret = cpuhp_invoke_callback(cpu, st->state, true, NULL, NULL);
@@ -2295,6 +2298,9 @@ EXPORT_SYMBOL(__cpu_present_mask);
 struct cpumask __cpu_active_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_active_mask);
 
+atomic_t __num_online_cpus __read_mostly;
+EXPORT_SYMBOL(__num_online_cpus);
+
 void init_cpu_present(const struct cpumask *src)
 {
 	cpumask_copy(&__cpu_present_mask, src);
@@ -2310,6 +2316,27 @@ void init_cpu_online(const struct cpumask *src)
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
@@ -2334,7 +2361,7 @@ void __init boot_cpu_init(void)
 void __init boot_cpu_hotplug_init(void)
 {
 #ifdef CONFIG_SMP
-	this_cpu_write(cpuhp_state.booted_once, true);
+	cpumask_set_cpu(smp_processor_id(), &cpus_booted_once_mask);
 #endif
 	this_cpu_write(cpuhp_state.state, CPUHP_ONLINE);
 }
diff --git a/lib/bitmap.c b/lib/bitmap.c
index bbe2589e8497..f9e834841e94 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -59,6 +59,26 @@ int __bitmap_equal(const unsigned long *bitmap1,
 }
 EXPORT_SYMBOL(__bitmap_equal);
 
+bool __bitmap_or_equal(const unsigned long *bitmap1,
+		       const unsigned long *bitmap2,
+		       const unsigned long *bitmap3,
+		       unsigned int bits)
+{
+	unsigned int k, lim = bits / BITS_PER_LONG;
+	unsigned long tmp;
+
+	for (k = 0; k < lim; ++k) {
+		if ((bitmap1[k] | bitmap2[k]) != bitmap3[k])
+			return false;
+	}
+
+	if (!(bits % BITS_PER_LONG))
+		return true;
+
+	tmp = (bitmap1[k] | bitmap2[k]) ^ bitmap3[k];
+	return (tmp & BITMAP_LAST_WORD_MASK(bits)) == 0;
+}
+
 void __bitmap_complement(unsigned long *dst, const unsigned long *src, unsigned int bits)
 {
 	unsigned int k, lim = BITS_TO_LONGS(bits);


