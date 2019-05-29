Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30773C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F163C2187F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MYTZvabu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfE2Nao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:30:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35708 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfE2Nan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JhvQcxsDOAi99i8nAmNAWnYo8mb5wQBh82wJuM9KB6k=; b=MYTZvabuIfIQiLPnTjcRrxTpg
        Fej6YenqPFI3Wa4z0+9Jo+9gIik1GxE8Jz34Eu3O3U/NBon3cr1ZAPWP5kn26P8pV9+BjP1Fgr9Y5
        7s9eCeZkmEOwaeuwhSaGE7wZP/3euBRdIrAUW1seXpdTxueQCRCUxrOWuhYYAVJjK1AoBp5akjeGd
        0OC6hhsaWuXMJbmYJpq7PnjIuE7Ad2+D9xTTd6oOjvRq97Uh8FXF0TYwH23mv3j8hJN7JsWKK+EWD
        JQNbGmlzYp99BmgRIFEOjvdEoCQD7KfLsX9gF5a0eNv4rQAlHzMbzmGLDd9n1fqFZEd+5xZB25VQR
        HL0GoZ2Bw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVye0-0005Hi-2q; Wed, 29 May 2019 13:29:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D86EA201DA64E; Wed, 29 May 2019 15:29:26 +0200 (CEST)
Date:   Wed, 29 May 2019 15:29:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, williams@redhat.com,
        daniel@bristot.me, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [RFC 2/3] preempt_tracer: Disable IRQ while starting/stopping
 due to a preempt_counter change
Message-ID: <20190529132926.GV2650@hirez.programming.kicks-ass.net>
References: <cover.1559051152.git.bristot@redhat.com>
 <f2ca7336162b6dc45f413cfe4e0056e6aa32e7ed.1559051152.git.bristot@redhat.com>
 <20190529083357.GF2623@hirez.programming.kicks-ass.net>
 <b47631c3-d65a-4506-098a-355c8cf50601@redhat.com>
 <20190529102038.GO2623@hirez.programming.kicks-ass.net>
 <20190529083930.5541130e@oasis.local.home>
 <20190529131957.GV2623@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529131957.GV2623@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 03:19:57PM +0200, Peter Zijlstra wrote:
> On Wed, May 29, 2019 at 08:39:30AM -0400, Steven Rostedt wrote:
> > I believe I see what Daniel is talking about, but I hate the proposed
> > solution ;-)
> > 
> > First, if you care about real times that the CPU can't preempt
> > (preempt_count != 0 or interrupts disabled), then you want the
> > preempt_irqsoff tracer. The preempt_tracer is more academic where it
> > just shows you when we disable preemption via the counter. But even
> > with the preempt_irqsoff tracer you may not get the full length of time
> > due to the above explained race.
> 
> IOW, that tracer gives a completely 'make believe' number? What's the
> point? Just delete the pure preempt tracer.

Alternatively, fix the preempt tracer by having it completely disregard
IRQs.
