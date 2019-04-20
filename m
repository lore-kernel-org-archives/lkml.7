Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED819C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 10:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B629F2087B
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 10:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfDTK6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 06:58:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34538 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfDTK6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 06:58:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5D522CA1FA;
        Sat, 20 Apr 2019 10:58:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.38])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0B4955D9D6;
        Sat, 20 Apr 2019 10:58:39 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sat, 20 Apr 2019 12:58:40 +0200 (CEST)
Date:   Sat, 20 Apr 2019 12:58:38 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Roman Gushchin <guroan@gmail.com>, Tejun Heo <tj@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 4/9] cgroup: cgroup v2 freezer
Message-ID: <20190420105838.GA17468@redhat.com>
References: <20190405174708.1010-1-guro@fb.com>
 <20190405174708.1010-5-guro@fb.com>
 <20190419151912.GA12152@redhat.com>
 <20190419161118.GA23357@tower.DHCP.thefacebook.com>
 <20190419162600.GC12228@redhat.com>
 <20190419165600.GC23357@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419165600.GC23357@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sat, 20 Apr 2019 10:58:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/19, Roman Gushchin wrote:
>
> > > >
> > > > wake_up_interruptible() ?
> > >
> > > Wait_up_interruptible() is supposed to work with a workqueue,
> > > but here there is nothing like this. Probably, I didn't understand your idea.
> > > Can you, please, elaborate a bit more?
> >
> > Not sure I understand... We need to wake up the task if it sleeps in
> > do_freezer_trap(), right? do_freezer_trap() uses TASK_INTERRUPTIBLE, so
> > why can't wake_up_interruptible() == __wake_up(TASK_INTERRUPTIBLE) work?
>
> Right, but __wake_up is supposed to wake threads blocked on a waitqueue:

Ugh sorry ;) of course I meant wake_up_state(task, TASK_INTERRUPTIBLE).

> > > > > +		if (unlikely(cgroup_task_frozen(current))) {
> > > > >  			spin_unlock_irq(&sighand->siglock);
> > > > > +			cgroup_leave_frozen(true);
> > > > >  			goto relock;
> > > > >  		}
> > > >
> > > > afaics cgroup_leave_frozen(false) makes more sense here.
> > >
> > > Why? I don't see any reasons why the task should remain in the frozen
> > > state after this point.
> >
> > But cgroup_leave_frozen(false) will equally clear ->frozen if !CGRP_FREEZE ?
> > OTOH, if CGRP_FREEZE is set again, why do we need to clear ->frozen?
>
> Hm, it might work too, but I'm not sure I like it more. IMO, the best option
> is to have a single cgroup_leave_frozen(true) in signal.c, it's just simpler.
> If a user changed the desired state of cgroup twice, there is no need to avoid
> state transitions. Or maybe I don't see it yet.

Then why do we need cgroup_leave_frozen(false) in wait_for_vfork_done() ? How
does it differ from get_signal() ?

If nothing else. Suppose that wait_for_vfork_done() calls leave(false) and this
races with freezer, CGRP_FREEZE is already set but JOBCTL_TRAP_FREEZE is not.

This sets TIF_SIGPENDING to ensure the task won't return to user mode, thus it
calls get_signal().

get_signal() doesn't see JOBCTL_TRAP_FREEZE, it notices ->frozen == T and does
cgroup_leave_frozen(true) which clears ->frozen.

Then the task calls dequeue_signal(), clears TIF_SIGPENDING and returns to user
mode?

Oleg.

