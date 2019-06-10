Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F1CC4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 22:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45CB12086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 22:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WF1H6+d1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390235AbfFJW0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 18:26:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45526 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389473AbfFJW0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 18:26:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id w34so5748445pga.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 15:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=67u0Tj2CoGeL4dThX4XrMYcQePJVLCvJn4vsI64szII=;
        b=WF1H6+d1SxAlb/vZeKF0B9iSmqUfjFmnpQhngBxfxtlTa5dzMscuS2YxqiovFwODl8
         9/UJ+FKjvDEg3auYYbf5pIpl0nH3T8j9M+qHfD4rfTJrwSdCOeSLYBN2uqtnwawrvm6u
         HfeTyvw6SOzE9f+8UL24AMx+WX8ah5iC6y6z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=67u0Tj2CoGeL4dThX4XrMYcQePJVLCvJn4vsI64szII=;
        b=UX7CzY0JoElom5QOKccYoNkYkZgocwNLsbHA9Cuy7FwFZnYPI4ezuRulvsGfYjOTEC
         rWdLYIqftr3yeuQKKot549lqIHj26AFF7lX4rFdVmxJQSMmpjPLO/PVOP4ikQGM51OcR
         ET/lrwfWG5RMxyUvZPqp4tI/yFwYjkUPO3TfFJ0fN17bJ+6ONBwEAvvuKkTUKujB2Ux1
         tRx7b2HZUH7iI2nsN1LWT0Ee+y1SAdGcspl47EJWbEzuUtGCpRvsx1yf40KHTHV5tpnb
         Rwm3Z+aW8u3szP7lCA92/qGI3ZlajQLzCQ7Sml6VBbZHhQyHkjPlLLzbWzXf30r5bVzZ
         zOdw==
X-Gm-Message-State: APjAAAUhP4AkQz5hA8gZLVHkLA15iU2drmMyT9hap373JNKnZhHG4YpJ
        fdE6Sy30rrwIcyJDZz/xERmkvg==
X-Google-Smtp-Source: APXvYqy5v/2Y0KGHNajWxqGNxE9ok3KQd0FddzucZjpJwTPjw1E5gp1y5On3KwEmj5oBF9TfSfULAg==
X-Received: by 2002:a63:84c1:: with SMTP id k184mr15441388pgd.7.1560205599265;
        Mon, 10 Jun 2019 15:26:39 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id l7sm12642106pfl.9.2019.06.10.15.26.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 15:26:38 -0700 (PDT)
Date:   Mon, 10 Jun 2019 15:26:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Garnier <thgarnie@chromium.org>
Cc:     kernel-hardening@lists.openwall.com, kristen@linux.intel.com,
        Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Feng Tang <feng.tang@intel.com>,
        Maran Wilson <maran.wilson@oracle.com>,
        Jan Beulich <JBeulich@suse.com>,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 09/12] x86/boot/64: Adapt assembly for PIE support
Message-ID: <201906101526.66E589DDD@keescook>
References: <20190520231948.49693-1-thgarnie@chromium.org>
 <20190520231948.49693-10-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520231948.49693-10-thgarnie@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 04:19:34PM -0700, Thomas Garnier wrote:
> From: Thomas Garnier <thgarnie@google.com>
> 
> Change the assembly code to use only relative references of symbols for the
> kernel to be PIE compatible.
> 
> Early at boot, the kernel is mapped at a temporary address while preparing
> the page table. To know the changes needed for the page table with KASLR,
> the boot code calculate the difference between the expected address of the
> kernel and the one chosen by KASLR. It does not work with PIE because all
> symbols in code are relatives. Instead of getting the future relocated
> virtual address, you will get the current temporary mapping.
> Instructions were changed to have absolute 64-bit references.
> 
> Position Independent Executable (PIE) support will allow to extend the
> KASLR randomization range below 0xffffffff80000000.
> 
> Signed-off-by: Thomas Garnier <thgarnie@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/x86/kernel/head_64.S | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index bcd206c8ac90..64a4f0a22b20 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -90,8 +90,10 @@ startup_64:
>  	popq	%rsi
>  
>  	/* Form the CR3 value being sure to include the CR3 modifier */
> -	addq	$(early_top_pgt - __START_KERNEL_map), %rax
> +	movabs  $(early_top_pgt - __START_KERNEL_map), %rcx
> +	addq    %rcx, %rax
>  	jmp 1f
> +
>  ENTRY(secondary_startup_64)
>  	UNWIND_HINT_EMPTY
>  	/*
> @@ -120,7 +122,8 @@ ENTRY(secondary_startup_64)
>  	popq	%rsi
>  
>  	/* Form the CR3 value being sure to include the CR3 modifier */
> -	addq	$(init_top_pgt - __START_KERNEL_map), %rax
> +	movabs	$(init_top_pgt - __START_KERNEL_map), %rcx
> +	addq    %rcx, %rax
>  1:
>  
>  	/* Enable PAE mode, PGE and LA57 */
> @@ -138,7 +141,7 @@ ENTRY(secondary_startup_64)
>  	movq	%rax, %cr3
>  
>  	/* Ensure I am executing from virtual addresses */
> -	movq	$1f, %rax
> +	movabs  $1f, %rax
>  	ANNOTATE_RETPOLINE_SAFE
>  	jmp	*%rax
>  1:
> @@ -235,11 +238,12 @@ ENTRY(secondary_startup_64)
>  	 *	REX.W + FF /5 JMP m16:64 Jump far, absolute indirect,
>  	 *		address given in m16:64.
>  	 */
> -	pushq	$.Lafter_lret	# put return address on stack for unwinder
> +	movabs  $.Lafter_lret, %rax
> +	pushq	%rax		# put return address on stack for unwinder
>  	xorl	%ebp, %ebp	# clear frame pointer
> -	movq	initial_code(%rip), %rax
> +	leaq	initial_code(%rip), %rax
>  	pushq	$__KERNEL_CS	# set correct cs
> -	pushq	%rax		# target address in negative space
> +	pushq	(%rax)		# target address in negative space
>  	lretq
>  .Lafter_lret:
>  END(secondary_startup_64)
> -- 
> 2.21.0.1020.gf2820cf01a-goog
> 

-- 
Kees Cook
