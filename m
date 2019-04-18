Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB64C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FD720835
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jueuVe51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388292AbfDRIjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:39:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46158 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbfDRIjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 04:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GCH1Ie2FAiR4E7TcUxYt/w1UZeaMOIeWYYWNM0/YfYU=; b=jueuVe51fnF+TXNKdSIgpiotF
        +B/eo1pVYrOrCEpvIIUoBdjvZZJT+IBREPInUXNbZSWTr7hcZNKCrptodrIoe2cY3lMu9/lYs1h0I
        bVouDP8q8NhZ9gamvzH52zQQK5ViWZLlhlH274rhzd9lYGxutbOKAkeUy9lt3yBlYxci56cP19Gxv
        kLw5mv95ZBSSb504JoofH0/iCoy4zLYXxgCNGv17FGfzx93TUx3F7jR7iWThQYDMi7Cv1wj4xrAHH
        b39+mmr1Lrhy/c4VHcqj/lyZA7nItEXi6xe+r9TWRRAGjeULRZFsiWWoYVl4QjVv5zRw97cW5l2MN
        eDEE4J14A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hH2a5-00047p-Dc; Thu, 18 Apr 2019 08:39:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C34A029B98550; Thu, 18 Apr 2019 10:39:39 +0200 (CEST)
Date:   Thu, 18 Apr 2019 10:39:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v4 08/16] locking/rwsem: Make rwsem_spin_on_owner()
 return owner state
Message-ID: <20190418083939.GU12232@hirez.programming.kicks-ass.net>
References: <20190413172259.2740-1-longman@redhat.com>
 <20190413172259.2740-9-longman@redhat.com>
 <20190417124101.GE4038@hirez.programming.kicks-ass.net>
 <20190417124759.GT14281@hirez.programming.kicks-ass.net>
 <e9e3c08c-a153-ad38-059e-98b1b212e11f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9e3c08c-a153-ad38-059e-98b1b212e11f@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 02:29:02PM -0400, Waiman Long wrote:
> On 04/17/2019 08:47 AM, Peter Zijlstra wrote:
> >>
> >> enum owner_state {
> >> 	OWNER_NULL		= 1 << 0,
> >> 	OWNER_WRITER		= 1 << 1,
> >> 	OWNER_READER		= 1 << 2,
> >> 	OWNER_NONSPINNABLE	= 1 << 3,
> >> };
> >> #define OWNER_SPINNABLE		(OWNER_NULL | OWNER_WRITER)
> > Hmm, we should not spin on OWNER_NULL. Or at least not mixed in with the
> > patch that changes the shape of all this. That should go in the RT
> > thingy patch, which comes after this.
> 
> We do spin on OWNER_NULL right now, not in rwsem_spin_on_owner() but in
> the main rwsem_optimistic_spin() function.
> 
> RT task will quit if owner is NULL.

Yeah, I figured it out eventually :-)
