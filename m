Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7E4C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D325222C6
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OlemqC/3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389532AbfKGRAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 12:00:02 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:35237 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729692AbfKGRAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 12:00:01 -0500
Received: by mail-il1-f195.google.com with SMTP id z12so2466280ilp.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 09:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=54zJYTA6CYjgn0y4dsSw2cHqSfHEeR/LXlBnsZVQsbs=;
        b=OlemqC/3HDaxtIPWv5ZDga3wwveV1kqTbSf3cjh11xFe9FcbnciERfEJDJkmVBX5QJ
         t52vt2RR2Txhhyp+cezqP9bUPsPrV/hB/UbNdAieyHG8pv3S7ZpIjIjsEtHQpgxYH4tj
         pcAVfslVR1ueqL6MNLAeqaAjOMZ8K5eXcltGgZ4akvpnAttQorNGCyPShFfrSbwBfB2x
         H/eImmsolpDLaBOCWyy5h73OgUVKwTre9CYt9WblFu++Xa9WSbD7ySVJvtCknwjyJLce
         UEvsnMnzo3u8clIAgKpCZ+kEEq8DIixwR4pYv5AV62RSDPR6Y9o17CKKL3dNKCeE2u5b
         L5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=54zJYTA6CYjgn0y4dsSw2cHqSfHEeR/LXlBnsZVQsbs=;
        b=n7Uujgz2W71RdYo4ONhprU6L0pypvJn4yvG7nQAPL+h+Y8t61+0eulX5PuUED5Ud/9
         oNBgs766nk9JT3nBzqCjWkgTyG9yfZ0eRC9bSWxXANIOTIKLI8jM4ES5f00RTdUpganu
         T4SNp1magA9pNBOSE+4xJ/RZ24W4xivtgnBYDvL3pRb5xQBbQzEXDr3EDzlQKl+g0Mdt
         9SvysNEmFdx9rhUnJOvWrM43/SEnzirC3S5j+6vJnpCrLTv0vIBIKBKT4kkAZlk5UEz2
         WXlfEZ0Imi33BNA3pY0/2dw9yhMJUn1xN+XXrtHVcn2ga3J2AWZxxa4iFE/cRf305ZgG
         xNtQ==
X-Gm-Message-State: APjAAAUQfgYxDhxrFEUvHYMywZu+Ckn3CKOLbPSse2Ec9s2kSXdxZgIb
        yT5dB3KtrRdkxLVXomdQ+QHpXHyonYQ9ARASujD3tg==
X-Google-Smtp-Source: APXvYqxuI8BuTcbtVZzvXYLJmGhWiYTnRq8s080yO9vxrvuYwO18ULHq92Sn+m65YiTdVY/Al2/8tGf+c+Dg1DGbCCs=
X-Received: by 2002:a92:109c:: with SMTP id 28mr5758698ilq.142.1573146000389;
 Thu, 07 Nov 2019 09:00:00 -0800 (PST)
MIME-Version: 1.0
References: <20191106174804.74723-1-edumazet@google.com> <157307905904.29376.8711513726869840596.tip-bot2@tip-bot2>
 <CANn89iKXi3rWWruKoBwQ8rncwLvkbzjZJWuJL3K05fjAhcySwg@mail.gmail.com>
 <CANn89iL=xPxejRPC=wHY7q27fLOvFBK-7HtqU_HJo+go3S9UXA@mail.gmail.com>
 <20191107085255.GK20975@paulmck-ThinkPad-P72> <CANn89i+8Hq5j234zFRY05QxZU1n=Vr6S-kZCcvn3Z80xYaindg@mail.gmail.com>
 <20191107161149.GQ20975@paulmck-ThinkPad-P72> <CANn89iLMD0=tiQ181qQ=qKo=Nom-XX4MqonZw6pKiYUzTDVjQg@mail.gmail.com>
 <CANn89iLqcqKLRgfn7TDnBr9ZatiJVyezXmmZaeN2f2BT=qFe7Q@mail.gmail.com> <20191107165428.GR20975@paulmck-ThinkPad-P72>
In-Reply-To: <20191107165428.GR20975@paulmck-ThinkPad-P72>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 7 Nov 2019 08:59:49 -0800
Message-ID: <CANn89i+Cc1aOHVFnYvZ93EDee81RaGNrv47ZBVdQXmxMuuMmww@mail.gmail.com>
Subject: Re: [tip: timers/core] hrtimer: Annotate lockless access to timer->state
To:     paulmck@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        syzbot <syzkaller@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 8:54 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Thu, Nov 07, 2019 at 08:39:42AM -0800, Eric Dumazet wrote:
> > On Thu, Nov 7, 2019 at 8:35 AM Eric Dumazet <edumazet@google.com> wrote:
> > >
> > > On Thu, Nov 7, 2019 at 8:11 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > OK, so this is due to timer_pending() lockless access to ->entry.pprev
> > > > to determine whether or not the timer is on the list.  New one on me!
> > > >
> > > > Given that use case, I don't have an objection to your patch to list.h.
> > > >
> > > > Except...
> > > >
> > > > Would it make sense to add a READ_ONCE() to hlist_unhashed()
> > > > and to then make timer_pending() invoke hlist_unhashed()?  That
> > > > would better confine the needed uses of READ_ONCE().
> > >
> > > Sounds good to me, I had the same idea but was too lazy to look at the
> > > history of timer_pending()
> > > to check if the pprev pointer check was really the same underlying idea.
> >
> > Note that forcing READ_ONCE() in hlist_unhashed() might force the compiler
> > to read the pprev pointer twice in some cases.
> >
> > This was one of the reason for me to add skb_queue_empty_lockless()
> > variant in include/linux/skbuff.h
>
> Ouch!
>
> > /**
> >  * skb_queue_empty_lockless - check if a queue is empty
> >  * @list: queue head
> >  *
> >  * Returns true if the queue is empty, false otherwise.
> >  * This variant can be used in lockless contexts.
> >  */
> > static inline bool skb_queue_empty_lockless(const struct sk_buff_head *list)
> > {
> > return READ_ONCE(list->next) == (const struct sk_buff *) list;
> > }
> >
> > So maybe add a hlist_unhashed_lockless() to clearly document why
> > callers are using the lockless variant ?
>
> That sounds like a reasonable approach to me.  There aren't all that
> many uses of hlist_unhashed(), so a name change should not be a problem.

Maybe I was not clear :  I did not rename skb_queue_empty()
I chose to add another helper.

Contexts that can safely use skb_queue_empty() still continue to use
it, since it might help
the compiler to generate better code.

So If I add hlist_unhashed_lockless(), I would only use it from
timer_pending() at first.

Then an audit of the code might reveal other potential users.
