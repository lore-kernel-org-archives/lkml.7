Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C00CC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E501920863
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dde4IC0E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391563AbfEXM1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 08:27:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41868 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391244AbfEXM1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 08:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eVHp0ESgYP2SVv9gpU+9DqsaIL0Z0MyAUxyGFotINZY=; b=dde4IC0EDUPS5Dae7l2uy4MU/
        OMQgKWX3Koau5qTkaGVhQ1Xse792h1gAth33/3bAsMo2wS2qH0SRUZsZULKoLHZM44c5KuOb60mbX
        TxZvC4cOeAMYXQXBHHBdqZyHnq9gfWzM/7OrlIn3j4RaUShcLuf3cwtp5MVCZ/aSMzicjVXN+uEre
        mV6rXmKqxQI3vaBkjXDMsh8w9vi1tPPfiRjtg7QPqElTBZ5OEWdP5SobpJ19xdHS/p+uaddOQNqQb
        XLHjS8/dYvQHzRcam6z1tzj6KQFxovixjnYHkHgo5H61WT2qrJAuEx8FQY6GWeVp37GM2FqeFzhkm
        IFrXYVWOQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hU9IE-0000iZ-DB; Fri, 24 May 2019 12:27:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 967A22027B77E; Fri, 24 May 2019 14:27:24 +0200 (CEST)
Date:   Fri, 24 May 2019 14:27:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Frank Ch. Eigler" <fche@redhat.com>
Subject: Re: [RFC][PATCH 03/14 v2] function_graph: Allow multiple users to
 attach to function graph
Message-ID: <20190524122724.GO2623@hirez.programming.kicks-ass.net>
References: <20190520142001.270067280@goodmis.org>
 <20190520142156.992391836@goodmis.org>
 <20190524112608.GJ2589@hirez.programming.kicks-ass.net>
 <20190524081219.25de03f6@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524081219.25de03f6@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 08:12:19AM -0400, Steven Rostedt wrote:
> On Fri, 24 May 2019 13:26:08 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > But but but but.. why not add all the required bits to the shadow stack
> > in the first place and do away with the array entirely?
> 
> What required bits would that be? The pointer to the fgraph_ops,
> because we need that to pass to the calling function.

I was thinking a smaller structure comprising of {func,callback}, which
you pop, if func matches, run callback.

> > So on ret, just keep POP'ing until either the stack is empty or the
> > entry is for another function.
> 
> When we hit a fgraph_ops, how do we know if it was freed or not? We
> can't just blindly reference it.
> 
> The idea of the array, is that we can maintain state in a single
> location of when the fgraph_ops is freed. If we return from a function,
> we have an index and a counter, and if the counter doesn't match with
> what's in the array, then we know that the fgraph_ops is no longer
> around and we just drop it.
> 
> The reason for the array, is to keep track of if the fgraph_ops has
> been freed or not. Otherwise, when we unregister the fgraph_ops, we
> would need to search all shadow stacks, looking for it to unreference
> it.
> 
> Believe me, I rather not have that array, but I couldn't come up with a
> better solution to handle freeing of fgraph_ops.

The trivial answer would be to refcount the thing, but can't we make
rcu_tasks do this?

And delay the unreg until all active users are gone -- who gives a crap
that can take a while.
