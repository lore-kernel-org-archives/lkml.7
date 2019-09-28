Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D63C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 22:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F612081B
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 22:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbfI1WYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 18:24:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49227 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbfI1WYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 18:24:47 -0400
Received: from pd9ef19d4.dip0.t-ipconnect.de ([217.239.25.212] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iEL8q-0004Lq-Tp; Sun, 29 Sep 2019 00:24:41 +0200
Date:   Sun, 29 Sep 2019 00:24:28 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Nicholas Mc Guire <hofrat@opentech.at>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: x86/random: Speculation to the rescue
Message-ID: <alpine.DEB.2.21.1909290010500.2636@nanos.tec.linutronix.de>
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

Nicholas presented the idea to (ab)use speculative execution for random
number generation years ago at the Real-Time Linux Workshop:

   https://static.lwn.net/images/conf/rtlws11/random-hardware.pdf

The idea is to use the non-constant execution time of loops on speculative
CPUs. The trick is to "time" the execution with rdtsc() and having enough
other instructions within the loop which make the uops scheduling
non-deterministic.

A trivial loop:

	for (i = 0; i < nbits; i++) {
		t = rdtsc();
		if (t & 0x01ULL)
			d |= (1ULL << i);
	}

does not provide enough entropy, but adding a pointless construct into the
loop makes it work:

	for (i = 0; i < nbits; i++) {
		t = __sw_hweight64(rdtsc() + rdtsc();
		if (t & 0x01ULL)
			d |= (1ULL << i);
	}

The interesting part is that rdtsc() can be speculated and the software
variant of hweight64() is adding enough 'useless' instructions to make the
uops scheduling and therefore the execution time random enough so that bit
zero of the result yields useful entropy.

To verify that this is true, there is a debugfs interface which provides
two files:

    /sys/kernel/debug/x86/rnd_fill
    /sys/kernel/debug/x86/rnd_data

Writing anything into 'rnd_fill' triggers the entropy collection via the
above algorithm and stores 64bit in one go in a data array after running
the 64bit value through a lame folding algorithm (Fibonacci LFSR).

When the write returns (which takes less than 10ms), the buffer is filled
with 4096 64bit entries, i.e. 262144 bits. The resulting data was read out
from rnd_data and tested against dieharder and the test01 Rabbit suite.

Most runs pass all tests, but both test suites find occasionally a few
tests which they considers weak, but the weak points are not the same on
the failing runs. The number of weak findings depends on the
microarchitecture, older CPUs expose it more than newer ones, which is not
suprising as the speculation gets more crazy on newer generations.

As the folding algorithm is lazy and primitive, it's not necessarily a
proof that the approach is wrong.  Feeding the entropy into the proper
kernel random generator should make that go away. Aside of that as the
'weak' points are randomly moving around there is no real way to attack
them in my opinion (but I might be wrong as usual).

What's interesting is that even with the trivial 64bit folding the result
is surprisingly good. That means that the speculative execution provides
usable entropy.

A visual comparison of 262144 bits retrieved from /dev/random and from the
rng_data file is here:

  https://tglx.de/~tglx/random/index.html

The tests were successfully run on various generations of Intel and AMD
hardware, but of course that needs way more investigation than a few runs
on a few machines.

As this depends on the microarchitecure and the pipeline depth this needs
at least some basic runtime verification mechanism before utilizing this.

But contrary to the last two years experience, speculation seems to have
it's useful sides as well :)

Suggested-by: Nicholas Mc Guire <hofrat@opentech.at>
Not-Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/processor.h |    2 
 arch/x86/kernel/cpu/common.c     |    4 +
 arch/x86/kernel/tsc.c            |   95 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -988,4 +988,6 @@ enum mds_mitigations {
 	MDS_MITIGATION_VMWERV,
 };
 
+extern bool cpu_has_speculation;
+
 #endif /* _ASM_X86_PROCESSOR_H */
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -77,6 +77,9 @@ EXPORT_SYMBOL(smp_num_siblings);
 /* Last level cache ID of each logical CPU */
 DEFINE_PER_CPU_READ_MOSTLY(u16, cpu_llc_id) = BAD_APICID;
 
+/* Indicator that the CPU is speculating */
+bool cpu_has_speculation __ro_after_init;
+
 /* correctly size the local cpu masks */
 void __init setup_cpu_local_masks(void)
 {
@@ -1099,6 +1102,7 @@ static void __init cpu_set_bug_bits(stru
 	if (cpu_matches(NO_SPECULATION))
 		return;
 
+	cpu_has_speculation = true;
 	setup_force_cpu_bug(X86_BUG_SPECTRE_V1);
 	setup_force_cpu_bug(X86_BUG_SPECTRE_V2);
 
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -14,6 +14,7 @@
 #include <linux/percpu.h>
 #include <linux/timex.h>
 #include <linux/static_key.h>
+#include <linux/debugfs.h>
 
 #include <asm/hpet.h>
 #include <asm/timer.h>
@@ -1531,3 +1532,97 @@ unsigned long calibrate_delay_is_known(v
 	return 0;
 }
 #endif
+
+unsigned int arch_get_speculative_entropy(u64 *buf, unsigned int nentries)
+{
+	unsigned int n, i;
+
+	if (!boot_cpu_has(X86_FEATURE_TSC) || !cpu_has_speculation)
+		return 0;
+
+	for (n = 0; n < nentries; n++) {
+		u64 d = 0;
+
+		/*
+		 * The loop below does not execute in constant time on
+		 * speculative CPUs. The trick is to do useless operations
+		 * between the TSC reads, i.e. calling __sw_hweight64().
+		 * This makes uops scheduling sufficiently random resulting
+		 * in useable entropy.
+		 */
+		for (i = 0; i < 64; i++) {
+			u64 t = rdtsc() + __sw_hweight64(rdtsc());
+
+			if (t & 0x01ULL)
+				d |= (1ULL << i);
+		}
+		buf[n] = d;
+	}
+	return nentries;
+}
+
+#define BUFSIZE 4096
+static u64 rng_array[4096];
+
+static struct debugfs_blob_wrapper rng_blob = {
+	.data = rng_array,
+	.size = sizeof(rng_array),
+};
+
+static u64 fold(u64 d)
+{
+	unsigned int i;
+	u64 res = d;
+
+	/*
+	 * Lazy and trivial folding just for testing purposes.
+	 *
+	 * Fibonacci LFSR with the primitive polynomial:
+	 * x^64 + x^61 + x^56 + x^31 + x^28 + x^23 + 1
+	 */
+	for (i = 1; i < 64; i++) {
+		u64 tmp = d << 63;
+
+		tmp = tmp >> 63;
+
+		tmp ^= ((res >> 63) & 1);
+		tmp ^= ((res >> 60) & 1);
+		tmp ^= ((res >> 55) & 1);
+		tmp ^= ((res >> 30) & 1);
+		tmp ^= ((res >> 27) & 1);
+		tmp ^= ((res >> 22) & 1);
+		res <<= 1;
+		res ^= tmp;
+	}
+	return res;
+}
+
+static ssize_t rngfill_write(struct file *file, const char __user *user_buf,
+			     size_t count, loff_t *ppos)
+{
+	unsigned int n;
+	u64 d;
+
+	for (n = 0; n < BUFSIZE; n++) {
+		if (!arch_get_speculative_entropy(&d, 1))
+			return -ENODEV;
+		rng_array[n] = fold(d);
+	}
+	return count;
+}
+
+static const struct file_operations fops_rngfill = {
+	.write = rngfill_write,
+	.llseek = default_llseek,
+};
+
+static int __init rng_debug_init(void)
+{
+	debugfs_create_file("rng_fill", S_IWUSR,
+			    arch_debugfs_dir, NULL, &fops_rngfill);
+
+	debugfs_create_blob("rng_data", 0444, arch_debugfs_dir, &rng_blob);
+
+	return 0;
+}
+late_initcall(rng_debug_init);
