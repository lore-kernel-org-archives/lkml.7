Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC3DC282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E665217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556178671;
	bh=eyoA9f5KSWXXOxyCVzYG0+MmbJplAk7EfBbWO5NHoGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BGtdiyFhI26MSE5UDFk9TdPyKyQ1MuzYH9QnChHnTGUnH+uMkiGS3M2KXU3U8ElNQ
	 hDBieZqFITxu0W0xcSRGiL4G2sEfg19+SY9vml5v/mNWcRNOCOI3zmobGRdudl/SeY
	 8ot74RSOJs/SGa7FjMCA2QD2tdqP/kOJXmf2x+5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfDYHvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:51:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727433AbfDYHvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:51:09 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 942F2217D7;
        Thu, 25 Apr 2019 07:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556178668;
        bh=eyoA9f5KSWXXOxyCVzYG0+MmbJplAk7EfBbWO5NHoGg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h3LU9Lk5VqAuuTt6b1EW8JVIQZpiiw8LLwkDsDZrXR2CTJRZxF9u5/6DZpyHI/pue
         V1vwsL0M9UVVitjDTTaU8e5Wb1uKc/Ari70d3A/wiWjbFuysBnfdBnRHwk62kqvO8+
         oN5hvftZDVb0jViZjdYNVyolCKow/CrufM1yP9jY=
Date:   Thu, 25 Apr 2019 09:51:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        stable@kernel.org, Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 3.18 055/104] arm64: futex: Fix FUTEX_WAKE_OP atomic ops
 with non-zero result value
Message-ID: <20190425075105.GA7481@kroah.com>
References: <20190424170839.996641496@linuxfoundation.org>
 <20190424170902.623665551@linuxfoundation.org>
 <20190424173520.GA13727@archlinux-i9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424173520.GA13727@archlinux-i9>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 10:35:20AM -0700, Nathan Chancellor wrote:
> Hi Greg,
> 
> On Wed, Apr 24, 2019 at 07:09:12PM +0200, Greg Kroah-Hartman wrote:
> > From: Will Deacon <will.deacon@arm.com>
> > 
> > commit 045afc24124d80c6998d9c770844c67912083506 upstream.
> > 
> > Rather embarrassingly, our futex() FUTEX_WAKE_OP implementation doesn't
> > explicitly set the return value on the non-faulting path and instead
> > leaves it holding the result of the underlying atomic operation. This
> > means that any FUTEX_WAKE_OP atomic operation which computes a non-zero
> > value will be reported as having failed. Regrettably, I wrote the buggy
> > code back in 2011 and it was upstreamed as part of the initial arm64
> > support in 2012.
> > 
> > The reasons we appear to get away with this are:
> > 
> >   1. FUTEX_WAKE_OP is rarely used and therefore doesn't appear to get
> >      exercised by futex() test applications
> > 
> >   2. If the result of the atomic operation is zero, the system call
> >      behaves correctly
> > 
> >   3. Prior to version 2.25, the only operation used by GLIBC set the
> >      futex to zero, and therefore worked as expected. From 2.25 onwards,
> >      FUTEX_WAKE_OP is not used by GLIBC at all.
> > 
> > Fix the implementation by ensuring that the return value is either 0
> > to indicate that the atomic operation completed successfully, or -EFAULT
> > if we encountered a fault when accessing the user mapping.
> > 
> > Cc: <stable@kernel.org>
> > Fixes: 6170a97460db ("arm64: Atomic operations")
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > ---
> >  arch/arm64/include/asm/futex.h |   16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> > 
> > --- a/arch/arm64/include/asm/futex.h
> > +++ b/arch/arm64/include/asm/futex.h
> > @@ -26,8 +26,8 @@
> >  	asm volatile(							\
> >  "1:	ldxr	%w1, %2\n"						\
> >  	insn "\n"							\
> > -"2:	stlxr	%w3, %w0, %2\n"						\
> > -"	cbnz	%w3, 1b\n"						\
> > +"2:	stlxr	%w0, %w3, %2\n"						\
> > +"	cbnz	%w0, 1b\n"						\
> >  "	dmb	ish\n"							\
> >  "3:\n"									\
> >  "	.pushsection .fixup,\"ax\"\n"					\
> > @@ -50,7 +50,7 @@ futex_atomic_op_inuser(unsigned int enco
> >  	int cmp = (encoded_op >> 24) & 15;
> >  	int oparg = (int)(encoded_op << 8) >> 20;
> >  	int cmparg = (int)(encoded_op << 20) >> 20;
> > -	int oldval = 0, ret, tmp;
> > +	int oldval, ret, tmp;
> 
> Please ensure the follow up fix gets queued up for 3.18 as well
> (backport attached).

Ugh, I forgot it, thanks for the backport, now queued up.

greg k-h
