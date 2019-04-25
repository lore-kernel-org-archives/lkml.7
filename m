Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A106C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA140218AD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3kRAaV2g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbfDYG7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 02:59:49 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47258 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfDYG7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 02:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7SBdbneTIvlthhDhg6TpFypFUS7+gOMvyzOHEIcI3nc=; b=3kRAaV2gxYu2GzuzIzRUU/xjJ
        mbLxblsafMZZXtjyP64G0UJ8HEE8ASi7/DFavQceu3cX3Mg8ck+jY1HOjPfo0lttqkDI8T8KGgCh7
        oZ8gC5fE6D1iQFye1WrxtGajJeC69R09VBJgQQ5yzWpX/hIGpY9l547N8+Ltoc//WA9mVQGeu4BNN
        B5v/19vS/MICl/jBC3RQmTUIzj2uCb2QZqJHFfaN+Qz+tj+UXJHm+pQGQTmyhAN45SEvP6PHqDQ+9
        FWbbhQUyVNeXLXrluUd8ubuA/d99ikN5PFaN8gb96+7NRwHIXst7WlUWD4LNJ7xADlY1vCdwpwA4B
        dFPZiTcRA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJYLu-0008Qg-2d; Thu, 25 Apr 2019 06:59:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5407B20D0A201; Thu, 25 Apr 2019 08:59:23 +0200 (CEST)
Date:   Thu, 25 Apr 2019 08:59:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Paul Burton <paul.burton@mips.com>
Cc:     "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "andrea.parri@amarulasolutions.com" 
        <andrea.parri@amarulasolutions.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 1/5] mips/atomic: Fix cmpxchg64 barriers
Message-ID: <20190425065923.GT11158@hirez.programming.kicks-ass.net>
References: <20190424123656.484227701@infradead.org>
 <20190424124421.579563933@infradead.org>
 <20190424210019.knq4nijg3xoqxzhg@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424210019.knq4nijg3xoqxzhg@pburton-laptop>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 09:00:25PM +0000, Paul Burton wrote:
> Hi Peter,
> 
> On Wed, Apr 24, 2019 at 02:36:57PM +0200, Peter Zijlstra wrote:
> > There were no memory barriers on cmpxchg64() _at_all_. Fix this.
> 
> This does looks problematic, but it's worth noting that this code path
> is only applicable to 32b kernels running on 64b CPUs which is pretty
> rare. The commit message as-is suggests to me that all configurations
> are broken, which isn't the case (at least, not in this respect :) ).

OK, I hadn't gone through the ifdef selection process. I just
encountered this cmpxchg implementation and noted a significant lack of
barriers.

> > 
> > Cc: Paul Burton <paul.burton@mips.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/mips/include/asm/cmpxchg.h |    6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > --- a/arch/mips/include/asm/cmpxchg.h
> > +++ b/arch/mips/include/asm/cmpxchg.h
> > @@ -290,9 +290,11 @@ static inline unsigned long __cmpxchg64(
> >  	 * will cause a build error unless cpu_has_64bits is a		\
> >  	 * compile-time constant 1.					\
> >  	 */								\
> > -	if (cpu_has_64bits && kernel_uses_llsc)				\
> > +	if (cpu_has_64bits && kernel_uses_llsc) {			\
> > +		smp_mb__before_llsc();					\
> >  		__res = __cmpxchg64((ptr), __old, __new);		\
> > -	else								\
> > +		smp_llsc_mb();						\
> > +	} else								\
> >  		__res = __cmpxchg64_unsupported();			\
> 
> It would be good to also add braces around the else block, and I believe
> checkpatch should be complaining about that ("braces {} should be used
> on all arms of this statement").

You're right, I'll fix up.
