Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07353C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D918121848
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732407AbfKFR0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:26:37 -0500
Received: from foss.arm.com ([217.140.110.172]:43540 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727572AbfKFR0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:26:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 982B246A;
        Wed,  6 Nov 2019 09:26:36 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 743B03F719;
        Wed,  6 Nov 2019 09:26:34 -0800 (PST)
Date:   Wed, 6 Nov 2019 17:26:32 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Quentin Perret <qperret@google.com>, linux-kernel@vger.kernel.org,
        aaron.lwe@gmail.com, valentin.schneider@arm.com, mingo@kernel.org,
        pauld@redhat.com, jdesfossez@digitalocean.com,
        naravamudan@digitalocean.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        kernel-team@android.com, john.stultz@linaro.org
Subject: Re: NULL pointer dereference in pick_next_task_fair
Message-ID: <20191106172631.euq7ggvfao2kvyld@e107158-lin.cambridge.arm.com>
References: <20191028174603.GA246917@google.com>
 <20191106120525.GX4131@hirez.programming.kicks-ass.net>
 <20191106130838.GL5671@hirez.programming.kicks-ass.net>
 <20191106150450.fa5ppdejiggsb46a@e107158-lin.cambridge.arm.com>
 <20191106165733.GY4114@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191106165733.GY4114@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/19 17:57, Peter Zijlstra wrote:
> On Wed, Nov 06, 2019 at 03:04:50PM +0000, Qais Yousef wrote:
> > On 11/06/19 14:08, Peter Zijlstra wrote:
> > > On Wed, Nov 06, 2019 at 01:05:25PM +0100, Peter Zijlstra wrote:
> 
> > > > The only thing I'm now considering is if we shouldn't be setting
> > > > ->on_cpu=2 _before_ calling put_prev_task(). I'll go audit the RT/DL
> > > > cases.
> > > 
> > > So I think it all works, but that's more by accident than anything else.
> > > I'll move the ->on_cpu=2 assignment earlier. That clearly avoids calling
> > > put_prev_task() while we're in put_prev_task().
> > 
> > Did you mean avoids calling *set_next_task()* while we're in put_prev_task()?
> 
> Either, really. The change pattern does put_prev_task() first, and then
> restores state by calling set_next_task(). And it can do that while
> we're in put_prev_task(), unless we're setting ->on_cpu=2.

*head starts spinning*

I can't see how we can have double put_prev_task() in a row. Let me stare more
at the code.

> 
> > So what you're saying is that put_prev_task_{rt,dl}() could drop the rq_lock()
> > too and the race could happen while we're inside these functions, correct? Or
> > is it a different reason?
> 
> Indeed, except it looks like that actually works (mostly by accident).

+1

I think I got it now, it's the double_lock_balance() that can drop the lock.
It even has a comment above it!

> 
> > By the way, is all reads/writes to ->on_cpu happen when a lock is held? Ie: we
> > don't need to use any smp read/write barriers?
> 
> Yes, ->on_cpu is fully serialized by rq->lock. We use
> smp_store_release() in finish_task() due to ttwu spin-waiting on it
> (which reminds me, riel was seeing lots of that).

Thanks. I had to ask as it was hard to walk all the paths.

Sometimes I get tempted to sprinkle comments or lockdep_assert() but then
I think that can easily get ugly and out of hand. I guess one just has to know
the code.

Cheers

--
Qais Yousef
