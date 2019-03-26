Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFEAC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00BBE20848
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553564177;
	bh=TFx0oLPulbQzVZaLavrifA9raXpTGOpN5q1N9OpsvSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rAJD6CutOZm1GCYP3vgFn1UM9PHkOJKth2OX6S+GVirC0lRtyy8HxTS9sahZ3b2b5
	 P0wIJ8vV0hZyVdb/+AKtUhV4EReyAw3vfa2KiRhW3HG3nRL36CkMuc2zPuuL/3OHpJ
	 /iYLItwjpVNaUew4EQ5AICJxxLXtvCkkEDYv4ndw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730728AbfCZBgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 21:36:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbfCZBgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 21:36:15 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 544AC2075D;
        Tue, 26 Mar 2019 01:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553564174;
        bh=TFx0oLPulbQzVZaLavrifA9raXpTGOpN5q1N9OpsvSw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CoMdTXwu12Kl3wWpS//JPvxgZVcFlI54l9z3ukVv+lnyKSzvJ6nL4k7W5wp0frYB1
         F7TMW0RZC7+hzcKlxa4I5lrL1Uhal8qiz6B8R1OYFnBpT37DxD64ro5HdwMcwLUOBb
         wPnI8uP+Gl/DEgfS6twuFSGjMoT7qXmaYhlSuT1w=
Date:   Tue, 26 Mar 2019 10:36:07 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     stable@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Florian La Roche <florian.laroche@googlemail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Anshul Garg <aksgarg1989@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Joe Perches <joe@perches.com>,
        David Miller <davem@davemloft.net>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Kees Cook <keescook@chromium.org>,
        Michael Davidson <md@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [BACKPORT 4.4.y 24/25] lib/int_sqrt: optimize small argument
Message-ID: <20190326013607.GD21198@kroah.com>
References: <20190322154425.3852517-1-arnd@arndb.de>
 <20190322154425.3852517-25-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322154425.3852517-25-arnd@arndb.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 04:44:15PM +0100, Arnd Bergmann wrote:
> From: Peter Zijlstra <peterz@infradead.org>
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
> (cherry picked from commit 3f3295709edea6268ff1609855f498035286af73)
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  lib/int_sqrt.c | 3 +++
>  1 file changed, 3 insertions(+)

Also added to 4.14.y and 4.9.y
