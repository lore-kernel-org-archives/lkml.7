Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4042FC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 18:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A0C2178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 18:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MK2d/To/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfKGSo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 13:44:26 -0500
Received: from merlin.infradead.org ([205.233.59.134]:35802 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbfKGSo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 13:44:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WAmqUas8/1seJaYslsfzkt5VgvRpsLO07lhYverw/V0=; b=MK2d/To/SxBcinI3o1P5Veag7
        /pDm1tVdb4mrmTKVtRlUTJVFqmIjtS8UxSV5DzFhiz9KvB+g/cE4UE4jumDk/3fgkrDOhhsN2ddR+
        USiS1at52qnmYA/1Ec0o42ABuXVvESCkj4E8ABx3bcyCcoNACvpk5oW4KfjDf4sYr9ny5Z5Boyj64
        UxPqWOFWuI2Mj2EdvFp1rT1/CFCLDLpT5g1d7LlEL+YEAIC2tplbPWIIZ9r+vhu7Y0to/u0988s5D
        NFKpzdJrkN2i8DVxttHYoXhVHj3x1dOyQOvv4ncOR13bT2YHxvroyN3RALu0t7h420alb0IW8zfAi
        InXz/VSmA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSmlD-00067V-Fw; Thu, 07 Nov 2019 18:43:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 989FA301A79;
        Thu,  7 Nov 2019 19:42:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2EDD72025EDA2; Thu,  7 Nov 2019 19:43:56 +0100 (CET)
Date:   Thu, 7 Nov 2019 19:43:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, linux-kernel@vger.kernel.org,
        aaron.lwe@gmail.com, valentin.schneider@arm.com, mingo@kernel.org,
        pauld@redhat.com, jdesfossez@digitalocean.com,
        naravamudan@digitalocean.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        kernel-team@android.com, john.stultz@linaro.org
Subject: Re: NULL pointer dereference in pick_next_task_fair
Message-ID: <20191107184356.GF4114@hirez.programming.kicks-ass.net>
References: <20191028174603.GA246917@google.com>
 <20191106120525.GX4131@hirez.programming.kicks-ass.net>
 <33643a5b-1b83-8605-2347-acd1aea04f93@virtuozzo.com>
 <20191106165437.GX4114@hirez.programming.kicks-ass.net>
 <20191106172737.GM5671@hirez.programming.kicks-ass.net>
 <831c2cd4-40a4-31b2-c0aa-b5f579e770d6@virtuozzo.com>
 <20191107132628.GZ4114@hirez.programming.kicks-ass.net>
 <20191107153848.GA31774@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107153848.GA31774@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 03:38:48PM +0000, Quentin Perret wrote:
> On Thursday 07 Nov 2019 at 14:26:28 (+0100), Peter Zijlstra wrote:
> > Given that we're stuck with this order, the only solution is fixing
> > the 'change' pattern. The simplest fix seems to be to 'absuse'
> > p->on_cpu to carry more state. Adding more state to p->on_rq is
> > possible but is far more invasive and also ends up duplicating much of
> > the state we already carry in p->on_cpu.
> 
> I think there is another solution, which is to 'de-factorize' the call
> to put_prev_task() (that is, have each class do it). I gave it a go and
> I basically end up with something equivalent to reverting 67692435c411
> ("sched: Rework pick_next_task() slow-path"), which isn't the worst
> solution IMO. I'm thinking at least we should consider it.

The purpose of 67692435c411 is to ret rid of the RETRY_TASK logic
restarting the pick.

But you mean something like:

	for (class = prev->sched_class; class; class = class->next) {
		if (class->balance(rq, rf))
			break;
	}

	put_prev_task(rq, prev);

	for_each_class(class) {
		p = class->pick_next_task(rq);
		if (p)
			return p;
	}

	BUG();

like?

I had convinced myself we didn't need that, but that DL to RT case is
pesky and might require it after all.

> Now, 67692435c411 _is_ a nice clean-up, it's just a shame that the fix
> on top isn't as nice (IMO). It might just be a matter of personal taste,
> so I don't have a strong opinion on this :)

Yeah, it does rather make a mess of things.

I'll try and code up the above after dinner.
