Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902BEC282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59EA1217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oODcq0td"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfDSWy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 18:54:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49702 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfDSWyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 18:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+otfAg4qacQS3U5b5PFlZngttTT3PUwwG1CQacAJdbo=; b=oODcq0tdxTFLxv3HxgoPAxTqS
        U7INU4DsThx4XCvUmwY225uFP3d9cYBVzc/c2Gn1//EViIRUDsSjlVHUbnn2ggpkLFg2eFst7vi9Z
        mFcTUUy9N+CDYqlSeYaBF1VXvNTe9e9E/QIh8t+2tedmhOSj5vbFQnwtTtPi3DQkTQlTrJoeJxFHh
        iWNh1a2VE5E9e+6d9pdA5mcF9K0nvvn3iVz1E0OVhj/5g0tkbzHuk/m9DvkiIjF2eBn3upc337deC
        5spavgDZvm24m95uS49vRqbgS3LZ8Wp2wPbFReQPlwEfh+ndGQQzQ1i2MIv1NSvEwzOdiegEM+9Q6
        EIz3Wla/A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hHTAY-0001aA-E7; Fri, 19 Apr 2019 13:03:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8A9EF29BF0BFC; Fri, 19 Apr 2019 15:03:04 +0200 (CEST)
Date:   Fri, 19 Apr 2019 15:03:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v4 14/16] locking/rwsem: Guard against making count
 negative
Message-ID: <20190419130304.GV14281@hirez.programming.kicks-ass.net>
References: <20190413172259.2740-1-longman@redhat.com>
 <20190413172259.2740-15-longman@redhat.com>
 <20190418135151.GB12232@hirez.programming.kicks-ass.net>
 <d931916b-41f5-f12d-8c38-0cccbc00a301@redhat.com>
 <20190418144036.GE12232@hirez.programming.kicks-ass.net>
 <4cbd3c18-c9c0-56eb-4e01-ee355a69057a@redhat.com>
 <20190419102647.GP7905@worktop.programming.kicks-ass.net>
 <20190419120207.GO4038@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419120207.GO4038@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 02:02:07PM +0200, Peter Zijlstra wrote:
> On Fri, Apr 19, 2019 at 12:26:47PM +0200, Peter Zijlstra wrote:
> > I thought of a horrible horrible alternative:
> 
> Hurm, that's broken as heck. Let me try again.

So I can't make that scheme work, it all ends up wanting to have
cmpxchg().

Do we have a performance comparison somewhere of xadd vs cmpxchg
readers? I tried looking in the old threads, but I can't seem to locate
it.

We need new instructions :/ Or more clever than I can muster just now.
