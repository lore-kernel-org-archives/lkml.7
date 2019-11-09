Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F73C17440
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 00:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0397D207FA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 00:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573259082;
	bh=Dp50A8wI5ibXo6HuUUlSg4ox4RYx4qSw81wneby5pt8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=12THDIWD3DIxGcbZtLu+OBcc//sZnhiqUBS8fJLkLc7mjdFhFb9CXC06EB6rEKMhG
	 9vpsAqq3lg/EewO7ZT0UuwJyi5gF5aVnJfmAubuBxkFQnrKS5NAyN4RH/ioL8MaFta
	 re+QWC96Kc+xliLYkQ5xjNJCbbe/N+BIuCGUo2ow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKIAYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 19:24:41 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174]:40553 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfKIAYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 19:24:40 -0500
Received: by mail-pf1-f174.google.com with SMTP id r4so6068804pfl.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 16:24:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uVumoSj6oFqPYZXKsAoSp8BF+si6JzsXP1lshMBc9fQ=;
        b=C/K06ldwWk3kERkwXqVoZrHUla6DLc0MCByPPnHHsOjtg9/S53hHK00NrHsnUFmZRG
         0KRfnQJ95+MQp3PdTA+nfO5imH4FbRYDbG22k5M5dkbX6g8MaChT38LdxOa/ZDYEw8er
         Gq77dJ3ousAG/sWFaBwS7lRsUNMvLite062AZLfJg4YNNKzGRkEiI7foOKBi4eNNG4b/
         3Tg9HquGMx1hFklc4YWCodOf6Msx5HghF5dGcj2D6v5JBSmfhhHpKzv765+UjzaLYAPi
         u4Z2MomkGBaQV77KFJl2+G/1LsJabanJMqyNUpglPALyhVZICwu6ILr2W2FrAS1x9hPe
         5TfQ==
X-Gm-Message-State: APjAAAXDp9hU+jxpK6HsqDSlyZV3b4zhtcWFESf39+Jo+QrN0sndW/gq
        uU62gOSvLDx7dx21JzNQQ5BZcNwImNms+w==
X-Google-Smtp-Source: APXvYqwCVICDbDrR3LPE6CDmu9fkswQcoSJRwAGIbG4JkDovi10XmKymU8ryjLJrUrRN3erybiTdsw==
X-Received: by 2002:a17:90a:26c1:: with SMTP id m59mr17838094pje.101.1573259079608;
        Fri, 08 Nov 2019 16:24:39 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:3602:86ff:fef6:e86b? ([2601:646:c200:1ef2:3602:86ff:fef6:e86b])
        by smtp.googlemail.com with ESMTPSA id 27sm7181405pgx.23.2019.11.08.16.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 16:24:38 -0800 (PST)
Subject: Re: [patch 4/9] x86/io: Speedup schedule out of I/O bitmap user
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20191106193459.581614484@linutronix.de>
 <20191106202806.133597409@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <b44feb60-130a-0672-5f14-5789de57a246@kernel.org>
Date:   Fri, 8 Nov 2019 16:24:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191106202806.133597409@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/19 11:35 AM, Thomas Gleixner wrote:
> There is no requirement to update the TSS I/O bitmap when a thread using it is
> scheduled out and the incoming thread does not use it.
> 
> For the permission check based on the TSS I/O bitmap the CPU calculates the memory
> location of the I/O bitmap by the address of the TSS and the io_bitmap_base member
> of the tss_struct. The easiest way to invalidate the I/O bitmap is to switch the
> offset to an address outside of the TSS limit.
> 
> If an I/O instruction is issued from user space the TSS limit causes #GP to be
> raised in the same was as valid I/O bitmap with all bits set to 1 would do.
> 
> This removes the extra work when an I/O bitmap using task is scheduled out
> and puts the burden on the rare I/O bitmap users when they are scheduled
> in.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/processor.h |   38 +++++++++++++++++--------
>  arch/x86/kernel/cpu/common.c     |    3 +
>  arch/x86/kernel/doublefault.c    |    2 -
>  arch/x86/kernel/process.c        |   59 +++++++++++++++++++++------------------
>  4 files changed, 61 insertions(+), 41 deletions(-)
> 
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -330,8 +330,23 @@ struct x86_hw_tss {
>  #define IO_BITMAP_BITS			65536
>  #define IO_BITMAP_BYTES			(IO_BITMAP_BITS/8)
>  #define IO_BITMAP_LONGS			(IO_BITMAP_BYTES/sizeof(long))
> -#define IO_BITMAP_OFFSET		(offsetof(struct tss_struct, io_bitmap) - offsetof(struct tss_struct, x86_tss))
> -#define INVALID_IO_BITMAP_OFFSET	0x8000
> +
> +#define IO_BITMAP_OFFSET_VALID				\
> +	(offsetof(struct tss_struct, io_bitmap) -	\
> +	 offsetof(struct tss_struct, x86_tss))
> +
> +/*
> + * sizeof(unsigned long) coming from an extra "long" at the end
> + * of the iobitmap.
> + *
> + * -1? seg base+limit should be pointing to the address of the
> + * last valid byte

What's with the '?'

> + */
> +#define __KERNEL_TSS_LIMIT	\
> +	(IO_BITMAP_OFFSET_VALID + IO_BITMAP_BYTES + sizeof(unsigned long) - 1)
> +
> +/* Base offset outside of TSS_LIMIT so unpriviledged IO causes #GP */
> +#define IO_BITMAP_OFFSET_INVALID	(__KERNEL_TSS_LIMIT + 1)
>  
>  struct entry_stack {
>  	unsigned long		words[64];
> @@ -350,6 +365,15 @@ struct tss_struct {
>  	struct x86_hw_tss	x86_tss;
>  
>  	/*
> +	 * Store the dirty size of the last io bitmap offender. The next
> +	 * one will have to do the cleanup as the switch out to a non
> +	 * io bitmap user will just set x86_tss.io_bitmap_base to a value
> +	 * outside of the TSS limit. So for sane tasks there is no need
> +	 * to actually touch the io_bitmap at all.
> +	 */
> +	unsigned int		io_bitmap_prev_max;

Hmm.  I'm wondering if a clearer way to say this would be:

io_bitmap_max_allowed_byte: offset from the start of the io bitmap to
the first byte that might contain a zero bit.  If we switch from a task
that uses ioperm() to one that does not, we will invalidate the io
bitmap by changing the offset.  The next task that starts using the io
bitmap again will need to make sure it updates all the bytes through
io_bitmap_max_allowed_byte.

But your description is okay, too.

It's worth noting that, due to Meltdown, this patch leaks the io bitmap
of io bitmap-using tasks.  I'm not sure I care.

> +
> +	/*
>  	 * The extra 1 is there because the CPU will access an
>  	 * additional byte beyond the end of the IO permission
>  	 * bitmap. The extra byte must be all 1 bits, and must
> @@ -360,16 +384,6 @@ struct tss_struct {
>  
>  DECLARE_PER_CPU_PAGE_ALIGNED(struct tss_struct, cpu_tss_rw);
>  
> -/*
> - * sizeof(unsigned long) coming from an extra "long" at the end
> - * of the iobitmap.
> - *
> - * -1? seg base+limit should be pointing to the address of the
> - * last valid byte
> - */
> -#define __KERNEL_TSS_LIMIT	\
> -	(IO_BITMAP_OFFSET + IO_BITMAP_BYTES + sizeof(unsigned long) - 1)
> -
>  /* Per CPU interrupt stacks */
>  struct irq_stack {
>  	char		stack[IRQ_STACK_SIZE];
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1863,7 +1863,8 @@ void cpu_init(void)
>  
>  	/* Initialize the TSS. */
>  	tss_setup_ist(tss);
> -	tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET;
> +	tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_INVALID;
> +	tss->io_bitmap_prev_max = 0;
>  	memset(tss->io_bitmap, 0xff, sizeof(tss->io_bitmap));
>  	set_tss_desc(cpu, &get_cpu_entry_area(cpu)->tss.x86_tss);
>  
> --- a/arch/x86/kernel/doublefault.c
> +++ b/arch/x86/kernel/doublefault.c
> @@ -54,7 +54,7 @@ struct x86_hw_tss doublefault_tss __cach
>  	.sp0		= STACK_START,
>  	.ss0		= __KERNEL_DS,
>  	.ldt		= 0,
> -	.io_bitmap_base	= INVALID_IO_BITMAP_OFFSET,
> +	.io_bitmap_base	= IO_BITMAP_OFFSET_INVALID,
>  
>  	.ip		= (unsigned long) doublefault_fn,
>  	/* 0x2 bit is always set */
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -72,18 +72,9 @@
>  #ifdef CONFIG_X86_32
>  		.ss0 = __KERNEL_DS,
>  		.ss1 = __KERNEL_CS,
> -		.io_bitmap_base	= INVALID_IO_BITMAP_OFFSET,
>  #endif
> +		.io_bitmap_base	= IO_BITMAP_OFFSET_INVALID,
>  	 },
> -#ifdef CONFIG_X86_32
> -	 /*
> -	  * Note that the .io_bitmap member must be extra-big. This is because
> -	  * the CPU will access an additional byte beyond the end of the IO
> -	  * permission bitmap. The extra byte must be all 1 bits, and must
> -	  * be within the limit.
> -	  */
> -	.io_bitmap		= { [0 ... IO_BITMAP_LONGS] = ~0 },
> -#endif
>  };
>  EXPORT_PER_CPU_SYMBOL(cpu_tss_rw);
>  
> @@ -112,18 +103,18 @@ void exit_thread(struct task_struct *tsk
>  	struct thread_struct *t = &tsk->thread;
>  	unsigned long *bp = t->io_bitmap_ptr;
>  	struct fpu *fpu = &t->fpu;
> +	struct tss_struct *tss;
>  
>  	if (bp) {
> -		struct tss_struct *tss = &per_cpu(cpu_tss_rw, get_cpu());
> +		preempt_disable();
> +		tss = this_cpu_ptr(&cpu_tss_rw);
>  
>  		t->io_bitmap_ptr = NULL;
> -		clear_thread_flag(TIF_IO_BITMAP);
> -		/*
> -		 * Careful, clear this in the TSS too:
> -		 */
> -		memset(tss->io_bitmap, 0xff, t->io_bitmap_max);
>  		t->io_bitmap_max = 0;
> -		put_cpu();
> +		clear_thread_flag(TIF_IO_BITMAP);
> +		/* Invalidate the io bitmap base in the TSS */
> +		tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_INVALID;

The first time I read this, I thought this code was all unnecessary.
But now I think I understand.  How about a comment:

/*
 * We're about to free the IO bitmap.  We need to disable it in the TSS
 * too so that switch_to() doesn't see an inconsistent state.
 */

In any case:

Acked-by: Andy Lutomirski <luto@kernel.org>
