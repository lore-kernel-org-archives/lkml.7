Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C99C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B16F218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ynQJ08oE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbfDXIpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:45:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59856 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfDXIpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KNLwmOQKFJyn50Vn9lGxwitkF38o6fhwSXB2kO96yfY=; b=ynQJ08oEAsTTkY5QImOENcAo/
        el+7t7D2yqBg5FfgiZMjyWo01DPAGp29JcJCZCedbSri3T9g6me0kDaNY/C+zZctc32wVQyLbk7K8
        98ScqbrgiMG+Uf0x6bPZHuvU8MQmq3QTTah1mGG2az1TiRO2PuttW5xhNUYE0NHe0frW9VnFm6vSf
        sMuWHg4XXDSNykn70lSEHPUppsAcOvrcWNjMdoLbT/lryqoCpzLy2cXyMKOLEfRweGGFeD6co4GYG
        UGa8BCtTy5asJnF2gBaWvXoaF+fXfx7/pnXlJhjq+I1JW2KmdwkPSlKwMapyf0cku665tDPAyeemN
        NGVjgeP8g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJDWA-0001Lt-0t; Wed, 24 Apr 2019 08:44:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5C76929BBFB9A; Wed, 24 Apr 2019 10:44:34 +0200 (CEST)
Date:   Wed, 24 Apr 2019 10:44:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Luc Maranget <luc.maranget@inria.fr>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] Documentation: atomic_t.txt: Explain ordering provided
 by smp_mb__{before,after}_atomic()
Message-ID: <20190424084434.GM12232@hirez.programming.kicks-ass.net>
References: <20190419180017.GP4038@hirez.programming.kicks-ass.net>
 <20190419182620.GF14111@linux.ibm.com>
 <1555719429.t9n8gkf70y.astroid@bobo.none>
 <20190420085440.GK14111@linux.ibm.com>
 <20190423121715.GQ4038@hirez.programming.kicks-ass.net>
 <20190423132116.GJ3923@linux.ibm.com>
 <20190423132620.GU4038@hirez.programming.kicks-ass.net>
 <20190423201637.GW3923@linux.ibm.com>
 <20190423202831.GA4038@hirez.programming.kicks-ass.net>
 <20190424082948.GG3923@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424082948.GG3923@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 01:29:48AM -0700, Paul E. McKenney wrote:
> On Tue, Apr 23, 2019 at 10:28:31PM +0200, Peter Zijlstra wrote:
> > On Tue, Apr 23, 2019 at 01:16:37PM -0700, Paul E. McKenney wrote:
> > 
> > > Agreed, but I thought that one of the ideas going forward was to get
> > > rid of smp_mb__{before,after}_atomic().
> > 
> > It's not one I had considered.. I just wanted to get rid of this
> > 'surprise' behaviour.
> 
> Ah, good point, your patch is in fact a midpoint between those two
> positions.  Just to make sure I understand:
> 
> 1.	Without your patch, smp_mb__{before,after}_atomic() orders
> 	only against the atomic itself.

Right, and that was not intentional.

> 2.	With your patch, smp_mb__{before,after}_atomic() orders against
> 	the atomic itself and the accesses on the other side of that
> 	atomic.  However, it does not order the atomic against the
> 	accesses on the other side of that atomic.

Right. I'll go make a more complete patch, covering all the
architectures.

> 	Putting things between the smp_mb__{before,after}_atomic()
> 	and the atomic is in my opinion a bad idea, but in this case
> 	they are not necessarily ordered.

Agreed, that is an unsupported idiom and it would be good to have
something check for this.

> 3.	Dispensing with smp_mb__{before,after}_atomic() would have
> 	void RMW atomics fully ordered, but I suspect that it results
> 	in ugly performance regressions.
> 
> Or am I still missing something?

I think we're good :-)
