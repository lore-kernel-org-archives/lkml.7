Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52476C74A35
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 20:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1937A2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 20:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cdsIMIze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfGJUT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 16:19:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41907 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbfGJUT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 16:19:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6AKJA1k2574137
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 10 Jul 2019 13:19:10 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6AKJA1k2574137
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562789951;
        bh=YfzqZzDBDKoKQ/r74H08P1FgxD7OY3xdUhs3xQ5xdEI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=cdsIMIze/rzleDkLQOPS/oWKf8a9iN+qlj6FbDL0X4jsj3BvDd1T9bXMT+EHtELdC
         +cCQ2kqzF7o2TGHHfB6w9z2nBE9Vfv34IvnhlEkrbaTWaU+llKWDrf9AuKSJycOmLp
         mglsoAIIv75nFlJzIumXw6aB1Y2m2GrOVMqhPlatEiW6CQsvWk7iiT3bm4Y2jQsdQ/
         k9/+fw98lt7eRw6YJFj79y5j8H2tmXbhpVQPgHoQSQ4VazTmHFNh+wutoxp8uHKVIu
         Vm14s+3FHUS6fUB9w3CWlYxMc8o3ivr+hsYB7bx0nJUbrR1EZz+rBj5OUJyWNiNzGp
         NzvfWkmsMigLA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6AKJ9TL2574133;
        Wed, 10 Jul 2019 13:19:09 -0700
Date:   Wed, 10 Jul 2019 13:19:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-7652ac92018536eb807b6c2130100c85f1ba7e3b@git.kernel.org>
Cc:     hpa@zytor.com, keescook@chromium.org, mingo@kernel.org,
        tglx@linutronix.de, xry111@mengyan1223.wang,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org
Reply-To: hpa@zytor.com, mingo@kernel.org, keescook@chromium.org,
          tglx@linutronix.de, xry111@mengyan1223.wang,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          torvalds@linux-foundation.org
In-Reply-To: <alpine.DEB.2.21.1907102140340.1758@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1907102140340.1758@nanos.tec.linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/asm: Move native_write_cr0/4() out of line
Git-Commit-ID: 7652ac92018536eb807b6c2130100c85f1ba7e3b
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

Commit-ID:  7652ac92018536eb807b6c2130100c85f1ba7e3b
Gitweb:     https://git.kernel.org/tip/7652ac92018536eb807b6c2130100c85f1ba7e3b
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 10 Jul 2019 21:42:46 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 10 Jul 2019 22:15:05 +0200

x86/asm: Move native_write_cr0/4() out of line

The pinning of sensitive CR0 and CR4 bits caused a boot crash when loading
the kvm_intel module on a kernel compiled with CONFIG_PARAVIRT=n.

The reason is that the static key which controls the pinning is marked RO
after init. The kvm_intel module contains a CR4 write which requires to
update the static key entry list. That obviously does not work when the key
is in a RO section.

With CONFIG_PARAVIRT enabled this does not happen because the CR4 write
uses the paravirt indirection and the actual write function is built in.

As the key is intended to be immutable after init, move
native_write_cr0/4() out of line.

While at it consolidate the update of the cr4 shadow variable and store the
value right away when the pinning is initialized on a booting CPU. No point
in reading it back 20 instructions later. This allows to confine the static
key and the pinning variable to cpu/common and allows to mark them static.

Fixes: 8dbec27a242c ("x86/asm: Pin sensitive CR0 bits")
Fixes: 873d50d58f67 ("x86/asm: Pin sensitive CR4 bits")
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Reported-by: Xi Ruoyao <xry111@mengyan1223.wang>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Xi Ruoyao <xry111@mengyan1223.wang>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1907102140340.1758@nanos.tec.linutronix.de

---
 arch/x86/include/asm/processor.h     |  1 +
 arch/x86/include/asm/special_insns.h | 41 +-------------------
 arch/x86/kernel/cpu/common.c         | 72 ++++++++++++++++++++++++++++--------
 arch/x86/kernel/smpboot.c            | 14 +------
 arch/x86/xen/smp_pv.c                |  1 +
 5 files changed, 61 insertions(+), 68 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 3eab6ece52b4..6e0a3b43d027 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -741,6 +741,7 @@ extern void load_direct_gdt(int);
 extern void load_fixmap_gdt(int);
 extern void load_percpu_segment(int);
 extern void cpu_init(void);
+extern void cr4_init(void);
 
 static inline unsigned long get_debugctlmsr(void)
 {
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index b2e84d113f2a..219be88a59d2 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -18,9 +18,7 @@
  */
 extern unsigned long __force_order;
 
-/* Starts false and gets enabled once CPU feature detection is done. */
-DECLARE_STATIC_KEY_FALSE(cr_pinning);
-extern unsigned long cr4_pinned_bits;
+void native_write_cr0(unsigned long val);
 
 static inline unsigned long native_read_cr0(void)
 {
@@ -29,24 +27,6 @@ static inline unsigned long native_read_cr0(void)
 	return val;
 }
 
-static inline void native_write_cr0(unsigned long val)
-{
-	unsigned long bits_missing = 0;
-
-set_register:
-	asm volatile("mov %0,%%cr0": "+r" (val), "+m" (__force_order));
-
-	if (static_branch_likely(&cr_pinning)) {
-		if (unlikely((val & X86_CR0_WP) != X86_CR0_WP)) {
-			bits_missing = X86_CR0_WP;
-			val |= bits_missing;
-			goto set_register;
-		}
-		/* Warn after we've set the missing bits. */
-		WARN_ONCE(bits_missing, "CR0 WP bit went missing!?\n");
-	}
-}
-
 static inline unsigned long native_read_cr2(void)
 {
 	unsigned long val;
@@ -91,24 +71,7 @@ static inline unsigned long native_read_cr4(void)
 	return val;
 }
 
-static inline void native_write_cr4(unsigned long val)
-{
-	unsigned long bits_missing = 0;
-
-set_register:
-	asm volatile("mov %0,%%cr4": "+r" (val), "+m" (cr4_pinned_bits));
-
-	if (static_branch_likely(&cr_pinning)) {
-		if (unlikely((val & cr4_pinned_bits) != cr4_pinned_bits)) {
-			bits_missing = ~val & cr4_pinned_bits;
-			val |= bits_missing;
-			goto set_register;
-		}
-		/* Warn after we've set the missing bits. */
-		WARN_ONCE(bits_missing, "CR4 bits went missing: %lx!?\n",
-			  bits_missing);
-	}
-}
+void native_write_cr4(unsigned long val);
 
 #ifdef CONFIG_X86_64
 static inline unsigned long native_read_cr8(void)
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 309b6b9b49d4..11472178e17f 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -366,10 +366,62 @@ out:
 	cr4_clear_bits(X86_CR4_UMIP);
 }
 
-DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
-EXPORT_SYMBOL(cr_pinning);
-unsigned long cr4_pinned_bits __ro_after_init;
-EXPORT_SYMBOL(cr4_pinned_bits);
+static DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
+static unsigned long cr4_pinned_bits __ro_after_init;
+
+void native_write_cr0(unsigned long val)
+{
+	unsigned long bits_missing = 0;
+
+set_register:
+	asm volatile("mov %0,%%cr0": "+r" (val), "+m" (__force_order));
+
+	if (static_branch_likely(&cr_pinning)) {
+		if (unlikely((val & X86_CR0_WP) != X86_CR0_WP)) {
+			bits_missing = X86_CR0_WP;
+			val |= bits_missing;
+			goto set_register;
+		}
+		/* Warn after we've set the missing bits. */
+		WARN_ONCE(bits_missing, "CR0 WP bit went missing!?\n");
+	}
+}
+EXPORT_SYMBOL(native_write_cr0);
+
+void native_write_cr4(unsigned long val)
+{
+	unsigned long bits_missing = 0;
+
+set_register:
+	asm volatile("mov %0,%%cr4": "+r" (val), "+m" (cr4_pinned_bits));
+
+	if (static_branch_likely(&cr_pinning)) {
+		if (unlikely((val & cr4_pinned_bits) != cr4_pinned_bits)) {
+			bits_missing = ~val & cr4_pinned_bits;
+			val |= bits_missing;
+			goto set_register;
+		}
+		/* Warn after we've set the missing bits. */
+		WARN_ONCE(bits_missing, "CR4 bits went missing: %lx!?\n",
+			  bits_missing);
+	}
+}
+EXPORT_SYMBOL(native_write_cr4);
+
+void cr4_init(void)
+{
+	unsigned long cr4 = __read_cr4();
+
+	if (boot_cpu_has(X86_FEATURE_PCID))
+		cr4 |= X86_CR4_PCIDE;
+	if (static_branch_likely(&cr_pinning))
+		cr4 |= cr4_pinned_bits;
+
+	__write_cr4(cr4);
+
+	/* Initialize cr4 shadow for this CPU. */
+	this_cpu_write(cpu_tlbstate.cr4, cr4);
+}
 
 /*
  * Once CPU feature detection is finished (and boot params have been
@@ -1723,12 +1775,6 @@ void cpu_init(void)
 
 	wait_for_master_cpu(cpu);
 
-	/*
-	 * Initialize the CR4 shadow before doing anything that could
-	 * try to read it.
-	 */
-	cr4_init_shadow();
-
 	if (cpu)
 		load_ucode_ap();
 
@@ -1823,12 +1869,6 @@ void cpu_init(void)
 
 	wait_for_master_cpu(cpu);
 
-	/*
-	 * Initialize the CR4 shadow before doing anything that could
-	 * try to read it.
-	 */
-	cr4_init_shadow();
-
 	show_ucode_info_early();
 
 	pr_info("Initializing CPU#%d\n", cpu);
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index f78801114ee1..259d1d2be076 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -210,28 +210,16 @@ static int enable_start_cpu0;
  */
 static void notrace start_secondary(void *unused)
 {
-	unsigned long cr4 = __read_cr4();
-
 	/*
 	 * Don't put *anything* except direct CPU state initialization
 	 * before cpu_init(), SMP booting is too fragile that we want to
 	 * limit the things done here to the most necessary things.
 	 */
-	if (boot_cpu_has(X86_FEATURE_PCID))
-		cr4 |= X86_CR4_PCIDE;
-	if (static_branch_likely(&cr_pinning))
-		cr4 |= cr4_pinned_bits;
-
-	__write_cr4(cr4);
+	cr4_init();
 
 #ifdef CONFIG_X86_32
 	/* switch away from the initial page table */
 	load_cr3(swapper_pg_dir);
-	/*
-	 * Initialize the CR4 shadow before doing anything that could
-	 * try to read it.
-	 */
-	cr4_init_shadow();
 	__flush_tlb_all();
 #endif
 	load_current_idt();
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 77d81c1a63e9..802ee5bba66c 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -58,6 +58,7 @@ static void cpu_bringup(void)
 {
 	int cpu;
 
+	cr4_init();
 	cpu_init();
 	touch_softlockup_watchdog();
 	preempt_disable();
