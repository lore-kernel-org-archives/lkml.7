Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232D0C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 13:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8824205C9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 13:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QSMKGU9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfEINh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 09:37:27 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58550 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbfEINh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 09:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=c3CNghomBvawXt39KUULl2no8YKZp9OCsMHGGo+d4vY=; b=QSMKGU9y7AlcT7/k7D/Szm2yH
        LIbJva8UKnIQv5o1v0AjlvexOXaEtc2xlrFGSSIwQN4PNuC+KvgJAW3Taak/bKS8wioU6Lj+PDqAV
        5FqCYx0qjJ212tmfb6gBV8dv/gtKDYLw/efRQazndKIOqb5an6AFuim5SoWC8FxjAQ0cmhytPyrtI
        OhSH5p3Byn8fEhNvdfLQM8fz95glNggAcecni9jCVX9IA2ZOClVImLpRNyovV+kfzyRbkc0lAlF46
        rz63s72/1EkCmASPhSkO5PO9/l0svnRdDNXxbEHArDe3Bcqbd3fP8OEcMeCyb10YpjQ0hVs0SH5nP
        J9TuRwfNg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOjE8-0003T4-SR; Thu, 09 May 2019 13:36:49 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 613DD20268735; Thu,  9 May 2019 15:36:47 +0200 (CEST)
Date:   Thu, 9 May 2019 15:36:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RFC: console: hack up console_lock more v3
Message-ID: <20190509133647.GX2623@hirez.programming.kicks-ass.net>
References: <20190509120903.28939-1-daniel.vetter@ffwll.ch>
 <20190509123104.GQ2589@hirez.programming.kicks-ass.net>
 <CAKMK7uGuOFGEuw1m_fiBfGbAEY0eeoDEFtP7Htt8-RCzD66MGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uGuOFGEuw1m_fiBfGbAEY0eeoDEFtP7Htt8-RCzD66MGw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 03:06:09PM +0200, Daniel Vetter wrote:
> On Thu, May 9, 2019 at 2:31 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > On Thu, May 09, 2019 at 02:09:03PM +0200, Daniel Vetter wrote:
> > > Fix this by creating a prinkt_safe_up() which calls wake_up_process
> > > outside of the spinlock. This isn't correct in full generality, but
> > > good enough for console_lock:
> > >
> > > - console_lock doesn't use interruptible or killable or timeout down()
> > >   calls, hence an up() is the only thing that can wake up a process.
> >
> > Wrong :/ Any task can be woken at any random time. We must, at all
> > times, assume spurious wakeups will happen.
> 
> Out of curiosity, where do these come from? I know about the races
> where you need to recheck on the waiter side to avoid getting stuck,
> but didn't know about this. Are these earlier (possibly spurious)
> wakeups that got held up and delayed for a while, then hit the task
> much later when it's already continued doing something else?

Yes, this. So they all more or less have the form:

CPU0		CPU1

		enqueue_waiter()
done = true;
if (waiters)
		for (;;) {
		  if (done)
		    break;

		  ...
		}

		dequeue_waiter()

		do something else again

  wake_up_task
		<gets wakeup>


The wake_q thing made the above much more common, but we've had it
forever.

> Or even
> more random, and even if I never put a task on a wait list or anything
> else, ever, it can get woken spuriously?

I had patches that did that on purpose, but no.

> > Something like the below might work.
> 
> Yeah that looks like the proper fix. I guess semaphores are uncritical
> enough that we can roll this out for everyone. Thanks for the hint.

It's actually an optimization that we never did because semaphores are
so uncritical :-)

The thing is, by delaying the wakup until after we've released the
spinlock, the waiter will not contend on the spinlock the moment it
wakes.
