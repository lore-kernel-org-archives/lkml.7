Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A7FC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 15:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBED621655
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 15:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r0Dol0fN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfKKPKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 10:10:43 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:40872 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfKKPKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 10:10:43 -0500
Received: by mail-ot1-f41.google.com with SMTP id m15so11491124otq.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 07:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xsIkU5AmEnCRR/m9/Ezz/TD78mENH8AOJv+fGm06V9k=;
        b=r0Dol0fNBX188QjijIugIj+zHru+pu+ZPQoBxGzORUFLPlRws6E77FELb+bWgQWFnx
         KMUAYZ+3K1QosUTYHRpPvYoL4Enuji1LYTkVEanVyNsf5mIt2oZDK9gr+McmdPcbNVKv
         BrjOc9DobSnSfDkby84HCIEAUCddyUdDB6RB3gaQHpgKIy11R7v39cUm4DJpVVDQjdUD
         4fA1qkyCaRa6i3uYOvJSn4KMOrka2l1zqmMjxY3HDCnP4Zba5cb78zf8xZrOaDqlgfXB
         JErg6HgFtUiWOsLT7rJhGUE2iCCPoPsnluOHYoQLlYcnbzw8SuvCr64falivbQ3tpiL7
         li+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xsIkU5AmEnCRR/m9/Ezz/TD78mENH8AOJv+fGm06V9k=;
        b=BCRTEcY254ymfrWMzT0Cu7hJBM8g9edPnK3cFqtAHbevhQoN2t+g36veYMnI6TePFV
         1VEKycMBVoWr3PFkENtqm0S3I7AG4g56LByiLT3XMZE+vgWdDnCWGYZepaHGxmIecs8F
         blK8JKwNaM3sO/AHBVuupwZ3qGQNfnsqHryX5owYTaIxZK5kvjpsjDQ/QGIogt+4JUtQ
         WFaaypIk9vk+d/KkpcjLyH325FwVbO0ddBYQleR1m43hAoM4MLbTfSAlID14wOMA+HYx
         ggCcpQHeGfimN5qcPaQeJq9iPui3HVsi238djJ907ASI4xHILXix5syJ5BC4y22DiU1Q
         f53A==
X-Gm-Message-State: APjAAAVfCU3YE3mJYxWieYcUo+7vIDuV3Q7918vt15cQvUtk7hoBW7d3
        sr9P+uHLDt5FMBCfZtjBAdtfXbOyhA8k32wB7oaynQ==
X-Google-Smtp-Source: APXvYqzF3Jls/Sfi8+mcEo5IgldbxsaSDpQIa/fa77bRFjXZbuEERH78Yu/YrR9TZJ4aPxbhJoMggUNHeGWl3dF5NEQ=
X-Received: by 2002:a05:6830:2308:: with SMTP id u8mr20443057ote.2.1573485041064;
 Mon, 11 Nov 2019 07:10:41 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjB61GNmqpX0BLA5tpL4tsjWV7akaTc2Roth7uGgax+mw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911101034180.29192-100000@netrider.rowland.org>
 <CAHk-=wjErHCwkcgO-=NReU0KR4TFozrFktbhh2rzJ=mPgRO0-g@mail.gmail.com>
 <CAHk-=wghq7rmtskFj7EbngpXUTJfc4H9sDcx10E6kMHoH2EsKA@mail.gmail.com>
 <20191110204442.GA2865@paulmck-ThinkPad-P72> <CANpmjNOepvb6+zJmDePxj21n2rctM4Sp4rJ66x_J-L1UmNK54A@mail.gmail.com>
 <20191111143130.GO2865@paulmck-ThinkPad-P72>
In-Reply-To: <20191111143130.GO2865@paulmck-ThinkPad-P72>
From:   Marco Elver <elver@google.com>
Date:   Mon, 11 Nov 2019 16:10:20 +0100
Message-ID: <CANpmjNP4qj7XcYcdrEEb+0_qeg-ii77qy0=-b9k07VRyNjqixA@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Parri <parri.andrea@gmail.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Nov 2019 at 15:31, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Mon, Nov 11, 2019 at 03:17:51PM +0100, Marco Elver wrote:
> > On Sun, 10 Nov 2019 at 21:44, Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Sun, Nov 10, 2019 at 11:20:53AM -0800, Linus Torvalds wrote:
> > > > On Sun, Nov 10, 2019 at 11:12 AM Linus Torvalds
> > > > <torvalds@linux-foundation.org> wrote:
> > > > >
> > > > > And this is where WRITE_IDEMPOTENT would make a possible difference.
> > > > > In particular, if we make the optimization to do the "read and only
> > > > > write if changed"
> > > >
> > > > It might be useful for checking too. IOW, something like KCSAN could
> > > > actually check that if a field has an idempotent write to it, all
> > > > writes always have the same value.
> > > >
> > > > Again, there's the issue with lifetime.
> > > >
> > > > Part of that is "initialization is different". Those writes would not
> > > > be marked idempotent, of course, and they'd write another value.
> > > >
> > > > There's also the issue of lifetime at the _end_ of the use, of course.
> > > > There _are_ interesting data races at the end of the lifetime, both
> > > > reads and writes.
> > > >
> > > > In particular, if it's a sticky flag, in order for there to not be any
> > > > races, all the writes have to happen with a refcount held, and the
> > > > final read has to happen after the final refcount is dropped (and the
> > > > refcounts have to have atomicity and ordering, of course). I'm not
> > > > sure how easy something like that is model in KSAN. Maybe it already
> > > > does things like that for all the other refcount stuff we do.
> > > >
> > > > But the lifetime can be problematic for other reasons too - in this
> > > > particular case we have a union for that sticky flag (which is used
> > > > under the refcount), and then when the final refcount is released we
> > > > read that value (thus no data race) but because of the union we will
> > > > now start using that field with *different* data. It becomes that RCU
> > > > list head instead.
> > > >
> > > > That kind of "it used to be a sticky flag, but now the lifetime of the
> > > > flag is over, and it's something entirely different" might be a
> > > > nightmare for something like KCSAN. It sounds complicated to check
> > > > for, but I have no idea what KCSAN really considers complicated or
> > > > not.
> > >
> > > But will "one size fits all" be practical and useful?
> > >
> > > For my code, I would be happy to accept a significant "false positive"
> > > rate to get even a probabilistic warning of other-task accesses to some
> > > of RCU's fields.  Even if the accesses were perfect from a functional
> > > viewpoint, they could be problematic from a performance and scalability
> > > viewpoint.  And for something like RCU, real bugs, even those that are
> > > very improbable, need to be fixed.
> > >
> > > But other code (and thus other developers and maintainers) are going to
> > > have different needs.  For all I know, some might have good reasons to
> > > exclude their code from KCSAN analysis entirely.
> > >
> > > Would it make sense for KCSAN to have per-file/subsystem/whatever flags
> > > specifying the depth of the analysis?
> >
> > Just to answer this: we already have this, and disable certain files
> > already. So it's an option if required. Just need maintainers to add
> > KCSAN_SANITIZE := n, or KCSAN_SANITIZE_file.o := n to Makefiles, and
> > KCSAN will simply ignore those.
> >
> > FWIW we now also have a config option to "ignore repeated writes with
> > the same value". It may be a little overaggressive/imprecise in
> > filtering data races, but anything else like the super precise
> > analysis involving tracking lifetimes and values (and whatever else
> > the rules would require) is simply too complex. So, the current
> > solution will avoid reporting cases like the original report here
> > (__alloc_file), but at the cost of maybe being a little imprecise.
> > It's probably a reasonable trade-off, given that we have too many data
> > races to deal with on syzbot anyway.
>
> Nice!
>
> Is this added repeated-writes analysis something that can be disabled?
> I would prefer that the analysis of RCU complain in this case as a
> probabilistic cache-locality warning.  If it can be disabled, please
> let me know if there is anything that I need to do to make this happen.

It's hidden behind a Kconfig config option, and actually disabled by
default. We can't enable/disable this on a per-file basis.

Right now, we'll just enable it on the public syzbot instance, which
will use the most conservative config.  Of course you can still run
your own fuzzer/stress test of choice with KCSAN and the option
disabled. Is that enough?

Otherwise I could also just say if the symbolized top stack frame
contains "rcu_", don't ignore -- which would be a little hacky and
imprecise though. What do you prefer?

Thanks,
-- Marco
