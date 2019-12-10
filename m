Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB2AC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80ADA2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="15lEJW8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfLJVyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:54:04 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48440 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbfLJVyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:54:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TfyQzdYdc2vORsdO4R5k7wzcXlTkqH6TBOkerjXFBzI=; b=15lEJW8TVI78zM5kQtMiXrA76
        2Vl14PyunTX7+JvCwguNW35sQJ7CAbTfjSdtIlWyPoYcBLAFIXRBeJd9/qNFlIfXqgJN0OCj9akkk
        +iHvINnQ0lzlUeLcj+cwJbce4CW1OaqYs+sadx3AeoGLfJ3968wEAHQRmuavunIHgoei/OruR4fGx
        3DzfmtNrw8FNpkz8Qwybo/Ptk7lKc2d2xzK4vkmNuE9VubxUwvvYqgldugVelvdpOUIS70kUdyg8r
        bO7/c1zM4QoEtvFtj3QYW9vJVpZ12rtk21iKVin6M503sssmfUIzizgjXoCQYbSkW87TK1QXiT5Fu
        leapZ9ApQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ienSB-00064n-3d; Tue, 10 Dec 2019 21:53:59 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 40068980CCD; Tue, 10 Dec 2019 22:53:56 +0100 (CET)
Date:   Tue, 10 Dec 2019 22:53:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        David Howells <dhowells@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: Problem with WARN_ON in mutex_trylock() and rxrpc
Message-ID: <20191210215356.GC11457@worktop.programming.kicks-ass.net>
References: <26229.1575547344@warthog.procyon.org.uk>
 <20191205132212.GK2827@hirez.programming.kicks-ass.net>
 <87wob4hvyq.fsf@nanos.tec.linutronix.de>
 <20191210192538.GB11457@worktop.programming.kicks-ass.net>
 <20191210203225.2kvykwn35gnethjn@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210203225.2kvykwn35gnethjn@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 09:32:25PM +0100, Sebastian Andrzej Siewior wrote:
> On 2019-12-10 20:25:38 [+0100], Peter Zijlstra wrote:
> > AFAICT the only assumption it relies on are:
> > 
> >  - that the softirq will cleanly preempt a task. That is, the task
> >    context must not change under the softirq execution.
> > 
> >  - that the softirq runs non-preemptible.
> > 
> > Now, both these properties are rather fundamental to how our softirqs
> > work. And can, therefore, be relied upon, irrespective of the mutex
> > implementation.
> 
> softirq is preemptible on -RT (I think you know that already but just in
> case).

Indeed, but there it also runs in task context and then it all works
naturally. The !preempt thing is required for when it runs on top of a
task; then it functions as a priority ceiling like construct.
