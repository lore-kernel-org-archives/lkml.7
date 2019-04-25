Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0310C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D25DE2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kYGyyBe1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbfDYTNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:13:22 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:38819 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfDYTNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:13:21 -0400
Received: by mail-it1-f194.google.com with SMTP id q19so1949071itk.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=A5wwbzdeiQrMV1W27Xj1YcX0Qjh4zwjiYg44ZJ89oQU=;
        b=kYGyyBe13Wv+DV3jzR0y04R2wwk23zd9LzN2fFhhKu+gP6ghvr5EqrDx+R0V5B/Dx9
         +ADYCq07AZJP8BTRi4uKSRBzHzNRPfKxhp5Jr5XaPD2HE7zuiDksc/lTZIu0/7YvbQWm
         27H5VqYNjX0nbRTtHvl17iN4bJ2kirlqKsnBNvO2GU3nFryc/NnEtVOqwdEh6Z9D34UN
         Tyiz29JcVOvCgmf87FmmV2Iy8oVV8DgsKdehmnYR3X0QfKfWhp5w2A/u6PmeNBWh+KUH
         SpX3zPDI/7H1LEAo52MG74rQS4w79ELl7hgoVLz6BHWOK0UD6QZtPCGyn4tz7om2z+01
         DFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=A5wwbzdeiQrMV1W27Xj1YcX0Qjh4zwjiYg44ZJ89oQU=;
        b=gpH4lnAifCGOGdhpBRXgNsOx+5CW8sDkhWCymmMEAaUhdX0TTR5PF1Uzw6wHacXink
         1K5G4xsoJHKgprdC1zxncpB8cwBKm6hldsofwlq7jav5LXhsa0JvS3z8OmMEX0j81lzW
         JTs6kvm2OcnEOV9XeDznVnKbX7VFX6NjN+InqsLdGDIJQ481/bodQ7yEC6fvtxfcZnw1
         MEJ4WvURq0s+hoV58pEde/FqxXrE0VypC/7NNnax2faQiQjqrgA9H0GPIfxJF7/4xHvR
         WJ5t9X8UaG2ylUdYj5EnGmo3v1SYv6WY/iptK18BKSI/c/BwdL4p6hyiUHzAzs5YtlA9
         xIcg==
X-Gm-Message-State: APjAAAW75eX98xDv9Lp86DfCk9tTp0d/3TAqfzZ/H5i0JzFroSqDXQ8q
        xJUzNNijpg34cNkCUA4nOEDDSNcYQ6o=
X-Google-Smtp-Source: APXvYqyr9NZCc/VcZOsEXVnVfgTlkN1QJMAR6T0f5ifenFiCwrEKIdf/L1GbTz4r9RiJzpOIT9eQxQ==
X-Received: by 2002:a24:76d5:: with SMTP id z204mr4967251itb.44.1556219600184;
        Thu, 25 Apr 2019 12:13:20 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id x187sm10583787itb.39.2019.04.25.12.13.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 12:13:19 -0700 (PDT)
Date:   Thu, 25 Apr 2019 12:13:18 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] riscv: remove duplicate macros from ptrace.h
In-Reply-To: <20190411115623.5749-8-hch@lst.de>
Message-ID: <alpine.DEB.2.21.9999.1904251208140.17442@viisi.sifive.com>
References: <20190411115623.5749-1-hch@lst.de> <20190411115623.5749-8-hch@lst.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Apr 2019, Christoph Hellwig wrote:

> No need to have two names for the same thing.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This is probably worth cleaning up across the entire tree.  

asm-{generic,x86,arm64,powerpc}/ptrace.h all define similar GET_IP/SET_IP
macros - although it seems that arch/riscv is the only architecture that 
uses them.


- Paul


> ---
>  arch/riscv/include/asm/ptrace.h | 21 ++++++---------------
>  arch/riscv/kernel/stacktrace.c  |  8 ++++----
>  arch/riscv/kernel/traps.c       |  2 +-
>  3 files changed, 11 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptrace.h
> index d35ec2f41381..9c867a4bac83 100644
> --- a/arch/riscv/include/asm/ptrace.h
> +++ b/arch/riscv/include/asm/ptrace.h
> @@ -70,47 +70,38 @@ struct pt_regs {
>  
>  
>  /* Helpers for working with the instruction pointer */
> -#define GET_IP(regs) ((regs)->sepc)
> -#define SET_IP(regs, val) (GET_IP(regs) = (val))
> -
>  static inline unsigned long instruction_pointer(struct pt_regs *regs)
>  {
> -	return GET_IP(regs);
> +	return regs->sepc;
>  }
>  static inline void instruction_pointer_set(struct pt_regs *regs,
>  					   unsigned long val)
>  {
> -	SET_IP(regs, val);
> +	regs->sepc = val;
>  }
>  
>  #define profile_pc(regs) instruction_pointer(regs)
>  
>  /* Helpers for working with the user stack pointer */
> -#define GET_USP(regs) ((regs)->sp)
> -#define SET_USP(regs, val) (GET_USP(regs) = (val))
> -
>  static inline unsigned long user_stack_pointer(struct pt_regs *regs)
>  {
> -	return GET_USP(regs);
> +	return regs->sp;
>  }
>  static inline void user_stack_pointer_set(struct pt_regs *regs,
>  					  unsigned long val)
>  {
> -	SET_USP(regs, val);
> +	regs->sp =  val;
>  }
>  
>  /* Helpers for working with the frame pointer */
> -#define GET_FP(regs) ((regs)->s0)
> -#define SET_FP(regs, val) (GET_FP(regs) = (val))
> -
>  static inline unsigned long frame_pointer(struct pt_regs *regs)
>  {
> -	return GET_FP(regs);
> +	return regs->s0;
>  }
>  static inline void frame_pointer_set(struct pt_regs *regs,
>  				     unsigned long val)
>  {
> -	SET_FP(regs, val);
> +	regs->s0 = val;
>  }
>  
>  static inline unsigned long regs_return_value(struct pt_regs *regs)
> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
> index a4b1d94371a0..25fe0ff81f9e 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c
> @@ -33,9 +33,9 @@ static void notrace walk_stackframe(struct task_struct *task,
>  	unsigned long fp, sp, pc;
>  
>  	if (regs) {
> -		fp = GET_FP(regs);
> -		sp = GET_USP(regs);
> -		pc = GET_IP(regs);
> +		fp = frame_pointer(regs);
> +		sp = user_stack_pointer(regs);
> +		pc = instruction_pointer(regs);
>  	} else if (task == NULL || task == current) {
>  		const register unsigned long current_sp __asm__ ("sp");
>  		fp = (unsigned long)__builtin_frame_address(0);
> @@ -83,7 +83,7 @@ static void notrace walk_stackframe(struct task_struct *task,
>  
>  	if (regs) {
>  		sp = GET_USP(regs);
> -		pc = GET_IP(regs);
> +		pc = instruction_pointer(regs);
>  	} else if (task == NULL || task == current) {
>  		const register unsigned long current_sp __asm__ ("sp");
>  		sp = current_sp;
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 24a9333dda2c..86731a2fa218 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -70,7 +70,7 @@ void do_trap(struct pt_regs *regs, int signo, int code,
>  	    && printk_ratelimit()) {
>  		pr_info("%s[%d]: unhandled signal %d code 0x%x at 0x" REG_FMT,
>  			tsk->comm, task_pid_nr(tsk), signo, code, addr);
> -		print_vma_addr(KERN_CONT " in ", GET_IP(regs));
> +		print_vma_addr(KERN_CONT " in ", instruction_pointer(regs));
>  		pr_cont("\n");
>  		show_regs(regs);
>  	}
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
