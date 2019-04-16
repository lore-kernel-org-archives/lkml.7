Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149C6C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C5C20675
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbfDPJNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 05:13:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50106 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbfDPJNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 05:13:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FE8AEBD;
        Tue, 16 Apr 2019 02:13:46 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F62C3F68F;
        Tue, 16 Apr 2019 02:13:44 -0700 (PDT)
Date:   Tue, 16 Apr 2019 10:13:40 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        stable@kernel.org
Subject: Re: [PATCH 4.9 72/76] arm64: futex: Fix FUTEX_WAKE_OP atomic ops
 with non-zero result value
Message-ID: <20190416091340.GA31579@fuggles.cambridge.arm.com>
References: <20190415183707.712011689@linuxfoundation.org>
 <20190415183729.170980546@linuxfoundation.org>
 <20190415220151.GA23056@archlinux-i9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415220151.GA23056@archlinux-i9>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 03:01:51PM -0700, Nathan Chancellor wrote:
> On Mon, Apr 15, 2019 at 08:44:36PM +0200, Greg Kroah-Hartman wrote:
> > From: Will Deacon <will.deacon@arm.com>

[...]

> > @@ -53,29 +53,29 @@
> >  static inline int
> >  arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
> >  {
> > -	int oldval = 0, ret, tmp;
> > +	int oldval, ret, tmp;
> >  
> >  	pagefault_disable();
> >  
> >  	switch (op) {
> >  	case FUTEX_OP_SET:
> > -		__futex_atomic_op("mov	%w0, %w4",
> > +		__futex_atomic_op("mov	%w3, %w4",
> >  				  ret, oldval, uaddr, tmp, oparg);
> >  		break;
> >  	case FUTEX_OP_ADD:
> > -		__futex_atomic_op("add	%w0, %w1, %w4",
> > +		__futex_atomic_op("add	%w3, %w1, %w4",
> >  				  ret, oldval, uaddr, tmp, oparg);
> >  		break;
> >  	case FUTEX_OP_OR:
> > -		__futex_atomic_op("orr	%w0, %w1, %w4",
> > +		__futex_atomic_op("orr	%w3, %w1, %w4",
> >  				  ret, oldval, uaddr, tmp, oparg);
> >  		break;
> >  	case FUTEX_OP_ANDN:
> > -		__futex_atomic_op("and	%w0, %w1, %w4",
> > +		__futex_atomic_op("and	%w3, %w1, %w4",
> >  				  ret, oldval, uaddr, tmp, ~oparg);
> >  		break;
> >  	case FUTEX_OP_XOR:
> > -		__futex_atomic_op("eor	%w0, %w1, %w4",
> > +		__futex_atomic_op("eor	%w3, %w1, %w4",
> >  				  ret, oldval, uaddr, tmp, oparg);
> >  		break;
> >  	default:
> > 
> >
> 
> This causes a (false) build warning with AOSP's GCC 4.9.4 (which is
> used to build nearly all arm64 Android kernels before 4.14):
> 
>   CC      kernel/futex.o
> ../kernel/futex.c: In function 'do_futex':
> ../kernel/futex.c:1492:17: warning: 'oldval' may be used uninitialized in this function [-Wmaybe-uninitialized]
>    return oldval == cmparg;
>                  ^
> In file included from ../kernel/futex.c:69:0:
> ../arch/arm64/include/asm/futex.h:56:6: note: 'oldval' was declared here
>   int oldval, ret, tmp;
>       ^
> 
> The only reason I bring this up is Qualcomm based kernels have a Python
> script that emulates -Werror, meaning this will be fatal for a large
> number of kernels, when this eventually gets merged into them.

Thanks. Does restoring the initial assignment of 0 suppress the bogus
warning? If so, please could you send a patch on top for stable (assuming
Greg is ok with the simple change for this)?

Will
