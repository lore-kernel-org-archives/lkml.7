Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF77C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C8C20833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555313143;
	bh=Cv9XQANIEh/hIYFUCcgow/Hb9AsrKOX9eneshnfNNNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uaYp6lsbyCffnCvm0+/wPBVL0bcMXYKJkmidIynNjDxK4TJCLNucIGR9RFcgB0G/b
	 fpJ9fi/udBrl3iUVGAPYq0BtFTOcKNd/XO0b+nSw+VSEzaT/GB6t+VGjDNTfMZnTGf
	 FlJrL/X4iG0M3gfbPIsisUX/smBOT5OSXr18sVpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfDOHZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:25:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33723 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfDOHZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 03:25:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id q1so20491932wrp.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 00:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UlRnr5z4Cbmab1Zs6WJuDWCVKRzYG7dVHDdRBvSoZF8=;
        b=awjkCG2zSwenNOSuu/HmwWOYETiqL0iP2+NtVCCw1vP4aIUUYIkYHTL5eCkWSXl6KR
         7z+E5nuOtWWok4sHN1W63zYdEiBucklh3d294YkgS1bfcFYzayIgRpeWN/8RgRuXCMpU
         3yvrBgbK3AVhpUno4G7Cbq3h1nO9jNKxlNruPtRdEH7Xwt5iEULcHZcuSMQVHjbtiUQp
         r/RTLTGSo8PkbFJbB9o/zVdt5qi1M6n3/71UC2JftNfJmcM0ktrZmVOjC+MCz5qvQHPC
         LxaFPSpOGhwXVHYDBflx5xMJEj3g1NP1hYinFaBIjwVyMELzewH7jD76E8bDX5TqXjQJ
         624g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=UlRnr5z4Cbmab1Zs6WJuDWCVKRzYG7dVHDdRBvSoZF8=;
        b=Pi2Yy1gqbhXbO5D0rcX/PInFLyxwtxH37M24fmzvsVMxFUuGY3IWXXPaUO3Bd+xgf3
         l5RvT7ZnDr3hE4O9h7HdODJDXl5KJWWeUgRU+zp60fjUWS0ayn/RFv9CMHqJuhDKDhdw
         MP7XWtLpGZqdc6uKA5C0h2K8bbEkaP5yn6hhGIZ0uc43In7pLxx/uwq2LBUnCjgUWQgo
         UDliKsiIUOKa2/yyMXrTvR4nTpklq9x0c3P0gY/Ai0CoW/uP8tfiKot3I4EM56Qd/OAZ
         0AU/SqdndyuCkm4Q3yFpsDAF2e5LRw0i3uDvNWlDZF4Od+DztmgJGiH9wW2hJeLVrJTM
         d7RA==
X-Gm-Message-State: APjAAAXSIX61qFah1nPWywSJxCOYCwhdDtkGWH4ABBdn0okVDqqXncun
        hF9G11p6cjZZDDFrQzX49itCMMj/
X-Google-Smtp-Source: APXvYqwE5/ucR2SU+lT0rhhofMladlG4ci9aZaZfqlli8j0wS1tWm0sGcEDHP03g45HrVLXSP4qfFA==
X-Received: by 2002:a5d:448f:: with SMTP id j15mr39809547wrq.79.1555313138919;
        Mon, 15 Apr 2019 00:25:38 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id b3sm48813738wrx.57.2019.04.15.00.25.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 00:25:38 -0700 (PDT)
Date:   Mon, 15 Apr 2019 09:25:35 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Elena Reshetova <elena.reshetova@intel.com>
Cc:     luto@kernel.org, luto@amacapital.net, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, keescook@chromium.org, jannh@google.com,
        enrico.perla@intel.com, mingo@redhat.com, bp@alien8.de,
        tglx@linutronix.de, peterz@infradead.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Message-ID: <20190415072535.GA51449@gmail.com>
References: <20190415060918.3766-1-elena.reshetova@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415060918.3766-1-elena.reshetova@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Elena Reshetova <elena.reshetova@intel.com> wrote:

> This is an example of produced assembly code for gcc x86_64:
> 
> ...
>   add_random_stack_offset();
> 0xffffffff810022e9 callq  0xffffffff81459570 <prandom_u32>
> 0xffffffff810022ee movzbl %al,%eax
> 0xffffffff810022f1 add    $0x16,%rax
> 0xffffffff810022f5 and    $0x1f8,%eax
> 0xffffffff810022fa sub    %rax,%rsp
> 0xffffffff810022fd lea    0xf(%rsp),%rax
> 0xffffffff81002302 and    $0xfffffffffffffff0,%rax
> ...

Hm, that all to prandom_u32() then does:

ffffffff8146cd70 <prandom_u32>:
ffffffff8146cd70:       48 c7 c7 10 e3 01 00    mov    $0x1e310,%rdi
ffffffff8146cd77:       65 48 03 3d d9 23 ba    add    %gs:0x7eba23d9(%rip),%rdi        # f158 <this_cpu_off>
ffffffff8146cd7e:       7e 
ffffffff8146cd7f:       e8 6c ff ff ff          callq  ffffffff8146ccf0 <prandom_u32_state>
ffffffff8146cd84:       c3                      retq   

which then does:

ffffffff8146ccf0 <prandom_u32_state>:
ffffffff8146ccf0:       8b 0f                   mov    (%rdi),%ecx
ffffffff8146ccf2:       8b 47 04                mov    0x4(%rdi),%eax
ffffffff8146ccf5:       44 8b 47 08             mov    0x8(%rdi),%r8d
ffffffff8146ccf9:       89 ca                   mov    %ecx,%edx
ffffffff8146ccfb:       8d 34 85 00 00 00 00    lea    0x0(,%rax,4),%esi
ffffffff8146cd02:       c1 e2 06                shl    $0x6,%edx
ffffffff8146cd05:       31 f0                   xor    %esi,%eax
ffffffff8146cd07:       83 e6 e0                and    $0xffffffe0,%esi
ffffffff8146cd0a:       31 ca                   xor    %ecx,%edx
ffffffff8146cd0c:       c1 e1 12                shl    $0x12,%ecx
ffffffff8146cd0f:       81 e1 00 00 f8 ff       and    $0xfff80000,%ecx
ffffffff8146cd15:       c1 ea 0d                shr    $0xd,%edx
ffffffff8146cd18:       31 ca                   xor    %ecx,%edx
ffffffff8146cd1a:       89 c1                   mov    %eax,%ecx
ffffffff8146cd1c:       44 89 c0                mov    %r8d,%eax
ffffffff8146cd1f:       c1 e0 0d                shl    $0xd,%eax
ffffffff8146cd22:       c1 e9 1b                shr    $0x1b,%ecx
ffffffff8146cd25:       89 17                   mov    %edx,(%rdi)
ffffffff8146cd27:       44 31 c0                xor    %r8d,%eax
ffffffff8146cd2a:       41 c1 e0 07             shl    $0x7,%r8d
ffffffff8146cd2e:       31 f1                   xor    %esi,%ecx
ffffffff8146cd30:       c1 e8 15                shr    $0x15,%eax
ffffffff8146cd33:       41 81 e0 00 f8 ff ff    and    $0xfffff800,%r8d
ffffffff8146cd3a:       89 4f 04                mov    %ecx,0x4(%rdi)
ffffffff8146cd3d:       41 31 c0                xor    %eax,%r8d
ffffffff8146cd40:       8b 47 0c                mov    0xc(%rdi),%eax
ffffffff8146cd43:       44 89 47 08             mov    %r8d,0x8(%rdi)
ffffffff8146cd47:       8d 34 c5 00 00 00 00    lea    0x0(,%rax,8),%esi
ffffffff8146cd4e:       31 c6                   xor    %eax,%esi
ffffffff8146cd50:       c1 e0 0d                shl    $0xd,%eax
ffffffff8146cd53:       25 00 00 f0 ff          and    $0xfff00000,%eax
ffffffff8146cd58:       c1 ee 0c                shr    $0xc,%esi
ffffffff8146cd5b:       31 c6                   xor    %eax,%esi
ffffffff8146cd5d:       89 d0                   mov    %edx,%eax
ffffffff8146cd5f:       31 c8                   xor    %ecx,%eax
ffffffff8146cd61:       89 77 0c                mov    %esi,0xc(%rdi)
ffffffff8146cd64:       44 31 c0                xor    %r8d,%eax
ffffffff8146cd67:       31 f0                   xor    %esi,%eax
ffffffff8146cd69:       c3                      retq   

and just to recover ~5 bits of randomness:

> As a result of the above gcc-produce code this patch introduces
> a bit more than 5 bits of randomness after pt_regs location on
> the thread stack (33 different offsets are generated
> randomly for x86_64 and 47 for i386).
> The amount of randomness can be adjusted based on how much of the
> stack space we wish/can trade for security.

Note that the reduction in bits is mostly due to:

> +#define add_random_stack_offset() do {               \
> +     size_t offset = ((size_t)prandom_u32()) % 256;   \
> +     char *ptr = __builtin_alloca(offset);            \
> +     asm volatile("":"=m"(*ptr));                     \

So if we are really sticking this into the syscall path, could we please 
be a bit more smart about it? Note how we are already masking off bits in 
prandom_u32_state():

ffffffff8146cd53:       25 00 00 f0 ff          and    $0xfff00000,%eax

and then we mask *again*, in a rather stupid way:

> 0xffffffff810022ee movzbl %al,%eax
> 0xffffffff810022f1 add    $0x16,%rax
> 0xffffffff810022f5 and    $0x1f8,%eax
> 0xffffffff810022fa sub    %rax,%rsp
> 0xffffffff810022fd lea    0xf(%rsp),%rax
> 0xffffffff81002302 and    $0xfffffffffffffff0,%rax

What I'd suggest is:

1)

Put the PRNG state not into a per-cpu area which has to be recovered, but 
put it somewhere convenient, already accessibe easily at that point in 
the syscall path - such as struct thread_info? (But don't take my word 
for it - if task_struct is a better place then use that.)

This avoids the whole percpu redirection.

2)

Then also please make a private version of that function which is inlined 
into the straight execution path: this code is going to be executed for 
every single syscall, so inlining is 1000% justified.

3)

Have a really good look at the generated assembly code and justify every 
single instruction, and try to eliminate it. Maybe even take a look at 
whether there's any simpler PRNG that is better suited: if we have per 
thread_info random state then there will be no cross-task leakage of the 
"secret" and we can actually weaken the PRNG.

4)

But before you tweak the patch, a more fundamental question:

Does the stack offset have to be per *syscall execution* randomized? 
Which threats does this protect against that a simpler per task syscall 
random offset wouldn't protect against?

It would be far, far more performant to just add a fork() time randomized 
kernel stack offset (and that can be a *real* random offset, not PRNG) to 
syscalls. We could even make that an overall default setting if it's fast 
enough, which I think it could be made.

> Performance (x86_64 measuments only):
> 
> 1) lmbench: ./lat_syscall -N 1000000 null
>     base:                                        Simple syscall: 0.1774 microseconds
>     random_offset (prandom_u32() every syscall): Simple syscall: 0.1822 microseconds
> 
> 2)  Andy's tests, misc-tests: ./timing_test_64 10M sys_enosys
>     base:                                        10000000 loops in 1.62224s = 162.22 nsec / loop
>     random_offset (prandom_u32() every syscall): 10000000 loops in 1.64660s = 166.26 nsec / loop

Was this measured with CONFIG_PAGE_TABLE_ISOLATION turned off? By the 
time such patches get to real Linux users we'll likely see modern 
processors with Meltdown fixed.

I.e. the relative cost of syscall entry code changes should generally be 
measured with CONFIG_PAGE_TABLE_ISOLATION off.

Thanks,

	Ingo
