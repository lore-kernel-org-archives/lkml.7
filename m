Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB8BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D582077C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OePZTCgl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbfDXNUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:20:19 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34914 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729315AbfDXNUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ut/AT5NZIvtj4Y0/qt7/Ac2TRDj3IJ2+OkiJo7N7EIM=; b=OePZTCglximpG/ZiJ0hTxlF54
        6/Z3ukz4p4TTpYMb99FexnNzEKTYpzELUZt9gTYt7NhgcyYif5sV5o+sUAsNK7vaMSddJLuQMOngG
        fZ05H3HwtYrAXkpo6N6IJPI/Y+fhlkqAabD0adg6biG1fHZ531zz4/7MqD60yRu+/E6CjAg9R78hf
        /AEEUzSF+5iMWJ1DniXZKcZ26Txyg3X89BkgB9z8QtZyKfD9T3+QLFjx+V6QgP242dqslIspy8UEh
        C1fwDsy64UrJWmw3EJImP2Rvx5EhRlUNx3IFJhfgQm07q3qqcTOPEQHQOVHiJOGNF+uEIUagdjXRc
        4+ezh6JNw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJHoa-0003Tq-4J; Wed, 24 Apr 2019 13:19:56 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 95BA029BD4886; Wed, 24 Apr 2019 15:19:54 +0200 (CEST)
Date:   Wed, 24 Apr 2019 15:19:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH] bpf: Fix preempt_enable_no_resched() abuse
Message-ID: <20190424131954.GZ14281@hirez.programming.kicks-ass.net>
References: <57620139-92a3-4a21-56bd-5d6fff23214f@redhat.com>
 <7b1bfc26-6e90-bd65-ab46-08413acd80e9@redhat.com>
 <20190423141714.GO11158@hirez.programming.kicks-ass.net>
 <CAHk-=whnQJ9YDrkcKteNSACMJxzw1bL0RPfGQsey_9Nm7b8mnw@mail.gmail.com>
 <4f62d7f2-e5f6-500e-3e70-b1d1978f7140@redhat.com>
 <20190423193435.GX4038@hirez.programming.kicks-ass.net>
 <88ba7be0-9ec5-941e-1b3f-80fbe05fe3a0@redhat.com>
 <20190423195559.GY4038@hirez.programming.kicks-ass.net>
 <CAHk-=wgopkA+NiFCDOBcc24usK8hwL9CnQGzmv_4j8zJLGTrqA@mail.gmail.com>
 <20190423203512.GB4038@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423203512.GB4038@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 10:35:12PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 23, 2019 at 01:27:29PM -0700, Linus Torvalds wrote:
> > On Tue, Apr 23, 2019 at 12:56 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > Unless the very next line is schedule(), or implies it, one must not use
> > > preempt_enable_no_resched(). It can cause a preemption to go missing and
> > > thereby cause arbitrary delays, breaking the PREEMPT=y invariant.
> > 
> > That language may be a bit strong, or m,aybe the "implies it" might at
> > least be extended on.
> > 
> > It doesn't need to be "schedule()" per se, it can be any of the things
> > that check if we _need_ to be scheduled.
> 
> I'll try and word-smith that tomorrow, brain is fried. But yes,
> something that ends up in schedule() 'soon'.

I've made that:

Unless there is a call into schedule() in the immediate
(deterministic) future, one must not use preempt_enable_no_resched().
It can cause a preemption to go missing and thereby cause arbitrary
delays, breaking the PREEMPT=y invariant.

