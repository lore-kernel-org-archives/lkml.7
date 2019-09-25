Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F417C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 14:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1851B21D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 14:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569422546;
	bh=1rKvhT6TPbRrj6cxJNqxk8DV8TgnweZpxmsORdoMk8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WYaiKwxZS8WeoixBvDvQOL9m4coIhQpkKawR2vVqk7KjdICnYDPIYiOOZuMQlXuCv
	 mZA7EBQu7stEgR4rG1idVU8AJqU05Id92ujpVNbTmyFcbJXDPBiQYezLWUtSv4aPdq
	 UkXKjPDZhN9LFWyV4XSh/ZvFJiCjIQ4PGAk5/e3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438046AbfIYOmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 10:42:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437125AbfIYOmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 10:42:24 -0400
Received: from localhost (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C2CC2146E;
        Wed, 25 Sep 2019 14:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569422544;
        bh=1rKvhT6TPbRrj6cxJNqxk8DV8TgnweZpxmsORdoMk8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H5s7h7DNkW2VGKnzSUZEtPrOQG2q4TTqozc9MoLFQl/O6qGWHBbzHCukjfr735SPC
         XdWEdPluQRzpBraxHIuX91dwamHsnDKRmzzGin0t0xZA7I33qQuzye7qUz2DJ9daPY
         pWxZjvEMv1YfBlguSb542zaXgdqCwgKKyq1JybFA=
Date:   Wed, 25 Sep 2019 16:42:21 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 04/25] vtime: Spare a seqcount lock/unlock cycle on
 context switch
Message-ID: <20190925144219.GA17854@lenoir>
References: <1542163569-20047-1-git-send-email-frederic@kernel.org>
 <1542163569-20047-5-git-send-email-frederic@kernel.org>
 <20181120132512.GQ2131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120132512.GQ2131@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry to answer 10 month later. You certainly have lost track of this. I have.
I'm re-issuing this patchset but more piecewise to make the review easier.

In case you still care, I'm answering your comments below. But you can skip
that and wait for the new version that I'm about to post.


On Tue, Nov 20, 2018 at 02:25:12PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 14, 2018 at 03:45:48AM +0100, Frederic Weisbecker wrote:
> 
> So I definitely like avoiding that superfluous atomic op, however:
> 
> > @@ -730,19 +728,25 @@ static void vtime_account_guest(struct task_struct *tsk,
> >  	}
> >  }
> >  
> > +static void __vtime_account_kernel(struct task_struct *tsk,
> > +				   struct vtime *vtime)
> 
> Your last patch removed a __function, and now you're adding one back :/

Yes, in fact I removed a __function to avoid having two in the end.

I can't think of a better name. vtime_account_kernel_locked() maybe,
but it's not event locked, it's seqcount write.

> 
> >  {
> >  	/* We might have scheduled out from guest path */
> >  	if (tsk->flags & PF_VCPU)
> >  		vtime_account_guest(tsk, vtime);
> >  	else
> >  		vtime_account_system(tsk, vtime);
> > +}
> > +
> > +void vtime_account_kernel(struct task_struct *tsk)
> > +{
> > +	struct vtime *vtime = &tsk->vtime;
> > +
> > +	if (!vtime_delta(vtime))
> > +		return;
> > +
> 
> See here the fast path (is it worth it?)

Might be worth testing if that fast path is often hit indeed. With
any sensible clock we should at least have a few nanosecs to account.

> 
> > +	write_seqcount_begin(&vtime->seqcount);
> > +	__vtime_account_kernel(tsk, vtime);
> >  	write_seqcount_end(&vtime->seqcount);
> >  }
> 
> > +void vtime_task_switch_generic(struct task_struct *prev)
> >  {
> >  	struct vtime *vtime = &prev->vtime;
> 
> And observe a distinct lack of that same fast path..

Right but in any case we have to lock (seqcount) here
since at least vtime->state has to be set to VTIME_INACTIVE.

> 
> >  
> >  	write_seqcount_begin(&vtime->seqcount);
> > +	if (is_idle_task(prev))
> > +		vtime_account_idle(prev);
> > +	else
> > +		__vtime_account_kernel(prev, vtime);
> >  	vtime->state = VTIME_INACTIVE;
> >  	write_seqcount_end(&vtime->seqcount);
> >  
> > -- 
> > 2.7.4
> > 
