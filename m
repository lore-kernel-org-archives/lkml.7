Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F765C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C4E20675
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555481713;
	bh=NYmYPb5rXANrXuDpm3eVMdsi5lkxHXmC8jZN3r6YSLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P5L39R8nMgquLLwjzxkmW0V2ixP1Ibl/Tvnf2UlxFEkyGSw0awvFNJfu/gXPteyez
	 ZG8IgTy52g0yEmAWSYC49zOn4QRtzws1c689KNJv08ED8DEgXk4DW4gOFlGGFr+quW
	 7Aw26ZztVZx05EAeuTgTgXHKF48ZCyw7AbUCWZoo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbfDQGPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 02:15:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728650AbfDQGPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 02:15:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 445BE20675;
        Wed, 17 Apr 2019 06:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555481710;
        bh=NYmYPb5rXANrXuDpm3eVMdsi5lkxHXmC8jZN3r6YSLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TMDgfzX1ZAARb7t02dPZ5k436Ynzc/a8YCjX1TS3UnVoH+xZqplpSAwlXsxsmdecO
         s5O5fSfGhXBMtx34qFskaD92obhKumgEjQnE3M9ddZFqMXQrUEtMAo1TN3qJ5W2zit
         raM7mbU0fwpbckpGwpoSGhn7/DyDxoKfeJOoyMa4=
Date:   Wed, 17 Apr 2019 08:15:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        stable@kernel.org, Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 4.9 72/76] arm64: futex: Fix FUTEX_WAKE_OP atomic ops
 with non-zero result value
Message-ID: <20190417061508.GB18320@kroah.com>
References: <20190415183707.712011689@linuxfoundation.org>
 <20190415183729.170980546@linuxfoundation.org>
 <20190415220151.GA23056@archlinux-i9>
 <20190416090052.GD4209@kroah.com>
 <20190416164751.GA25801@archlinux-i9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416164751.GA25801@archlinux-i9>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 09:47:51AM -0700, Nathan Chancellor wrote:
> On Tue, Apr 16, 2019 at 11:00:52AM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Apr 15, 2019 at 03:01:51PM -0700, Nathan Chancellor wrote:
> > > On Mon, Apr 15, 2019 at 08:44:36PM +0200, Greg Kroah-Hartman wrote:
> > > > From: Will Deacon <will.deacon@arm.com>
> > > > 
> > > > commit 045afc24124d80c6998d9c770844c67912083506 upstream.
> > > > 
> > > > Rather embarrassingly, our futex() FUTEX_WAKE_OP implementation doesn't
> > > > explicitly set the return value on the non-faulting path and instead
> > > > leaves it holding the result of the underlying atomic operation. This
> > > > means that any FUTEX_WAKE_OP atomic operation which computes a non-zero
> > > > value will be reported as having failed. Regrettably, I wrote the buggy
> > > > code back in 2011 and it was upstreamed as part of the initial arm64
> > > > support in 2012.
> > > > 
> > > > The reasons we appear to get away with this are:
> > > > 
> > > >   1. FUTEX_WAKE_OP is rarely used and therefore doesn't appear to get
> > > >      exercised by futex() test applications
> > > > 
> > > >   2. If the result of the atomic operation is zero, the system call
> > > >      behaves correctly
> > > > 
> > > >   3. Prior to version 2.25, the only operation used by GLIBC set the
> > > >      futex to zero, and therefore worked as expected. From 2.25 onwards,
> > > >      FUTEX_WAKE_OP is not used by GLIBC at all.
> > > > 
> > > > Fix the implementation by ensuring that the return value is either 0
> > > > to indicate that the atomic operation completed successfully, or -EFAULT
> > > > if we encountered a fault when accessing the user mapping.
> > > > 
> > > > Cc: <stable@kernel.org>
> > > > Fixes: 6170a97460db ("arm64: Atomic operations")
> > > > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > 
> > > > ---
> > > >  arch/arm64/include/asm/futex.h |   16 ++++++++--------
> > > >  1 file changed, 8 insertions(+), 8 deletions(-)
> > > > 
> > > > --- a/arch/arm64/include/asm/futex.h
> > > > +++ b/arch/arm64/include/asm/futex.h
> > > > @@ -33,8 +33,8 @@
> > > >  "	prfm	pstl1strm, %2\n"					\
> > > >  "1:	ldxr	%w1, %2\n"						\
> > > >  	insn "\n"							\
> > > > -"2:	stlxr	%w3, %w0, %2\n"						\
> > > > -"	cbnz	%w3, 1b\n"						\
> > > > +"2:	stlxr	%w0, %w3, %2\n"						\
> > > > +"	cbnz	%w0, 1b\n"						\
> > > >  "	dmb	ish\n"							\
> > > >  "3:\n"									\
> > > >  "	.pushsection .fixup,\"ax\"\n"					\
> > > > @@ -53,29 +53,29 @@
> > > >  static inline int
> > > >  arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
> > > >  {
> > > > -	int oldval = 0, ret, tmp;
> > > > +	int oldval, ret, tmp;
> > > >  
> > > >  	pagefault_disable();
> > > >  
> > > >  	switch (op) {
> > > >  	case FUTEX_OP_SET:
> > > > -		__futex_atomic_op("mov	%w0, %w4",
> > > > +		__futex_atomic_op("mov	%w3, %w4",
> > > >  				  ret, oldval, uaddr, tmp, oparg);
> > > >  		break;
> > > >  	case FUTEX_OP_ADD:
> > > > -		__futex_atomic_op("add	%w0, %w1, %w4",
> > > > +		__futex_atomic_op("add	%w3, %w1, %w4",
> > > >  				  ret, oldval, uaddr, tmp, oparg);
> > > >  		break;
> > > >  	case FUTEX_OP_OR:
> > > > -		__futex_atomic_op("orr	%w0, %w1, %w4",
> > > > +		__futex_atomic_op("orr	%w3, %w1, %w4",
> > > >  				  ret, oldval, uaddr, tmp, oparg);
> > > >  		break;
> > > >  	case FUTEX_OP_ANDN:
> > > > -		__futex_atomic_op("and	%w0, %w1, %w4",
> > > > +		__futex_atomic_op("and	%w3, %w1, %w4",
> > > >  				  ret, oldval, uaddr, tmp, ~oparg);
> > > >  		break;
> > > >  	case FUTEX_OP_XOR:
> > > > -		__futex_atomic_op("eor	%w0, %w1, %w4",
> > > > +		__futex_atomic_op("eor	%w3, %w1, %w4",
> > > >  				  ret, oldval, uaddr, tmp, oparg);
> > > >  		break;
> > > >  	default:
> > > > 
> > > >
> > > 
> > > This causes a (false) build warning with AOSP's GCC 4.9.4 (which is
> > > used to build nearly all arm64 Android kernels before 4.14):
> > > 
> > >   CC      kernel/futex.o
> > > ../kernel/futex.c: In function 'do_futex':
> > > ../kernel/futex.c:1492:17: warning: 'oldval' may be used uninitialized in this function [-Wmaybe-uninitialized]
> > >    return oldval == cmparg;
> > >                  ^
> > > In file included from ../kernel/futex.c:69:0:
> > > ../arch/arm64/include/asm/futex.h:56:6: note: 'oldval' was declared here
> > >   int oldval, ret, tmp;
> > >       ^
> > > 
> > > The only reason I bring this up is Qualcomm based kernels have a Python
> > > script that emulates -Werror, meaning this will be fatal for a large
> > > number of kernels, when this eventually gets merged into them.
> > 
> > Argh, really?  That's a buggy compiler that you have there, as oldval
> > will be set correctly if all is good, and if not, ret will be and the
> > code will error out.
> > 
> 
> Correct.
> 
> > Working around broken compilers is not something I really like doing :(
> > 
> 
> Indeed, I wouldn't have brought it up if it wasn't the compiler for all
> Android 4.9 kernels aside from the Pixel 3 (XL).
> 
> > That being said, does this also show up in the 4.19.y and 5.0.y tree
> > right now?  If not, why not?
> > 
> 
> It does.
> 
> $ make ARCH=arm64 CROSS_COMPILE=<path>/bin/aarch64-linux-gnu- defconfig kernel/futex.o

Great, so it seems this needs to be fixed in Linus's tree first, before
I can backport it everywhere.

Want me to send a patch for this or can you?

thanks,

greg k-h
