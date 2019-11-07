Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B47DC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264D62178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573146464;
	bh=fPQk1CB2fD+joQiucvbdrbH/MOkp35H8ljloJnhHVes=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=sVthmsHoJ7GUDrCjveX2kL0J4ARVfYAt1Y5lWe41a2ODuFlQHu1yQdVE2bMx4hsTi
	 OevjtlXY41MViiWHUp+o0OnSqP9qiVXaQzljgbXCiZTAakYCaHWhnm4HNgq9n+WAHh
	 URWwV1CajHykPSc2X/MV4sjxmcLo/bv0zLyUEQRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbfKGRHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 12:07:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:56832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfKGRHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 12:07:42 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [109.144.209.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AB93206BA;
        Thu,  7 Nov 2019 17:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573146461;
        bh=fPQk1CB2fD+joQiucvbdrbH/MOkp35H8ljloJnhHVes=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FULeloc2Cw14BMI0w6LnhBrCrhL9bUi4jg/5JduqcxU4Ybfb829eYbVWNWZF4gheK
         tDIboebsOwypoS5vF4/mx2IY93cqYQEIFnewH7V4EQyDY5/XgXLycehA4w0EAzQA5j
         ZK841bxgxlWiZqX0XKC7AuXoB+tVohNI61d9Kd+s=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A09D13522919; Thu,  7 Nov 2019 09:07:38 -0800 (PST)
Date:   Thu, 7 Nov 2019 09:07:38 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        syzbot <syzkaller@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: Re: [tip: timers/core] hrtimer: Annotate lockless access to
 timer->state
Message-ID: <20191107170738.GT20975@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <157307905904.29376.8711513726869840596.tip-bot2@tip-bot2>
 <CANn89iKXi3rWWruKoBwQ8rncwLvkbzjZJWuJL3K05fjAhcySwg@mail.gmail.com>
 <CANn89iL=xPxejRPC=wHY7q27fLOvFBK-7HtqU_HJo+go3S9UXA@mail.gmail.com>
 <20191107085255.GK20975@paulmck-ThinkPad-P72>
 <CANn89i+8Hq5j234zFRY05QxZU1n=Vr6S-kZCcvn3Z80xYaindg@mail.gmail.com>
 <20191107161149.GQ20975@paulmck-ThinkPad-P72>
 <CANn89iLMD0=tiQ181qQ=qKo=Nom-XX4MqonZw6pKiYUzTDVjQg@mail.gmail.com>
 <CANn89iLqcqKLRgfn7TDnBr9ZatiJVyezXmmZaeN2f2BT=qFe7Q@mail.gmail.com>
 <20191107165428.GR20975@paulmck-ThinkPad-P72>
 <CANn89i+Cc1aOHVFnYvZ93EDee81RaGNrv47ZBVdQXmxMuuMmww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89i+Cc1aOHVFnYvZ93EDee81RaGNrv47ZBVdQXmxMuuMmww@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 08:59:49AM -0800, Eric Dumazet wrote:
> On Thu, Nov 7, 2019 at 8:54 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Thu, Nov 07, 2019 at 08:39:42AM -0800, Eric Dumazet wrote:
> > > On Thu, Nov 7, 2019 at 8:35 AM Eric Dumazet <edumazet@google.com> wrote:
> > > >
> > > > On Thu, Nov 7, 2019 at 8:11 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > >
> > > > > OK, so this is due to timer_pending() lockless access to ->entry.pprev
> > > > > to determine whether or not the timer is on the list.  New one on me!
> > > > >
> > > > > Given that use case, I don't have an objection to your patch to list.h.
> > > > >
> > > > > Except...
> > > > >
> > > > > Would it make sense to add a READ_ONCE() to hlist_unhashed()
> > > > > and to then make timer_pending() invoke hlist_unhashed()?  That
> > > > > would better confine the needed uses of READ_ONCE().
> > > >
> > > > Sounds good to me, I had the same idea but was too lazy to look at the
> > > > history of timer_pending()
> > > > to check if the pprev pointer check was really the same underlying idea.
> > >
> > > Note that forcing READ_ONCE() in hlist_unhashed() might force the compiler
> > > to read the pprev pointer twice in some cases.
> > >
> > > This was one of the reason for me to add skb_queue_empty_lockless()
> > > variant in include/linux/skbuff.h
> >
> > Ouch!
> >
> > > /**
> > >  * skb_queue_empty_lockless - check if a queue is empty
> > >  * @list: queue head
> > >  *
> > >  * Returns true if the queue is empty, false otherwise.
> > >  * This variant can be used in lockless contexts.
> > >  */
> > > static inline bool skb_queue_empty_lockless(const struct sk_buff_head *list)
> > > {
> > > return READ_ONCE(list->next) == (const struct sk_buff *) list;
> > > }
> > >
> > > So maybe add a hlist_unhashed_lockless() to clearly document why
> > > callers are using the lockless variant ?
> >
> > That sounds like a reasonable approach to me.  There aren't all that
> > many uses of hlist_unhashed(), so a name change should not be a problem.
> 
> Maybe I was not clear :  I did not rename skb_queue_empty()
> I chose to add another helper.
> 
> Contexts that can safely use skb_queue_empty() still continue to use
> it, since it might help
> the compiler to generate better code.
> 
> So If I add hlist_unhashed_lockless(), I would only use it from
> timer_pending() at first.
> 
> Then an audit of the code might reveal other potential users.

OK, yes, that approach does make more sense, and thank you for the
clarification.

							Thanx, Paul
