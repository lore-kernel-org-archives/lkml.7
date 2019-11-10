Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D071C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 17:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697232085B
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 17:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573406770;
	bh=EnfiXp+UfaPrCon8GJjjP7SlqP4VXDKRYAQNuHL9dO4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=uCs3vDuyE+FAkhmZ+wSCDKdZTOWOVu4SOoVcpHcfFuIngw9zdLt+1+1koD4agOnDq
	 a0v0CxdcWPi4LKAM//iVcdD4v0ce9btVeDHx0AIb7niT1AMz7TB4HzSfhE/E4cICpG
	 AvRA8GjpbIDDqJYzps+4XYB+GGVvjkcIe28x/RUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKJR0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 12:26:09 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41288 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbfKJR0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 12:26:08 -0500
Received: by mail-pg1-f193.google.com with SMTP id h4so7677520pgv.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 09:26:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JGy9KePftdC8OdgEthZWpeAxiIIr5gQHOfv2YEZCZIs=;
        b=KNfW8JzaS0iDdMtTZ65K9D2wlmpcWAURiAKtBag0YnXHAU+o/Eoi1V0foFMXz4mSTJ
         gVXaoa/qhuqRVNvLj6UJDFh6SLXIIhQmRpcTGDd/oXlfUYXMK0/gwEbCpoOptmneETIO
         r1m2ERUe74ZOzlniDTH02syBBkvdD4aOUcoOOtLcbsHj/AuQtnKn5kNnMu1e3LOS7bZn
         CZ1zn43O0iFu/eJ3hxSiMuFHHss6i27qIiG99hycMvsR+3BEjk2aAR1lmEvUh/zW+sDL
         W65oDM0l6o4LRYyaM2+Isr2Y8rqnUbZz2nKk//aqydb7mmvgRY34vmUIz2nSyeIENO66
         Q29g==
X-Gm-Message-State: APjAAAVjW7c5wFPhp/AoHTGi7u5plvP7NJJWjmVHGXlYppJHrlV0FZfa
        KUP68rS35UTkFypQ8PaAL0j2fQ==
X-Google-Smtp-Source: APXvYqzYxvWKJbt4rDc9kOfPDLg/xPvy6k5lD6tt4yx9W5Y+QLhM4fdHg9VBoStweGvdT6Y59hQ8Lg==
X-Received: by 2002:a63:231b:: with SMTP id j27mr11866750pgj.106.1573406767914;
        Sun, 10 Nov 2019 09:26:07 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:3602:86ff:fef6:e86b? ([2601:646:c200:1ef2:3602:86ff:fef6:e86b])
        by smtp.googlemail.com with ESMTPSA id h8sm17870130pjp.1.2019.11.10.09.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2019 09:26:07 -0800 (PST)
Subject: Re: [patch 7/9] x86/iopl: Restrict iopl() permission scope
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20191106193459.581614484@linutronix.de>
 <20191106202806.425388355@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <a1afc4bb-c90e-db58-42f2-da91a50b1872@kernel.org>
Date:   Sun, 10 Nov 2019 09:26:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191106202806.425388355@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/19 11:35 AM, Thomas Gleixner wrote:
> The access to the full I/O port range can be also provided by the TSS I/O
> bitmap, but that would require to copy 8k of data on scheduling in the
> task. As shown with the sched out optimization TSS.io_bitmap_base can be
> used to switch the incoming task to a preallocated I/O bitmap which has all
> bits zero, i.e. allows access to all I/O ports.
> 
> Implementing this allows to provide an iopl() emulation mode which restricts
> the IOPL level 3 permissions to I/O port access but removes the STI/CLI
> permission which is coming with the hardware IOPL mechansim.
> 
> Provide a config option to switch IOPL to emulation mode, make it the
> default and while at it also provide an option to disable IOPL completely.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/Kconfig                 |   32 ++++++++++++++++
>  arch/x86/include/asm/processor.h |   24 +++++++++---
>  arch/x86/kernel/cpu/common.c     |    4 +-
>  arch/x86/kernel/ioport.c         |   75 ++++++++++++++++++++++++++++++---------
>  arch/x86/kernel/process.c        |   15 +++++--
>  5 files changed, 123 insertions(+), 27 deletions(-)
> 
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1254,6 +1254,38 @@ config X86_VSYSCALL_EMULATION
>  	 Disabling this option saves about 7K of kernel size and
>  	 possibly 4K of additional runtime pagetable memory.
>  
> +choice
> +	prompt "IOPL"
> +	default X86_IOPL_EMULATION
> +
> +config X86_IOPL_EMULATION
> +	bool "IOPL Emulation"
> +	---help---
> +	  Legacy IOPL support is an overbroad mechanism which allows user
> +	  space aside of accessing all 65536 I/O ports also to disable
> +	  interrupts. To gain this access the caller needs CAP_SYS_RAWIO
> +	  capabilities and permission from eventually active security
> +	  modules.
> +
> +	  The emulation restricts the functionality of the syscall to
> +	  only allowing the full range I/O port access, but prevents the
> +	  ability to disable interrupts from user space.
> +
> +config X86_IOPL_LEGACY
> +	bool "IOPL Legacy"
> +	---help---
> +	Allow the full IOPL permissions, i.e. user space access to all
> +	65536 I/O ports and also the ability to disable interrupts, which
> +	is overbroad and can result in system lockups.
> +
> +config X86_IOPL_NONE
> +	bool "IOPL None"
> +	---help---
> +	Disable the IOPL permission syscall. That's the safest option as
> +	no sane application should depend on this functionality.
> +
> +endchoice
> +
>  config TOSHIBA
>  	tristate "Toshiba Laptop support"
>  	depends on X86_32
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -331,8 +331,12 @@ struct x86_hw_tss {
>  #define IO_BITMAP_BYTES			(IO_BITMAP_BITS/8)
>  #define IO_BITMAP_LONGS			(IO_BITMAP_BYTES/sizeof(long))
>  
> -#define IO_BITMAP_OFFSET_VALID				\
> -	(offsetof(struct tss_struct, io_bitmap) -	\
> +#define IO_BITMAP_OFFSET_VALID_MAP			\
> +	(offsetof(struct tss_struct, io_bitmap_map) -	\
> +	 offsetof(struct tss_struct, x86_tss))
> +
> +#define IO_BITMAP_OFFSET_VALID_ALL			\
> +	(offsetof(struct tss_struct, io_bitmap_all) -	\
>  	 offsetof(struct tss_struct, x86_tss))
>  
>  /*
> @@ -343,7 +347,7 @@ struct x86_hw_tss {
>   * last valid byte
>   */
>  #define __KERNEL_TSS_LIMIT	\
> -	(IO_BITMAP_OFFSET_VALID + IO_BITMAP_BYTES + sizeof(unsigned long) - 1)
> +	(IO_BITMAP_OFFSET_VALID_ALL + IO_BITMAP_BYTES + sizeof(unsigned long) - 1)
>  
>  /* Base offset outside of TSS_LIMIT so unpriviledged IO causes #GP */
>  #define IO_BITMAP_OFFSET_INVALID	(__KERNEL_TSS_LIMIT + 1)
> @@ -379,7 +383,8 @@ struct tss_struct {
>  	 * byte beyond the end of the I/O permission bitmap. The extra byte
>  	 * must have all bits set and must be within the TSS limit.
>  	 */
> -	unsigned long		io_bitmap[IO_BITMAP_LONGS + 1];
> +	unsigned long		io_bitmap_map[IO_BITMAP_LONGS + 1];
> +	unsigned long		io_bitmap_all[IO_BITMAP_LONGS + 1];
>  } __aligned(PAGE_SIZE);
>  
>  DECLARE_PER_CPU_PAGE_ALIGNED(struct tss_struct, cpu_tss_rw);
> @@ -495,7 +500,6 @@ struct thread_struct {
>  #endif
>  	/* IO permissions: */
>  	unsigned long		*io_bitmap_ptr;
> -	unsigned long		iopl;
>  	/*
>  	 * The byte range in the I/O permission bitmap which contains zero
>  	 * bits.
> @@ -503,6 +507,13 @@ struct thread_struct {
>  	unsigned int		io_zerobits_start;
>  	unsigned int		io_zerobits_end;
>  
> +	/*
> +	 * IOPL. Priviledge level dependent I/O permission which includes
> +	 * user space CLI/STI when granted.
> +	 */
> +	unsigned long		iopl;
> +	unsigned long		iopl_emul;
> +
>  	mm_segment_t		addr_limit;
>  
>  	unsigned int		sig_on_uaccess_err:1;
> @@ -524,6 +535,9 @@ static inline void arch_thread_struct_wh
>  	*size = fpu_kernel_xstate_size;
>  }
>  
> +extern void tss_update_io_bitmap(struct tss_struct *tss,
> +				 struct thread_struct *thread);
> +
>  /*
>   * Thread-synchronous status.
>   *
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1866,7 +1866,9 @@ void cpu_init(void)
>  	tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_INVALID;
>  	tss->io_zerobits_start = IO_BITMAP_BYTES;
>  	tss->io_zerobits_end = 0;
> -	memset(tss->io_bitmap, 0xff, sizeof(tss->io_bitmap));
> +	memset(tss->io_bitmap_map, 0xff, sizeof(tss->io_bitmap_map));
> +	/* Invalidate the extra tail entry of the allow all I/O bitmap */
> +	tss->io_bitmap_all[IO_BITMAP_LONGS] = ~0UL;
>  	set_tss_desc(cpu, &get_cpu_entry_area(cpu)->tss.x86_tss);
>  
>  	load_TR_desc();
> --- a/arch/x86/kernel/ioport.c
> +++ b/arch/x86/kernel/ioport.c
> @@ -109,7 +109,7 @@ long ksys_ioperm(unsigned long from, uns
>  	}
>  
>  	/* Copy the changed range over to the TSS bitmap */
> -	dst = (char *)tss->io_bitmap;
> +	dst = (char *)tss->io_bitmap_map;
>  	src = (char *)bitmap;
>  	memcpy(dst + copy_start, src + copy_start, copy_len);
>  
> @@ -130,7 +130,7 @@ long ksys_ioperm(unsigned long from, uns
>  		 * is correct. It might have been wreckaged by a VMEXiT.
>  		 */
>  		set_thread_flag(TIF_IO_BITMAP);
> -		tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_VALID;
> +		tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_VALID_MAP;
>  		refresh_tss_limit();
>  	}
>  
> @@ -184,36 +184,77 @@ SYSCALL_DEFINE3(ioperm, unsigned long, f
>   */
>  SYSCALL_DEFINE1(iopl, unsigned int, level)
>  {
> -	struct pt_regs *regs = current_pt_regs();
>  	struct thread_struct *t = &current->thread;
> +	struct pt_regs *regs = current_pt_regs();
> +	unsigned int old;
>  
>  	/*
>  	 * Careful: the IOPL bits in regs->flags are undefined under Xen PV
>  	 * and changing them has no effect.
>  	 */
> -	unsigned int old = t->iopl >> X86_EFLAGS_IOPL_BIT;
> +	if (IS_ENABLED(CONFIG_X86_IOPL_NONE))
> +		return -ENOSYS;
>  
>  	if (level > 3)
>  		return -EINVAL;
> +
> +	if (IS_ENABLED(CONFIG_X86_IOPL_EMULATION))
> +		old = t->iopl_emul;
> +	else
> +		old = t->iopl >> X86_EFLAGS_IOPL_BIT;
> +
> +	/* No point in going further if nothing changes */
> +	if (level == old)
> +		return 0;
> +
>  	/* Trying to gain more privileges? */
>  	if (level > old) {
>  		if (!capable(CAP_SYS_RAWIO) ||
>  		    security_locked_down(LOCKDOWN_IOPORT))
>  			return -EPERM;
>  	}
> -	/*
> -	 * Change the flags value on the return stack, which has been set
> -	 * up on system-call entry. See also the fork and signal handling
> -	 * code how this is handled.
> -	 */
> -	regs->flags = (regs->flags & ~X86_EFLAGS_IOPL) |
> -		(level << X86_EFLAGS_IOPL_BIT);
> -	/* Store the new level in the thread struct */
> -	t->iopl = level << X86_EFLAGS_IOPL_BIT;
> -	/*
> -	 * X86_32 switches immediately and XEN handles it via emulation.
> -	 */
> -	set_iopl_mask(t->iopl);
> +
> +	if (IS_ENABLED(CONFIG_X86_IOPL_EMULATION)) {
> +		struct tss_struct *tss;
> +		unsigned int tss_base;
> +
> +		/* Prevent racing against a task switch */
> +		preempt_disable();
> +		tss = this_cpu_ptr(&cpu_tss_rw);
> +		if (level == 3) {
> +			/* Grant access to all I/O ports */
> +			set_thread_flag(TIF_IO_BITMAP);
> +			tss_base = IO_BITMAP_OFFSET_VALID_ALL;

Where is the actual TSS updated?

> +		} else if (t->io_bitmap_ptr) {
> +			/* Thread has a I/O bitmap */
> +			tss_update_io_bitmap(tss, t);
> +			set_thread_flag(TIF_IO_BITMAP);
> +			tss_base = IO_BITMAP_OFFSET_VALID_MAP;
> +		} else {
> +			/* Take it out of the context switch work burden */
> +			clear_thread_flag(TIF_IO_BITMAP);
> +			tss_base = IO_BITMAP_OFFSET_INVALID;

Ditto.

I think what you need to do is have a single function, called by
exit_thread(), switch_to(), and here, that updates the TSS to match a
given task's IO bitmap state.  This is probably switch_to_bitmap() or
similar.

(Maybe it already is, but I swear I checked all the patches in the
series and I can't find the body of tss_update_io_bitmap().  But you
should call it in all branches of this if-else thing.)
