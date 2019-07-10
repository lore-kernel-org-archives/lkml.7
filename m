Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B69DC74A21
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AEC72064A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mengyan1223.wang header.i=@mengyan1223.wang header.b="u7aob8J5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfGJP6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:58:17 -0400
Received: from mengyan1223.wang ([89.208.246.23]:38962 "EHLO mengyan1223.wang"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727463AbfGJP6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:58:17 -0400
Received: from [IPv6:2408:8270:a58:d980:697b:cb16:ae5f:f5aa] (unknown [IPv6:2408:8270:a58:d980:697b:cb16:ae5f:f5aa])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: xry111@mengyan1223.wang)
        by mengyan1223.wang (Postfix) with ESMTPSA id EDE5C65B60;
        Wed, 10 Jul 2019 11:58:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mengyan1223.wang;
        s=mail; t=1562774296;
        bh=5NzwbBGqtPoTMfsv3+OVP8wP42KNVmOMVqEYZiOBrx4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=u7aob8J5jToXtx8TioDj1zWKqG8nx0hwBHgJrF3J7+BreMBBph9klc+3T0UKEKFbA
         LLb5/Z/9NDEx0J/nN/9lAv8VZIlNGLbo/gJB37UZdGfdI+4WgYZYYg5shLP676Dy/i
         byIa88C2MxAATFJMnY4oFYTzjiiaboJNRSQTW8qvOC0ZUwgjw4oamotc9Jg0asOFbJ
         FzHvf6Z3AfdxV0MtENWIQeTukJ6TYadBUfRiQ5ROkzofa79h2nOkBVTaPx+1w+JPna
         UQBkvwa4o8ZqZ58GSNKlDj7Wk8kqmqOfvCQhF2FiN7fjKi+EBVD2gHIBpDomgCuHEw
         epfhnTIyoBYhQ==
Message-ID: <a822cf447949582e2a11b7899f22b11da02f0ece.camel@mengyan1223.wang>
Subject: Re: [GIT PULL] x86/topology changes for v5.3
From:   Xi Ruoyao <xry111@mengyan1223.wang>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Kosina <jikos@kernel.org>, Kees Cook <keescook@chromium.org>,
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
        xry111@mengyan1223.wang
Date:   Wed, 10 Jul 2019 23:58:03 +0800
In-Reply-To: <alpine.DEB.2.21.1907101709340.1758@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1907100039540.1758@nanos.tec.linutronix.de>
         <alpine.DEB.2.21.1907100115220.1758@nanos.tec.linutronix.de>
         <201907091727.91CC6C72D8@keescook>
         <1ad2de95e694a29909801d022fe2d556df9a4bd5.camel@mengyan1223.wang>
         <cb6d381ed7cd0bf732ae9d8f30c806b849b0f94b.camel@mengyan1223.wang>
         <alpine.DEB.2.21.1907101404570.1758@nanos.tec.linutronix.de>
         <nycvar.YFH.7.76.1907101425290.5899@cbobk.fhfr.pm>
         <768463eb26a2feb0fcc374fd7f9cc28b96976917.camel@mengyan1223.wang>
         <20190710134433.GN3402@hirez.programming.kicks-ass.net>
         <nycvar.YFH.7.76.1907101621050.5899@cbobk.fhfr.pm>
         <20190710142653.GJ3419@hirez.programming.kicks-ass.net>
         <alpine.DEB.2.21.1907101709340.1758@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-10 17:13 +0200, Thomas Gleixner wrote:
> Something like the below. Builds and boots, must be perfect.
> 
> Thanks,
> 
> 	tglx

Tested-by: Xi Ruoyao <xry111@mengyan1223.wang>

> 8<----------------
> 
>  arch/x86/include/asm/processor.h     |    1 
>  arch/x86/include/asm/special_insns.h |   41 -------------------
>  arch/x86/kernel/cpu/common.c         |   72 +++++++++++++++++++++++++++----
> ----
>  arch/x86/kernel/smpboot.c            |   14 ------
>  arch/x86/xen/smp_pv.c                |    1 
>  5 files changed, 61 insertions(+), 68 deletions(-)
> 
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -741,6 +741,7 @@ extern void load_direct_gdt(int);
>  extern void load_fixmap_gdt(int);
>  extern void load_percpu_segment(int);
>  extern void cpu_init(void);
> +extern void cr4_init(void);
>  
>  static inline unsigned long get_debugctlmsr(void)
>  {
> --- a/arch/x86/include/asm/special_insns.h
> +++ b/arch/x86/include/asm/special_insns.h
> @@ -18,9 +18,7 @@
>   */
>  extern unsigned long __force_order;
>  
> -/* Starts false and gets enabled once CPU feature detection is done. */
> -DECLARE_STATIC_KEY_FALSE(cr_pinning);
> -extern unsigned long cr4_pinned_bits;
> +void native_write_cr0(unsigned long val);
>  
>  static inline unsigned long native_read_cr0(void)
>  {
> @@ -29,24 +27,6 @@ static inline unsigned long native_read_
>  	return val;
>  }
>  
> -static inline void native_write_cr0(unsigned long val)
> -{
> -	unsigned long bits_missing = 0;
> -
> -set_register:
> -	asm volatile("mov %0,%%cr0": "+r" (val), "+m" (__force_order));
> -
> -	if (static_branch_likely(&cr_pinning)) {
> -		if (unlikely((val & X86_CR0_WP) != X86_CR0_WP)) {
> -			bits_missing = X86_CR0_WP;
> -			val |= bits_missing;
> -			goto set_register;
> -		}
> -		/* Warn after we've set the missing bits. */
> -		WARN_ONCE(bits_missing, "CR0 WP bit went missing!?\n");
> -	}
> -}
> -
>  static inline unsigned long native_read_cr2(void)
>  {
>  	unsigned long val;
> @@ -91,24 +71,7 @@ static inline unsigned long native_read_
>  	return val;
>  }
>  
> -static inline void native_write_cr4(unsigned long val)
> -{
> -	unsigned long bits_missing = 0;
> -
> -set_register:
> -	asm volatile("mov %0,%%cr4": "+r" (val), "+m" (cr4_pinned_bits));
> -
> -	if (static_branch_likely(&cr_pinning)) {
> -		if (unlikely((val & cr4_pinned_bits) != cr4_pinned_bits)) {
> -			bits_missing = ~val & cr4_pinned_bits;
> -			val |= bits_missing;
> -			goto set_register;
> -		}
> -		/* Warn after we've set the missing bits. */
> -		WARN_ONCE(bits_missing, "CR4 bits went missing: %lx!?\n",
> -			  bits_missing);
> -	}
> -}
> +void native_write_cr4(unsigned long val);
>  
>  #ifdef CONFIG_X86_64
>  static inline unsigned long native_read_cr8(void)
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -366,10 +366,62 @@ static __always_inline void setup_umip(s
>  	cr4_clear_bits(X86_CR4_UMIP);
>  }
>  
> -DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
> -EXPORT_SYMBOL(cr_pinning);
> -unsigned long cr4_pinned_bits __ro_after_init;
> -EXPORT_SYMBOL(cr4_pinned_bits);
> +static DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
> +static unsigned long cr4_pinned_bits __ro_after_init;
> +
> +void native_write_cr0(unsigned long val)
> +{
> +	unsigned long bits_missing = 0;
> +
> +set_register:
> +	asm volatile("mov %0,%%cr0": "+r" (val), "+m" (__force_order));
> +
> +	if (static_branch_likely(&cr_pinning)) {
> +		if (unlikely((val & X86_CR0_WP) != X86_CR0_WP)) {
> +			bits_missing = X86_CR0_WP;
> +			val |= bits_missing;
> +			goto set_register;
> +		}
> +		/* Warn after we've set the missing bits. */
> +		WARN_ONCE(bits_missing, "CR0 WP bit went missing!?\n");
> +	}
> +}
> +EXPORT_SYMBOL(native_write_cr0);
> +
> +void native_write_cr4(unsigned long val)
> +{
> +	unsigned long bits_missing = 0;
> +
> +set_register:
> +	asm volatile("mov %0,%%cr4": "+r" (val), "+m" (cr4_pinned_bits));
> +
> +	if (static_branch_likely(&cr_pinning)) {
> +		if (unlikely((val & cr4_pinned_bits) != cr4_pinned_bits)) {
> +			bits_missing = ~val & cr4_pinned_bits;
> +			val |= bits_missing;
> +			goto set_register;
> +		}
> +		/* Warn after we've set the missing bits. */
> +		WARN_ONCE(bits_missing, "CR4 bits went missing: %lx!?\n",
> +			  bits_missing);
> +	}
> +}
> +EXPORT_SYMBOL(native_write_cr4);
> +
> +void cr4_init(void)
> +{
> +	unsigned long cr4 = __read_cr4();
> +
> +	if (boot_cpu_has(X86_FEATURE_PCID))
> +		cr4 |= X86_CR4_PCIDE;
> +	if (static_branch_likely(&cr_pinning))
> +		cr4 |= cr4_pinned_bits;
> +
> +	__write_cr4(cr4);
> +
> +	/* Initialize cr4 shadow for this CPU. */
> +	this_cpu_write(cpu_tlbstate.cr4, cr4);
> +}
>  
>  /*
>   * Once CPU feature detection is finished (and boot params have been
> @@ -1723,12 +1775,6 @@ void cpu_init(void)
>  
>  	wait_for_master_cpu(cpu);
>  
> -	/*
> -	 * Initialize the CR4 shadow before doing anything that could
> -	 * try to read it.
> -	 */
> -	cr4_init_shadow();
> -
>  	if (cpu)
>  		load_ucode_ap();
>  
> @@ -1823,12 +1869,6 @@ void cpu_init(void)
>  
>  	wait_for_master_cpu(cpu);
>  
> -	/*
> -	 * Initialize the CR4 shadow before doing anything that could
> -	 * try to read it.
> -	 */
> -	cr4_init_shadow();
> -
>  	show_ucode_info_early();
>  
>  	pr_info("Initializing CPU#%d\n", cpu);
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -210,28 +210,16 @@ static int enable_start_cpu0;
>   */
>  static void notrace start_secondary(void *unused)
>  {
> -	unsigned long cr4 = __read_cr4();
> -
>  	/*
>  	 * Don't put *anything* except direct CPU state initialization
>  	 * before cpu_init(), SMP booting is too fragile that we want to
>  	 * limit the things done here to the most necessary things.
>  	 */
> -	if (boot_cpu_has(X86_FEATURE_PCID))
> -		cr4 |= X86_CR4_PCIDE;
> -	if (static_branch_likely(&cr_pinning))
> -		cr4 |= cr4_pinned_bits;
> -
> -	__write_cr4(cr4);
> +	cr4_init();
>  
>  #ifdef CONFIG_X86_32
>  	/* switch away from the initial page table */
>  	load_cr3(swapper_pg_dir);
> -	/*
> -	 * Initialize the CR4 shadow before doing anything that could
> -	 * try to read it.
> -	 */
> -	cr4_init_shadow();
>  	__flush_tlb_all();
>  #endif
>  	load_current_idt();
> --- a/arch/x86/xen/smp_pv.c
> +++ b/arch/x86/xen/smp_pv.c
> @@ -58,6 +58,7 @@ static void cpu_bringup(void)
>  {
>  	int cpu;
>  
> +	cr4_init();
>  	cpu_init();
>  	touch_softlockup_watchdog();
>  	preempt_disable();
-- 
Xi Ruoyao <xry111@mengyan1223.wang>
School of Aerospace Science and Technology, Xidian University

