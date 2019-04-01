Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B660EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E302086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jCGcq6y6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfDAKxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:53:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38050 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfDAKxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IerMMB5v/hiF4zKHXWZLMMTyu1Q+MRKudWkdOjTlBG4=; b=jCGcq6y6ziFRMYFKva4ZZpDG+
        J3pbnRq+CC4Rfxnj/tBAMykBMPJe4qBdjksNaqBqPG29T7fVLhW+mu4I3OFGO930os0EH80u0FPBB
        BzOZo19Q+GonraEdoY+jCsF6alMUrUAsxrQUt2RV0OBQ7aWgdi8aAWm7xpOJkvl/sBly9RYWvk/cY
        YyblTLIl7E4CtiPjX8rhnBetdl9t3bW+MafChkXpGSpNxCg/lRwQAlMXy86Ds+ELGoUPUD+TVV8mm
        +QCLKtEjbUyN88WC9Tqrj2bVT84Biw87nO1/FwqZnZfTvRvxfbyhr9mOdGphBhzqOLDBwuSfAbBkJ
        Letm+M4EA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hAuZa-0008Lx-3u; Mon, 01 Apr 2019 10:53:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DA63B2026BE97; Mon,  1 Apr 2019 12:53:48 +0200 (CEST)
Date:   Mon, 1 Apr 2019 12:53:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Potapenko <glider@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitriy Vyukov <dvyukov@google.com>,
        James Y Knight <jyknight@google.com>
Subject: Re: Potentially missing "memory" clobbers in bitops.h for x86
Message-ID: <20190401105348.GL11158@hirez.programming.kicks-ass.net>
References: <CAG_fn=X9tpSW6jvJd_COk_RU8zvcr-cxSWuJ05qcV0LotTxEEQ@mail.gmail.com>
 <20190328162222.GO4102@linux.ibm.com>
 <CAG_fn=WKA_4Vzsh6yH+=5TFv-EMrX87pr+2c_ANoH_MOVpbe1w@mail.gmail.com>
 <8e32ab34-c14c-1ccb-76f9-0dcd729a0ef6@zytor.com>
 <20190329210918.GZ4102@linux.ibm.com>
 <8092b8aa-bb1c-0266-b308-5cebfb25e2ef@zytor.com>
 <20190329220554.GD4102@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329220554.GD4102@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 03:05:54PM -0700, Paul E. McKenney wrote:
> On Fri, Mar 29, 2019 at 02:51:26PM -0700, H. Peter Anvin wrote:
> > On 3/29/19 2:09 PM, Paul E. McKenney wrote:
> > >>
> > >> Note: the atomic versions of these functions obviously need to have
> > >> "volatile" and the clobber anyway, as they are by definition barriers
> > >> and moving memory operations around them would be a very serious error.
> > > 
> > > The atomic functions that return void don't need to order anything except
> > > the input and output arguments.  The oddness with clear_bit() is that the
> > > memory changed isn't necessarily the quantity referenced by the argument,
> > > if the number of bits specified is large.
> > > 
> > > So (for example) atomic_inc() does not need a "memory" clobber, right?

Correct, and many implementations do not, including x86:

static __always_inline void arch_atomic_inc(atomic_t *v)
{
	asm volatile(LOCK_PREFIX "incl %0"
		     : "+m" (v->counter));
}

> > I don't believe that is true: the code calling it has a reasonable
> > expectation that previous memory operations have finished and later
> > memory operations have not started from the point of view of another
> > processor. You are more of an expert on memory ordering than I am, but
> > I'm 89% sure that there is plenty of code in the kernel which makes that
> > assumption.
> 
> From Documentation/core-api/atomic_ops.rst:

We should delete that file.
