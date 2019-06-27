Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34D1C48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 01:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA7521726
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 01:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfF0Bba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 21:31:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49004 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbfF0Bba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 21:31:30 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B150E308213C;
        Thu, 27 Jun 2019 01:31:29 +0000 (UTC)
Received: from xz-x1 (ovpn-12-42.pek2.redhat.com [10.72.12.42])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C83CF19936;
        Thu, 27 Jun 2019 01:31:24 +0000 (UTC)
Date:   Thu, 27 Jun 2019 09:31:20 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH] timer: document TIMER_PINNED
Message-ID: <20190627013119.GA17087@xz-x1>
References: <20190618004356.10357-1-peterx@redhat.com>
 <alpine.DEB.2.21.1906270034520.32342@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906270034520.32342@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 27 Jun 2019 01:31:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 12:43:03AM +0200, Thomas Gleixner wrote:
> Peter,
> 
> On Tue, 18 Jun 2019, Peter Xu wrote:
> > -/*
> > - * A deferrable timer will work normally when the system is busy, but
> > - * will not cause a CPU to come out of idle just to service it; instead,
> > - * the timer will be serviced when the CPU eventually wakes up with a
> > - * subsequent non-deferrable timer.
> > +/**
> > + * @TIMER_DEFERRABLE: A deferrable timer will work normally when the
> > + * system is busy, but will not cause a CPU to come out of idle just
> > + * to service it; instead, the timer will be serviced when the CPU
> > + * eventually wakes up with a subsequent non-deferrable timer.
> >   *
> > - * An irqsafe timer is executed with IRQ disabled and it's safe to wait for
> > - * the completion of the running instance from IRQ handlers, for example,
> > - * by calling del_timer_sync().
> > + * @TIMER_IRQSAFE: An irqsafe timer is executed with IRQ disabled and
> > + * it's safe to wait for the completion of the running instance from
> > + * IRQ handlers, for example, by calling del_timer_sync().
> >   *
> >   * Note: The irq disabled callback execution is a special case for
> >   * workqueue locking issues. It's not meant for executing random crap
> >   * with interrupts disabled. Abuse is monitored!
> > + *
> > + * @TIMER_PINNED: A pinned timer will not be affected by timer
> > + * migration so it will always be run on a static cpu that was
> > + * specified.
> 
> That's a bit misleading.
> 
> The timer pinned flag prevents the MOHZ timer placement heuristics to take
> effect. That means that the timer is enqueued on the CPU on which the
> enqueue function is invoked. 

Right.  I thought these details could be hidden from the API layer so
timer users won't need to know these details (neither about NOHZ, nor
about the fact that the action of queuing the timer is the thing that
really matters, because add_timer_on() can hide all these), but it's
also ok to me if you prefer them to be exposed to the users.

> 
> > + * Note: neither timer_setup() nor mod_timer() will
> > + * guarantee correct pinning of timers.  One should always use
> > + * add_timer_on() when arm the timer to guarantee that the timer will
> > + * be pinned to the target CPU correctly.
> 
> I'd rather say:
> 
>     That means that pinned timers are not guaranteed to stay on the
>     initialy selected CPU. They move to the CPU on which the enqueue
>     function is invoked via mod_timer() or add_timer().
> 
>     If the timer should be placed on a particular CPU then add_timer_on()
>     has to be used.
> 
> Or something like that. Too tired to think about it right now, but you get
> the idea.

Yes, let me give it another shot soon...  Thanks,

-- 
Peter Xu
