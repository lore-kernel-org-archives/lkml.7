Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0329BFC6197
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 22:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8EE3214DA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 22:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573252312;
	bh=hXgXlga8MM0o2yd0itfeDxgoO6zMYIg93uGHnxnY8C8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=nHdiiO+T3RriIHfTOQfbPbGzoxF9MGuD1nlC+AaYMseG71VqgD88691QNua2ud0+T
	 5j0sw9OskAMTfUaWOodfGFRNBLtpf56CKpv+Yo7bS4UgO96z7MGf8bMXoSa4uBH+W+
	 q2WOLlPf8qcB2U7w3qaP17WV4Est52tXFsah2mbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730722AbfKHWbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 17:31:51 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42624 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729164AbfKHWbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 17:31:51 -0500
Received: by mail-pf1-f193.google.com with SMTP id s5so5710918pfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 14:31:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uOMwlXA0YCJxSB/0tZdjm9vpOf0PBhXbvsTTJSciZBo=;
        b=YHtoMo+Smmf4nheTP5Ssye+fQPNTSTfHWaiJRqZmBosU3H1bHsE0rB+sfM7z80Xy0x
         +N6j9poEJyUySepGAXlMnk8eW7cT5uLI6wP5Gf9UCW37J++SPnLB6BillSJhxVxGICO8
         GAlIDSlAGuz2RvR9TQNnXpWB4ipZbOWPdnn+tYLf1bMnM9hcP3+he3j58d8X7yrRIHk9
         L3uJIxmuy0DUngSVJcip8fjHwZXJSJRzsik8BXNpxDCjBTEKtxdjE97THAh4O9SKF4nV
         i168oYzU2924TUa9C2IHetlzquSSfxYW6loQqdTpicTb4OdswnoSdRNfqWaFeXXa+gpa
         CbJg==
X-Gm-Message-State: APjAAAXzXxsZv6S3HZ1q1moM9DtyZ+ozjdQ+CVzTy3IizYhfGq3Qmjj9
        0IYFfsrCLkw7rBE2bi6qIPIPXQ==
X-Google-Smtp-Source: APXvYqxgsTzvWwKVeIOAd8QL9w8gxGiA6Qrkb61KTL7dh0OSi94Xnte59tfcevtvB/aF+pXShlPMww==
X-Received: by 2002:a17:90a:fb53:: with SMTP id iq19mr16819626pjb.138.1573252310306;
        Fri, 08 Nov 2019 14:31:50 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:3602:86ff:fef6:e86b? ([2601:646:c200:1ef2:3602:86ff:fef6:e86b])
        by smtp.googlemail.com with ESMTPSA id e1sm6479853pgv.82.2019.11.08.14.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 14:31:49 -0800 (PST)
Subject: Re: [patch 2/9] x86/process: Unify copy_thread_tls()
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20191106193459.581614484@linutronix.de>
 <20191106202805.948064985@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <53a6f346-fca1-ac04-ee34-6d472a0d4408@kernel.org>
Date:   Fri, 8 Nov 2019 14:31:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191106202805.948064985@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/19 11:35 AM, Thomas Gleixner wrote:
> While looking at the TSS io bitmap it turned out that any change in that
> area would require identical changes to copy_thread_tls(). The 32 and 64
> bit variants share sufficient code to consolidate them into a common
> function to avoid duplication of upcoming modifications.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/ptrace.h    |    6 ++
>  arch/x86/include/asm/switch_to.h |   10 ++++
>  arch/x86/kernel/process.c        |   94 +++++++++++++++++++++++++++++++++++++++
>  arch/x86/kernel/process_32.c     |   68 ----------------------------
>  arch/x86/kernel/process_64.c     |   75 -------------------------------
>  5 files changed, 110 insertions(+), 143 deletions(-)
> 
> --- a/arch/x86/include/asm/ptrace.h
> +++ b/arch/x86/include/asm/ptrace.h
> @@ -361,5 +361,11 @@ extern int do_get_thread_area(struct tas
>  extern int do_set_thread_area(struct task_struct *p, int idx,
>  			      struct user_desc __user *info, int can_allocate);
>  
> +#ifdef CONFIG_X86_64
> +# define do_set_thread_area_64(p, s, t)	do_arch_prctl_64(p, s, t)
> +#else
> +# define do_set_thread_area_64(p, s, t)	(0)
> +#endif
> +
>  #endif /* !__ASSEMBLY__ */
>  #endif /* _ASM_X86_PTRACE_H */
> --- a/arch/x86/include/asm/switch_to.h
> +++ b/arch/x86/include/asm/switch_to.h
> @@ -103,7 +103,17 @@ static inline void update_task_stack(str
>  	if (static_cpu_has(X86_FEATURE_XENPV))
>  		load_sp0(task_top_of_stack(task));
>  #endif
> +}
>  
> +static inline void kthread_frame_init(struct inactive_task_frame *frame,
> +				      unsigned long fun, unsigned long arg)
> +{
> +	frame->bx = fun;
> +#ifdef CONFIG_X86_32
> +	frame->di = arg;
> +#else
> +	frame->r12 = arg;
> +#endif
>  }
>  
>  #endif /* _ASM_X86_SWITCH_TO_H */
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -132,6 +132,100 @@ void exit_thread(struct task_struct *tsk
>  	fpu__drop(fpu);
>  }
>  
> +static int set_new_tls(struct task_struct *p, unsigned long tls)
> +{
> +	struct user_desc __user *utls = (struct user_desc __user *)tls;
> +
> +	if (in_ia32_syscall())
> +		return do_set_thread_area(p, -1, utls, 0);
> +	else
> +		return do_set_thread_area_64(p, ARCH_SET_FS, tls);
> +}
> +
> +static inline int copy_io_bitmap(struct task_struct *tsk)
> +{
> +	if (likely(!test_tsk_thread_flag(current, TIF_IO_BITMAP)))
> +		return 0;
> +
> +	tsk->thread.io_bitmap_ptr = kmemdup(current->thread.io_bitmap_ptr,
> +					    IO_BITMAP_BYTES, GFP_KERNEL);

tsk->thread.io_bitmap_max = current->thread.io_bitmap_max?

I realize you inherited this from the code you're refactoring, but it
does seem to be missing.

> +	if (!tsk->thread.io_bitmap_ptr) {
> +		tsk->thread.io_bitmap_max = 0;
> +		return -ENOMEM;
> +	}
> +	set_tsk_thread_flag(tsk, TIF_IO_BITMAP);
> +	return 0;
> +}
> +
> +static inline void free_io_bitmap(struct task_struct *tsk)
> +{
> +	if (tsk->thread.io_bitmap_ptr) {
> +		kfree(tsk->thread.io_bitmap_ptr);
> +		tsk->thread.io_bitmap_ptr = NULL;
> +		tsk->thread.io_bitmap_max = 0;
> +	}
> +}
> +
> +int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
> +		    unsigned long arg, struct task_struct *p, unsigned long tls)
> +{
> +	struct inactive_task_frame *frame;
> +	struct fork_frame *fork_frame;
> +	struct pt_regs *childregs;
> +	int ret;
> +
> +	childregs = task_pt_regs(p);
> +	fork_frame = container_of(childregs, struct fork_frame, regs);
> +	frame = &fork_frame->frame;
> +
> +	frame->bp = 0;
> +	frame->ret_addr = (unsigned long) ret_from_fork;
> +	p->thread.sp = (unsigned long) fork_frame;
> +	p->thread.io_bitmap_ptr = NULL;
> +	memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
> +
> +#ifdef CONFIG_X86_64
> +	savesegment(gs, p->thread.gsindex);
> +	p->thread.gsbase = p->thread.gsindex ? 0 : current->thread.gsbase;
> +	savesegment(fs, p->thread.fsindex);
> +	p->thread.fsbase = p->thread.fsindex ? 0 : current->thread.fsbase;
> +	savesegment(es, p->thread.es);
> +	savesegment(ds, p->thread.ds);
> +#else
> +	/* Clear all status flags including IF and set fixed bit. */
> +	frame->flags = X86_EFLAGS_FIXED;
> +#endif

Want to do another commit to make the eflags fixup unconditional?  I'm
wondering if we have a bug.

Other than these questions:

Acked-by: Andy Lutomirski <luto@kernel.org>
