Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F53C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1272B20663
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbfDSSvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:51:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33962 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfDSSvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:51:19 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E803ACD4A8;
        Fri, 19 Apr 2019 16:26:02 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.38])
        by smtp.corp.redhat.com (Postfix) with SMTP id 994D71001E98;
        Fri, 19 Apr 2019 16:26:01 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 19 Apr 2019 18:26:02 +0200 (CEST)
Date:   Fri, 19 Apr 2019 18:26:00 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Roman Gushchin <guroan@gmail.com>, Tejun Heo <tj@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 4/9] cgroup: cgroup v2 freezer
Message-ID: <20190419162600.GC12228@redhat.com>
References: <20190405174708.1010-1-guro@fb.com>
 <20190405174708.1010-5-guro@fb.com>
 <20190419151912.GA12152@redhat.com>
 <20190419161118.GA23357@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419161118.GA23357@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 19 Apr 2019 16:26:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/19, Roman Gushchin wrote:
>
> > Once again, suppose we race with CGRP_FREEZE. If JOBCTL_TRAP_FREEZE is already
> > set then signal_pending() must be already T and we do not need recalc_sigpending?
> > If JOBCTL_TRAP_FREEZE is not set yet, how can recalc_sigpending() help?
>
> This is paired with cgroup_task_frozen() check in recalc_sigpending_tsk().

Ooh, I didn't notice this version added cgroup_task_frozen() into
recalc_sigpending_tsk() ...

Honestly, I don't like this. But see another email I sent, we can cleanup
this code later.

> > > +static void cgroup_freeze_task(struct task_struct *task, bool freeze)
> > > +{
> > > +	unsigned long flags;
> > > +
> > > +	/* If the task is about to die, don't bother with freezing it. */
> > > +	if (!lock_task_sighand(task, &flags))
> > > +		return;
> > > +
> > > +	if (freeze) {
> > > +		task->jobctl |= JOBCTL_TRAP_FREEZE;
> > > +		signal_wake_up(task, false);
> > > +	} else {
> > > +		task->jobctl &= ~JOBCTL_TRAP_FREEZE;
> > > +		wake_up_process(task);
> >
> > wake_up_interruptible() ?
>
> Wait_up_interruptible() is supposed to work with a workqueue,
> but here there is nothing like this. Probably, I didn't understand your idea.
> Can you, please, elaborate a bit more?

Not sure I understand... We need to wake up the task if it sleeps in
do_freezer_trap(), right? do_freezer_trap() uses TASK_INTERRUPTIBLE, so
why can't wake_up_interruptible() == __wake_up(TASK_INTERRUPTIBLE) work?

> > >  static int ptrace_signal(int signr, kernel_siginfo_t *info)
> > >  {
> > >  	/*
> > > @@ -2442,6 +2483,10 @@ bool get_signal(struct ksignal *ksig)
> > >  		ksig->info.si_signo = signr = SIGKILL;
> > >  		sigdelset(&current->pending.signal, SIGKILL);
> > >  		recalc_sigpending();
> > > +		current->jobctl &= ~JOBCTL_TRAP_FREEZE;
> > > +		spin_unlock_irq(&sighand->siglock);
> > > +		if (unlikely(cgroup_task_frozen(current)))
> > > +			cgroup_leave_frozen(true);
> >
> > Oh, and another leave_frozen below...
>
> Yeah, because of this new "goto fatal" shortcut.

I understand, but the code doesn't look nice... but again, I can't suggest
anything better at least right now, so please forget.

> > > +		if (unlikely(cgroup_task_frozen(current))) {
> > >  			spin_unlock_irq(&sighand->siglock);
> > > +			cgroup_leave_frozen(true);
> > >  			goto relock;
> > >  		}
> >
> > afaics cgroup_leave_frozen(false) makes more sense here.
>
> Why? I don't see any reasons why the task should remain in the frozen
> state after this point.

But cgroup_leave_frozen(false) will equally clear ->frozen if !CGRP_FREEZE ?
OTOH, if CGRP_FREEZE is set again, why do we need to clear ->frozen?

Oleg.

