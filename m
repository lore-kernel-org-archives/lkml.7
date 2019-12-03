Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9760C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 17:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767E62084B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 17:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575395150;
	bh=SKTt++4ehKNxj9alaTIqGbxVRfRny7WlP66LscAM2Tw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=YGakA18YlYJHIWevN1tddYjzqXhvnEagNNfeYdioz63BKGm7BUeGZe7h1dRaWVg9+
	 nXp1hU/Oh5J86F+ynvlrLg4myOfqrql5ay1ry7+Nl16jjsMZcxK2yZcR3x/fkXU3e7
	 hpZAh3OTgynLlo1gPsATvsa67AN2JTlmfX4X3zys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfLCRpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 12:45:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:37940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfLCRpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 12:45:47 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D04E2080F;
        Tue,  3 Dec 2019 17:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575395147;
        bh=SKTt++4ehKNxj9alaTIqGbxVRfRny7WlP66LscAM2Tw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gYw6+tIZQ/sQMyEfngpumkCNKvB2OT3nDZHnl4akATGkutnFgKuSGvfHKSMZ2zTsy
         s7t7yno/2mY5/QIbWbJrbKKKaA2eszlKkO1UNZivRqb4pWaJE75LUAY8K1bSYmnotl
         SghMhXymJFyF9qd3lUG8otD4ZaynxA6f8v/ASrdk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0925E3522780; Tue,  3 Dec 2019 09:45:47 -0800 (PST)
Date:   Tue, 3 Dec 2019 09:45:47 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Workqueues splat due to ending up on wrong CPU
Message-ID: <20191203174547.GG2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191125230312.GP2889@paulmck-ThinkPad-P72>
 <20191126183334.GE2867037@devbig004.ftw2.facebook.com>
 <20191126220533.GU2889@paulmck-ThinkPad-P72>
 <20191127155027.GA15170@paulmck-ThinkPad-P72>
 <20191128161823.GA24667@paulmck-ThinkPad-P72>
 <20191129155850.GA17002@paulmck-ThinkPad-P72>
 <20191202015548.GA13391@paulmck-ThinkPad-P72>
 <20191202201338.GH16681@devbig004.ftw2.facebook.com>
 <20191202233944.GY2889@paulmck-ThinkPad-P72>
 <20191203100010.GI2827@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203100010.GI2827@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 11:00:10AM +0100, Peter Zijlstra wrote:
> On Mon, Dec 02, 2019 at 03:39:44PM -0800, Paul E. McKenney wrote:
> 
> > I think that I do not understand the code, but I never let that stop
> > me from asking stupid questions!  ;-)
> > 
> > Suppose that a given worker is bound to a particular CPU, but has no
> > work pending, and is therefore sleeping in the schedule() call near the
> > end of worker_thread().  During this time, its CPU goes offline and then
> > comes back online.  Doesn't this break that task's affinity to that CPU?
> 
> No. The thing about sleeping tasks is that they're not in fact on any
> CPU at all. Only when a task wakes up do we concern ourselves with
> placing it. If at that time we find the CPU it was constrained to is no
> longer with us, then we go break affinity.
> 
> But if the CPU went away and came back while the task was asleep, it
> will not notice anything.

Good point, and yes, you have told me this before.

Furthermore, in all of these cases, the process was supposed to be
running on CPU 0, which cannot be taken offline on any of the systems
under test.  Which is leading me to wonder if the workqueue CPU-online
notifier is sometimes moving more kthreads to the newly onlined CPU than
it is supposed to.  Tejun, could that be happening?

							Thanx, Paul
