Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D433C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA322077C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573145673;
	bh=xbqAtvVWlrEfOFkrNtCJbqXJ9udKi5GGRhx73z0trbQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=0JqBR7VnOdhrr+nMdas2/Atn3+swLEKcFOi34ah64NxgHv0sH64RuizD12yRiEDDZ
	 QPka98/0y4+bwi8al4evhr8R3UdI37JTPXLaE+a9dI+wlr4LCGr4c0cyqWC7bohaBI
	 nqZZr2PN8mmbKK5C6w25MzQwoGXHQ/tnbvD0UEUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389636AbfKGQyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 11:54:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:50494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729509AbfKGQyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 11:54:31 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [109.144.209.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8015B214D8;
        Thu,  7 Nov 2019 16:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573145670;
        bh=xbqAtvVWlrEfOFkrNtCJbqXJ9udKi5GGRhx73z0trbQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WymNmy8vBMhToty5nAepu8+/SlfuivhoGg9hoK7wOOWrvUqW5ynerWrOcoUq56F8Y
         Uz91JuakzZUCjug2ty0xObKvFnxjQq3CmSOOtK+qejT/pi9vbXiszwPoA4h/mEoSyL
         MVp65/9RTqUx2fpPCbWqwWloQlOFRzUNMoEBFBSM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 566F33522919; Thu,  7 Nov 2019 08:54:28 -0800 (PST)
Date:   Thu, 7 Nov 2019 08:54:28 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        syzbot <syzkaller@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: Re: [tip: timers/core] hrtimer: Annotate lockless access to
 timer->state
Message-ID: <20191107165428.GR20975@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191106174804.74723-1-edumazet@google.com>
 <157307905904.29376.8711513726869840596.tip-bot2@tip-bot2>
 <CANn89iKXi3rWWruKoBwQ8rncwLvkbzjZJWuJL3K05fjAhcySwg@mail.gmail.com>
 <CANn89iL=xPxejRPC=wHY7q27fLOvFBK-7HtqU_HJo+go3S9UXA@mail.gmail.com>
 <20191107085255.GK20975@paulmck-ThinkPad-P72>
 <CANn89i+8Hq5j234zFRY05QxZU1n=Vr6S-kZCcvn3Z80xYaindg@mail.gmail.com>
 <20191107161149.GQ20975@paulmck-ThinkPad-P72>
 <CANn89iLMD0=tiQ181qQ=qKo=Nom-XX4MqonZw6pKiYUzTDVjQg@mail.gmail.com>
 <CANn89iLqcqKLRgfn7TDnBr9ZatiJVyezXmmZaeN2f2BT=qFe7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iLqcqKLRgfn7TDnBr9ZatiJVyezXmmZaeN2f2BT=qFe7Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 08:39:42AM -0800, Eric Dumazet wrote:
> On Thu, Nov 7, 2019 at 8:35 AM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Thu, Nov 7, 2019 at 8:11 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > OK, so this is due to timer_pending() lockless access to ->entry.pprev
> > > to determine whether or not the timer is on the list.  New one on me!
> > >
> > > Given that use case, I don't have an objection to your patch to list.h.
> > >
> > > Except...
> > >
> > > Would it make sense to add a READ_ONCE() to hlist_unhashed()
> > > and to then make timer_pending() invoke hlist_unhashed()?  That
> > > would better confine the needed uses of READ_ONCE().
> >
> > Sounds good to me, I had the same idea but was too lazy to look at the
> > history of timer_pending()
> > to check if the pprev pointer check was really the same underlying idea.
> 
> Note that forcing READ_ONCE() in hlist_unhashed() might force the compiler
> to read the pprev pointer twice in some cases.
> 
> This was one of the reason for me to add skb_queue_empty_lockless()
> variant in include/linux/skbuff.h

Ouch!

> /**
>  * skb_queue_empty_lockless - check if a queue is empty
>  * @list: queue head
>  *
>  * Returns true if the queue is empty, false otherwise.
>  * This variant can be used in lockless contexts.
>  */
> static inline bool skb_queue_empty_lockless(const struct sk_buff_head *list)
> {
> return READ_ONCE(list->next) == (const struct sk_buff *) list;
> }
> 
> So maybe add a hlist_unhashed_lockless() to clearly document why
> callers are using the lockless variant ?

That sounds like a reasonable approach to me.  There aren't all that
many uses of hlist_unhashed(), so a name change should not be a problem.

							Thanx, Paul
