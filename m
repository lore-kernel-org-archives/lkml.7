Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1421AC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 00:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0BA620663
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 00:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfFRAmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 20:42:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54562 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfFRAmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 20:42:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C43223082E1E;
        Tue, 18 Jun 2019 00:41:59 +0000 (UTC)
Received: from xz-x1 (unknown [10.66.60.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 786EA5E7C6;
        Tue, 18 Jun 2019 00:41:55 +0000 (UTC)
Date:   Tue, 18 Jun 2019 08:41:52 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH] timers: Fix up get_target_base() to use old base properly
Message-ID: <20190618004152.GE30983@xz-x1>
References: <20190603132944.9726-1-peterx@redhat.com>
 <alpine.DEB.2.21.1906170732410.1760@nanos.tec.linutronix.de>
 <20190617091122.GC12456@xz-x1>
 <alpine.DEB.2.21.1906171400050.1854@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906171400050.1854@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 18 Jun 2019 00:41:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 02:07:48PM +0200, Thomas Gleixner wrote:
> Peter,
> 
> On Mon, 17 Jun 2019, Peter Xu wrote:
> > On Mon, Jun 17, 2019 at 08:09:20AM +0200, Thomas Gleixner wrote:
> > > You might argue that in case of an explicit pinned timer, the above logic
> > > is wrong when the timer is modified as it might move to a different
> > > CPU. But from day one when the pinned logic was introduced, pinned just
> > > prevents it from being queued on a remote CPU. If you need a timer to stay
> > > on a particular CPU even if modified from a remote CPU, then the only way
> > > right now is to dequeue and requeue it with add_timer_on(). 
> > 
> > Indeed.  If add_timer_on() should always be used when with pinned
> > timers, IMHO it would be good to comment probably above TIMER_PINNED
> > about the fact so people will never misuse the interfaces (it seems to
> > be mis-used somehow but I cannot be 100% sure, please see below).
> 
> Yeah, some documentation would be good.
> 
> > > If we really want to change that, then we need to audit all usage sites of
> > > pinned timers and figure out whether this would break anything.
> > > 
> > > The proper change would be in that case:
> > > 
> > >       return pinned ? base : get_timer_this_cpu_base(tflags);
> > 
> > Purely for curiousity - why would we like to use current cpu base even
> > if it's unpinned?  My humble opinion is that if we use base directly
> > at least we can avoid potential migration of the timer.  But I can be
> > missing some real reason here...
> 
> In most cases it's desired to move the timer over. Assume you have a
> network interrupt moving from one cpu to the other and then the tcp timers
> would stay on the old cpu forever. So you'd pay the remote access price
> every time you touch it and if it fires the callback is pretty much
> guaranteed to be cache cold.

I see.

> 
> > Though, I see two outliers:
> > 
> > ======================
> > 
> > *** drivers/cpufreq/powernv-cpufreq.c:
> > powernv_cpufreq_cpu_init[867]  TIMER_PINNED | TIMER_DEFERRABLE);
> > 
> > *** net/ipv4/inet_timewait_sock.c:
> > inet_twsk_alloc[189]           timer_setup(&tw->tw_timer, tw_timer_handler, TIMER_PINNED);
> 
> That's fine. It just wants to make sure that the timer is not queued on a
> remote CPU if NOHZ is active. That gives them a serialization guarantee of
> the network softirq vs. the timer softirq so they can spare some locking
> stuff.

Thanks for the analysis.  Instead of this patch, let me post a
documentation update for pinned timers.

Thanks,

-- 
Peter Xu
