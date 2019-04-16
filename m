Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7A7C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60063206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u3YzQ7Vj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbfDPQr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:47:57 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40386 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfDPQr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:47:57 -0400
Received: by mail-ed1-f66.google.com with SMTP id d46so13690580eda.7;
        Tue, 16 Apr 2019 09:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZbeA4skiXNxO1iYF0snjEHkfBR0nml9mqhKeCLbw2NI=;
        b=u3YzQ7VjuUhA+ihj/tBV05JuV+DIrpX7tszf6cQQVUk1RCxWvxFzer4AyGTZMEyTER
         EzOM1qO4ce6h5NgbhyrwkI82YmV2ajU+M5UtmBTE97oX/O/xidof09knZMj7yUOR9uQx
         x4OdG/cYpKqTWYIQ5DMAdW78sYXJl45m2ZVsVjoDwmipDhPIpRcaQPZ0pwVr0XUYbFgw
         D11tA7GGUN0mNITUl36sCmUq0he0zyM63VbvYWYz2/7qH57eHit2bDXWiQrqJh3eR07P
         nVlW8C35EqroC2DuFnGnh17jLPwx3q5za42G1bdjQCHpt6ZYps173UQ/I1cepsutKWtZ
         TE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZbeA4skiXNxO1iYF0snjEHkfBR0nml9mqhKeCLbw2NI=;
        b=Ld5IFkY66Rzdc8AkBhKtB6+0HkJpj2GkwOlgk3DZuAz2FMg0PdGgwnZvIPy1aZYo3A
         3s0dMrJN8d3pXfm1mb4KhkMG8Z3BVMkJ92OsKO9IHsW2UeawNI9dtE/6gTeSHVu9sEo7
         teff4goaNNBuiODjyEhK2LQGjq89neTKKKR4IkvjFZ6vEqQlL8dsTS2B8X9yvvLz7OmH
         1UwyKOsTml+UBQZSI/z+RaUer/Rg+ESjMpGp5fCNp5KTTcKc5YS+FX5FfTxyODMoOY+a
         nMZDceM5pc8Irv6US8ZeUziojsOAnRW/HzD9EJDTe3ZlhfqWxRbzFmJyyThwuon9I1gU
         4cyA==
X-Gm-Message-State: APjAAAXYs+tbsgjd7vLP9cHEs+atI72c/kgFgAjy5R77Z1e9IoUr3Cd0
        s8d9Dh1A3OfWPKZuLOgthGE=
X-Google-Smtp-Source: APXvYqwXBz8b+g3OQY4ABMTSG8vvvO8CKGMQIZ7SC30Nl4v3l+igwznD1AsqsnLvmuO6NSW2npypsg==
X-Received: by 2002:a50:b4c9:: with SMTP id x9mr51827673edd.132.1555433274278;
        Tue, 16 Apr 2019 09:47:54 -0700 (PDT)
Received: from archlinux-i9 ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id j11sm7547256edk.9.2019.04.16.09.47.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Apr 2019 09:47:53 -0700 (PDT)
Date:   Tue, 16 Apr 2019 09:47:51 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        stable@kernel.org, Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 4.9 72/76] arm64: futex: Fix FUTEX_WAKE_OP atomic ops
 with non-zero result value
Message-ID: <20190416164751.GA25801@archlinux-i9>
References: <20190415183707.712011689@linuxfoundation.org>
 <20190415183729.170980546@linuxfoundation.org>
 <20190415220151.GA23056@archlinux-i9>
 <20190416090052.GD4209@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416090052.GD4209@kroah.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 11:00:52AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Apr 15, 2019 at 03:01:51PM -0700, Nathan Chancellor wrote:
> > On Mon, Apr 15, 2019 at 08:44:36PM +0200, Greg Kroah-Hartman wrote:
> > > From: Will Deacon <will.deacon@arm.com>
> > > 
> > > commit 045afc24124d80c6998d9c770844c67912083506 upstream.
> > > 
> > > Rather embarrassingly, our futex() FUTEX_WAKE_OP implementation doesn't
> > > explicitly set the return value on the non-faulting path and instead
> > > leaves it holding the result of the underlying atomic operation. This
> > > means that any FUTEX_WAKE_OP atomic operation which computes a non-zero
> > > value will be reported as having failed. Regrettably, I wrote the buggy
> > > code back in 2011 and it was upstreamed as part of the initial arm64
> > > support in 2012.
> > > 
> > > The reasons we appear to get away with this are:
> > > 
> > >   1. FUTEX_WAKE_OP is rarely used and therefore doesn't appear to get
> > >      exercised by futex() test applications
> > > 
> > >   2. If the result of the atomic operation is zero, the system call
> > >      behaves correctly
> > > 
> > >   3. Prior to version 2.25, the only operation used by GLIBC set the
> > >      futex to zero, and therefore worked as expected. From 2.25 onwards,
> > >      FUTEX_WAKE_OP is not used by GLIBC at all.
> > > 
> > > Fix the implementation by ensuring that the return value is either 0
> > > to indicate that the atomic operation completed successfully, or -EFAULT
> > > if we encountered a fault when accessing the user mapping.
> > > 
> > > Cc: <stable@kernel.org>
> > > Fixes: 6170a97460db ("arm64: Atomic operations")
> > > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > 
> > > ---
> > >  arch/arm64/include/asm/futex.h |   16 ++++++++--------
> > >  1 file changed, 8 insertions(+), 8 deletions(-)
> > > 
> > > --- a/arch/arm64/include/asm/futex.h
> > > +++ b/arch/arm64/include/asm/futex.h
> > > @@ -33,8 +33,8 @@
> > >  "	prfm	pstl1strm, %2\n"					\
> > >  "1:	ldxr	%w1, %2\n"						\
> > >  	insn "\n"							\
> > > -"2:	stlxr	%w3, %w0, %2\n"						\
> > > -"	cbnz	%w3, 1b\n"						\
> > > +"2:	stlxr	%w0, %w3, %2\n"						\
> > > +"	cbnz	%w0, 1b\n"						\
> > >  "	dmb	ish\n"							\
> > >  "3:\n"									\
> > >  "	.pushsection .fixup,\"ax\"\n"					\
> > > @@ -53,29 +53,29 @@
> > >  static inline int
> > >  arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
> > >  {
> > > -	int oldval = 0, ret, tmp;
> > > +	int oldval, ret, tmp;
> > >  
> > >  	pagefault_disable();
> > >  
> > >  	switch (op) {
> > >  	case FUTEX_OP_SET:
> > > -		__futex_atomic_op("mov	%w0, %w4",
> > > +		__futex_atomic_op("mov	%w3, %w4",
> > >  				  ret, oldval, uaddr, tmp, oparg);
> > >  		break;
> > >  	case FUTEX_OP_ADD:
> > > -		__futex_atomic_op("add	%w0, %w1, %w4",
> > > +		__futex_atomic_op("add	%w3, %w1, %w4",
> > >  				  ret, oldval, uaddr, tmp, oparg);
> > >  		break;
> > >  	case FUTEX_OP_OR:
> > > -		__futex_atomic_op("orr	%w0, %w1, %w4",
> > > +		__futex_atomic_op("orr	%w3, %w1, %w4",
> > >  				  ret, oldval, uaddr, tmp, oparg);
> > >  		break;
> > >  	case FUTEX_OP_ANDN:
> > > -		__futex_atomic_op("and	%w0, %w1, %w4",
> > > +		__futex_atomic_op("and	%w3, %w1, %w4",
> > >  				  ret, oldval, uaddr, tmp, ~oparg);
> > >  		break;
> > >  	case FUTEX_OP_XOR:
> > > -		__futex_atomic_op("eor	%w0, %w1, %w4",
> > > +		__futex_atomic_op("eor	%w3, %w1, %w4",
> > >  				  ret, oldval, uaddr, tmp, oparg);
> > >  		break;
> > >  	default:
> > > 
> > >
> > 
> > This causes a (false) build warning with AOSP's GCC 4.9.4 (which is
> > used to build nearly all arm64 Android kernels before 4.14):
> > 
> >   CC      kernel/futex.o
> > ../kernel/futex.c: In function 'do_futex':
> > ../kernel/futex.c:1492:17: warning: 'oldval' may be used uninitialized in this function [-Wmaybe-uninitialized]
> >    return oldval == cmparg;
> >                  ^
> > In file included from ../kernel/futex.c:69:0:
> > ../arch/arm64/include/asm/futex.h:56:6: note: 'oldval' was declared here
> >   int oldval, ret, tmp;
> >       ^
> > 
> > The only reason I bring this up is Qualcomm based kernels have a Python
> > script that emulates -Werror, meaning this will be fatal for a large
> > number of kernels, when this eventually gets merged into them.
> 
> Argh, really?  That's a buggy compiler that you have there, as oldval
> will be set correctly if all is good, and if not, ret will be and the
> code will error out.
> 

Correct.

> Working around broken compilers is not something I really like doing :(
> 

Indeed, I wouldn't have brought it up if it wasn't the compiler for all
Android 4.9 kernels aside from the Pixel 3 (XL).

> That being said, does this also show up in the 4.19.y and 5.0.y tree
> right now?  If not, why not?
> 

It does.

$ make ARCH=arm64 CROSS_COMPILE=<path>/bin/aarch64-linux-gnu- defconfig kernel/futex.o

> thanks,
> 
> greg k-h
