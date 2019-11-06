Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05074C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6FDC217F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfKFPE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 10:04:56 -0500
Received: from foss.arm.com ([217.140.110.172]:41416 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727548AbfKFPE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 10:04:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 625E97CD;
        Wed,  6 Nov 2019 07:04:55 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 442CB3F71A;
        Wed,  6 Nov 2019 07:04:53 -0800 (PST)
Date:   Wed, 6 Nov 2019 15:04:50 +0000
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
Message-ID: <20191106150450.fa5ppdejiggsb46a@e107158-lin.cambridge.arm.com>
References: <20191028174603.GA246917@google.com>
 <20191106120525.GX4131@hirez.programming.kicks-ass.net>
 <20191106130838.GL5671@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191106130838.GL5671@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/19 14:08, Peter Zijlstra wrote:
> On Wed, Nov 06, 2019 at 01:05:25PM +0100, Peter Zijlstra wrote:
> > On Mon, Oct 28, 2019 at 05:46:03PM +0000, Quentin Perret wrote:
> > > 
> > > After digging a bit, the offending commit seems to be:
> > > 
> > >     67692435c411 ("sched: Rework pick_next_task() slow-path")
> > > 
> > > By 'offending' I mean that reverting it makes the issue go away. The
> > > issue comes from the fact that pick_next_entity() returns a NULL se in
> > > the 'simple' path of pick_next_task_fair(), which causes obvious
> > > problems in the subsequent call to set_next_entity().
> > > 
> > > I'll dig more, but if anybody understands the issue in the meatime feel
> > > free to send me a patch to try out :)
> > 
> > So for all those who didn't follow along on IRC, the below seems to cure
> > things.
> > 
> > The only thing I'm now considering is if we shouldn't be setting
> > ->on_cpu=2 _before_ calling put_prev_task(). I'll go audit the RT/DL
> > cases.
> 
> So I think it all works, but that's more by accident than anything else.
> I'll move the ->on_cpu=2 assignment earlier. That clearly avoids calling
> put_prev_task() while we're in put_prev_task().

Did you mean avoids calling *set_next_task()* while we're in put_prev_task()?

So what you're saying is that put_prev_task_{rt,dl}() could drop the rq_lock()
too and the race could happen while we're inside these functions, correct? Or
is it a different reason?

By the way, is all reads/writes to ->on_cpu happen when a lock is held? Ie: we
don't need to use any smp read/write barriers?

Cheers

--
Qais Yousef
