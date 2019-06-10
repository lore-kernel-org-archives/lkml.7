Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5079C43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC41C20859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IC/xB4mZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390130AbfFJVel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 17:34:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45867 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389362AbfFJVek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:34:40 -0400
Received: by mail-pg1-f194.google.com with SMTP id w34so5687863pga.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 14:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0gg9xI+8OwFzJxQ5Jji+7QkkrE7G1u89nLUppMZzu4U=;
        b=IC/xB4mZYUXagp1Vs5PCNT5doE5TOZwvi2QbGkJUI340xW7wqEHqYG7y/Eq+xenumk
         cS8HQehz3OrthiYSUfl/obdasSCXFz9D8cKjBNAGQDkIJQ7A/7VJiQN1LGRjnoWEmiwq
         W3AhlKPISl2oSnRtTU4apJ4FJiVcKCsWREVEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0gg9xI+8OwFzJxQ5Jji+7QkkrE7G1u89nLUppMZzu4U=;
        b=TGZIIgYouMbq8hvoWuOx0nHeCP+j2hCahdS/e2aS0xC/UEZkmh3uwT7iqH8SLWb8Ta
         2i6ZfHhgH3HvIkeMHoL9Ls7/N0FnD8abG75RDvoEuTOuCTOuciNKSzLwuit2suHuIHMq
         Rw/3zAEEgVPigxqFAF0RhU+RT5Y45kLYPpRDanSWlUv11TNfbPh1kQur9m8UajWkfz38
         G5w0Tu9kVi6Fu+u2NspwoWqLoTmGjOkuRJlV7JxGpI7LeU/MkwG0hQNtbv4l4rAxpkLF
         /xV+OuAZksfR0YCvM2PveuynNg+2dAxtdU4jDY4GuGEDHkOa5obW5XMH81Fgtxq2Qtj7
         I5rg==
X-Gm-Message-State: APjAAAXUM8N3vTzlMNyDhTNfhauHxndLrhSKpRE6uhXGK4Zn783oIePX
        Goc8UxazNpuuNnpSCqL0wxdTNQ==
X-Google-Smtp-Source: APXvYqzjO8yUHSkuYoQvw/HO6Xif3zgekf12tc403Aq29rm+0ex33Cb6wl/8OR0+O7ACVBSvhVTnpA==
X-Received: by 2002:a63:1f48:: with SMTP id q8mr122649pgm.417.1560202480038;
        Mon, 10 Jun 2019 14:34:40 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id b66sm13929525pfa.77.2019.06.10.14.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 14:34:38 -0700 (PDT)
Date:   Mon, 10 Jun 2019 14:34:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Garnier <thgarnie@chromium.org>
Cc:     kernel-hardening@lists.openwall.com, kristen@linux.intel.com,
        Thomas Garnier <thgarnie@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 05/12] x86/entry/64: Adapt assembly for PIE support
Message-ID: <201906101433.C0DB679DD@keescook>
References: <20190520231948.49693-1-thgarnie@chromium.org>
 <20190520231948.49693-6-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520231948.49693-6-thgarnie@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 04:19:30PM -0700, Thomas Garnier wrote:
> From: Thomas Garnier <thgarnie@google.com>
> 
> Change the assembly code to use only relative references of symbols for the
> kernel to be PIE compatible.
> 
> Position Independent Executable (PIE) support will allow to extend the
> KASLR randomization range below 0xffffffff80000000.
> 
> Signed-off-by: Thomas Garnier <thgarnie@google.com>
> ---
>  arch/x86/entry/entry_64.S | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 20e45d9b4e15..e99b3438aa9b 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1268,7 +1268,8 @@ ENTRY(error_entry)
>  	movl	%ecx, %eax			/* zero extend */
>  	cmpq	%rax, RIP+8(%rsp)
>  	je	.Lbstep_iret
> -	cmpq	$.Lgs_change, RIP+8(%rsp)
> +	leaq	.Lgs_change(%rip), %rcx
> +	cmpq	%rcx, RIP+8(%rsp)
>  	jne	.Lerror_entry_done
>  
>  	/*
> @@ -1465,10 +1466,10 @@ ENTRY(nmi)
>  	 * resume the outer NMI.
>  	 */
>  
> -	movq	$repeat_nmi, %rdx
> +	leaq	repeat_nmi(%rip), %rdx
>  	cmpq	8(%rsp), %rdx
>  	ja	1f
> -	movq	$end_repeat_nmi, %rdx
> +	leaq	end_repeat_nmi(%rip), %rdx
>  	cmpq	8(%rsp), %rdx
>  	ja	nested_nmi_out
>  1:
> @@ -1522,7 +1523,8 @@ nested_nmi:
>  	pushq	%rdx
>  	pushfq
>  	pushq	$__KERNEL_CS
> -	pushq	$repeat_nmi
> +	leaq	repeat_nmi(%rip), %rdx
> +	pushq	%rdx
>  
>  	/* Put stack back */
>  	addq	$(6*8), %rsp
> @@ -1561,7 +1563,11 @@ first_nmi:
>  	addq	$8, (%rsp)	/* Fix up RSP */
>  	pushfq			/* RFLAGS */
>  	pushq	$__KERNEL_CS	/* CS */
> -	pushq	$1f		/* RIP */
> +	pushq	$0		/* Futur return address */

typo: Future

> +	pushq	%rax		/* Save RAX */
> +	leaq	1f(%rip), %rax	/* RIP */
> +	movq    %rax, 8(%rsp)   /* Put 1f on return address */
> +	popq	%rax		/* Restore RAX */
>  	iretq			/* continues at repeat_nmi below */
>  	UNWIND_HINT_IRET_REGS
>  1:

Other than that:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
