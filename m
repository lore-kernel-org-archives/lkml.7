Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC15C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B189B20830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387905AbfDARnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:43:02 -0400
Received: from smtprelay0115.hostedemail.com ([216.40.44.115]:57318 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387538AbfDARm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:42:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 5C4C5837F24C;
        Mon,  1 Apr 2019 17:42:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: flock74_537ecc453f420
X-Filterd-Recvd-Size: 4675
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Mon,  1 Apr 2019 17:42:53 +0000 (UTC)
Message-ID: <d153fa8079c3e49e1ad35a54c400298ba51184e3.camel@perches.com>
Subject: Re: [PATCH 4.4 034/131] lib/int_sqrt: optimize small argument
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Anshul Garg <aksgarg1989@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        David Miller <davem@davemloft.net>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Kees Cook <keescook@chromium.org>,
        Michael Davidson <md@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 01 Apr 2019 10:42:52 -0700
In-Reply-To: <20190401170055.035782875@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
         <20190401170055.035782875@linuxfoundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-04-01 at 19:01 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.

If this is to be ported just for an optimization
(which I think is dubious as it's not a bug fix),
why not port the __fls optimization too?

__fls has a bigger effect on performance.

------------------
> 
> From: Peter Zijlstra <peterz@infradead.org>
> 
> commit 3f3295709edea6268ff1609855f498035286af73 upstream.
> 
> The current int_sqrt() computation is sub-optimal for the case of small
> @x.  Which is the interesting case when we're going to do cumulative
> distribution functions on idle times, which we assume to be a random
> variable, where the target residency of the deepest idle state gives an
> upper bound on the variable (5e6ns on recent Intel chips).
> 
> In the case of small @x, the compute loop:
> 
> 	while (m != 0) {
> 		b = y + m;
> 		y >>= 1;
> 
> 		if (x >= b) {
> 			x -= b;
> 			y += m;
> 		}
> 		m >>= 2;
> 	}
> 
> can be reduced to:
> 
> 	while (m > x)
> 		m >>= 2;
> 
> Because y==0, b==m and until x>=m y will remain 0.
> 
> And while this is computationally equivalent, it runs much faster
> because there's less code, in particular less branches.
> 
>       cycles:                 branches:              branch-misses:
> 
> OLD:
> 
> hot:   45.109444 +- 0.044117  44.333392 +- 0.002254  0.018723 +- 0.000593
> cold: 187.737379 +- 0.156678  44.333407 +- 0.002254  6.272844 +- 0.004305
> 
> PRE:
> 
> hot:   67.937492 +- 0.064124  66.999535 +- 0.000488  0.066720 +- 0.001113
> cold: 232.004379 +- 0.332811  66.999527 +- 0.000488  6.914634 +- 0.006568
> 
> POST:
> 
> hot:   43.633557 +- 0.034373  45.333132 +- 0.002277  0.023529 +- 0.000681
> cold: 207.438411 +- 0.125840  45.333132 +- 0.002277  6.976486 +- 0.004219
> 
> Averages computed over all values <128k using a LFSR to generate order.
> Cold numbers have a LFSR based branch trace buffer 'confuser' ran between
> each int_sqrt() invocation.
> 
> Link: http://lkml.kernel.org/r/20171020164644.876503355@infradead.org
> Fixes: 30493cc9dddb ("lib/int_sqrt.c: optimize square root algorithm")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Suggested-by: Anshul Garg <aksgarg1989@gmail.com>
> Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: David Miller <davem@davemloft.net>
> Cc: Matthew Wilcox <mawilcox@microsoft.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Michael Davidson <md@google.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
>  lib/int_sqrt.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> --- a/lib/int_sqrt.c
> +++ b/lib/int_sqrt.c
> @@ -22,6 +22,9 @@ unsigned long int_sqrt(unsigned long x)
>  		return x;
>  
>  	m = 1UL << (BITS_PER_LONG - 2);
> +	while (m > x)
> +		m >>= 2;
> +
>  	while (m != 0) {
>  		b = y + m;
>  		y >>= 1;
> 
> 

