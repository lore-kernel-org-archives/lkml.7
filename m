Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058C3C282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C758C206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhL8C6TG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbfDOWB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 18:01:57 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35496 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfDOWB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 18:01:57 -0400
Received: by mail-ed1-f68.google.com with SMTP id y67so2810027ede.2;
        Mon, 15 Apr 2019 15:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RJqS8aUhikcYPZrVt+ASSZGTsN7hObt7ZSRvFLdA9Mk=;
        b=LhL8C6TGF5qrwHscLfvYjjPlw4g5okjx2s5ZgM9HOzroeGIQMzvqhISoAfAYth10a2
         dr9wc9VU21x4R/Nur2+AQsIHbTRTj9DyHAHnHdEM5p/ZImk4dw8/u7LYxGixa7s4qtLN
         iT6hxRE2b6PlL1q2AOYsT8W/FWqvIpz+LC6m6oNnx3nQdzES3CasL2gwnkFeP3nzdZ60
         bYzCTuGQGH+q+bgkko+fEwlJPsJ2OxL0+TLNohlwvPgI311SMMRamCDAWYO4sv71FrNt
         jv5nWOABfUxIWUIyrj6IBbsyncnlSIQDabslysHhVtRyJrnPowjPn9gfPV5WfCUKUIRM
         tXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RJqS8aUhikcYPZrVt+ASSZGTsN7hObt7ZSRvFLdA9Mk=;
        b=TrZv7vbSyBWfshD6sa0atW+frgPqP7kbQcCEms6u/gFHDsxktblwVmGvZ11igEthCt
         xbDuijs4u0I1OGS2LDiKbo77P2THwMRR/4eNJJ52KLHNQb6piHmM7a3vMoN79+3LHjIW
         DB5GPLPJOiESfhB1XcWyg6vkVIAiFqy1riGO7d4a5u4tAnShZWiyo83AfnaVEe0jbxYR
         OHId6VKj1qvpcLpQLqxloF7ClGJye8hzyW4+PNzS2Gd4gnMcGrxJV4cW2/2OEyTd1mXT
         5hBNhNOnC+1mB1dTIK1OrZRwMyen3RYo7xqf+A1+oroOGG89ndMLcSzTfOUWbHR49eKQ
         B+bA==
X-Gm-Message-State: APjAAAXrsDtremosMju0wDcHQVx6PU5AYq9PGGRbt4GCu1imntRWecwI
        URLk8+jqUOGNkMhB+3jfe20tM96IHNc=
X-Google-Smtp-Source: APXvYqw7VZYDNV9MDxala6jKYeIHzOAnspA9bIpEKpijftLvnT4Wl6/M/VqXeJqHn+m7bFpZJD6xUQ==
X-Received: by 2002:a50:b80e:: with SMTP id j14mr10773402ede.170.1555365714762;
        Mon, 15 Apr 2019 15:01:54 -0700 (PDT)
Received: from archlinux-i9 ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id x13sm1862556eda.13.2019.04.15.15.01.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Apr 2019 15:01:53 -0700 (PDT)
Date:   Mon, 15 Apr 2019 15:01:51 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        stable@kernel.org, Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 4.9 72/76] arm64: futex: Fix FUTEX_WAKE_OP atomic ops
 with non-zero result value
Message-ID: <20190415220151.GA23056@archlinux-i9>
References: <20190415183707.712011689@linuxfoundation.org>
 <20190415183729.170980546@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415183729.170980546@linuxfoundation.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 08:44:36PM +0200, Greg Kroah-Hartman wrote:
> From: Will Deacon <will.deacon@arm.com>
> 
> commit 045afc24124d80c6998d9c770844c67912083506 upstream.
> 
> Rather embarrassingly, our futex() FUTEX_WAKE_OP implementation doesn't
> explicitly set the return value on the non-faulting path and instead
> leaves it holding the result of the underlying atomic operation. This
> means that any FUTEX_WAKE_OP atomic operation which computes a non-zero
> value will be reported as having failed. Regrettably, I wrote the buggy
> code back in 2011 and it was upstreamed as part of the initial arm64
> support in 2012.
> 
> The reasons we appear to get away with this are:
> 
>   1. FUTEX_WAKE_OP is rarely used and therefore doesn't appear to get
>      exercised by futex() test applications
> 
>   2. If the result of the atomic operation is zero, the system call
>      behaves correctly
> 
>   3. Prior to version 2.25, the only operation used by GLIBC set the
>      futex to zero, and therefore worked as expected. From 2.25 onwards,
>      FUTEX_WAKE_OP is not used by GLIBC at all.
> 
> Fix the implementation by ensuring that the return value is either 0
> to indicate that the atomic operation completed successfully, or -EFAULT
> if we encountered a fault when accessing the user mapping.
> 
> Cc: <stable@kernel.org>
> Fixes: 6170a97460db ("arm64: Atomic operations")
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
>  arch/arm64/include/asm/futex.h |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> --- a/arch/arm64/include/asm/futex.h
> +++ b/arch/arm64/include/asm/futex.h
> @@ -33,8 +33,8 @@
>  "	prfm	pstl1strm, %2\n"					\
>  "1:	ldxr	%w1, %2\n"						\
>  	insn "\n"							\
> -"2:	stlxr	%w3, %w0, %2\n"						\
> -"	cbnz	%w3, 1b\n"						\
> +"2:	stlxr	%w0, %w3, %2\n"						\
> +"	cbnz	%w0, 1b\n"						\
>  "	dmb	ish\n"							\
>  "3:\n"									\
>  "	.pushsection .fixup,\"ax\"\n"					\
> @@ -53,29 +53,29 @@
>  static inline int
>  arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
>  {
> -	int oldval = 0, ret, tmp;
> +	int oldval, ret, tmp;
>  
>  	pagefault_disable();
>  
>  	switch (op) {
>  	case FUTEX_OP_SET:
> -		__futex_atomic_op("mov	%w0, %w4",
> +		__futex_atomic_op("mov	%w3, %w4",
>  				  ret, oldval, uaddr, tmp, oparg);
>  		break;
>  	case FUTEX_OP_ADD:
> -		__futex_atomic_op("add	%w0, %w1, %w4",
> +		__futex_atomic_op("add	%w3, %w1, %w4",
>  				  ret, oldval, uaddr, tmp, oparg);
>  		break;
>  	case FUTEX_OP_OR:
> -		__futex_atomic_op("orr	%w0, %w1, %w4",
> +		__futex_atomic_op("orr	%w3, %w1, %w4",
>  				  ret, oldval, uaddr, tmp, oparg);
>  		break;
>  	case FUTEX_OP_ANDN:
> -		__futex_atomic_op("and	%w0, %w1, %w4",
> +		__futex_atomic_op("and	%w3, %w1, %w4",
>  				  ret, oldval, uaddr, tmp, ~oparg);
>  		break;
>  	case FUTEX_OP_XOR:
> -		__futex_atomic_op("eor	%w0, %w1, %w4",
> +		__futex_atomic_op("eor	%w3, %w1, %w4",
>  				  ret, oldval, uaddr, tmp, oparg);
>  		break;
>  	default:
> 
>

This causes a (false) build warning with AOSP's GCC 4.9.4 (which is
used to build nearly all arm64 Android kernels before 4.14):

  CC      kernel/futex.o
../kernel/futex.c: In function 'do_futex':
../kernel/futex.c:1492:17: warning: 'oldval' may be used uninitialized in this function [-Wmaybe-uninitialized]
   return oldval == cmparg;
                 ^
In file included from ../kernel/futex.c:69:0:
../arch/arm64/include/asm/futex.h:56:6: note: 'oldval' was declared here
  int oldval, ret, tmp;
      ^

The only reason I bring this up is Qualcomm based kernels have a Python
script that emulates -Werror, meaning this will be fatal for a large
number of kernels, when this eventually gets merged into them.

Nathan
