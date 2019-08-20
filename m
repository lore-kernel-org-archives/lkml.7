Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A6FC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CAC2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XUJNwUKT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbfHTQCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 12:02:21 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38566 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfHTQCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 12:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CXbbDa4ffmi5gie+3V6ZjcTpxpVMrBHD7zn0A7vJWZQ=; b=XUJNwUKTTwn2YE9BsUeD/S+vE
        LBxVVIIyjiedcHeNmoJe+jxATxLSyoYWmMP2OrFqnd+8wbWwBTFiBEau/m0QaRqJSjIr5lVF2H+vq
        xeqahqpYCTGjyUz5LiK241+e8XYZi8PuiNHmLDeCIUUSzf4Ks/XymVTVkWhk2PKjCpu+aZq+BGkyn
        VrmltWVf3RCqU/OHXDptFo8irqy5C1QYOytUFSyW7ps4aob8sCxk7PqrjhWvPAXN5RYdGHJN3ARqa
        h84oCMKytOlOmIHytp1aEh/2wakP65p5owz7enivueClejNdsD2nwn8I6TWOwdbZvM9p2QJpTsfBm
        ChUEaKehA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i06aQ-0001ig-Rg; Tue, 20 Aug 2019 16:02:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EEBA9307603;
        Tue, 20 Aug 2019 18:01:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 437F420A21FEA; Tue, 20 Aug 2019 18:02:17 +0200 (CEST)
Date:   Tue, 20 Aug 2019 18:02:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        tglx@linutronix.de
Subject: Re: [PATCH] sched/core: Schedule new worker even if PI-blocked
Message-ID: <20190820160217.GR2369@hirez.programming.kicks-ass.net>
References: <20190816160626.12742-1-bigeasy@linutronix.de>
 <20190820135014.GQ2332@hirez.programming.kicks-ass.net>
 <20190820145926.jhnpwiicv73z6ol3@linutronix.de>
 <20190820152025.GU2349@hirez.programming.kicks-ass.net>
 <20190820155401.c5apbxjntdz5n2gk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820155401.c5apbxjntdz5n2gk@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 05:54:01PM +0200, Sebastian Andrzej Siewior wrote:
> On 2019-08-20 17:20:25 [+0200], Peter Zijlstra wrote:

> > And am I right in thinking that that, again, is specific to the
> > sleeping-spinlocks from PREEMPT_RT? Is there really nothing else that
> > identifies those more specifically? It's been a while since I looked at
> > them.
> 
> Not really. I hacked "int sleeping_lock" into task_struct which is
> incremented each time a "sleeping lock" version of rtmutex is requested.
> We have two users as of now:
> - RCU, which checks if we schedule() while holding rcu_read_lock() which
>   is okay if it is a sleeping lock.
> 
> - NOHZ's pending softirq detection while going to idle. It is possible
>   that "ksoftirqd" and "current" are blocked on locks and the CPU goes
>   to idle (because nothing else is runnable) with pending softirqs.
> 
> I wanted to let rtmutex invoke another schedule() function in case of a
> sleeping lock to avoid the RCU warning. This would avoid incrementing
> "sleeping_lock" in the fast path. But then I had no idea what to do with
> the NOHZ thing.

Once upon a time there was also a shadow task->state thing, that was
specific to the sleeping locks, because normally spinlocks don't muck
with task->state and so we have code relying on it not getting trampled.

Can't we use that somewhow? Or is that gone?

> > Also, I suppose it would be really good to put that in a comment.
> So, what does that mean for that patch. According to my inbox it has
> applied to an "urgent" branch. Do I resubmit the whole thing or just a
> comment on top?

Yeah, I'm not sure. I was surprised by that, because afaict all this is
PREEMPT_RT specific and not really /urgent material in the first place.
Ingo?
