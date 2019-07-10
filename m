Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8ECC74A21
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41F12064B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbfGJPNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:13:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47975 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbfGJPNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:13:38 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hlEHd-0005JO-8B; Wed, 10 Jul 2019 17:13:25 +0200
Date:   Wed, 10 Jul 2019 17:13:24 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Jiri Kosina <jikos@kernel.org>,
        Xi Ruoyao <xry111@mengyan1223.wang>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Nadav Amit <namit@vmware.com>, Juergen Gross <jgross@suse.com>
Subject: Re: [GIT PULL] x86/topology changes for v5.3
In-Reply-To: <20190710142653.GJ3419@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1907101709340.1758@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1907100039540.1758@nanos.tec.linutronix.de> <alpine.DEB.2.21.1907100115220.1758@nanos.tec.linutronix.de> <201907091727.91CC6C72D8@keescook> <1ad2de95e694a29909801d022fe2d556df9a4bd5.camel@mengyan1223.wang>
 <cb6d381ed7cd0bf732ae9d8f30c806b849b0f94b.camel@mengyan1223.wang> <alpine.DEB.2.21.1907101404570.1758@nanos.tec.linutronix.de> <nycvar.YFH.7.76.1907101425290.5899@cbobk.fhfr.pm> <768463eb26a2feb0fcc374fd7f9cc28b96976917.camel@mengyan1223.wang>
 <20190710134433.GN3402@hirez.programming.kicks-ass.net> <nycvar.YFH.7.76.1907101621050.5899@cbobk.fhfr.pm> <20190710142653.GJ3419@hirez.programming.kicks-ass.net>
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

On Wed, 10 Jul 2019, Peter Zijlstra wrote:
> On Wed, Jul 10, 2019 at 04:22:51PM +0200, Jiri Kosina wrote:
> > On Wed, 10 Jul 2019, Peter Zijlstra wrote:
> > 
> > > If we mark the key as RO after init, and then try and modify the key to
> > > link module usage sites, things might go bang as described.
> > > 
> > > Thanks!
> > > 
> > > 
> > > diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> > > index 27d7864e7252..5bf7a8354da2 100644
> > > --- a/arch/x86/kernel/cpu/common.c
> > > +++ b/arch/x86/kernel/cpu/common.c
> > > @@ -366,7 +366,7 @@ static __always_inline void setup_umip(struct cpuinfo_x86 *c)
> > >  	cr4_clear_bits(X86_CR4_UMIP);
> > >  }
> > >  
> > > -DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
> > > +DEFINE_STATIC_KEY_FALSE(cr_pinning);
> > 
> > Good catch, I guess that is going to fix it.
> > 
> > At the same time though, it sort of destroys the original intent of Kees' 
> > patch, right? The exploits will just have to call static_key_disable() 
> > prior to calling native_write_cr4() again, and the protection is gone.
> 
> This is fixable by moving native_write_cr*() out-of-line, such that they
> never end up in a module.

Something like the below. Builds and boots, must be perfect.

Thanks,

	tglx
	
8<----------------

 arch/x86/include/asm/processor.h     |    1 
 arch/x86/include/asm/special_insns.h |   41 -------------------
 arch/x86/kernel/cpu/common.c         |   72 +++++++++++++++++++++++++++--------
 arch/x86/kernel/smpboot.c            |   14 ------
 arch/x86/xen/smp_pv.c                |    1 
 5 files changed, 61 insertions(+), 68 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -741,6 +741,7 @@ extern void load_direct_gdt(int);
 extern void load_fixmap_gdt(int);
 extern void load_percpu_segment(int);
 extern void cpu_init(void);
+extern void cr4_init(void);
 
 static inline unsigned long get_debugctlmsr(void)
 {
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
@@ -29,24 +27,6 @@ static inline unsigned long native_read_
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
@@ -91,24 +71,7 @@ static inline unsigned long native_read_
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
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -366,10 +366,62 @@ static __always_inline void setup_umip(s
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
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -58,6 +58,7 @@ static void cpu_bringup(void)
 {
 	int cpu;
 
+	cr4_init();
 	cpu_init();
 	touch_softlockup_watchdog();
 	preempt_disable();
